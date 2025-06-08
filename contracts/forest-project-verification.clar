;; Forest Project Verification Contract
;; This contract validates forest carbon projects

(define-data-var admin principal tx-sender)

;; Project status: 0 = pending, 1 = verified, 2 = rejected
(define-map projects
  { project-id: uint }
  {
    owner: principal,
    location: (string-utf8 100),
    area: uint,
    status: uint,
    verification-date: uint,
    verifier: principal
  }
)

(define-map verifiers
  { verifier: principal }
  { is-active: bool }
)

(define-read-only (get-project (project-id uint))
  (map-get? projects { project-id: project-id })
)

(define-read-only (is-verified-project (project-id uint))
  (let ((project (map-get? projects { project-id: project-id })))
    (if (is-some project)
      (is-eq (get status (unwrap-panic project)) u1)
      false
    )
  )
)

(define-read-only (is-verifier (address principal))
  (default-to false (get is-active (map-get? verifiers { verifier: address })))
)

(define-public (register-project (project-id uint) (location (string-utf8 100)) (area uint))
  (begin
    (asserts! (is-eq tx-sender (var-get admin)) (err u403))
    (asserts! (is-none (map-get? projects { project-id: project-id })) (err u100))
    (map-set projects
      { project-id: project-id }
      {
        owner: tx-sender,
        location: location,
        area: area,
        status: u0,
        verification-date: u0,
        verifier: tx-sender
      }
    )
    (ok true)
  )
)

(define-public (add-verifier (verifier principal))
  (begin
    (asserts! (is-eq tx-sender (var-get admin)) (err u403))
    (map-set verifiers { verifier: verifier } { is-active: true })
    (ok true)
  )
)

(define-public (remove-verifier (verifier principal))
  (begin
    (asserts! (is-eq tx-sender (var-get admin)) (err u403))
    (map-set verifiers { verifier: verifier } { is-active: false })
    (ok true)
  )
)

(define-public (verify-project (project-id uint) (status uint))
  (let ((project (map-get? projects { project-id: project-id })))
    (begin
      (asserts! (is-verifier tx-sender) (err u401))
      (asserts! (is-some project) (err u404))
      (asserts! (< status u3) (err u400))
      (map-set projects
        { project-id: project-id }
        (merge (unwrap-panic project)
          {
            status: status,
            verification-date: block-height,
            verifier: tx-sender
          }
        )
      )
      (ok true)
    )
  )
)

(define-public (transfer-admin (new-admin principal))
  (begin
    (asserts! (is-eq tx-sender (var-get admin)) (err u403))
    (var-set admin new-admin)
    (ok true)
  )
)

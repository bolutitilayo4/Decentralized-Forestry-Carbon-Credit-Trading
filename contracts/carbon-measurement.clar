;; Carbon Measurement Contract
;; Measures forest carbon sequestration

(define-data-var admin principal tx-sender)

(define-map carbon-measurements
  { project-id: uint, measurement-id: uint }
  {
    timestamp: uint,
    carbon-amount: uint,
    methodology: (string-utf8 50),
    measurer: principal,
    verified: bool
  }
)

(define-map project-measurement-count
  { project-id: uint }
  { count: uint }
)

(define-map authorized-measurers
  { measurer: principal }
  { is-active: bool }
)

(define-read-only (get-measurement (project-id uint) (measurement-id uint))
  (map-get? carbon-measurements { project-id: project-id, measurement-id: measurement-id })
)

(define-read-only (get-project-measurement-count (project-id uint))
  (default-to { count: u0 } (map-get? project-measurement-count { project-id: project-id }))
)

(define-read-only (is-authorized-measurer (address principal))
  (default-to false (get is-active (map-get? authorized-measurers { measurer: address })))
)

(define-public (add-measurer (measurer principal))
  (begin
    (asserts! (is-eq tx-sender (var-get admin)) (err u403))
    (map-set authorized-measurers { measurer: measurer } { is-active: true })
    (ok true)
  )
)

(define-public (remove-measurer (measurer principal))
  (begin
    (asserts! (is-eq tx-sender (var-get admin)) (err u403))
    (map-set authorized-measurers { measurer: measurer } { is-active: false })
    (ok true)
  )
)

(define-public (record-measurement (project-id uint) (carbon-amount uint) (methodology (string-utf8 50)))
  (let (
    (count (get count (get-project-measurement-count project-id)))
    (new-measurement-id (+ count u1))
  )
    (begin
      (asserts! (is-authorized-measurer tx-sender) (err u401))
      (map-set carbon-measurements
        { project-id: project-id, measurement-id: new-measurement-id }
        {
          timestamp: block-height,
          carbon-amount: carbon-amount,
          methodology: methodology,
          measurer: tx-sender,
          verified: false
        }
      )
      (map-set project-measurement-count
        { project-id: project-id }
        { count: new-measurement-id }
      )
      (ok new-measurement-id)
    )
  )
)

(define-public (verify-measurement (project-id uint) (measurement-id uint))
  (let ((measurement (map-get? carbon-measurements { project-id: project-id, measurement-id: measurement-id })))
    (begin
      (asserts! (is-eq tx-sender (var-get admin)) (err u403))
      (asserts! (is-some measurement) (err u404))
      (map-set carbon-measurements
        { project-id: project-id, measurement-id: measurement-id }
        (merge (unwrap-panic measurement) { verified: true })
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

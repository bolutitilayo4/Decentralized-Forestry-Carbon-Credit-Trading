# Decentralized Forestry Carbon Credit Trading System

A blockchain-based platform for transparent and verifiable forest carbon credit trading built on the Stacks blockchain using Clarity smart contracts.

## Overview

This system enables forest owners to register their projects, measure carbon sequestration, issue tradable carbon credits, and facilitate transparent trading while ensuring ongoing verification and monitoring.

## System Architecture

The platform consists of five interconnected smart contracts:

### 1. Forest Project Verification Contract (`forest-project-verification.clar`)
- **Purpose**: Register and validate forest projects
- **Key Functions**:
    - `register-project`: Register new forest projects
    - `verify-project`: Verify projects by authorized verifiers
    - `get-project`: Retrieve project information
    - `is-verified`: Check project verification status

### 2. Carbon Measurement Contract (`carbon-measurement.clar`)
- **Purpose**: Record and verify carbon sequestration measurements
- **Key Functions**:
    - `record-measurement`: Record carbon measurements for projects
    - `verify-measurement`: Verify measurements by authorized verifiers
    - `get-measurement`: Retrieve measurement data
    - `get-total-carbon`: Get total verified carbon for a project

### 3. Credit Issuance Contract (`credit-issuance.clar`)
- **Purpose**: Issue fungible carbon credits based on verified measurements
- **Key Functions**:
    - `issue-credits`: Issue new carbon credits
    - `transfer-credits`: Transfer credits between users
    - `get-balance`: Check credit balance
    - `get-total-supply`: Get total credits in circulation

### 4. Trading Platform Contract (`trading-platform.clar`)
- **Purpose**: Facilitate buying and selling of carbon credits
- **Key Functions**:
    - `create-listing`: Create sell orders
    - `buy-credits`: Purchase credits from listings
    - `cancel-listing`: Cancel existing listings
    - `get-listing`: Retrieve listing information

### 5. Verification Monitoring Contract (`verification-monitoring.clar`)
- **Purpose**: Monitor ongoing compliance and verification
- **Key Functions**:
    - `schedule-monitoring`: Schedule regular monitoring
    - `submit-monitoring-report`: Submit monitoring reports
    - `verify-monitoring`: Verify monitoring reports
    - `get-monitoring-status`: Check monitoring compliance

## Features

### 🌲 **Project Registration & Verification**
- Decentralized project registration
- Multi-verifier validation system
- Transparent project status tracking

### 📊 **Carbon Measurement & Verification**
- Standardized carbon measurement recording
- Independent measurement verification
- Historical measurement tracking

### 🪙 **Carbon Credit Issuance**
- Fungible token-based carbon credits
- Automated credit issuance based on verified measurements
- Transparent supply tracking

### 💱 **Decentralized Trading**
- Open marketplace for carbon credit trading
- Flexible pricing mechanisms
- Secure peer-to-peer transactions

### 🔍 **Ongoing Monitoring**
- Scheduled compliance monitoring
- Verification of monitoring reports
- Long-term project sustainability tracking

## Getting Started

### Prerequisites

- [Clarinet](https://github.com/hirosystems/clarinet) - Clarity development environment
- [Node.js](https://nodejs.org/) (v16 or higher)
- [Stacks CLI](https://docs.stacks.co/docs/command-line-interface)

### Installation

1. Clone the repository:
   \`\`\`bash
   git clone https://github.com/yourusername/forestry-carbon-credits.git
   cd forestry-carbon-credits
   \`\`\`

2. Install dependencies:
   \`\`\`bash
   npm install
   \`\`\`

3. Initialize Clarinet project:
   \`\`\`bash
   clarinet integrate
   \`\`\`

### Testing

Run the comprehensive test suite:

\`\`\`bash
npm test
\`\`\`

Run specific test files:
\`\`\`bash
npm test forest-project-verification.test.ts
npm test carbon-measurement.test.ts
npm test credit-issuance.test.ts
npm test trading-platform.test.ts
npm test verification-monitoring.test.ts
\`\`\`

### Deployment

1. Configure your deployment settings in `Clarinet.toml`

2. Deploy to testnet:
   \`\`\`bash
   clarinet deploy --testnet
   \`\`\`

3. Deploy to mainnet:
   \`\`\`bash
   clarinet deploy --mainnet
   \`\`\`

## Usage Examples

### Registering a Forest Project

\`\`\`clarity
(contract-call? .forest-project-verification register-project
u1
"Amazon Rainforest Conservation Project"
u50000)
\`\`\`

### Recording Carbon Measurement

\`\`\`clarity
(contract-call? .carbon-measurement record-measurement
u1
u1000
u1640995200)
\`\`\`

### Issuing Carbon Credits

\`\`\`clarity
(contract-call? .credit-issuance issue-credits
u1
'ST1PQHQKV0RJXZFY1DGX8MNSNYVE3VGZJSRTPGZGM
u1000)
\`\`\`

### Creating a Trading Listing

\`\`\`clarity
(contract-call? .trading-platform create-listing
u1000
u50)
\`\`\`

### Purchasing Carbon Credits

\`\`\`clarity
(contract-call? .trading-platform buy-credits
u1
u500)
\`\`\`

## Contract Interactions

### Error Codes

| Code | Description |
|------|-------------|
| u100 | Unauthorized access |
| u101 | Project not found |
| u102 | Project already exists |
| u103 | Project not verified |
| u104 | Insufficient balance |
| u105 | Invalid measurement |
| u106 | Listing not found |
| u107 | Insufficient payment |
| u108 | Invalid monitoring report |

### Events

The contracts emit various events for off-chain monitoring:
- Project registration and verification
- Carbon measurements and verifications
- Credit issuance and transfers
- Trading activities
- Monitoring reports

## Security Considerations

- **Access Control**: Role-based permissions for verifiers and administrators
- **Data Integrity**: All measurements and verifications are immutable once recorded
- **Economic Security**: Trading mechanisms prevent double-spending and ensure fair pricing
- **Monitoring**: Continuous verification ensures long-term project compliance

## Contributing

We welcome contributions! Please see our [Contributing Guidelines](CONTRIBUTING.md) for details.

### Development Workflow

1. Fork the repository
2. Create a feature branch
3. Write tests for new functionality
4. Ensure all tests pass
5. Submit a pull request

### Code Standards

- Follow Clarity best practices
- Write comprehensive tests
- Document all public functions
- Use clear, descriptive variable names

## Roadmap

- [ ] **Phase 1**: Core contract deployment and testing
- [ ] **Phase 2**: Web interface development
- [ ] **Phase 3**: Integration with IoT sensors for automated measurements
- [ ] **Phase 4**: Cross-chain compatibility
- [ ] **Phase 5**: Mobile application development

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Support

For questions and support:
- Create an issue on GitHub
- Join our Discord community
- Email: support@forestrycarboncredits.com

## Acknowledgments

- Stacks Foundation for blockchain infrastructure
- Forest carbon measurement standards organizations
- Open source contributors and community

---

**Disclaimer**: This system is for educational and development purposes. Ensure compliance with local regulations before deploying in production environments.
\`\`\`

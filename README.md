# POCKET-MASTER

Pocket is a modern e-commerce system based on SpringCloud Alibaba and Vue3, with complete front-end and back-end implementations, supporting both merchant back-end and customer front-end.

## Project Introduction

The Pocket e-commerce system is a comprehensive e-commerce solution that includes core functional modules such as product management, user management, order management, payment system, and recommendation system. The system adopts a micro-services architecture, with the back-end services built on SpringCloud Alibaba, the back-end developed using Vue3 + JavaScript, and the customer front-end developed using UniApp + TypeScript.

## System Architecture

### Backend Technology Stack

- **Core Framework**: Spring Boot 3.0.5, Spring Cloud 2022.0.2
- **Microservices Governance**: Spring Cloud Alibaba 2022.0.0.0-RC2
- **Registry/Configuration Center**: Nacos
- **Service Circuit Breaker**: Sentinel
- **Database**: MySQL, Redis
- **ORM Framework**: MyBatis Plus
- **Distributed Transactions**: Seata
- **Message Queue**: RabbitMQ
- **API Documentation**: Knife4j
- **Others**: JWT, Druid connection pool, etc.

### Frontend Technology Stack

#### Admin Backend (Pocket UI)
- **Core Framework**: Vue 3.3.9
- **UI Framework**: Element Plus 2.4.3
- **State Management**: Pinia 2.1.7
- **Build Tool**: Vite 5.0.4
- **Routing**: Vue Router 4.2.5

#### User Frontend (Pocket Front)
- **Core Framework**: UniApp
- **Supported Platforms**: WeChat Mini Program, H5, App, and other multi-platforms
- **State Management**: Pinia
- **Build Tool**: Vite

## Functional Modules

### Back-end Service Modules

- **Basic Services**
  - `ruoyi-system`: System management service (users, roles, menus, departments, etc.)
  - `ruoyi-file`: File management service

- **E-commerce Business Services**
  - `pocket-product`: Product management service
  - `pocket-user`: User management service
  - `pocket-order`: Order management service
  - `pocket-cart`: Shopping cart service
  - `pocket-payment`: Payment service
  - `pocket-channel`: Channel management service

- **Intelligent Services**
  - `pocket-aiagent`: AI merchant and customer service
  - `pocket-recommendation`: Recommendation system service
  - `pocket-live`: Live-streaming service

- **Common Modules**
  - `ruoyi-gateway`: Gateway service
  - `ruoyi-auth`: Authentication and authorization service
  - `ruoyi-common`: Common dependency package

### System Features

#### Admin-End
- System management (users, roles, menus, departments, positions, etc.)
- Product management
- Order management
- User management
- Data statistics and analysis
- Content management

#### User-End
- Homepage display
- Product browsing and search
- Shopping cart functionality
- Order management
- Personal center
- Payment functionality
- Live streaming functionality

## Project Structure

```
pocket-master
├── pocket-cloud-master-master     // Backend services
│   ├── ruoyi-auth                 // Authentication center
│   ├── ruoyi-gateway              // Gateway module
│   ├── ruoyi-common               // Common module
│   ├── ruoyi-api                  // API module
│   ├── ruoyi-modules              // Business modules
│   └── pocket-recommender         // Recommendation system
├── shopping-system-back-front-js  // Admin frontend
│   └── pocket-ui
└── shopping-system-front-front-uniapp-ts  // User frontend
    └── pocket-front-master
```

## Environment Requirements

### Back-end Environment
- JDK 17+
- MySQL 8.0+
- Redis 5.0+
- Nacos 2.0+
- Sentinel (optional)
- RabbitMQ
- MinIO (optional, for file storage)

### Front-end Environment
#### Admin Backend
- Node.js 16+
- pnpm 8+

#### Frontend
- Node.js 16+
- HBuilderX (recommended) or other IDEs supporting UniApp

## Quick Start

### Back-end Deployment

1. Import database scripts
2. Start Nacos configuration center and registry center
3. Modify configuration files of each module
4. Start services in order:
   - `ruoyi-gateway` (Gateway service)
   - `ruoyi-auth` (Authentication service)
   - Other business modules

### Front-end Deployment

#### Admin Backend
```bash
cd shopping-system-back-front-js/pocket-ui
pnpm install
pnpm run dev
```

#### User Frontend
```bash
cd shopping-system-front-front-uniapp-ts/pocket-front-master
npm install
# Use HBuilderX to run on the corresponding platform
```

## License

This project is open-sourced under the MIT License and can be used for learning and commercial purposes.

## Contribution

Welcome to submit Issues and Pull Requests to help improve the project.
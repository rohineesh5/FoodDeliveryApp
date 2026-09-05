# Foodly Online Food Delivery

A beginner-friendly full-stack foundation using Spring Boot, MySQL, and React.

## Architecture

- `controller`: receives HTTP requests and returns API responses.
- `service`: holds application and business logic; ready for the next modules.
- `repository`: JPA data-access interfaces; ready for entities.
- `entity`: database-mapped domain objects; ready for customers, restaurants, menus, and orders.
- `dto`: safe request and response shapes used by the API.
- `exception`: centralized application exceptions and error handling; reserved for later features.
- `config`: cross-cutting setup such as CORS and, later, Spring Security.

The backend is intentionally layered. Module 2 adds the database schema and JPA entity model; authentication and order business logic remain deferred.

## Module 2 database structure

The database is centered on `users`, `restaurants`, and `food_items`:

```text
users 1---* addresses
users *---* roles      (user_roles)
users 1---1 carts 1---* cart_items *---1 food_items
users 1---* orders 1---* order_items *---1 food_items
restaurants 1---* categories
restaurants 1---* food_items
categories 1---* food_items
orders 1---1 payments
restaurants *---1 users (owner)
```

Foreign keys live on the dependent side of each relationship. The Java entities intentionally do not expose parent collections, which keeps REST serialization from walking recursive graphs. `OrderItem.unitPrice` preserves the price at purchase time, while `FoodItem.price` remains the current menu price.

Entity responsibilities:

- `User` and `Role`: customer/owner/admin identity data and role assignments. Password handling is not implemented here.
- `Restaurant`, `Category`, and `FoodItem`: restaurant-owned menu organization and prices.
- `Address`: saved delivery address owned by a user.
- `Cart` and `CartItem`: one active cart per user and its menu quantities.
- `Order` and `OrderItem`: an order snapshot, status, delivery address, quantities, and purchase-time prices.
- `Payment`: one payment record per order with method, status, and optional transaction reference.
- All entities inherit `createdAt` and `updatedAt`; enum values are stored as readable strings.

The complete schema is in `backend/src/main/resources/db/schema.sql`, with sample records in `backend/src/main/resources/db/sample-data.sql`. Run the schema first, then the sample data, against MySQL. Hibernate remains configured with `ddl-auto=update` for local development.

## Module 3 authentication

`POST /api/auth/register` accepts `fullName`, `email`, and an 8-72 character password. It always assigns `CUSTOMER`; callers cannot self-register as administrators. `POST /api/auth/login` accepts `email` and `password` and returns a signed one-day Bearer JWT. Passwords are stored with BCrypt, never in plaintext.

Authentication flow: the client registers or logs in; Spring AuthenticationManager loads the user by email and compares the BCrypt hash; AuthService signs a JWT containing the subject and authorities; the JWT filter verifies its signature and expiry on each request; Spring Security places the authenticated user in the security context; `/api/admin/**` requires `ROLE_ADMIN`.

Postman examples:

```http
POST http://localhost:8080/api/auth/register
Content-Type: application/json

{"fullName":"Sam Customer","email":"sam@example.com","password":"customer-pass"}
```

```http
POST http://localhost:8080/api/auth/login
Content-Type: application/json

{"email":"admin@example.com","password":"password"}
```

The sample SQL credentials are `ava@example.com` / `password` for a customer and `admin@example.com` / `password` for an administrator. Change these development-only sample credentials before deploying.

## Folder structure

```text
backend/
  pom.xml
  src/main/java/com/fooddelivery/
    FoodDeliveryApplication.java
    config/WebConfig.java
    config/SecurityConfig.java
    controller/HealthController.java
    dto/HealthResponse.java
    entity/                  # JPA entities and enums
    exception/               # next module
    repository/              # next module
    service/                 # next module
  src/main/resources/application.properties
  src/main/resources/db/schema.sql
  src/main/resources/db/sample-data.sql
frontend/
  package.json
  vite.config.js
  index.html
  src/App.jsx
  src/main.jsx
  src/styles.css
```

## Run locally

### 1. Database

Install MySQL and ensure it is running. The configured connection creates the `food_delivery` database automatically. Update `backend/src/main/resources/application.properties` with your local MySQL password.

### 2. Backend

```bash
cd backend
mvn spring-boot:run
```

Test it at `http://localhost:8080/api/health`. Expected response:

```json
{"status":"UP","message":"Food Delivery API is running"}
```

### 3. Frontend

In a second terminal:

```bash
cd frontend
npm install
npm run dev
```

Open the Vite URL, normally `http://localhost:5173`. The homepage shows whether it can reach the Spring Boot API.

## Notes

Spring Security is included as a dependency, but authentication is not implemented in this module. A temporary development user is configured so the application remains protected by Spring Boot's default security behavior while the health endpoint remains available for the frontend connection.

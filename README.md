# Banking Management System (JSP + Servlets + MySQL)

A simple yet functional banking web application built using Java Servlets, JSP, and MySQL.
It allows users to create bank accounts, view balances, deposit, withdraw, and transfer funds.

## Features

- User Authentication (Login & Register)
- Account Creation with Unique Account Number
- View Account Balance & Details
- Deposit & Withdraw Money
- Transfer Money to Another Account
- Session Management
- MySQL Database Integration

## Project Structure

BankingSystem/
│── src/
│   └── com.bank/
│       ├── DBConnection.java
│       ├── RegisterServlet.java
│       ├── LoginServlet.java
│       ├── AccountServlet.java
│       ├── DepositServlet.java
│       ├── WithdrawServlet.java
│       ├── TransferServlet.java
│       └── LogoutServlet.java
│
│── WebContent/ or src/main/webapp/
│   ├── index.jsp
│   ├── login.jsp
│   ├── register.jsp
│   ├── createAccount.jsp
│   ├── viewBalance.jsp
│   ├── deposit.jsp
│   ├── withdraw.jsp
│   └── transfer.jsp
│
│── README.md

## Database Setup

CREATE DATABASE banking_db;
USE banking_db;

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50),
    email VARCHAR(100) UNIQUE,
    password VARCHAR(100)
);

CREATE TABLE accounts (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_email VARCHAR(100),
    account_number VARCHAR(20) UNIQUE,
    name VARCHAR(100),
    balance DOUBLE DEFAULT 0.0
);

CREATE TABLE transactions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_email VARCHAR(100),
    account_number VARCHAR(20),
    transaction_type VARCHAR(50),
    amount DOUBLE,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

## Run Instructions

1. Import the project into Eclipse/IntelliJ as a Dynamic Web/Maven Project.
2. Add MySQL JDBC Connector to the project.
3. Update database credentials inside `DBConnection.java`.
4. Deploy and run the application on Apache Tomcat.
5. Access via: http://localhost:8080/BankingSystem/login.jsp

## Author

**Piyush**  
Computer Science (AIML) Student | Backend & Java Developer

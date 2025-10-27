package com.bank;

import java.sql.Timestamp;

public class Transaction {
    private int id;
    private String userEmail;
    private String accountNumber;       // ✅ New field
    private String transactionType;
    private double amount;
    private Timestamp timestamp;

    // Constructor
    public Transaction(int id, String userEmail, String accountNumber, String transactionType, double amount, Timestamp timestamp) {
        this.id = id;
        this.userEmail = userEmail;
        this.accountNumber = accountNumber; // ✅ assign new field
        this.transactionType = transactionType;
        this.amount = amount;
        this.timestamp = timestamp;
    }

    // Getters
    public int getId() {
        return id;
    }

    public String getUserEmail() {
        return userEmail;
    }

    public String getAccountNumber() {   // ✅ new getter
        return accountNumber;
    }

    public String getTransactionType() {
        return transactionType;
    }

    public double getAmount() {
        return amount;
    }

    public Timestamp getTimestamp() {
        return timestamp;
    }
}

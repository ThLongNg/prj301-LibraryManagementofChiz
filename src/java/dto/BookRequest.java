/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dto;

import java.sql.Date;
import java.io.Serializable;

public class BookRequest implements Serializable { // It's a good practice to implement Serializable

   private int id;
    private int bookId;
    private int userId;
    private Date requestDate;
    private Date borrowDate;
    private Date returnDate;
    private String status; 
    private double fineAmount;
    private String paymentStatus; // Thêm thuộc tính này
    private String transactionId; // Thêm thuộc tính này
    private String bookTitle;
    // Constructors

public BookRequest(int id, int bookId, int userId, Date requestDate, Date borrowDate, Date returnDate, String status, double fineAmount) {
        this.id = id;
        this.bookId = bookId;
        this.userId = userId;
        this.requestDate = requestDate;
        this.borrowDate = borrowDate;
        this.returnDate = returnDate;
        this.status = status;
        this.fineAmount = fineAmount;
    }
    
    // Thêm constructor mới có cả paymentStatus và transactionId (dòng 41 của bạn)
    public BookRequest(int id, int bookId, int userId, Date requestDate, Date borrowDate, Date returnDate, String status, double fineAmount, String paymentStatus, String transactionId) {
        this.id = id;
        this.bookId = bookId;
        this.userId = userId;
        this.requestDate = requestDate;
        this.borrowDate = borrowDate;
        this.returnDate = returnDate;
        this.status = status;
        this.fineAmount = fineAmount;
        this.paymentStatus = paymentStatus;
        this.transactionId = transactionId;
        
    }

    public BookRequest(int id, int bookId, int userId, Date requestDate, Date borrowDate, Date returnDate, String status, double fineAmount, String bookTitle) {
        this.id = id;
        this.bookId = bookId;
        this.userId = userId;
        this.requestDate = requestDate;
        this.borrowDate = borrowDate;
        this.returnDate = returnDate;
        this.status = status;
        this.fineAmount = fineAmount;
        this.bookTitle = bookTitle;
    }

    public String getBookTitle() {
        return bookTitle;
    }

    public void setBookTitle(String bookTitle) {
        this.bookTitle = bookTitle;
    }
    
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getBookId() {
        return bookId;
    }

    public void setBookId(int bookId) {
        this.bookId = bookId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public Date getRequestDate() {
        return requestDate;
    }

    public void setRequestDate(Date requestDate) {
        this.requestDate = requestDate;
    }

    public Date getBorrowDate() {
        return borrowDate;
    }

    public void setBorrowDate(Date borrowDate) {
        this.borrowDate = borrowDate;
    }

    public Date getReturnDate() {
        return returnDate;
    }

    public void setReturnDate(Date returnDate) {
        this.returnDate = returnDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public double getFineAmount() {
        return fineAmount;
    }

    public void setFineAmount(double fineAmount) {
        this.fineAmount = fineAmount;
    }

    public String getPaymentStatus() {
        return paymentStatus;
    }

    public void setPaymentStatus(String paymentStatus) {
        this.paymentStatus = paymentStatus;
    }

    public String getTransactionId() {
        return transactionId;
    }

    public void setTransactionId(String transactionId) {
        this.transactionId = transactionId;
    }

}
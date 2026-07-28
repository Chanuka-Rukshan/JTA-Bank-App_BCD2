package lk.jiat.ee.bank.entity;

import jakarta.persistence.*;

import java.time.LocalDateTime;

@Entity
@Table(name = "transactions")
@NamedQueries({
        @NamedQuery(name = "Transaction.findByAccountNo",
        query = "SELECT t FROM Transaction t WHERE t.accountNo=:accountNo ORDER BY t.timestamp DESC")
})
public class Transaction {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String accountNo;

    private String relatedAccountNo;

    @Enumerated(EnumType.STRING)
    private TransactionType type;

    private Double amount;

    private LocalDateTime timestamp;

    private double balanceAfter;

    public Transaction() {
    }

    public Transaction(String accountNo, TransactionType type, Double amount,double balanceAfter,String relatedAccountNo) {
        this.accountNo = accountNo;
        this.relatedAccountNo = relatedAccountNo;
        this.type = type;
        this.amount = amount;
        this.timestamp = LocalDateTime.now();
        this.balanceAfter = balanceAfter;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public double getBalanceAfter() {
        return balanceAfter;
    }

    public void setBalanceAfter(double balanceAfter) {
        this.balanceAfter = balanceAfter;
    }

    public String getAccountNo() {
        return accountNo;
    }

    public void setAccountNo(String accountNo) {
        this.accountNo = accountNo;
    }

    public String getRelatedAccountNo() {
        return relatedAccountNo;
    }

    public void setRelatedAccountNo(String relatedAccountNo) {
        this.relatedAccountNo = relatedAccountNo;
    }

    public TransactionType getType() {
        return type;
    }

    public void setType(TransactionType type) {
        this.type = type;
    }

    public Double getAmount() {
        return amount;
    }

    public void setAmount(Double amount) {
        this.amount = amount;
    }

    public LocalDateTime getTimestamp() {
        return timestamp;
    }

    public void setTimestamp(LocalDateTime timestamp) {
        this.timestamp = timestamp;
    }
}

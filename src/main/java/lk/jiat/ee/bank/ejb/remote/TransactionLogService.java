package lk.jiat.ee.bank.ejb.remote;

import jakarta.ejb.Local;
import lk.jiat.ee.bank.entity.Transaction;
import lk.jiat.ee.bank.entity.TransactionType;

import java.util.List;

@Local
public interface TransactionLogService {
    void log(String accountNo, TransactionType transactionType,double amount, double balanceAfter,String relatedAccountNo);
    List<Transaction> history(String accountNo);
}

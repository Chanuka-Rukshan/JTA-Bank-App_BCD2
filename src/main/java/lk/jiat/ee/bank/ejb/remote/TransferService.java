package lk.jiat.ee.bank.ejb.remote;

import jakarta.ejb.Local;
import lk.jiat.ee.bank.exception.AccountNotFoundException;
import lk.jiat.ee.bank.exception.InsufficientFundsException;

@Local
public interface TransferService {
    void transferAmount(String sourceAccountNo, String destinationAccountNo, double amount)
            throws InsufficientFundsException, AccountNotFoundException;
}

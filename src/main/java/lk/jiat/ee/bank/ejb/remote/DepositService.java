package lk.jiat.ee.bank.ejb.remote;

import jakarta.ejb.Local;
import lk.jiat.ee.bank.exception.AccountNotFoundException;

@Local
public interface DepositService {
    void deposit(String accountNo, double amount) throws AccountNotFoundException;
}

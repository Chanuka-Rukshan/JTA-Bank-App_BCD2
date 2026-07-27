package lk.jiat.ee.bank.exception;

import jakarta.ejb.ApplicationException;

@ApplicationException(rollback = true)
public class AccountNotFoundException extends  Exception {
    public AccountNotFoundException(String accountNo) {
        super("No account found with account number " + accountNo);
    }
}

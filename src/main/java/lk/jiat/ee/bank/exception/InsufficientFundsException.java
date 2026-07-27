package lk.jiat.ee.bank.exception;

import jakarta.ejb.ApplicationException;

import java.math.BigDecimal;

@ApplicationException(rollback=true)
public class InsufficientFundsException extends Exception {
    public InsufficientFundsException(String accountNo, BigDecimal requested, BigDecimal available) {
        super("Insufficient Funds in Account " + accountNo + ": " + requested + " but only " + available);
    }
}

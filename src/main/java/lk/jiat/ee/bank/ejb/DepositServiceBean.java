package lk.jiat.ee.bank.ejb;

import jakarta.ejb.EJB;
import jakarta.ejb.Stateless;
import jakarta.ejb.TransactionAttribute;
import jakarta.ejb.TransactionAttributeType;
import lk.jiat.ee.bank.ejb.remote.AccountService;
import lk.jiat.ee.bank.ejb.remote.DepositService;
import lk.jiat.ee.bank.ejb.remote.TransactionLogService;
import lk.jiat.ee.bank.entity.Account;
import lk.jiat.ee.bank.entity.TransactionType;
import lk.jiat.ee.bank.exception.AccountNotFoundException;

import java.math.BigDecimal;

@Stateless
@TransactionAttribute(TransactionAttributeType.REQUIRED)
public class DepositServiceBean implements DepositService {

    @EJB
    private AccountService accountService;

    @EJB
    private TransactionLogService transactionLogService;

    @Override
    public void deposit(String accountNo, double amount) throws AccountNotFoundException {
        accountService.creditToAccount(accountNo, BigDecimal.valueOf(amount));

        Account account = accountService.findByAccountNo(accountNo);
        transactionLogService.log(accountNo, TransactionType.DEPOSIT, amount, account.getBalance(), null);
    }
}

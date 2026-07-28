package lk.jiat.ee.bank.ejb;

import jakarta.ejb.EJB;
import jakarta.ejb.Stateless;
import jakarta.ejb.TransactionAttribute;
import jakarta.ejb.TransactionAttributeType;
import lk.jiat.ee.bank.ejb.remote.AccountService;
import lk.jiat.ee.bank.ejb.remote.TransactionLogService;
import lk.jiat.ee.bank.ejb.remote.WithdrawService;
import lk.jiat.ee.bank.entity.Account;
import lk.jiat.ee.bank.entity.TransactionType;
import lk.jiat.ee.bank.exception.AccountNotFoundException;
import lk.jiat.ee.bank.exception.InsufficientFundsException;

import java.math.BigDecimal;

@Stateless
@TransactionAttribute(TransactionAttributeType.REQUIRED)
public class WithdrawServiceBean implements WithdrawService {

    @EJB
    private AccountService accountService;

    @EJB
    private TransactionLogService transactionLogService;

    @Override
    public void withdraw(String accountNo, double amount) throws InsufficientFundsException, AccountNotFoundException {
        accountService.debitToAccount(accountNo, BigDecimal.valueOf(amount));
        Account account = accountService.findByAccountNo(accountNo);
        transactionLogService.log(accountNo, TransactionType.WITHDRAW, amount, account.getBalance(), null);
    }
}

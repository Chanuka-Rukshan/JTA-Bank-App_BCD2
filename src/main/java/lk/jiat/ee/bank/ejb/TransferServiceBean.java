package lk.jiat.ee.bank.ejb;

import jakarta.annotation.Resource;
import jakarta.ejb.*;
import jakarta.transaction.*;
import lk.jiat.ee.bank.ejb.remote.AccountService;
import lk.jiat.ee.bank.ejb.remote.TransactionLogService;
import lk.jiat.ee.bank.ejb.remote.TransferService;
import lk.jiat.ee.bank.entity.Account;
import lk.jiat.ee.bank.entity.TransactionType;
import lk.jiat.ee.bank.exception.AccountNotFoundException;
import lk.jiat.ee.bank.exception.InsufficientFundsException;

import java.math.BigDecimal;

@Stateless
@TransactionManagement(TransactionManagementType.BEAN)
public class TransferServiceBean implements TransferService {

    @Resource
    private UserTransaction userTransaction;

    @EJB
    private AccountService accountService;

    @EJB
    private TransactionLogService transactionLogService;

    @Override
    public void transferAmount(String sourceAccountNo, String destinationAccountNo, double amount) throws InsufficientFundsException, AccountNotFoundException {
        if (amount <= 0) {
            throw new IllegalArgumentException("Amount must be greater than 0");
        }

        if (sourceAccountNo.equals(destinationAccountNo)) {
            throw new AccountNotFoundException("Source and destination accounts must differ");
        }

        accountService.findByAccountNo(sourceAccountNo);
        accountService.findByAccountNo(destinationAccountNo);

        try {
            userTransaction.begin();
            try {
                accountService.debitToAccount(sourceAccountNo, BigDecimal.valueOf(amount));
                accountService.creditToAccount(destinationAccountNo, BigDecimal.valueOf(amount));
                userTransaction.commit();
            } catch (InsufficientFundsException | RuntimeException e) {
                safeRollback();
                throw e;
            }
        } catch (NotSupportedException | SystemException e) {
            throw new RuntimeException("Unable to start transaction for after transfer", e);
        } catch (RollbackException | HeuristicMixedException | HeuristicRollbackException e) {
            throw new RuntimeException("Transfer commit failed", e);
        }

        Account source = accountService.findByAccountNo(sourceAccountNo);
        Account destination = accountService.findByAccountNo(destinationAccountNo);

        transactionLogService.log(sourceAccountNo, TransactionType.DEPOSIT, amount, source.getBalance(), destinationAccountNo);

        transactionLogService.log(destinationAccountNo, TransactionType.CREDITED, amount, destination.getBalance(), sourceAccountNo);

    }

    private void safeRollback() {
        try {
            userTransaction.rollback();
        } catch (SystemException e) {
            throw new RuntimeException("Rollback failed after transfer error", e);
        }
    }
}


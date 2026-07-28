package lk.jiat.ee.bank.ejb;

import jakarta.annotation.Resource;
import jakarta.ejb.*;
import jakarta.transaction.UserTransaction;
import lk.jiat.ee.bank.ejb.remote.AccountService;
import lk.jiat.ee.bank.ejb.remote.TransactionLogService;
import lk.jiat.ee.bank.ejb.remote.TransferService;
import lk.jiat.ee.bank.exception.AccountNotFoundException;
import lk.jiat.ee.bank.exception.InsufficientFundsException;

@Stateless
@TransactionManagement(TransactionManagementType.BEAN)
public class TransferServiceBean implements TransferService {

    @Resource
    private UserTransaction userTransaction;

    @EJB
    private AccountService accountService;

    @EJB
    private TransactionLogService  transactionLogService;

    @Override
    public void transferAmount(String sourceAccountNo, String destinationAccountNo, double amount) throws InsufficientFundsException, AccountNotFoundException {

    }
}

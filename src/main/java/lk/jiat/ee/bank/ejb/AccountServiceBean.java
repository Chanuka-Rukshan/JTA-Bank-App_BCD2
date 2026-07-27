package lk.jiat.ee.bank.ejb;

import jakarta.ejb.Stateless;
import jakarta.ejb.TransactionAttribute;
import jakarta.ejb.TransactionAttributeType;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import lk.jiat.ee.bank.ejb.remote.AccountService;
import lk.jiat.ee.bank.entity.Account;
import lk.jiat.ee.bank.entity.AccountType;
import lk.jiat.ee.bank.exception.AccountNotFoundException;
import lk.jiat.ee.bank.exception.InsufficientFundsException;

import java.math.BigDecimal;
import java.util.List;
import java.util.concurrent.ThreadLocalRandom;

@Stateless
public class AccountServiceBean implements AccountService {

    @PersistenceContext(unitName = "BankPU")
    private EntityManager em;

    @Override
    public void creditToAccount(String accountNo, BigDecimal amount) {

    }

    @Override
    public void debitToAccount(String accountNo, BigDecimal amount) throws InsufficientFundsException {

    }

    @Override
    public Account findByAccountNo(String accountNo) throws AccountNotFoundException {
        return null;
    }

    @Override
    public List<Account> findAccountsByUserEmail(String email) throws AccountNotFoundException {
        return List.of();
    }

    @Override
    @TransactionAttribute(TransactionAttributeType.REQUIRED)
    public void createAccount(String email, AccountType type, BigDecimal openingBalance) {

    }

    @Override
    @TransactionAttribute(TransactionAttributeType.NOT_SUPPORTED)
    public String generateAccountNumber(AccountType type) {
        int branchCode = ThreadLocalRandom.current().nextInt(1, 999);
        int typeCode = (type == AccountType.CURRENT) ? 2 : 1;
        long serial = System.currentTimeMillis() % 100_000_000L;
        return String.format("%03d%d%d08d", branchCode, typeCode, serial);
    }
}

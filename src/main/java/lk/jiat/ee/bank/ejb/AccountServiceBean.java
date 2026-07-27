package lk.jiat.ee.bank.ejb;

import jakarta.ejb.*;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import lk.jiat.ee.bank.ejb.remote.AccountService;
import lk.jiat.ee.bank.ejb.remote.LoginService;
import lk.jiat.ee.bank.entity.Account;
import lk.jiat.ee.bank.entity.AccountType;
import lk.jiat.ee.bank.entity.User;
import lk.jiat.ee.bank.exception.AccountNotFoundException;
import lk.jiat.ee.bank.exception.InsufficientFundsException;

import java.math.BigDecimal;
import java.util.List;
import java.util.concurrent.ThreadLocalRandom;

@Stateless
public class AccountServiceBean implements AccountService {

    @PersistenceContext(unitName = "BankPU")
    private EntityManager em;

    @EJB
    private LoginService loginService;

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
    public Account createAccount(String email, AccountType type, BigDecimal openingBalance) {
        User user = loginService.findByEmail(email);
        if (user == null){
            throw new EJBException("Cannot open account, no such user: " + email);
        }
        Account account = new Account();
        account.setAccountType(type);
        account.setAccNo(generateAccountNumber(AccountType.SAVINGS));
        account.setBalance(openingBalance.doubleValue());
        account.setUser(user);
        em.persist(account);

        return account;

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

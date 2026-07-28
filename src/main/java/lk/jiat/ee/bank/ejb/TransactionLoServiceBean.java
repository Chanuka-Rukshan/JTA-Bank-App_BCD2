package lk.jiat.ee.bank.ejb;

import jakarta.ejb.Stateless;
import jakarta.ejb.TransactionAttribute;
import jakarta.ejb.TransactionAttributeType;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import lk.jiat.ee.bank.ejb.remote.TransactionLogService;
import lk.jiat.ee.bank.entity.Transaction;
import lk.jiat.ee.bank.entity.TransactionType;

import java.util.List;

@Stateless
public class TransactionLoServiceBean implements TransactionLogService {

    @PersistenceContext(unitName = "BankPU")
    private EntityManager em;

    @Override
    @TransactionAttribute(TransactionAttributeType.REQUIRED)
    public void log(String accountNo, TransactionType transactionType, double amount, double balanceAfter, String relatedAccountNo) {
        Transaction transaction = new Transaction(accountNo, transactionType, amount, balanceAfter, relatedAccountNo);
        em.persist(transaction);
    }

    @Override
    @TransactionAttribute(TransactionAttributeType.REQUIRED)
    public List<Transaction> history(String accountNo) {
        return em.createNamedQuery("Transaction.findByAccountNo",Transaction.class)
                .setParameter("accountNo",accountNo )
                .getResultList();
    }
}

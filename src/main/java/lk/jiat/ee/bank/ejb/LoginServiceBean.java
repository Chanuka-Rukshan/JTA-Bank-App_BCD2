package lk.jiat.ee.bank.ejb;

import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.NoResultException;
import jakarta.persistence.PersistenceContext;
import lk.jiat.ee.bank.ejb.remote.LoginService;
import lk.jiat.ee.bank.entity.User;

@Stateless
public class LoginServiceBean implements LoginService {

    @PersistenceContext(unitName = "BankPU")
    private EntityManager em;

    @Override
    public boolean login(String email, String password) {
        try{
            em.createNamedQuery("User.findByEmailAndPassword", User.class)
                    .setParameter("email", email)
                    .setParameter("password", password)
                    .getResultList();
            return true;
        }catch (NoResultException e){
            return false;
        }
    }

    @Override
    public User findByEmail(String email) {
        try{
            return em.createNamedQuery("User.findByEmail", User.class)
                    .setParameter("email",email)
                    .getSingleResult();
        }catch (NoResultException e){
            return null;
        }
    }
}

package lk.jiat.ee.bank.ejb;

import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import lk.jiat.ee.bank.ejb.remote.RegisterService;
import lk.jiat.ee.bank.entity.User;

import java.rmi.RemoteException;

@Stateless
public class RegisterServiceBean implements RegisterService {

    @PersistenceContext(unitName = "BankPU")
    private EntityManager em;

    @Override
    public void registerUser(String name, String email, String password) throws RemoteException {

        long existing = em.createNamedQuery("User.findByEmail", User.class)
                .setParameter("email", email)
                .getResultList()
                .size();

        if (existing > 0){
            throw new RemoteException("User already exists");
        }

        User user = new User();
        user.setName(name);
        user.setEmail(email);
        user.setPassword(password);

        em.persist(user);
        em.flush();

    }
}

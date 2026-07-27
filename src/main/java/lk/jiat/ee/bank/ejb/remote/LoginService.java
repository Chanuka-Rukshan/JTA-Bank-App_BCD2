package lk.jiat.ee.bank.ejb.remote;

import jakarta.ejb.Local;
import lk.jiat.ee.bank.entity.User;

@Local
public interface LoginService {
    boolean login(String email, String password);
    User findByEmail(String email);
}

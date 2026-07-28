package lk.jiat.ee.bank.servlet;

import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lk.jiat.ee.bank.ejb.remote.AccountService;
import lk.jiat.ee.bank.entity.User; // අනිවාර්යයෙන්ම User class එක Import කරගන්න ඕනේ

import java.io.IOException;

@WebServlet("/dashboard")
public class Dashboard extends HttpServlet {

    @EJB
    private AccountService accountService;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        // 1. Session එකෙන් User Object එක ගන්නවා
        User loggedInUser = (User) req.getSession().getAttribute("user");

        // 2. User ගෙන් Email එක ගන්නවා (ඔයාගේ getter එකේ නම අනුව මේක වෙනස් වෙන්න පුළුවන්)
        String email = loggedInUser.getEmail();

        req.setAttribute("accounts", accountService.findAccountsByUserEmail(email));

        req.getRequestDispatcher("home.jsp").forward(req, resp);

    }
}
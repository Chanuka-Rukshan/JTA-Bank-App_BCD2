package lk.jiat.ee.bank.servlet;

import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lk.jiat.ee.bank.ejb.remote.LoginService;
import lk.jiat.ee.bank.entity.User;

import java.io.IOException;

@WebServlet("/login")
public class Login extends HttpServlet {

    @EJB
    private LoginService loginService;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");
        String password = req.getParameter("password");

        if (loginService.login(email, password)) {
            User user = loginService.findByEmail(email);
            HttpSession session = req.getSession();
            session.setAttribute("user", user);
            session.setAttribute("username", user.getName());
            session.setAttribute("email", user.getEmail());

            resp.sendRedirect(req.getContextPath() + "/dashboard");
        } else {
            req.setAttribute("error", "Invalid email or password");
            req.getRequestDispatcher("/login.jsp").forward(req, resp);
        }

    }
}

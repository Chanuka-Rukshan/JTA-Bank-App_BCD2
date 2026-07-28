package lk.jiat.ee.bank.servlet;

import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lk.jiat.ee.bank.ejb.remote.AccountService;
import lk.jiat.ee.bank.ejb.remote.WithdrawService;
import lk.jiat.ee.bank.entity.Account;
import lk.jiat.ee.bank.entity.User;
import lk.jiat.ee.bank.exception.AccountNotFoundException;
import lk.jiat.ee.bank.exception.InsufficientFundsException;

import java.util.List;
import java.io.IOException;

@WebServlet("/withdraw")
public class withdraw extends HttpServlet {

    @EJB
    private AccountService accountService;

    @EJB
    private WithdrawService withdrawService;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User user = (User) req.getSession().getAttribute("user");
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        String email = user.getEmail();
        List<Account> accounts = accountService.findAccountsByUserEmail(email);
        req.setAttribute("accounts", accounts);
        req.getRequestDispatcher("withdraw.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String accountNo = req.getParameter("accountNo");
        String amountStr = req.getParameter("amount");

        try {
            if (accountNo == null || accountNo.isEmpty() || amountStr == null || amountStr.isEmpty()) {
                throw new IllegalArgumentException("Account number and amount are required.");
            }

            double amount = Double.parseDouble(amountStr);
            withdrawService.withdraw(accountNo, amount);
            resp.sendRedirect(req.getContextPath() + "/dashboard");
        } catch (Exception e) {
            User user = (User) req.getSession().getAttribute("user");
            if (user != null) {
                List<Account> accounts = accountService.findAccountsByUserEmail(user.getEmail());
                req.setAttribute("accounts", accounts);
            }
            req.setAttribute("error", e.getMessage() != null ? e.getMessage() : "Withdrawal failed.");
            req.getRequestDispatcher("withdraw.jsp").forward(req, resp);
        }
    }
}

package lk.jiat.ee.bank.servlet;

import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lk.jiat.ee.bank.ejb.remote.AccountService;
import lk.jiat.ee.bank.ejb.remote.TransferService;
import lk.jiat.ee.bank.entity.Account;
import lk.jiat.ee.bank.entity.User;
import lk.jiat.ee.bank.exception.AccountNotFoundException;
import lk.jiat.ee.bank.exception.InsufficientFundsException;

import java.io.IOException;
import java.util.List;

@WebServlet("/transfer")
public class Transfer extends HttpServlet {

    @EJB
    private AccountService accountService;

    @EJB
    TransferService transferService;

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
        req.getRequestDispatcher("transfer.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User user = (User) req.getSession().getAttribute("user");
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        String sourceAccountNo = req.getParameter("sourceAccountNo");
        String destinationAccountNo = req.getParameter("destinationAccountNo");
        String amountStr = req.getParameter("amount");

        try {
            if (sourceAccountNo == null || sourceAccountNo.trim().isEmpty() ||
                    destinationAccountNo == null || destinationAccountNo.trim().isEmpty() ||
                    amountStr == null || amountStr.trim().isEmpty()) {
                throw new IllegalArgumentException("All fields are required.");
            }

            double amount = Double.parseDouble(amountStr);
            transferService.transferAmount(sourceAccountNo, destinationAccountNo, amount);
            resp.sendRedirect(req.getContextPath() + "/dashboard");
        } catch (Exception e) {
            List<Account> accounts = accountService.findAccountsByUserEmail(user.getEmail());
            req.setAttribute("accounts", accounts);
            req.setAttribute("error", e.getMessage() != null ? e.getMessage() : "Transfer failed.");
            req.getRequestDispatcher("transfer.jsp").forward(req, resp);
        }
    }
}

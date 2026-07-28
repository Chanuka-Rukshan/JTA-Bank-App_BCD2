package lk.jiat.ee.bank.servlet;

import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lk.jiat.ee.bank.ejb.remote.TransactionLogService;
import lk.jiat.ee.bank.entity.Transaction;

import java.io.IOException;
import java.util.List;

@WebServlet("/history")
public class History extends HttpServlet {

    @EJB
    private TransactionLogService transactionLogService;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String accountNo = req.getParameter("accNo");
        if (accountNo == null || accountNo.trim().isEmpty()) {
            accountNo = req.getParameter("accountNo");
        }

        if (accountNo != null && !accountNo.trim().isEmpty()) {
            accountNo = accountNo.trim();
            List<Transaction> transactions = transactionLogService.history(accountNo);
            req.setAttribute("accountNo", accountNo);
            req.setAttribute("transactions", transactions);
        }

        req.getRequestDispatcher("history.jsp").forward(req, resp);
    }
}

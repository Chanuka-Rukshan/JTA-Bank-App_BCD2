package lk.jiat.ee.bank.servlet;

import jakarta.ejb.EJB;
import jakarta.ejb.EJBException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lk.jiat.ee.bank.ejb.remote.RegisterService;
import lk.jiat.ee.bank.exception.DuplicateEmailException;

import java.io.IOException;
import java.rmi.RemoteException;

@WebServlet("/register")
public class Register extends HttpServlet {

    private static final double DEFAULT_OPENING_BALANCE = 1000.00;

    @EJB
    private RegisterService registerService;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String name = req.getParameter("name");
        String email = req.getParameter("email");
        String password = req.getParameter("password");

        try{
            registerService.registerUser(name,email,password,DEFAULT_OPENING_BALANCE);
            req.setAttribute("message","Register Successfully");

            req.getRequestDispatcher("login.jsp").forward(req,resp);

        }catch (DuplicateEmailException e){

            req.setAttribute("error",e.getMessage());
            req.getRequestDispatcher("register.jsp").forward(req,resp);

        }

    }
}

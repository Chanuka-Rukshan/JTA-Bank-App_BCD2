<%@ page import="lk.jiat.ee.bank.entity.Account" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: K.A.Chanuka Rukshan
  Date: 7/26/2026
  Time: 1:23 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>JTA Bank | Dashboard</title>
</head>
<body>

<nav>
    <a href="dashboard">Dashboard</a>
    <a href="deposit">Deposit</a>
    <a href="withdraw">withdraw</a>
    <a href="transfer">Transfer</a>
    <a href="create-account">New Account</a>
    <a href="logout">Logout</a>
</nav>

<div>
    <h1>Welcome ${sessionScope.userName}</h1>

    <h2>Your Accounts:</h2>

    <% List<Account> accounts = (List<Account>) request.getAttribute("accounts");

        if (accounts == null || accounts.isEmpty()) { %>

    <p>You don't have any Account's yet. <a href="create-account">Create New Account</a></p>

    <%
    } else {

        for (Account account : accounts) { %>

    <div>
        <strong><%= account.getAccNo() %>
        </strong>
        <br>
        <div>
            <%= account.getAccountType() %>
        </div>
        <div>
            LKR <%= account.getBalance() %>
        </div>
        <div>
            <a href="history?accNo=<%= account.getAccNo() %>">View Transaction History</a>
        </div>
    </div>

    <%
            }

        }
    %>


</div>

</body>
</html>

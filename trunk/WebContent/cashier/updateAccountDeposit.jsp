<%@ page import="enums.AccessRightsEnum"%>
<%@ page import="bean.AccessRights"%>
<%
	Integer accountTypeId = (Integer) session
			.getAttribute("accountTypeId");
	AccessRights accessRights = new AccessRights();
	if (accountTypeId == null) {
		response.sendRedirect("../errorpage.jsp");
	} else {
		switch (accessRights.getAccessRights(accountTypeId)) {
		case DIRECTOR:
		case CASHIER:
%>
<%@ page import="java.sql.*;"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	response.setCharacterEncoding("UTF-8");
	response.setContentType("text/html;charset=UTF-8");
%>
<jsp:useBean id="account" scope="page" class="sql.AccountsRepositoryImpl" />

<jsp:useBean id="accountTransaction" scope="page" class="sql.AccountTransactionsImpl" />

<%!String TotalAccountAmount1 = "", CardNumber = "", Action = "";
	int CustomerId, AccountId;
	float Balance = 0, InitialAccountAmount = 0, TotalAccountAmount = 0, RemainingAccountAmount = 0 ;
%>

<%
			CustomerId = (Integer) session.getAttribute("CustomerId");
			Action = "Κατάθεση";
			AccountId = (Integer) session.getAttribute("AccountId");			
			Balance = (Float) session.getAttribute("Balance");
			
			InitialAccountAmount = Balance;			
			System.out.println(TotalAccountAmount);
			TotalAccountAmount1 = request.getParameter("TotalAccountAmount");								
			TotalAccountAmount = Float.parseFloat(TotalAccountAmount1);	
			RemainingAccountAmount = InitialAccountAmount + TotalAccountAmount;						
			Balance = RemainingAccountAmount;				
			account.updateAccount(Balance, AccountId);
			accountTransaction.accountTransaction(AccountId, CustomerId, Action, InitialAccountAmount, TotalAccountAmount, RemainingAccountAmount);
			
			out.println("correct");

			break;
		case NOACCESS:
			response.sendRedirect("errorpage.jsp");
			break;
		}
	}
%>
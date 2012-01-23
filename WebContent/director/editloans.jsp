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
%>
<%@ page language="java" import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
<head>
<link rel="stylesheet" type="text/css" href="style.css" />
<link rel="stylesheet" type="text/css" href="../css/fancybox.css" />
<link rel="SHORTCUT ICON" href="images/favicon.ico" type="image/x-icon" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="../js/jquery.overlabel.min.js" type="text/javascript"></script>
<script type="text/javascript">
	$(document).ready(function() {
		var overlayColor = $('#fancybox-overlay')

		$(document).ready(function() {
			$("label.overlabel").overlabel();
		});
	});
</script>
</head>

<jsp:useBean id="loan" scope="page" class="sql.LoansRepositoryImpl" />
<%!String loanId1 = "", type = "", status = "";
	int loanId = 0, customerId = 0;
	float amount = 0;%>

<%
	loanId1 = request.getParameter("loanId");
			loanId = Integer.parseInt(loanId1);
			ResultSet rs = loan.editLoan(loanId);
			if (rs.next()) {
				loanId = rs.getInt("loan_id");
				customerId = rs.getInt("customer_id");
				amount = rs.getFloat("loan_amount");
				type = rs.getString("type");
				status = rs.getString("status");
				session.setAttribute("loanId", loanId);
				session.setAttribute("customerId", customerId);
			}
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@page import="enums.LoanOptions"%>

<form name="editform" method="post" action="updateloans.jsp">
	<table width="300px">
		<tr>
			<td colspan=2 style="font-weight: bold;" align="center"><h2 style="margin-bottom: -3px;">Επεξεργασία
				Δανείου</h2>		<div class="hr" style="margin-bottom: -3px;"></div></td>
		</tr>

		<tr>
			<td colspan=2 align="center" height="10px"></td>
		</tr>
		<tr>
			<td>Id Πελάτη:</td>
			<td><input type="text" name="customerId" value="<%=customerId%>" readonly></td>
		</tr>
		<tr>
			<td>Ποσό:</td>
			<td><input type="text" name="amount" value="<%=amount%>"></td>
		</tr>
		<tr>
			<td>Tύπος:</td>
			<td><select name="type">
					<option selected value="<%=type%>"><%=type%></option>
					<c:forEach var="type" items="<%= LoanOptions.values() %>">
						<option value="${type}">${type}</option>
					</c:forEach>
			</select></td>

		</tr>
		<tr>
			<td>Κατάσταση:</td>
			<td><select name="status">
					<option selected value="<%=status%>"></option>
					<option value="Εκκρεμεί">Εκκρεμεί</option>
					<option value="Εγκριθηκε">'Εγκριση</option>
					<option value="Απορριφθηκε">Απόρριψη</option>
			</select></td>
			

		</tr>
	</table>
		<div class="hr" style="margin-bottom: -3px;"></div>
	<p class="right noMargin">
		<button type="submit" class="btn" value="Submit">
			<span>Save..</span>
		</button>
		<br>
</form>
</body>
</html>
<%
	break;
		case CASHIER:
		case NOACCESS:
			response.sendRedirect("errorpage.jsp");
			break;
		}
	}
%>
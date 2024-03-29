<%@page import="enums.LoanStatus"%>
<%@page import="enums.LoanOptions"%>
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
<div id="reload">
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
					session.setAttribute("type", type);
					session.setAttribute("status", status);
				}
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	pageContext.setAttribute("loanOptions",enums.LoanOptions.values());
	pageContext.setAttribute("loanStatus",enums.LoanStatus.values());
%>
<form name="editform" method="post" id="editLoans" action="">
	<table width="300px">
		<tr>
			<td colspan=2 style="font-weight: bold;" align="center"><h2
					style="margin-bottom: -3px;">Επεξεργασία Δανείου</h2>
				<div class="hr" style="margin-bottom: -3px;"></div></td>
		</tr>
		<tr>
			<td colspan=2 align="center" height="10px"></td>
		</tr>
		<tr>
			<td>Id Πελάτη:</td>
			<td><input type="text" name="customerId" value="<%=customerId%>" disabled="disabled" style="background: #E8E8E8;"> </td>
		</tr>
		<tr>
			<td>Ποσό:</td>
			<td><input type="text" name="amount" id="amount" value="<%=amount%>"></td>
		</tr>
		<tr>
			<td>Tύπος:</td>
			<td><select name='type' id="type">
					<c:forEach items="${loanOptions}" var="loanOptions">
						<option value="${loanOptions.type}" ${loanOptions.type==type? 'selected' : ''}>${loanOptions.type}</option>
					</c:forEach>
			</select></td>
		</tr>
		<tr>
			<td>Κατάσταση:</td>
			<td><select name=status id="status">
					<c:forEach items="${loanStatus}" var="loanStatus">
						<option value="${loanStatus.status}" ${loanStatus.status==status? 'selected' : ''}>${loanStatus.status}</option>
					</c:forEach>
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
</div>
<script>
$(document).ready(function(){
	$("form#editLoans").submit(function() {
	var amount = $('#amount').attr('value');
	var type = $('#type').attr('value');	
	var status = $('#status').attr('value');	
		$.ajax({
			type: "POST",
			url: "updateloans.jsp",
			data: {"amount": amount, "type": type, "status": status},	
			success: function(result){
				var result = $.trim(result);
				$('#reload').load('editloans.jsp', {'loanId' : <%=loanId%>,});									
				setTimeout(function(){			
				if (result=='correct'){								
					$('#correct').fadeIn(500).show();
					setTimeout(function() {
						$('#correct').fadeOut(1600, "linear");
					}, 3000);
				} else { }			
			;},150);
				}
		});
	return false;
	});
});
;
</script>
<div id="correct" style="display: none; color: red; ">
	<strong>Τo δάνειο:(<%=loanId%>)
		ανανεώθηκε!
	</strong>
</div>
</body>
</html>

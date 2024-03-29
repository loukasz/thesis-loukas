<%@ page import="java.text.DecimalFormat" %>
<%@ page import="sql.LoanTransactionsRepository"%>
<%@ page language="java" import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="loanTransactions" scope="page" class="sql.LoanTransactionsRepositoryImpl" />
<%
	String desc, firstname, lastname;
	int loanTransactionId ;
	float loanAmount, loanBalance, totalPayedAmount, remainingPayeeAmount;
	Timestamp loanTransactionTime; 
	

DecimalFormat df = new DecimalFormat( "#,##0.00" );

%>
<script type="text/javascript" language="javascript"> 
function showHide() {
    var table = document.getElementById("table");
    if(table.style.display == "block") {
    	table.style.display = "none";
      }
    else {
    	table.style.display = "block";
    }
}
</script> 
<html>
<head>
<script src="../js/sorttable.js"></script>
<meta http-equiv="content-type" content="text/html;charset=utf-8" />
<link rel="stylesheet" href="style.css" type="text/css" />
<link rel="SHORTCUT ICON" href="images/favicon.ico" type="image/x-icon" />   
</head>
<body>
	<%@ include file="top.jsp"%>
	<div class="pageTop"></div>
	<div class="pageMain">
		<div class="contentArea">
			<!-- Main Menu Links -->
		<%@ include file="menu.jsp"%>
			<h1>Συνολική εικόνα συναλλαγων δανείων</h1>
			<table id="table-2"> 
				<thead>
					<tr>
						<td ALIGN="center">Αναζήτηση</td>
						<td ALIGN="center">Όλες οι συναλλαγές</td>
					</tr>
				</thead>
				<tr>
					<td>
						<form action="searchLoanTransaction.jsp" method="post" style="padding: 0; margin: 0">
							<select name="searchCombo">
								<option value="searchId">Αρ. Συναλ.</option>
								<option value="searchFirst">Όνομα</option>
								<option value="searchLast">Επώνυμο</option>
								<option value="searchDesc">Περιγραφή</option>
								<option value="searchLoanAmount">Ποσό Δανείου</option>
								<option value="searchLoanBalance">Παλαίο Υπόλοιπο</option>
								<option value="searchTotalPayedAmount">Πληρωτέο Ποσό</option>
								<option value="searchRemainingPayeeAmount">Νέο Υπόλοιπο</option>						
							</select> 
							
							<input type="text" name="search" id="search">

							<button type="submit" class="btn" value="Submit">
								<span>Aναζήτηση..</span>
							</button>
						</form>
					</td>
					<td>&nbsp;
						<button type="button" class="btn" value="Show-Hide"
							onclick="return showHide();">
							<span>Όλες οι συναλλαγές</span>
						</button>
					</td>
				</tr>
			</table>
			<br>			
			<div>			
				<div id="table" style="overflow: auto; max-height:500px; display: none;">
					<% ResultSet rs = loanTransactions.getLoanTransaction(); 
						if (rs.next()) { %> 
					<table id="table-2" class="sortable">					
						<thead>
							<tr>
								<th>Αρ. Συναλ.</th>
								<th>Όνομα</th>
								<th>Επώνυμο</th>
								<th>Περιγραφή</th>
								<th>Ποσό Δανείου</th>
								<th>Παλαίο Υπόλοιπο</th>
								<th>Πληρωτέο Ποσό</th>
								<th>Νέο Υπόλοιπο</th>
								<th>Ώρα Συναλ.</th>								
							</tr>
						</thead>
						<tbody>
							<%							
							rs.beforeFirst();
								while (rs.next()) {
									loanTransactionId = rs.getInt("loan_transaction_id");
									firstname = rs.getString("Firstname");
									lastname = rs.getString("lastname");
									desc = rs.getString("description");
									loanAmount = rs.getFloat("loan_amount");
									loanBalance = rs.getFloat("loan_balance");
									totalPayedAmount = rs.getFloat("total_Payed_Amount");
									remainingPayeeAmount = rs.getFloat("remaining_payee_amount");
									loanTransactionTime = rs.getTimestamp("loan_Transaction_Time");
							%>
							<tr> 
								<td align='center' ><%=loanTransactionId%></td>
								<td align='center' ><%=firstname%></td>
								<td align='center' ><%=lastname%></td>
								<td align='center' ><%=desc%></td>
 								<td align='center' ><%=df.format(loanAmount)%></td>
 								<td align='center' ><%=df.format(loanBalance)%></td>
								<td align='center' ><%=df.format(totalPayedAmount)%></td>
								<td align='center' ><%=df.format(remainingPayeeAmount)%></td>
							    <td align='center' ><%=loanTransactionTime%></td>							    			
							</tr>							
					<% } %>
						</tbody>
						</table>
						<% } else { %>
					<div class="center" id="error" style="font-size: 17pt; overflow: auto; font-style:italic; color:red;">Δεν υπάρχουν συναλλαγές στην ενότητα των δανείων.</div>
					<% } %>
				</div>
				<div class="clear"></div>
			</div>
		</div>
		<div class="clear"></div>
	</div>
	<%@ include file="../footer.jsp"%>
</body>
</html>

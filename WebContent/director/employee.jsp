<%@ page import="enums.AccessRightsEnum"%>
<%@ page import="bean.AccessRights"%>

<%	
	Integer accountTypeId = (Integer) session.getAttribute("accountTypeId");
	AccessRights accessRights = new AccessRights();
	if (accountTypeId == null) {
		response.sendRedirect("../errorpage.jsp");
	} else {
	switch (accessRights.getAccessRights(accountTypeId)) {
	case DIRECTOR:
%>
<%@ page import="sql.LoansRepository"%>
<%@ page import="bean.Loans"%> 
<%@ page import="sql.LoansRepositoryImpl"%>
<%@ page language="java" import="java.sql.*"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<jsp:useBean id="employee" scope="page" class="sql.EmployeeRepositoryImpl" />

<%
	 String firstname = "", lastname = "", type= "", empAddress = "", empCity = "", empPostalCode = "", empTelephone = "", branchAddress= "", branchCity="", branchPostalCode= "", branchTelephone= "";
	 int employeeId = 0, empAddressId = 0, branchAddressId;
	 double salary = 0;
	 Timestamp dataHired;
%>
 
<html>
<head>
<script src="../js/sorttable.js"></script>
<meta http-equiv="content-type" content="text/html;charset=utf-8" />
<link rel="stylesheet" href="style.css" type="text/css" />
<link rel="SHORTCUT ICON" href="../images/favicon.ico" type="image/x-icon" />
<script src="../js/jquery.min.js" type="text/javascript" ></script>
<link rel="stylesheet" type="text/css" href="../css/fancybox.css" />       
    
<script type="text/javascript">
$(document).ready(function() {
    var overlayColor=$('#fancy_overlay')
$("a.editform").fancybox({
	'padding':3,
	'overlayOpacity':0.2,
	'overlayColor':overlayColor,
	'frameWidth':400,
	'frameHeight':208,
	'hideOnContentClick':false,
	'callbackOnShow':modalStart,
	'onClosed': function() {
		   parent.location.reload(true);
		  } 
});
                 
function modalStart(){
    Cufon.replace('.fancy_title > div')};                                                          
});

$(document).ready(function() {
    $("label.overlabel").overlabel();
});      
</script>   
</head>
<body>
	<%@ include file="top.jsp"%>
	<div class="pageTop"></div>
	<div class="pageMain">
		<div class="contentArea">
			<!-- Main Menu Links -->
			<div id="director">
				<ul class="navmain">
					<li class="list"><a href="director.jsp">Γενικός Διευθυντής</a>
						<ul class="navsub">
							<li><a href="sumloans.jsp">Συνολική εικόνα δανείων</a></li>
							<li><a href="customers.jsp">Κατάσταση Πελατών</a></li>
							<li><a href="employee.jsp">Κατάσταση εργαζομένων</a></li>
							<li><a href="message.jsp">Mηνύματα</a></li>
						</ul></li>
				</ul>
			</div>
			<h1>Kατάσταση Υπαλλήλων της τράπεζας</h1>
				<div style="overflow: auto; height: 500px;">
					<table id="table-2" class="sortable">
						<thead>
							<tr>
								<th>A/A</th>
								<th>Όνομα</th>
								<th>Επώνυμο</th>
								<th>Μισθος</th>
								<th>Ημ. Προσλ.</th>
								<th>Τυπος</th>
								<th>Διευθ. Εργαζ.</th>
								<th>Πόλη Εργαζ.</th>
								<th>Τ.Κ Εργαζ.</th>
								<th>Τηλ. Εργαζ.</th>
								<th>Διευθ. Κατα.</th>
								<th>Πόλη Κατα.</th>
								<th>Τ.Κ Κατα.</th>
								<th>Τηλέφωνο Κατα.</th>
								<th colspan="2" class="sorttable_nosort">Επιλογές</th>	
							</tr>
						</thead>
						<tbody>
							<%
								ResultSet rs = employee.getResult();
								while (rs.next()) {								
									employeeId = rs.getInt("employee_id");
									firstname = rs.getString("firstname");
									lastname = rs.getString("lastname");
									salary = rs.getDouble("salary");
									dataHired = rs.getTimestamp("date_hired");
									type = rs.getString("type");
									empAddress = rs.getString("a.address");
									empCity = rs.getString("a.city");
									empPostalCode = rs.getString("a.postal_code");
									empTelephone = rs.getString("a.telephone");
									branchAddress = rs.getString("a2.address");
									branchCity = rs.getString("a2.city");
									branchPostalCode = rs.getString("a2.postal_code");
									branchTelephone = rs.getString("a2.telephone");									
							%>
							<tr>
								<td><%=employeeId%></td>
								<td><%=firstname%></td>
								<td><%=lastname%></td>
								<td><%=salary%></td>
								<td><%=dataHired%></td>
								<td><%=type%></td>
								<td><%=empAddress%></td>
								<td><%=empCity%></td>
								<td><%=empPostalCode%></td>
								<td><%=empTelephone%></td>
								<td><%=branchAddress%></td>
								<td><%=branchCity%></td>
								<td><%=branchPostalCode%></td>
								<td><%=branchTelephone%></td>
								<td><a href="editemployees.jsp?employeeId=<%=rs.getInt("employee_Id")%>" class="editform" >Aλλαγή</a></td>
       						</tr>
							<%
								}
							%>			
						</tbody> 
					</table>
				</div>
				<div class="clear"></div>
		</div>
		<div class="clear"></div>
	</div>
	<%@ include file="../footer.jsp"%>
</body>
</html>
<%
	break;
	case CASHIER:
	case NOACCESS:
	case CUSTOMER:
		response.sendRedirect("../errorpage.jsp");
	break;
	}}
%>

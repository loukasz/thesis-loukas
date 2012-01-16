<%@ page import="enums.AccessRightsEnum"%>
<%@ page import="bean.AccessRights"%>

<%	
	Integer accountTypeId = (Integer) session.getAttribute("accountTypeId");
	AccessRights accessRights = new AccessRights();
	switch (accessRights.getAccessRights(accountTypeId)) {
	case DIRECTOR:
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<html>
<head>
<meta http-equiv="content-type" content="text/html;charset=utf-8" />
<link rel="stylesheet" href="style.css" type="text/css" />
<link rel="SHORTCUT ICON" href="images/favicon.ico" type="image/x-icon" />
</head>
<%@ include file="top.jsp"%>
<div class="pageTop"></div>
<div class="pageMain">
	<div class="contentArea">
		<div class="pattern_box_icon">
			<img src="director.png" alt="" title="" />
		</div>





		<h1>
			Γενικός Διευθυντής<span> <%=session.getAttribute("firstname")%>
				<%=session.getAttribute("lastname")%></span>
		</h1>

		<p>
		<h1>Παρακαλώ επιλέξτε μια απο τις παρακάτω λειτουργίες.</h1>
		<a href="sumloans.jsp">Συνολική εικόνα δανείων</a><br> <br>
		<a href="deposits.jsp">Συνολική εικόνα καταθέσεων</a><br> <br>
		<a href="egkrisi.jsp">Δάνεια προς έγκριση</a>


	</div>
	<div class="clear"></div>


</div>



<%@ include file="../footer.jsp"%>

<%
	break;
	case CASHIER:
	case NOACCESS:
%>
<html>
<h1>Η πρόσβαση σε αυτή την Ιστοσελίδα απαγορεύεται!</h1>
<br>
<br> Επιστροφή στην αρχική
<a href="http://localhost:8080/">σελίδα</a>.
</html>
<%
	break;
	}
%>
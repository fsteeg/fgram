<%
//Part of "Functional Grammar Language Generator" (http://fgram.sourceforge.net/) (C) 2006 Fabian Steeg
//This library is free software; you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation; either version 2.1 of the License, or (at your option) any later version.
//This library is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.
//You should have received a copy of the GNU Lesser General Public License along with this library; if not, write to the Free Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
 %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>FGRAM JSP</title>
<jsp:useBean id="formHandler"
	class="de.uni_koeln.spinfo.fg.ui.web.FgramBean">
	<jsp:setProperty name="formHandler" property="*" />
	<%
	            String i = request.getParameter("userInput");
	            if (i != null)
	                formHandler.setUserInput(i);
	            formHandler.doit();
	%>
</jsp:useBean>
</head>
<body onload="document.form1.userInput.focus();">
<table width="100%">
	<tr>
		<td align="left"><font size="1">Sample: <jsp:getProperty
			name="formHandler" property="preselectedUCS" /></font></td>
		<td align="right"><font size="1"><a
			href="http://fgram.sourceforge.net"> fgram home </a></font></td>
	</tr>
</table>
<hr size="1" />
<table width="100%">
	<tr>
		<td align="left" width="70%">
		<form name="form1" action="/de.uni_koeln.spinfo.fg.ui.web/fgram.jsp"
			method="post"><input name="userInput" size="120"
			property="preselectedUCS" /></form>
		<h3><i><jsp:getProperty name="formHandler" property="answer" /></i>
		<br />
		<font size="1"> <jsp:getProperty name="formHandler"
			property="userInput" /> </font></h3>
		<!-- conversation input --></td>
	</tr>
</table>
<hr size="1" />
</body>
</html>


<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@page import="java.util.*,java.sql.*"%>
<%@include file="config.jsp"%>
<html>
<body>
<%
if (request.getParameter("id")!=null && !request.getParameter("id").equals("")
	&& request.getParameter("passwords") !=null && !request.getParameter("passwords").equals("")){
		sql="SELECT * FROM `members` WHERE `id`='"+ request.getParameter("id")+
			"' AND `passwords`='"+request.getParameter("passwords")+"'";
			
		ResultSet rs=con.createStatement().executeQuery(sql);
		
		if (rs.next()){
			session.setAttribute("id",request.getParameter("id"));
			con.close();
			response.sendRedirect("user.jsp");
			
		}else{
			con.close();
			out.print("密碼帳號不符!!<a href='login.html'>按此</a>重新登入");
		}
		
	}
	else{
		response.sendRedirect("login.html");
	}
%>
</body>
</html>
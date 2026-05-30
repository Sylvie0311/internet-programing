<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@page import="java.util.*,java.sql.*"%>
<%@include file="config.jsp"%>
<html>
<head>
	<link rel="stylesheet" href="../css/sign.css">
</head>
<body>
<%
if (session.getAttribute("id")!=null){
	sql="SELECT * FROM `members` WHERE `id` ='"+session.getAttribute("id")+"';";
	ResultSet rs=con.createStatement().executeQuery(sql);
	String id="",passwords="";
	while (rs.next()){
		id=rs.getString("id");
		passwords=rs.getString("passwords");
	}
	con.close();
%>
 <main class="container">
	<section class="card">
		<h2><%=id%>您好~<br></h2>
		請修改您的會員資料<br>
		<form action="update.jsp" method="post" class="form">
		<div class="form-row">
			您的帳號:<input type="text" name="id" value="<%=id%>">
		</div>
		<div class="form-row">
			您的密碼:<input type="text" name="passwords" value="<%=passwords%>">
		</div>
		<div class="form-actions">
			<input type="submit" name="b1" value="更新" class="s primary">
		</div>
		</form>
	</section>
</main>
<%
}
else{
	con.close();
%>
<main class="container">
	<section class="card">
		<h1><font color="red">您尚未登入!!</font></h1>
		<form action="check.jsp" method="post" class="form">
		<div class="form-row">
			帳號:<input type="text" name="id"><br>
		</div>
		<div class="form-row">
			密碼:<input type="password" name="passwords"><br>
		</div>
		<div class="form-actions">
			<input type="submit" name="b1" value="登入" class="s primary">
		</div>
		</form>
	</section>
</main>
<%
}
%>
</body>
</html>
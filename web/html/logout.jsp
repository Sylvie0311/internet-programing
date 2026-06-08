<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%
    session.removeAttribute("id");
    session.removeAttribute("role");
    session.invalidate();
    
    response.sendRedirect("login.jsp");
%>
<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@page import="java.util.*,java.sql.*"%>
<%@include file="config.jsp"%>
<html>
<body>
<%
Connection con = (Connection)request.getAttribute("con"); 

if (request.getParameter("id")!=null && !request.getParameter("id").equals("")
    && request.getParameter("passwords") !=null && !request.getParameter("passwords").equals("")){

    String sql = "SELECT * FROM members WHERE id=? AND passwords=?";
    PreparedStatement pstmt = con.prepareStatement(sql);
    pstmt.setString(1, request.getParameter("id"));
    pstmt.setString(2, request.getParameter("passwords"));

    ResultSet rs = pstmt.executeQuery();

    if (rs.next()){
        session.setAttribute("id", rs.getString("id"));
        session.setAttribute("role", rs.getString("role")); 

        String consent = null;
        if (request.getCookies() != null) {
            for (Cookie c : request.getCookies()) {
                if ("cookie_consent".equals(c.getName())) {
                    consent = c.getValue();
                }
            }
        }

        if ("accepted".equals(consent)) {
            Cookie loginCookie = new Cookie("login_user", rs.getString("id"));
            loginCookie.setMaxAge(60*60*24); // 一天
            loginCookie.setHttpOnly(true);
            loginCookie.setSecure(true);
            response.addCookie(loginCookie);

            Cookie roleCookie = new Cookie("user_role", rs.getString("role"));
            roleCookie.setMaxAge(60*60*24);
            roleCookie.setHttpOnly(true);
            roleCookie.setSecure(true);
            response.addCookie(roleCookie);
        }

        con.close();
        response.sendRedirect("user.jsp");
    } else {
        con.close();
        out.print("密碼帳號不符!!<a href='login.jsp'>按此</a>重新登入");
    }

} else {
    response.sendRedirect("login.jsp");
}
%>
</body>
</html>

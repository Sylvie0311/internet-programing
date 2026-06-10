<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%
    session.removeAttribute("id");
    session.removeAttribute("role");
    session.invalidate();

    if (request.getCookies() != null) {
        for (Cookie c : request.getCookies()) {
            if ("login_user".equals(c.getName()) || "user_role".equals(c.getName())) {
                c.setValue("");         // 清空值
                c.setMaxAge(0);         
                c.setPath("/");         
                response.addCookie(c);  // 寫回瀏覽器
            }
        }
    }

    response.sendRedirect("login.jsp");
%>

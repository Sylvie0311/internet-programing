<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %> 

<!DOCTYPE html>
<html>
<head>
    <title>搜尋結果</title>
</head>
<body>

<%
    // 取得前端關鍵字
    request.setCharacterEncoding("UTF-8");
    String keyword = request.getParameter("keyword");

    if (keyword != null && !keyword.trim().isEmpty()) {

        String dbUser = "root"; 
		String dbPassword = "1234";
		String url = "jdbc:mysql://localhost:3306/medical_system_my_db?serverTimezone=UTC&characterEncoding=UTF-8&allowPublicKeyRetrieval=true&useSSL=false";
        
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(url, dbUser, dbPassword);
            
            //對應 Product_Name 欄位進行模糊查詢
            String sql = "SELECT * FROM Product WHERE Product_Name LIKE ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, "%" + keyword + "%"); 
            
            rs = pstmt.executeQuery();
            
            //前端網頁表格
            out.print("<table border='1' cellpadding='10' style='border-collapse: collapse; text-align: left;'>");
            out.print("<tr style='background-color: #f2f2f2;'><th>器材編號</th><th>器材名稱</th><th>許可證字號</th><th>規格</th><th>單價</th></tr>");
            
            boolean hasResult = false;
            while(rs.next()) {
                hasResult = true;
                out.print("<tr>");
                out.print("<td>" + rs.getString("Product_ID") + "</td>");
                out.print("<td>" + rs.getString("Product_Name") + "</td>");
                out.print("<td>" + rs.getString("License_No") + "</td>");
                out.print("<td>" + rs.getString("Specification") + "</td>");
                out.print("<td>$" + rs.getInt("Unit_Price") + "元</td>");
                out.print("</tr>");
            }
            out.print("</table>");
            
            if(!hasResult) {
                out.print("<p>找不到與『" + keyword + "』相關的醫療器材。</p>");
            }
            
        } catch (Exception e) {
            out.print("<p style='color:red;'>錯誤資訊: " + e.getMessage() + "</p>");
        } finally {
            if (rs != null) try { rs.close(); } catch (Exception e) {}
            if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}
            if (conn != null) try { conn.close(); } catch (Exception e) {}
        }
        
    } else {
        out.print("<p>請輸入要搜尋的物品！</p>");
    }
%>

<%@ page import = "java.sql.*, java.util.*"%>
<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<html>
<head>
<title>列出所有留言</title>

<style>
    body {
        font-family: 'Noto Sans TC', -apple-system, BlinkMacSystemFont, sans-serif;
        color: #333333;
        background-color: #FFFFFF;
        padding: 10px;
        line-height: 1.7;
    }
    
    body, p, a {
        font-size: 14px;
    }
    
    a {
        color: #00A49E;
        text-decoration: none;
        padding: 4px 8px;
        font-weight: 500;
    }
    a:hover {
        color: #008782;
        text-decoration: underline;
    }
    
    .modern-review-row {
        background: #FFFFFF;
        border: 1px solid #E8EBEB;
        border-left: 4px solid #00A49E; 
        padding: 20px;
        margin-bottom: 20px;
        border-radius: 0 8px 8px 0; 
        box-shadow: 0 2px 6px rgba(0,0,0,0.02); 
    }
    
    
    .review-tag {
        color: #666666; 
        font-size: 14px;
        display: inline-block;
    }
    
    
    .review-email {
        color: #999999;
        font-size: 13px;
        margin-left: 5px;
    }
    
    
    .modern-review-row br {
        display: block;
        margin-bottom: 6px;
        content: " ";
    }
    
    
    .review-text-content {
        background-color: #F7F9F9; 
        padding: 14px;
        border-radius: 6px;
        margin: 12px 0;
        color: #444444;
        font-size: 15px;
        border: 1px solid #EEF2F2;
    }
    
    
    .review-time {
        font-size: 12px;
        color: #A0AAB0;
        display: block;
        text-align: right;
    }
    </style>
</head>

<body>
<%
Connection con = null;
PreparedStatement pstmtCount = null;
PreparedStatement pstmtList = null;
ResultSet rsCount = null;
ResultSet rsList = null;

try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    String url="jdbc:mysql://localhost:3306/board?serverTimezone=UTC&characterEncoding=UTF-8&allowPublicKeyRetrieval=true&useSSL=false";
    String user="root";
    String password="1234"; // 請確認密碼正確
    con=DriverManager.getConnection(url, user, password);

    if(con != null && !con.isClosed()) {
        // 計算總筆數
        String sqlCount = "SELECT COUNT(*) FROM guestbook";
        pstmtCount = con.prepareStatement(sqlCount);
        rsCount = pstmtCount.executeQuery();
        int total_content = 0;
        if(rsCount.next()) {
            total_content = rsCount.getInt(1);
        }
        int page_num = (int)Math.ceil((double)total_content/5.0);

        // 取得目前頁碼 
        String page_string = request.getParameter("page");
        if (page_string == null || page_string.equals("0")) {
            page_string = "1";
        }
        int current_page = Integer.parseInt(page_string);

        out.println("共 " + total_content + " 筆留言<p>");
        out.println("請選擇頁數：");

        // 顯示分頁的連結
        out.println("<a href='view.jsp?page=1'>第一頁</a> ");
        if(current_page > 1) 
            out.println("<a href='view.jsp?page=" + (current_page-1) + "'>上一頁</a> ");

        for(int i=1; i<=page_num; i++) {
            if (i == current_page)
                out.print("[" + i + "]&nbsp;");
            else
                out.print("<a href='view.jsp?page=" + i + "'>" + i + "</a>&nbsp;");
        }

        if(current_page < page_num)
            out.println("<a href='view.jsp?page=" + (current_page+1) + "'>下一頁</a> ");
        out.println("<a href='view.jsp?page=" + page_num + "'>最後頁</a><p><hr>");

        // 抓取當前頁面訊息
        int start_record = (current_page - 1) * 5;
        String sqlList = "SELECT * FROM guestbook ORDER BY GBNO DESC LIMIT ?, ?";
        pstmtList = con.prepareStatement(sqlList);
        pstmtList.setInt(1, start_record);
        pstmtList.setInt(2, 5);
        rsList = pstmtList.executeQuery();

        while(rsList.next()) {
            String content = rsList.getString("Content");
            if (content != null) {
                content = content.replace("\n", "<br>");
            }

            out.println("<div class='modern-review-row'>");
            out.println("<span class='review-tag'>留言主題：</span><strong>" + rsList.getString("Subject") + "</strong><br>");
            out.println("<span class='review-tag'>訪客姓名：</span>" + rsList.getString("GBName") + 
                        " <span class='review-email'>(" + rsList.getString("Mail") + ")</span><br>");
            out.println("<div class='review-text-content'>" + content + "</div>");
            out.println("<span class='review-time'>留言時間：" + rsList.getString("Putdate") + "</span>");
            out.println("</div>");
        }
    }
} catch (Exception e) {
    out.println("錯誤：" + e.getMessage());
} finally {
    if (rsCount != null) try { rsCount.close(); } catch(SQLException e){}
    if (rsList != null) try { rsList.close(); } catch(SQLException e){}
    if (pstmtCount != null) try { pstmtCount.close(); } catch(SQLException e){}
    if (pstmtList != null) try { pstmtList.close(); } catch(SQLException e){}
    if (con != null) try { con.close(); } catch(SQLException e){}
}
%>
</body>
</html>
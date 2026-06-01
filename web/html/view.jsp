<%@ page import = "java.sql.*, java.util.*"%>
<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<html>
<head>
<title>列出所有留言</title>
</head>
<body>

<%
try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    try {
        String url="jdbc:mysql://localhost:3306/board?serverTimezone=UTC&useUnicode=true&characterEncoding=UTF-8";
        Connection con=DriverManager.getConnection(url,"root","1234");
        
        if(con != null && !con.isClosed()) {
       
            con.createStatement().execute("USE `board` ");

            // 計算總筆數
            String sqlCount = "SELECT * FROM `guestbook` ";
            ResultSet rsCount = con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY).executeQuery(sqlCount);
            rsCount.last();
            int total_content = rsCount.getRow();
            int page_num = (int)Math.ceil((double)total_content/5.0);

            // 取得目前頁碼 
            String page_string = request.getParameter("page");
            if (page_string == null || page_string.equals("0")) {
                page_string = "1";
            }
            int current_page = Integer.valueOf(page_string);

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

            // 抓取當前頁面資訊
            int start_record = (current_page - 1) * 5;
            String sqlList = "SELECT * FROM `guestbook` ORDER BY `GBNO` DESC LIMIT " + start_record + ", 5";
            ResultSet rsList = con.createStatement().executeQuery(sqlList);
			
            while(rsList.next()) {
				out.println("留言主題:" + rsList.getString("Subject") + "<br>");
				out.println("訪客姓名:" + rsList.getString("GBName") + "<br>");
				out.println("E-mail:" + rsList.getString("Mail") + "<br>");
                
                String content = rsList.getString(5);
                if (content != null) {
                    content = content.replace("\n", "<br>");
                }
                out.println("留言內容:" + content + "<br>");
                out.println("留言時間:" + rsList.getString(6) + "<br><hr>");
            }
            con.close();
        }
    } catch (SQLException sExec) {
        out.println("SQL錯誤: " + sExec.toString());
    }
} catch (ClassNotFoundException err) {
    out.println("驅動載入錯誤: " + err.toString());
}
%>
</body>
</html>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    String url = "jdbc:mysql://localhost:3306/cart?useSSL=false&serverTimezone=Asia/Taipei&useUnicode=true&characterEncoding=utf8";
    String user = "root";
    String password = "1234";

    String action = request.getParameter("action");
    String pIdParam = request.getParameter("p_id");

    //增加、減少、刪除
    if (action != null && pIdParam != null) {
        Connection connAction = null;
        PreparedStatement pstmtAction = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connAction = DriverManager.getConnection(url, user, password);

            if ("add".equals(action)) {
                String checkSql = "SELECT c.Quantity AS CartQty, i.Quantity AS MaxStock FROM shopping_cart c JOIN Inventory i ON c.Product_ID = i.Product_ID WHERE c.Product_ID = ?";
                pstmtAction = connAction.prepareStatement(checkSql);
                pstmtAction.setString(1, pIdParam);
                ResultSet rsCheck = pstmtAction.executeQuery();
                if (rsCheck.next() && rsCheck.getInt("CartQty") < rsCheck.getInt("MaxStock")) {
                    String sql = "UPDATE shopping_cart SET Quantity = Quantity + 1 WHERE Product_ID=?";
                    PreparedStatement pstmtUpdate = connAction.prepareStatement(sql);
                    pstmtUpdate.setString(1, pIdParam);
                    pstmtUpdate.executeUpdate();
                    pstmtUpdate.close();
                }
            } else if ("minus".equals(action)) {
                String sql = "UPDATE shopping_cart SET Quantity = Quantity - 1 WHERE Product_ID=? AND Quantity > 1";
                pstmtAction = connAction.prepareStatement(sql);
                pstmtAction.setString(1, pIdParam);
                pstmtAction.executeUpdate();
            } else if ("delete".equals(action)) {
                String sql = "DELETE FROM shopping_cart WHERE Product_ID=?";
                pstmtAction = connAction.prepareStatement(sql);
                pstmtAction.setString(1, pIdParam);
                pstmtAction.executeUpdate();
            }
            response.sendRedirect("cart.jsp");
            return;
        } finally {
            if (pstmtAction != null) pstmtAction.close();
            if (connAction != null) connAction.close();
        }
    }
%>

<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>我的購物車 - 醫療器材販賣商城</title>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+TC:wght@300;400;500;700&display=swap" rel="stylesheet">
<style>
	:root {
		--primary-color: #00A49E;
		--primary-hover: #008782;
		--text-color: #333333;
		--light-bg: #F8F9FA;
		--border-color: #E5E5E5;
		--price-color: #FF5A5F;
	}
	body {
		font-family: 'Noto Sans TC', sans-serif;
		background-color: #FFFFFF;
		color: var(--text-color);
		padding: 40px 20px;
	}
	.cart-container {
		max-width: 1000px;
		margin: 0 auto;
		background: #FFFFFF;
		padding: 30px;
		border-radius: 12px;
		box-shadow: 0 4px 20px rgba(0,0,0,0.05);
		border: 1px solid var(--border-color);
	}
	h2 {
		font-size: 24px;
		color: var(--primary-color);
		margin-bottom: 25px;
		border-bottom: 2px solid var(--primary-color);
		padding-bottom: 10px;
	}
	table {
		width: 100%;
		border-collapse: collapse;
		margin-bottom: 30px;
	}
	th, td {
		padding: 15px;
		text-align: center;
		border-bottom: 1px solid var(--border-color);
	}
	th {
		background-color: var(--light-bg);
		font-weight: 500;
		color: #666;
	}
	.qty-btn {
		display: inline-block;
		width: 28px;
		height: 28px;
		line-height: 26px;
		text-align: center;
		border: 1px solid var(--border-color);
		background: #fff;
		border-radius: 4px;
		text-decoration: none;
		color: var(--text-color);
		font-weight: bold;
		transition: all 0.2s;
	}
	.qty-btn:hover {
		border-color: var(--primary-color);
		color: var(--primary-color);
		background-color: #E6F4F3;
	}
    .qty-btn.disabled {
        background-color: #EEEEEE;
        color: #CCCCCC;
        border-color: #E5E5E5;
        cursor: not-allowed;
        pointer-events: none;
    }
	.qty-text {
		display: inline-block;
		width: 40px;
		text-align: center;
	}
	.delete-btn {
		background-color: #FFF0F0;
		color: var(--price-color);
		border: 1px solid #FFD2D3;
		padding: 6px 12px;
		border-radius: 6px;
		cursor: pointer;
		transition: all 0.2s;
	}
	.delete-btn:hover {
		background-color: var(--price-color);
		color: #fff;
	}
	.empty-msg {
		text-align: center;
		padding: 5px 0 40px 0;
		color: #888;
		font-size: 16px;
	}
	.total-box {
		text-align: right;
		font-size: 20px;
		font-weight: bold;
		margin-bottom: 30px;
		color: var(--price-color);
	}
	.actions-box {
		display: flex;
		justify-content: space-between;
		align-items: center;
	}
	.btn-secondary {
		color: #666;
		border: 1px solid var(--border-color);
		padding: 10px 20px;
		border-radius: 6px;
		text-decoration: none;
		transition: all 0.2s;
	}
	.btn-secondary:hover {
		background-color: var(--light-bg);
	}
	.btn-primary {
		background-color: var(--primary-color);
		color: white;
		padding: 10px 25px;
		border-radius: 6px;
		text-decoration: none;
		font-weight: 500;
		transition: background-color: 0.2s;
	}
	.btn-primary:hover {
		background-color: var(--primary-hover);
	}
</style>
<script>
    function confirmDelete(name, id) {
        if (confirm("確定刪除 " + name + "？")) window.location.href = "cart.jsp?action=delete&p_id=" + id;
    }
</script>
</head>
<body>

<div class="cart-container">
    <h2>🛒 我的購物車</h2>
    <table>
        <thead>
            <tr>
                <th>商品編號</th>
                <th>商品名稱</th>
                <th>單價</th>
                <th>數量</th>
                <th>小計</th>
                <th>操作</th>
            </tr>
        </thead>
        <tbody>
        <%
            Connection conn = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;
            int totalSum = 0;
            boolean hasItems = false;
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection(url, user, password);
                
                String sql = "SELECT c.Product_ID, c.Quantity AS CartQty, p.Product_Name, p.Unit_Price, i.Quantity AS Stock " +
                             "FROM shopping_cart c " +
                             "JOIN Product p ON c.Product_ID = p.Product_ID " +
                             "LEFT JOIN Inventory i ON c.Product_ID = i.Product_ID";
                pstmt = conn.prepareStatement(sql);
                rs = pstmt.executeQuery();

                while(rs.next()) {
                    hasItems = true;
                    String pId = rs.getString("Product_ID");
                    String pName = rs.getString("Product_Name");
                    int price = rs.getInt("Unit_Price");
                    int qty = rs.getInt("CartQty");
                    int stock = rs.getInt("Stock");
                    int subTotal = price * qty;
                    totalSum += subTotal;
        %>
                    <tr>
                        <td><%= pId %></td>
                        <td style="text-align: left;">
                            <%= pName %><br>
                            <span style="font-size: 12px; color: #999;">(庫存剩餘：<%= stock %> 件)</span>
                        </td>
                        <td>$<%= price %> 元</td>
                        <td>
                            <a href="cart.jsp?action=minus&p_id=<%= pId %>" class="qty-btn">−</a>
                            <strong class="qty-text"><%= qty %></strong>
                            <a href="cart.jsp?action=add&p_id=<%= pId %>" class="qty-btn <%= qty >= stock ? "disabled" : "" %>">+</a>
                        </td>
                        <td style="color: var(--price-color); font-weight: bold;">$<%= subTotal %> 元</td>
                        <td>
                            <button type="button" class="delete-btn" onclick="confirmDelete('<%= pName.replace("'", "\\'") %>', '<%= pId %>')">🗑️ 刪除</button>
                        </td>
                    </tr>
        <%
                }
            } catch (SQLException sExec) {
                out.print("<tr><td colspan='6' style='color:red;'>購物車讀取失敗：" + sExec.toString() + "</td></tr>");
            } finally {
                if (rs != null) try { rs.close(); } catch (SQLException e) {}
                if (pstmt != null) try { pstmt.close(); } catch (SQLException e) {}
                if (conn != null) try { conn.close(); } catch (SQLException e) {}
            }
        %>
        </tbody>
    </table>

    <% if (!hasItems) { %>
        <div class="empty-msg">您的購物車目前是空的喔！快去挑選一些需要的醫療器材吧！</div>
    <% } else { %>
        <div class="total-box">
            結帳總金額： $<%= totalSum %> 元
        </div>
    <% } %>

    <div class="actions-box">
        <a href="../index.jsp" class="btn-secondary">⬅ 繼續購物</a>
        <% if (hasItems) { %>
            <a href="checkout.jsp" class="btn-primary">確認結帳並付款 ➡</a>
        <% } %>
    </div>
</div>
</body>
</html>

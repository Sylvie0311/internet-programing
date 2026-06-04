<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    // 資料庫連線
    String url = "jdbc:mysql://localhost:3306/medical_system_my_db?useSSL=false&serverTimezone=Asia/Taipei&useUnicode=true&characterEncoding=utf8";
    String user = "root";
    String password = "1234";

    // 商品編號
    String action = request.getParameter("action");
    String pIdParam = request.getParameter("p_id");

    // 數量加減、刪除 
    if (action != null && pIdParam != null) {
        Connection connAction = null;
        Statement stmtAction = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connAction = DriverManager.getConnection(url, user, password);
            stmtAction = connAction.createStatement();

            String sqlAction = "";

            if (action.equals("add")) {
                sqlAction = "UPDATE shopping_cart SET Quantity = Quantity + 1 WHERE Product_ID = '" + pIdParam + "'";
            } else if (action.equals("minus")) {
                sqlAction = "UPDATE shopping_cart SET Quantity = Quantity - 1 WHERE Product_ID = '" + pIdParam + "' AND Quantity > 1";
            } else if (action.equals("delete")) {
                sqlAction = "DELETE FROM shopping_cart WHERE Product_ID = '" + pIdParam + "'";
            } 
            if (!sqlAction.equals("")) {
                stmtAction.executeUpdate(sqlAction);
            }
            
            // 重新導向回自己，刷新購物車數據
            response.sendRedirect("cart.jsp");
            return;
        }
        catch (SQLException sExec) {
            out.print("<script>alert('購物車操作失敗：" + sExec.toString().replace("'", "\\'") + "');</script>");
        } 
        finally {
            if (stmtAction != null) { try { stmtAction.close(); } catch (SQLException e) {} }
            if (connAction != null) { try { connAction.close(); } catch (SQLException e) {} }
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
		transition: background-color 0.2s;
	}
	.btn-primary:hover {
		background-color: var(--primary-hover);
	}
</style>
<script type="text/javascript">
	function confirmDelete(productName, productId) {
		var agree = confirm("您確定要將「" + productName + "」從購物車中刪除嗎？");
		if (agree) {
			window.location.href = "cart.jsp?action=delete&p_id=" + productId;
		}
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
            Statement stmt = null;
            ResultSet rs = null;
            int totalSum = 0; 
            boolean hasItems = false; 

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection(url, user, password);
                stmt = conn.createStatement();

                String sql = "SELECT Product_ID, Quantity FROM shopping_cart";
                rs = stmt.executeQuery(sql);

                while (rs.next()) {
                    hasItems = true;
                    String pId = rs.getString("Product_ID");
                    int qty = rs.getInt("Quantity");
                    
                    String pName = "";
                    int price = 0;
                    
                    Statement stmtDetail = conn.createStatement();
                    String sqlDetail = "SELECT Product_Name, Unit_Price FROM Product WHERE Product_ID = '" + pId + "'";
                    ResultSet rsDetail = stmtDetail.executeQuery(sqlDetail);
                    if (rsDetail.next()) {
                        pName = rsDetail.getString("Product_Name");
                        price = rsDetail.getInt("Unit_Price");
                    }
                    rsDetail.close();
                    stmtDetail.close();
                    
                    int subTotal = price * qty; 
                    totalSum += subTotal;        
		%>
                    <tr>
                        <td><%= pId %></td>
                        <td style="text-align: left;"><%= pName %></td>
                        <td>$<%= price %> 元</td>
                        <td>
                            <a href="cart.jsp?action=minus&p_id=<%= pId %>" class="qty-btn">−</a>
                            <strong class="qty-text"><%= qty %></strong>
                            <a href="cart.jsp?action=add&p_id=<%= pId %>" class="qty-btn">+</a>
                        </td>
                        <td style="color: var(--price-color); font-weight: bold;">$<%= subTotal %> 元</td>
                        <td>
                            <button type="button" class="delete-btn" onclick="confirmDelete('<%= pName.replace("'", "\\'") %>', '<%= pId %>')">🗑️ 刪除</button>
                        </td>
                    </tr>
        <%
                }
            } 
            catch (SQLException sExec) {
                out.print("<tr><td colspan='6' style='color:red;'>購物車讀取失敗：" + sExec.toString() + "</td></tr>");
            } 
            finally {
                if (rs != null) { try { rs.close(); } catch (SQLException e) {} }
                if (stmt != null) { try { stmt.close(); } catch (SQLException e) {} }
                if (conn != null) { try { conn.close(); } catch (SQLException e) {} }
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

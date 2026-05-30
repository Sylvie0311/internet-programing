<%@ page import = "java.sql.*"%>
<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>

<html>
<head>
<title>留言版</title>
<style>
	* {
        box-sizing: border-box;
        margin: 0;
        padding: 0;
    }
    body {
        font-family: 'Noto Serif TC', serif;
        background-color: #fffaf0;
    }
    .big {
        font-size: 18px;
        margin: 30px auto;
        padding: 30px;
        border: 2px solid #e08e8e;
        border-radius: 20px;
        background-color: #fff8dc;
        width: 70%;
        display: flex;
        justify-content: center;
        align-items: center;
    }
    .middle {
        line-height: 2.3;
        display: flex;
        flex-direction: column;
        align-items: center;
        width: 100%;
    }
    .small {
        margin: 15px 0;
        text-align: center;
    }
    .small input[type="text"],
    .small input[type="number"],
    .small textarea {
        width: 80%;
        padding: 8px;
        margin: 8px 0;
        border: 1px solid #ccc;
        border-radius: 8px;
        font-size: 16px;
    }
    .small textarea {
        resize: none;
    }
    .small input[type="submit"],
    .small input[type="reset"] {
        background-color: #e08e8e;
        color: white;
        border: none;
        padding: 10px 20px;
        margin: 10px 5px;
        border-radius: 8px;
        font-size: 16px;
        cursor: pointer;
        transition: background-color 0.3s;
    }
    .small input[type="submit"]:hover,
    .small input[type="reset"]:hover {
        background-color: #c76b6b;
    }
    .small input[type="number"] {
        text-align: center;
    }
	 .form-row {
        display: flex;
        align-items: flex-start; 
        width: 100%;
        max-width: 500px;
    }
</style>
</head>
<body>
<a href="view.jsp?page=1">觀看留言</a><p>
<div class="big">
	<div class="middle">
		<form name="form1" method="post" action="add.jsp" class="small">
		<div class="form-row">
		姓名：<input type="text" name="name"><br>
		</div>
		<div class="form-row">
		郵件：<input type="text" name="mail"><br>
		</div>
		<div class="form-row">
		主題：<input type="text" name="subject"><br>
		</div>
		<div class="form-row">
		內容:&nbsp&nbsp<br>
		<textarea rows=5 name="content"></textarea><br>
		</div>
		<input type="submit" name="Submit" value="送出">
		<input type="Reset" name="Reset" value="重新填寫">
		</form>
		
		<form action="view.jsp" method="get" class="small">
			直接跳轉至頁碼:<input type="number" name="page" min="1" style="width:50px;">
			<input type="submit" value="跳轉">
		</form>
	</div>
</div>
</body>
</html>

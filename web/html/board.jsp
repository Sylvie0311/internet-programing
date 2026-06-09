<%@ page import = "java.sql.*"%>
<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<html>
<head>
<title>留言版</title>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+TC:wght@400;500;700&display=swap" rel="stylesheet">
<style>
    :root {
        --primary-color: #00A49E;
        --primary-hover: #008782;
        --secondary-bg: #E6F4F3;
        --text-color: #333333;
        --border-color: #E5E5E5;
        --danger-color: #FF5A5F;
    }

    body {
        font-family: 'Noto Sans TC', sans-serif;
        background-color: #FFFFFF;
        color: var(--text-color);
        line-height: 1.6;
        padding: 40px;
    }

    h2 {
        text-align: center;
        color: var(--primary-color);
        margin-bottom: 20px;
    }

    .card {
        max-width: 700px;
        margin: 0 auto;
        background: #fff;
        border: 1px solid var(--border-color);
        border-radius: 12px;
        padding: 30px;
        box-shadow: 0 4px 12px rgba(0,0,0,0.1);
    }

    .form-row {
        margin-bottom: 15px;
    }

    label {
        display: block;
        margin-bottom: 6px;
        font-weight: 500;
    }

    input[type="text"], input[type="number"], textarea {
        width: 100%;
        padding: 10px;
        border: 1px solid var(--border-color);
        border-radius: 6px;
        font-size: 15px;
    }

    textarea {
        resize: none;
    }

    .btn-submit, .btn-reset {
        background-color: var(--primary-color);
        color: #fff;
        border: none;
        padding: 10px 20px;
        border-radius: 6px;
        font-size: 15px;
        font-weight: 500;
        cursor: pointer;
        transition: background-color 0.25s ease;
        margin-right: 10px;
    }

    .btn-submit:hover, .btn-reset:hover {
        background-color: var(--primary-hover);
    }

    .btn-secondary {
        display: inline-block;
        margin-top: 15px;
        background-color: var(--secondary-bg);
        color: var(--primary-color);
        padding: 10px 20px;
        border-radius: 6px;
        font-size: 14px;
        font-weight: 500;
        text-decoration: none;
        transition: background-color 0.25s ease;
    }

    .btn-secondary:hover {
        background-color: var(--primary-color);
        color: #fff;
    }

    .btn-group {
        text-align: center;
        margin-top: 20px;
    }

    .error-msg {
        color: var(--danger-color);
        font-size: 13px;
        margin-top: 5px;
    }
</style>
<script>
    function validateForm() {
        const mailInput = document.forms["form1"]["mail"].value;
        if (!mailInput.includes("@")) {
            alert("請輸入有效的電子郵件地址，必須包含 @");
            return false;
        }
        return true;
    }
</script>
</head>
<body>
    <h2>留言版</h2>
    <div class="card">
        <form name="form1" method="post" action="add.jsp" onsubmit="return validateForm();">
            <input type="hidden" name="productId" value="<%= request.getParameter("id") %>">

            <div class="form-row">
                <label>姓名：</label>
                <input type="text" name="name" placeholder="請輸入您的姓名">
            </div>
            <div class="form-row">
                <label>郵件：</label>
                <input type="text" name="mail" placeholder="請輸入您的電子郵件">
            </div>
            <div class="form-row">
                <label>主題：</label>
                <input type="text" name="subject" placeholder="請輸入留言主題">
            </div>
            <div class="form-row">
                <label>內容：</label>
                <textarea rows="5" name="content" placeholder="請輸入留言內容"></textarea>
            </div>
            <div class="form-row">
                <input type="submit" name="Submit" value="送出" class="btn-submit">
                <input type="reset" name="Reset" value="重新填寫" class="btn-reset">
            </div>
        </form>

        <form action="view.jsp" method="get" style="text-align:center; margin-top:20px;">
            <label>直接跳轉至頁碼：</label>
            <input type="number" name="page" min="1" style="width:60px; text-align:center;">
            <input type="submit" value="跳轉" class="btn-submit">
        </form>

        <div class="btn-group">
            <a href="../index.jsp" class="btn-secondary">返回主頁</a>
            <a href="view.jsp?page=1" class="btn-secondary">觀看留言</a>
        </div>
    </div>
</body>
</html>

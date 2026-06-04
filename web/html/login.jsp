<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@page import="java.util.*,java.sql.*"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>會員登入</title>
<style>
:root {
    --primary-color: #00A49E;       
    --primary-hover: #008782;
    --light-bg: #FAFBFB;          
    --text-main: #333333;
    --border-color: #E5E5E5;
}

body {
    font-family: 'Noto Sans TC', sans-serif;
    background-color: var(--light-bg);
    margin: 0;
    padding: 0;
    color: var(--text-main);
}

.arrow {
    width: 32px;
    height: 32px;
    margin: 20px 0 0 20px;
    transition: transform 0.2s;
    display: inline-block;
}

.arrow:hover {
    transform: translateX(-3px);
}


.container {
    max-width: 450px;
    margin: 60px auto;
    padding: 0 20px;
}

.card {
    background: #FFFFFF;
    border-radius: 12px;
    padding: 40px 30px;
    border: 1px solid var(--border-color);
    box-shadow: 0 4px 20px rgba(0, 164, 158, 0.05);
}


.title {
    margin-bottom: 30px;
    font-size: 24px;
    text-align: center;
    font-weight: 700;
    color: #222222;
    letter-spacing: 1px;
}


.form {
    display: grid;
    gap: 20px; 
}
  
.form-row {
    display: flex;
    flex-direction: column;
}
  
label {
    margin-bottom: 8px;
    font-size: 14px;
    font-weight: 500;
    color: #555555;
}
  
input[type="text"], 
input[type="password"] {
    padding: 12px 14px;
    border: 1px solid #D1D5D5;
    border-radius: 8px;
    font-size: 15px;
    outline: none;
    transition: all 0.25s;
    background-color: #FFFFFF;
}

input[type="text"]:focus, 
input[type="password"]:focus {
    border-color: var(--primary-color);
    box-shadow: 0 0 0 3px rgba(0, 164, 158, 0.1);
}


.form-actions {
    display: flex;
    flex-direction: column;
    margin-top: 10px;
}
  
.s {
    padding: 12px 20px;
    border-radius: 8px;
    text-align: center;
    cursor: pointer;
    font-size: 16px;
    font-weight: 500;
    transition: all 0.25s;
    width: 100%;
}
  
.s.primary {
    background: var(--primary-color);
    color: #FFFFFF;
    border: none;
    letter-spacing: 2px;
    box-shadow: 0 4px 12px rgba(0, 164, 158, 0.15);
}

.s.primary:hover {
    background: var(--primary-hover);
    box-shadow: 0 6px 18px rgba(0, 164, 158, 0.25);
}

@media (max-width: 480px) {
    .container {
        margin: 30px auto;
    }
    .card {
        padding: 30px 20px;
    }
}
</style>
</head>
<body>
	<a href="../index.jsp">
		<img src="../images/arrow.png" class="arrow">
	</a>
  <main class="container">
    <section class="card">
      <h1 class="title">會員登入</h1>
      <form class="form" action="check.jsp" method="post" id="loginForm">
        <div class="form-row">
          <label for="login-id">帳號：</label>
          <input type="text" id="login-username" name="id" required placeholder="請輸入帳號">
        </div>

        <div class="form-row">
          <label for="login-passwords">密碼：</label>
          <input type="password" id="login-password" name="passwords" required placeholder="請輸入密碼">
        </div>

        <div class="form-actions">
          <button type="submit" class="s primary">登入</button>
        </div>
      </form>
    </section>
  </main>
<script>
/*會員登入*/
document.addEventListener("DOMContentLoaded", function() {
    const loginForm = document.getElementById("loginForm");
    const usernameInput = document.getElementById("login-username");
    const passwordInput = document.getElementById("login-password");

    if (loginForm) {
        loginForm.addEventListener("submit", function(event) {
            // 取出欄位值並去除前後空白
            const username = usernameInput.value.trim();
            const password = passwordInput.value.trim();

            // 前端防呆驗證
            if (username === "" || password === "") {
                alert("請確實填寫帳號與密碼！");
                event.preventDefault(); // 阻擋表單送出
                return;
            }
            
            console.log("前端驗證通過，送出資料至 check.jsp...");
        });
    }
});
  
  // 綁定
  document.addEventListener('DOMContentLoaded', () => {
    const shippingOptions = document.querySelectorAll('input[name="shipping"]');
    shippingOptions.forEach(option => {
      option.addEventListener('change', toggleAddress);
    });
  });
 </script>
</body>
</html>

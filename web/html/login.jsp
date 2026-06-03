<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@page import="java.util.*,java.sql.*"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>登入</title>
<style>
/* 全域 */
body {
    font-family:'Noto Serif TC', serif;
    background-color: #ffe5ec;
    margin: 0;
    padding: 0;
}
.arrow{
    width: 30px;
    height: 30px;
    margin:20px;
}
/* 容器自適應 */
.container {
    max-width: 500px;
    margin: 50px auto;
    padding: 20px;
}

/* 卡片樣式 */ 
.card {
    background: #fff;
    border-radius: 8px;
    padding: 30px;
    box-shadow: 0 4px 12px rgba(0,0,0,0.1);
}

/* 標題 */
.title {
    margin-bottom: 20px;
    font-size: 24px;
    text-align: center;
}

/* 表單樣式 */
.form {
    display: grid;
    gap: 15px; 
}
  
.form-row {
    display: flex;
    flex-direction: column;
}
  
label {
    margin-bottom: 5px;
    font-size: 14px;
}
  
input[type="text"], 
input[type="password"],
input[type="email"],
input[type="tel"] {
    padding: 10px;
    border: 1px solid #ccc;
    border-radius: 6px;
}

/* 表單動作 */ 
.form-actions {
    display: flex;
    flex-direction: column;
    gap: 10px;
    align-items: center;
    margin-top: 10px;
}
  
.s {
    padding: 10px 20px;
    border-radius: 6px;
    text-align: center;
    cursor: pointer;
    width: 100%;
    max-width: 300px;
}
  
.s.primary {
    background: #4a90e2;
    color: #fff;
    border: none;
    text-decoration: none;
    width:250px;
}
  
.s.link {
    background: transparent;
    color: #4a90e2;
}

.s.link:hover {
    text-decoration: underline;
}

/* 隱藏欄位 */
.hidden {
    display: none;
}

/* ===== 響應式 ===== */
@media (max-width: 600px) {
    .container {
        margin: 20px auto;
        padding: 10px;
    }
    .card {
        padding: 20px;
    }
    .s {
        width: 100%;
    }
    .s.primary{
        width:70%;
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
      <h1 class="title">登入</h1>
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
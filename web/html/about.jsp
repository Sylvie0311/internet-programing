<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*,java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>關於我們</title>
	<style>
	*{
		box-sizing: border-box;
		margin: 0;
		padding: 0;
	}
	
	body {
		font-family:'Noto Serif TC', serif;
		background-color: #00A49E;
		margin: 0;
		padding: 20px;
	}

	.arrow{
		width:30px;
		height:30px;
	}
	/*卡片區域容器:置中並限制寬度*/
	.card-area{
		max-width: 1200px;
		margin: 0 auto;
		display: grid;
		grid-template-columns: repeat(2, 1fr);
		gap: 20px; 
	}

	/* 單一卡片樣式*/
	.card {
		background-color: #fff;
		border-radius: 10px;
		padding: 20px 10px;
		box-shadow: 0 4px 8px rgba(0,0,0,0.1);
		text-align: center;
		height: auto;
		display: flex;
		flex-direction: column;
		overflow: hidden;
	}

	/* 圓形頭像 */
	.photo-box img {
		width: 100px;  
		height: 100px;  
		object-fit: cover; 
		border-radius: 50%;
		margin-bottom: 15px;
	}
	  
	/* 文字段落樣式 */
	.card p {
		font-size: 14px;
		color: #333;
		margin-bottom: 10px;
		line-height: 1.5;
		word-wrap: break-word;       
		overflow-wrap: break-word;   
		word-break: break-all;
	}

	/*響應式*/
	/*手機 */
	@media (max-width: 767px) {
		.card-area {
			grid-template-columns: 1fr; 
			padding: 10px;
		}
		.card {
			height: auto; 
			padding: 15px;
		}
		h1 {
			font-size: 1.5rem; 
		}
	}

	/*平板*/
	@media (min-width: 768px) and (max-width: 1024px) {
		.card-area {
			grid-template-columns: repeat(2, 1fr); 
		}
		.card {
			height: 400px; 
		}
	}

	/*桌面 */
	@media (min-width: 1025px) {
		.card-area {
			grid-template-columns: repeat(2, 1fr); 
		}
	}
	</style>
</head>
<body>
  <a href="../index.jsp">
    <img src="../images/arrow.png" class="arrow">
  </a>
  
  <div class="card-area">
    <div class="card">
      <div class="photo-box">
        <img src="../images/me.png" alt="個人照片">
      </div>
      <p>姓名:馬彩庭</p>
      <p>工作內容:商品陳列與庫存展示、動態庫存管理、購物車結帳與品項刪除、SQL框架、商品照片蒐集</p>
      <p>心得:<br>
        這次做完期末專題後，最難就是在庫存數量變動的地方了。
		一開始我的商品清單裡，只有 4 個商品項目能正常顯示庫存，只要使用者一操作，資料就容易對不上。
		為了搞定這個大魔王問題，我真的花了很多時間，每天都在程式碼裡刪刪改改、不斷重新測試。
		但也因為這樣反覆除錯的磨練，當看到每個商品的庫存終於能成功啟動、精準連動時，那個成就感真的很難用言語形容！
		這次的經驗讓我深刻體會到，寫專題不只是在寫程式碼，更是在鍛鍊自己面對問題時、靜下心來拆解並解決問題的能力。
      </p>
    </div>
  
    <div class="card">
      <div class="photo-box">
        <img src="../images/yc.jpg" alt="個人照片">
      </div>
      <p>姓名：莊晏淳</p>
      <p>工作內容:前端視覺美化、產品搜尋功能、網頁計數器</p>
      <p>心得:<br>
        在本次專題中，我主要負責動態功能模組的開發與優化。
		其中最具挑戰性的是「網頁計數器」與「產品搜尋功能」的實作。
		透過整合 JSP 與 MySQL 資料庫，我深入理解了如何利用 SQL 的 COUNT、LIMIT 分頁機制與動態撈取技術，
		將原本死板的條列留言轉化為兼具計數統計與流暢分頁的現代化清單。
		而在產品搜尋與篩選的邏輯設計中，也讓我掌握了前後端資料傳遞、參數驗證（如 productId 的防呆防空機制）
		以及處理跨環境 UTF-8 亂碼的實務經驗。這次專題讓我真正體會到，將邏輯架構轉化為使用者友善功能的成就感。
      </p>
    </div>
  
    <div class="card">
      <div class="photo-box">
        <img src="../images/yl.jpg" alt="個人照片">
      </div>
      <p>姓名：顏伶頤</p>
      <p>工作內容:前端製作、留言板展現、登入控制</p>
      <p>心得:<br>
        這次期末專案最具挑戰性的部分，莫過於SQL和JSP後端與前端網頁的跨平台串接。在開發初期，
		經常因為串接邏輯不夠嚴謹或語法出錯，導致前端傳輸的資料在後端端點遺失。
		而在撰寫JSP時也曾因語法不夠熟練而陷入瓶頸，所幸透過複習課堂講義並上網查閱資料，
		最終解決了所有出錯的問題。在這次的實作開發中，不僅讓我實質掌握了前後端的完整架構外，
		也大幅提升了自我獨立為程式進行疑難排解的能力。

      </p>
    </div>
  
    <div class="card">
      <div class="photo-box">
        <img src="../images/tx.jpg" alt="個人照片">
      </div>
      <p>姓名：王婷宣</p>
      <p>工作內容：商家後臺管理、資料隱碼防注入、新增上架修改刪除產品</p>
      <p>心得：<br>
        我認為這次期末專案最具挑戰性的部分是前後端的整合與連接。
		在開發過程中，需要確保前端畫面能夠正確地與後端資料庫進行資料傳輸與互動，
		在本次專案中，我負責商家後臺管理功能的開發，
		包括產品的新增、上架、修改與刪除，以及資料隱碼與防止 SQL Injection 等安全性相關功能。
		透過實際操作，這次專案讓我獲得許多寶貴的經驗，
		從需求分析、功能實作到問題排除，都讓我學到許多課堂上較少接觸的實務技能。
		同時也感謝組員們的協助與配合，在遇到困難時大家能互相討論、共同解決問題，
		讓專案得以順利完成。
      </p>
    </div>
  </div>

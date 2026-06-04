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
		background-color: #ffe5ec;
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
      <p>工作內容:html分支、基礎css分支、找icon、些許js</p>
      <p>心得:<br>
          在這堂課做註冊與登入功能時，js的部分讓我陷入困境，因為以前沒學過此類相關的程式，
          所以對於程式語法結構感到陌生，剛開始感覺自己有點驚慌失措不知從何下手。
          但後面透過向電腦ai查詢輔助及利用老師上課的基礎結構架構下，我不僅順利解決了語法難題，
          更釐清了互動的邏輯，最後順利解決了我的程式問題。 
          從這次的經驗讓我了解到任何的程式語言學系方式都是應該學習基礎的架構然後再去記住它的特殊語法及邏輯，
          後面有不懂的地方可以跟同學討論或ai求助，不是ㄧ昧悶著頭苦做。
      </p>
    </div>
  
    <div class="card">
      <div class="photo-box">
        <img src="../images/yc.jpg" alt="個人照片">
      </div>
      <p>姓名：莊晏淳</p>
      <p>工作內容:管理並優化商品影像素材、整理&尋找商品資訊、使用AI製作商標、撰寫大部分css</p>
      <p>心得:<br>
        在工作中，我負責商品影像素材的管理與優化，確保圖片規格與品質符合展示與上架需求，
        並整理與整合商品資訊，讓資料更完整、易於使用。
        這些工作流程雖繁瑣，但需要耐心與細心完成。
        在品牌視覺方面，我嘗試運用 AI 工具製作商標，學習透過指令引導 AI 產出理想設計。
        此外，我撰寫大部分 CSS，負責網站版面與細節調整，並在反覆嘗試中累積不同寫法與實務經驗，加深對前端樣式設計的理解。
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
        <img src="../images/yu.jpg" alt="個人照片">
      </div>
      <p>姓名：王婷宣</p>
      <p>工作內容：商家後臺管理、資料隱碼防注入、新增上架修改刪除產品</p>
      <p>心得：<br>
        動態廣告輪播是我覺得最困難的部分，需要理解定時器控制和事件監聽器的綁定。
        相反地，localStorage 資料管理的實現讓我覺得有趣，透過 JSON 序列化和反序列化
        來存儲和讀取商品資料，讓使用者即使關掉網頁再開啟，購物車裡的商品仍保存。在撰寫的過程中，我透過 AI 工具查找想要實現的功能，
        結合課業守護的教學資源包和TA影片的查閱以及反覆的測試，逐漸實踐了 JavaScript 的撰寫，成功將構想的購物功能具象化。
      </p>
    </div>
  </div>

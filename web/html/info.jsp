<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Information</title>


    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Italianno&family=Noto+Serif+HK:wght@200..900&family=Noto+Serif+TC:wght@200..900&display=swap" rel="stylesheet">
	
<style>
:root {
	--primary-color: #00A49E;      
	--primary-hover: #008782;      
	--secondary-bg: #E6F4F3;        
	--light-bg: #FAFBFB;          
	--card-bg: #FFFFFF;
	--text-main: #333333;          
	--text-sub: #666666;          
	--border-color: #E5E5E5;      
	--price-color: #FF5A5F;         
}

* {
	box-sizing: border-box;
	margin: 0;
	padding: 0;
}

body {
	font-family: 'Noto Sans TC', sans-serif;
	background-color: var(--light-bg);
	color: var(--text-main);
	line-height: 1.8;
	padding: 40px 20px;
}


.info-container {
	max-width: 800px;
	margin: 0 auto;
	display: flex;
	flex-direction: column;
	gap: 24px;
}

section {
	background-color: var(--card-bg);
	border: 1px solid var(--border-color);
	border-radius: 12px;
	padding: 30px;
	box-shadow: 0 4px 15px rgba(0, 164, 158, 0.02);
	transition: transform 0.3s ease, box-shadow 0.3s ease;
	position: relative;
	overflow: hidden;
	animation: cardFadeIn 0.5s ease-out forwards;
}

section:hover {
	transform: translateY(-3px);
	box-shadow: 0 8px 25px rgba(0, 164, 158, 0.1);
	border-color: var(--primary-color);
}

section h2 {
	font-size: 20px;
	font-weight: 700;
	color: #222222;
	margin-bottom: 16px;
	padding-left: 12px;
	border-left: 4px solid var(--primary-color);
	letter-spacing: 1px;
}


section p {
	font-size: 15px;
	color: var(--text-sub);
	margin-bottom: 10px;
}

section p:last-child {
	margin-bottom: 0;
}

section strong {
	color: #222222;
	font-weight: 500;
}


#news p {
	background-color: #F4FBFB;
	padding: 12px 16px;
	border-radius: 6px;
	margin-bottom: 12px;
	border: 1px dashed #CCEBEA;
}

.btn-wrapper {
	text-align: center;
	margin-top: 20px;
	margin-bottom: 40px;
}

.back-btn {
	display: inline-block;
	text-decoration: none;
	background-color: var(--primary-color);
	color: #FFFFFF;
	padding: 12px 36px;
	font-size: 15px;
	font-weight: 500;
	border-radius: 25px;
	letter-spacing: 0.5px;
	box-shadow: 0 4px 12px rgba(0, 164, 158, 0.2);
	transition: all 0.25s ease;
}

.back-btn:hover {
	background-color: var(--primary-hover);
	box-shadow: 0 6px 18px rgba(0, 164, 158, 0.35);
	transform: translateY(-1px);
}

@keyframes cardFadeIn {
	from { opacity: 0; transform: translateY(15px); }
	to { opacity: 1; transform: translateY(0); }
}


@media (max-width: 600px) {
	body {
		padding: 20px 15px;
	}
	section {
		padding: 20px;
	}
	section h2 {
		font-size: 18px;
	}
	section p {
		font-size: 14px;
	}
}
</style>

</head>
<body>
<div class="info-container">
    <section id="brand">
        <h2>品牌介紹</h2>
        <p>「醫療器材販賣商城」致力於成為您居家健康與專業醫療的最強後盾。我們深知優質器材對維護生命健康的重要性，館內商品涵蓋日常防護醫用口罩、專業電子血壓計、復健護具到全方位輔具。所有器材均通過國家醫療器材認證，嚴格控管品質，讓每一次的測量與防護都精準安心。</p>
    </section>

    <section id="store">
        <h2>門市據點</h2>
        <p><strong>桃園總店：</strong>桃園市中壢區中北路200號 (鄰近中原大學，客服專線：02-0888-0618，營業時間 09:00 - 21:00)</p>
        <p><strong>台北旗艦店：</strong>台北市信義區忠孝東路五段 (捷運站旁，提供大型醫療輔具與輪椅椅款現場實體體驗，營業時間 11:00 - 22:00)</p>
    </section>

    <section id="news">
        <h2>最新消息</h2>
        <p>🔥 <strong>防疫與健康防護專區升級：</strong>醫用 N95 口罩、活性碳口罩與無菌針頭大量現貨到庫，保障醫療前線與居家防護需求！</p>
        <p>📢 <strong>系統升級公告：</strong>全新醫療商城會員系統正式上線！現在點擊註冊完成即可至「會員中心」領取 50 元首購折價券。</p>
    </section>

    <section id="service">
        <h2>售後服務問題</h2>
        <p><strong>衛生器材保障：</strong>基於醫療衛生與個人防護安全考量，接觸性器材（如口罩、約束帶、無菌針頭、人工皮等）一經拆封，恕不接受非瑕疵原因之退換貨。</p>
        <p><strong>電子儀器保固：</strong>電子血壓計、血糖機等儀器類商品皆享有原廠安心保固與免費校正諮詢。若收到產品有品項不符或功能異常，請於 7 天內聯繫客服專線或透過 Email 與我們聯繫，我們將為您安排免費換貨處理。</p>
    </section>

    <section id="shopping">
        <h2>購物常見說明</h2>
        <p><strong>多元支付方式：</strong>商城全面支援多種安全便捷的付款管道，包括 VISA / MasterCard 信用卡線上刷卡、PayPal、LINE Pay 行動支付以及超商貨到付款。</p>
        <p><strong>配送與出貨效率：</strong>日常防護及中小型醫療器材於下單後 48 小時內快速出貨。超商取貨約 2-3 個工作天送達；大型復健器材或馬桶椅等輔具則全面採用合作物流專車安全配送。</p>
    </section>

    <section id="privacy">
        <h2>隱私公告</h2>
        <p>本商城極為重視您的個人資訊與醫療消費隱私。我們承諾嚴格保護您的身分資料、聯絡電話、收件地址及病患相關器材購買記錄，絕不向任何第三方透露或外洩。所有資訊均加密儲存，並完全遵循國家個人資料保護法及醫療器材販售法規之各項規定辦理。</p>
    </section>

    <div class="btn-wrapper">
        <a href="../index.jsp" class="back-btn">回首頁繼續購物</a>
    </div>
</div>
</body>
</html>
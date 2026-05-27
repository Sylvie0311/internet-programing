// 1. 20款完整的杏一醫療護理精選商品資料庫
const products = [
    { id: 1, brand: "OMRON 歐姆龍", name: "HEM-7121 電子血壓計 (基礎型)", price: 1680, img: "https://images.unsplash.com/photo-1603398938378-e54eab446dde?w=300", desc: "居家高血壓防護的核心款式！單鍵操作簡易，具備大螢幕清晰數位顯示，能自動記錄前次測量數值。搭載不正確壓脈帶著裝提示，長輩單獨在家操作也能精準放心。" },
    { id: 2, brand: "OMRON 歐姆龍", name: "HEM-7156 智慧藍牙手臂式血壓計", price: 2980, img: "https://images.unsplash.com/photo-1576091160399-112ba8d25d1d?w=300", desc: "升級360度精準硬式壓脈帶，怎麼捲都準確。內建智慧藍牙傳輸技術，可與手機OMRON Connect APP完美同步，省去手寫記錄，長效追蹤全家人長期的健康曲線。" },
    { id: 3, brand: "Accu-Chek 羅氏", name: "逸智血糖機隨身組 (含採血筆/採血針)", price: 2200, img: "https://images.unsplash.com/photo-1584017911766-d451b3d0e843?w=300", desc: "德國精密醫療製程，量測時間僅需4秒、採血量極少。寬廣的試紙吸血區防呆效果佳，並支持低血糖貼心預警，是糖尿病健康管理不可或缺的專業伴侶。" },
    { id: 4, brand: "Bionime 華廣", name: "GM700S 瑞特血糖機 專業照護組", price: 1950, img: "https://images.unsplash.com/photo-1631549916768-4119b255f9ed?w=300", desc: "專利黃金電極試紙技術，提供高穩定、高精準的生理量測報告。無導線一體化寬大設計，專為年長者顫抖的手量身打造，握持更平穩安全。" },
    { id: 5, brand: "來復易", name: "整夜一片就安心紙尿片(33片x6包/箱)", price: 1239, img: "https://images.unsplash.com/photo-1540555700478-4be289fbecef?w=300", desc: "專為長期臥床或夜間高尿量護理設計，高達4次尿量吸收力。創新的立體防漏摺邊，防側漏、後漏。長效乾爽防止壓瘡與紅屁股不適。" },
    { id: 6, brand: "來復易", name: "防漏安心復健褲 (M號/4包/箱)", price: 1299, img: "https://images.unsplash.com/photo-1550572017-edd951b55104?w=300", desc: "如同純棉內褲般貼身隱形。超高彈性腰圍極易自行穿脫，適合具行動能力、進行復健中的長輩，重拾自主尊嚴與社交生活的安心防護。" },
    { id: 7, brand: "包大人", name: "防漏安心替換式尿片(30片x6包)", price: 850, img: "https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?w=300", desc: "高性價比醫養機構首選！強力吸收芯體快速鎖水，表層添加親膚抑菌成分。可搭配各式外層紙尿褲重複替換，大幅節省日常護理開銷。" },
    { id: 8, brand: "CENTRUM 善存", name: "新寶納多孕婦綜合維他命 (230錠/盒)", price: 1499, img: "https://images.unsplash.com/photo-1584017911766-d451b3d0e843?w=300", desc: "專為懷孕期及哺乳期女性研發。補齊高單位鐵質、葉酸、鈣質及多元微量元素，一錠補足媽媽與寶寶雙向發育的每日黃金營養素。" },
    { id: 9, brand: "CENTRUM 善存", name: "葉黃素20mg 游離型軟膠囊 (60粒/2盒)", price: 1249, img: "https://images.unsplash.com/photo-1607613009820-a29f7bb81c04?w=300", desc: "現代低頭族與高齡銀髮必備。採用液態游離型葉黃素，分子小、吸收效率加倍。科學實證5比1黃金比例搭配玉米黃素，全面對抗3C藍光傷害。" },
    { id: 10, brand: "Move Free 益節", name: "加強型迷你錠 (60錠/盒) 葡萄糖胺", price: 1350, img: "https://images.unsplash.com/photo-1626754226190-d5a934639a06?w=300", desc: "美國原裝進口關節保養專家。迷你小錠劑極易吞嚥，內含關鍵UC-II(非變性第二型膠原蛋白)與透明質酸，靈活行動力成效是傳統葡萄糖胺的2倍以上。" },
    { id: 11, brand: "Mueller 慕樂", name: "超薄透氣調整型全方位護膝 (單入)", price: 680, img: "https://images.unsplash.com/photo-1519689680058-324335c77eba?w=300", desc: "開放式圓孔設計能有效減輕髕骨壓力。交叉加壓束帶能自由調整鬆緊度，兼顧高度的膝關節側向支撐力與全天候久穿不悶熱的透氣表現。" },
    { id: 12, brand: "LP SUPPORT", name: "極致透氣加壓護腕帶 (兩入組)", price: 450, img: "https://images.unsplash.com/photo-1598971861713-54ad16a7e72e?w=300", desc: "媽媽手、滑鼠手、運動愛好者必備。高彈性針織材質，環繞式加壓束帶能精準鎖定手腕核心肌群與骨骼，穩定核心並預防日常反覆性拉傷。" },
    { id: 13, brand: "3M 醫療", name: "防水透氣敷料貼/人工皮 (3片裝)", price: 280, img: "https://images.unsplash.com/photo-1603398938378-e54eab446dde?w=300", desc: "超薄、防水、完全隔絕細菌與病毒入侵。能吸收傷口組織液，提供理想的濕潤癒合環境，減少疤痕形成，洗澡、游泳皆不易脫落。" },
    { id: 14, brand: "亞培 Abbott", name: "安素優能基 均衡營養配方 (850g 原味)", price: 950, img: "https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?w=300", desc: "全台各大醫院推薦的經典醫學營養品。內含28種維生素及礦物質、優質蛋白質，針對手術後調養、胃口不佳或高齡營養不良提供全方位能量修護。" },
    { id: 15, brand: "雀巢 Nestle", name: "佳膳膳纖 均衡營養完整配方 (400g)", price: 560, img: "https://images.unsplash.com/photo-1626754226190-d5a934639a06?w=300", desc: "特別添加優質膳食纖維與益生菌成分。水溶性與非水溶性纖維金比例，有助於維持腸道機能蠕動，維持長期灌食或腸胃敏感患者的排便順暢。" },
    { id: 16, brand: "Microlife 百略", name: "紅外線額溫槍 (FR1DL1 記憶型)", price: 1500, img: "https://images.unsplash.com/photo-1584017911766-d451b3d0e843?w=300", desc: "居家防疫前線守護者！1秒快速測量，具備發燒紅光警示背光燈。內建30組歷史數據記憶追蹤，更可一鍵切換測量室溫或嬰兒奶瓶表面溫度。" },
    { id: 17, brand: "BRAUN 百靈", name: "免接觸紅外線額溫槍 BNT400", price: 2480, img: "https://images.unsplash.com/photo-1576091160399-112ba8d25d1d?w=300", desc: "德國百靈精準專利。結合「免接觸式」與「觸碰式」雙測量模式，獨家發燒顏色顯示技術(綠/黃/紅)及距離導引光源，確保夜間幫熟睡寶寶量溫不失誤。" },
    { id: 18, brand: "中衛 CSD", name: "醫療口罩 50入 (經典醫療綠)", price: 300, img: "https://images.unsplash.com/photo-1584622650111-993a426fbf0a?w=300", desc: "符合國家CNS14774醫療級高標準規範。三層防護結構有效阻隔飛沫與細微粉塵，高彈性耳帶久戴不痛，色澤飽滿、透氣性優異，防護時尚兼具。" },
    { id: 19, brand: "普惠", name: "3D醫用防護口罩 (特大尺寸/30入)", price: 250, img: "https://images.unsplash.com/photo-1584622650111-993a426fbf0a?w=300", desc: "大臉型、高鼻樑或男士的福音！3D立體氣室設計，大幅增加口鼻呼吸空間，完美貼合面部輪廓不漏氣，同時避免說話時摩擦嘴唇及妝容脫落。" },
    { id: 20, brand: "杏一嚴選", name: "不鏽鋼折疊式便器椅/洗澡椅", price: 1850, img: "https://images.unsplash.com/photo-1519689680058-324335c77eba?w=300", desc: "居家無障礙護理神器。採用加厚不鏽鋼防鏽防滑結構，可放在床邊作為便器椅，亦可直接進浴室當作洗澡安全靠背椅，不用時可一秒折疊不佔空間。" }
];

// 購物車狀態陣列
let cart = [];

// DOM 元素選取
const productGrid = document.getElementById('productGrid');
const cartToggle = document.getElementById('cartToggle');
const cartSidebar = document.getElementById('cartSidebar');
const closeCart = document.getElementById('closeCart');
const cartItemsContainer = document.getElementById('cartItems');
const cartCount = document.getElementById('cartCount');
const cartTotal = document.getElementById('cartTotal');
const searchInput = document.getElementById('searchInput');

// 視圖切換元素
const mainView = document.getElementById('mainView');
const detailView = document.getElementById('detailView');
const checkoutView = document.getElementById('checkoutView');
const mainBanner = document.getElementById('mainBanner');
const goToCheckoutBtn = document.getElementById('goToCheckoutBtn');

// 2. 首頁渲染 20 個商品卡片
function renderProducts(productsList) {
    if (productsList.length === 0) {
        // 如果查無商品，渲染返回按鈕與文字
        productGrid.style.gridTemplateColumns = '1fr';
        productGrid.innerHTML = `
            <div class="no-product-container">
                <p><i class="fas fa-exclamation-circle" style="color:#aaa; font-size:48px; margin-bottom:15px;"></i><br>找不到符合關鍵字的醫療商品</p>
                <button class="back-home-btn" onclick="showMainPage()">返回主頁</button>
            </div>
        `;
        return;
    }

    productGrid.style.gridTemplateColumns = 'repeat(auto-fill, minmax(220px, 1fr))';
    productGrid.innerHTML = productsList.map(product => `
        <div class="product-card" onclick="goToDetail(${product.id}, event)">
            <img src="${product.img}" alt="${product.name}" class="product-img">
            <div>
                <p class="product-brand">${product.brand}</p>
                <h3 class="product-name">${product.name}</h3>
            </div>
            <div class="product-footer">
                <span class="product-price">$${product.price}</span>
                <button class="add-btn" onclick="addToCart(${product.id}, event)">加入購物車</button>
            </div>
        </div>
    `).join('');
}

// 3. 搜尋功能
function handleSearch() {
    const keyword = searchInput.value.trim().toLowerCase();
    const filtered = products.filter(p => 
        p.name.toLowerCase().includes(keyword) || 
        p.brand.toLowerCase().includes(keyword)
    );
    showMainPage(); // 確保是在首頁視圖顯示搜尋結果
    renderProducts(filtered);
}

// 支持輸入框按下 Enter 鍵直接搜尋
searchInput.addEventListener('keypress', function(e) {
    if (e.key === 'Enter') {
        handleSearch();
    }
});

// 4. 前往商品詳細內頁
function goToDetail(productId, event) {
    // 防呆：如果是按到「加入購物車」按鈕，不要觸發進入內頁
    if (event.target.classList.contains('add-btn')) return;

    const targetProduct = products.find(p => p.id === productId);
    if (!targetProduct) return;

    // 隱藏其他視圖，打開詳細內頁視圖
    mainView.style.display = 'none';
    checkoutView.style.display = 'none';
    detailView.style.display = 'block';
    window.scrollTo(0, 0);

    detailView.innerHTML = `
        <h2 class="section-title">商品詳情</h2>
        <div class="detail-layout">
            <div class="detail-img-box">
                <img src="${targetProduct.img}" alt="${targetProduct.name}">
            </div>
            <div class="detail-info-box">
                <div>
                    <p class="detail-brand">${targetProduct.brand}</p>
                    <h1 class="detail-title">${targetProduct.name}</h1>
                    <div class="detail-price-line">$${targetProduct.price}</div>
                    <div class="detail-desc-box">
                        <h4>【商品特點與介紹】</h4>
                        <p>${targetProduct.desc}</p>
                    </div>
                </div>
                <div class="detail-action-line">
                    <div class="quantity-selector">
                        <button onclick="adjustDetailQty(-1)">-</button>
                        <input type="number" id="detailQtyInput" value="1" min="1" readonly>
                        <button onclick="adjustDetailQty(1)">+</button>
                    </div>
                    <button class="large-add-btn" onclick="addFromDetail(${targetProduct.id})">加入購物車</button>
                    <button class="back-home-btn" style="background:#666;" onclick="showMainPage()">回首頁</button>
                </div>
            </div>
        </div>
    `;
}

// 詳細頁數量調整
function adjustDetailQty(amount) {
    const input = document.getElementById('detailQtyInput');
    let currentVal = parseInt(input.value) + amount;
    if (currentVal < 1) currentVal = 1;
    input.value = currentVal;
}

// 詳細頁將商品送入購物車
function addFromDetail(productId) {
    const input = document.getElementById('detailQtyInput');
    const qty = parseInt(input.value);
    
    const product = products.find(p => p.id === productId);
    const cartItem = cart.find(item => item.id === productId);

    if (cartItem) {
        cartItem.quantity += qty;
    } else {
        cart.push({ ...product, quantity: qty });
    }

    updateCartUI();
    cartSidebar.classList.add('open');
    input.value = 1; // 復原數量
}

// 5. 回到商城主首頁
function showMainPage() {
    detailView.style.display = 'none';
    checkoutView.style.display = 'none';
    mainView.style.display = 'block';
    mainBanner.style.display = 'block'; // 顯示頂部廣告
    window.scrollTo(0, 0);
}

// 6. 加入購物車邏輯 (首頁卡片專用)
function addToCart(productId, event) {
    if(event) event.stopPropagation(); // 阻止氣泡事件
    
    const product = products.find(p => p.id === productId);
    const cartItem = cart.find(item => item.id === productId);

    if (cartItem) {
        cartItem.quantity += 1;
    } else {
        cart.push({ ...product, quantity: 1 });
    }

    updateCartUI();
    cartSidebar.classList.add('open'); // 原汁原味：自動滑出側邊欄
}

// 從購物車刪除商品
function removeFromCart(productId) {
    cart = cart.filter(item => item.id !== productId);
    updateCartUI();
    // 同步刷新結帳頁面(若處於結帳畫面)
    if(checkoutView.style.display === 'block') {
        renderCheckoutView();
    }
}

// 更新購物車 UI
function updateCartUI() {
    const totalCount = cart.reduce((sum, item) => sum + item.quantity, 0);
    cartCount.textContent = totalCount;

    if (cart.length === 0) {
        cartItemsContainer.innerHTML = '<p class="empty-msg">購物車目前是空的</p>';
    } else {
        cartItemsContainer.innerHTML = cart.map(item => `
            <div class="cart-item">
                <div class="cart-item-info">
                    <h4>${item.name}</h4>
                    <p>$${item.price} x ${item.quantity}</p>
                </div>
                <button class="remove-btn" onclick="removeFromCart(${item.id})">
                    <i class="fas fa-trash-alt"></i>
                </button>
            </div>
        `).join('');
    }

    const totalPrice = cart.reduce((sum, item) => sum + (item.price * item.quantity), 0);
    cartTotal.textContent = totalPrice;
}

// 7. 進入與渲染獨立結帳區視圖
function renderCheckoutView() {
    const itemsListContainer = document.getElementById('checkoutItemsList');
    
    if (cart.length === 0) {
        itemsListContainer.innerHTML = '<p class="empty-msg" style="padding: 40px 0;">您的購物車內無任何商品，無法進行結帳。</p>';
        document.getElementById('checkoutTotal').textContent = '0';
        document.getElementById('checkoutPay').textContent = '0';
        return;
    }

    itemsListContainer.innerHTML = cart.map(item => `
        <div class="checkout-item">
            <img src="${item.img}" alt="${item.name}">
            <div class="checkout-item-details">
                <h4>${item.name}</h4>
                <p>品牌: ${item.brand} | 規格: 醫用標準級</p>
                <p style="color:var(--price-color); font-weight:bold; margin-top:5px;">$${item.price} x ${item.quantity}</p>
            </div>
            <button class="remove-btn" onclick="removeFromCart(${item.id})" style="padding: 10px;">
                <i class="fas fa-trash-alt" style="font-size:16px;"></i>
            </button>
        </div>
    `).join('');

    const total = cart.reduce((sum, item) => sum + (item.price * item.quantity), 0);
    document.getElementById('checkoutTotal').textContent = total;
    document.getElementById('checkoutPay').textContent = total;
}

// 訂單完成處理
function processOrder() {
    if (cart.length === 0) {
        alert('購物車是空的，無法送出訂單喔！');
        return;
    }
    alert('🎉 感謝您的訂購！MedFirst 杏一已收到您的模擬訂單，將由專業人員包裝配送。');
    cart = [];
    updateCartUI();
    showMainPage();
}

// 8. 事件監聽設定
cartToggle.addEventListener('click', () => {
    cartSidebar.classList.toggle('open');
});

closeCart.addEventListener('click', () => {
    cartSidebar.classList.remove('open');
});

goToCheckoutBtn.addEventListener('click', () => {
    cartSidebar.classList.remove('open'); // 關閉側邊欄
    mainView.style.display = 'none';
    detailView.style.display = 'none';
    mainBanner.style.display = 'none';  // 進入結帳頁隱藏 Banner 保持畫面乾淨
    checkoutView.style.display = 'block';
    renderCheckoutView();
    window.scrollTo(0, 0);
});

// 初始化網頁：載入全部 20 個商品
renderProducts(products);
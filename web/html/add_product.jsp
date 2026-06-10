<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
    <title>新增商品</title>
    <style>
        :root {
            --primary-color: #00A49E;      
            --primary-hover: #008782;        
            --secondary-bg: #E6F4F3;        
            --text-color: #333333;          
            --border-color: #E5E5E5;        
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
            max-width: 600px;
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

        input[type="text"], input[type="date"], input[type="file"] {
            width: 100%;
            padding: 10px;
            border: 1px solid var(--border-color);
            border-radius: 6px;
        }

        .btn-submit {
            display: block;
            width: 100%;
            background-color: var(--primary-color);
            color: #fff;
            padding: 12px;
            border: none;
            border-radius: 6px;
            font-size: 15px;
            font-weight: 600;
            cursor: pointer;
            transition: background-color 0.25s ease;
        }

        .btn-submit:hover {
            background-color: var(--primary-hover);
        }

        .btn-back {
            display: inline-block;
            margin-top: 15px;
            text-align: center;
            background-color: var(--secondary-bg);
            color: var(--primary-color);
            padding: 10px 20px;
            border-radius: 6px;
            font-size: 14px;
            font-weight: 500;
            text-decoration: none;
        }

        .btn-back:hover {
            background-color: var(--primary-color);
            color: #fff;
        }
    </style>
</head>
<body>
    <h2>新增商品</h2>
    <div class="card">
        <form action="add_product_process.jsp" method="post" enctype="multipart/form-data">
            <div class="form-row">
                <label>商品圖片 (限 .jpg):</label>
                <input type="file" name="Product_Image" accept=".jpg" required>
            </div>
            <div class="form-row">
                <label>商品編號:</label>
                <input type="text" name="Product_ID" required>
            </div>
            <div class="form-row">
                <label>商品名稱:</label>
                <input type="text" name="Product_Name" required>
            </div>
            <div class="form-row">
                <label>許可證號:</label>
                <input type="text" name="License_No">
            </div>
            <div class="form-row">
                <label>規格:</label>
                <input type="text" name="Specification">
            </div>
            <div class="form-row">
                <label>單價:</label>
                <input type="text" name="Unit_Price" required>
            </div>
            <div class="form-row">
                <label>商品介紹:</label>
                <input type="text" name="Product_introduction">
            </div>
            <div class="form-row">
                <label>庫存數量:</label>
                <input type="text" name="Stock_Quantity" required>
            </div>
            <input type="submit" value="新增商品" class="btn-submit">
        </form>
        <a href="product_list.jsp" class="btn-back">返回商品列表</a>
    </div>
</body>
</html>

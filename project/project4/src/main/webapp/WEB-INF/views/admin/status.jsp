<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>관리자 현황</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700&display=swap');
        
        * {
            box-sizing: border-box;
        }

        body {
            font-family: 'Noto Sans KR', sans-serif;
            margin: 0;
            padding: 80px 0 0 0;
            background-color: #8B0000;
            /* 중국풍 격자 무늬 패턴 */
            background-image: 
                linear-gradient(30deg, #800000 12%, transparent 12.5%, transparent 87%, #800000 87.5%, #800000),
                linear-gradient(150deg, #800000 12%, transparent 12.5%, transparent 87%, #800000 87.5%, #800000),
                linear-gradient(30deg, #800000 12%, transparent 12.5%, transparent 87%, #800000 87.5%, #800000),
                linear-gradient(150deg, #800000 12%, transparent 12.5%, transparent 87%, #800000 87.5%, #800000),
                linear-gradient(60deg, #990000 25%, transparent 25.5%, transparent 75%, #990000 75%, #990000),
                linear-gradient(60deg, #990000 25%, transparent 25.5%, transparent 75%, #990000 75%, #990000);
            background-size: 80px 140px;
            background-position: 0 0, 0 0, 40px 70px, 40px 70px, 0 0, 40px 70px;
            min-height: 100vh;
        }
        
        /* 상단 고정 메뉴바 */
        .menu-bar {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 70px;
            display: flex;
            align-items: center;
            justify-content: flex-start;
            padding: 0 40px;
            background: linear-gradient(90deg, #600000 0%, #8B0000 50%, #600000 100%);
            box-shadow: 0 4px 15px rgba(0,0,0,0.5);
            z-index: 1000;
            border-bottom: 3px solid #DAA520;
        }

        .brand-logo {
            color: #FFD700;
            font-size: 24px;
            font-weight: 700;
            margin-right: 60px;
            display: flex;
            align-items: center;
            gap: 10px;
            text-decoration: none;
            text-shadow: 1px 1px 2px rgba(0,0,0,0.5);
        }

        .menu-items {
            display: flex;
            gap: 10px;
        }
        
        .menu-item {
            padding: 10px 25px;
            color: rgba(255, 255, 255, 0.9);
            text-decoration: none;
            border-radius: 4px;
            font-weight: 500;
            transition: all 0.2s ease;
            font-size: 16px;
            border: 1px solid transparent;
        }
        
        .menu-item:hover {
            background: rgba(218, 165, 32, 0.2);
            color: #FFD700;
            border-color: #DAA520;
        }
        
        .menu-item.active {
            background: #DAA520;
            color: #600000;
            font-weight: 700;
            box-shadow: 0 0 10px rgba(218, 165, 32, 0.5);
        }

        .container {
            max-width: 1200px;
            margin: 40px auto;
            padding: 30px;
            background-color: #FFF9E6; /* 연한 크림색 배경 */
            border-radius: 15px;
            border: 4px double #DAA520; /* 금색 이중 테두리 */
            box-shadow: 0 10px 30px rgba(0,0,0,0.5);
            position: relative;
        }
        
        .container::before {
            content: '🐉';
            position: absolute;
            top: -35px;
            left: 50%;
            transform: translateX(-50%);
            font-size: 40px;
            background: linear-gradient(135deg, #8B0000 0%, #A52A2A 100%);
            width: 70px;
            height: 70px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            border: 4px solid #DAA520;
            box-shadow: 0 4px 15px rgba(0,0,0,0.4);
        }
        
        h1 {
            color: #8B0000;
            text-align: center;
            font-size: 32px;
            font-weight: 700;
            margin-bottom: 40px;
            text-shadow: 1px 1px 0 rgba(218, 165, 32, 0.3);
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 15px;
        }

        /* 테이블 섹션 스타일 */
        .table-section {
            background: white;
            border-radius: 8px;
            padding: 25px;
            margin-bottom: 25px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            border: 2px solid #DAA520;
            position: relative;
        }
        
        .table-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            padding-bottom: 15px;
            border-bottom: 2px dashed #DAA520;
        }
        
        .table-id {
            font-size: 22px;
            font-weight: 700;
            color: #8B0000;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .checkout-btn {
            padding: 8px 20px;
            background: linear-gradient(to bottom, #b22222, #800000);
            color: #FFD700;
            border: 1px solid #DAA520;
            border-radius: 4px;
            cursor: pointer;
            text-decoration: none;
            font-weight: 700;
            font-size: 14px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.2);
            transition: all 0.2s;
        }
        
        .checkout-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0,0,0,0.3);
        }
        
        /* 데이터 테이블 스타일 */
        table {
            width: 100%;
            border-collapse: collapse;
            font-size: 15px;
        }
        
        th {
            background: linear-gradient(to bottom, #8B0000, #600000);
            color: #FFD700;
            font-weight: 500;
            padding: 12px;
            text-align: left;
            border: 1px solid #600000;
        }
        
        td {
            padding: 12px;
            border-bottom: 1px solid #E0E0E0;
            color: #333;
            border-left: 1px solid #eee;
            border-right: 1px solid #eee;
        }
        
        tr:hover {
            background-color: #FFF5E6;
        }
        
        .total-row td {
            background: #f8f9fa;
            color: #333;
            font-weight: 700;
            border-top: 2px solid #8B0000;
            font-size: 16px;
        }
        
        .total-amount {
            color: #8B0000;
            font-size: 18px;
        }
        
        .empty-order {
            color: #888;
            text-align: center;
            padding: 40px;
            font-style: italic;
        }
        
        .checkout-container {
            margin-top: 20px;
            text-align: left;
        }
    </style>
</head>
<body>
    <!-- 상단 고정 메뉴바 -->
    <div class="menu-bar">
        <a href="/admin/status.html" class="brand-logo">장군반점</a>
        <div class="menu-items">
            <a href="/admin/status.html" class="menu-item active">전체 현황</a>
            <a href="/admin/menu.html?action=stat" class="menu-item">메뉴 관리</a>
            <a href="/admin/table.html?action=stat" class="menu-item">테이블 관리</a>
        </div>
    </div>
    
    <div class="container">
        <h1>🏮 전체 주문 현황 🏮</h1>
        
        <c:choose>
            <c:when test="${empty tables}">
                <p class="empty-order">등록된 테이블이 없습니다.</p>
            </c:when>
            <c:otherwise>
                <c:forEach items="${tables}" var="table">
                    <div class="table-section">
                        <div class="table-header">
                            <span class="table-id">테이블: ${table.tid}</span>
                        </div>
                        
                        <c:choose>
                            <c:when test="${empty orders[table.tid] or empty orders[table.tid].items}">
                                <p class="empty-order">주문 내역이 없습니다.</p>
                            </c:when>
                            <c:otherwise>
                                <table>
                                    <thead>
                                        <tr>
                                            <th>메뉴</th>
                                            <th>단가</th>
                                            <th>수량</th>
                                            <th>금액</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${orders[table.tid].items}" var="item">
                                            <tr>
                                                <td>${item.menu}</td>
                                                <td>${item.price}원</td>
                                                <td>${item.num}개</td>
                                                <td>${item.total}원</td>
                                            </tr>
                                        </c:forEach>
                                        <tr class="total-row">
                                            <td colspan="3">총 합계</td>
                                            <td class="total-amount">${orders[table.tid].total}원</td>
                                        </tr>
                                    </tbody>
                                </table>
                                <c:if test="${not empty orders[table.tid] and not empty orders[table.tid].items}">
                                    <div class="checkout-container">
                                        <a href="/admin/checkout.html?tid=${table.tid}" class="checkout-btn">
                                            결제하기
                                        </a>
                                    </div>
                                </c:if>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </div>
</body>
</html>

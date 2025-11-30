<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>관리자 현황</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Noto+Serif+KR:wght@400;700&display=swap');
        
        body {
            font-family: 'Noto Serif KR', serif;
            max-width: 1400px;
            margin: 0 auto;
            padding: 20px;
            background: linear-gradient(135deg, #8B0000 0%, #DC143C 50%, #8B0000 100%);
            background-attachment: fixed;
            min-height: 100vh;
            position: relative;
        }
        
        body::before {
            content: '';
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-image: 
                repeating-linear-gradient(45deg, transparent, transparent 35px, rgba(255,215,0,0.05) 35px, rgba(255,215,0,0.05) 70px);
            pointer-events: none;
            z-index: 0;
        }
        
        .container {
            background: linear-gradient(to bottom, #FFF9E6 0%, #FFFEF7 100%);
            border-radius: 15px;
            padding: 30px;
            box-shadow: 0 15px 50px rgba(0,0,0,0.4), 
                        inset 0 0 30px rgba(255,215,0,0.1);
            border: 3px solid #DAA520;
            position: relative;
            z-index: 1;
        }
        
        .container::before {
            content: '🐉';
            position: absolute;
            top: -15px;
            left: 50%;
            transform: translateX(-50%);
            font-size: 30px;
            background: #8B0000;
            padding: 10px 20px;
            border-radius: 50px;
            border: 2px solid #DAA520;
        }
        
        h1 {
            color: #8B0000;
            text-align: center;
            font-size: 32px;
            font-weight: 700;
            border-bottom: 3px double #DAA520;
            padding-bottom: 15px;
            margin-bottom: 30px;
            text-shadow: 2px 2px 4px rgba(218,165,32,0.3);
            letter-spacing: 2px;
        }
        
        .table-section {
            margin-bottom: 40px;
            padding: 25px;
            background: linear-gradient(135deg, #FFF 0%, #FFF9E6 100%);
            border-radius: 12px;
            border: 2px solid #DAA520;
            box-shadow: 0 5px 15px rgba(139,0,0,0.2);
            position: relative;
        }
        
        .table-section::before {
            content: '🏮';
            position: absolute;
            top: -12px;
            left: 20px;
            font-size: 24px;
        }
        
        .table-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
            padding-bottom: 10px;
            border-bottom: 2px dashed #DAA520;
        }
        
        .table-id {
            font-size: 24px;
            font-weight: bold;
            color: #8B0000;
            text-shadow: 1px 1px 2px rgba(218,165,32,0.3);
        }
        
        .checkout-btn {
            padding: 12px 25px;
            background: linear-gradient(135deg, #DC143C 0%, #8B0000 100%);
            color: #FFD700;
            border: 2px solid #DAA520;
            border-radius: 8px;
            cursor: pointer;
            text-decoration: none;
            font-weight: bold;
            transition: all 0.3s;
            box-shadow: 0 4px 10px rgba(139,0,0,0.3);
            font-size: 15px;
        }
        
        .checkout-btn:hover {
            background: linear-gradient(135deg, #8B0000 0%, #DC143C 100%);
            transform: translateY(-2px);
            box-shadow: 0 6px 15px rgba(139,0,0,0.4);
        }
        
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
            background: white;
            border: 1px solid #DAA520;
        }
        
        th, td {
            padding: 14px;
            text-align: left;
            border-bottom: 1px solid #F0E68C;
        }
        
        th {
            background: linear-gradient(135deg, #8B0000 0%, #DC143C 100%);
            color: #FFD700;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 1px;
            border-bottom: 2px solid #DAA520;
        }
        
        tr:hover {
            background-color: #FFF9E6;
        }
        
        .total-row {
            background: linear-gradient(135deg, #FFD700 0%, #FFA500 100%);
            font-weight: bold;
            font-size: 17px;
            border-top: 3px double #8B0000;
        }
        
        .total-amount {
            color: #8B0000;
            font-size: 20px;
            font-weight: 900;
            text-shadow: 1px 1px 2px rgba(218,165,32,0.3);
        }
        
        .empty-order {
            color: #999;
            font-style: italic;
            padding: 30px;
            text-align: center;
            background: #FFF9E6;
            border-radius: 8px;
            border: 2px dashed #DAA520;
        }
        
        .finished-badge {
            display: inline-block;
            padding: 6px 12px;
            background: linear-gradient(135deg, #228B22 0%, #32CD32 100%);
            color: white;
            border-radius: 20px;
            font-size: 12px;
            margin-left: 10px;
            border: 1px solid #006400;
            font-weight: bold;
        }
    </style>
</head>
<body>
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
                            <div>
                                <span class="table-id">테이블: ${table.tid}</span>
                                <c:if test="${orders[table.tid].finished}">
                                    <span class="finished-badge">주문확정</span>
                                </c:if>
                            </div>
                            <c:if test="${not empty orders[table.tid] and not empty orders[table.tid].items}">
                                <a href="/admin/checkout.html?tid=${table.tid}" class="checkout-btn">
                                    💳 결제하기
                                </a>
                            </c:if>
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
                            </c:otherwise>
                        </c:choose>
                    </div>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </div>
</body>
</html>


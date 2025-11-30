<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>주문 현황 - ${tid}</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Noto+Serif+KR:wght@400;700&display=swap');
        
        body {
            font-family: 'Noto Serif KR', serif;
            max-width: 900px;
            margin: 0 auto;
            padding: 20px;
            background: linear-gradient(135deg, #8B0000 0%, #DC143C 50%, #8B0000 100%);
            background-attachment: fixed;
            min-height: 100vh;
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
        }
        
        .container {
            background: linear-gradient(to bottom, #FFF9E6 0%, #FFFEF7 100%);
            border-radius: 15px;
            padding: 40px;
            box-shadow: 0 15px 50px rgba(0,0,0,0.4);
            border: 3px solid #DAA520;
            position: relative;
            z-index: 1;
        }
        
        .container::before {
            content: '🥢';
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
        
        .table-info {
            background: linear-gradient(135deg, #8B0000 0%, #DC143C 100%);
            color: #FFD700;
            padding: 20px 30px;
            border-radius: 12px;
            font-size: 22px;
            font-weight: bold;
            margin-bottom: 30px;
            text-align: center;
            border: 3px solid #DAA520;
            box-shadow: 0 5px 15px rgba(139,0,0,0.3);
        }
        
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            border: 2px solid #DAA520;
            background: white;
        }
        
        th, td {
            padding: 15px;
            text-align: left;
            border-bottom: 1px solid #F0E68C;
        }
        
        th {
            background: linear-gradient(135deg, #8B0000 0%, #DC143C 100%);
            color: #FFD700;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 1px;
        }
        
        tr:hover {
            background-color: #FFF9E6;
        }
        
        .total-row {
            background: linear-gradient(135deg, #FFD700 0%, #FFA500 100%);
            font-weight: bold;
            font-size: 18px;
            border-top: 3px double #8B0000;
        }
        
        .total-amount {
            color: #8B0000;
            font-size: 22px;
            font-weight: 900;
            text-shadow: 1px 1px 2px rgba(218,165,32,0.3);
        }
        
        .empty-order {
            text-align: center;
            color: #999;
            padding: 60px 20px;
            font-size: 20px;
            background: #FFF9E6;
            border: 2px dashed #DAA520;
            border-radius: 10px;
        }
        
        .status-badge {
            display: inline-block;
            padding: 8px 16px;
            border-radius: 25px;
            font-size: 14px;
            font-weight: bold;
            margin-left: 15px;
            border: 2px solid;
        }
        
        .finished {
            background: linear-gradient(135deg, #228B22 0%, #32CD32 100%);
            color: white;
            border-color: #006400;
        }
        
        .pending {
            background: linear-gradient(135deg, #FF8C00 0%, #FFA500 100%);
            color: white;
            border-color: #CC7000;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>🏮 주문 현황 🏮</h1>
        
        <div class="table-info">
            🪑 테이블: ${tid}
            <c:choose>
                <c:when test="${order.finished}">
                    <span class="status-badge finished">✓ 주문확정 완료</span>
                </c:when>
                <c:otherwise>
                    <span class="status-badge pending">⏳ 주문 진행중</span>
                </c:otherwise>
            </c:choose>
        </div>
        
        <c:choose>
            <c:when test="${empty order.items}">
                <div class="empty-order">
                    🛒 주문 내역이 없습니다.<br>
                    <small style="color: #999; margin-top: 15px; display: block;">맛있는 요리를 주문해주세요!</small>
                </div>
            </c:when>
            <c:otherwise>
                <table>
                    <thead>
                        <tr>
                            <th>🍜 메뉴</th>
                            <th>💰 단가</th>
                            <th>📦 수량</th>
                            <th>💵 금액</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${order.items}" var="item">
                            <tr>
                                <td>${item.menu}</td>
                                <td>${item.price}원</td>
                                <td>${item.num}개</td>
                                <td>${item.total}원</td>
                            </tr>
                        </c:forEach>
                        <tr class="total-row">
                            <td colspan="3">💴 총 합계</td>
                            <td class="total-amount">${order.total}원</td>
                        </tr>
                    </tbody>
                </table>
            </c:otherwise>
        </c:choose>
    </div>
</body>
</html>

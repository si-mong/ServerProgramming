<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>테이블 관리</title>
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

        table {
            width: 100%;
            border-collapse: collapse;
            background: white;
            border: 2px solid #DAA520;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }
        
        th, td {
            padding: 15px;
            text-align: left;
            border-bottom: 1px solid #eee;
        }
        
        th {
            background: linear-gradient(to bottom, #8B0000, #600000);
            color: #FFD700;
            font-weight: 500;
            text-transform: uppercase;
            border: 1px solid #600000;
        }
        
        td {
            border-left: 1px solid #eee;
            border-right: 1px solid #eee;
            color: #333;
        }
        
        .back-link {
            display: inline-block;
            margin-top: 40px;
            padding: 12px 30px;
            background: #8B0000;
            color: #FFD700;
            text-decoration: none;
            border-radius: 4px;
            transition: all 0.3s;
            font-weight: 700;
            border: 2px solid #DAA520;
            box-shadow: 0 4px 10px rgba(0,0,0,0.2);
        }
        
        .back-link:hover {
            background: #600000;
            transform: translateY(-2px);
            box-shadow: 0 6px 15px rgba(0,0,0,0.3);
        }
        
        .empty-state {
            text-align: center;
            color: #888;
            padding: 60px;
            background: white;
            border: 2px dashed #DAA520;
            font-style: italic;
            border-radius: 8px;
        }
    </style>
</head>
<body>
    <!-- 상단 고정 메뉴바 -->
    <div class="menu-bar">
        <a href="/admin/status.html" class="brand-logo">장군반점</a>
        <div class="menu-items">
            <a href="/admin/status.html" class="menu-item">전체 현황</a>
            <a href="/admin/menu.html?action=stat" class="menu-item">메뉴 관리</a>
            <a href="/admin/table.html?action=stat" class="menu-item active">테이블 관리</a>
        </div>
    </div>
    
    <div class="container">
        <h1>🏮 테이블 현황 🏮</h1>
        
        <c:choose>
            <c:when test="${empty tables}">
                <p class="empty-state">등록된 테이블이 없습니다.</p>
            </c:when>
            <c:otherwise>
                <table>
                    <thead>
                        <tr>
                            <th>테이블 번호</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${tables}" var="table">
                            <tr>
                                <td>${table.tid}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:otherwise>
        </c:choose>
        
        <a href="/admin/status.html" class="back-link">관리자 현황으로</a>
    </div>
</body>
</html>

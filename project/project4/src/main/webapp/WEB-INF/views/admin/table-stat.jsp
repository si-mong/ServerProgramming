<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>테이블 관리</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Noto+Serif+KR:wght@400;700&display=swap');
        
        body {
            font-family: 'Noto Serif KR', serif;
            max-width: 1200px;
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
            content: '🪑';
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
        
        .table-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(180px, 1fr));
            gap: 20px;
            margin-top: 30px;
        }
        
        .table-card {
            background: linear-gradient(135deg, #8B0000 0%, #DC143C 100%);
            color: #FFD700;
            padding: 30px 20px;
            border-radius: 12px;
            text-align: center;
            font-weight: bold;
            font-size: 22px;
            box-shadow: 0 6px 20px rgba(139,0,0,0.4);
            transition: all 0.3s;
            border: 3px solid #DAA520;
            position: relative;
        }
        
        .table-card::before {
            content: '🏮';
            position: absolute;
            top: -15px;
            left: 50%;
            transform: translateX(-50%);
            font-size: 24px;
        }
        
        .table-card:hover {
            transform: translateY(-10px) scale(1.05);
            box-shadow: 0 10px 30px rgba(139,0,0,0.6);
        }
        
        .back-link {
            display: inline-block;
            margin-top: 30px;
            padding: 12px 30px;
            background: linear-gradient(135deg, #DAA520 0%, #FFD700 100%);
            color: #8B0000;
            text-decoration: none;
            border-radius: 8px;
            transition: all 0.3s;
            border: 2px solid #8B0000;
            font-weight: bold;
            box-shadow: 0 4px 10px rgba(139,0,0,0.3);
        }
        
        .back-link:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 15px rgba(139,0,0,0.4);
        }
        
        .empty-state {
            text-align: center;
            color: #999;
            padding: 60px;
            background: #FFF9E6;
            border: 2px dashed #DAA520;
            border-radius: 10px;
            font-size: 18px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>🏮 테이블 현황 🏮</h1>
        
        <c:choose>
            <c:when test="${empty tables}">
                <p class="empty-state">등록된 테이블이 없습니다.</p>
            </c:when>
            <c:otherwise>
                <div class="table-grid">
                    <c:forEach items="${tables}" var="table">
                        <div class="table-card">
                            ${table.tid}
                        </div>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>
        
        <a href="/admin/status.html" class="back-link">🏠 관리자 현황으로</a>
    </div>
</body>
</html>

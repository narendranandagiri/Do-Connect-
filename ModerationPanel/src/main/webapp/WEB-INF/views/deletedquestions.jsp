<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Deleted Questions</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --black: #000000;
            --dark-gray: #1f1f1f;
            --teal: #1dd1a1;
            --green: #10ac84;
            --red: #ff4d4d;
            --glass: rgba(255, 255, 255, 0.03);
            --shadow: rgba(0, 0, 0, 0.2);
            --radius: 10px;
            --transition: all 0.3s ease;
            --font: 'Inter', sans-serif;
        }

        body {
            font-family: var(--font);
            background: var(--black);
            margin: 0;
            padding: 2rem;
            color: #fff;
            animation: fadeIn 0.5s ease-in;
        }

        .page-container {
            max-width: 1000px;
            margin: auto;
            background: var(--glass);
            backdrop-filter: blur(15px);
            padding: 2rem;
            border-radius: var(--radius);
            box-shadow: 0 8px 20px var(--shadow);
        }

        h2 {
            color: var(--teal);
            text-align: center;
        }

        .message {
            text-align: center;
            color: var(--green);
            font-weight: bold;
            margin: 1rem 0;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 1rem;
            background: rgba(255, 255, 255, 0.05);
            border-radius: var(--radius);
            overflow: hidden;
            box-shadow: 0 4px 10px var(--shadow);
        }

        table thead {
            background: var(--dark-gray);
        }

        th, td {
            padding: 1rem;
            border-bottom: 1px solid #333;
            text-align: left;
        }

        th {
            font-weight: 600;
            color: var(--teal);
        }

        tbody tr:hover {
            background: rgba(255, 255, 255, 0.05);
        }

        .back-link {
            display: block;
            text-align: center;
            margin-top: 2rem;
            color: var(--teal);
            text-decoration: none;
            font-weight: 600;
        }

        .back-link:hover {
            text-shadow: 0 0 5px var(--teal);
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }
    </style>
</head>
<body>
    <div class="page-container">
        <h2>🗑️ Deleted Questions</h2>
        <c:choose>
            <c:when test="${not empty deletedQuestions}">
                <table>
                    <thead>
                        <tr>
                            <th>Title</th>
                            <th>Content</th>
                            <th>Topic</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="q" items="${deletedQuestions}">
                            <tr>
                                <td>${q.title}</td>
                                <td>${q.content}</td>
                                <td>${q.topic}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:when>
            <c:otherwise>
                <p class="message">No deleted questions yet.</p>
            </c:otherwise>
        </c:choose>
        <a class="back-link" href="/moderation/dashboard">⬅ Back to Dashboard</a>
    </div>
</body>
</html>

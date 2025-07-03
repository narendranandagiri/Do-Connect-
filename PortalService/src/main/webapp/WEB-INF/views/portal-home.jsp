<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>User Dashboard - DoConnect</title>

    <!-- Font -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap" rel="stylesheet">

    <style>
        :root {
            --black: #000;
            --teal: #1dd1a1;
            --green: #10ac84;
            --red: #ff4d4d;
            --glass: rgba(255, 255, 255, 0.03);
            --shadow: rgba(0, 0, 0, 0.2);
            --radius: 10px;
            --font: 'Inter', sans-serif;
            --transition: all 0.3s ease;
        }

        body {
            font-family: var(--font);
            background: var(--black);
            color: white;
            margin: 0;
            padding: 2rem;
            animation: fadeIn 0.4s ease-in;
        }

        .dashboard-container {
            max-width: 600px;
            margin: auto;
            background: var(--glass);
            backdrop-filter: blur(10px);
            padding: 2rem;
            border-radius: var(--radius);
            box-shadow: 0 8px 20px var(--shadow);
            text-align: center;
        }

        h2 {
            color: var(--teal);
            margin-bottom: 2rem;
        }

        .dashboard-actions ul {
            list-style: none;
            padding: 0;
        }

        .dashboard-actions li {
            margin: 1rem 0;
        }

        .dashboard-actions a {
            display: inline-block;
            background: #1a1a1a;
            color: var(--teal);
            padding: 12px 20px;
            border-radius: var(--radius);
            text-decoration: none;
            font-weight: 600;
            transition: var(--transition);
            box-shadow: 0 4px 10px var(--shadow);
        }

        .dashboard-actions a:hover {
            background: var(--teal);
            color: #000;
            transform: scale(1.03);
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }

        @media (max-width: 600px) {
            .dashboard-container {
                padding: 1.5rem;
            }

            .dashboard-actions a {
                padding: 10px 16px;
                font-size: 0.95rem;
            }
        }
    </style>
</head>
<body>

<div class="dashboard-container">
    <h2>Welcome, <c:out value="${user.username}" /> 👋</h2>

    <div class="dashboard-actions">
        <ul>
            <li><a href="/portal/${user.id}/questions/ask">📝 Ask a Question</a></li>
            <li><a href="/portal/questionList">📋 View All Questions</a></li>
            <li><a href="/portal/questionSearch">🔍 Search Questions</a></li>
            <li><a href="/portal/logout">🚪 Logout</a></li>
        </ul>
    </div>
</div>

</body>
</html>

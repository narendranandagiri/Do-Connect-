<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard - DoConnect</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap" rel="stylesheet">

    <style>
        :root {
            --black: #000000;
            --dark-gray: #1f1f1f;
            --teal: #1dd1a1;
            --green: #10ac84;
            --red: #ff4d4d;
            --gray: #576574;
            --glass: rgba(255, 255, 255, 0.06);
            --shadow: rgba(0, 0, 0, 0.2);
            --radius: 12px;
            --transition: all 0.3s ease;
            --font: 'Inter', sans-serif;
        }

        body {
            margin: 0;
            padding: 0;
            font-family: var(--font);
            background: var(--black);
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
            animation: fadeIn 1s ease-in;
        }

        .dashboard-container {
            max-width: 1000px;
            width: 95%;
            background: var(--glass);
            backdrop-filter: blur(15px);
            padding: 2rem;
            border-radius: var(--radius);
            box-shadow: 0 10px 25px var(--shadow);
            text-align: center;
        }

        .dashboard-title {
            color: var(--teal);
            font-size: 2rem;
            margin-bottom: 2rem;
        }

        .control-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(160px, 1fr));
            gap: 2rem;
            justify-items: center;
        }

        .control-link {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            width: 160px;
            height: 160px;
            border-radius: 50%;
            background: linear-gradient(135deg, var(--teal), var(--green));
            text-decoration: none;
            color: white;
            font-weight: bold;
            box-shadow: 0 6px 20px var(--shadow);
            transition: var(--transition);
            animation: popIn 0.6s ease forwards;
        }

        .control-link:hover {
            transform: scale(1.07);
            background: linear-gradient(135deg, var(--green), var(--teal));
            box-shadow: 0 0 15px var(--teal);
        }

        .logout-btn {
            margin-top: 2.5rem;
            padding: 12px 30px;
            background: var(--red);
            border: none;
            border-radius: var(--radius);
            color: white;
            font-weight: bold;
            cursor: pointer;
            transition: var(--transition);
            box-shadow: 0 5px 12px var(--shadow);
        }

        .logout-btn:hover {
            background: #ff6b6b;
            transform: scale(1.05);
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: scale(0.95); }
            to { opacity: 1; transform: scale(1); }
        }

        @keyframes popIn {
            from { opacity: 0; transform: scale(0.8); }
            to { opacity: 1; transform: scale(1); }
        }

        @media (max-width: 500px) {
            .control-link {
                width: 120px;
                height: 120px;
                font-size: 0.85rem;
            }
        }
    </style>
</head>
<body>

<div class="dashboard-container">
    <div class="dashboard-title">Welcome Admin 👋</div>

    <div class="control-grid">
        <a href="/moderation/users" class="control-link">Manage Users</a>
        <a href="/moderation/questions" class="control-link">Manage Questions</a>
        <a href="/moderation/answers" class="control-link">Manage Answers</a>
        <a href="/moderation/comments" class="control-link">Manage Comments</a>
    </div>

    <form action="/moderation/logout" method="get">
        <button class="logout-btn">🚪 Logout</button>
    </form>
</div>

</body>
</html>

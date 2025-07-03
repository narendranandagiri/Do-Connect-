<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Manage Questions - DoConnect</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap" rel="stylesheet">

    <style>
        :root {
            --black: #000000;
            --dark-gray: #1f1f1f;
            --teal: #1dd1a1;
            --green: #10ac84;
            --red: #ff4d4d;
            --orange: #ffa502;
            --gray: #576574;
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

        .moderation-container {
            max-width: 1200px;
            margin: auto;
            background: var(--glass);
            backdrop-filter: blur(15px);
            padding: 2rem;
            border-radius: var(--radius);
            box-shadow: 0 8px 20px var(--shadow);
        }

        .top-nav {
            display: flex;
            justify-content: space-between;
            margin-bottom: 1.5rem;
        }

        .top-nav a {
            color: var(--teal);
            text-decoration: none;
            font-weight: bold;
            padding: 6px 14px;
            background: rgba(255, 255, 255, 0.05);
            border-radius: var(--radius);
            transition: var(--transition);
        }

        .top-nav a:hover {
            background: var(--teal);
            color: black;
        }

        h2, h3 {
            color: var(--teal);
            text-align: center;
        }

        h3 {
            color: var(--green);
            margin-top: 2.5rem;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 1rem;
            background: rgba(255, 255, 255, 0.04);
            border-radius: var(--radius);
            overflow: hidden;
            box-shadow: 0 4px 10px var(--shadow);
        }

        thead {
            background: var(--dark-gray);
        }

        th, td {
            padding: 1rem;
            border-bottom: 1px solid #333;
            text-align: left;
            vertical-align: top;
        }

        th {
            font-weight: 600;
            color: var(--teal);
        }

        tbody tr:hover {
            background: rgba(255, 255, 255, 0.05);
        }

        button {
            padding: 8px 12px;
            border: none;
            border-radius: var(--radius);
            font-weight: bold;
            cursor: pointer;
            transition: var(--transition);
            color: white;
            margin: 2px;
        }

        .btn-approve { background: var(--green); }
        .btn-unapprove { background: var(--orange); }
        .btn-resolve { background: var(--teal); }
        .btn-deactivate { background: var(--gray); }
        .btn-delete { background: var(--red); }

        button:hover {
            transform: scale(1.03);
            filter: brightness(1.1);
        }

        form {
            display: inline;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }

        @media (max-width: 768px) {
            th, td {
                font-size: 0.85rem;
                padding: 0.75rem;
            }

            button {
                font-size: 0.8rem;
                padding: 6px 10px;
            }

            .moderation-container {
                padding: 1.2rem;
            }
        }
    </style>
</head>
<body>
<div class="moderation-container">

    <!-- 🔝 Top Navigation -->
    <div class="top-nav">
        <a href="/moderation/dashboard">← Back to Dashboard</a>
        <a href="/moderation/logout">Logout</a>
    </div>

    <h2>Question management</h2>

    <!-- ❓ Unapproved Questions -->
    <h3>Unapproved Questions</h3>
    <table>
        <thead>
        <tr>
            <th>ID</th>
            <th>Title</th>
            <th>Content</th>
            <th>Posted By</th>
            <th>Action</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="q" items="${unapprovedQuestions}">
            <tr>
                <td>${q.id}</td>
                <td>${q.title}</td>
                <td>${q.content}</td>
                <td>${q.userId}</td>
                <td>
                    <form method="post" action="/moderation/questions/approve/${q.id}">
                        <button type="submit" class="btn-approve">✅ Approve</button>
                    </form>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <!-- ✅ Approved Questions -->
    <h3>Approved Questions</h3>
    <table>
        <thead>
        <tr>
            <th>ID</th>
            <th>Title</th>
            <th>Content</th>
            <th>Posted By</th>
            <th>Status</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="q" items="${approvedQuestions}">
            <tr>
                <td>${q.id}</td>
                <td>${q.title}</td>
                <td>${q.content}</td>
                <td>${q.userId}</td>
                <td>✅ Approved</td>
                <td>
                    <form method="post" action="/moderation/questions/unapprove/${q.id}">
                        <button type="submit" class="btn-unapprove">❌ Unapprove</button>
                    </form>
                    <form method="post" action="/moderation/questions/resolve/${q.id}">
                        <button type="submit" class="btn-resolve">✔️ Resolve</button>
                    </form>
                    <form method="post" action="/moderation/questions/delete/${q.id}" onsubmit="return confirm('Are you sure you want to delete this question?');">
                        <button type="submit" class="btn-delete">🗑 Delete</button>
                    </form>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <!-- 🟩 Resolved Questions -->
    <h3>Resolved Questions</h3>
    <table>
        <thead>
        <tr>
            <th>ID</th>
            <th>Title</th>
            <th>Content</th>
            <th>Posted By</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="q" items="${resolvedQuestions}">
            <tr>
                <td>${q.id}</td>
                <td>${q.title}</td>
                <td>${q.content}</td>
                <td>${q.userId}</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

</div>
</body>
</html>

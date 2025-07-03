<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Manage Answers - DoConnect</title>

    <!-- Font -->
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

        .top-nav {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1rem;
        }

        .top-nav a {
            color: var(--teal);
            font-weight: bold;
            text-decoration: none;
        }

        .top-nav a.logout {
            color: var(--red);
        }

        .page-title {
            text-align: center;
            color: var(--teal);
            margin-bottom: 2rem;
            font-size: 1.8rem;
        }

        h3 {
            color: var(--green);
            margin-top: 2rem;
        }

        table.data-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 1rem;
            background: rgba(255, 255, 255, 0.05);
            border-radius: var(--radius);
            overflow: hidden;
            box-shadow: 0 4px 10px var(--shadow);
        }

        table.data-table thead {
            background: var(--dark-gray);
        }

        table.data-table th, table.data-table td {
            padding: 1rem;
            text-align: left;
            border-bottom: 1px solid #333;
        }

        table.data-table th {
            font-weight: 600;
            color: var(--teal);
        }

        table.data-table tbody tr:hover {
            background: rgba(255, 255, 255, 0.05);
        }

        button {
            padding: 8px 14px;
            border: none;
            border-radius: var(--radius);
            font-weight: bold;
            cursor: pointer;
            transition: var(--transition);
            color: #fff;
        }

        .btn-approve {
            background: var(--green);
        }

        .btn-approve:hover {
            background: var(--teal);
            transform: scale(1.03);
        }

        .btn-unapprove {
            background: #ffa502;
        }

        .btn-unapprove:hover {
            background: #ffc048;
            transform: scale(1.03);
        }

        .btn-delete {
            background: var(--red);
            margin-left: 5px;
        }

        .btn-delete:hover {
            background: #ff6b6b;
            transform: scale(1.03);
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }

        @media (max-width: 768px) {
            table.data-table th, table.data-table td {
                font-size: 0.85rem;
                padding: 0.75rem;
            }

            .page-container {
                padding: 1.2rem;
            }

            button {
                font-size: 0.85rem;
                padding: 6px 10px;
            }
        }
    </style>
</head>
<body>
<div class="page-container">

    <div class="top-nav">
        <a href="/moderation/dashboard">← Back to Dashboard</a>
        <a href="/moderation/logout" class="logout">Logout</a>
    </div>

    <h2 class="page-title">Manage Answers</h2>

    <!-- 🔴 Unapproved Answers -->
    <h3>Unapproved Answers</h3>
    <table class="data-table">
        <thead>
        <tr>
            <th>ID</th>
            <th>Content</th>
            <th>Likes</th>
            <th>Question ID</th>
            <th>User ID</th>
            <th>Action</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="a" items="${unapprovedAnswers}">
            <tr>
                <td>${a.id}</td>
                <td>${a.content}</td>
                <td>${a.likes}</td>
                <td>${a.questionId}</td>
                <td>${a.userId}</td>
                <td>
                    <form method="post" action="/moderation/answers/approve/${a.id}">
                        <button type="submit" class="btn-approve">Approve</button>
                    </form>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <!-- 🟢 Approved Answers -->
    <h3>Approved Answers</h3>
    <table class="data-table">
        <thead>
        <tr>
            <th>ID</th>
            <th>Content</th>
            <th>Likes</th>
            <th>Question ID</th>
            <th>User ID</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="a" items="${approvedAnswers}">
            <tr>
                <td>${a.id}</td>
                <td>${a.content}</td>
                <td>${a.likes}</td>
                <td>${a.questionId}</td>
                <td>${a.userId}</td>
                <td>
                    <form method="post" action="/moderation/answers/unapprove/${a.id}" style="display:inline;">
                        <button type="submit" class="btn-unapprove">Unapprove</button>
                    </form>
                    <form method="post" action="/moderation/answers/delete/${a.id}" style="display:inline;" onsubmit="return confirm('Are you sure you want to delete this answer?');">
                        <button type="submit" class="btn-delete">Delete</button>
                    </form>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
</body>
</html>

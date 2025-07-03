<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Manage Comments - DoConnect</title>

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

        h2, h3 {
            color: var(--teal);
            text-align: center;
        }

        h3 {
            margin-top: 2rem;
            color: var(--green);
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

        @media (max-width: 768px) {
            th, td {
                font-size: 0.85rem;
                padding: 0.75rem;
            }

            button {
                font-size: 0.85rem;
                padding: 6px 10px;
            }
            
            .top-nav {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 2rem;
}

.top-nav a {
    color: var(--teal);
    text-decoration: none;
    font-weight: 600;
    transition: var(--transition);
}

.top-nav a:hover {
    text-shadow: 0 0 5px var(--teal);
}
            

            .page-container {
                padding: 1.2rem;
            }
        }
    </style>
</head>
<body>
<div class="page-container">

<div class="page-container">

    <!-- 🔝 Top Navigation -->
    <div style="display: flex; justify-content: space-between; margin-bottom: 1rem;">
        <a href="/moderation/dashboard" style="color: var(--teal); font-weight: bold; text-decoration: none;">← Back to Dashboard</a>
        <a href="/moderation/logout" style="color: var(--teal); font-weight: bold; text-decoration: none;">Logout</a>
    </div>

    <h2>Manage Comments</h2>

    <!-- ✅ Flash Message -->
    <c:if test="${not empty message}">
        <div class="message">${message}</div>
    </c:if>

    <!-- 🔴 Unapproved Comments -->
    <h3>Unapproved Comments</h3>
    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Content</th>
                <th>Commented By</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="c" items="${unapprovedComments}">
                <tr>
                    <td>${c.id}</td>
                    <td>${c.content}</td>
                    <td>${c.commentedBy}</td>
                    <td>
                        <form method="post" action="/moderation/comments/approve/${c.id}">
                            <button type="submit" class="btn-approve">Approve</button>
                        </form>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>

    <!-- 🟢 Approved Comments -->
    <h3>Approved Comments</h3>
    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Content</th>
                <th>Commented By</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
           <c:forEach var="c" items="${approvedComments}">
    <tr>
        <td>${c.id}</td>
        <td>${c.content}</td>
        <td>${c.commentedBy}</td>
        <td>
            <form method="post" action="/moderation/comments/unapprove/${c.id}" style="display:inline;">
                <button type="submit" class="btn-unapprove">Unapprove</button>
            </form>

            <form method="post" action="/moderation/comments/delete/${c.id}" style="display:inline;">
                <button type="submit" class="btn-delete" onclick="return confirm('Delete this comment?');">🗑 Delete</button>
            </form>
        </td>
    </tr>
</c:forEach>

        </tbody>
    </table>

    <!-- ✅ Back to Dashboard Link -->
    <a href="/moderation/dashboard" class="back-link">← Back to Dashboard</a>
</div>
</body>
</html>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Manage Users</title>

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

        h2 {
            text-align: center;
            color: var(--teal);
            margin-bottom: 2rem;
        }

        table {
            width: 90%;
            margin: auto;
            border-collapse: collapse;
            background: rgba(255, 255, 255, 0.05);
            border-radius: var(--radius);
            overflow: hidden;
            box-shadow: 0 4px 10px var(--shadow);
        }

        th, td {
            padding: 1rem;
            border-bottom: 1px solid #333;
            text-align: center;
        }

        thead {
            background: var(--dark-gray);
        }

        th {
            font-weight: 600;
            color: var(--teal);
        }

        tbody tr:hover {
            background: rgba(255, 255, 255, 0.05);
        }

        .action-form {
            display: inline-block;
            margin-top: 5px;
        }

        button {
            padding: 8px 14px;
            border: none;
            border-radius: var(--radius);
            font-weight: bold;
            cursor: pointer;
            transition: var(--transition);
            color: white;
        }

        .btn-deactivate {
            background: var(--red);
        }

        .btn-deactivate:hover {
            background: #ff6b6b;
            transform: scale(1.03);
        }

        .btn-activate {
            background: var(--green);
        }

        .btn-activate:hover {
            background: var(--teal);
            transform: scale(1.03);
        }

        a {
            color: var(--teal);
            text-decoration: none;
            font-weight: 600;
        }

        a:hover {
            text-shadow: 0 0 5px var(--teal);
        }

        .back-link {
            text-align: center;
            margin-top: 2rem;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }

        @media (max-width: 768px) {
            table, th, td {
                font-size: 0.85rem;
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
          
            button {
                font-size: 0.85rem;
                padding: 6px 10px;
            }
        }
    </style>
</head>
<body>
 <div class="top-nav">
    <a href="/moderation/dashboard">← Back to Dashboard</a>
    <a href="/moderation/logout">Logout</a>
</div>
 
<h2>👤 User Management</h2>

<table>
    <thead>
    <tr>
        <th>ID</th>
        <th>Username</th>
        <th>Email</th>
        <th>Role</th>
        <th>Status</th>
        <th>Action</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="user" items="${users}">
        <tr>
            <td>${user.id}</td>
            <td>${user.username}</td>
            <td>${user.email}</td>
            
            <td>
                <c:choose>
                    <c:when test="${user.active}">✅ Active</c:when>
                    <c:otherwise>❌ Inactive</c:otherwise>
                </c:choose>
            </td>
            <td>
                <c:choose>
                    <c:when test="${user.active}">
                        <form method="post" action="/moderation/users/deactivate/${user.id}" class="action-form">
                            <button type="submit" class="btn-deactivate">Deactivate</button>
                        </form>
                    </c:when>
                    <c:otherwise>
                        <form method="post" action="/moderation/users/activate/${user.id}" class="action-form">
                            <button type="submit" class="btn-activate">Activate</button>
                        </form>
                    </c:otherwise>
                </c:choose>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>

<div class="back-link">
    <br/>
    <a href="/moderation/dashboard">← Back to Dashboard</a>
</div>

</body>
</html>

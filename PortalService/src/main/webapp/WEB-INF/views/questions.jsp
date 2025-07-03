<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>All Questions</title>

    <!-- Font -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap" rel="stylesheet">

    <style>
        :root {
            --black: #000;
            --teal: #1dd1a1;
            --green: #10ac84;
            --red: #ff4d4d;
            --orange: #ffa502;
            --gray: #cccccc;
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

        h1 {
            color: var(--teal);
            text-align: center;
            margin-bottom: 2rem;
        }

        .question-card {
            background: var(--glass);
            backdrop-filter: blur(10px);
            padding: 1.5rem;
            border-radius: var(--radius);
            box-shadow: 0 4px 12px var(--shadow);
            margin-bottom: 1.5rem;
        }

        .question-card a {
            color: var(--teal);
            font-weight: bold;
            text-decoration: none;
            font-size: 1.1rem;
        }

        .question-card a:hover {
            text-shadow: 0 0 6px var(--teal);
        }

        .status {
            font-weight: 600;
        }

        .status span {
            margin-right: 1rem;
        }

        .status .approved {
            color: var(--green);
        }

        .status .pending {
            color: var(--orange);
        }

        .status .resolved {
            color: var(--teal);
        }

        .status .unresolved {
            color: var(--red);
        }

        a.back-link {
            display: block;
            text-align: center;
            color: var(--teal);
            font-weight: 600;
            margin-top: 2rem;
            text-decoration: none;
        }

        a.back-link:hover {
            text-shadow: 0 0 5px var(--teal);
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }

        @media (max-width: 768px) {
            .question-card {
                padding: 1rem;
            }

            .question-card a {
                font-size: 1rem;
            }
        }
    </style>
</head>
<body>

<h1>All Questions</h1>

<c:forEach var="question" items="${questions}">
    <div class="question-card">
        <p><strong>Title:</strong>
            <a href="/portal/questions/${question.id}">${question.title}</a>
        </p>
        <p><strong>Posted By:</strong> ${question.postedBy}</p>
        <p class="status">
            <span class="${question.approved ? 'approved' : 'pending'}">
                <strong>Status:</strong>
                <c:choose>
                    <c:when test="${question.approved}">✅ Approved</c:when>
                    <c:otherwise>⏳ Pending</c:otherwise>
                </c:choose>
            </span>
            <span class="${question.resolved ? 'resolved' : 'unresolved'}">
                <strong>Resolution:</strong>
                <c:choose>
                    <c:when test="${question.resolved}">✅ Resolved</c:when>
                    <c:otherwise>❌ Not Resolved</c:otherwise>
                </c:choose>
            </span>
        </p>
    </div>
</c:forEach>

<a class="back-link" href="/portal/userDashboard/${user.id}">← Back to Dashboard</a>

</body>
</html>

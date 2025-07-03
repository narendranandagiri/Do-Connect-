<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Search Questions - DoConnect</title>

    <!-- Font -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap" rel="stylesheet">

    <style>
        :root {
            --black: #000;
            --teal: #1dd1a1;
            --green: #10ac84;
            --red: #ff4d4d;
            --dark-gray: #1f1f1f;
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

        .search-results-container {
            max-width: 800px;
            margin: auto;
            background: var(--glass);
            backdrop-filter: blur(10px);
            padding: 2rem;
            border-radius: var(--radius);
            box-shadow: 0 8px 20px var(--shadow);
        }

        h2 {
            color: var(--teal);
            text-align: center;
            margin-bottom: 1.5rem;
        }

        form {
            display: flex;
            gap: 1rem;
            margin-bottom: 2rem;
        }

        input[type="text"] {
            flex: 1;
            padding: 10px;
            border-radius: var(--radius);
            border: 1px solid #333;
            background-color: #1a1a1a;
            color: white;
            font-size: 1rem;
        }

        button {
            background: var(--green);
            color: white;
            padding: 10px 16px;
            border: none;
            border-radius: var(--radius);
            font-weight: bold;
            cursor: pointer;
            transition: var(--transition);
        }

        button:hover {
            background: var(--teal);
            transform: scale(1.03);
        }

        ul {
            list-style: none;
            padding-left: 0;
        }

        li {
            padding: 1rem 0;
        }

        li strong {
            color: var(--teal);
        }

        small {
            color: #aaa;
        }

        a {
            color: var(--teal);
            font-weight: 600;
            text-decoration: none;
        }

        a:hover {
            text-shadow: 0 0 5px var(--teal);
        }

        hr {
            border: none;
            border-top: 1px solid #444;
        }

        p {
            text-align: center;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }

        @media (max-width: 768px) {
            form {
                flex-direction: column;
            }

            button {
                width: 100%;
            }
        }
    </style>
</head>
<body>

<div class="search-results-container">
    <h2>🔍 Search Questions</h2>

    <!-- 🔎 Search Form -->
    <form method="get" action="/portal/questionSearch">
        <input type="text" name="query" placeholder="Enter keyword..." value="${query}" required />
        <button type="submit">Search</button>
    </form>

    <!-- 📋 Search Results -->
    <c:choose>
        <c:when test="${not empty questions}">
            <ul>
                <c:forEach var="q" items="${questions}">
                    <li>
                        <strong>${q.title}</strong><br/>
                        <small>Topic: ${q.topic}</small><br/>
                        <a href="/portal/questions/${q.id}">View Question</a>
                    </li>
                    <hr/>
                </c:forEach>
            </ul>
        </c:when>
        <c:otherwise>
            <p>No questions found matching your search.</p>
        </c:otherwise>
    </c:choose>

    <p><a href="/portal/userDashboard/${user.id}">⬅ Back to Dashboard</a></p>
</div>

</body>
</html>

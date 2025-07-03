<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Question Thread - DoConnect</title>

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

        .thread-container {
            max-width: 900px;
            margin: auto;
            background: var(--glass);
            backdrop-filter: blur(10px);
            padding: 2rem;
            border-radius: var(--radius);
            box-shadow: 0 8px 20px var(--shadow);
        }

        h2 {
            color: var(--teal);
            margin-bottom: 0.5rem;
        }

        h3 {
            color: var(--green);
            margin-top: 2rem;
        }

        p {
            line-height: 1.6;
        }

        textarea {
            width: 100%;
            padding: 12px;
            font-size: 1rem;
            border-radius: var(--radius);
            border: 1px solid #333;
            background-color: #1a1a1a;
            color: white;
            resize: vertical;
            margin-bottom: 1rem;
        }

        button {
            background: var(--green);
            color: white;
            border: none;
            padding: 10px 16px;
            border-radius: var(--radius);
            font-weight: bold;
            cursor: pointer;
            transition: var(--transition);
        }

        button:hover {
            background: var(--teal);
            transform: scale(1.03);
        }

        a {
            color: var(--teal);
            font-weight: 600;
            text-decoration: none;
            margin-right: 1rem;
        }

        a:hover {
            text-shadow: 0 0 5px var(--teal);
        }

        .answer {
            background: rgba(255, 255, 255, 0.04);
            padding: 1rem;
            border-radius: var(--radius);
            margin-bottom: 1rem;
            box-shadow: 0 2px 8px var(--shadow);
        }

        .answer small {
            color: #ccc;
        }

        hr {
            border: none;
            border-top: 1px solid #444;
            margin: 2rem 0;
        }

        .error-msg {
            color: var(--red);
            margin-bottom: 1rem;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }

        @media (max-width: 768px) {
            button {
                font-size: 0.95rem;
                padding: 8px 12px;
            }

            .answer {
                padding: 1rem 0.75rem;
            }

            textarea {
                font-size: 0.95rem;
            }
        }
    </style>
</head>
<body>

<div class="thread-container">

    <!-- 🔎 Question Section -->
    <h2>${question.title}</h2>
    <p><strong>Topic:</strong> ${question.topic}</p>
    <p>${question.content}</p>

    <hr/>

    <!-- 📝 Post Answer -->
    <h3>Post Your Answer</h3>
    <c:if test="${not empty error}">
        <p class="error-msg">${error}</p>
    </c:if>

    <form method="post" action="/portal/${user.id}/questions/${question.id}/answers">
        <textarea name="content" rows="4" placeholder="Type your answer here..." required>${answer.content}</textarea>
        <button type="submit">Submit Answer</button>
    </form>

    <hr/>

    <!-- 💬 Answers Section -->
    <h3>${question.answers.size()} Answer(s)</h3>

    <c:forEach var="ans" items="${question.answers}">
        <div class="answer">
            <p>${ans.content}</p>
            <p><small>By: ${ans.user.username} | Likes: ${ans.likes}</small></p>

            <!-- 👍 Like -->
            <form method="post" action="/portal/answers/${ans.id}/like" style="display: inline;">
                <input type="hidden" name="questionId" value="${question.id}" />
                <button type="submit">👍 Like</button>
            </form>

            <!-- ✏️ Edit -->
            <c:if test="${ans.user.id == user.id}">
                <a href="/portal/${user.id}/answers/${ans.id}/edit">✏️ Edit</a>
            </c:if>

            <!-- 💬 Commenting -->
            <c:if test="${commentsEnabled}">
                <a href="/portal/${user.id}/answers/${ans.id}/comments/add?questionId=${question.id}">💬 Comment</a>
            </c:if>

            <c:if test="${!commentsEnabled}">
                <p style="color: gray;">🛑 Commenting is currently disabled by Admin.</p>
            </c:if>
        </div>
    </c:forEach>

    <!-- ⬅ Back -->
    <p style="text-align:center;"><a href="/portal/questionList">⬅ Back to All Questions</a></p>
</div>

</body>
</html>

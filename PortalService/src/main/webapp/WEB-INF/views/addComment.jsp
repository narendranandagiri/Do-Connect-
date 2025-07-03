<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Add Comment - DoConnect</title>

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
            margin: 0;
            padding: 2rem;
            color: white;
            animation: fadeIn 0.5s ease-in;
        }

        .add-comment-container {
            max-width: 700px;
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
            margin-bottom: 1.5rem;
        }

        label {
            font-weight: 600;
            color: var(--teal);
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
            margin-top: 0.5rem;
        }

        button {
            background: var(--green);
            color: white;
            border: none;
            padding: 10px 16px;
            border-radius: var(--radius);
            font-weight: 600;
            cursor: pointer;
            transition: var(--transition);
            margin-right: 10px;
        }

        button:hover {
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

        p {
            text-align: center;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }

        @media (max-width: 768px) {
            textarea {
                font-size: 0.9rem;
            }

            button {
                font-size: 0.9rem;
                padding: 8px 12px;
            }
        }
    </style>
</head>
<body>

<div class="add-comment-container">
    <h2>Add a Comment</h2>

    <c:if test="${not empty error}">
        <p style="color:red;">${error}</p>
    </c:if>

    <form method="post" action="/portal/${userId}/answers/${answerId}/comments">
        <input type="hidden" name="questionId" value="${questionId}" />

        <label for="content">Your Comment:</label>
        <textarea name="content" rows="4" required>${comment.content}</textarea><br/><br/>

        <button type="submit">💬 Post Comment</button>
        <a href="/portal/questions/${questionId}">Cancel</a>
    </form>
</div>

</body>
</html>

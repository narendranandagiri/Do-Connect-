<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Ask a Question - DoConnect</title>

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

        .ask-question-container {
            max-width: 700px;
            margin: auto;
            background: var(--glass);
            backdrop-filter: blur(12px);
            padding: 2rem;
            border-radius: var(--radius);
            box-shadow: 0 8px 20px var(--shadow);
        }

        h2 {
            color: var(--teal);
            text-align: center;
            margin-bottom: 2rem;
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        label {
            font-weight: 600;
            color: var(--teal);
            display: block;
            margin-bottom: 0.5rem;
        }

        input, textarea {
            width: 100%;
            padding: 12px;
            border: 1px solid #333;
            background-color: #1a1a1a;
            color: white;
            font-size: 1rem;
            border-radius: var(--radius);
        }

        textarea {
            resize: vertical;
        }

        button {
            background: var(--green);
            color: white;
            padding: 12px 20px;
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

        a {
            color: var(--teal);
            font-weight: 600;
            text-decoration: none;
        }

        a:hover {
            text-shadow: 0 0 5px var(--teal);
        }

        p {
            text-align: center;
            margin-top: 2rem;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }

        @media (max-width: 768px) {
            input, textarea {
                font-size: 0.95rem;
            }

            button {
                font-size: 0.95rem;
            }
        }
    </style>
</head>
<body>

<div class="ask-question-container">
    <h2>📝 Ask a New Question</h2>

    <form method="post" action="/portal/${userId}/questions">
        <div class="form-group">
            <label for="title">Title:</label>
            <input type="text" id="title" name="title" value="${question.title}" required />
        </div>

        <div class="form-group">
            <label for="content">Question Details:</label>
            <textarea id="content" name="content" rows="5" required>${question.content}</textarea>
        </div>

        <div class="form-group">
            <label for="topic">Topic:</label>
            <input type="text" id="topic" name="topic" value="${question.topic}" required />
        </div>

        <button type="submit">Submit Question</button>
    </form>

    <p><a href="/portal/userDashboard/${userId}">⬅ Back to Dashboard</a></p>
</div>

</body>
</html>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Login - DoConnect Portal</title>

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

        .signin-container {
            max-width: 500px;
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
            margin-bottom: 1.5rem;
        }

        .form-group {
            margin-bottom: 1.2rem;
        }

        label {
            font-weight: 600;
            display: block;
            margin-bottom: 0.5rem;
            color: var(--teal);
        }

        input {
            width: 100%;
            padding: 10px;
            font-size: 1rem;
            border-radius: var(--radius);
            border: 1px solid #333;
            background-color: #1a1a1a;
            color: white;
        }

        button {
            width: 100%;
            padding: 12px;
            font-weight: bold;
            background: var(--green);
            color: white;
            border: none;
            border-radius: var(--radius);
            cursor: pointer;
            transition: var(--transition);
            margin-top: 1rem;
        }

        button:hover {
            background: var(--teal);
            transform: scale(1.03);
        }

        .error-msg {
            color: var(--red);
            text-align: center;
            margin-bottom: 1rem;
        }

        p {
            text-align: center;
            margin-top: 1.5rem;
        }

        a {
            color: var(--teal);
            font-weight: 600;
            text-decoration: none;
        }

        a:hover {
            text-shadow: 0 0 5px var(--teal);
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }

        @media (max-width: 600px) {
            .signin-container {
                padding: 1.5rem;
            }

            input, button {
                font-size: 0.95rem;
            }
        }
    </style>
</head>
<body>

<div class="signin-container">
    <h2>Login to DoConnect</h2>

    <c:if test="${not empty error}">
        <p class="error-msg">${error}</p>
    </c:if>

    <form method="post" action="/portal/login">
        <div class="form-group">
            <label>Username:</label>
            <input type="text" name="username" required />
        </div>

        <div class="form-group">
            <label>Password:</label>
            <input type="password" name="password" required />
        </div>

        <button type="submit">Login</button>
    </form>

    <p>Don't have an account? <a href="/portal/register">Register here</a></p>
</div>

</body>
</html>

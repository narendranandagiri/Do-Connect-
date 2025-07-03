<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Registration - DoConnect</title>

    <!-- Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap" rel="stylesheet">

    <style>
        :root {
            --black: #000000;
            --dark-gray: #1f1f1f;
            --teal: #1dd1a1;
            --green: #10ac84;
            --glass: rgba(255, 255, 255, 0.1);
            --shadow: rgba(0, 0, 0, 0.2);
            --radius: 10px;
            --transition: all 0.3s ease;
            --font: 'Inter', sans-serif;
        }

        body {
            font-family: var(--font);
            background: var(--black);
            margin: 0;
            padding: 0;
            color: #fff;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            animation: fadeIn 0.6s ease-in-out;
        }

        .auth-container {
            background: var(--glass);
            backdrop-filter: blur(20px);
            padding: 2rem 3rem;
            border-radius: var(--radius);
            box-shadow: 0 8px 20px var(--shadow);
            max-width: 400px;
            width: 100%;
        }

        .auth-title {
            text-align: center;
            color: var(--teal);
            margin-bottom: 1.5rem;
        }

        .auth-form .form-group {
            margin-bottom: 1rem;
            display: flex;
            flex-direction: column;
        }

        .auth-form label {
            margin-bottom: 0.5rem;
            font-weight: 600;
        }

        .input-field {
            padding: 10px 12px;
            border-radius: var(--radius);
            border: none;
            background: #fff;
            color: #000;
            transition: var(--transition);
        }

        .input-field:focus {
            outline: none;
            box-shadow: 0 0 0 2px var(--teal);
        }

        .btn-submit {
            width: 100%;
            padding: 12px;
            margin-top: 1rem;
            background: var(--green);
            border: none;
            border-radius: var(--radius);
            color: white;
            font-weight: bold;
            cursor: pointer;
            transition: var(--transition);
            box-shadow: 0 4px 12px var(--shadow);
        }

        .btn-submit:hover {
            transform: scale(1.03);
            background: var(--teal);
        }

        .auth-footer {
            text-align: center;
            margin-top: 1.5rem;
        }

        .auth-link {
            color: var(--teal);
            text-decoration: none;
            font-weight: 600;
        }

        .auth-link:hover {
            text-shadow: 0 0 5px var(--teal);
        }

        .auth-error {
            background: rgba(255, 0, 0, 0.1);
            padding: 10px;
            margin-bottom: 1rem;
            border-left: 5px solid red;
            color: #fdd;
            border-radius: var(--radius);
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }

        @media (max-width: 500px) {
            .auth-container {
                padding: 1.5rem;
            }
        }
    </style>
</head>
<body>
    <div class="auth-container">
        <h2 class="auth-title">Admin Registration</h2>

        <c:if test="${not empty error}">
            <div class="auth-error">${error}</div>
        </c:if>

        <form class="auth-form" method="post" action="/moderation/register">
            <div class="form-group">
                <label for="username">Username:</label>
                <input type="text" name="username" class="input-field" required />
            </div>

            <div class="form-group">
                <label for="email">Email:</label>
                <input type="email" name="email" class="input-field" required />
            </div>

            <div class="form-group">
                <label for="password">Password:</label>
                <input type="password" name="password" class="input-field" required />
            </div>

            <div class="form-group">
                <label for="confirmPassword">Confirm Password:</label>
                <input type="password" name="confirmPassword" class="input-field" required />
            </div>

            <button type="submit" class="btn-submit">Register</button>
        </form>

        <p class="auth-footer">
            Already have an account? <a href="/moderation/login" class="auth-link">Login</a>
        </p>
    </div>
</body>
</html>

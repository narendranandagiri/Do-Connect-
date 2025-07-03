<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Error - DoConnect</title>

    <!-- Font -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap" rel="stylesheet">

    <style>
        :root {
            --black: #000;
            --red: #ff4d4d;
            --teal: #1dd1a1;
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
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
            animation: fadeIn 0.4s ease-in;
        }

        .error-page {
            max-width: 600px;
            background: var(--glass);
            backdrop-filter: blur(10px);
            padding: 2rem;
            border-radius: var(--radius);
            box-shadow: 0 8px 20px var(--shadow);
            text-align: center;
        }

        .error-header h1 {
            color: var(--red);
            margin-bottom: 1.5rem;
        }

        .error-message {
            font-size: 1.1rem;
            margin-bottom: 2rem;
        }

        .error-back-link {
            display: inline-block;
            padding: 10px 20px;
            background: var(--teal);
            color: white;
            font-weight: 600;
            text-decoration: none;
            border-radius: var(--radius);
            transition: var(--transition);
        }

        .error-back-link:hover {
            background: white;
            color: var(--black);
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }

        @media (max-width: 600px) {
            .error-page {
                padding: 1.5rem;
            }

            .error-message {
                font-size: 1rem;
            }
        }
    </style>
</head>
<body>

<div class="error-page">

    <header class="error-header">
        <h1>Something went wrong</h1>
    </header>

    <main class="error-content">
        <p class="error-message">
            ${error != null ? error : "An unexpected error occurred. Please try again later."}
        </p>
        <a href="/portal/login" class="error-back-link">← Back to Login</a>
    </main>

</div>

</body>
</html>

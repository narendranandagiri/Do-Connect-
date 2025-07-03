<%@ page isErrorPage="true" contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Error - DoConnect</title>

    <style>
    /* Add styles here later */
    </style>
</head>
<body>
    <div class="error-container">
        <h2 class="error-title">Oops! Something went wrong.</h2>
        <p class="error-message">
            ${requestScope['javax.servlet.error.message'] != null 
                ? requestScope['javax.servlet.error.message'] 
                : "An unexpected error occurred."}
        </p>
        <a href="/moderation/dashboard" class="error-back-link">Back to Dashboard</a>
    </div>
</body>
</html>

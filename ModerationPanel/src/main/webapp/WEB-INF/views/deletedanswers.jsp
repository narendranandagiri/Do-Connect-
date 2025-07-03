<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Deleted Answers</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap" rel="stylesheet">
    <style>
        /* Same CSS as above - omitted for brevity */
        /* Paste the same <style> block here from deletedquestions.jsp */
    </style>
</head>
<body>
    <div class="page-container">
        <h2>🗑️ Deleted Answers</h2>
        <c:choose>
            <c:when test="${not empty deletedAnswers}">
                <table>
                    <thead>
                        <tr>
                            <th>Answer</th>
                            <th>Answered By</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="a" items="${deletedAnswers}">
                            <tr>
                                <td>${a.answerText}</td>
                                <td>${a.userName}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:when>
            <c:otherwise>
                <p class="message">No deleted answers yet.</p>
            </c:otherwise>
        </c:choose>
        <a class="back-link" href="/moderation/dashboard">⬅ Back to Dashboard</a>
    </div>
</body>
</html>

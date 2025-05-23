<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Course and Comments</title>
    <script src="https://kit.fontawesome.com/61b76a306e.js" crossorigin="anonymous"></script>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: Arial, sans-serif;
            background: #f0f0f0;
        }

        nav {
            background: #1a1a1a;
            width: 100%;
            padding: 10px 10%;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .header-text {
            color: white;
        }

        .loginandregister ul {
            width: 100%;
            text-align: right;
        }

        .loginandregister ul li {
            display: inline-block;
            list-style: none;
            margin: 10px 20px;
        }

        .loginandregister ul li a {
            color: #fff;
            text-decoration: none;
        }

        .container {
            display: flex;
            width: 80%;
            max-width: 1200px;
            margin: 20px auto;
            border: 1px solid #ccc;
            background: #fff;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        .box {
            flex: 1;
            padding: 20px;
            box-sizing: border-box;
        }

        .voting-box {
            border: 2px solid blue;
        }

        .votingComment-box {
            border: 2px solid red;
            min-height: 400px;
        }

        .title {
            font-size: 20px;
            margin-bottom: 10px;
            text-align: center;
        }

        .comment-area {
            margin-top: 400px;
        }

        .comment-input {
            width: 100%;
            min-height: 100px;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            resize: none;
        }

        .submit-button {
            margin-top: 10px;
            background: #28a745;
            color: white;
            border: none;
            border-radius: 5px;
            padding: 10px 15px;
            cursor: pointer;
        }

        .submit-button:hover {
            background: #218838;
        }

        .modal {
            display: none;
            position: fixed;
            z-index: 1000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            justify-content: center;
            align-items: center;
        }

        .modal-content {
            background-color: white;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }

        .close-button {
            float: right;
            cursor: pointer;
            color: #aaa;
        }

    </style>
</head>

<body>
<nav>
    <div class="logo">
        <span class="header-text">Course Website</span>
    </div>
    <div class="loginandregister">
        <ul>
            <c:choose>
                <c:when test="${pageContext.request.userPrincipal != null}">
                    <li><a href="${pageContext.request.contextPath}/logout">Logout</a></li>
                </c:when>
                <c:otherwise>
                    <li><a href="${pageContext.request.contextPath}/login">Login</a></li>
                    <li><a href="${pageContext.request.contextPath}/register">Register</a></li>
                </c:otherwise>
            </c:choose>
        </ul>
    </div>
</nav>

<div class="container">
    <div class="box voting-box">
        <div class="title">Question</div>
        <p style="text-align: center;">${poll.question}</p>

        <c:choose>
            <c:when test="${hasVoted}">
                <c:forEach var="option" items="${poll.options}">
                    <p>${option.optionText}: ${option.votes} votes</p>
                </c:forEach>
                <form action="${pageContext.request.contextPath}/polls/${poll.id}/editVote" method="POST">
                    <button type="submit" class="edit-button">Edit Vote</button>
                </form>
            </c:when>
            <c:otherwise>
                <form action="${pageContext.request.contextPath}/polls/${poll.id}/submitVote" method="POST">
                    <c:forEach var="option" items="${poll.options}">
                        <input type="radio" id="${option.optionText}" name="midterm_date" value="${option.optionText}"
                               <c:if test="${userVote == option.optionText}">checked</c:if>>
                        <label for="${option.optionText}">${option.optionText}</label><br>
                    </c:forEach>
                    <button type="submit" class="submit-button">Vote</button>
                </form>
            </c:otherwise>
        </c:choose>
    </div>

    <div class="box votingComment-box">
        <div class="title">Comments</div>
        <div>
            <c:forEach var="comment" items="${comments}">
                <p>
                    <strong>${comment.username}:</strong>
                        ${comment.content}
                </p>
            </c:forEach>
        </div>
        <div class="comment-area">
            <form action="${pageContext.request.contextPath}/polls/${poll.id}/submitComment" method="POST">
                <textarea class="comment-input" name="comment" placeholder="Enter your comment here..." required></textarea>
                <button type="submit" class="submit-button">Submit</button>
            </form>
        </div>
    </div>
</div>
</body>

</html>

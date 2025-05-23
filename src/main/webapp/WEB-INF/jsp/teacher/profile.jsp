<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Profile</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://kit.fontawesome.com/61b76a306e.js" crossorigin="anonymous"></script>
    <style>
        nav { background: #1a1a1a; width: 100%; padding: 10px 10%; height: 70px; display: flex; align-items: center; justify-content: space-between; position: relative; }
        .header-text { color: white; }
        .logo { display: flex; align-items: center; }
        .container { margin-top: 20px; }
        .profile-card { max-width: 600px; margin: 0 auto; }
        .btn-custom { margin-top: 10px; }
    </style>
</head>
<body>
<nav>
    <div class="logo">
        <i class="fas fa-graduation-cap" style="color: red;"></i>
        <span class="header-text">Course Website</span>
    </div>
    <span class="header-text">Welcome, ${user.fullName}!</span>
    <div class="loginandregister">
        <span class="header-text">
            <c:url var="homeUrl" value="/teacher/dashboard"/>
               <a href="${homeUrl}" style="color: white; text-decoration: none; margin-right: 20px;">dashboard</a>
            <c:url var="CourseUrl" value="/teacher/S265F"/>
               <a href="${CourseUrl}" style="color: white; text-decoration: none; margin-right: 20px;">Course</a>
            <c:url var="profileUrl" value="/teacher/profile"/>
            <a href="${profileUrl}" style="color: white; text-decoration: none; margin-right: 20px;">Profile</a>
            <c:url var="logoutUrl" value="/logout"/>
            <form action="${logoutUrl}" method="post" style="display: inline;">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                <button type="submit" style="background: none; border: none; color: white; cursor: pointer;">Logout</button>
            </form>
        </span>
        <a href="${pageContext.request.contextPath}/teacher/profile?lang=zh" style="color: white; text-decoration: none;">Change to Chinese</a>

    </div>
</nav>

<div class="container">
    <div class="card profile-card">
        <div class="card-header bg-dark text-white">
            <h2>User Profile</h2>
        </div>
        <div class="card-body">
            <p><strong>Username:</strong> ${user.username}</p>
            <p><strong>Full Name:</strong> ${user.fullName}</p>
            <p><strong>Email:</strong> ${user.email}</p>
            <p><strong>Phone Number:</strong> ${user.phoneNumber}</p>
            <p><strong>Role:</strong> ${user.role}</p>
            <sec:authorize access="hasRole('TEACHER')">
                <c:url var="editProfileUrl" value="/teacher/edit_profile"/>
                <a href="${editProfileUrl}" class="btn btn-outline-warning btn-custom">Edit Profile</a>
            </sec:authorize>
            <c:url var="dashboardUrl" value="/teacher/dashboard"/>
            <a href="${dashboardUrl}" class="btn btn-outline-primary btn-custom">Back to Dashboard</a>
        </div>
    </div>
</div>
</body>
</html>
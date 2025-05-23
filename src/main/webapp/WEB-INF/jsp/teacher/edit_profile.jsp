<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Profile</title>
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
                <button type="submit" style="background: none; text-decoration: none; border: none; color: white; cursor: pointer;">Logout</button>
            </form>
        </span>
        <a href="${pageContext.request.contextPath}/teacher/edit_profile?lang=zh" style="color: white; text-decoration: none;">Change to Chinese</a>

    </div>
</nav>

<div class="container">
    <div class="card profile-card">
        <div class="card-header bg-dark text-white">
            <h2>Edit Profile</h2>
        </div>
        <div class="card-body">
            <form action="<c:url value='/teacher/profile/update'/>" method="post">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                <input type="hidden" name="originalUsername" value="${user.username}"/>
                <div class="mb-3">
                    <label for="username" class="form-label">Username:</label>
                    <input type="text" class="form-control" id="username" name="username" value="${user.username}" required>
                </div>
                <div class="mb-3">
                    <label for="fullName" class="form-label">Full Name:</label>
                    <input type="text" class="form-control" id="fullName" name="fullName" value="${user.fullName}" required>
                </div>
                <div class="mb-3">
                    <label for="email" class="form-label">Email:</label>
                    <input type="email" class="form-control" id="email" name="email" value="${user.email}" required>
                </div>
                <div class="mb-3">
                    <label for="phoneNumber" class="form-label">Phone Number:</label>
                    <input type="text" class="form-control" id="phoneNumber" name="phoneNumber" value="${user.phoneNumber}" required>
                </div>
                <div class="mb-3">
                    <label for="role" class="form-label">Role:</label>
                    <select class="form-control" id="role" name="role" required>
                        <option value="ROLE_TEACHER" ${user.role == 'ROLE_TEACHER' ? 'selected' : ''}>Teacher</option>
                        <option value="ROLE_STUDENT" ${user.role == 'ROLE_STUDENT' ? 'selected' : ''}>Student</option>
                    </select>
                </div>
                <div class="mb-3">
                    <label for="password" class="form-label">New Password (leave blank to keep current):</label>
                    <input type="password" class="form-control" id="password" name="password" placeholder="Enter new password">
                </div>
                <button type="submit" class="btn btn-primary btn-custom">Save Changes</button>
                <c:url var="profileUrl" value="/teacher/profile"/>
                <a href="${profileUrl}" class="btn btn-secondary btn-custom">Cancel</a>
            </form>
        </div>
    </div>
</div>
</body>
</html>
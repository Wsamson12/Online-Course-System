<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Add User</title>
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
        <span class="header-text">Course Website Admin Control Panel</span>
    </div>
    <%--    <span class="header-text">Welcome, Teacher ${user.username}!</span>--%>
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
<a href="${pageContext.request.contextPath}/teacher/addUser?lang=zh" style="color: white; text-decoration: none;">Switch to Chinese</a>
    </div>
</nav>

<div class="container mt-4">
    <h2>Add User</h2>
    <form action="<c:url value='/teacher/addUser'/>" method="post">
        <div class="form-group">
            <label for="username">Username</label>
            <input type="text" class="form-control" id="username" name="username" required>
        </div>
        <div class="form-group">
            <label for="fullName">Full Name</label>
            <input type="text" class="form-control" id="fullName" name="fullName" required>
        </div>
        <div class="form-group">
            <label for="email">Email</label>
            <input type="email" class="form-control" id="email" name="email" required>
        </div>
        <div class="form-group">
            <label for="phoneNumber">Phone Number</label>
            <input type="text" class="form-control" id="phoneNumber" name="phoneNumber" required>
        </div>
        <div class="form-group">
            <label for="password">password</label>
            <input type="password" class="form-control" id="password" name="password" required>
        </div>
        <div class="form-group">
            <label for="role">Role</label>
            <select class="form-control" id="role" name="role" required>
                <option value="ROLE_TEACHER" ${user.role == 'ROLE_TEACHER' ? 'selected' : ''}>Teacher</option>
                <option value="ROLE_STUDENT" ${user.role == 'ROLE_STUDENT' ? 'selected' : ''}>Student</option>
            </select>
            </select>
        </div>
        <button type="submit" class="btn btn-success">Save</button>
        <c:url var="manageUrl" value="/teacher/manage"/>
        <a href="${manageUrl}" class="btn btn-outline-secondary ml-2">Cancel</a>
    </form>
</div>
</body>
</html>
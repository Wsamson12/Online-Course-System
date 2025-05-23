<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Manage Users</title>
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
                <button type="submit" style="background: none; text-decoration: none; border: none; text-decoration: none; color: white; cursor: pointer;">Logout</button>
            </form>
        </span>
        <a href="${pageContext.request.contextPath}/teacher/manage?lang=zh" style="color: white; text-decoration: none;">Change to Chinese</a>

    </div>
</nav>

<div class="container mt-4">
    <h2>Manage Users</h2>
    <p>View, edit, and delete teacher and student accounts.</p>

    <table class="table table-striped table-bordered">
        <thead class="thead-dark">
        <tr>
            <th>Username</th>
            <th>Full Name</th>
            <th>Email</th>
            <th>Phone Number</th>
            <th>Role</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="user" items="${users}">
            <tr>
                <td>${user.username}</td>
                <td>${user.full_name}</td>
                <td>${user.email}</td>
                <td>${user.phone_number}</td>
                <td>${user.role}</td>
                <td>
                    <a href="<c:url value='/teacher/editdata?username=${user.username}'/>"
                       class="btn btn-sm btn-primary mr-2">Edit</a>
                    <a href="<c:url value='/teacher/deleteUser?username=${user.username}'/>"
                       class="btn btn-sm btn-danger"
                       onclick="return confirm('Are you sure you want to delete ${user.username}?')">Delete</a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <c:url var="dashboardUrl" value="/teacher/dashboard"/>
    <a href="${dashboardUrl}" class="btn btn-outline-primary btn-custom">Back to Dashboard</a>

    <c:url var="addUserUrl" value="/teacher/addUser"/>
    <a href="${addUserUrl}" class="btn btn-outline-success btn-custom ml-2">Add User</a>

</div>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
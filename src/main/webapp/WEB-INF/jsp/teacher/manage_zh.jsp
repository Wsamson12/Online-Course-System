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
        <span class="header-text">課程網站管理面板</span>
    </div>
    <%--    <span class="header-text">歡迎，教師 ${user.username}!</span>--%>
    <div class="loginandregister">
        <span class="header-text">
            <c:url var="homeUrl" value="/teacher/dashboard"/>
            <a href="${homeUrl}" style="color: white; text-decoration: none; margin-right: 20px;">主面板</a>
            <c:url var="CourseUrl" value="/teacher/S265F"/>
            <a href="${CourseUrl}" style="color: white; text-decoration: none; margin-right: 20px;">課程</a>
            <c:url var="profileUrl" value="/teacher/profile"/>
            <a href="${profileUrl}" style="color: white; text-decoration: none; margin-right: 20px;">個人資料</a>
            <c:url var="logoutUrl" value="/logout"/>
            <form action="${logoutUrl}" method="post" style="display: inline;">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                <button type="submit" style="background: none; border: none; text-decoration: none; color: white; cursor: pointer;">登出</button>
            </form>
        </span>
        <a href="${pageContext.request.contextPath}/teacher/manage?lang=en" style="color: white; text-decoration: none;">切換到英文</a>

    </div>
</nav>

<div class="container mt-4">
    <h2>管理用戶</h2>
    <p>查看、編輯和刪除管理員和用戶帳戶。</p>

    <table class="table table-striped table-bordered">
        <thead class="thead-dark">
        <tr>
            <th>用戶名</th>
            <th>全名</th>
            <th>電郵地址</th>
            <th>電話號碼</th>
            <th>角色</th>
            <th>動作</th>
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
                    <a href="<c:url value='/teacher/editdata?username=${user.username}&lang=zh'/>"
                       class="btn btn-sm btn-primary mr-2">編輯</a>
                    <a href="<c:url value='/teacher/deleteUser?username=${user.username}'/>"
                       class="btn btn-sm btn-danger"
                       onclick="return confirm('確定要刪除 ${user.username}?')">刪除</a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <c:url var="dashboardUrl" value="/teacher/dashboard"/>
    <a href="${dashboardUrl}" class="btn btn-outline-primary btn-custom">返回主面板</a>

    <c:url var="addUserUrl" value="/teacher/addUser"/>
    <a href="${addUserUrl}" class="btn btn-outline-success btn-custom ml-2">新增用戶</a>

</div>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
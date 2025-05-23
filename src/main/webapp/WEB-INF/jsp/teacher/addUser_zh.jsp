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

<nav>
    <div class="logo">
        <i class="fas fa-graduation-cap" style="color: red;"></i>
        <span class="header-text">課程網站管理面板</span>
    </div>
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
                <button type="submit" style="background: none; text-decoration: none; border: none; color: white; cursor: pointer;">登出</button>
            </form>
        </span>
        <a href="${pageContext.request.contextPath}/teacher/addUser?lang=en" style="color: white; text-decoration: none;">切換到英文</a>
    </div>
</nav>

<div class="container mt-4">
    <h2>新增用戶</h2>
    <form action="<c:url value='/teacher/addUser'/>" method="post">
        <div class="form-group">
            <label for="username">用戶名</label>
            <input type="text" class="form-control" id="username" name="username" required>
        </div>
        <div class="form-group">
            <label for="fullName">全名</label>
            <input type="text" class="form-control" id="fullName" name="fullName" required>
        </div>
        <div class="form-group">
            <label for="email">電子郵件</label>
            <input type="email" class="form-control" id="email" name="email" required>
        </div>
        <div class="form-group">
            <label for="phoneNumber">電話號碼</label>
            <input type="text" class="form-control" id="phoneNumber" name="phoneNumber" required>
        </div>
        <div class="form-group">
            <label for="password">密碼</label>
            <input type="password" class="form-control" id="password" name="password" required>
        </div>
        <div class="form-group">
            <label for="role">角色</label>
            <select class="form-control" id="role" name="role" required>
                <option value="ROLE_TEACHER" ${user.role == 'ROLE_TEACHER' ? 'selected' : ''}>教師</option>
                <option value="ROLE_STUDENT" ${user.role == 'ROLE_STUDENT' ? 'selected' : ''}>學生</option>
            </select>
        </div>
        <button type="submit" class="btn btn-success">保存</button>
        <c:url var="manageUrl" value="/teacher/manage"/>
        <a href="${manageUrl}" class="btn btn-outline-secondary ml-2">取消</a>
    </form>
</div>
</body>
</html>
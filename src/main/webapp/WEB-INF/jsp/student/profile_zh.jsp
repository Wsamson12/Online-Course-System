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
        <span class="header-text">課程網站</span>
    </div>
    <span class="header-text">歡迎, ${user.fullName}!</span>
    <div class="loginandregister">
        <span class="header-text">
           <c:url var="homeeUrl" value="/student/dashboard"/>
            <a href="${homeeUrl}" style="color: white; text-decoration: none; margin-right: 20px;">主面板</a>
            <c:url var="profileUrl" value="/student/profile"/>
            <a href="${profileUrl}" style="color: white; text-decoration: none; margin-right: 20px;">個人資料</a>
            <c:url var="logoutUrl" value="/logout"/>
            <form action="${logoutUrl}" method="post" style="display: inline;">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                <button type="submit" style="background: none; text-decoration: none; border: none; color: white; cursor: pointer;">登出</button>
            </form>
        </span>
        <a href="${pageContext.request.contextPath}/student/profile?lang=en" style="color: white; text-decoration: none;">切換到英文</a>

    </div>
</nav>

<div class="container">
    <div class="card profile-card">
        <div class="card-header bg-dark text-white">
            <h2>個人資料</h2>
        </div>
        <div class="card-body">
            <p><strong>用戶名:</strong> ${user.username}</p>
            <p><strong>全名:</strong> ${user.fullName}</p>
            <p><strong>電郵地址:</strong> ${user.email}</p>
            <p><strong>電話號碼:</strong> ${user.phoneNumber}</p>
            <p><strong>用戶角色:</strong> ${user.role}</p>
            <sec:authorize access="hasRole('STUDENT')">
                <c:url var="editProfileUrl" value="/student/edit_profile"/>
                <a href="${editProfileUrl}" class="btn btn-outline-warning btn-custom">編輯個人資料</a>
            </sec:authorize>
            <c:url var="dashboardUrl" value="/student/dashboard"/>
            <a href="${dashboardUrl}" class="btn btn-outline-primary btn-custom">返回主面板</a>
        </div>
    </div>
</div>
</body>
</html>
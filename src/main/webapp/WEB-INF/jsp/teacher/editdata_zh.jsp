<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Edit User</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
    <a href="${pageContext.request.contextPath}/teacher/editdata?username=${user.username}&lang=en" style="color: rgb(0, 0, 0); text-decoration: none;">切換到英文</a>
<div class="container mt-4">
    <h2>Edit User</h2>
    <p>更改 <strong>${user.username} 的資料</strong></p>

    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>

    <!-- Form to edit user details -->
    <form action="<c:url value='/teacher/editdata'/>" method="post">
        <div class="mb-3">
            <label for="username" class="form-label">用戶名:</label>
            <input type="text" class="form-control" id="username" name="username" value="${user.username}" required>
        </div>
        <!-- Other fields remain the same -->
        <div class="mb-3">
            <label for="full_name" class="form-label">全名:</label>
            <input type="text" class="form-control" id="full_name" name="full_name" value="${user.full_name}" required>
        </div>
        <div class="mb-3">
            <label for="email" class="form-label">電郵地址:</label>
            <input type="email" class="form-control" id="email" name="email" value="${user.email}" required>
        </div>
        <div class="mb-3">
            <label for="phone_number" class="form-label">電話號碼:</label>
            <input type="text" class="form-control" id="phone_number" name="phone_number" value="${user.phone_number}" required>
        </div>
        <div class="mb-3">
            <label for="role" class="form-label">角色:</label>
            <select class="form-control" id="role" name="role" required>
                <option value="ROLE_TEACHER" ${user.role == 'ROLE_TEACHER' ? 'selected' : ''}>教師</option>
                <option value="ROLE_STUDENT" ${user.role == 'ROLE_STUDENT' ? 'selected' : ''}>學生</option>
            </select>
        </div>
        <div class="mb-3">
            <label for="password" class="form-label">新密碼（如不更改請留空）： </label>
            <input type="password" class="form-control" id="password" name="password" placeholder="Enter new password">
        </div>

        <button type="submit" class="btn btn-primary">儲存</button>
        <c:url var="manageUrl" value="/teacher/manage"/>
        <a href="${manageUrl}" class="btn btn-outline-secondary ml-2">取消</a>
    </form>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
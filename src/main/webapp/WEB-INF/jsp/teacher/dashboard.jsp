<!-- filepath: c:\Users\User\Downloads\project\src\main\webapp\WEB-INF\jsp\teacher\dashboard.jsp -->
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Teacher Dashboard</title>
    <script src="https://kit.fontawesome.com/61b76a306e.js" crossorigin="anonymous"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .main-container {
            display: flex;
            justify-content: space-between;
            max-width: 1200px;
            margin: 20px auto;
        }

        .course-section {
            flex: 1;
            padding: 20px;
            margin-right: 20px;
        }

        .poll-section {
            width: 300px;
            padding: 20px;
            background: #f1f1f1;
            border-radius: 10px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
        }

        h2 {
            text-align: left;
            color: #333;
            margin-bottom: 20px;
        }

        .course-card {
            background: #f1f1f1;
            border-radius: 10px;
            padding: 15px;
            margin: 10px 0;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
            transition: transform 0.2s;
        }

        .course-card:hover {
            transform: translateY(-5px);
        }

        .course-card a {
            text-decoration: none; /* Remove underline from links */
            color: inherit; /* Inherit text color from the parent */
            display: block; /* Make the link cover the entire card */
            height: 100%; /* Ensure it fills the card */
        }

        .course-card a:hover {
            color: #3498db; /* Change color on hover */
        }

        .course-card h3 {
            margin: 0;
            color: #2c3e50;
        }

        .course-card p {
            margin: 5px 0;
            color: #7f8c8d;
        }

        .status {
            display: inline-block;
            margin-top: 10px;
            padding: 5px 10px;
            border-radius: 5px;
            color: deepskyblue;
        }
        .card { margin: 15px; }
        .btn-custom { margin-top: 10px; }
        * { margin: 0; padding: 0; box-sizing: border-box; }
        .header-text { color: white; }
        nav { background: #1a1a1a; width: 100%; padding: 10px 10%; height: 70px; display: flex; align-items: center; justify-content: space-between; position: relative; }
    </style>
</head>
<body>
<nav>
    <div class="logo">
        <i class="fas fa-graduation-cap" style="color: red;"></i>
        <span class="header-text">Course Website Admin Control Panel</span>
    </div>
    <span class="header-text">Welcome, Teacher ${username}!</span>
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
        <a href="${pageContext.request.contextPath}/teacher/dashboard?lang=zh" style="color: white; text-decoration: none;">Change to Chinese</a>

    </div>
</nav>

<div class="container mt-4">
    <p>Manage System, Write Comments, Vote on Polls, and More</p>
    <div class="row">
        <div class="col-md-6">
            <div class="card">
                <div class="card-header bg-primary text-white">Manage Users</div>
                <div class="card-body">
                    <p>View, edit, and delete admin and user accounts.</p>
                    <c:url var="ManageUrl" value="/teacher/manage"/>
                    <a href="${ManageUrl}" class="btn btn-outline-primary btn-custom w-100">Manage Users</a>
                </div>
            </div>
        </div>
        <div class="col-md-6">
            <div class="card">
                <div class="card-header bg-success text-white">Manage Course Materials</div>
                <div class="card-body">
                    <p>Add, edit, or remove lecture materials and notes.</p>
                    <c:url var="CourseUrl" value="/teacher/S265F"/>
                    <a href="${CourseUrl}" class="btn btn-outline-success btn-custom w-100">Manage Course Materials</a>
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <!-- <div class="col-md-6">
            <div class="card">
                <div class="card-header bg-warning text-white">Manage Poll Pages</div>
                <div class="card-body">
                    <p>Create, edit, or delete poll pages and questions.</p>
                    <button class="btn btn-outline-warning btn-custom w-100" onclick="managePolls()">Manage Poll Pages</button>
                </div>
            </div>
        </div> -->
        <!-- <div class="col-md-6"> -->
        <div class="col-md-12">
            <div class="card">
                <div class="card-header bg-danger text-white">Manage Comments</div>
                <div class="card-body">
                    <p>Delete or moderate user comments on lectures and polls.</p>
                    <c:url var="CourseUrl" value="/teacher/S265F"/>
                    <a href="${CourseUrl}" class="btn btn-outline-danger btn-custom w-100">Manage Comments</a>
                </div>
            </div>
        </div>
    </div>
    <div class="row mt-4">
        <!-- <div class="col-md-6"> -->
        <div class="col-md-12">
            <div class="card">
                <div class="card-header bg-info text-white">Write Comments</div>
                <div class="card-body">
                    <p>Write new comments on lectures or polls as an admin.</p>
                    <c:url var="CourseUrl" value="/teacher/S265F"/>
                    <a href="${CourseUrl}" class="btn btn-outline-info btn-custom w-100">Write Comments</a>
                    
                </div>
            </div>
        </div>
        <!-- <div class="col-md-6">
            <div class="card">
                <div class="card-header bg-secondary text-white">Vote on Polls</div>
                <div class="card-body">
                    <p>Participate in polls and edit your votes as an admin.</p>
                    <button class="btn btn-outline-secondary btn-custom w-100" onclick="votePolls()">Vote on Polls</button>
                </div>
            </div>
        </div> -->
    </div>
    <div class="row mt-4">
        <div class="col-md-12">
            <div class="card">
                <div class="card-header bg-dark text-white">Update Personal Profile</div>
                <div class="card-body">
                    <p>Update your personal information, such as name, email, or phone number.</p>
                    <c:url var="editProfileUrl" value="/teacher/edit_profile"/>
                    <a href="${editProfileUrl}" class="btn btn-outline-dark btn-custom w-100">Update Profile</a>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    function manageUsers() { alert("Redirecting to user management..."); window.location.href = "/HelloSpringSecurity/teacher/manage-users"; }
    function manageMaterials() { alert("Redirecting to course material management..."); window.location.href = "/HelloSpringSecurity/teacher/manage-materials"; }
    function managePolls() { alert("Redirecting to poll management..."); window.location.href = "/HelloSpringSecurity/teacher/manage-polls"; }
    function manageComments() { alert("Redirecting to comment management..."); window.location.href = "/HelloSpringSecurity/teacher/manage-comments"; }
    function writeComments() { alert("Redirecting to write comments..."); window.location.href = "/HelloSpringSecurity/teacher/write-comments"; }
    function votePolls() { alert("Redirecting to vote on polls..."); window.location.href = "/HelloSpringSecurity/teacher/vote-polls"; }
    function manageUsers() {
        alert("Redirecting to user management...");
        window.location.href = "/teacher/manage";
    }
</script>
</body>
</html>
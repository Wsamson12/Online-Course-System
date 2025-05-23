<%@page contentType="text/html" pageEncoding="UTF-8" session="true"%>
<!DOCTYPE html>
<html>

<head>
    <title>Responsive Table Design - Easy Tutorials</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://kit.fontawesome.com/61b76a306e.js" crossorigin="anonymous"></script>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        .header-text {
            color: white;
        }

        .hero {
            width: 100%;
            min-height: 100vh;
            color: #525252;
        }

        nav {
            background: #1a1a1a;
            width: 100%;
            padding: 10px 10%;
            display: flex;
            align-items: center;
            justify-content: space-between;
            position: relative;
        }

        .user-pic {
            width: 40px;
            border-radius: 50px;
            cursor: pointer;
            margin-left: 30px;
        }

        nav ul {
            width: 100%;
            text-align: right;
        }

        nav ul li {
            display: inline-block;
            list-style: none;
            margin: 10px 20px;
        }

        nav ul li a {
            color: #fff;
            text-decoration: none;
        }

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


    </style>
</head>

<body>

<nav>
    <div class="logo">
        <i class="fas fa-graduation-cap" style="color: red;"></i>
        <span class="header-text">Course Website</span>
    </div>

    <div class="loginandregister">
        <ul>
            <li><a href="login">Login</a></li>
            <li><a href="register">Register</a></li>
            
        </ul>

        <a href="${pageContext.request.contextPath}?lang=zh" style="color: white; text-decoration: none;">Change to Chinese</a>

    </div>
</nav>

<div class="main-container">
    <div class="course-section">
        <h2>My Courses</h2>
        <a href="">
            <div class="course-card">
                <h3>S265F</h3>
                <h2>Design And Analysis Of Algorithms (2025 Spring)</h2>
                <div class="status">Lecture <br> Monday <br>11:00AM-12:50PM</div>
            </div>
        </a>

    </div>

    <a href="${pageContext.request.contextPath}/polls/1">Go to Poll</a>
</div>

</body>

</html>
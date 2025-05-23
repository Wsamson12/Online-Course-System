<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Registration</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .registration-container {
            max-width: 500px;
            margin: 50px auto;
            padding: 20px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            border-radius: 8px;
        }
        .form-title {
            text-align: center;
            margin-bottom: 30px;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="registration-container">
        <h2 class="form-title">Student Registration</h2>
        <form action="register" method="POST">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

            <div class="mb-3">
                <label for="username" class="form-label">Username</label>
                <input type="text" class="form-control" id="username" name="username"
                       placeholder="Enter username" required>
            </div>
            <div class="mb-3">
                <label for="password" class="form-label">Password</label>
                <input type="password" class="form-control" id="password" name="password"
                       placeholder="Enter password" required>
            </div>

            <div class="mb-3">
                <label for="fullName" class="form-label">Full Name</label>
                <input type="text" class="form-control" id="fullName" name="fullName"
                       placeholder="Enter full name" required>
            </div>
            <div class="mb-3">
                <label for="email" class="form-label">Email Address</label>
                <input type="email" class="form-control" id="email" name="email"
                       placeholder="Enter email" required>
            </div>
            <div class="mb-3">
                <label for="phone" class="form-label">Phone Number</label>
                <input type="tel" class="form-control" id="phone" name="phoneNumber"
                       placeholder="Enter phone number" required
                       pattern="[0-9]{8,}" title="Please enter a valid phone number">
            </div>

            <label for="role">Role:</label>
            <select id="role" name="role">
                <option value="ROLE_STUDENT">Student</option>
                <option value="ROLE_TEACHER">Teacher</option>
            </select>

            <div class="d-grid">
                <button type="submit" class="btn btn-primary">Register</button>
            </div>

            <div class="text-center mt-3">
                <p>Already have an account? <a href="login">Login here</a></p>
            </div>
            
        </form>
    </div>
</div>

<!-- Bootstrap JS (optional, for interactive components) -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

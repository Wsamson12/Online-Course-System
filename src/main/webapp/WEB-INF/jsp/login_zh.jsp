
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>登入頁面</title>
        
<style>




    @import url("https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400");
    @import url("https://fonts.googleapis.com/css?family=Playfair+Display");
    body,
    .message,
    .form,
    form {
        display: flex;
        justify-content: center;
        align-items: center;
        flex-direction: column;
    }

    body {
        height: 100vh;
        background: #e8e8e8;
        font-family: "Source Sans Pro", sans-serif;
        overflow: hidden;
    }

    .container {
        width: 700px;
        height: 400px;
        background: white;
        position: relative;
        display: grid;
        grid-template: 100%/50% 50%;
        box-shadow: 2px 2px 10px 0 rgba(51, 51, 51, 0.2);
    }

    .message {
        position: absolute;
        background: white;
        width: 50%;
        height: 100%;
        transition: 0.5s all ease;
        transform: translateX(100%);
        z-index: 4;
    }
    .message:before {
        position: absolute;
        content: "";
        width: 1px;
        height: 70%;
        background: #c3c3d8;
        opacity: 0;
        left: 0;
        top: 15%;
    }
    .message .button {
        margin: 5px 0;
    }

    .signup:before {
        opacity: 0.3;
        left: 0;
    }

    .login:before {
        opacity: 0.3;
        left: 100%;
    }

    .btn-wrapper {
        width: 60%;
    }

    .form {
        width: 100%;
        height: 100%;
    }
    .form--heading {
        font-size: 25px;
        height: 50px;
        color: #129D72;
        font-family: "Source Sans Pro", sans-serif;
        margin-top: 180px;
        text-align: center;
    }
    .form--signup {
        border-right: 1px solid #999;
    }

    form {
        width: 70%;
    }
    form > * {
        margin: 10.1px;
    }
    form input {
        width: 96.8%;
        border: 0;
        border-bottom: 1px solid #aaa;
        font-size: 13px;
        font-weight: 300;
        color: #797a9e;
        letter-spacing: 0.11em;
    }
    form input::placeholder {
        color: #333;
        font-size: 10px;
    }
    form input:focus {
        outline: 0;
        border-bottom: 1px solid rgba(128, 155, 206, 0.7);
        transition: 0.6s all ease;
    }

    input[type=submit]{
        width: 100%;
        height: 30px;
        border: 0;
        outline: 0;
        color: white;
        font-size: 15px;
        font-weight: 400;
        position: relative;
        z-index: 3;
        font-family: "Source Sans Pro", sans-serif;
        cursor: pointer;
        background-color: #EB5406;

    }

    .button {
        width: 100%;
        height: 30px;
        border: 0;
        outline: 0;
        color: white;
        font-size: 15px;
        font-weight: 400;
        position: relative;
        z-index: 3;
        font-family: "Source Sans Pro", sans-serif;
        cursor: pointer;
    }
    #submit {
        background-color: #EB5406;
    }

    #Loginbtn1{
        background-color: #FFA500;
    }

    .remember-me-container {
        display: flex;
        align-items: center; /* Aligns items vertically in the center */
    }

    .remember-me-container input[type=checkbox] {
        margin-right: 6.2px; /* Space between checkbox and label */
        margin-left: -105.0px;
    }

    .remember-me-container {
        margin-top: 17px; /* Optional: add some space above */
        margin-left: -5px;
    }
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
</style>

    </head>
    <body>
        <div class="container">
            <div class="form--heading">課程網站 <br/> 用戶登入</div>
            <form action="login" method="POST">
                用戶名： <input type="text" name="username" placeholder="請輸入用戶名"><br />
                密碼： <input type="password" name="password" placeholder="請輸入密碼"/>
                <div class="remember-me-container">
                    <input type="checkbox" name="remember-me" id="remember-me" />
                    <label for="remember-me">記住我</label>
                </div>
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                <input name="submit" type="submit" value="登入" /><br />
            </form>

            <p>Don't have account? <a href="register">Register here</a></p>
            <a href="${pageContext.request.contextPath}/login?lang=en" style="color: white; text-decoration: none;">切換到英文</a>

        </div>
        
        </div>
    </body>
</html> 






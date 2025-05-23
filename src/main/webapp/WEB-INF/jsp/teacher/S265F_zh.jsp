<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Course and Comments</title>
    <script src="https://kit.fontawesome.com/61b76a306e.js" crossorigin="anonymous"></script>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: Arial, sans-serif;
            background: #f0f0f0;
        }

        nav {
            background: #1a1a1a;
            width: 100%;
            padding: 10px 10%;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .header-text {
            color: white;
        }

        .loginandregister ul {
            width: 100%;
            text-align: right;
        }

        .loginandregister ul li {
            display: inline-block;
            list-style: none;
            margin: 10px 20px;
        }

        .loginandregister ul li a {
            color: #fff;
            text-decoration: none;
        }

        .container {
            display: flex;
            width: 80%;
            max-width: 1200px;
            margin: 20px auto;
            border: 1px solid #ccc;
            background: #fff;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        .box {
            flex: 1;
            padding: 20px;
            box-sizing: border-box;
        }

        .course-box {
            border: 2px solid blue;
        }

        .comment-box {
            border: 2px solid red;
            min-height: 400px;
        }

        .title {
            font-size: 20px;
            margin-bottom: 10px;
            text-align: center;
        }

        .add-file-button {
            margin: 20px 0;
            align-self: flex-start;
            margin-left: 19%;
            background: #5E5DF0;
            border-radius: 999px;
            box-shadow: #5E5DF0 0 10px 20px -10px;
            box-sizing: border-box;
            color: #FFFFFF;
            cursor: pointer;
            font-family: Inter, Helvetica, "Apple Color Emoji", "Segoe UI Emoji", NotoColorEmoji, "Noto Color Emoji", "Segoe UI Symbol", "Android Emoji", EmojiSymbols, -apple-system, system-ui, "Segoe UI", Roboto, "Helvetica Neue", "Noto Sans", sans-serif;
            font-size: 16px;
            font-weight: 700;
            line-height: 24px;
            opacity: 1;
            outline: 0 solid transparent;
            padding: 8px 18px;
            user-select: none;
            -webkit-user-select: none;
            touch-action: manipulation;
            width: fit-content;
            word-break: break-word;
            border: 0;
        }

        .file-list {
            margin-top: 10px;
        }

        .file-list-item {
            margin: 5px 0;
            padding: 5px;
            border: 1px solid #ddd;
            border-radius: 3px;
        }

        .file-list-item a {
            color: #007bff;
            text-decoration: none;
        }

        .file-list-item a:hover {
            text-decoration: underline;
        }

        .comment-area {
            margin-top: 400px;
        }

        .comment-input {
            width: 100%;
            min-height: 100px;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            resize: none;
        }

        .submit-button {
            margin-top: 10px;
            background: #28a745;
            color: white;
            border: none;
            border-radius: 5px;
            padding: 10px 15px;
            cursor: pointer;
        }

        .submit-button:hover {
            background: #218838;
        }

        .modal {
            display: none;
            position: fixed;
            z-index: 1000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            justify-content: center;
            align-items: center;
        }

        .modal-content {
            background-color: white;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }

        .close-button {
            float: right;
            cursor: pointer;
            color: #aaa;
        }
        .delete-button {
            background: #dc3545;
            color: white;
            border: none;
            border-radius: 5px;
            padding: 5px 10px;
            cursor: pointer;
        }

        .delete-button:hover {
            background: #c82333;
        }
    </style>
</head>
<body>

    <nav>
        <div class="logo">
            <i class="fas fa-graduation-cap" style="color: red;"></i>
            <span class="header-text">課程網站</span>
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
            <a href="${pageContext.request.contextPath}/teacher/S265F?lang=en" style="color: white; text-decoration: none;">切換到英文</a>
        </div>
    </nav>
    
    <button class="add-file-button" onclick="openModal()">新增檔案</button>
    
    <div class="container">
        <div class="box course-box">
            <div class="title">S265F 算法設計與分析（2025 春季）</div>
            <p>此處可以放置課程詳細資訊。</p>
            <div class="file-list">
                <c:if test="${not empty files}">
                    <c:forEach var="file" items="${files}">
                        <div class="file-list-item">
                            <strong>標題：</strong> ${file.title}<br>
                            <strong>檔案名稱：</strong> <a href="${file.fileUrl}" download>${file.fileName}</a>
                            <form action="${pageContext.request.contextPath}/teacher/filedelete" method="post" style="display:inline;">
                                <input type="hidden" name="fileId" value="${file.id}" />
                                <button type="submit" class="delete-button">刪除</button>
                            </form>
                        </div>
                    </c:forEach>
                </c:if>
                <c:if test="${empty files}">
                    <p>尚未上傳任何檔案</p>
                </c:if>
            </div>
        </div>
        <div class="box comment-box">
            <div class="title">評論</div>
            <div class="comment-list">
                <c:forEach var="comment" items="${comments}">
                    <p><strong>${comment.username}</strong>：${comment.content} 
                        <form action="${pageContext.request.contextPath}/teacher/S265F/deleteComment" method="post" style="display:inline;">
                            <input type="hidden" name="commentId" value="${comment.id}" />
                            <button type="submit" class="delete-button">刪除</button>
                        </form>
                    </p>
                </c:forEach>
            </div>
    
            <div class="comment-area">
                <form action="${pageContext.request.contextPath}/teacher/S265F/submit_Comment" method="post">
                    <textarea class="comment-input" name="comment" placeholder="在此輸入您的評論..."></textarea>
                    <button type="submit" class="submit-button">提交</button>
                </form>
            </div>
        </div>
    </div>
    
    <div class="modal" id="addFileModal">
        <div class="modal-content">
            <span class="close-button" onclick="closeModal()">×</span>
            <form action="/HelloSpringSecurity/upload" method="post" enctype="multipart/form-data">
                <h3>上傳筆記</h3>
                <label>標題：</label>
                <input type="text" name="title" required><br><br>
                <label>檔案：</label>
                <input type="file" name="attachments" multiple required/><br><br>
                <button type="submit" class="submit-button">上傳</button>
            </form>
        </div>
    </div>

<script>
    function openModal() {
        document.getElementById('addFileModal').style.display = 'flex';
    }

    function closeModal() {
        document.getElementById('addFileModal').style.display = 'none';
    }

    window.onclick = function(event) {
        const modal = document.getElementById('addFileModal');
        if (event.target === modal) {
            closeModal();
        }
    }
</script>
</body>
</html>
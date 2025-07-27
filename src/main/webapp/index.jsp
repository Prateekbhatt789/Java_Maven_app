<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Typing Speed Checker</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
            background-color: #f4f4f4;
        }
        h1, h2 {
            color: #333;
        }
        .error {
            color: red;
        }
        textarea {
            width: 100%;
            margin-top: 10px;
            padding: 10px;
            font-size: 16px;
        }
        input[type="submit"] {
            margin-top: 10px;
            padding: 10px 20px;
            background-color: #007bff;
            color: white;
            border: none;
            cursor: pointer;
        }
        input[type="submit"]:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <h1>Check Your Typing Speed</h1>
    
    <label for="textInput">Text to type:</label>
    <p><%= request.getAttribute("referenceText") != null ? request.getAttribute("referenceText") : "The quick brown fox jumps over the lazy dog." %></p>
    
    <form action="${pageContext.request.contextPath}/wpm" method="post">
        <textarea id="textInput" name="typedText" rows="4" cols="50" placeholder="Type the text here..." required></textarea>
        <br>
        <input type="submit" value="Check WPM">
    </form>
    
    <h2>
        <% 
            String wpm = (String) request.getAttribute("wpm");
            String error = (String) request.getAttribute("error");
            if (error != null) {
                out.println("<p class='error'>" + error + "</p>");
            }
            if (wpm != null) {
                out.println("Your WPM: " + wpm);
            } else {
                out.println("Your WPM: 0");
            }
        %>
    </h2>
    <script>
        let startTime;
        const textarea = document.getElementById("textInput");
    
        textarea.addEventListener("input", () => {
            if (!startTime) {
                startTime = new Date().getTime();
            }
        });
    
        document.querySelector("form").addEventListener("submit", function (e) {
            if (startTime) {
                const endTime = new Date().getTime();
                const typingTimeInSeconds = (endTime - startTime) / 1000;
    
                const typingTimeField = document.createElement("input");
                typingTimeField.type = "hidden";
                typingTimeField.name = "typingTime";
                typingTimeField.value = typingTimeInSeconds;
                this.appendChild(typingTimeField);
            }
        });
    </script>
</body>
</html>
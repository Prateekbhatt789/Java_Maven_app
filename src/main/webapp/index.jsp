<%@ page import="com.google.gson.JsonArray, com.google.gson.JsonObject" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Speed Checker</title>
</head>
<body>
    <h1>Check your Word Speed</h1>
    
    <label for="textInput">Text to type:</label>
    <p>The quick brown fox jumps over the lazy dog.</p>
    
    <form action="${pageContext.request.contextPath}/YourServletURL" method="post">
        <textarea id="textInput" name="typedText" rows="4" cols="50" placeholder="Type the text here..." required></textarea>
        <br>
        <input type="submit" value="Check WPM">
    </form>
    
    <h2 id="wpmResult">
        <% 
            String wpm = (String) request.getAttribute("wpm");
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
    
        textarea.addEventListener("keydown", () => {
            if (!startTime) {
                startTime = new Date().getTime();
            }
        });
    
        document.querySelector("form").addEventListener("submit", function (e) {
            const endTime = new Date().getTime();
            const typingTimeInSeconds = (endTime - startTime) / 1000;
    
            const typingTimeField = document.createElement("input");
            typingTimeField.type = "hidden";
            typingTimeField.name = "typingTime";
            typingTimeField.value = typingTimeInSeconds;
            this.appendChild(typingTimeField);
        });
    </script>
    
    
</body>
</html>

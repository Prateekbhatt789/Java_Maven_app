<%@ page import="com.google.gson.JsonArray, com.google.gson.JsonObject" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Latest News</title>
</head>
<body>
    <h1>Top News from India</h1>
    <%
        JsonArray articles = (JsonArray) request.getAttribute("articles");
        for (int i = 0; i < articles.size(); i++) {
            JsonObject article = articles.get(i).getAsJsonObject();
    %>
        <div style="border-bottom: 1px solid #ccc; margin-bottom: 10px;">
            <h2><%= article.get("title").getAsString() %></h2>
            <p><%= article.get("description").getAsString() %></p>
            <a href="<%= article.get("url").getAsString() %>" target="_blank">Read more</a>
        </div>
    <%
        }
    %>
</body>
</html>

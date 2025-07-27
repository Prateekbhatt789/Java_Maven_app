package com.example;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.http.*;

public class WPMCalculatorServlet extends HttpServlet {

    // Reference text
    private static final String referenceText = "The quick brown fox jumps over the lazy dog.";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    String typedText = request.getParameter("typedText");
    String typingTimeStr = request.getParameter("typingTime");

    if (typedText == null || typingTimeStr == null) {
        request.setAttribute("wpm", "0");
        request.getRequestDispatcher("index.jsp").forward(request, response);
        return;
    }

    try {
        double typingTimeInSeconds = Double.parseDouble(typingTimeStr);
        if (typingTimeInSeconds <= 0) {
            request.setAttribute("wpm", "0");
            request.setAttribute("error", "Typing time must be greater than zero.");
            request.getRequestDispatcher("/index.jsp").forward(request, response);
            return;
        }

        int numChars = typedText.length();

        // WPM = (chars / 5) / minutes
        int wpm = (int) ((((double) numChars / 5) / typingTimeInSeconds) * 60);

        request.setAttribute("wpm", String.valueOf(wpm));
    } catch (NumberFormatException e) {
        request.setAttribute("wpm", "0");
        request.setAttribute("error", "Invalid typing time format.");
    }
    request.getRequestDispatcher("/index.jsp").forward(request, response);
}
}

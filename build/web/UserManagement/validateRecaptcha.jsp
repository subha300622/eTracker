<%-- 
    Document   : validateRecaptcha
    Created on : 17 Feb, 2016, 4:19:54 PM
    Author     : admin
--%>


<%
    String captchsession = (String) session.getAttribute("captcha");
    String enterCaptch = request.getParameter("captchenter");
    if (captchsession.equals(enterCaptch)) {
        out.print("true");
    }
%>

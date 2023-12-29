<%-- 
    Document   : newAddCandidate
    Created on : 10 Mar, 2016, 9:32:01 AM
    Author     : admin
--%>

<%@page import="pack.eminent.encryption.MakeConnection"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.eminentlabs.erm.ERMUtil"%>
<%--<%@ page language="java" contentType="text/html" pageEncoding="UTF-8" errorPage="/unexpectedNotify.jsp"%>--%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html ">
        <LINK title=STYLE href="<%= request.getContextPath()%>/eminentech support files/main_ie.css" type="text/css" rel=STYLESHEET>
        <TITLE>eOutsource &trade;- Eminent Product Development Life Cycle Management</TITLE>
            <%@ include file="../noScript.jsp" %>

    </head>
    <body>
        <%@ page import="org.apache.log4j.*" %>
        <jsp:useBean id="addCandidate" class="com.eminentlabs.erm.Addcondidtate"></jsp:useBean>
        <jsp:useBean id="rc" class="com.eminentlabs.erm.ResumeController"></jsp:useBean>
            <div align="center">
                <FORM name="theForm" METHOD=POST >
                    <table width="100%">
                        <tr>
                            <td align="center">
                            <%
                                String apid = "";
                                String flag = rc.resumeUpload(request, response, pageContext.getServletContext());
                                //System.out.print("iam in newAddcandidate:" + flag);
                                if (flag.contains("false")) {%>

                            <br>
                            <br>
                            <br>
                            <br>
                            <br>
                            <br>
                            <br>
                            <br>
                            <br>
                            <br>
                            <br>
                            <br>
                            <br> 
                            <br>
                            <br>
                            <br>
                            <TABLE bgColor=#E8EEF7 align="center">
                                <TBODY>

                                    <tr>
                                        <TD align="center"><B><FONT SIZE="6" COLOR="red"> Problem in Applicant Id Creation.</FONT></B></TD>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <div align="Left">Return to Candidate Registration page <a href="<%=request.getContextPath()%>/ERM/register.jsp">Click
                                                    Here </a></div>
                                        </td>
                                    </tr>
                                </TBODY>
                            </TABLE>
                            <%}
                                if (flag.contains("existed")) {
                                    String existingmail = flag.substring(flag.indexOf(",") + 1, flag.indexOf("-"));
                                    String existingapid = flag.substring(flag.indexOf("-") + 1, flag.length());
                                    request.setAttribute("existingmail", existingmail);
                                    request.setAttribute("existingapid", existingapid);
                                    response.sendRedirect(request.getContextPath() + "/ERM/userexist.jsp");

                                } else if (flag.contains("true")) {
                                    apid = flag.substring(flag.indexOf(",") + 1, flag.length());
                                    flag = flag.substring(0, flag.indexOf(","));
                                    String bug = "yes";
                                    session.setAttribute("bug", bug);
                            %>
                             <br>
                            <br>
                            <br>
                            <br>
                            <br>
                            <br>
                            <br>
                            <br>
                            <br>
                            <br>
                            <br>
                            <br>
                            <br> 
                            <br>
                            <br>
                            <br>
                            <table width="80%" align=center border="0">
                                <tr>
                                    <td align="center"><center><FONT SIZE="9" COLOR="#000000">Thank You. Your information has been saved successfully.
                                                <br>
                                                Your application Id is <%=apid%></center>

                                                <br>
                                                Feel free to send your suggestion and feedbacks to E-mail: <a href="mailto:hr@eminentlabs.net"><font color="#006699">hr@eminentlabs.net</center></td></tr>
                                                        <tr>  <td colspan="2" align="center"> <input type="button" name="Close" value="Close" onclick="self.close();" ></td>
                                                        </tr>

                                                        </table>
                                                        <br>

                                                        <%}%>
                                                        </table>

                                                        </Form>
                                                        </div>
                                                        </body>
                                                        </html>
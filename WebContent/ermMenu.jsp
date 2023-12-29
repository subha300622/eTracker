<%-- 
    Document   : ermMenu
    Created on : Feb 14, 2014, 12:36:52 PM
    Author     : E0288
--%>
<%@page import="com.eminentlabs.erm.ErmMenu"%>
<%@page import="com.eminentlabs.erm.ERMUtil"%>
<%@ page import="java.util.List,java.util.HashMap,com.eminent.tqm.TqmUtil,com.eminent.tqm.TestCasePlan,com.eminent.util.ProjectFinder, com.eminent.util.UserIssueCount,com.eminent.util.GetProjectManager,com.eminent.customer.ContactUtil" language="java" contentType="text/html" pageEncoding="UTF-8"%>
<html>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">

    <meta http-equiv="Content-Language" content="en-us">
    <title>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS
        Solution</title>
    <LINK title=STYLE href="eminentech support files/main_ie.css" type="text/css" rel="STYLESHEET">

    <style fprolloverstyle>
        A:hover {
            color: #FF0000;
            font-weight: bold
        }

        .links { text-decoration: none; }


    </style>
    <script language="Javascript">

        //var isNS = (navigator.appName == "Netscape") ? 1 : 0;
        //var EnableRightClick = 0;
        //if(isNS)
        //document.captureEvents(Event.MOUSEDOWN||Event.MOUSEUP);
        //function mischandler(){
        //  if(EnableRightClick==1){ return true; }
        //  else {return false; }
        //}
        //function mousehandler(e){
        //  if(EnableRightClick==1){ return true; }
        //  var myevent = (isNS) ? e : event;
        //  var eventbutton = (isNS) ? myevent.which : myevent.button;
        //  if((eventbutton==2)||(eventbutton==3)) return false;
        //}
        //function keyhandler(e) {
        //  var myevent = (isNS) ? e : window.event;
        //  if (myevent.keyCode==96)
        //    EnableRightClick = 1;
        //  return;
        //}
        //document.oncontextmenu = mischandler;
        //document.onkeypress = keyhandler;
        //document.onmousedown = mousehandler;
        //document.onmouseup = mousehandler;

    </script>
</head>
<body>
    <%

        response.setHeader("Cache-Control", "no-cache"); //Forces caches to obtain a new copy of the page from the origin server
        response.setHeader("Cache-Control", "no-store"); //Directs caches not to store the page under any circumstance
        response.setDateHeader("Expires", 0); //Causes the proxy cache to see the page as "stale"
        response.setHeader("Pragma", "no-cache"); //HTTP 1.0 backward compatibility

        if (session != null) {
    %>

    <table height="13%">
        <tr>
            <td width="145" align="center"><a
                    href="https://www.eminentlabs.net" target="_new"><img border="0"
                                                                     alt="Eminentlabs Software Pvt. Ltd."
                                                                     src="<%=request.getContextPath()%>/eminentech support files/Eminentlabs.png"></a></td>
        </tr>
    </table>
    <table width="87%" bgcolor="#E0ECFF" height="68%">
        <%
            Integer userId = (Integer) session.getAttribute("userid_curr");
            ErmMenu ermMenu = ErmMenu.getErmMenu(request);
        %>
        <tr>
            <td valign="center" width="143" height="100%" valign="center"><font
                    face="Impact" size="10"></font>
                <p><font face="Georgia"><IMG SRC="images/dashboard.jpeg" alt="Project Dashboard"
                                             border="0" align="middle"> <a class="links" target="basefrm"
                                             href="<%=request.getContextPath()%>/admin/dashboard/displayChart.jsp?project=<%= ProjectFinder.findProjectWorkin(userId)%>">
                        Project Dashboard</a></font></p>

                <p><font face="Georgia"><IMG SRC="images/user.jpg" alt="My Dashboard"
                                             border="0" align="middle"> <a target="basefrm" class="links"
                                             href="<%=request.getContextPath()%>/admin/dashboard/myERMDashBoard.jsp">My
                        Dashboard</a></font></p>

                <p><IMG SRC="images/myissue.gif" align="middle" alt="My Issues">
                    <a class="links" target="basefrm" href="<%=request.getContextPath()%>/MyIssues/MyIssues.jsp"> My
                        Issues <%if (ermMenu.getMyIssueCount() > 0) {%>(<%=ermMenu.getMyIssueCount()%>)<%}%></a></font></p>

                <p><font face="Georgia" size="5"><IMG SRC="images/myassign.gif" alt="My Assignment"
                                                      border="0" align="middle"> <a target="basefrm" class="links"
                                                      href="<%=request.getContextPath()%>/ERM/assignedApplicants.jsp">
                        My Assignments <%if (ermMenu.getMyassignmentCount() > 0) {%>(<%=ermMenu.getMyassignmentCount()%>)<%}%></a></font></p>

                <p><font face="Georgia"><IMG SRC="images/search.png" alt="My Searches"
                                             border="0" align="middle" width="16" height="16"> <a
                                             target="basefrm" class="links"
                                             href="<%=request.getContextPath()%>/ERM/ermSearch.jsp">My
                        Searches</a></font></p>
                <p><font face="Georgia"><IMG SRC="images/myquery.gif" alt="My Views"
                                             border="0" align="middle"> <a target="basefrm" class="links"
                                             href="<%=request.getContextPath()%>/MyQuery/MyQueryView.jsp">My
                        Views <%if (ermMenu.getMyViewsCount() > 0) {%>(<%=ermMenu.getMyViewsCount()%>)<%}%></a></font></p>

                <p><font face="Georgia"><IMG SRC="images/Contacts.png" alt="My Contacts"
                                             border="0" align="middle"> <a target="basefrm" class="links"
                                             href="<%=request.getContextPath()%>/contact/viewcontact.jsp">My
                        Contacts <%if (ermMenu.getMyContactsCount() > 0) {%>(<%=ermMenu.getMyContactsCount()%>)<%}%></a></font></p>
                <p><IMG SRC="images/mom.png" alt="Minutes of Meeting"
                        border="0" align="middle" width="16" height="16"><font face="Georgia"><a target="basefrm" class="links"
                        href="<%=request.getContextPath()%>/MOM/momView.jsp"> View MoM </a></font></p>
                  <p><font face="Georgia"><IMG SRC="images/user.gif"
                                  border="0" align="middle"> <a target="basefrm" class="links"
                                  href="<%=request.getContextPath()%>/admin/user/viewuser.jsp">
            Users</a></p>
            </td>
        </tr>
    </table>
    <table>
        <tr>
            <td width="30%" align="left"><font size="2"
                                               face="Verdana, Arial, Helvetica, sans-serif"> <IMG
                                               SRC="<%=request.getContextPath()%>/images/bug.jpg" ALT="Bug"
                                               width="23" height="23" align="middle">&nbsp;&nbsp;<A class="links"
                                               HREF="<%= request.getContextPath()%>/editmodule.jsp?project=eTracker&version=3.0&next=YES"
                                               target="_new">File a bug</A></font></td>
        </tr>
    </table>

    <%
    } else {
    %>


    <%= "Session has been expired"%>
    <%
        }
    %>
</body>
</html>



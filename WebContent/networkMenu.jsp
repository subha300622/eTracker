<%-- 
    Document   : leftFrameNetwork
    Created on : 29 Jul, 2016, 4:16:51 PM
    Author     : EMINENT
--%>

<%@page import="java.util.Date"%>
<%@ page import="java.util.List,com.eminent.tqm.TqmUtil,com.eminent.tqm.TestCasePlan,com.eminent.util.ProjectFinder, com.eminent.util.UserIssueCount,com.eminent.util.GetProjectManager,com.eminent.customer.ContactUtil" language="java" contentType="text/html" pageEncoding="UTF-8"%>
<html>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
        <meta name="GENERATOR" content="Microsoft FrontPage 4.0">
        <meta name="ProgId" content="FrontPage.Editor.Document">
        <meta http-equiv="Content-Type" content="text/html">
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

            var isNS = (navigator.appName == "Netscape") ? 1 : 0;
            var EnableRightClick = 0;
            if (isNS)
                document.captureEvents(Event.MOUSEDOWN || Event.MOUSEUP);
            function mischandler() {
                if (EnableRightClick == 1) {
                    return true;
                }
                else {
                    return false;
                }
            }
            function mousehandler(e) {
                if (EnableRightClick == 1) {
                    return true;
                }
                var myevent = (isNS) ? e : event;
                var eventbutton = (isNS) ? myevent.which : myevent.button;
                if ((eventbutton == 2) || (eventbutton == 3))
                    return false;
            }
            function keyhandler(e) {
                var myevent = (isNS) ? e : window.event;
                if (myevent.keyCode == 96)
                    EnableRightClick = 1;
                return;
            }
            document.oncontextmenu = mischandler;
            document.onkeypress = keyhandler;
            document.onmousedown = mousehandler;
            document.onmouseup = mousehandler;

        </script>
    </head>
    <body>
        <%

            response.setHeader("Cache-Control", "no-cache"); //Forces caches to obtain a new copy of the page from the origin server
            response.setHeader("Cache-Control", "no-store"); //Directs caches not to store the page under any circumstance
            response.setDateHeader("Expires", 0); //Causes the proxy cache to see the page as "stale"
            response.setHeader("Pragma", "no-cache"); //HTTP 1.0 backward compatibility
            if (session.getAttribute("theName") != null) {
        %>
        <jsp:useBean id="vmc" class="com.eminentlabs.mom.controller.ViewMomController"></jsp:useBean>
        <table height="13%">
            <tr>
                <td width="145" align="center"><a
                        href="http://www.eminentlabs.com" target="_new"><img border="0"
                                                                         alt="Eminentlabs Software Pvt. Ltd."
                                                                         src="<%=request.getContextPath()%>/eminentech support files/Eminentlabs.png"></a></td>
            </tr>
        </table>
        <table width="87%" bgcolor="#E0ECFF" height="68%">
            <%
                String mail = (String) session.getAttribute("theName");
                String url = null;
                if (mail != null) {
                    url = mail.substring(mail.indexOf("@") + 1, mail.length());
                }
                Integer userId = (Integer) session.getAttribute("userid_curr");
                String user = userId.toString();
                int count = GetProjectManager.checkProjectManager(user);
                int assinmentNo = UserIssueCount.getAssignmentCount(user);
                int myissueNo = UserIssueCount.getOwnCount(user);
                int myviewsNo = UserIssueCount.getQueryCount(user);
                int mycontactNo = ContactUtil.getContactCount(user);
                int timesheetNo = UserIssueCount.getTimeSheetIssueCount(user);
                //                       List l          =   TqmUtil.listUserPTC(userId);
                //                       int noOfTC      =   l.size();
                int noOfTC = TqmUtil.countUserTestcases(userId);
            %>
            <tr>
                <td valign="center" width="143" height="100%" valign="center"><font
                        face="Impact" size="10"></font>
                    <!--                         <p><font face="Georgia"><IMG SRC="images/dashboard.jpeg" alt="Project Dashboard"
                                            border="0" align="middle"> <a class="links" target="basefrm"
                                            href="<%=request.getContextPath()%>/testMap.jsp?pid=10097">
                                    BPM</a></font></p>-->
                    <p><font face="Georgia"><IMG SRC="images/dashboard.jpeg" alt="Project Dashboard"
                                                 border="0" align="middle"> <a class="links" target="basefrm"
                                                 href="<%=request.getContextPath()%>/admin/dashboard/displayChart.jsp?project=<%= ProjectFinder.findProjectWorkin(userId)%>">
                            Project Dashboard</a></font></p>

                    <p><font face="Georgia"><IMG SRC="images/user.jpg" alt="My Dashboard"
                                                 border="0" align="middle"> <a target="basefrm" class="links"
                                                 href="<%=request.getContextPath()%>/admin/dashboard/chartForUsers.jsp">My
                            Dashboard</a></font></p>
                    <p><font face="Georgia">
                        <IMG SRC="images/myissue.gif" align="middle" alt="My Issues">
                        <a class="links" target="basefrm" href="<%=request.getContextPath()%>/MyIssues/MyIssues.jsp"> My
                            Issues <%if (myissueNo > 0) {%>(<%=myissueNo%>)<%}%></a></font></p>

                    <p><font face="Georgia" size="5"><IMG SRC="images/myassign.gif" alt="My Assignment"
                                                          border="0" align="middle"> <a target="basefrm" class="links"
                                                          href="<%=request.getContextPath()%>/MyAssignment/UpdateIssue.jsp">
                            My Assignments <%if (assinmentNo > 0) {%>(<%=assinmentNo%>)<%}%></a></font></p>
                    <!--
                    <p><font face="Georgia" size="5"><IMG SRC="images/myassign.gif"
                            border="0" align="middle"> <a target="basefrm" class="links"
                            href="<%=request.getContextPath()%>/MyTimeSheet/timeSheetList.jsp">
                    My Assignments <%if (assinmentNo > 0) {%>(<%=assinmentNo%>)<%}%></a></font></p
                    -->

                    <p><font face="Georgia"><IMG SRC="images/create.jpeg" alt="Create Issue"
                                                 border="0" align="middle"> <a target="basefrm" class="links"
                                                 href="<%=request.getContextPath()%>/CreateIssue/createissuenew.jsp">Create
                            Issue</a></font></p>

                    <p><font face="Georgia"><IMG SRC="images/testcase.png" alt="My Test Cases"
                                                 border="0" align="middle"> <a target="basefrm" class="links"
                                                 href="<%=request.getContextPath()%>/admin/tqm/listPTCTest.jsp">My Test Cases <%if (noOfTC > 0) {%>(<%=noOfTC%>)<%}%></a></font></p>

                    <p><font face="Georgia"><IMG SRC="<%=request.getContextPath()%>/images/assets.png"
                                  border="0" align="middle"> <a target="basefrm" class="links"
                                  href="<%=request.getContextPath()%>/admin/resource/viewResources.jsp"
                                  title="Non Live Resources">Assets</a></font></p>
                    <p><font face="Georgia"><IMG SRC="images/search.png" alt="My Searches"
                                                 border="0" align="middle" width="16" height="16"> <a
                                                 target="basefrm" class="links"
                                                 href="<%=request.getContextPath()%>/IssueSummary/IssueSummary.jsp">My
                            Searches</a></font></p>

                    <p><font face="Georgia"><IMG SRC="images/myquery.gif" alt="My Views"
                                                 border="0" align="middle"> <a target="basefrm" class="links"
                                                 href="<%=request.getContextPath()%>/MyQuery/MyQueryView.jsp">My
                            Views <%if (myviewsNo > 0) {%>(<%=myviewsNo%>)<%}%></a></font></p>

                    <p><font face="Georgia"><IMG SRC="images/Contacts.png" alt="My Contacts"
                                                 border="0" align="middle"> <a target="basefrm" class="links"
                                                 href="<%=request.getContextPath()%>/contact/viewcontact.jsp">My
                            Contacts <%if (mycontactNo > 0) {%>(<%=mycontactNo%>)<%}%></a></font></p>
                    <!--
                                    <p><font face="Georgia"><IMG SRC="images/profile.gif"
                                            border="0" align="middle"> <a target="basefrm" class="links"
                                            href="<%=request.getContextPath()%>/test.jsp">My
                    Test <%if (timesheetNo > 0) {%>(<%=timesheetNo%>)<%}%></a></font></p>
                    -->
                    <p><font face="Georgia"><IMG SRC="images/performance.jpg" alt="My Performance"
                                                 border="0" align="middle"> <a target="basefrm" class="links"
                                                 href="<%=request.getContextPath()%>/MyTimeSheet/performanceChart.jsp" <%if (timesheetNo > 0) {%>title="Timesheet(<%=timesheetNo%>)"<%}%>>My
                            Performance </a></font></p>
                            <%if (url.equals("eminentlabs.net")) {
                                 
                                if (vmc.getModList().contains((userId).toString())) {
                                    %>
                     <p><IMG SRC="images/mom.png" alt="Minutes of Meeting"
                            border="0" align="middle" width="16" height="16"><font face="Georgia"><a target="basefrm" class="links"
                            href="<%=request.getContextPath()%>/MOM/mom.jsp"> Send MoM </a></font></p>
                                    <%
                                }
                                    %>
                     <p><IMG SRC="images/mom.png" alt="Minutes of Meeting"
                            border="0" align="middle" width="16" height="16"><font face="Georgia"><a target="basefrm" class="links"
                            href="<%=request.getContextPath()%>/MOM/momView.jsp"> View MoM </a></font></p>
                                    
                            
                   
                        <%}%>
                        <%if (count > 0) {%>
                    <p><font face="Georgia"><IMG SRC="images/people.png" alt="Resource Requisition"
                                                 border="0" align="middle"> <a target="basefrm" class="links"
                                                 href="<%=request.getContextPath()%>/ResourceRequest/viewMyRequest.jsp">My Resource
                            Requisition</a></font></p>
                            <%}%>
                </td>
            </tr>
        </table>
        <table>
            <tr>
                <td width="17%" align="left"><font size="2"
                                                   face="Verdana, Arial, Helvetica, sans-serif"><A class="links"
                                                   HREF="<%= request.getContextPath()%>/editmodule.jsp?project=eTracker&version=3.0&next=YES"
                                                   target="_blank"><IMG
                                                   SRC="<%=request.getContextPath()%>/images/bug.jpg" ALT="Bug"
                                                   width="23" height="23" align="middle">File a bug</A></font></td>
          
                
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


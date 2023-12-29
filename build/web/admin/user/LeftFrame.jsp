<%@page import="java.util.Date"%>
<%@ page import=" com.eminent.util.UserIssueCount" language="java"%>

<%@page import="com.eminent.util.GetProjectManager"%><html>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
    <title>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS
        Solution</title>
    <LINK title=STYLE
          href="<%=request.getContextPath()%>/eminentech support files/main_ie.css"
          type="text/css" rel=STYLESHEET>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
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

    <table>
        <tr>
            <td width="145" align="center"><a
                    href="http://www.eminentlabs.net" target="_new"><img border="0"
                                                                     alt="Eminentlabs Software Pvt. Ltd."
                                                                     src="<%=request.getContextPath()%>/eminentech support files/Eminentlabs.png"></a>
            </td>
        </tr>
    </table>
             <jsp:useBean id="ac" class="com.eminent.Assets.AssetsController" /> 
    <%
        Integer userId = (Integer) session.getAttribute("userid_curr");
        String user = userId.toString();
        int assinmentNo = UserIssueCount.getAssignmentCount(user);
        int myissueNo = UserIssueCount.getOwnCount(user);
        int myviewsNo = UserIssueCount.getQueryCount(user);


    %>
    <br>
    <table bgcolor="#E0ECFF">
        <tr>

            <td><font face="Impact" size="2"><u><b><a target="basefrm" class="links"
                                                  href="<%=request.getContextPath()%>/admin/customer/crmPerformance.jsp"
                                                  title="Customer Relationship Management">CRM</a></b></u></font></td>



</tr>
<tr>
    <td><font face="Georgia"><IMG SRC="images/myquery.gif"
                                  border="0" align="middle"> <a target="basefrm" class="links"
                                  href="<%=request.getContextPath()%>/admin/dashboard/contactStatus.jsp">
            Contact</a></font></td>
</tr>
<tr>
    <td><font face="Georgia"><IMG SRC="images/project.jpeg"
                                  border="0" align="middle"> <a target="basefrm" class="links"
                                  href="<%=request.getContextPath()%>/admin/dashboard/leadStatusDashBoard.jsp">
            Lead</a></font></td>
</tr>

<tr>
    <td><font face="Georgia"><IMG SRC="images/myassign.gif"
                                  border="0" align="middle"> <a target="basefrm" class="links"
                                  href="<%=request.getContextPath()%>/admin/customer/viewOpportunity.jsp">
            Opportunity</a></font></td>
</tr>
<tr>
    <td><font face="Georgia"><IMG SRC="images/myissue.gif"
                                  border="0" align="middle"> <a target="basefrm" class="links"
                                  href="<%=request.getContextPath()%>/admin/customer/viewaccount.jsp">
            Account</a></font></td>
</tr>
<tr>
    <td><font face="Georgia"><IMG SRC="<%=request.getContextPath()%>/images/search.png"
                                  border="0" align="middle" align="middle" width="16" height="16"> <a target="basefrm" class="links"
                                  href="<%=request.getContextPath()%>/admin/customer/crmSearch.jsp">
            CRM Search</a></font></td>
</tr>
<tr>
    <td><font face="Georgia" ><IMG height="20px" width="20px" SRC="<%=request.getContextPath()%>/images/send_email.png"
                                   border="0" align="middle" align="middle" width="16" height="16"><a target="basefrm" class="links" href="<%=request.getContextPath()%>/admin/user/sendBulkMail.jsp"

                                   />Send Bulk Mail</a></font></td>
</tr>

<tr />
<tr />
<tr />
<tr>

    <td><font face="Impact" size="2"><u><b><a target="basefrm" class="links"
                                          href="<%=request.getContextPath()%>/BPM/adminBPM.jsp"

                                          title="Business Process Management">BPM</a></b></u></font></td>
<tr />
<tr />
<tr />
<tr />
<tr>
    <td><font face="Impact" size="2"><u><b><a target="basefrm" class="links"
                                          href="<%=request.getContextPath()%>/admin/user/apmPerformance.jsp"
                                          title="Advanced Project Management">APM</a></b></u></font></td>
</tr>
<tr>
    <td><font face="Georgia"><IMG SRC="images/dashboard.jpeg"
                                  border="0" align="middle"> <a target="basefrm" class="links"
                                  href="<%=request.getContextPath()%>/admin/project/viewproject.jsp">
            Projects</a></font></td>
</tr>
<tr>
    <td><font face="Georgia"><IMG SRC="images/create.jpeg"
                                  border="0" align="middle"> <a target="basefrm" class="links"
                                  href="<%=request.getContextPath()%>/CreateIssue/createissuenew.jsp">Create
            Issue</a></font></td>
</tr>

<tr>
    <td><font face="Georgia"><IMG SRC="images/myissue.gif"
                                  border="0" align="middle"> <a target="basefrm" class="links"
                                  href="<%=request.getContextPath()%>/MyIssues/MyIssues.jsp"> My
            Issues<%if (myissueNo > 0) {%>(<%=myissueNo%>)<%}%></a></font></td>
</tr>
<tr>
    <td><font face="Georgia"><IMG SRC="images/myassign.gif"
                                  border="0" align="middle"> <a target="basefrm" class="links"
                                  href="<%=request.getContextPath()%>/MyAssignment/UpdateIssue.jsp">
            My Assignments  <%if (assinmentNo > 0) {%>(<%=assinmentNo%>)<%}%> </a></font></td>
</tr>
<tr>
    <td><font face="Georgia"><IMG SRC="<%=request.getContextPath()%>/images/search.png" alt="My Searches"
                                  border="0" align="middle" width="16" height="16"> <a
                                  target="basefrm" class="links"
                                  href="<%=request.getContextPath()%>/IssueSummary/IssueSummary.jsp">My
            Searches</a></font></td>
</tr>

<tr>
    <td><font face="Georgia"><IMG SRC="images/myquery.gif"
                                  border="0" align="middle"> <a target="basefrm" class="links"
                                  href="<%=request.getContextPath()%>/MyQuery/MyQueryView.jsp">My
            Views <%if (myviewsNo > 0) {%>(<%=myviewsNo%>)<%}%></a></font></td>
</tr>
<tr>
    <td><IMG SRC="<%=request.getContextPath()%>/images/mom.png" alt="Minutes of Meeting"
             border="0" align="middle" width="16" height="16"><font face="Georgia"><a target="basefrm" class="links"
             href="<%=request.getContextPath()%>/MOM/momView.jsp"> View MoM </a></font>
    </td>
</tr>
<tr />
<tr />
<tr />
<tr />
<tr>

    <td><font face="Impact" size="2"><u><b><a target="basefrm" class="links"
                                          href="<%=request.getContextPath()%>/admin/tqm/tqmPerformance.jsp"
                                          title="Total Quality Management">TQM</a></b></u></font></td>


</tr>
<tr>
    <td><font face="Georgia"><IMG SRC="images/project.jpeg"
                                  border="0" align="middle"> <a target="basefrm" class="links"
                                  href="<%=request.getContextPath()%>/admin/tqm/listCTC.jsp"
                                  title="Common Test Case Management"> CTCM</a></font></td>
</tr>
<tr>
    <td><font face="Georgia"><IMG SRC="images/create.jpeg"
                                  border="0" align="middle"> <a target="basefrm" class="links"
                                  href="<%=request.getContextPath()%>/admin/dashboard/ptcmChart.jsp"
                                  title="Project Test Case Management">PTCM</a></font></td>
</tr>

<tr>
    <td><font face="Georgia"><IMG SRC="<%=request.getContextPath()%>/images/ter.png"
                                  border="0" align="middle"> <a target="basefrm" class="links"
                                  href="<%=request.getContextPath()%>/admin/tqm/listExecutionPlan.jsp"
                                  title="Test Execution Result"> TER</a></font></td>
</tr>
<tr>
<tr />
<tr />
<tr />
<tr />
<tr>
    <td><font face="Impact" size="2"><u
    title="Enterprise Resource Management"><b><a target="basefrm" class="links"
                                                  href="<%=request.getContextPath()%>/ERM/ermAnalysis.jsp"
                                                  title="Enterprise Resource Management">ERM</a></b></u></font></td>
</tr>
<tr>
    <td><font face="Georgia"><IMG SRC="<%=request.getContextPath()%>/images/assets.png"
                                  border="0" align="middle"> <a target="basefrm" class="links"
                                  href="<%=request.getContextPath()%>/admin/resource/viewResources.jsp"
                                  title="Non Live Resources">Assets (<%=ac.getAssetcount()%>)</a></font></td>
</tr>
<tr>
    <td><font face="Georgia"><IMG SRC="images/user.gif"
                                  border="0" align="middle"> <a target="basefrm" class="links"
                                  href="<%=request.getContextPath()%>/admin/user/viewuser.jsp">
            Users</a></font></td>
</tr>

<tr>
    <td><font face="Georgia"><IMG SRC="<%=request.getContextPath()%>/images/profiles.png"
                                  border="0" align="middle"> <a target="basefrm" class="links"
                                  href="<%= request.getContextPath()%>/admin/candidate/eminentProfiles.jsp">Eminent
            Profiles</a></font></td>
</tr>
<tr>
    <td><font face="Georgia"><IMG SRC="images/myissue.gif"
                                  border="0" align="middle"> <a target="basefrm" class="links"
                                  href="<%= request.getContextPath()%>/admin/candidate/wholeApplicants.jsp">Applicants</a></font>
    </td>
</tr>
<tr>
    <td><font face="Georgia"><IMG SRC="<%=request.getContextPath()%>/images/search.png" alt="My Searches"
                                  border="0" align="middle" width="16" height="16"> <a
                                  target="basefrm" class="links"
                                  href="<%=request.getContextPath()%>/ERM/ermSearch.jsp">ERM Searches</a></font>
    </td>
</tr>
<tr>
    <td><font face="Georgia"><IMG SRC="<%= request.getContextPath()%>/images/people.png" alt="Resource Requisition"
                                  border="0" align="middle"> <a target="basefrm" class="links"
                                  href="<%= request.getContextPath()%>/ResourceRequest/viewResourceRequest.jsp">Resource Requests </a></font>
    </td>
</tr>
</table>

<table>
    <tr>
        <td width="25%" align="left"><font size="2"
                                           face="Verdana, Arial, Helvetica, sans-serif"> <IMG
                                           SRC="<%=request.getContextPath()%>/images/bug.jpg" ALT="Bug"
                                           width="23" height="20" align="middle"/>&nbsp;&nbsp;<A class="links"
                                           HREF="<%= request.getContextPath()%>/editmodule.jsp?project=eTracker&version=3.0&next=YES"
                                           target="_new">File a bug</A></font></td>              
    </tr>
</table>

</body>
</html>
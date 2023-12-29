<%-- 
    Document   : printWRM
    Created on : Jun 27, 2014, 10:46:41 AM
    Author     : E0288
--%>

<%@page import="org.apache.log4j.Logger"%>
<%@page import="com.eminentlabs.mom.ApmWrmPlan"%>
<%@page import="com.eminent.issue.formbean.IssueFormBean"%>
<%@page import="com.eminentlabs.mom.formbean.MomForClientFormbean"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Cache-Control", "no-store");
    response.setDateHeader("Expires", 0);
    response.setHeader("Pragma", "no-cache");

    Logger logger = Logger.getLogger("editMomForClient");
    String logoutcheck = (String) session.getAttribute("Name");
    if (logoutcheck == null) {
        logger.fatal("==============Session Expired===============");
%>
<jsp:forward page="../SessionExpired.jsp"></jsp:forward>
<%
    }

%>
<html>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS Solution</title>
        <LINK title=STYLE href="<%= request.getContextPath()%>/eminentech support files/main_ie.css" type="text/css" rel="STYLESHEET">
        <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/jquery.js"></script>
        <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/tooltip.js"></script>
        <script src="<%=request.getContextPath()%>/javaScript/jquery.tablesorter.min.js" type="text/javascript"></script>

        <script type="text/javascript">
            function callPrint() {
                document.getElementById("print").style.display = 'none';
                window.print();
                document.getElementById("print").style.display = 'block';
            }
            function KillBrowser()
            {
                opener.focus();
                self.close();
            }
        </script>
    </head>
    <body>
        <%--<jsp:forward page="../whenDevelopment.jsp"></jsp:forward>--%>
        <div style="text-align: center;">
            <center>
                <table align="center" width="100%" cellpadding="0" cellspacing="0">
                    <tr style="height: 20px;">

                        <td width="145" align="left"><a
                                href="http://www.eminentlabs.com" target="_new"><img border="0" height="28"
                                                                                 alt="Eminentlabs Software Pvt. Ltd."
                                                                                 src="<%=request.getContextPath()%>/eminentech support files/Eminentlabs.png"></a></td>
                        <td align="right">
                            <img alt="Eminentlabs Software Pvt Ltd" height="25" src="<%= request.getContextPath()%>/eminentech support files/Eminentlabs_logo.gif">
                        </td>
                    </tr>
                </table>
                <br/>
                <jsp:useBean id="twm" class="com.eminentlabs.mom.TeamWiseMom"></jsp:useBean>
                <%twm.printWRM(request);
                    if (twm.isProjectAccess() == false) {%>
                <div style="text-align: center;color: red;">You are not authorized to access it</div>
                <%} else {%>
                <table style="background-color: #E8EEF7;width:100%;" >
                    <%for (MomForClientFormbean mfcf : twm.getMomForClients()) {%>
                    <tr style='height:25px;background-color: #C3D9FE;'><td colspan="12" style="color: blue;font-weight: bold;">WRM Held On <%=mfcf.getHeldOn()%></td></tr>
                    <tr style='height:21px;'>
                        <td style='font-weight: bold;width:16%;'>Held On </td><td style='width:1%;'>:</td><td style='width:10%;'><%=mfcf.getHeldOn()%></td>
                        <td style='font-weight: bold;width:8%;'>Held At </td><td style='width:1%;'>:</td><td  style='width:30%;'><%=mfcf.getHeldAt()%></td>
                        <td style='font-weight: bold;width:12%;'>Start Time</td><td style='width:1%;'>:</td><td  style='width:8%;'><%=mfcf.getStartTime()%></td>
                        <td style='font-weight: bold;width:12%;'>End Time</td><td style='width:1%;'>:</td><td  style='width:8%;'><%=mfcf.getEndTime()%></td>
                    </tr>
                    <tr style='height:21px;'>
                        <td style='font-weight: bold;'>Attendees </td><td>:</td><td colspan='8' align='left' id='tdattendies'><%=mfcf.getAttendies()%></td>
                    </tr>
                    <%if (mfcf.getWrmplanIssueDetails().size() > 0) {%>
                    <tr style="font-weight: bold;color: blue;"><td colspan="16">Issues Reviewed and Committed for Next Week</td></tr>

                    <tr>
                        <td colspan="16">
                            <table style="width: 100%;" id="wrmPlanTable" class="tablesorter">
                                <thead> 
                                    <tr>
                                        <TH class="header" width="12%"><font><b>Issue No</b></font></TH>
                                        <TH class="header" width="7%"><font><b>Module</b></font></TH>
                                        <TH class="header" width="28%"><font><b>Subject</b></font></TH>
                                        <th class="header"><font><b>Review Comments</b></font></th>
                                    </tr>
                                </thead>


                                <%int k = 0;String rating = "",color="";
                                    for (IssueFormBean isfb : mfcf.getWrmplanIssueDetails()) {
                                        k++;
                                        if ((k % 2) == 0) {

                                %>
                                <tr bgcolor="#E8EEF7" height="23">
                                    <%                } else {
                                    %>

                                <tr bgcolor="white" height="23">
                                    <%                    }rating  =    isfb.getRating();
                              color="";
                                        if(rating!=null){
                                            if(rating.equalsIgnoreCase("Excellent")){
                                                color   = "#336600";

                                            }else if(rating.equalsIgnoreCase("Good")){
                                                color   = "#33CC66";

                                            }else if(rating.equalsIgnoreCase("Average")){
                                                color   = "#CC9900";

                                            }else if(rating.equalsIgnoreCase("Need Improvement")){
                                                color   = "#CC0000";

                                            }
                                            
                                            
                            }
                                     
                                    %>
                                    <td width="11%" title="<%=isfb.getType()%>" bgcolor='<%=color%>'><a href="${pageContext.servletContext.contextPath}/Issuesummaryview.jsp?issueid=<%=isfb.getIssueId()%>"><%=isfb.getIssueId()%></a></td>
                                    <td width="7%" title="<%=isfb.getmName()%>"><%=isfb.getRedMName()%></td>
                                    <td width="29%" id="<%=isfb.getIssueId()%>tab" onmouseover="xstooltip_show('<%=isfb.getIssueId()%>', '<%=isfb.getIssueId()%>tab', 289, 49);" onmouseout="xstooltip_hide('<%=isfb.getIssueId()%>');" ><div class="issuetooltip" id="<%=isfb.getIssueId()%>"><%= isfb.getDescription()%></div><%=isfb.getSubject()%></td>
                                    <td>
                                        <%
                                            String comments = null;
                                            for (ApmWrmPlan awp : mfcf.getWrmPlanList()) {
                                                if (awp.getIssueid().equalsIgnoreCase(isfb.getIssueId())) {
                                                    comments = awp.getComments();
                                                }
                                            }
                                            if (comments == null) {
                                                comments = "";
                                            }
                                        %>
                                        <%=comments%>
                                    </td>
                                </tr>

                                <%}%>
                            </table>
                        </td></tr>
                        <%}
                                 if (mfcf.getAdditonalClosedIssueDetails().size() > 0) {%>
                    <tr>
                        <td colspan="16"><font color='blue' style="font-weight: bold;">Additional Issues Closed</font></td></tr>

                    <tr id="test1">
                        <td colspan="16">
                            <table style="width: 100%;" id="wrmAdditionalTable" class="tablesorter">
                                <thead> 
                                    <tr>
                                        <!--                                //     <TH style="background-color: #C3D9FF;" width="1%" TITLE="Severity"><font><b>S</b></font></TH>-->
                                        <TH class="header" width="12%"><font><b>Issue No</b></font></TH>
                                        <!--<TH class="header" width="2%" TITLE="Priority"><font><b>P</b></font></TH>-->
                                        <TH class="header" width="17%"><font><b>Module</b></font></TH>
                                        <TH class="header" width="68%"><font><b>Subject</b></font></TH>
                                    </tr>
                                </thead>


                                <%int p = 0;
                                    for (IssueFormBean isfb : mfcf.getAdditonalClosedIssueDetails()) {
                                        p++;
                                        if ((p % 2) == 0) {

                                %>
                                <tr bgcolor="#E8EEF7" height="23">
                                    <%                } else {
                                    %>

                                <tr bgcolor="white" height="23">
                                    <%                    }

                                    %>
                                    <td width="11%" title="<%=isfb.getType()%>" bgcolor="<%=isfb.getRatingColor()%>"><a href="${pageContext.servletContext.contextPath}/viewIssueDetails.jsp?issueid=<%=isfb.getIssueId()%>" target="_blank"><%=isfb.getIssueId()%></a></td>
                                    <td width="7%" title="<%=isfb.getmName()%>"><%=isfb.getRedMName()%></td>
                                    <td width="29%" id="<%=isfb.getIssueId()%>tab" onmouseover="xstooltip_show('<%=isfb.getIssueId()%>', '<%=isfb.getIssueId()%>tab', 289, 49);" onmouseout="xstooltip_hide('<%=isfb.getIssueId()%>');" ><div class="issuetooltip" id="<%=isfb.getIssueId()%>"><%= isfb.getDescription()%></div><%=isfb.getSubject()%></td>

                                </tr>
                                <%}%>
                            </table>
                        </td>
                    </tr>
                    <%}%>
                    <tr>
                        <td style='font-weight: bold;'>Points Discussed </td><td>:</td><td colspan='10' align='left' id='tddiscussion'>
                            <font size='2' face='Verdana, Arial, Helvetica, sans-serif'> <%=mfcf.getDiscussion()%></font></td>
                    </tr>
                    <tr>
                        <td style='font-weight: bold;height: 21px;'>Rating </td><td>:</td><td  align='left' id='tddiscussion'>
                            <font size='2' face='Verdana, Arial, Helvetica, sans-serif'> <%=mfcf.getmRating()%></font></td>
                        <td style='font-weight: bold;height: 21px;'>Feedback </td><td>:</td><td  align='left' id='tddiscussion'>
                            <font size='2' face='Verdana, Arial, Helvetica, sans-serif'> <%=mfcf.getmFeedback()%></font></td>
                    </tr>

                    <tr><td style='font-weight: bold;'>Escalation</td><td>:</td>
                        <td colspan='10' ><%=mfcf.getEscalation()%></td>
                    </tr>
                    <%
                        if (!mfcf.getResponsiblePerson().equalsIgnoreCase("NA")) {%>
                    <tr>
                        <td style='font-weight: bold;'>Responsible Person</td><td>:</td><td colspan='10' ><%=mfcf.getResponsiblePerson()%></td>
                    </tr>
                    <%}
                        }%>
                    <tr align="right">
                        <td colspan="3" id="print"><input type="button" name="print" value="Print"
                                                          onclick="javascript:callPrint();" /><input type="button"
                                                          name="Close" value="Close" onclick="javascript:KillBrowser()" /></td>
                    </tr>
                </table>
                <%}%>
                <br>
                <br>
                <TABLE bgColor="#C3D9FF" border=0 width="100%">
                    <tbody>
                        <TR>
                            <TD align=center noWrap vAlign=top width="50%" height="150%">
                                <font face="Verdana" size="4" color="#666666">
                                KPI Tracker&#153;, ERPDS&#153;, EWE&#153;, eTracker&#153;, eOutsource&#153;, Rightshore&#153; are registered trademarks of Eminentlabs&#153; Software Private Limited
                                </font>
                            </TD>

                        </TR>
                    </TBODY>
                </TABLE>
            </center>
        </div>
    </body>
    <script>
        $(document).ready(function()
        {
            $(".tablesorter").tablesorter({
                // change the multi sort key from the default shift to alt button 


            });
        });
    </script>
</html>

<%-- 
    Document   : BestPMNTeam
    Created on : Aug 13, 2014, 7:48:06 AM
    Author     : RN.Khans
--%>

<%@page import="com.eminent.issue.ApmTeam"%>
<%@page import="com.eminentlabs.mom.BestPMTeamBean"%>
<%@page import="com.eminent.issue.formbean.IssueFormBean"%>
<%@page import="com.eminentlabs.mom.formbean.PMReportFormBean"%>
<%@page import="java.util.Map"%>
<%@page import="org.apache.log4j.Logger"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    Logger logger = Logger.getLogger("BestPMandTeamReport");
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
        <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/checkSubmit.js"></script>
        <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/jquery.js"></script>
        <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/slide.js"></script>
        <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/tooltip.js"></script>
        <script language=javascript src="<%= request.getContextPath()%>/eminentech support files/datetimepicker.js"></script>
        <style type="text/css" >
            .r_c {
                float: right;
                width: 30%;
            }
            .l_c {
                float: left;
                width: 65%;
            }
        </style>
       

    </head>
    <body>
        <%@ include file="/header.jsp"%>

        <jsp:useBean id="best" class="com.eminentlabs.mom.BestTeamNPM"></jsp:useBean>

        <jsp:useBean id="mas" class="com.eminent.issue.formbean.MyAsignmentIssues" /> 
 <jsp:useBean id="mwd" class="com.eminent.branch.BranchController"></jsp:useBean>
 <jsp:useBean id="smmc" class="com.eminentlabs.mom.controller.SendMomMaintainController"></jsp:useBean>
    <%mwd.getAllBranchMap();%>
    <%
       int wrmSize= mas.wrmIssues().size();
   best.setAll(request);%>

        <br/>
        <%int assignedto = (Integer) session.getAttribute("userid_curr");
         smmc.getLocationNBranch(assignedto);%>
        <table cellpadding="0" cellspacing="0" width="100%">
            <tr border="2" bgcolor="#C3D9FF">
                <td border="1" align="left" width="70%">
                    <font size="8" COLOR="#0000FF"><b>Best Team and Project Manager Report for <%=best.getYear()%></b></font>

                </td>

            </tr>
        </table>      

        <table cellpadding="0" cellspacing="0" width="100%">

            <tr>
                <td style="height: 25px;">
                    <a href="<%=request.getContextPath()%>/MOM/addTask.jsp"> Add Issue / Task</a>&nbsp;&nbsp;&nbsp;&nbsp;
                    <a href="<%=request.getContextPath()%>/MOM/viewTask.jsp" style="cursor: pointer;">View Issue / Task</a> &nbsp;&nbsp;&nbsp;
                     <%if (smmc.getSendMomMaintenance() != null && smmc.getSendMomMaintenance().getUserId() != null && smmc.getSendMomMaintenance().getUserId().intValue() == assignedto) {
                    %>
                     <a href="<%=request.getContextPath()%>/MOM/mom.jsp" style="cursor: pointer;">Send MOM</a> &nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/MOM/plannedIssuesReport.jsp" style="cursor: pointer;">Planned Issue Report</a> &nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/MOM/feedBackCommand.jsp" style="cursor: pointer;">FeedBack</a> &nbsp;&nbsp;&nbsp;
                <a title="Fine Management" href="<%=request.getContextPath()%>/MOM/addFineAmtForUser.jsp" style="cursor: pointer;">Fine Mgmt</a> &nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/MOM/projectWiseClosedReport.jsp" style="cursor: pointer;">PM'S Rank</a> &nbsp;&nbsp;&nbsp;
                <%                 } else {
                %>
                <a href="<%=request.getContextPath()%>/MOM/fineAmtReort.jsp" style="cursor: pointer;">Fine Amount </a> &nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/MOM/fineReport.jsp" style="cursor: pointer;">Fine Report</a> &nbsp;&nbsp;&nbsp;
                <%}%>
                <a href="<%=request.getContextPath()%>/MOM/weekPerformers.jsp" style="cursor: pointer;">Team Performance</a> &nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/MOM/bestPMNTeam.jsp" style="cursor: pointer; font-weight: bold;">Best PM/Team</a> &nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/MOM/dueDateReport.jsp" style="cursor: pointer; ">DDR</a> &nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/MOM/wrmIssues.jsp" style="cursor: pointer; ">WRM Issues (<%=wrmSize%>)</a> &nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/Reimbursement/reimbursementUpload.jsp" style="cursor: pointer; ">Reimbursement</a> &nbsp;&nbsp;&nbsp;
                </td>
            </tr>
        </table>
                <form name="theForm" action="<%=request.getContextPath()%>/MOM/bestPMNTeam.jsp" method="post">
            <table bgcolor="E8EEF7" width="100%" >
                <tr>
                    <td style="font-weight: bold; text-align: right;">Select Year :
                        <select name="year" id="year"  >
                            <% for (String years : best.getYears()) {
                                    if (years.equalsIgnoreCase(best.getYear())) {
                            %>
                            <option value="<%=years%>" selected="true"><%=years%></option>                                                    
                            <%} else {%>
                            <option value="<%=years%>"><%=years%></option>     
                            <%}
                                }%>
<!--                                    <option value="<%=Integer.parseInt(best.getYear()) - 1%>" ><%=Integer.parseInt(best.getYear()) - 1%></option>                                                    
                            <option value="<%=best.getYear()%>" selected="true"><%=best.getYear()%></option>                                                    
                            <option value="<%=Integer.parseInt(best.getYear()) + 1%>" ><%=Integer.parseInt(best.getYear()) + 1%></option>                                                    -->
                        </select>
                    </td>
                    <td >
                          <td>  <select id="branch" name="branch" >
                    <option value="">All Location</option>
                        <%if (!mwd.getBranchMap().isEmpty()) {
                                for (Map.Entry<Integer, String> entry : mwd.getBranchMap().entrySet()) {%>
                                <option value="<%=entry.getKey()%>" <%if(best.getBranch()==entry.getKey()){%> selected=""<%}%>><%=entry.getValue()%></option>
                        <%}
                            }%>                                                
                    </select>
                         <input type="submit" name="submit" id="submit" value="Search"></td>
                </tr>
            </table>
        </form>
        <br/>
        <div>  
            <div class="l_c">
                <table cellpadding="0" cellspacing="0" width="100%">
                    <tr border="2" bgcolor="#C3D9FF">
                        <td border="1" align="left" width="70%">
                            <font size="10" COLOR="#0000FF"><b>Best Project Manager Report for <%=best.getYear()%></b></font>
                        </td>
                    </tr>
                </table>
                <br/>

                <table  style="width: 100%;text-align: left;">
                    <tr style="background-color: #C3D9FF;font-weight: bold;">
                        <td style="width:20%;">Start Date</td>
                        <td style="width:20%;">End Date</td>
                        <td style="width:30%;">Project</td>
                        <td style="width:30%;">Project Manager</td>
                    </tr>
                </table>
                <table  style="width: 100%;text-align: left;">
                    <tr >
                        <% int i = 0;

                            for (BestPMTeamBean bestPM : best.getBestPMList()) {
                                if ((i % 2) != 0) {
                        %>
                    <tr bgcolor="#E8EEF7" height="21">
                        <%} else {%>
                    <tr bgcolor="white" height="21">
                        <%                    }
                            i++;%>
                        <td style="width:20%;"><%=bestPM.getStartDate()%></td>
                        <td style="width:20%;"><%=bestPM.getEndDate()%></td>
                        <td style="width: 30%;"><%=bestPM.getProjectName()%></td>
                        <td style="width: 30%;"><%=bestPM.getpManager()%></td>      
                    </tr>             
                    <%}%>
                </table>
            </div>  
            <div class="r_c">
                <br/><br/>
                <%int highestPMCount = 0;
                    if (!best.getPmCountResult().isEmpty()) {%>
                <table  style="width: 100%;text-align: left;font-weight: bold;">
                    <tr style="background-color: #C3D9FF; ">
                        <td style="width:50%;">Best Project Manager</td>
                        <td style="width:50%;">Count</td>
                    </tr>
                    <table  style="width: 100%;text-align: left; font-size:  xx-large ;">
                        <tr >
                            <% int m = 0;

                                highestPMCount = best.getPmCountResult().get(0).getValue();

                                for (Map.Entry<String, Integer> entry : best.getPmCountResult()) {
                                    if ((m % 2) != 0) {
                            %>
                        <tr bgcolor="#E8EEF7" height="21">
                            <%} else {%>
                        <tr bgcolor="white" height="21">
                            <%                    }
                                m++;%>
                            <%if (highestPMCount == entry.getValue()) {%>
                            <td style="width:50%;"> <font style="color: green; font-weight: bold; size: 20"><%=entry.getKey()%></font></td>
                            <td style="width:50%;"> <font style="color:  green; font-weight: bold;" ><%=entry.getValue()%></font></td>
                                <%} else {%>
                            <td style="width:50%;"><%=entry.getKey()%></td>
                            <td style="width:50%;"><%=entry.getValue()%></td>
                            <%}
                                }%>
                        </tr>

                        <%  int t = 0;
                            for (String missingPM : best.getAllActivePM()) {
                                if (!best.getAllActivePMFromCount().contains(missingPM)) {
                                    if ((t % 2) != 0) {
                        %><tr bgcolor="#E8EEF7" height="21">
                            <%} else {%>
                        <tr bgcolor="white" height="21">
                            <%                    }
                                t++;%>
                            <td style="width:50%;"> <font style="color: red;font-weight: bold;"><%=missingPM%></font></td>
                            <td style="width:50%;"> <font style="color: red;font-weight: bold;">0</font></td></tr>
                                <%}
                                    }%>
                    </table>
                    <%}
                    %>
                    <br/>

            </div>  
        </div>     



        <div>  
            <div class="l_c">
                <br/><br/>
                <table cellpadding="0" cellspacing="0" width="100%">
                    <tr border="2" bgcolor="#C3D9FF">
                        <td border="1" align="left" width="70%">
                            <font size="8" COLOR="#0000FF"><b>Best Team Report for <%=best.getYear()%></b></font>
                        </td>

                    </tr>
                </table>

                <br/>
                <table  style="width: 100%;text-align: left;">
                    <tr style="background-color: #C3D9FF; font-weight: bold;">
                        <td style="width:30%;">Start Date</td>
                        <td style="width:30%;">End Date</td>
                        <td style="width:30%;">Team</td>

                    </tr>
              
                    <tr >
                        <% int j = 0;
                            for (BestPMTeamBean bestTeam : best.getBestTeamList()) {
                                if ((j % 2) != 0) {
                        %>
                    <tr bgcolor="#E8EEF7" height="21">
                        <%} else {%>
                    <tr bgcolor="white" height="21">
                        <%                    }
                            j++;%>
                        <td style="width:30%;"><%=bestTeam.getStartDate()%></td>
                        <td style="width:30%;"><%=bestTeam.getEndDate()%></td>
                        <td style="width:30%;">
                            <%if (bestTeam.getTeam().equalsIgnoreCase("NA")) {%>
                            <font style="color: red"><%=bestTeam.getTeam()%>
                            <% } else {%>
                            <%=bestTeam.getTeam()%>
                            <%}%>
                        </td>
                    </tr>             
                    <%}%>
                </table>
            </div>  
            <div class="r_c">
                <br/><br/> <br/><br/>
                <%int highestTeamCount = 0;
                    if (!best.getTeamCountResult().isEmpty()) {%>
                <table  style="width: 100%;text-align: left;font-weight: bold;">
                    <tr style="background-color: #C3D9FF;">
                        <td style="width:50%;">Best Team</td>
                        <td style="width:50%;">Count</td>
                    </tr>
                </table>
                <table  style="width: 100%;text-align: left;font-size: medium ;">
                    <% int n = 0;

                        highestTeamCount = best.getTeamCountResult().get(0).getValue();

                        for (Map.Entry<String, Integer> entry : best.getTeamCountResult()) {
                            if ((n % 2) != 0) {
                    %>
                    <tr bgcolor="#E8EEF7" height="21">
                        <%} else {%>
                    <tr bgcolor="white" height="21">
                        <%                    }
                            n++;%>
                        <%if (highestTeamCount == entry.getValue()) {%>
                        <td style="width:50%;"> <font style="color: green;font-weight: bold;"><%=entry.getKey()%></font></td>
                        <td style="width:50%;"> <font style="color: green;font-weight: bold;"><%=entry.getValue()%></font></td>
                            <%} else {%>
                        <td style="width:50%;"><%=entry.getKey()%></td>
                        <td style="width:50%;"><%=entry.getValue()%></td>
                        <%}
                            }%>
                    </tr>

                    <%  int p = 0;
                        for (String missingTeam : best.getAllTeam()) {
                            if (!best.getAllTeamFromCount().contains(missingTeam)) {
                                if ((p % 2) != 0) {
                    %><tr bgcolor="#E8EEF7" height="21">
                        <%} else {%>
                    <tr bgcolor="white" height="21">
                        <%                    }
                            p++;%>
                        <td style="width:50%;"> <font style="color: red;font-weight: bold;"><%=missingTeam%></font></td>
                        <td style="width:50%;"> <font style="color: red;font-weight: bold;">0</font></td></tr>
                            <%}
                                }%>
                </table>
                <%}
                %>
                <br/>
            </div>  
        </div>         
    </body>
</html>

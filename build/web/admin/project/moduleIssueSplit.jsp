<%-- 
    Document   : moduleIssueSplit
    Created on : 19 Dec, 2014, 5:24:04 PM
    Author     : Tamilvelan
--%>

<%@page import="com.eminent.util.bean.ModuleWaiseCountBean"%>
<%@page import="java.util.List"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="org.apache.log4j.Logger,com.eminent.util.ProjectFinder"%>
<%
    //Configuring log4j properties
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Cache-Control", "no-store");
    response.setDateHeader("Expires", 0);
    response.setHeader("Pragma", "no-cache");
    Logger logger = Logger.getLogger("moduleIssueSplit");
    String logoutcheck = (String) session.getAttribute("Name");
    if (logoutcheck == null) {
%>
<jsp:forward page="/SessionExpired.jsp"></jsp:forward>
<%    }

%>
<!DOCTYPE html>
<html>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

    <title>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS Solution</title>
    <LINK title=STYLE href="<%= request.getContextPath()%>/eminentech support files/main_ie.css"  type="text/css" rel=STYLESHEET>

</head>
<%@ include file="/header.jsp"%>
<body>
    <table cellpadding="0" cellspacing="0" width="100%" bgColor="#C3D9FF">
        <tr border="2">
            <td border="1" align="left" width="100%"><font size="4" COLOR="#0000FF"><b>Issue Analysis</b></font> <FONT SIZE="3" COLOR="#0000FF"> </FONT></td>
        </tr>
    </table>
    <br>
    <table width="100%" border="0">
        <tr>
            <td>
                <a href="<%=request.getContextPath()%>/admin/project/createProject.jsp">Add Project</a>&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/admin/project/maintainDays.jsp">Maintain SLA</a>&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/admin/project/treePrintAccess.jsp">Tree Print Access</a>&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/admin/project/viewWRM.jsp">WRM Days</a>&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/admin/project/apmTeam.jsp">Team Maintenance</a>&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/admin/project/moduleIssueSplit.jsp">Issue Analysis</a>&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/admin/project/momMaintanance.jsp" >MoM Maintenance</a>&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/admin/project/trDisplay.jsp" >TR Display</a>&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/admin/project/manageTR.jsp" >TR Pattern</a>&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/admin/project/uploadIssues.jsp" >Upload Issues</a>&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/admin/project/viewAttachedImages.jsp" style="cursor: pointer;">View Attached Images</a>&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/admin/project/gstLogs.jsp" style="cursor: pointer;">GST 3in1 Cockpit</a>&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/admin/dashboard/gnattChartAdmin.jsp" style="cursor: pointer;">Gantt Chart</a>
                <a href="<%=request.getContextPath()%>/admin/project/maintainSapSystems.jsp" style="cursor: pointer;">Maintain SAP Systems</a>
                <a href="<%=request.getContextPath()%>/admin/project/demoProjects.jsp" style="cursor: pointer;">Demo(11)</a>
                <a href="<%=request.getContextPath()%>/admin/project/daywiseEInvoiceCount.jsp" style="cursor: pointer;">Daywise E-Invoice</a>

            </td>
            <td></td>

        </tr>
    </table>
    <br>
    <jsp:useBean id="ProjectFinder" class="com.eminent.util.ProjectFinder"/>
    <%String value = "";
        String projectIssueSplit[][] = ProjectFinder.getModuleSplit();
        int noOfColumns = projectIssueSplit[0].length;
        int noOfRows = projectIssueSplit.length;
        int largestCol = 0, largestRow = 0, colIndex = 0, rowIndex = 0;
        try {

            largestCol = Integer.parseInt(projectIssueSplit[1][noOfColumns - 1]);
            for (int i = 2; i < noOfRows - 3; i++) {

                if (Integer.parseInt(projectIssueSplit[i][noOfColumns - 1]) > largestCol) {
                    largestCol = Integer.parseInt(projectIssueSplit[i][noOfColumns - 1]);
                    logger.info("Largest No Column Index" + largestCol);
                    colIndex = i;
                }

            }
        } catch (Exception e) {
            logger.error(e.getMessage());
        }
        try {

            largestRow = Integer.parseInt(projectIssueSplit[noOfRows - 3][1]);
            for (int i = 2; i < noOfColumns - 1; i++) {

                if (Integer.parseInt(projectIssueSplit[noOfRows - 3][i]) > largestRow) {
                    largestRow = Integer.parseInt(projectIssueSplit[noOfRows - 3][i]);
                    rowIndex = i;
                    logger.info("Largest No Row Index" + largestRow);
                }

            }
        } catch (Exception e) {
            logger.error(e.getMessage());
        }
    %>
    <table width="100%" style=" border: 1px solid #ccccff;border-collapse:collapse;" id="issueSplit" class="tablesorter">

        <thead>
            <tr bgColor="#C3D9FF" height="21" style=" border: 1px solid #ccccff;">

                <% String[][] monitor = ProjectFinder.getBasisMonitoring(request);
                    try {
                        String projSplit = "", title = "";
                        for (String s : monitor[0]) {
                            if (s == null) {
                                s = "";
                            }
                            try {
                                //                   logger.info("Proj Name"+s);
                                projSplit = s.substring(0, s.indexOf("***"));

                                title = s.substring(s.indexOf("***") + 3, s.length());
                            } catch (Exception e) {
                                //              logger.error(e.getMessage());
                                projSplit = "";
                                title = "";
                            }
                %>  

                <th class="header" style=" border: 1px solid #ccccff;" title="<%=title%>"><b><%=projSplit%></th>
                    <%
                            }
                        } catch (Exception e) {
                            logger.error(e.getMessage());
                        }
                    %>
        </thead>

    </tr>
    <tbody>
        <%noOfRows = monitor.length;
            String prid = "", sid = "";
            for (int m = 1; m < monitor.length; m++) { %>
        <tr <%if (m % 2 == 0) {%>class="zebraline"<%} else {%>class="zebralinealter"<%}%>>
            <%
                for (int j = 0; j < monitor[0].length; j++) {
                    value = monitor[m][j];
                    if (value == null) {
                        value = "";
                    }
                    if (m > 0 && j > 0) {
                        String[] resu = value.split("@@@");
                        prid = resu[0];
                        sid = resu[1];
                        value = resu[2];
                    }

                    if (m > 0 && j == 0) {
            %>
            <td style=" border: 1px solid #ccccff;"><b><%=value%></b> </td>

            <%
            } else {
            %>
            <td style=" border: 1px solid #ccccff;color:white;background-color:  <%if (value.equals("Monitored")) {%>green; <%} else {%>red;<%}%>">
                <a  style="color:white;"  <%if (value.contains("Monitored")) {%>    
                    href="<%=request.getContextPath()%>/admin/project/monitoringStatus.jsp?pid=<%=prid%>&serverId=<%=sid%>"
                    <%} else if (value.contains("Matrix Not Maintained")) {%>
                    href="<%=request.getContextPath()%>/admin/project/editproject.jsp?pid=<%=prid%>"
                    <%} else if (value.contains("Parameter Not Maintained")) {%>
                    href="<%=request.getContextPath()%>/admin/project/maintainMonitoring.jsp?pid=<%=prid%>&serverId=<%=sid%>"
                    <%}%>>
                    <%=value%> </a></td>
                    <%}
                        }
                    %>

        </tr>
        <%}%>
    </tbody>

</table>
<br/>
<table width="100%" style=" border: 1px solid #ccccff;border-collapse:collapse;" id="issueSplit" class="tablesorter">

    <thead>
        <tr bgColor="#C3D9FF" height="21" style=" border: 1px solid #ccccff;">

            <%                    try {
                    String projSplit = "", title = "";
                    for (String s : projectIssueSplit[0]) {
                        if (s == null) {
                            s = "";
                        }
                        try {
                            //                   logger.info("Proj Name"+s);
                            projSplit = s.substring(0, s.indexOf("***"));

                            title = s.substring(s.indexOf("***") + 3, s.length());
                        } catch (Exception e) {
                            //              logger.error(e.getMessage());
                            projSplit = "";
                            title = "";
                        }
            %>  

            <th class="header" style=" border: 1px solid #ccccff;" title="<%=title%>"><b><%=projSplit%></th>
                <%
                        }
                    } catch (Exception e) {
                        logger.error(e.getMessage());
                    }
                %>
    </thead>

</tr>
<tbody>
    <%
        int extraRows = 2;

        for (int i = 1; i < projectIssueSplit.length; i++) {
            if (i == (projectIssueSplit.length - (extraRows + 1))) {
    %>
</tbody>
<tfoot>
    <%
        }
    %>
    <tr <%if (i % 2 == 0) {%>class="zebralinealter"<%} else {%>class="zebralinealter"<%}%>  <%if (i == (projectIssueSplit.length - 3)) {%>style="background-color:yellow;"<%}%> >

        <%
            for (int j = 0; j < projectIssueSplit[0].length; j++) {
                value = projectIssueSplit[i][j];
                if (value == null) {
                    value = "";
                }
        %>
        <td style=" border: 1px solid #ccccff;<%if ((noOfRows - (extraRows + 1)) == i || (noOfColumns - 1) == (j)) {%>font-weight:bold;<%}%>" <%if (j != 0) {%>align="center"<%}%>>

            <%
                if (i == colIndex || j == rowIndex) {
            %>
            <font color="red" style="font-weight:bold;"><%=value%></font>
            <%} else {
            %>
            <%=value%>
            <%}%>

        </td>
        <%
            }
        %>
    </tr>
    <%
        if (i == (projectIssueSplit.length - 1)) {
    %>
</tfoot>
<%
        }
    }


%>
</table>
<table width="100%" height="23" border="0">

    <tr height="10">
        <td colspan="11">
            <table width="100%">
                <tr height="10">
                    <td align="left" width="100%">
                        <a href="#" onclick="collapse('wrm', 150);
                                return false" style="text-decoration: none;color: black" class="trigger" title="WRM Rating" ><b style="color: blue">WRM Rating
                        </a>   </td>

                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td>
            <div id="wrm" >
                <table id="wrmTable" style=" border: 1px solid #ccccff;border-collapse:collapse;" width="100%">
                    <thead>
                        <tr bgColor="#C3D9FF" height="21" style=" border: 1px solid #ccccff;">

                            <%                                                                                        String wrm[][] = ProjectFinder.getWRMRatings();

                                try {

                                    String projSplit = "", title = "";
                                    for (String s : wrm[0]) {
                                        if (s == null) {
                                            s = "";
                                        }
                                        try {
                                            if (s.equals("")) {
                                                projSplit = "Week#";
                                                title = "";
                                            } else {
                                                projSplit = s.substring(0, s.indexOf("***"));
                                                title = s.substring(s.indexOf("***") + 3, s.length());
                                            }
                                        } catch (Exception e) {
                                            //              logger.error(e.getMessage());
                                            projSplit = "";
                                            title = "";
                                        }
                            %>  

                            <th class="header" style=" border: 1px solid #ccccff;" title="<%=title%>"><b><%=projSplit%></th>
                                <%
                                        }
                                    } catch (Exception e) {
                                        logger.error(e.getMessage());
                                    }
                                %>
                    </thead>

                    <tbody>
                        <%  for (int i = 1; i < wrm.length; i++) { %>
                        <tr <%if (i % 2 == 0) {%>class="zebraline"<%} else {%>class="zebralinealter"<%}%>>

                            <%
                                String color = "", rating = "", wrmDate = "", rat = "Not Done", momClientId = "";
                                int count = 0;
                                for (int k = 0; k < wrm[0].length; k++) {
                                    momClientId = "";
                                    rat = wrm[i][k];
                                    if (rat == null) {
                                        rat = "Not Done";
                                    } else {
                                        if (!rat.equals("Not Done")) {
                                            try {
                                                if (rat.contains(",")) {
                                                    rating = "";
                                                    wrmDate = "";
                                                    count = 0;
                                                    for (String val : rat.split(",")) {
                                                        wrmDate = val.replace("&&&", " @ ") + "," + wrmDate;
                                                        if (count == 0) {
                                                            rating = val.split("&&&")[0];
                                                        }
                                                        count++;
                                                    }
                                                    if (wrmDate.contains("@@@@")) {
                                                        momClientId = wrmDate.split("@@@@")[1];
                                                        momClientId = momClientId.substring(0, momClientId.length() - 1);
                                                        wrmDate = wrmDate.substring(0, wrmDate.indexOf("@@@@"));
                                                    }
                                                } else {
                                                    rating = rat.split("&&&")[0];
                                                    wrmDate = rat.split("&&&")[1];
                                                    if (wrmDate.contains("@@@@")) {
                                                        momClientId = wrmDate.split("@@@@")[1];
                                                        wrmDate = wrmDate.substring(0, wrmDate.indexOf("@@@@"));
                                                    }
                                                }

                                                if (rating.equalsIgnoreCase("Excellent")) {
                                                    color = "#336600";
                                                } else if (rating.equalsIgnoreCase("Good")) {
                                                    color = "#33CC66";
                                                } else if (rating.equalsIgnoreCase("Average")) {
                                                    color = "#CC9900";
                                                } else if (rating.equalsIgnoreCase("Need Improvement")) {
                                                    color = "#CC0000";
                                                } else {
                                                    rating = "<b>" + rating + "</b>";
                                                    wrmDate = wrmDate;
                                                }

                                            } catch (Exception e) {
                                                rating = rat;
                                                wrmDate = "";
                                                color = "";
                                            }
                                        } else {
                                            rating = rat;
                                            wrmDate = "";
                                            color = "red";
                                        }
                                    }
                            %>

                            <td style=" border: 1px solid #ccccff; background-color: <%=color%> <%if (rating.contains("Not Do")) {%><%}%>" title="<%=wrmDate%>">

                                <%if (!momClientId.equals("")) {%>
                                <a style=" color:white; background-color: <%=color%>"  href="/eTracker/MOM/printWRM.jsp?momClientId=<%=momClientId%>" class="rating" target="_blank"> <%=rating%> </a>
                                <%} else {%>

                                <%=rating%>
                                <%
                                    }
                                %>    
                            </td>
                            <%
                                }
                            %>
                        </tr>
                        <%
                            }


                        %>
                    </tbody>
                </table>
            </div>
        </td>
    </tr>




    <tr height="10">
        <td colspan="11">
            <table width="100%">
                <tr height="10">
                    <td align="left" width="100%"><a href="#" onclick="javascript:void(0);
                            return false;" style="text-decoration: none;color: black" class="trigger" title="Daily Issue Split Up" ><b style="color: blue">Daily</b></td>

                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td>
            <div id="erm">
                <table id="daily" style=" border: 1px solid #ccccff;border-collapse:collapse;" width="100%">
                    <thead>
                        <tr bgColor="#C3D9FF" height="21" style=" border: 1px solid #ccccff;">

                            <%                    try {
                                    String projSplit = "", title = "";
                                    for (String s : projectIssueSplit[0]) {
                                        if (s == null) {
                                            s = "";
                                        }
                                        try {
                                            //                   logger.info("Proj Name"+s);
                                            projSplit = s.substring(0, s.indexOf("***"));

                                            title = s.substring(s.indexOf("***") + 3, s.length());
                                        } catch (Exception e) {
                                            //              logger.error(e.getMessage());
                                            projSplit = "";
                                            title = "";
                                        }
                            %>  

                            <th class="header" style=" border: 1px solid #ccccff;" title="<%=title%>"><b><%=projSplit%></th>
                                <%
                                        }
                                    } catch (Exception e) {
                                        logger.error(e.getMessage());
                                    }
                                %>
                    </thead>
                    <tbody>
                        <%
                            String dailyIssueSplit[][] = ProjectFinder.getYearlyValue("Daily");
                            for (int i = 1; i < dailyIssueSplit.length; i++) {

                        %>
                        <tr <%if (i % 2 == 0) {%>class="zebralinealter"<%} else {%>class="zebralinealter"<%}%>>

                            <%
                                for (int j = 0; j < dailyIssueSplit[0].length; j++) {
                                    value = dailyIssueSplit[i][j];
                                    if (value == null) {
                                        value = "";
                                    }
                            %>
                            <td style=" border: 1px solid #ccccff;<%if ((noOfRows - 1) == i || (noOfColumns - 1) == (j)) {%>font-weight:bold;<%}%>" <%if (j != 0) {%>align="center"<%}%>><%=value%></td>
                            <%
                                }
                            %>
                        </tr>
                        <%
                            }


                        %>
                </table>
            </div>
        </td>
    </tr>
    <tr height="10">
        <td colspan="11">
            <table width="100%">
                <tr height="10">
                    <td align="left" width="100%"><a href="#" onclick="collapse('tqm', 150);
                            return false" style="text-decoration: none;color: black" class="trigger" title="Weekly Issue Split Up" ><b style="color: blue">Weekly</a></td>

                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td>
            <div id="tqm" class="hide_me" >
                <table id="weekly" style=" border: 1px solid #ccccff;border-collapse:collapse;" width="100%">
                    <thead>
                        <tr bgColor="#C3D9FF" height="21" style=" border: 1px solid #ccccff;">

                            <%                    try {
                                    String projSplit = "", title = "";
                                    for (String s : projectIssueSplit[0]) {
                                        if (s == null) {
                                            s = "";
                                        }
                                        try {
                                            //                   logger.info("Proj Name"+s);
                                            projSplit = s.substring(0, s.indexOf("***"));

                                            title = s.substring(s.indexOf("***") + 3, s.length());
                                        } catch (Exception e) {
                                            //              logger.error(e.getMessage());
                                            projSplit = "";
                                            title = "";
                                        }
                            %>  

                            <th class="header" style=" border: 1px solid #ccccff;" title="<%=title%>"><b><%=projSplit%></th>
                                <%
                                        }
                                    } catch (Exception e) {
                                        logger.error(e.getMessage());
                                    }
                                %>
                    </thead>
                    <tbody>
                        <%
                            String weeklyIssueSplit[][] = ProjectFinder.getYearlyValue("Weekly");
                            for (int i = 1; i < weeklyIssueSplit.length; i++) {

                        %>
                        <tr <%if (i % 2 == 0) {%>class="zebralinealter"<%} else {%>class="zebralinealter"<%}%>>

                            <%
                                for (int j = 0; j < weeklyIssueSplit[0].length; j++) {
                                    value = weeklyIssueSplit[i][j];
                                    if (value == null) {
                                        value = "";
                                    }
                            %>
                            <td style=" border: 1px solid #ccccff;<%if ((noOfRows - 1) == i || (noOfColumns - 1) == (j)) {%>font-weight:bold;<%}%>" <%if (j != 0) {%>align="center"<%}%>><%=value%></td>
                            <%
                                }
                            %>
                        </tr>
                        <%
                            }


                        %>
                </table>
            </div>
        </td>
    </tr>
    <tr height="10">
        <td colspan="11">
            <table width="100%">
                <tr height="10">
                    <td align="left" width="100%">
                        <a href="#" onclick="collapse('bpm', 150);
                                return false" style="text-decoration: none;color: black" class="trigger" title="Monthly Issue Split Up" ><b style="color: blue">Monthly
                                </td>

                                </tr>
                                </table>
                                </td>
                                </tr>
                                <tr>
                                    <td>
                                        <div id="bpm" class="hide_me" >
                                            <table id="monthly" style=" border: 1px solid #ccccff;border-collapse:collapse;" width="100%">
                                                <thead>
                                                    <tr bgColor="#C3D9FF" height="21" style=" border: 1px solid #ccccff;">

                                                        <%                    try {
                                                                String projSplit = "", title = "";
                                                                for (String s : projectIssueSplit[0]) {
                                                                    if (s == null) {
                                                                        s = "";
                                                                    }
                                                                    try {
                                                                        //                   logger.info("Proj Name"+s);
                                                                        projSplit = s.substring(0, s.indexOf("***"));

                                                                        title = s.substring(s.indexOf("***") + 3, s.length());
                                                                    } catch (Exception e) {
                                                                        //              logger.error(e.getMessage());
                                                                        projSplit = "";
                                                                        title = "";
                                                                    }
                                                        %>  

                                                        <th class="header" style=" border: 1px solid #ccccff;" title="<%=title%>"><b><%=projSplit%></th>
                                                            <%
                                                                    }
                                                                } catch (Exception e) {
                                                                    logger.error(e.getMessage());
                                                                }
                                                            %>
                                                </thead>
                                                <tbody>
                                                    <%
                                                        String monthlyIssueSplit[][] = ProjectFinder.getYearlyValue("Monthly");
                                                        for (int i = 1; i < monthlyIssueSplit.length; i++) {

                                                    %>
                                                    <tr <%if (i % 2 == 0) {%>class="zebralinealter"<%} else {%>class="zebralinealter"<%}%>>

                                                        <%
                                                            for (int j = 0; j < monthlyIssueSplit[0].length; j++) {
                                                                value = monthlyIssueSplit[i][j];
                                                                if (value == null) {
                                                                    value = "";
                                                                }
                                                        %>
                                                        <td style=" border: 1px solid #ccccff;<%if ((noOfRows - 1) == i || (noOfColumns - 1) == (j)) {%>font-weight:bold;<%}%>" <%if (j != 0) {%>align="center"<%}%>><%=value%></td>
                                                        <%
                                                            }
                                                        %>
                                                    </tr>
                                                    <%
                                                        }


                                                    %>
                                            </table>
                                        </div>
                                    </td>
                                </tr>
                                <tr height="10">
                                    <td colspan="11">
                                        <table width="100%">
                                            <tr height="10">
                                                <td align="left" width="100%">
                                                    <a href="#" onclick="collapse('crm', 150);
                                                            return false" style="text-decoration: none;color: black" class="trigger" title="Quarterly Issue Split Up" ><b style="color: blue">Quarterly</a></td>

                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <div id="crm" class="hide_me" >
                                            <table id="quarterly" style=" border: 1px solid #ccccff;border-collapse:collapse;" width="100%">
                                                <thead>
                                                    <tr bgColor="#C3D9FF" height="21" style=" border: 1px solid #ccccff;">

                                                        <%                    try {
                                                                String projSplit = "", title = "";
                                                                for (String s : projectIssueSplit[0]) {
                                                                    if (s == null) {
                                                                        s = "";
                                                                    }
                                                                    try {
                                                                        //                   logger.info("Proj Name"+s);
                                                                        projSplit = s.substring(0, s.indexOf("***"));

                                                                        title = s.substring(s.indexOf("***") + 3, s.length());
                                                                    } catch (Exception e) {
                                                                        //              logger.error(e.getMessage());
                                                                        projSplit = "";
                                                                        title = "";
                                                                    }
                                                        %>  

                                                        <th class="header" style=" border: 1px solid #ccccff;" title="<%=title%>"><b><%=projSplit%></th>
                                                            <%
                                                                    }
                                                                } catch (Exception e) {
                                                                    logger.error(e.getMessage());
                                                                }
                                                            %>
                                                </thead>
                                                <tbody>
                                                    <%
                                                        String quarterlyIssueSplit[][] = ProjectFinder.getYearlyValue("Quarterly");
                                                        for (int i = 1; i < quarterlyIssueSplit.length; i++) {

                                                    %>
                                                    <tr <%if (i % 2 == 0) {%>class="zebralinealter"<%} else {%>class="zebralinealter"<%}%>>

                                                        <%
                                                            for (int j = 0; j < quarterlyIssueSplit[0].length; j++) {
                                                                value = quarterlyIssueSplit[i][j];
                                                                if (value == null) {
                                                                    value = "";
                                                                }
                                                        %>
                                                        <td style=" border: 1px solid #ccccff;<%if ((noOfRows - 1) == i || (noOfColumns - 1) == (j)) {%>font-weight:bold;<%}%>" <%if (j != 0) {%>align="center"<%}%>><%=value%></td>
                                                        <%
                                                            }
                                                        %>
                                                    </tr>
                                                    <%
                                                        }


                                                    %>
                                            </table>
                                        </div>
                                    </td>
                                </tr>
                                <tr height="10">
                                    <td colspan="11">
                                        <table width="100%">
                                            <tr height="10">
                                                <td align="left" width="100%">
                                                    <a href="#" onclick="collapse('apm', 150);
                                                            return false" style="text-decoration: none;color: black" class="trigger" title="Yearly Issue Split Up" ><b style="color: blue">Yearly</a>
                                                </td>

                                            </tr>
                                        </table>
                                    </td>
                                </tr>

                                <tr>
                                    <td>
                                        <div id="apm" class="hide_me" >
                                            <table id="yearly" style=" border: 1px solid #ccccff;border-collapse:collapse;" width="100%">
                                                <thead>
                                                    <tr bgColor="#C3D9FF" height="21" style=" border: 1px solid #ccccff;">

                                                        <%                    try {
                                                                String projSplit = "", title = "";
                                                                for (String s : projectIssueSplit[0]) {
                                                                    if (s == null) {
                                                                        s = "";
                                                                    }
                                                                    try {
                                                                        //                   logger.info("Proj Name"+s);
                                                                        projSplit = s.substring(0, s.indexOf("***"));

                                                                        title = s.substring(s.indexOf("***") + 3, s.length());
                                                                    } catch (Exception e) {
                                                                        //              logger.error(e.getMessage());
                                                                        projSplit = "";
                                                                        title = "";
                                                                    }
                                                        %>  

                                                        <th class="header" style=" border: 1px solid #ccccff;" title="<%=title%>"><b><%=projSplit%></th>
                                                            <%
                                                                    }
                                                                } catch (Exception e) {
                                                                    logger.error(e.getMessage());
                                                                }
                                                            %>
                                                </thead>
                                                <tbody>
                                                    <%
                                                        String yearlyIssueSplit[][] = ProjectFinder.getYearlyValue("Yearly");
                                                        for (int i = 1; i < yearlyIssueSplit.length; i++) {

                                                    %>
                                                    <tr <%if (i % 2 == 0) {%>class="zebralinealter"<%} else {%>class="zebralinealter"<%}%>>

                                                        <%
                                                            for (int j = 0; j < yearlyIssueSplit[0].length; j++) {
                                                                value = yearlyIssueSplit[i][j];
                                                                if (value == null) {
                                                                    value = "";
                                                                }
                                                        %>
                                                        <td style=" border: 1px solid #ccccff;<%if ((noOfRows - 1) == i || (noOfColumns - 1) == (j)) {%>font-weight:bold;<%}%>" <%if (j != 0) {%>align="center"<%}%>><%=value%></td>
                                                        <%
                                                            }
                                                        %>
                                                    </tr>
                                                    <%
                                                        }


                                                    %>
                                            </table>
                                        </div>
                                    </td>
                                </tr>
                                <tr height="10">
                                    <td colspan="11">
                                        <table width="100%">
                                            <tr height="10">
                                                <td align="left" width="100%">
                                                    <a href="#" onclick="collapse('mmwt', 150);
                                                            return false" style="text-decoration: none;color: black" class="trigger" title="Yearly Issue Split Up" ><b style="color: blue">Monthly Module</a>
                                                </td>

                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td>

                                        <div id="mmwt" class="hide_me" >
                                            <%                    List<ModuleWaiseCountBean> mwcblist = ProjectFinder.getModuleSplitMonth();

                                            %>
                                            <table id="monthlyModule" style="border: 1px solid #ccccff;border-collapse:collapse; width: 100%">
                                                <thead>
                                                    <tr style=" border: 1px solid #ccccff; background: #C3D9FF;height: 21px">
                                                        <th><b>Module</b></th>
                                                        <th><b>Open Issue Count</b></th>
                                                        <th><b>Target Count</b></th>
                                                        <th><b>Created Count</b></th>
                                                        <th><b>Planned Count</b></th>
                                                        <th><b>Worked Count</b></th>
                                                        <th><b>WRM Count</b></th>
                                                        <th><b>Closed Count</b></th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <% int j = 0;
                                                        Integer totalOpenIssue = 0, totaleTarget = 0, totalCreate = 0, totalPlan = 0, totalworked = 0, totalclosed = 0, toatlWrm = 0;
                                                        for (ModuleWaiseCountBean mwcb : mwcblist) {
                                                            j++;
                                                            totalOpenIssue = totalOpenIssue + mwcb.getOpenIssue();
                                                            totaleTarget = totaleTarget + mwcb.getTargetCount();
                                                            totalCreate = totalCreate + mwcb.getCreatedCount();
                                                            totalPlan = totalPlan + mwcb.getPlanCount();
                                                            totalworked = totalworked + mwcb.getWorkedCount();
                                                            totalclosed = totalclosed + mwcb.getCloseCount();
                                                            toatlWrm = toatlWrm + mwcb.getWrmCount();
                                                    %>
                                                    <tr <%if (j % 2 == 0) {%>class="zebralinealter"<%} else {%>class="zebralinealter"<%}%>>
                                                        <td style="text-align: left;"><b><%=mwcb.getModuleName()%></b></td>
                                                        <td><%=mwcb.getOpenIssue()%></td>
                                                        <td><%=mwcb.getTargetCount()%></td>
                                                        <td><%=mwcb.getCreatedCount()%></td>
                                                        <td><%=mwcb.getPlanCount()%></td>
                                                        <td><%=mwcb.getWorkedCount()%></td>
                                                        <td><%=mwcb.getWrmCount()%></td>
                                                        <td><%=mwcb.getCloseCount()%></td>
                                                    </tr>
                                                    <%}%>

                                                </tbody>
                                                <tr style="background: yellow">
                                                    <td style="text-align: left;"><b>Total</b></td>
                                                    <td><%=totalOpenIssue%></td>
                                                    <td><%=totaleTarget%></td>
                                                    <td><%=totalCreate%></td>
                                                    <td><%=totalPlan%></td>
                                                    <td><%=totalworked%></td>
                                                    <td><%=toatlWrm%></td> 
                                                    <td><%=totalclosed%></td>
                                                </tr>
                                            </table>

                                        </div>
                                    </td>
                                </tr>


                                </table>
                                <style>
                                    #monthlyModule{
                                        border: 1px solid #ccccff;
                                        border-collapse:collapse;
                                        width: 100%
                                    }
                                    #monthlyModule tr th, #monthlyModule tr td{
                                        border: 1px solid #ccccff;
                                        text-align: center;
                                    }

                                </style>

                                <script src="<%=request.getContextPath()%>/javaScript/jquery.js" type="text/javascript"></script>
                                <script src="<%=request.getContextPath()%>/javaScript/jquery.tablesorter.min.js" type="text/javascript"></script>
                                <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/slide.js"></script>
                                <script type="text/javascript">
                                                        $(document).ready(function()
                                                        {
                                                            $("#issueSplit").tablesorter({
                                                                widgets: ['zebra'],
                                                                widgetZebra: {css: ['zebraline', 'zebralinealter']},
                                                                // change the multi sort key from the default shift to alt button 
                                                                sortMultiSortKey: 'altKey'
                                                            });
                                                            $("#daily").tablesorter({
                                                                widgets: ['zebra'],
                                                                widgetZebra: {css: ['zebraline', 'zebralinealter']},
                                                                // change the multi sort key from the default shift to alt button 
                                                                sortMultiSortKey: 'altKey'
                                                            });
                                                            $("#weekly").tablesorter({
                                                                widgets: ['zebra'],
                                                                widgetZebra: {css: ['zebraline', 'zebralinealter']},
                                                                // change the multi sort key from the default shift to alt button 
                                                                sortMultiSortKey: 'altKey'
                                                            });
                                                            $("#monthly").tablesorter({
                                                                widgets: ['zebra'],
                                                                widgetZebra: {css: ['zebraline', 'zebralinealter']},
                                                                // change the multi sort key from the default shift to alt button 
                                                                sortMultiSortKey: 'altKey'
                                                            });
                                                            $("#monthlyModule").tablesorter({
                                                                widgets: ['zebra'],
                                                                widgetZebra: {css: ['zebraline', 'zebralinealter']},
                                                                // change the multi sort key from the default shift to alt button 
                                                                sortMultiSortKey: 'altKey'
                                                            });
                                                            $("#quarterly").tablesorter({
                                                                widgets: ['zebra'],
                                                                widgetZebra: {css: ['zebraline', 'zebralinealter']},
                                                                // change the multi sort key from the default shift to alt button 
                                                                sortMultiSortKey: 'altKey'
                                                            });
                                                            $("#yearly").tablesorter({
                                                                widgets: ['zebra'],
                                                                widgetZebra: {css: ['zebraline', 'zebralinealter']},
                                                                // change the multi sort key from the default shift to alt button 
                                                                sortMultiSortKey: 'altKey'
                                                            });
                                                            $("#wrmTable").tablesorter({
                                                                widgets: ['zebra'],
                                                                widgetZebra: {css: ['zebraline', 'zebralinealter']},
                                                                // change the multi sort key from the default shift to alt button 
                                                                sortMultiSortKey: 'altKey'
                                                            });
                                                        }
                                                        );

                                </script>
                                </body>
                                </html>
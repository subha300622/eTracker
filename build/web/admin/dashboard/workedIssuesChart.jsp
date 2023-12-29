<%-- 
    Document   : workedIssuesChart
    Created on : 14 Jun, 2010, 12:11:37 PM
    Author     : ADAL
--%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="org.apache.log4j.*,com.eminent.util.*,dashboard.*,java.util.*"%>
<%
    response.setHeader("Cache-Control", "no-chache");
    response.setHeader("Cache-Control", "no-store");
    response.setDateHeader("Expires", 0);
    response.setHeader("Pragma", "no-cache");

    //Configuring log4j Properties
  
    Logger logger = Logger.getLogger("WorkedIssueChart");

    String logoutCheck = (String) session.getAttribute("Name");

    if (logoutCheck == null) {
%>
<jsp:forward page="/SessionExpired.jsp"/>
<%    }

    HashMap<Integer, String> monthSelect = new HashMap<Integer, String>();

    monthSelect.put(0, "Jan");
    monthSelect.put(1, "Feb");
    monthSelect.put(2, "Mar");
    monthSelect.put(3, "Apr");
    monthSelect.put(4, "May");
    monthSelect.put(5, "Jun");
    monthSelect.put(6, "Jul");
    monthSelect.put(7, "Aug");
    monthSelect.put(8, "Sep");
    monthSelect.put(9, "Oct");
    monthSelect.put(10, "Nov");
    monthSelect.put(11, "Dec");

    //calculating start and end date of this month
    Calendar cal = new GregorianCalendar();
    int currentYear = cal.get(Calendar.YEAR);
    int currentMonth = cal.get(Calendar.MONTH);
    int currentDay = cal.get(Calendar.DAY_OF_MONTH);

    String selectYear = request.getParameter("year");
    String selectMonth = request.getParameter("month");
//        logger.info("Selected Year"+selectYear);
//        logger.info("Selected Month"+selectMonth);
    int year = 0;
    int month = 0;
    int maxday = 30;
    int period = 4;
    int total = monthSelect.size();
    if (selectYear == null || selectYear.equals("")) {
        year = currentYear;
        month = cal.get(Calendar.MONTH);
        maxday = cal.get(Calendar.DAY_OF_MONTH);
    } else {
        year = Integer.parseInt(selectYear);
        month = Integer.parseInt(selectMonth);

        Calendar cale = Calendar.getInstance();
        cale.set(year, month, 1);
        maxday = cale.getActualMaximum(Calendar.DATE);
    }
    int reqYear = year;
    //       logger.info("Year"+year);
    //       logger.info("Month"+monthSelect.get(month));

    //       logger.info("MAX DAY of MOnth"+maxday);
    SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy");
    String startDate = "1" + "-" + monthSelect.get(month) + "-" + year;
    String endDate = maxday + "-" + monthSelect.get(month) + "-" + year;
    logger.info("Start Date  :" + startDate);
    logger.info("End Date    :" + endDate);

    // Validation for correct month
    Calendar startCalendar = new GregorianCalendar();
    String currDate = "1" + "-" + monthSelect.get(currentMonth) + "-" + currentYear;
    startCalendar.setTime(sdf.parse(currDate));

    Calendar endCalendar = new GregorianCalendar();
    endCalendar.setTime(sdf.parse(startDate));

    int diffYear = startCalendar.get(Calendar.YEAR) - endCalendar.get(Calendar.YEAR);
    int diffMonth = diffYear * 12 + startCalendar.get(Calendar.MONTH) - endCalendar.get(Calendar.MONTH);
    int newMon = month;
    if (diffMonth < 3) {
        newMon = newMon - (3 - diffMonth);
        if (newMon < 0) {
            newMon = (total +newMon);
            year = year - 1;
        }

        startDate = "1" + "-" + monthSelect.get(newMon) + "-" + year;

        Calendar cale = Calendar.getInstance();
        cale.set(year, newMon, 1);
        maxday = cale.getActualMaximum(Calendar.DATE);
        endDate = maxday + "-" + monthSelect.get(newMon) + "-" + year;
    }
    //end of Validation for correct month

    //Retriving Worked Issues for all projects
    String projectWorkedIssues[][] = ProjectIssues.totalWorkedIssues(startDate, endDate);
    Date endDateinD = sdf.parse(endDate);

    cal.setTime(endDateinD);
    cal.add(Calendar.MONTH, 1);
    int monthq1 = cal.get(Calendar.MONTH);
    int maxdaya = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
    int yeara = cal.get(Calendar.YEAR);
    String startDatea = "1" + "-" + monthSelect.get(monthq1) + "-" + yeara;
    String endDatea = maxdaya + "-" + monthSelect.get(monthq1) + "-" + yeara;

    logger.info("Start Date  :" + startDate);
    logger.info("End Date    :" + endDate);

    //Retriving Worked Issues for all projects
    String projectWorkedIssuesa[][] = ProjectIssues.totalWorkedIssues(startDatea, endDatea);
    endDateinD = sdf.parse(endDatea);

    cal.setTime(endDateinD);
    cal.add(Calendar.MONTH, 1);
    int monthq2 = cal.get(Calendar.MONTH);
    int maxdayb = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
    int yearb = cal.get(Calendar.YEAR);
    String startDateb = "1" + "-" + monthSelect.get(monthq2) + "-" + yearb;
    String endDateb = maxdayb + "-" + monthSelect.get(monthq2) + "-" + yearb;
    logger.info("Start Date  :" + startDate);
    logger.info("End Date    :" + endDate);
    String projectWorkedIssuesb[][] = ProjectIssues.totalWorkedIssues(startDateb, endDateb);

    endDateinD = sdf.parse(endDateb);

    cal.setTime(endDateinD);
    cal.add(Calendar.MONTH, 1);
    int monthq3 = cal.get(Calendar.MONTH);
    int maxdayc = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
    int yearc = cal.get(Calendar.YEAR);
    String startDatec = "1" + "-" + monthSelect.get(monthq3) + "-" + yearc;
    String endDatec = maxdayc + "-" + monthSelect.get(monthq3) + "-" + yearc;

    logger.info("Start Date  :" + startDate);
    logger.info("End Date    :" + endDate);

    //Retriving Worked Issues for all projects
    String projectWorkedIssuesc[][] = ProjectIssues.totalWorkedIssues(startDatec, endDatec);
    endDateinD = sdf.parse(endDatec);

    //Retriving Worked Issues for all projects
    int noOfProjects = projectWorkedIssues.length;
    int noOfProjectsa = projectWorkedIssuesa.length;
    int noOfProjectsb = projectWorkedIssuesb.length;
    int noOfProjectsc = projectWorkedIssuesc.length;
    logger.info("No fo Projects" + noOfProjects);
    // Random no generation for chart color
    Random randomGenerator = new Random();


%>
<html>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
        <meta http-equiv="Content-Type" content="text/html">
        <title>eTracker&#0153; - Eminentlabs CRM,APM,ERM and PTS Solution</title>
        <LINK title=STYLE href="<%= request.getContextPath()%>/eminentech support files/main_ie.css" type="text/css" rel=STYLESHEET>
        <script type="text/javascript" src="<%=request.getContextPath()%>/fusion/fusioncharts.js?version=30032016"></script>
        <script type="text/javascript">
            function monthSelection() {

                var date = 1;
                var startMonth = 7;
                var startYear = 2008;

                var startRange = new Date(startYear, startMonth, date);

                var month = document.getElementById("month").value;
                var year = document.getElementById("year").value;
                var selectedValue = new Date(year, month, date);
                var current_date = new Date();
                if (selectedValue >= startRange && selectedValue <= current_date) {
                    document.getElementById('button').value = 'Processing';
                    document.getElementById('button').disabled = true;
                    location = 'workedIssuesChart.jsp?month=' + month + '&year=' + year;
                } else {
                    alert("You can view Eminentlabs Worked Issues chart from Aug 2008 to Current Month");
                }
            }

        </script>
    </head>
    <body>
        <%@ include file="/header.jsp"%>
        <table width="100%" bgColor="#C3D9FF">
            <tr  bgColor="#C3D9FF">
                <td  align="left" width="55%"><font size="4" COLOR="#0000FF"><b>Worked Isssue for the Month of</b></font>
                    <select name="month" id="month">
                        <%

                            for (int k = 0; k < monthSelect.size(); k++) {
                                if (k == month) {
                        %>
                        <option value='<%=k%>' selected><%=monthSelect.get(k)%></option>
                        <%
                        } else {
                        %>
                        <option value='<%=k%>'><%=monthSelect.get(k)%></option>
                        <%
                                }

                            }
                        %>

                    </select>

                    <%
                        ArrayList<Integer> selectYears = new ArrayList<Integer>();
                        int startYear = 2008;

                        while (startYear <= currentYear) {
                            selectYears.add(startYear);
                            startYear++;
                        }
                    %>

                    <select name='year' id='year' >
                        <%
                            for (int k = 0, selected = 2008; k < selectYears.size(); k++, selected++) {
                                if (selected == reqYear) {
                        %>
                        <option value='<%=selectYears.get(k)%>' selected><%=selectYears.get(k)%></option>
                        <%
                        } else {
                        %>
                        <option value='<%=selectYears.get(k)%>'><%=selectYears.get(k)%></option>
                        <%
                                }

                            }

                        %>
                    </select>
                    <input type="button" id="button" value="Submit" onclick="monthSelection()">

                </td>
                <td style="text-align: right;"><a style="font-weight: bold;" href="<%= request.getContextPath()%>/admin/user/apmPerformance.jsp">APM Performance</a>&nbsp;&nbsp;&nbsp;<a href="<%= request.getContextPath()%>/admin/dashboard/ageWiseIssueChart.jsp?month=<%=month%>&year=<%=year%>">Age Wise</a>&nbsp;&nbsp;&nbsp;<a href="<%= request.getContextPath()%>/admin/dashboard/moduleWorkedIssuesChart.jsp?month=<%=month%>&year=<%=year%>">Module Wise</a>&nbsp;&nbsp;&nbsp;<a   href="<%= request.getContextPath()%>/admin/dashboard/dueDateChangeWise.jsp?month=<%=month%>&year=<%=year%>">DueDate Wise</a>&nbsp;&nbsp;&nbsp;<a  href="<%= request.getContextPath()%>/admin/dashboard/dayWiseChart.jsp?month=<%=month%>&year=<%=year%>">Day Wise</a></td>
            </tr>
        </table>
            <%
                if (noOfProjects > 0 || noOfProjectsa > 0 || noOfProjectsb > 0 || noOfProjectsc > 0) {
            %>
            <script type="text/javascript">
                    FusionCharts.ready(function() {
                    var ageGroupChart = new FusionCharts({
                    type: 'pie3d',
                            renderAt: 'chart-container',
                            width: '600',
                            height: '500',
                            dataFormat: 'json',
                            dataSource: {
                            "chart": {
                                "caption": "<%=monthSelect.get(newMon) + "-" + year%>",
//                                    "paletteColors": "#0075c2,#1aaf5d,#f2c500,#f45b00,#8e0000",
                                    "bgColor": "#ffffff",
                                    "use3DLighting": "0",
                                    "showShadow": "0",
                                    "pieslicedepth": "30",
                                    "enableSmartLabels": "0",
                                    "startingAngle": "0",
                                    "showPercentValues": "1",
                                    "showPercentInTooltip": "0",
                                    "decimals": "1",
                                    "captionFontSize": "14",
                                    "subcaptionFontSize": "14",
                                    "subcaptionFontBold": "0",
                                    "toolTipColor": "#ffffff",
                                    "toolTipBorderThickness": "0",
                                    "toolTipBgColor": "#000000",
                                    "toolTipBgAlpha": "80",
                                    "toolTipBorderRadius": "2",
                                    "toolTipPadding": "5",
                                    "showHoverEffect":"1",
                                    "showLegend": "1",
                                    "legendBgColor": "#ffffff",
                                    "legendBorderAlpha": '0',
                                    "legendShadow": '0',
                                    "legendItemFontSize": '10',
                                    "legendItemFontColor": '#666666'
                            },
                                    "data": [

            <%int j = 0;
            for (int k = 0; k < noOfProjects; k++) {
            %>
                                    {
                                        "label": "<%=projectWorkedIssues[k][1]%>",
                                                "value": "<%= projectWorkedIssues[k][2]%>",
                                                "link":'<%= request.getContextPath()%>/admin/user/eminentWorkedIssues.jsp?month=<%=month%>&year=<%=year%>&pid=<%=projectWorkedIssues[k][0]%>'
                                                                        },
            <% j++;
            }%>
                                                                        ]
                                                                }
                                                        }
                                                        ); ageGroupChart.render();
                                                        });</script>
        <script type="text/javascript">
                    FusionCharts.ready(function() {
                    var ageGroupChart = new FusionCharts({
                    type: 'pie3d',
                            renderAt: 'chart-containera',
                            width: '600',
                            height: '500',
                            dataFormat: 'json',
                            dataSource: {
                            "chart": {
                                "caption": "<%=monthSelect.get(monthq1) + "-" + yeara%>",
//                                    "paletteColors": "#0075c2,#1aaf5d,#f2c500,#f45b00,#8e0000",
                                    "bgColor": "#ffffff",
                                    "use3DLighting": "0",
                                    "showShadow": "0",
                                    "pieslicedepth": "30",
                                    "enableSmartLabels": "0",
                                    "startingAngle": "0",
                                    "showPercentValues": "1",
                                    "showPercentInTooltip": "0",
                                    "decimals": "1",
                                    "captionFontSize": "14",
                                    "subcaptionFontSize": "14",
                                    "subcaptionFontBold": "0",
                                    "toolTipColor": "#ffffff",
                                    "toolTipBorderThickness": "0",
                                    "toolTipBgColor": "#000000",
                                    "toolTipBgAlpha": "80",
                                    "toolTipBorderRadius": "2",
                                    "toolTipPadding": "5",
                                    "showHoverEffect":"1",
                                    "showLegend": "1",
                                    "legendBgColor": "#ffffff",
                                    "legendBorderAlpha": '0',
                                    "legendShadow": '0',
                                    "legendItemFontSize": '10',
                                    "legendItemFontColor": '#666666'
                            },
                                    "data": [

            <%
            for (int k = 0; k < noOfProjectsa; k++) {
            %>
                                    {
                                        "label": "<%=projectWorkedIssuesa[k][1]%>",
                                                "value": "<%= projectWorkedIssuesa[k][2]%>",
                                                "link":'<%= request.getContextPath()%>/admin/user/eminentWorkedIssues.jsp?month=<%=month%>&year=<%=year%>&pid=<%=projectWorkedIssuesa[k][0]%>'
                                                                        },
            <% j++;
            }%>
                                                                        ]
                                                                }
                                                        }
                                                        ); ageGroupChart.render();
                                                        });</script>
        <script type="text/javascript">
                    FusionCharts.ready(function() {
                    var ageGroupChart = new FusionCharts({
                    type: 'pie3d',
                            renderAt: 'chart-containerb',
                            width: '600',
                            height: '500',
                            dataFormat: 'json',
                            dataSource: {
                            "chart": {
                                "caption": "<%=monthSelect.get(monthq2) + "-" + yearb%>",
//                                    "paletteColors": "#0075c2,#1aaf5d,#f2c500,#f45b00,#8e0000",
                                    "bgColor": "#ffffff",
                                    "use3DLighting": "0",
                                    "showShadow": "0",
                                    "pieslicedepth": "30",
                                    "enableSmartLabels": "0",
                                    "startingAngle": "0",
                                    "showPercentValues": "1",
                                    "showPercentInTooltip": "0",
                                    "decimals": "1",
                                    "captionFontSize": "14",
                                    "subcaptionFontSize": "14",
                                    "subcaptionFontBold": "0",
                                    "toolTipColor": "#ffffff",
                                    "toolTipBorderThickness": "0",
                                    "toolTipBgColor": "#000000",
                                    "toolTipBgAlpha": "80",
                                    "toolTipBorderRadius": "2",
                                    "toolTipPadding": "5",
                                    "showHoverEffect":"1",
                                    "showLegend": "1",
                                    "legendBgColor": "#ffffff",
                                    "legendBorderAlpha": '0',
                                    "legendShadow": '0',
                                    "legendItemFontSize": '10',
                                    "legendItemFontColor": '#666666'
                            },
                                    "data": [

            <%
            for (int k = 0; k < noOfProjectsb; k++) {
            %>
                                    {
                                        "label": "<%=projectWorkedIssuesb[k][1]%>",
                                                "value": "<%= projectWorkedIssuesb[k][2]%>",
                                                "link":'<%= request.getContextPath()%>/admin/user/eminentWorkedIssues.jsp?month=<%=month%>&year=<%=year%>&pid=<%=projectWorkedIssuesb[k][0]%>'
                                                                        },
            <% j++;
            }%>
                                                                        ]
                                                                }
                                                        }
                                                        ); ageGroupChart.render();
                                                        });</script>
        <script type="text/javascript">
                    FusionCharts.ready(function() {
                    var ageGroupChart = new FusionCharts({
                    type: 'pie3d',
                            renderAt: 'chart-containerc',
                            width: '600',
                            height: '500',
                            dataFormat: 'json',
                            dataSource: {
                            "chart": {
                                "caption": "<%=monthSelect.get(monthq3) + "-" + yearc%>",
//                                    "paletteColors": "#0075c2,#1aaf5d,#f2c500,#f45b00,#8e0000",
                                    "bgColor": "#ffffff",
                                    "use3DLighting": "0",
                                    "showShadow": "0",
                                    "pieslicedepth": "30",
                                    "enableSmartLabels": "0",
                                    "startingAngle": "0",
                                    "showPercentValues": "1",
                                    "showPercentInTooltip": "0",
                                    "decimals": "1",
                                    "captionFontSize": "14",
                                    "subcaptionFontSize": "14",
                                    "subcaptionFontBold": "0",
                                    "toolTipColor": "#ffffff",
                                    "toolTipBorderThickness": "0",
                                    "toolTipBgColor": "#000000",
                                    "toolTipBgAlpha": "80",
                                    "toolTipBorderRadius": "2",
                                    "toolTipPadding": "5",
                                    "showHoverEffect":"1",
                                    "showLegend": "1",
                                    "legendBgColor": "#ffffff",
                                    "legendBorderAlpha": '0',
                                    "legendShadow": '0',
                                    "legendItemFontSize": '10',
                                    "legendItemFontColor": '#666666'
                            },
                                    "data": [

            <%
            for (int k = 0; k < noOfProjectsc; k++) {
            %>
                                    {
                                        "label": "<%=projectWorkedIssuesc[k][1]%>",
                                                "value": "<%= projectWorkedIssuesc[k][2]%>",
                                                "link":'<%= request.getContextPath()%>/admin/user/eminentWorkedIssues.jsp?month=<%=month%>&year=<%=year%>&pid=<%=projectWorkedIssuesc[k][0]%>'
                                                                        },
            <% j++;
            }%>
                                                                        ]
                                                                }
                                                        }
                                                        ); ageGroupChart.render();
                                                        });</script>
        <div style="width: 100%;">
            <div id="chart-container" class="chartarea" style="width: 46%;float: left;margin: 20px 20px 20px 20px;">
                <img class="loading" src="<%=request.getContextPath()%>/images/276 (1).GIF" alt="FusionCharts XT will load here!" />
            </div>
            <div id="chart-containera" class="chartarea" style="width: 46%;float: left;margin: 20px 20px 20px 20px;">
                <img class="loading" src="<%=request.getContextPath()%>/images/276 (1).GIF" alt="FusionCharts XT will load here!" />
            </div><div id="chart-containerb" class="chartarea" style="width: 46%;float: left;margin: 20px 20px 20px 20px;">
                <img class="loading" src="<%=request.getContextPath()%>/images/276 (1).GIF" alt="FusionCharts XT will load here!" />
            </div>
            <div id="chart-containerc" class="chartarea" style="width: 46%;float: left;margin: 20px 20px 20px 20px;">
                <img class="loading" src="<%=request.getContextPath()%>/images/276 (1).GIF" alt="FusionCharts XT will load here!" />
            </div>
        </div>
        
       
        <!-- Pie Data --> <!--                value,URL,Target Frame -->



        <%
        } else {
        %>
        <table width="100%">
            <tr>
                <td width="100%">No Closed Issue available</td>
            </tr>
        </table>
        <%    }
        %>
        <script src="//code.jquery.com/jquery-1.10.2.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/fusion/fusiontrailremover.js"></script>
    </body>
</html>


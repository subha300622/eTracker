<%-- 
    Document   : showTestScript
    Created on : 5 Nov, 2011, 10:19:25 PM
    Author     : Tamilvelan
--%>
<%@page import="org.apache.log4j.Logger,org.apache.log4j.PropertyConfigurator,com.eminentlabs.userBPM.ViewBPM,java.util.LinkedHashMap,java.util.HashMap" %>
<%@page import="com.eminent.util.GetProjectMembers,com.eminent.util.GetProjectManager,java.util.Iterator,java.util.Collection,com.eminent.util.GetProjects" %>
<%@page import="dashboard.TestCases,java.sql.Connection,java.sql.ResultSet,java.sql.PreparedStatement,pack.eminent.encryption.MakeConnection"%>
<%
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Cache-Control", "no-store");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);

        //Configuring log4j properties
    Logger logger = Logger.getLogger("Test Case Chart");

    String sessionCheck = (String) session.getAttribute("Name");
    if (sessionCheck == null) {
%>
<jsp:forward page="/SessionExpired.jsp"></jsp:forward>
<%
    }

%>


<html>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
    <meta http-equiv="Content-Type" content="text/html">
    <title>eTracker&#0153; - Eminentlabs&#0153; CRM, BPM, APM, TQM, ERM and EPTS Solution</title>
    <LINK title=STYLE href="<%= request.getContextPath()%>/eminentech support files/main_ie.css" type="text/css" rel=STYLESHEET>
    <script src="<%=request.getContextPath()%>/javaScript/XMLHttpRequest.js" type="text/javascript"></script>
    <script src="<%=request.getContextPath()%>/javaScript/jquery.js" type="text/javascript"></script>
    <script type="text/javascript">
        var newRequest = createRequest();
        function showComments(ptcId) {
            $('#' + ptcId + ' div').toggleClass('treeExpand');

            if ($('#' + ptcId + ' div').hasClass('treeExpand')) {
                try {
                    if (newRequest != null) {
                        newRequest.open("GET", '${pageContext.servletContext.contextPath}/UserBPM/executionHistory.jsp?ptcId=' + ptcId + '&rand=' + Math.random(1, 10), true);
                        newRequest.onreadystatechange = function () {

                            callbackComments(ptcId);
                        }
                        newRequest.send(null);

                    }
                } catch (e) {
                    alert(e);
                }

            } else {
                $('#ptc' + ptcId + ' td').remove();
            }

        }
        function callbackComments(ptcId) {
            if (newRequest.readyState === 4 && newRequest.status === 200) {

                var comments = newRequest.responseText;
                document.getElementById('ptc' + ptcId).innerHTML = comments;

            }
        }
    </script>
</head>
<body>
    <%
        Connection connection = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        String pid = request.getParameter("pid");
        String tsId = request.getParameter("tsId");
        String clientName = request.getParameter("clientName");
        String compName = request.getParameter("companyName");
        String nameofbp = request.getParameter("bpName");
        String nameofmp = request.getParameter("mpName");
        String nameofsp = request.getParameter("spName");
        String nameofsc = request.getParameter("scName");
        String nameofvt = request.getParameter("vtName");
        String nameoftc = request.getParameter("tcName");
        String nameofts = request.getParameter("tsName");
        logger.info("Test Step Id" + tsId);

    %>
    <%@ include file="/header.jsp"%>
    <table cellpadding="0" cellspacing="0" width="100%" bgColor="#C3D9FF">
        <tr  bgColor="#C3D9FF">
            <td  align="left" width="100%"><font size="4" COLOR="#0000FF"><b>View <%=GetProjects.getProject(Integer.parseInt(pid))%> Test Map Dashboard</b></font></td>
        </tr>
    </table>
    <table>
        <tr style="height:20px">
            <td>
                <a href="<%=request.getContextPath()%>/testMap.jsp?pid=<%=pid%>">Test Map Tree View</a>&nbsp;&nbsp;&nbsp;
                <%
                    String cases[][] = TestCases.showTestCases(pid);
                    int noOfTestcases = cases.length;
                    if (noOfTestcases > 0) {
                %>
                <a href="<%=request.getContextPath()%>/admin/dashboard/TestCasesChart.jsp?project=<%=pid%>">View Test Coverage</a>&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/UserProject/listProjectTestPlan.jsp?pid=<%=pid%>">View Test Plans</a>&nbsp;&nbsp;&nbsp;
                <%}%>
                <a href="<%=request.getContextPath()%>/admin/dashboard/projectPerformanceChart.jsp?pid=<%=pid%>">View Project Performance</a>&nbsp;&nbsp;&nbsp;

            </td>
        </tr>
        <tr>
            <td><div><span title="Client"><%=clientName%></span> >> <span title="Company Code"><%=compName%></span> >> <span title="Business Process"><%=nameofbp%></span> >> <span title="Main Process"><%=nameofmp%></span> >> <span title="Sub Process"><%=nameofsp%></span>  >> <span title="Scenario"><%=nameofsc%></span> >> <span title="Variant"><%=nameofvt%></span> >> <span title="Test Case"><%=nameoftc%> </span> >> <span title="Test Step"><%=nameofts%> </span> >> <b>Test Script</b></div></td>
        </tr>
    </table>
    <br>
    <table style="border:1px solid gray;" id="tstable">
        <tr style='background-color: #C3D9FF;border:1px solid red;'>
            <td width="40%"><b>Test Script</b></td>
            <td width="40%"><b>Expected Result</b></td>
            <td width="10%"><b>Created By</b></td>
            <td width="10%"><b>Status</b></td>

        </tr>
        <%
            try {
                connection = MakeConnection.getConnection();
                ps = connection.prepareStatement("select TESTSCRIPT_ID,TEST_SCRIPT,EXPECTED_RESULT,CREATEDBY,PTCID from bpm_testscript where teststep_id=?", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                ps.setString(1, tsId);
                rs = ps.executeQuery();
                String script = null;
                String exp_rslt = null;
                int createdBy = 0;
                int i = 0;
                String color = "white";
                while (rs.next()) {
                    script = rs.getString(2);
                    exp_rslt = rs.getString(3);
                    createdBy = rs.getInt(4);

                    if ((i % 2) != 0) {
                        color = "#E8EEF7";
                    } else {
                        color = "white";
                    }
        %>
        <tr bgcolor="<%=color%>" id="<%=rs.getString(5)%>">
            <td>
                <div class="treeclass" onclick="javascript:showComments('<%=rs.getString(5)%>');"></div>
                <%=script%>
            </td>
            <td><%=exp_rslt%></td>
            <td><%=GetProjectManager.getUserName(createdBy)%></td>
            <td><%=ViewBPM.getTestScriptStatus(rs.getString(5))%></td>

        </tr>
        <tr  id="ptc<%=rs.getString(5)%>"></tr>
        <%
                    i++;
                }
            } catch (Exception e) {
                logger.error(e.getMessage());
            } finally {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
                if (connection != null) {
                    connection.close();
                }

            }
        %>


    </table>
    <table id="created">
    </table>
</body>
</html>



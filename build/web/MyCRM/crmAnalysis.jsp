<%-- 
    Document   : crmAnalysis
    Created on : 22 Nov, 2019, 10:24:46 AM
    Author     : Muthu
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@page import="com.eminent.util.GetProjectMembers"%>
<%@page import="java.util.Map"%>
<%@page import="com.eminent.customer.CRMSummaryCount"%>
<%@page import="java.util.HashMap"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page import="org.apache.log4j.*"%>






<%
//			response.setHeader("Cache-Control","no-cache");
//			response.setHeader("Cache-Control","no-store");
//			response.setDateHeader("Expires", 0);
//		 	response.setHeader("Pragma","no-cache");

    //Configuring log4j properties
    Logger logger = Logger.getLogger("CRM Summary");

    String logoutcheck = (String) session.getAttribute("Name");
    if (logoutcheck == null) {
        logger.fatal("================Session expired===================");
%>
<jsp:forward page="../SessionExpired.jsp"></jsp:forward>
<%
    }

%>

<HTML>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
    <TITLE>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS
        Solution</TITLE>
    <META NAME="Generator" CONTENT="EditPlus">
    <META NAME="Author" CONTENT="">
    <META NAME="Keywords" CONTENT="">
    <META NAME="Description" CONTENT="">
    <LINK title=STYLE
          href="<%= request.getContextPath()%>/eminentech support files/main_ie.css"
          type=text/css rel=STYLESHEET>
    <script src="<%=request.getContextPath()%>/javaScript/jquery.tablesorter.min.js" type="text/javascript"></script>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/theme.blue1.css?test=150720161404">


</HEAD>

<jsp:useBean id="csr" class="com.eminentlabs.crm.CRMAnalysis"></jsp:useBean>
    <BODY BGCOLOR="#FFFFFF">

    <%@ include file="../header.jsp"%>
    <table width="100%">
        <tr>
            <td colspan="3">
                <%int roleId = (Integer) session.getAttribute("Role");
                    if (roleId == 1) {
                %>
                <a href="<%=request.getContextPath()%>/admin/customer/crmPerformance.jsp" style="cursor: pointer">CRM Performance Chart</a> &nbsp;&nbsp;&nbsp;&nbsp;              
                <%}%>
                <a href="<%=request.getContextPath()%>/MyCRM/crmSummary.jsp">CRM Summary</a> &nbsp;&nbsp;&nbsp;&nbsp;              
                <a href="<%=request.getContextPath()%>/MyCRM/crmAnalysis.jsp" style="font-weight: bold;">CRM Analysis</a> &nbsp;&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/MyCRM/industryMaintenance.jsp" style="cursor: pointer">Industry Maintenance</a> &nbsp;&nbsp;&nbsp;&nbsp;
            </td>
        </tr>
    </table>

    <br>
    <br>

    <table cellpadding="0" cellspacing="0" width="100%">
        <tr border="2" bgcolor="#E8EEF7">
            <td bgcolor="#E8EEF7" border="1" align="left">
                <font size="4" COLOR="#0000FF"> <b> CRM Analysis </b></font></td>
        </tr>
    </table>
    <%
        csr.getAll(request);
    %>
    <!--        </br> </br> </br>     </br>-->

    <div >
        <table class="tablecontent">
            <thead>

                <tr >
                    <th  class="filter-select filter-match" data-placeholder="Select a State"><font><b>State</b></FONT></th>
                            <%for (Map.Entry<String, Integer> industry : csr.getIndustrywise().entrySet()) {%>
                    <TH  style="text-align: center;" data-placeholder="Try >=, <=,=,!= "><font><b><%=industry.getKey()%>&nbsp;&nbsp;(<%=industry.getValue()%>)</b></font></TH>
                            <%}%>
                    <TH  style="text-align: center;" data-placeholder="Try >=, <=,=,!= "><font><b>Total</b></FONT></TH>
                </tr>
            </thead>
            <tbody>
                <%for (Map.Entry<String, Map<String, Integer>> entry : csr.getCrmAnalysis().entrySet()) {%>
                <tr>
                    <td><%=entry.getKey()%> </td>
                    <%
                        int statewise = 0;
                        for (Map.Entry<String, Integer> industry : csr.getIndustrywise().entrySet()) {
                            if (entry.getValue().containsKey(industry.getKey())) {
                                statewise += entry.getValue().get(industry.getKey());
                            }
                    %>
                    <td style="text-align: center;"><span class="crmsearch" heading="<%=entry.getKey()%>" contactType="<%=industry.getKey()%>" ><%=entry.getValue().get(industry.getKey()) == null ? 0 : entry.getValue().get(industry.getKey())%></SPAN></td>
                            <%}%>
                    <td style="text-align: center;"><%=statewise%></td>
                </tr>
                <%}%>
            </tbody>


        </table>


    </div>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<link rel="stylesheet" href="<%= request.getContextPath()%>//css/jquery-ui.css"/>
<script src="<%= request.getContextPath()%>/javaScript/jquery-ui.js"></script>
<SCRIPT type="text/javascript" 	src="<%=request.getContextPath()%>/javaScript/jquery.min.js"></script>
<script src="<%=request.getContextPath()%>/javaScript/jquery.tablesorter1.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/javaScript/jquery.tablesorter.widgets.js" type="text/javascript"></script>    
<script src="<%=request.getContextPath()%>/javaScript/jquery.tablesorter.pager.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/javaScript/pager-custom-controls.js" type="text/javascript"></script>
<script type="text/javascript">
    $(document).ready(function () {

        $(".tablecontent").tablesorter({
            theme: 'blue',
            // hidden filter input/selects will resize the columns, so try to minimize the change
            widthFixed: true,
            // initialize zebra striping and filter widgets
            widgets: ["zebra", "filter"],
            widgetOptions: {
                // extra css class applied to the table row containing the filters & the inputs within that row
                filter_cssFilter: 'tablesorter-filter',
                // If there are child rows in the table (rows with class name from "cssChildRow" option)
                // and this option is true and a match is found anywhere in the child row, then it will make that row
                // visible; default is false
                filter_childRows: false,
                // if true, filters are collapsed initially, but can be revealed by hovering over the grey bar immediately
                // below the header row. Additionally, tabbing through the document will open the filter row when an input gets focus
                filter_hideFilters: false,
                // Set this option to false to make the searches case sensitive
                filter_ignoreCase: true,
                // jQuery selector string of an element used to reset the filters
                filter_reset: '.reset',
                // Use the $.tablesorter.storage utility to save the most recent filters
                filter_saveFilters: false,
                // Delay in milliseconds before the filter widget starts searching; This option prevents searching for
                // every character while typing and should make searching large tables faster.
                filter_searchDelay: 300,
                // Set this option to true to use the filter to find text from the start of the column
                // So typing in "a" will find "albert" but not "frank", both have a's; default is false
                filter_startsWith: false,
                // if false, filters are collapsed initially, but can be revealed by hovering over the grey bar immediately
                // below the header row. Additionally, tabbing through the document will open the filter row when an input gets focus
                // Add select box to 4th column (zero-based index)
                // each option has an associated function that returns a boolean
                // function variables:
                // e = exact text from cell
                // n = normalized value returned by the column parser
                // f = search filter input value
                // i = column index
                filter_functions: {
                },
                filter_formatter: {
                }
            }
        });
    });
</script>
<script>
    $(document).on('click', '.crmsearch', function () {
        var state = $.trim($(this).attr('heading'));
        var industry = $.trim($(this).attr('contactType'));
        window.open("<%=request.getContextPath()%>/MyCRM/crmCompany.jsp?company=&state=" + state + "&industry=" + industry + "");
    });
</script>
<style>
    .pager a.current {
        color: #0080ff;
        font-weight: 800;            
    }
    .pager a {
        text-decoration: none;
        color: black;
    }
    .tablesorter-blue tbody tr.odd > td {
        background-color: #E8EEF7;
    }
    .tablesorter-blue tbody tr.even > td {
        background-color: white;
    }
    .crmsearch{
        cursor: pointer;
        text-decoration: underline;
        text-decoration-color: blue;
    }
</style>


</BODY>
</HTML>



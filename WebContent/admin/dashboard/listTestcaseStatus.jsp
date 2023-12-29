<%-- 
    Document   : listTestcaseStatus
    Created on : Jul 22, 2010, 12:54:51 PM
    Author     : Tamilvelan
--%>
<%@page  import="java.util.HashMap,com.pack.StringUtil,org.apache.log4j.*,java.util.List,java.util.Iterator,com.eminent.tqm.TqmPtcm,com.eminent.tqm.TqmTestcaseexecution,com.eminent.tqm.TqmUtil,com.eminent.tqm.TestCasePlan,com.eminent.util.GetProjectMembers,com.eminent.util.GetProjects,com.eminent.util.GetProjectManager,java.text.SimpleDateFormat"%>
<%
    session.setAttribute("forwardpage", "/MyAssignment/listTestCases.jsp");

    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Cache-Control", "no-store");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);

//Configuring log4j properties
    Logger logger = Logger.getLogger("listTestCaseStatus");

    String logoutcheck = (String) session.getAttribute("Name");
    if (logoutcheck == null) {
        logger.fatal("=========================Session Expired======================");
%>
<jsp:forward page="../SessionExpired.jsp"></jsp:forward>
<%
    }
%>

<%@ include file="/header.jsp"%>

<html>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">

    <title>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS Solution</title>
    <LINK title=STYLE  href="<%= request.getContextPath()%>/eminentech support files/main_ie.css" type="text/css" rel="STYLESHEET">
    <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/checkSubmit.js"></script>
        <script src="<%= request.getContextPath()%>/javaScript/jquery.js" type="text/javascript" />
    <script src="<%= request.getContextPath()%>/javaScript/jquery-1.10.2.js"></script>
        <link rel="stylesheet" href="<%=request.getContextPath()%>/css/theme.blue1.css?test=2">

</head>
<body>
    <%


    %>
    <table cellpadding="0" cellspacing="0" width="100%">
        <tr border="2" bgcolor="#C3D9FF">
            <td align="left"><b> Execution Plan Test Cases</b></td>

        </tr>

    </table>

    <%            String status = request.getParameter("status");
        String planId = request.getParameter("planId");
        logger.info("Plan " + planId + "Status" + status);
        try {

            int adminId = GetProjectMembers.getAdminID();
            int userId = (Integer) session.getAttribute("uid");
            List ptc = TestCasePlan.listStatusTestcases(planId, status);
            int noOfRecords = ptc.size();


    %>
    <br>
    <table cellpadding="0" cellspacing="0" width="100%">
        <tr border="2" >
            <td align="left">This list shows <b><%=noOfRecords%></b> Test Cases in <%=status%> Status</td>

        </tr>

    </table>
    <br>

    <table id="tables">
        <thead>
        <tr bgcolor="#C3D9FF" >
            <th width="3%"><b>Sl No</b></th>
            <th width="7%"><b>TestCaseId</b></th>
            <th width="7%"><b>IssueId</b></th>
            <th width="9%" class="filter-select filter-match" data-placeholder="Select a Module"><b>Module</b></th>
            <th width="10%"class="filter-select filter-match" data-placeholder="Select a Module"><b>TestPlan</b></th>
            <th width="18%"><b>Functionality</b></th>
            <th width="18%"><b>Description</b></th>
            <th width="18%"><b>Expected Result</b></th>
            <th width="8%" class="filter-select filter-match" data-placeholder="Select a Status"><b>Status</b></th>
            <th width="8%" class="filter-select filter-match" data-placeholder="Select a Createdby"><b>Createdby</b></th>
            <th width="4%"><b>DueDate</b></th>
        </tr>
        </thead>
        <tbody>
        <%
            int k = 1, order;
            String created = null;
            TqmTestcaseexecution t = null;
            HashMap statusMap = TestCasePlan.getTescaseStatus();
            for (Iterator i = ptc.iterator(); i.hasNext(); k++) {
                t = (TqmTestcaseexecution) i.next();
                String ptcid = t.getPtcid().getPtcid();
                String func = t.getPtcid().getFunctionality();
                String desc = t.getPtcid().getDescription();
                String reslt = t.getPtcid().getExpectedresult();
                String tp = t.getTqmTestcaseexecutionplan().getPlanname();
                String project = GetProjects.getProjectName(((Integer) t.getPtcid().getPid()).toString());
                String module = GetProjects.getModuleName(((Integer) t.getPtcid().getMid()).toString());
                created = GetProjectManager.getUserName(t.getPtcid().getCreatedby());
                String testcasestatus = (String) statusMap.get(t.getStatusid());
                int statusId = t.getStatusid();
                int tceId = t.getTceid();
                order = t.getTestorder();
                java.util.Date date = t.getCreatedon();
                java.util.Date dDate = t.getDuedate();
                SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yy");
                String requestedOn = sdf.format(date);
                String dueDate = sdf.format(dDate);

                project = project.replace(":", " v");
                String funcTitle = func;
                String descTitle = desc;
                String rsltTitle = reslt;
                if (func.length() > 30) {
                    func = func.substring(0, 30) + "...";
                }
                if (desc.length() > 30) {
                    desc = desc.substring(0, 30) + "...";
                }
                if (reslt.length() > 30) {
                    reslt = reslt.substring(0, 30) + "...";
                }

                String color = "white";
                if ((k % 2) != 0) {
                    color = "white";
                } else {
                    color = "#E8EEF7";
                }
        %>
        <tr bgcolor="<%=color%>" height="22">
            <td><%=order%></td>
            <td><a href="<%=request.getContextPath()%>/admin/dashboard/testcaseDetails.jsp?ptcID=<%=ptcid%>&statusId=<%=statusId%>&tceId=<%=tceId%>&assignedto=<%=userId%>"><%=ptcid%></a></td>
         <td>
                        <%if(t.getIssuereference()==null){%>
                        <%}else{%>
                        <a target="_blank" href="<%=request.getContextPath()%>/viewIssueDetails.jsp?issueid=<%=t.getIssuereference()%>"><%=t.getIssuereference()%></a>          
                        <%}%>
                    </td>
            <td title="Project : <%=project%>"><%=module%></td>
            <td><%=tp%></td>
            <td title="<%=StringUtil.encodeHtmlTag(funcTitle)%>"><%=StringUtil.encodeHtmlTag(func)%></td>
            <td title="<%=StringUtil.encodeHtmlTag(descTitle)%>"><%=StringUtil.encodeHtmlTag(desc)%></td>
            <td title="<%=StringUtil.encodeHtmlTag(rsltTitle)%>"><%=StringUtil.encodeHtmlTag(reslt)%></td>
            <td><%=testcasestatus%></td>
            <td><%=created%></td>
            <td><%=dueDate%></td>
        </tr>



        <%
                }
            } catch (Exception e) {
                logger.error(e.getMessage());
            }
        %>
        </tbody>
    </table>
                  
                 <SCRIPT type="text/javascript" 	src="https://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>

<link rel="stylesheet" href="<%= request.getContextPath()%>//css/jquery-ui.css"/>
<script src="<%= request.getContextPath()%>/javaScript/jquery-ui.js"></script>


<script src="<%=request.getContextPath()%>/javaScript/jquery.tablesorter1.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/javaScript/jquery.tablesorter.widgets.js" type="text/javascript"></script>    

            <script type="text/javascript">


                $(document).ready(function() {
                     $("#tables").tablesorter({
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
</style>

</body>
</html>
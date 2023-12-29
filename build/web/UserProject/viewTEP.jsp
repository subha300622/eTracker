<%-- 
    Document   : viewTEP
    Created on : 6 Jul, 2010, 1:11:05 PM
    Author     : Tamilvelan
--%>
<%@page import="java.util.ArrayList"%>
<%@page  import="java.util.Date,dashboard.CheckCategory,java.util.HashMap,com.pack.StringUtil,org.apache.log4j.Logger,java.util.List,java.util.Iterator,com.eminent.tqm.TqmPtcm,com.eminent.tqm.TqmTestcaseexecution,com.eminent.tqm.TqmUtil,com.eminent.tqm.TestCasePlan,com.eminent.util.GetProjectMembers,com.eminent.util.GetProjects,com.eminent.util.GetProjectManager,java.text.SimpleDateFormat"%>
<%


    Logger logger = Logger.getLogger("viewTEP");
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
        -
        <script src="<%=request.getContextPath()%>/javaScript/jquery-latest.min_1.js" type="text/javascript"></script>
        <script src="<%=request.getContextPath()%>/javaScript/jquery.tablesorter1.js" type="text/javascript"></script>
        <script src="<%=request.getContextPath()%>/javaScript/jquery.tablesorter.widgets.js" type="text/javascript"></script>    
        <link rel="stylesheet" href="<%=request.getContextPath()%>/css/theme.blue1.css?test=2">
        <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/tooltip.js"></script>
        <!--        <script type="text/javascript">
                    $(function() {
        
                        $('input[name^="text"]').change(function() {
        
                            var $current = $(this);
        
                            $('input[name^="text"]').each(function() {
                                if ($(this).val() === $current.val() && $(this).attr('id') !== $current.attr('id'))
                                {
                                    alert('duplicate found!');
                                }
        
                            });
                        });
                    });
                </script>-->
        
           <script type="text/javascript">
           
            $(function() {

                // call the tablesorter plugin
                $("#filtersort").tablesorter({
                    theme: 'blue',
                    // hidden filter input/selects will resize the columns, so try to minimize the change
                    widthFixed: true,
                    // initialize zebra striping and filter widgets
                    widgets: ["zebra", "filter"],
                    headers: {7: {// <-- replace 6 with the zero-based index of your column
                            sorter: 'ddMMMyy'
                        }},
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
                        }

                    }

                });
            });</script>
    </head>
    <body>
        <%
            String pid = request.getParameter("pid");
            String tepId = request.getParameter("tepId");
            String project = GetProjects.getProjectName(pid);
            String category = CheckCategory.getProjectCategory(pid);
            List ptc = TestCasePlan.viewExecutionTestcases(tepId);
            //       List ptc        =   new ArrayList();
            int noOfRecords = ptc.size();
            logger.info("No of Records" + noOfRecords);          
            String fwdPage = "/UserProject/viewTEP.jsp?tepId=" + tepId + "&pid=" + pid;
            logger.info(fwdPage);
            session.setAttribute("forwardpage", fwdPage);
        %>
        <table cellpadding="0" cellspacing="0" width="100%">
            <tr border="2" bgcolor="#C3D9FF">
                <td align="left"><b> Execution Plan Test Cases</b></td>

            </tr>

        </table>
        <br>
        <table width="100%">
            <tr>
                <td width="5%">
                    <%
                        if (category.equalsIgnoreCase("SAP Project")) {
                    %>
                    <a href="<%=request.getContextPath()%>/testMap.jsp?pid=<%=pid%>">Test Map Tree View</a>&nbsp;&nbsp;&nbsp;
                    <a href="<%=request.getContextPath()%>/admin/dashboard/projectChart.jsp?project=<%=project%>">Status-wise Dashboard</a>&nbsp;&nbsp;&nbsp;
    <!--                <a href="<%=request.getContextPath()%>/UserBPM/dashboardForCompany.jsp?pid=<%=pid%>">View Test Map Dashboard</a>&nbsp;&nbsp;&nbsp;-->
                    <%
                        }
                    %>
                    <a href="<%=request.getContextPath()%>/admin/dashboard/modulewiseChart.jsp?project=<%=project%>">Module-wise Dashboard</a>&nbsp;&nbsp;&nbsp;

                    <a href="<%=request.getContextPath()%>/admin/dashboard/TestCasesChart.jsp?project=<%=pid%>">View Test Coverage</a>&nbsp;&nbsp;&nbsp;
                    <a href="<%=request.getContextPath()%>/UserProject/listProjectTestPlan.jsp?pid=<%=pid%>">View Test Plans</a>&nbsp;&nbsp;&nbsp;

                    <a href="<%=request.getContextPath()%>/admin/dashboard/projectPerformanceChart.jsp?pid=<%=pid%>">View Project Performance</a>&nbsp;&nbsp;&nbsp;

                </td>
            </tr>
        </table>
        <table cellpadding="0" cellspacing="0" width="100%">
            <tr border="2">
                <td align="left">This list shows <b><%=noOfRecords%></b> Test Cases assigned to the Test Plan</td>

            </tr>

        </table>
        <%

            try {
                int adminId = GetProjectMembers.getAdminID();
                int userId = (Integer) session.getAttribute("uid");
        %>

        <br>
        <form action="updateOrder.jsp" method="post" onsubmit="">
            <table width="100%" id="tables">
                <thead>
                <tr bgcolor="#C3D9FF" >
                    <th width="1%"><b>Sl</b></th>
                    <th width="10%"><b>TestCaseId</b></th>
                    <th width="10%"><b>IssueId</b></th>
                    <th width="10%" class="filter-select filter-match" data-placeholder="Select a Module"><b>Project</b></th>
                    <th width="8%" class="filter-select filter-match" data-placeholder="Select a Module"><b>Module</b></th>
                    <th width="12%" class="filter-select filter-match" data-placeholder="Select a Functionality"><b>Functionality</b></th>
                    <th width="12%"class="filter-select filter-match" data-placeholder="Select a Test Step"><b>Test Step</b></th>
                    <th width="16%"><b>Description</b></th>
                    <th width="16%"><b>Expected Result</b></th>
                    <th width="8%" class="filter-select filter-match" data-placeholder="Select a Status"><b>Status</b></th>
                    <th width="8%" class="filter-select filter-match" data-placeholder="Select a AssignedTo"><b>AssignedTo</b></th>
                    <th width="8%"><b>DueDate</b></th>
                </tr>
                </thead>
                <tbody>
                <%
                    int k = 1;
                    String created = null;
                    String assignedTo = null;

                    TqmTestcaseexecution t = null;
                    SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yy");
                    String ptcid, func, desc, reslt, module, testcasestatus, dueDate, funcTitle, descTitle, rsltTitle,testStep,testStepC;
                    int statusId, assigned, tceId, order;
                    Date date;
                    HashMap statusMap = TestCasePlan.getTescaseStatus();
                    for (Iterator i = ptc.iterator(); i.hasNext(); k++) {
                        t = (TqmTestcaseexecution) i.next();
                        ptcid = t.getPtcid().getPtcid();
                        func = t.getPtcid().getFunctionality();
                        desc = t.getPtcid().getDescription();
                        reslt = t.getPtcid().getExpectedresult();
                        //         String project   =   GetProjects.getProjectName(((Integer)t.getPtcid().getPid()).toString());
                        module = GetProjects.getModuleName(((Integer) t.getPtcid().getMid()).toString());
                        created = GetProjectManager.getUserName(t.getPtcid().getCreatedby());
                        assignedTo = GetProjectManager.getUserName(t.getAssignedto().getUserid());
                                                     testStep = TestCasePlan.getTestStepByPTC(ptcid);

                        statusId = t.getStatusid();
                        testcasestatus = (String) statusMap.get(statusId);
                        assigned = t.getAssignedto().getUserid();

                        tceId = t.getTceid();

                        date = t.getDuedate();
                        order = t.getTestorder();
                        dueDate = sdf.format(date);

                        project = project.replace(":", " v");
                        funcTitle = func;
                        descTitle = desc;
                        rsltTitle = reslt;
                        if (func.length() > 30) {
                            func = func.substring(0, 30) + "...";
                        }
                        if (desc.length() > 30) {
                            desc = desc.substring(0, 30) + "...";
                        }
                        if (reslt.length() > 30) {
                            reslt = reslt.substring(0, 30) + "...";
                        }
                        testStepC=testStep;
                        if (testStep.length() > 30) {
                            testStepC = testStep.substring(0, 30) + "...";
                        }

                        String color = "white";
                        if ((k % 2) != 0) {
                            color = "white";
                        } else {
                            color = "#E8EEF7";
                        }
                %>
                <tr bgcolor="<%=color%>" height="22">
                    <td><input type="text" class="text" id="<%=ptcid%>" name="<%=ptcid%>" value="<%=order%>" size="1"/></td>
                    <td><a href="<%=request.getContextPath()%>/UserProject/runTestcases.jsp?ptcID=<%=ptcid%>&statusId=<%=statusId%>&tceId=<%=tceId%>&assignedto=<%=assigned%>"><%=ptcid%></a></td>
                    <td>
                        <%if(t.getIssuereference()==null){%>
                        <%}else{%>
                        <a target="_blank" href="<%=request.getContextPath()%>/viewIssueDetails.jsp?issueid=<%=t.getIssuereference()%>"><%=t.getIssuereference()%></a>          
                        <%}%>
                    </td>                        
                    <td><%=project%></td>
                    <td><%=module%></td>
                    <td title="<%=StringUtil.encodeHtmlTag(funcTitle)%>"><%=StringUtil.encodeHtmlTag(func)%></td>
                    <td title="<%=StringUtil.encodeHtmlTag(testStep)%>"><%=StringUtil.encodeHtmlTag(testStepC)%></td>
                    <td title="<%=StringUtil.encodeHtmlTag(descTitle)%>"><%=StringUtil.encodeHtmlTag(desc)%></td>
                    <td title="<%=StringUtil.encodeHtmlTag(rsltTitle)%>"><%=StringUtil.encodeHtmlTag(reslt)%></td>
                    <td><%=testcasestatus%></td>
                    <td title="Created By :<%=created%>"><%=assignedTo%></td>
                    <td><%=dueDate%></td>
                </tr>
                <%
                        }
                    } catch (Exception e) {
                        logger.error(e.getMessage());
                    }
                %>
                </tbody>
                <tfoot>
                     <tr>
                    <td colspan="12" align="center"><input type="submit" id="submit" value="Submit"><input type="reset" id="reset" value="Reset"></td>
                </tr>
                </tfoot>
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

                    $('.text').keydown(function(event) {
                        // Allow special chars + arrows 
                        if (event.keyCode == 46 || event.keyCode == 8 || event.keyCode == 9
                                || event.keyCode == 27 || event.keyCode == 13
                                || (event.keyCode == 65 && event.ctrlKey === true)
                                || (event.keyCode >= 35 && event.keyCode <= 39)) {
                            return;
                        } else {
                            // If it's not a number stop the keypress
                            if (event.shiftKey || (event.keyCode < 48 || event.keyCode > 57) && (event.keyCode < 96 || event.keyCode > 105)) {
                                event.preventDefault();
                            }
                        }
                    });
                    $('#submit').click(function() {
                        var counts = 0;
                        var rows = $('#tables');
                        var count = $("input:text").length;
                        var counta = new Number(count);
                        var sorted;

                        $.each(rows, function() {
                            sorted = $(this).find("input[type='text']").sort(
                                    function(a, b) {
                                        return a.value - b.value;
                                    });

                            var sortedMax = $(this).find("input[type='text']").sort(
                                    function(a, b) {
                                        return b.value - a.value;
                                    });
                            var lowest = sorted[0].value;
                            var highest = sortedMax[0].value;
                            var highesta = new Number(highest);
                            var lowesta = new Number(lowest);
                            var maxCount = counta + lowesta;
                            var maxCounta = new Number(maxCount);
                            maxCounta = maxCounta - 1;

                            if (lowesta == 0) {
                                alert('Serial Number should not empty or zero.');                             
                                counts = 1;

                            }

                            if (highesta > maxCounta && counts == 0) {
                                alert('Crossed maximum number of Serial Number. Please enter the serial Number between '+lowesta+' and '+maxCounta);
                                counts = 1;
                            }
                            if (counts == 0) {
                                for (var k = 0; k < maxCounta; k++) {
                                    if (sorted[k].value == sorted[k + 1].value) {
                                        alert('Duplicate value is ' + sorted[k].value);
                                        counts = 1;
                                        break;
                                    }
                                }
                            }
                        });
                        if (counts == 0) {
                            return true;
                        } else {
                            return false;
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


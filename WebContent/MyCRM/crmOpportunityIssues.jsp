<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page import="org.apache.log4j.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.HashMap, java.text.*, com.pack.StringUtil"%>
<%@ page import="pack.eminent.encryption.*,com.eminent.util.*, dashboard.CheckDate,com.eminentlabs.crm.CRMUtil"%>





<%
    session.setAttribute("forwardpage", "/MyCRM/crmOpportunityIssues.jsp");
//			response.setHeader("Cache-Control","no-cache");
//			response.setHeader("Cache-Control","no-store");
//			response.setDateHeader("Expires", 0);
//		 	response.setHeader("Pragma","no-cache");

    //Configuring log4j properties
    Logger logger = Logger.getLogger("crmIssues");

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
          href="<%= request.getContextPath()%>/eminentech support files/main_ie.css" type="text/css" rel=STYLESHEET>
    <script src="<%=request.getContextPath()%>/javaScript/jquery.tablesorter.min.js" type="text/javascript"></script>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/theme.blue1.css?test=150720161404">
    <script src="<%= request.getContextPath()%>/javaScript/jquery-1.10.2.js"></script>
    <script language="JavaScript">
        function check(searchOpportuntiy) {
            if ((searchOpportuntiy.opportunityName.value == null) || (searchOpportuntiy.opportunityName.value == ""))
            {
                alert("Please Enter Opportunity Name ")
                searchOpportuntiy.opportunityName.focus()
                return false
            }
            return true
        }

    </script>
</HEAD>

<style fprolloverstyle>
    A:hover {
        color: #FF0000;
        font-weight: bold
    }
</style>
<BODY BGCOLOR="#FFFFFF">

    <%@ include file="../header.jsp"%>
    <form name="searchOpportuntiy" onsubmit="return check(this);"
          action="searchOpportunity.jsp">
        <table cellpadding="0" cellspacing="0" width="100%">
            <tr border="2" bgcolor="#E8EEF7">
                <td bgcolor="#E8EEF7" border="1" align="left"><font size="4"
                                                                    COLOR="#0000FF"> <b> CRM Opportunity Issues </b></font><FONT SIZE="3"
                                                                                 COLOR="#0000FF"> </FONT></td>
                <td align="right"><b>Enter Opportunity Name:</b></td>
                <td align="left"><input type="text" name="opportunityName" maxlength="40"
                                        size="15"></td>
                <td><input type="submit" name="submit" value="Search"></td>
                <td><input type="reset" name="reset" value="Reset"></td>
                <td width="25%" border="1" align="right"><font size="2"
                                                               face="Verdana, Arial, Helvetica, sans-serif"></font></td>
            </tr>
        </table>
    </form>

    <br>

    <jsp:useBean id="CRMIssue" class="com.pack.CRMIssueBean" /> 
    <%  int age;
        int userid_curri;
        HashMap<String, Integer> hm = null;
        Connection connection = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            connection = MakeConnection.getConnection();
            logger.debug("Connection:" + connection);
            if (connection != null) {
                Integer userid_curr = (Integer) session.getAttribute("userid_curr");
                userid_curri = userid_curr.intValue();
                String assignedtoa = String.valueOf(userid_curri);
                ps = connection.prepareStatement("SELECT OPPORTUNITYID,OPPORTUNITYNAME, ASSIGNEDTO, AMOUNT, CLOSE_DATE,STAGE,DESCRIPTION,PROBABILITY from opportunity where roleid=2 and assignedto=? order by close_date ASC", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                ps.setString(1, assignedtoa);
                rs = ps.executeQuery();
                int apmIssues = CRMIssue.getAPMIssues(connection, userid_curri);
                hm = CRMIssue.getCRMIssuesCounts(connection, userid_curri);
                int contact = hm.get("Contact");
                int lead = hm.get("Lead");
                int account = hm.get("Account");
                String pro = "CRM";
                String fix = "1.0";
                String manager = GetProjectManager.getManager(pro, fix);
                int userId = (Integer) session.getAttribute("userid_curr");
                int unapprovedContact = 0;
                if (Integer.parseInt(manager) == userId) {
                    unapprovedContact = CRMUtil.getUnapprovedContacts(userId);
                }
    %>
    <table width="100%">
        <tr>
            <td colspan="3">
                <%
                    if (contact > 0) {
                %>
                <a href="<%=request.getContextPath()%>/MyCRM/crmContactIssues.jsp">Contact Issues</a>&nbsp;&nbsp;&nbsp;&nbsp;
                <%}

                    if (unapprovedContact > 0) {
                %>
                <a href="<%=request.getContextPath()%>/MyCRM/waitingContacts.jsp">Approve Contacts</a>&nbsp;&nbsp;&nbsp;&nbsp;
                <%}
                    if (lead > 0) {
                %>  
                <a href="<%=request.getContextPath()%>/MyCRM/crmLeadIssues.jsp">Lead Issues</a>&nbsp;&nbsp;&nbsp;&nbsp;
                <%}%>
                <b><a href="javascript:void(0);">Opportunity Issues</a></b>&nbsp;&nbsp;&nbsp;&nbsp;
                <%
                    if (account > 0) {
                %>    
                <a href="<%=request.getContextPath()%>/MyCRM/crmAccountIssues.jsp">Account Issues</a>
                <%}%>
                &nbsp;&nbsp;&nbsp;&nbsp;<a href="<%=request.getContextPath()%>/MyCRM/crmSummary.jsp">CRM Summary</a>
            </td>
        </tr>
        <tr>
            <% if (apmIssues > 0) {%>
            <td align="right" width="40%">You have <a href="<%=request.getContextPath()%>/MyAssignment/UpdateIssue.jsp"><%=apmIssues%></a> APM Issues</td>
            <%}%>
        </tr>
    </table>
    <br>
    <table width=100% id="user" class="tablesorter">
        <thead>
            <tr class="tablesorter-ignoreRow" >
                <td class="pager" colspan="2" style="background-color: white">
                    <span class="pagedisplay"></span>
                </td>
                <td colspan="3" style="background-color: white">
                    <div class="pager"><nav class="left"> # per page: <a href="#">10</a> | <a href="#" >25</a> | <a href="#">50</a>|<a href="#" class="current">100</a>
                        </nav> 
                        <nav class="right"> <span class="prev"> <img
                                    src="<%=request.getContextPath()%>/images/prev.png" /> Prev&nbsp; </span> <span
                                class="pagecount"></span> &nbsp;<span class="next">Next <img
                                    src="<%=request.getContextPath()%>/images/next.png" /> </span> </nav></div>
                </td>
            </tr>
            <tr bgColor="#C3D9FF" height="9">
                <th width="25%"><font><b>Opportunity Name</b></font></th>
                <th width="20%" class="filter-select filter-match" data-placeholder="Select a Assigned"><font><b>Assigned To</b></font></th>
                <th width="15%" ALIGN="center" data-placeholder="Try >=, <=,=,!= "><font><b>Deal Value</b></font></th>
                <th width="15%"><font><b>Close Date</b></font></th>
                <th width="15%" class="filter-select filter-match" data-placeholder="Select a Stage"><font><b>Stage</b></font></th>
            </tr>
        </THEAD>
        <TBODY>
            <%while (rs.next()) {
                    int opportunityid = rs.getInt("opportunityid");
                    String opportunityname = rs.getString("opportunityname");
                    if (opportunityname == null) {
                        opportunityname = "NA";
                    }
                    int assignedto = rs.getInt("ASSIGNEDTO");

                    String amount = rs.getString("amount");
                    if (amount == null) {
                        amount = "NA";
                    }
                    String probability = rs.getString("PROBABILITY");
                    java.sql.Date closedate = rs.getDate("CLOSE_DATE");

                    String stage = rs.getString("stage");
                    if (stage == null) {
                        stage = "NA";
                    }

                    SimpleDateFormat dfm = new SimpleDateFormat("dd-MMM-yyyy");
                    String dueDate = "NA";
                    if (closedate != null) {
                        dueDate = dfm.format(closedate);
                    }
            %>
            <tr height="21">
                <td width="25%"><font
                        face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><A HREF="opportunityIssueView.jsp?opportunityid=<%=opportunityid%>"><%= StringUtil.encodeHtmlTag(opportunityname)%></A></font></td>
                <td width="20%"><font
                        face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%=GetProjectManager.getUserName(assignedto)%></font></td>
                <td width="15%"><font
                        face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= (Long.parseLong(amount) * Long.parseLong(probability)) / 100%></font></td>
                <td width="15%"><font
                        face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= dueDate%></font></td>
                <td width="15%"><font
                        face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= StringUtil.encodeHtmlTag(stage)%></font></td>
            </tr>

            <%
                        }
                    }
                } catch (Exception e) {
                    logger.error("Exception:" + e);
                    //System.err.println(e);
                } finally {
                    //MyIssue.close();
                    logger.debug("closing jdbc resources in finally block");
                    if (rs != null) {
                        rs.close();
                    }
                    if (ps != null) {
                        ps.close();
                    }
                    if (connection != null) {
                        connection.close();
                        //                logger.info("connection closed");
                    }
                    if (connection.isClosed()) {
                        logger.info("Connection is Closed");
                    } else {
                        logger.info("Connection not Closed");
                    }
                }
            %> 
        </tbody>
        <tfoot>
            <tr>
                <td colspan="5" style="background-color: #c3d9ff;">
                    <div class="pager"><nav class="left"> # per page: <a href="#">10</a> | <a href="#" >25</a> | <a href="#">50</a>|<a href="#" class="current">100</a>
                        </nav> 
                        <nav class="right"> <span class="prev"> <img
                                    src="<%=request.getContextPath()%>/images/prev.png" /> Prev&nbsp; </span> <span
                                class="pagecount"></span> &nbsp;<span class="next">Next <img
                                    src="<%=request.getContextPath()%>/images/next.png" /> </span> </nav></div>
                </td>
            </tr>
        </tfoot>
    </TABLE>
<link rel="stylesheet" href="<%= request.getContextPath()%>//css/jquery-ui.css"/>
<script src="<%= request.getContextPath()%>/javaScript/jquery-ui.js"></script>
<SCRIPT type="text/javascript" 	src="<%=request.getContextPath()%>/javaScript/jquery.min.js"></script>
<script src="<%=request.getContextPath()%>/javaScript/jquery.tablesorter1.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/javaScript/jquery.tablesorter.widgets.js" type="text/javascript"></script>    
<script src="<%=request.getContextPath()%>/javaScript/jquery.tablesorter.pager.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/javaScript/pager-custom-controls.js" type="text/javascript"></script>
<script type="text/javascript">
        $(document).ready(function () {
            var $table = $('#user'),
                    $pager = $('.pager');
            $.tablesorter.customPagerControls({
                table: $table, // point at correct table (string or jQuery object)
                pager: $pager, // pager wrapper (string or jQuery object)
                pageSize: '.left a', // container for page sizes
                currentPage: '.right a', // container for page selectors
                ends: 2, // number of pages to show of either end
                aroundCurrent: 5, // number of pages surrounding the current page
                link: '<a href="#" class="pagerno">{page}</a>', // page element; use {page} to include the page number
                currentClass: 'current', // current page class name
                adjacentSpacer: ' | ', // spacer for page numbers next to each other
                distanceSpacer: ' \u2026 ', // spacer for page numbers away from each other (ellipsis &amp;hellip;)
                addKeyboard: true                      // add left/right keyboard arrows to change current page
            });
            $("#user").tablesorter({
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
            }).tablesorterPager({
                //target the pager markup - see the HTML block below
                container: $pager,
                size: 10,
                output: 'Displaying {startRow} - {endRow} of {filteredRows}'
            });
            $('#user').trigger('pageSize', 100);
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

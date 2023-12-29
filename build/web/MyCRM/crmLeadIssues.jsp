<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page import="org.apache.log4j.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.HashMap, java.text.*, com.pack.StringUtil"%>
<%@ page import="pack.eminent.encryption.*,com.eminent.util.*, dashboard.CheckDate,com.eminentlabs.crm.CRMUtil"%>





<%
    session.setAttribute("forwardpage", "/MyCRM/crmLeadIssues.jsp");
//			response.setHeader("Cache-Control","no-cache");
//			response.setHeader("Cache-Control","no-store");
//			response.setDateHeader("Expires", 0);
//		 	response.setHeader("Pragma","no-cache");

    //Configuring log4j properties
    Logger logger = Logger.getLogger("CRM Lead Issues");

    String logoutcheck = (String) session.getAttribute("Name");
    logger.info("Logged In User" + logoutcheck);
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
    <script src="<%= request.getContextPath()%>/javaScript/jquery-1.10.2.js"></script>
    <script language="JavaScript">
        function check(searchLead) {
            if ((searchLead.leadName.value == null) || (searchLead.leadName.value == ""))
            {
                alert("Please Enter Name or Company ")
                searchLead.leadName.focus()
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



    <form name="searchLead" onsubmit="return check(this);"
          action="searchLead.jsp">
        <table cellpadding="0" cellspacing="0" width="100%">
            <tr border="2" bgcolor="#E8EEF7">
                <td bgcolor="#E8EEF7" border="1" align="left"><font size="4"
                                                                    COLOR="#0000FF"> <b> CRM Lead Issues </b></font><FONT SIZE="3"
                                                                          COLOR="#0000FF"> </FONT></td>
                <td align="right"><b>Enter Lead Name:</b></td>
                <td align="left"><input type="text" name="leadName" maxlength="12"
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

    <%
        int age=0;
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
                String assignedto = String.valueOf(userid_curri);
                ps = connection.prepareStatement("SELECT LEADID,TITLE,FIRSTNAME, LASTNAME, COMPANY, STATE,PHONE,MOBILE,EMAIL,LEADSTATUS,RATING,DUEDATE,ASSIGNEDTO,CREATEDON,MODIFIEDON,LEAD_OWNER,DESCRIPTION,lead_type  from lead where roleid=2 and assignedto=? order by duedate ASC", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                ps.setString(1, assignedto);
                rs = ps.executeQuery();
                int apmIssues = CRMIssue.getAPMIssues(connection, userid_curri);
                hm = CRMIssue.getCRMIssuesCounts(connection, userid_curri);
                int contact = hm.get("Contact");
                int opportunity = hm.get("Opportunity");
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
                <%}%>
                <%
                    if (unapprovedContact > 0) {
                %>
                <a href="<%=request.getContextPath()%>/MyCRM/waitingContacts.jsp">Approve Contacts</a>&nbsp;&nbsp;&nbsp;&nbsp;
                <%}%>
                <b><a href="javascript:void(0);">Lead Issues</a></b>&nbsp;&nbsp;&nbsp;&nbsp;
                <%
                    if (opportunity > 0) {
                %>  
                <a href="<%=request.getContextPath()%>/MyCRM/crmOpportunityIssues.jsp">Opportunity Issues</a>&nbsp;&nbsp;&nbsp;&nbsp;
                <%}
                    if (account > 0) {
                %>  
                <a href="<%=request.getContextPath()%>/MyCRM/crmAccountIssues.jsp">Account Issues</a>
                <%}%>
                &nbsp;&nbsp;&nbsp;&nbsp;<a href="<%=request.getContextPath()%>/MyCRM/crmSummary.jsp">CRM Summary</a>
            </td>
        </tr>
        <tr>          
            <%if (apmIssues > 0) {%>
            <TD align="right" width="40%">You have <a href="<%=request.getContextPath()%>/MyAssignment/UpdateIssue.jsp"><%=apmIssues%></a> APM Issues</td>
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
                <td colspan="6" style="background-color: white">
                    <div class="pager"><nav class="left"> # per page: <a href="#">10</a> | <a href="#" >25</a> | <a href="#">50</a>|<a href="#" class="current">100</a>
                        </nav> 
                        <nav class="right"> <span class="prev"> <img
                                    src="<%=request.getContextPath()%>/images/prev.png" /> Prev&nbsp; </span> <span
                                class="pagecount"></span> &nbsp;<span class="next">Next <img
                                    src="<%=request.getContextPath()%>/images/next.png" /> </span> </nav></div>
                </td>
            </tr>
            <tr bgColor="#C3D9FF" height="9">
                <th width="20%"><font><b>Lead Name</b></font></th>
                <th width="18%"><font><b>Company</b></font></th>
                <th width="12%"><font><b>Phone</b></font></th>
                <th width="13%"><font><b>Email</b></font></th>
                <th width="10%" class="filter-select filter-match" data-placeholder="Select a Status"><font><b>Lead Status</b></font></th>
                <th width="8%" class="filter-select filter-match" data-placeholder="Select a Rating"><font><b>Rating</b></font></th>
                <th width="9%"><font><b>Due Date</b></font></th>
                <th width="5%" TITLE="In Days" ALIGN="center" data-placeholder="Try >=, <=,=,!= "><font><b>Age</b></font></th>
            </tr>
        </THEAD><TBODY>
            <%

                while (rs.next()) {

                    int leadid = rs.getInt("leadid");
                    String title = rs.getString("TITLE");

                    String firstname = rs.getString("firstname");

                    String lastname = rs.getString("lastname");

                    String company = rs.getString("company");

                    String email = rs.getString("email");

                    String leadstatus = rs.getString("leadstatus");

                    String phone = rs.getString("phone");

                    String mobile = rs.getString("mobile");

                    SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yy");

                    Date createdOn = rs.getDate("createdon");
                    String createdon = null;
                    if (createdOn != null) {
                        createdon = sdf.format(createdOn);
                        age = GetAge.getContactAge(connection, createdon);
                        createdon = ((Integer) age).toString();
                    } else {
                        createdon = "NA";
                    }
                    Date dueDateFormat = rs.getDate("duedate");

                    String dueDate = "NA";
                    if (dueDateFormat != null) {

                        dueDate = sdf.format(dueDateFormat);
                    }

                    String typ = rs.getString("assignedto");
                    String assignedTo = "NA";
                    if (typ != null) {
                        assignedTo = GetProjectManager.getUserName(Integer.parseInt(typ));
                    }

                    String own = rs.getString("lead_owner");
                    String owner = "NA";
                    if (own != null) {
                        owner = GetProjectManager.getUserName(Integer.parseInt(own));
                    }

                    Date modifiedOn = rs.getDate("modifiedon");

                    String modified = "NA";
                    if (modifiedOn != null) {

                        modified = sdf.format(modifiedOn);
                    }

                    String rate = rs.getString("rating");
                    if (rate == null) {
                        rate = "NA";
                    }

                    String description = rs.getString("description");
                    if (description == null) {
                        description = "NA";
                    }

                    String lastcomment = CRMIssue.getLeadLastComment(connection, leadid);
            %>
            <tr bgcolor="#E8EEF7" height="22">
                <td width="20%" TITLE="<%= title%>"><A
                        HREF="<%=request.getContextPath()%>/MyCRM/crmIssueView.jsp?leadid=<%=leadid%>"><font
                            face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%=firstname%><%=lastname%>
                        </font></A>
                <%if (rs.getString("lead_type").equalsIgnoreCase("Influencer")) {%>
                    &nbsp;<img src="<%=request.getContextPath()%>/images/star.png"  alt="Influencer"  title="Influencer Lead"  style="cursor: pointer;height: 11px;"/>
                    <%} else if (rs.getString("lead_type").equalsIgnoreCase("Decision Maker")) {%>
                    &nbsp;<img src="<%=request.getContextPath()%>/images/hammer.png"  alt="Decision Maker"  title="Decision Maker Lead"  style="cursor: pointer;height: 11px;"/>
                    <%}%>
                
                </td>
                <td width="18%" TITLE="Description:<%= description%>"><font face="Verdana, Arial, Helvetica, sans-serif"
                                                                            size="1" color="#000000"><%= company%></font></td>
                <td width="12%" TITLE="<%= mobile%>"><font face="Verdana, Arial, Helvetica, sans-serif"
                                                           size="1" color="#000000"><%= phone%></font></td>
                        <%
                            if (email.length() < 42) {
                        %>
                <td width="13%" ><font
                        face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= email%></font></td>
                        <%
                        } else {
                        %>
                <td width="13%" ><font
                        face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= email.substring(0, 42) + "..."%></font></td>
                        <%
                            }

                        %>
                <td width="10%"><font face="Verdana, Arial, Helvetica, sans-serif"
                                      size="1" color="#000000"><%= leadstatus%></font></td>
                <td width="8%"><font face="Verdana, Arial, Helvetica, sans-serif"
                                     size="1" color="#000000"><%= rate%></font></td>

                <%
                    if ((!dueDate.equalsIgnoreCase("NA")) && (CheckDate.getFlag(dueDate) == true)) {

                %>
                <td width="9%" title="Last Modified On <%= modifiedOn%>"><font
                        face="Verdana, Arial, Helvetica, sans-serif" size="1" color="RED"><%= dueDate%></font>
                </td>
                <%
                } else {
                %>
                <td width="9%" title="Last Modified On <%= modifiedOn%>"><font
                        face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= dueDate%></font>
                </td>
                <%
                    }
                %>


                <td width="5%" align=center><font
                        face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%=age%></font>
                </td>
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
                        logger.info("connection closed");
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
                <td colspan="8" style="background-color: #c3d9ff;">
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

<%@ page language="java" contentType="text/html"
         pageEncoding="UTF-8"%>
<%@ page import="org.apache.log4j.*,pack.eminent.encryption.*"%>
<%
    //Configuring log4j properties
    Logger logger = Logger.getLogger("DisabledUsers");
    String logoutcheck = (String) session.getAttribute("Name");
    if (logoutcheck == null) {
        logger.fatal("================Session expired===================");
%>
<jsp:forward page="../SessionExpired.jsp"></jsp:forward>
<%
    }
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
        <meta http-equiv="Content-Type" content="text/html ">
        <LINK title=STYLE href="<%= request.getContextPath()%>/eminentech support files/main_ie.css?test=150720161454" type="text/css" rel=STYLESHEET>
        <link rel="stylesheet" href="<%=request.getContextPath()%>/css/theme.blue1.css?test=150720161404">
        <TITLE>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS
            Solution</TITLE>
        <script language="JavaScript">
            function printpost(post)
            {
                pp = window.open('/etracker/profile.jsp?post_id=' + post, 'pp', 'size = maximize,location=no,statusbar=no,menubar=no,scrollbars=no width=900,height=400');
                pp.focus();
            }

            var form = 'showusers' //form name

            function SetChecked(val, chkName)
            {
                dml = document.forms[form];
                len = dml.elements.length;
                var i = 0;
                for (i = 0; i < len; i++)
                {
                    if (dml.elements[i].name == chkName)
                    {
                        dml.elements[i].checked = val;
                    }
                }
            }

            function ValidateForm(dml, chkName)
            {
                len = dml.elements.length;
                var i = 0;
                for (i = 0; i < len; i++)
                {
                    if ((dml.elements[i].name == chkName) && (dml.elements[i].checked == 1))
                        return true
                }
                alert("Please select at least one record to be approved")
                return false;
            }


        </script>

    </head>
    <body>
        <%@ include file="/header.jsp"%>


        <table cellpadding="0" cellspacing="0" width="100%">
            <tr border="2" bgcolor="#F5F5F5">
                <td BGCOLOR="C3D9FF" border="1" align="left" width="100%"><font
                        size="4" COLOR="#0000FF"><b>Disabled Users</b> </font><FONT SIZE="3"
                                                                                COLOR="#0000FF"> </FONT></td>
            </tr>
        </table>

        <%@ page import="com.pack.*"%>
        <%@ page import="java.sql.*"%>
        <%!
            int requestpage, pageone, pageremain, rowcount;
            static int totalpage, pagemanipulation, presentpage, issuenofrom, issuenoto, extra;
        %>

        <%
            Connection connection = null;
            Statement st = null;
            ResultSet rs = null;
            try {
                connection = MakeConnection.getConnection();
                logger.debug("Connection has been created:" + connection);
                if (connection != null) {
                    int x = -2;
                    st = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                    rs = st.executeQuery("SELECT FIRSTNAME,LASTNAME,USERID,COMPANY,EMAIL,MOBILE,PHONE,TEAM,VALUE,LASTLOGGEDON from users where roleid=" + x + " order by USERID DESC ");
                    rs.last();
                    int rowcount = rs.getRow();
                    logger.debug("Total No of records:" + rowcount);
                    rs.beforeFirst();
        %>
        <table width="100%" border="0">
            <tr>
                <td><a
                        href="<%=request.getContextPath()%>/admin/user/addnewuser.jsp">Add
                        User</a>&nbsp;&nbsp;&nbsp;&nbsp;<a
                        href="<%=request.getContextPath()%>/admin/user/viewuser.jsp">View
                        User</a>&nbsp;&nbsp;&nbsp;&nbsp;<a
                        href="<%=request.getContextPath()%>/admin/user/waitingForApproval.jsp">Approve
                        User</a>&nbsp;&nbsp;&nbsp;&nbsp;<a
                        href="<%=request.getContextPath()%>/admin/user/deniedUsers.jsp">Denied
                        Users</a>
                        <%
                            if (rowcount > 0) {
                        %>
                <td align="right"><a href="javascript:SetChecked(1,'approve')"><font
                            face="Arial, Helvetica, sans-serif" size="2">Select All</font></a> <a
                        href="javascript:SetChecked(0,'approve')"><font
                            face="Arial, Helvetica, sans-serif" size="2">Clear All</font></a></td>
                            <%}%>
            </tr>
        </table>
        <%
            if (rowcount <= 0) {

        %>
        <table width="100%" height="70%" align="center">
            <tr>
                <td><font face="Tahoma" size="5" color="red">
                        <h3 align="center"><%= "Nobody is waiting for your approval"%></h3>
                    </font></td>
            </tr>
        </table>
        <%
        } else {
        %>
        <form name="showusers" action="approveUsers.jsp"
              onSubmit="return ValidateForm(this, 'approve')">
            <table id="user" class="tablesorter">
                <thead>
                    <tr class="tablesorter-ignoreRow" bgColor="white" >
                        <td class="pager" colspan="2" style="background-color: white">
                            <span class="pagedisplay"></span>
                        </td>
                        <td colspan="9" style="background-color: white">
                            <div class="pager"><nav class="left"> # per page: <a href="#">10</a> | <a href="#" >25</a> | <a href="#">50</a>|<a href="#" class="current">100</a>
                                </nav> 
                                <nav class="right"> <span class="prev"> <img
                                            src="<%=request.getContextPath()%>/images/prev.png" /> Prev&nbsp; </span> <span
                                        class="pagecount"></span> &nbsp;<span class="next">Next <img
                                            src="<%=request.getContextPath()%>/images/next.png" /> </span> </nav></div>
                        </td>
                    </tr>
                    <tr bgcolor="#C3D9FF" height="9">
                        <TD width="18%"><font><b>FirstName</b></font></TD>
                        <TD width="20%"><font><b>LastName</b></font></TD>
                        <TD width="21%"><font><b>Company</b></font></TD>
                        <TD width="28%"><font><b>Email</b></font></TD>
                        <TD width="14%"><font><b>Mobile</b></font></TD>
                        <TD width="3%" class="filter-false"><font><b>Manage</b></font></TD>
                    </tr>
                </thead>
                <tbody>
                    <%
                        while (rs.next()) {
                            String fname = rs.getString("firstname");
                            String lname = rs.getString("lastname");
                            String company = rs.getString("company");
                            String email = rs.getString("email");
                            String mobile = rs.getString("mobile");
                            String team = rs.getString("team");
                            String userid = rs.getString("userid");
                    %>
                    <tr  height="9">
                        <td width="17%"><font
                                face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= StringUtil.encodeHtmlTag(fname)%></font></td>
                        <td width="18%"><font
                                face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= StringUtil.encodeHtmlTag(lname)%></font></td>
                        <td width="20%"><font
                                face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= StringUtil.encodeHtmlTag(company)%></font></td>
                        <td width="25%"><font
                                face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= StringUtil.encodeHtmlTag(email)%></font></td>
                        <td width="13%"><font
                                face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= mobile%></font></td>
                        <td width="5%" align="center"><font
                                face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><input
                                    type="checkbox" name="approve" value="<%= userid%>"></td>
                                </tr>
                                <%
                                    }

                                %>
                                </tbody>
                                <tfoot>
                                    <tr>
                                        <td colspan="6" style="background-color: #c3d9ff;">
                                            <div class="pager"><nav class="left"> # per page: <a href="#">10</a> | <a href="#" >25</a> | <a href="#">50</a>|<a href="#" class="current">100</a>
                                                </nav> 
                                                <nav class="right"> <span class="prev"> <img
                                                            src="<%=request.getContextPath()%>/images/prev.png" /> Prev&nbsp; </span> <span
                                                        class="pagecount"></span> &nbsp;<span class="next">Next <img
                                                            src="<%=request.getContextPath()%>/images/next.png" /> </span> </nav></div>
                                        </td>
                                    </tr>
                                </tfoot>

            </table>
            <table>
                <tr>
                    <td colspan="6" align="center"><input type="submit" name="submit"
                                                          value="Enable"></td>
                </tr>
            </table>
        </form>
        <%}
                }
            } catch (Exception e) {
                logger.error("Error while approving the users" + e);
            } finally {
                if (rs != null) {
                    rs.close();
                }
                if (st != null) {
                    st.close();
                }
                if (connection != null) {
                    connection.close();
                }
                //	Admin.close();
                logger.debug("Closing JDBC Resources");
            }
        %>
        <SCRIPT type="text/javascript" 	src="https://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>

    <link rel="stylesheet" href="<%= request.getContextPath()%>//css/jquery-ui.css"/>
    <script src="<%= request.getContextPath()%>/javaScript/jquery-ui.js"></script>


    <script src="<%=request.getContextPath()%>/javaScript/jquery.tablesorter1.js" type="text/javascript"></script>
    <script src="<%=request.getContextPath()%>/javaScript/jquery.tablesorter.widgets.js" type="text/javascript"></script>    
    <script src="<%=request.getContextPath()%>/javaScript/jquery.tablesorter.pager.js" type="text/javascript"></script>
    <script src="<%=request.getContextPath()%>/javaScript/pager-custom-controls.js" type="text/javascript"></script>
    <script type="text/javascript">




                  $(document).ready(function() {

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
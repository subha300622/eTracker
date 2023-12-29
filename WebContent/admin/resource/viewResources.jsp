<%@ page language="java" contentType="text/html"
         pageEncoding="UTF-8"%>
<%@ page
    import="org.apache.log4j.*,pack.eminent.encryption.*,com.eminent.util.*"%>
    <%
        //Configuring log4j properties
        Logger logger = Logger.getLogger("ViewResource");

        String logoutcheck = (String) session.getAttribute("Name");
        if (logoutcheck == null) {
            logger.fatal("================Session expired===================");
    %>
    <jsp:forward page="../SessionExpired.jsp"></jsp:forward>
    <%
        }
    %>
    <%@ page import="com.pack.*"%>
    <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
    <html>
        <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
            <meta http-equiv="Content-Type" content="text/html ">
            <LINK title=STYLE
                  href="<%= request.getContextPath()%>/eminentech support files/main_ie.css"
                  type="text/css" rel=STYLESHEET>
            <script src="<%=request.getContextPath()%>/javaScript/jquery.js" type="text/javascript"></script>
            <script src="<%=request.getContextPath()%>/javaScript/XMLHttpRequest.js" type="text/javascript"></script>
             <script src="<%=request.getContextPath()%>/javaScript/jquery-latest.min_1.js" type="text/javascript"></script>
    <script src="<%=request.getContextPath()%>/javaScript/jquery-ui.min.js"></script>
    <script src="<%=request.getContextPath()%>/javaScript/jquery.tablesorter1.js" type="text/javascript"></script>
    <script src="<%=request.getContextPath()%>/javaScript/jquery.tablesorter.widgets.js" type="text/javascript"></script>   
    <link rel="stylesheet" href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.10.0/themes/cupertino/jquery-ui.css">
    <script src="<%=request.getContextPath()%>/javaScript/widget-filter-formatter-jui.js"></script>

            <title>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS
                Solution</title>
            <script language="JavaScript">
                function printpost(post)
                {
                    pp = window.open('./profile.jsp?post_id=' + post, 'pp', 'size = maximize,location=no,statusbar=no,menubar=no,scrollbars=no width=900,height=400');
                    pp.focus();
                }
            </script>
        </head>
        <body>
            <%@ page import="java.sql.*"%>
            <%!
                int requestpage, pageone, pageremain, rowcount;
                static int totalpage, pagemanipulation, presentpage, issuenofrom, issuenoto, extra;
            %>
            <%@ include file="/header.jsp"%>
            <table cellpadding="0" cellspacing="0" width="100%" bgColor="#C3D9FF">
                <tr>
                    <td align="left"><font size="4" COLOR="#0000FF"><b>Resource
                                Administration</b> </font> <FONT SIZE="3" COLOR="#0000FF"> </FONT></td>
                </tr>
            </table>

            <%

                Connection connection = null;
                Statement st = null;
                ResultSet rs = null;

                try {
                    connection = MakeConnection.getConnection();
                    logger.debug("Connection has been created:" + connection);

                    if (connection != null) {
                        st = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                        rs = st.executeQuery("SELECT ipaddress,machinename,assigneduser,cpudetails,ramdetails,harddisk,motherboard,OS,Unique_Asset_No,value,status from resources order by UPPER(machinename) ASC ");
                        rs.last();
                        int rowcount = rs.getRow();
                        logger.debug("Total No of records:" + rowcount);
                        rs.beforeFirst();
                        pageone = rowcount / 150;
                        pageremain = rowcount % 150;

                        if (pageremain > 0) {
                            totalpage = pageone + 1;
                        } else {
                            totalpage = pageone;
                        }
                        try {
                            String requestpag = request.getParameter("manipulation");
                            logger.debug("Requested Page:" + requestpag);
                            if (requestpag != null) {
                                requestpage = Integer.parseInt(requestpag);
                                if (requestpage == 1) {
                                    presentpage = 1;
                                    rs.beforeFirst();
                                    logger.debug("Requested page First" + presentpage);
                                    issuenofrom = 1;
                                    issuenoto = issuenofrom + 149;
                                    if (issuenoto > rowcount) {
                                        extra = issuenoto - rowcount;
                                        issuenoto = issuenoto - extra;
                                    }
                                }
                                if (requestpage == 2) {
                                    presentpage = presentpage - 1;
                                    if (presentpage <= 0) {
                                        presentpage = 1;
                                    }
                                    if (presentpage == 1) {
                                        rs.beforeFirst();
                                        issuenofrom = 1;
                                        issuenoto = issuenofrom + 149;
                                        if (issuenoto > rowcount) {
                                            extra = issuenoto - rowcount;
                                            issuenoto = issuenoto - extra;
                                        }
                                    } else {
                                        issuenofrom = ((presentpage - 1) * 150 + 1);
                                        rs.absolute(issuenofrom - 1);
                                        issuenoto = issuenofrom + 149;
                                        if (issuenoto > rowcount) {
                                            extra = issuenoto - rowcount;
                                            issuenoto = issuenoto - extra;
                                        }
                                    }
                                    logger.debug("Requested page Prev" + presentpage);
                                }
                                if (requestpage == 3) {
                                    presentpage = presentpage + 1;
                                    if (presentpage >= totalpage) {
                                        presentpage = totalpage;
                                    }
                                    issuenofrom = ((presentpage - 1) * 150 + 1);
                                    rs.absolute(issuenofrom - 1);
                                    logger.debug("Requested page Next" + presentpage);
                                    issuenoto = issuenofrom + 149;
                                    if (issuenoto > rowcount) {
                                        extra = issuenoto - rowcount;
                                        issuenoto = issuenoto - extra;
                                    }
                                }
                                if (requestpage == 4) {
                                    presentpage = totalpage;
                                    logger.debug("Requested page Last" + presentpage);
                                    issuenofrom = ((presentpage - 1) * 150 + 1);
                                    rs.absolute(issuenofrom - 1);
                                    issuenoto = issuenofrom + 149;
                                    if (issuenoto > rowcount) {
                                        extra = issuenoto - rowcount;
                                        issuenoto = issuenoto - extra;
                                    }
                                }
                            } else {
                                presentpage = 1;
                                issuenofrom = 1;
                                rs.beforeFirst();
                                issuenoto = issuenofrom + 149;
                                if (issuenoto > rowcount) {
                                    extra = issuenoto - rowcount;
                                    issuenoto = issuenoto - extra;
                                }
                            }
                        } catch (Exception e) {
                            logger.error("Exception:" + e);
                        }
                        if (request.getParameter("newresource") != null) {
                        
                            if (!(request.getParameter("newresource").equalsIgnoreCase("deleted"))) {
                               

            %>

            <table width="100%" align=center border="0" bgcolor="E8EEF7">
                <tr>
                    <td align=center><FONT SIZE="4" COLOR="#33CC33">New
                            Resource has been <%=request.getParameter("newresource")%>
                            successfully!: </FONT> <FONT SIZE="4" COLOR="#0000FF"><%= request.getParameter("machinename")%></FONT>
                    </td>
                </tr>
            </table>
            <% } else {%>
            <table width="100%" align=center border="0" bgcolor="E8EEF7">
                <tr>
                    <td align=center><FONT SIZE="4" COLOR="#33CC33">Resource <%=request.getParameter("newresource")%> successfully!: </FONT> <FONT SIZE="4" COLOR="#0000FF"><%= request.getParameter("machinename")%></FONT>
                    </td>
                </tr>
            </table>
            <%}
                }%>
            <TABLE width="100%" border="0">
                <tr>
                    <td><b><a
                                href="<%=request.getContextPath()%>/admin/resource/addResource.jsp">Add
                                Resource</a></b></td>
                                <%
                                    if (rowcount == 0) {
                                %>
                    <td>Displaying&nbsp;<%= "0"%>&nbsp;-<%=issuenoto%>&nbsp;of&nbsp;<b><%=rowcount%></b></td>
                    <%
                    } else {
                    %>
                    <td>Displaying&nbsp;<%=issuenofrom%>&nbsp;-<%=issuenoto%>&nbsp;of&nbsp;<b><%=rowcount%></b></td>
                    <%
                        }
                    %>
                </tr>
            </TABLE>
            <br>
            <div class="tablecontent">
            <table width=100% id="searchTable" class="tablesorter">
                <thead>
                <TR bgColor="#C3D9FF" height="9">
                    <TD width="25%"><font><b>Machine Name</b></font></TD>
                    <TD width="20%" class="filter-select filter-match" data-placeholder="Select a User"><font><b>User</b></font></TD>
                    <TD width="15%" class="filter-select filter-match" data-placeholder="Select a OS"><font><b>OS</b></font></TD>
                    <TD width="10%"><font><b>RAM Details</b></font></TD>
                    <TD width="10%"><font><b>Value</b></font></TD>
                    <TD width="10%" class="filter-select" data-placeholder="Select a Status"><font><b>Status</b></font></TD>
                    <TD width="10%" class="filter-false"><font><b>Manage</b></font></TD>
                </TR>
                </thead>
             <tbody>
                <%
                    String machinename = "", User = "", os = "", ram = "", value = "", status = null, assetid = null, ipaddress = null;

                    if (rs != null) {
                        for (int i = 1; i <= 150; i++) {
                            if (rs.next()) {

                                machinename = rs.getString("machinename");
                                if (machinename == null) {
                                    machinename = "";
                                }
                                User = rs.getString("assigneduser");
                                if (User == null) {
                                    User = "";
                                }
                                ipaddress = rs.getString("ipaddress");
                                os = rs.getString("os");
                                if (os == null) {
                                    os = "nil";
                                }
                                ram = rs.getString("ramdetails");
                                if (ram == null) {
                                    ram = "";
                                }
                                value = rs.getString("VALUE");
                                if (value == null) {
                                    value = "nil";
                                }
                                assetid = rs.getString("UNIQUE_ASSET_NO");
                                if (assetid == null) {
                                    assetid = "nil";
                                }
                                status = rs.getString("STATUS");
                                if (status == null) {
                                    status = "Now Working";
                                }
                                if ((i % 2) != 0) {

                %>
                <tr id='assetid<%=assetid%><%=machinename%>' class="zebraline" height="21">
                    <%
                    } else {
                    %>

                <tr id='assetid<%=assetid%><%=machinename%>'class="zebralinealter" height="21">
                    <%
                        }
                    %>
                    <td width="25%" class="background"><font
                            face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= StringUtil.encodeHtmlTag(machinename)%></font></td>
                    <td width="20%" class="background"><font
                            face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= StringUtil.encodeHtmlTag(GetProjectMembers.getUserName(User))%></font></td>
                    <td width="15%" class="background"><font
                            face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= StringUtil.encodeHtmlTag(os)%></font></td>
                    <td width="10%" class="background"><font
                            face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= StringUtil.encodeHtmlTag(ram)%></font></td>
                    <td width="10%" class="background"><font
                            face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= StringUtil.encodeHtmlTag(value)%></font></td>
                    <td width="10%" class="background"><font
                            face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%=status%></font></td>
                    <td width="10%" class="background"><font
                            face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><A
                                HREF="editResource.jsp?assetid=<%=assetid%>">Edit</A></font><font
                            face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"> ||<A
                                HREF="deleteResource.jsp?assetid=<%=assetid%>&machinename=<%=machinename%>&action=delete">Delete</A></font></td>

                </tr>
                <%
                            }
                        }
                    }
                    if (request.getParameter("manipulation") == null && (rowcount / 150 == 0)) {
                %>
                </tbody>
                 </table>
            </div>
                <table align=right>
                    <tr>

                    </tr>
                </table>
                <%
                } else if (request.getParameter("manipulation") == null) {
                %>
                <table align=right>
                    <tr>
                        <td>First</td>
                        <td>Prev</td>
                        <td><a href=viewResources.jsp?manipulation=3>Next</a></td>
                        <td><a href=viewResources.jsp?manipulation=4>Last</a></td>
                    </tr>
                </table>
                <%
                } else if (request.getParameter("manipulation").equals("1")) {
                %>
                <table align=right>
                    <tr>
                        <td>First</td>
                        <td>Prev</td>
                        <td><a href=viewResources.jsp?manipulation=3>Next</a></td>
                        <td><a href=viewResources.jsp?manipulation=4>Last</a></td>
                    </tr>
                </table>
                <%
                } else if (request.getParameter("manipulation").equals("4")) {
                %>
                <table align=right>
                    <tr>
                        <td><a href=viewResources.jsp?manipulation=1>First</a></td>
                        <td><a href=viewResources.jsp?manipulation=2>Prev</a></td>
                        <td>Next</td>
                        <td>Last</td>
                    </tr>
                </table>
                <%
                } else if (request.getParameter("manipulation").equals("3") && issuenoto == rowcount) {
                %>
                <table align=right>
                    <tr>
                        <td><a href=viewResources.jsp?manipulation=1>First</a></td>
                        <td><a href=viewResources.jsp?manipulation=2>Prev</a></td>
                        <td>Next</td>
                        <td>Last</td>
                    </tr>
                </table>
                <%
                } else if (request.getParameter("manipulation").equals("3")) {
                %>
                <table align=right>
                    <tr>
                        <td><a href=viewResources.jsp?manipulation=1>First</a></td>
                        <td><a href=viewResources.jsp?manipulation=2>Prev</a></td>
                        <td><a href=viewResources.jsp?manipulation=3>Next</a></td>
                        <td><a href=viewResources.jsp?manipulation=4>Last</a></td>
                    </tr>
                </table>
                <%
                } else if (request.getParameter("manipulation").equals("2") && issuenofrom == 1) {
                %>
                <table align=right>
                    <tr>
                        <td>First</td>
                        <td>Prev</td>
                        <td><a href=viewResources.jsp?manipulation=3>Next</a></td>
                        <td><a href=viewResources.jsp?manipulation=4>Last</a></td>
                    </tr>
                </table>
                <%
                } else if (request.getParameter("manipulation").equals("2")) {
                %>
                <table align=right>
                    <tr>
                        <td><a href=viewResources.jsp?manipulation=1>First</a></td>
                        <td><a href=viewResources.jsp?manipulation=2>Prev</a></td>
                        <td><a href=viewResources.jsp?manipulation=3>Next</a></td>
                        <td><a href=viewResources.jsp?manipulation=4>Last</a></td>
                    </tr>
                </table>
                <%
                            }
                        }
                    } catch (Exception e) {
                        logger.error(e.getMessage());
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
                        logger.debug("Closing JDBC Resources");
                    }
                %>
            <link rel="stylesheet" href="<%=request.getContextPath()%>/css/theme.blue1.css?test=16110202">
    <script type="text/javascript">


        $(document).ready(function() {

            $("#searchTable").tablesorter({
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
                    }

                }

            });

        });



    </script>
        </body>
    </html>
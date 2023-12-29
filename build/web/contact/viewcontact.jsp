<%@ page language="java" contentType="text/html"
         pageEncoding="UTF-8"%>
<%@ page import="org.apache.log4j.*,pack.eminent.encryption.*,com.eminent.util.*"%>
<%

    //Configuring log4j properties
    Logger logger = Logger.getLogger("ViewUser");

    String logoutcheck = (String) session.getAttribute("Name");
    if (logoutcheck == null) {
        logger.fatal("================Session expired===================");
%>
<jsp:forward page="../SessionExpired.jsp"></jsp:forward>
<%
    }
    String link = "/contact/viewcontact.jsp";
    session.setAttribute("forwardpage", link);
%>
<%@ page import="com.pack.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
    <meta http-equiv="Content-Type" content="text/html ">
    <LINK title=STYLE
          href="<%= request.getContextPath()%>/eminentech support files/main_ie.css"
          type="text/css" rel=STYLESHEET>
    <TITLE>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS
        Solution</TITLE>
    <script src="<%=request.getContextPath()%>/javaScript/jquery.tablesorter.min.js" type="text/javascript"></script>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/theme.blue1.css?test=150720161404">
    <script src="<%= request.getContextPath()%>/javaScript/jquery-1.10.2.js"></script>
</head>
<body>
    <%@ page import="java.sql.*,java.text.*"%>
    <%@ include file="/header.jsp"%>
    <table cellpadding="0" cellspacing="0" width="100%" bgColor="#C3D9FF">
        <tr>
            <td align="left"><font size="4" COLOR="#0000FF"><b>Contact
                        Administration</b> </font> <FONT SIZE="3" COLOR="#0000FF"> </FONT></td>
        </tr>
    </table>

    <%
        Connection connection = null;
        Statement st = null;
        ResultSet rs = null;
        try {
            connection = MakeConnection.getConnection();
            if (connection != null) {
                int owner = ((Integer) session.getAttribute("uid")).intValue();
                boolean flag = GetProjectMembers.isBDMembers(owner);
                st = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                rs = st.executeQuery("SELECT contactid,FIRSTNAME,LASTNAME,TITLE,PHONE,MOBILE,EMAIL,CREATEDON,COMPANY,contact_type from CONTACT where contact_owner=" + session.getAttribute("uid") + " order by CREATEDON desc ");
                if (request.getParameter("newcontact") != null) {
    %>

    <table width="100%" align=center border="0" bgcolor="E8EEF7">
        <tr>
            <td align=center><FONT SIZE="4" COLOR="#33CC33">New
                    Contact has been added successfully!: </FONT> <FONT SIZE="4" COLOR="#0000FF"><%= request.getParameter("email")%></FONT>
            </td>
        </tr>
    </table>
    <%
        }
    %>
    <TABLE width="100%" border="0">
        <tr>
            <td><b>
                    <%
                        if (flag) {%>
                    <a href="<%=request.getContextPath()%>/admin/customer/addnewcontact.jsp">Add Contact</a>
                    <%             } else {%>
                    <a href="<%=request.getContextPath()%>/contact/addnewcontact.jsp">Add Contact</a>
                    <%     }%>

                </b>

            </td>		
        </tr>
    </TABLE>
    <br>
    <table width=100% id="user" class="tablesorter">

        <thead>
            <tr class="tablesorter-ignoreRow" >
                <td class="pager" colspan="2" style="background-color: white">
                    <span class="pagedisplay"></span>
                </td>
                <td colspan="5" style="background-color: white">
                    <div class="pager"><nav class="left"> # per page: <a href="#">10</a> | <a href="#" >25</a> | <a href="#">50</a>|<a href="#" class="current">100</a>
                        </nav> 
                        <nav class="right"> <span class="prev"> <img
                                    src="<%=request.getContextPath()%>/images/prev.png" /> Prev&nbsp; </span> <span
                                class="pagecount"></span> &nbsp;<span class="next">Next <img
                                    src="<%=request.getContextPath()%>/images/next.png" /> </span> </nav></div>
                </td>
            </tr>
            <tr bgColor="#C3D9FF" height="9">
                <th width="24%"><font><b>Name</b></font></th>
                <th width="15%"><font><b>Title</b></font></th>
                <th width="10%"><font><b>Phone</b></font></th>
                <th width="10%"><font><b>Mobile</b></font></th>
                <th width="20%"><font><b>Email</b></font></th>
                <th width="16%"><font><b>Company</b></font></th>
                <th width="5%" data-placeholder="Try >=, <=,=,!= "><font><b>Age</b></font></th>

            </tr>
        </thead>
        <tbody>
            <%
                int contactid = 9999, age;
                String fname = "", lname = "", title = "", account = "", email = "", phone = "", mobile = "", createdon = null, company = null;
                String fullname = "";
                while (rs.next()) {
                    contactid = rs.getInt("contactid");
                    fname = rs.getString("firstname");
                    if (fname == null) {
                        fname = "";
                    }
                    lname = rs.getString("lastname");
                    if (lname == null) {
                        lname = "";
                    }

                    fullname = fname + " " + lname;
                    title = rs.getString("title");
                    if (title == null) {
                        title = "nil";
                    }

                    email = rs.getString("email");
                    if (email == null) {
                        email = "";
                    }
                    phone = rs.getString("phone");
                    if (phone == null) {
                        phone = "nil";
                    }
                    mobile = rs.getString("mobile");

                    SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yy");

                    Date createdOn = rs.getDate("createdon");

                    if (createdOn != null) {
                        createdon = sdf.format(createdOn);
                        age = GetAge.getContactAge(connection, createdon);
                        createdon = ((Integer) age).toString();
                    } else {
                        createdon = "NA";
                    }

                    company = rs.getString("company");

            %>


            <tr  height="21">
                <%                    if (fullname.length() < 25) {
                        if (flag) {%>
                <td width="24%"><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><A HREF="<%= request.getContextPath()%>/contact/memberEdit.jsp?contactid=<%=contactid%>"><%= fullname%></A></font><%if (rs.getString("contact_type").equalsIgnoreCase("Influencer")) {%>
                    &nbsp;<img src="<%=request.getContextPath()%>/images/star.png"  alt="Influencer"  title="Influencer contact"  style="cursor: pointer;height: 11px;"/>
                    <%} else if (rs.getString("contact_type").equalsIgnoreCase("Decision Maker")) {%>
                    &nbsp;<img src="<%=request.getContextPath()%>/images/hammer.png"  alt="Decision Maker"  title="Decision Maker contact"  style="cursor: pointer;height: 11px;"/>
                    <%}%></td>
                    <%             } else {%>
                <td width="24%"><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><A HREF="<%= request.getContextPath()%>/contact/editContact.jsp?contactid=<%=contactid%>"><%= fullname%></A></font><%if (rs.getString("contact_type").equalsIgnoreCase("Influencer")) {%>
                    &nbsp;<img src="<%=request.getContextPath()%>/images/star.png"  alt="Influencer"  title="Influencer contact"  style="cursor: pointer;height: 11px;"/>
                    <%} else if (rs.getString("contact_type").equalsIgnoreCase("Decision Maker")) {%>
                    &nbsp;<img src="<%=request.getContextPath()%>/images/hammer.png"  alt="Decision Maker"  title="Decision Maker contact"  style="cursor: pointer;height: 11px;"/>
                    <%}%></td>
                    <%     }
                    } else {

                        if (flag) {%>
                <td width="24%"><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><A HREF="<%= request.getContextPath()%>/contact/memberEdit.jsp?contactid=<%=contactid%>"><%= fullname.substring(0, 25) + "..."%></A></font>
                    <%if (rs.getString("contact_type").equalsIgnoreCase("Influencer")) {%>
                    &nbsp;<img src="<%=request.getContextPath()%>/images/star.png"  alt="Influencer"  title="Influencer contact"  style="cursor: pointer;height: 11px;"/>
                    <%} else if (rs.getString("contact_type").equalsIgnoreCase("Decision Maker")) {%>
                    &nbsp;<img src="<%=request.getContextPath()%>/images/hammer.png"  alt="Decision Maker"  title="Decision Maker contact"  style="cursor: pointer;height: 11px;"/>
                    <%}%></td>
                    <%             } else {%>
                <td width="24%"><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><A HREF="<%= request.getContextPath()%>/contact/editContact.jsp?contactid=<%=contactid%>"><%= fullname.substring(0, 25) + "..."%></A></font><%if (rs.getString("contact_type").equalsIgnoreCase("Influencer")) {%>
                    &nbsp;<img src="<%=request.getContextPath()%>/images/star.png"  alt="Influencer"  title="Influencer contact"  style="cursor: pointer;height: 11px;"/>
                    <%} else if (rs.getString("contact_type").equalsIgnoreCase("Decision Maker")) {%>
                    &nbsp;<img src="<%=request.getContextPath()%>/images/hammer.png"  alt="Decision Maker"  title="Decision Maker contact"  style="cursor: pointer;height: 11px;"/>
                    <%}%></td>
                    <%     }  %>

                <%
                    }
                %>

                <%											if (title.length() < 15) {
                %>
                <td width="15%"><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= StringUtil.encodeHtmlTag(title)%></font></td>
                        <%
                        } else {
                        %>
                <td width="15%"><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= title.substring(0, 15) + "..."%></font></td>
                        <%
                            }
                        %>

                <td width="10%"><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= phone%></font></td>
                <td width="10%"><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= mobile%></font></td>

                <%if (email.length() < 20) {
                %>
                <td width="20%"><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= StringUtil.encodeHtmlTag(email)%></font></td>
                        <%
                        } else {
                        %>
                <td width="20%"><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= email.substring(0, 20) + "..."%></font></td>
                        <%
                            }

                            session.setAttribute("user", "true");

                        %>
                <td width="16%"><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%=company%></font></td>
                <td width="5%" align="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= createdon%></font></td>


            </tr>

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
        </tbody>
        <tfoot>
            <tr>
                <td colspan="7" style="background-color: #c3d9ff;">
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

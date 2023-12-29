<%@page import="java.util.Map"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page import="org.apache.log4j.*"%>
<%@ page import="java.sql.*, com.pack.StringUtil"%>
<%@ page import="java.util.HashMap,java.text.SimpleDateFormat"%>
<%@ page import="pack.eminent.encryption.*,com.eminent.util.*, dashboard.CheckDate"%>





<%
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Cache-Control", "no-store");
    response.setDateHeader("Expires", 0);
    response.setHeader("Pragma", "no-cache");

    //Configuring log4j properties
    Logger logger = Logger.getLogger("issuesForProject");

    String logoutcheck = (String) session.getAttribute("Name");
    if (logoutcheck == null) {
        logger.fatal("================Session expired===================");
%>
<jsp:forward page="SessionExpired.jsp"></jsp:forward>
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
        <LINK title=STYLE href="<%= request.getContextPath()%>/eminentech support files/main_ie.css?test=261020151225" type="text/css" rel="STYLESHEET">
        <script src="<%=request.getContextPath()%>/javaScript/XMLHttpRequest.js" type="text/javascript"></script>
        <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/fileAttach.js"></script>
        <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/tooltip.js"></script>
        <script src="<%=request.getContextPath()%>/javaScript/jquery.js" type="text/javascript"></script>

    </HEAD>

    <style fprolloverstyle>
        A:hover {
            color: #FF0000;
            font-weight: bold
        }
    </style>
    <BODY BGCOLOR="#FFFFFF">

        <%@ include file="/header.jsp"%>





        <div align="center">
            <center>

                <table cellpadding="0" cellspacing="0" width="100%">
                    <tr border="2" bgcolor="C3D9FF">
                        <td border="1" align="left" width="75%"><font size="4"
                                                                      COLOR="#0000FF"><b>Issue(s) based on your selection are
                                    listed below </b></font><FONT SIZE="3" COLOR="#0000FF"> </FONT></td>




                        <jsp:useBean id="MyIssue" class="com.pack.MyIssueBean" />

                        <%!
                            int requestpage, pageone, pageremain, rowcount, age;
                            static int totalpage, pagemanipulation, presentpage, extra, issuenofrom, issuenoto;
                            int userid_curri, absolte;
                            HashMap hm;

                                                                                        %>
                        <%

                            Connection connection = null;
                            ResultSet rs = null;
                            PreparedStatement ps = null;
                            session.setAttribute("dashBoard", "project");
                            session.setAttribute("forwardpage", "/admin/dashboard/issuesForProject.jsp");
                            //int count =0;
                            try {
                                connection = MakeConnection.getConnection();
                                logger.debug("Connection:" + connection);

                                //hm = new HashMap<Integer,String>();
                                hm = MyIssue.getUser(connection);
                                logger.info("SIZE:" + hm.size());

                                if (connection != null) {
                                    String project = null;
                                    String status = null;
                                    String priority = null;

                                    if (request.getParameter("issuestatus") == null) {

                                        project = request.getParameter("project");
                                        status = request.getParameter("status");
                                        priority = request.getParameter("priority");

                                        boolean flag = false;

                                        if (project == null) {

                                            flag = true;

                                            project = (String) session.getAttribute("chartForProject");
                                            status = (String) session.getAttribute("chartForStatus");
                                            priority = (String) session.getAttribute("chartForPriority");

                                        }

                                        if (flag == false) {

                                            session.setAttribute("chartForProject", project);
                                            session.setAttribute("chartForStatus", status);
                                            session.setAttribute("chartForPriority", priority);
                                        }

                                        logger.info("Project" + project);
                                        logger.info("status" + status);
                                        logger.info("priority" + priority);

                                    } else {

                                        project = (String) session.getAttribute("chartForProject");
                                        status = (String) session.getAttribute("chartForStatus");
                                        priority = (String) session.getAttribute("chartForPriority");
                                        logger.info("Project" + project);
                                        logger.info("status" + status);
                                        logger.info("priority" + priority);

                                    }
                        %>

                        <td border="1" align="left" width="75%"><font size="4"
                                                                      COLOR="#0000FF"><b>Project&nbsp; :&nbsp; <%= project%> </b></font><FONT
                                SIZE="3" COLOR="#0000FF"> </FONT></td>
                    </tr>
                </table>

                <%
                    if (request.getParameter("issuestatus") != null && request.getParameter("issuestatus").equalsIgnoreCase("yes")) {
                %>

                <table width="100%" align=center border="0" bgcolor="#F9F9F9">
                    <tr>
                        <td align=center><FONT SIZE="4" COLOR="#0000ff">You have
                                updated the issue successfully : </FONT> <%
                                    String no = (String) session.getAttribute("theissu");


                                %> <FONT SIZE="4" COLOR="#0000FF"><%=no%></FONT></td>
                    </tr>
                </table>
                <%
                } else {
                %> <br>
                <%
                    }
                %> <%
                    absolte = 0;
                    // invoking the Query() of MyIssueBean
                    logger.debug("Requested Project:" + project);
                    int indexa = project.lastIndexOf(":");

                    String projecta = project.substring(0, indexa);
                    String versiona = project.substring((indexa + 1));

                    ps = connection.prepareStatement("select i.issueid, pname as project,module, subject, description, severity, type, createdon,  due_date,  modifiedon, createdby, assignedto, s.status,ceil(to_number(sysdate-to_date(createdon)))as age  from issue i, issuestatus s, project p,modules m where i.issueid = s.issueid and i.module_id=m.moduleid and pname = ? and version = ? and priority = ? and s.status = ? and p.pid = i.pid order by due_date asc, modifiedon asc, type asc, priority asc, severity asc, createdon asc", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                    ps.setString(1, projecta);
                    ps.setString(2, versiona);
                    ps.setString(3, priority);
                    ps.setString(4, status);

                    rs = ps.executeQuery();
                    rs.last();
                    rowcount = rs.getRow();
                    rs.beforeFirst();

                
                %>



                <table width="100%" height="15">
                    <tr>
                        <%
                            if (rowcount == 0) {
                        %>
                        <td align="left" width="100%">Displaying <b><%= rowcount%></b>&nbsp;Issues&nbsp;
                            with status <b><%= status%></b> and priority <b><%= priority%></td>
                            <%
                            } else {
                            %>
                        <td align="left" width="100%">Displaying <b><%= rowcount%></b>&nbsp;Issues&nbsp;
                            with status <b><%= status%></b> and priority <b><%= priority%></b></td>
                            <%
                                }
                            %>



                        <TD align="right" width="25" height="10">Severity</td>
                        <TD align="right" width="25" height="10" bgcolor="#FF0000">S1</TD>
                        <TD align="right" width="25" height="10" bgcolor="#DF7401">S2</TD>
                        <TD align="right" width="25" height="10" bgcolor="#F7FE2E">S3</TD>
                        <TD align="right" width="25" height="10" bgcolor="#04B45F">S4</TD>
                    </tr>

                </table>
                <br>
                 <div class="tablecontent">
                <TABLE width="100%" id="searchTable" class="tablesorter">                        <thead>
                        <TR bgcolor="#C3D9FF" height="21">
                            <TH width="1%" TITLE="Severity" class="filter-false"><font><b>S</b></font></TH>
                            <TH width="10%"><font><b>Issue No</b></font></TH>
                            <TH width="7%" class="filter-select filter-match" data-placeholder="Select a Module"><font><b>Module</b></font></TH>
                            <TH width="28%"><font><b>Subject</b></font></TH>
                            <TH width="8%" class="filter-false"><font><b>Due Date</b></font></TH>
                            <TH width="8%" class="filter-false"><font><b>Modified On</b></font></TH>
                            <TH width="13%" class="filter-select filter-match" data-placeholder="Select CeatedBy"><font><b>Created By</b></font></TH>
                            <TH width="13%" class="filter-select filter-match" data-placeholder="Select AssignTo"><font><b>AssignedTo</b></font></TH>
                            <TH width="8%" class="filter-false"><font><b>Refer</b></font></TH>
                            <TH width="5%" TITLE="In Days" ALIGN="center"><font><b>Age</b></font></TH>

                        </TR>
                    </thead>
                    <tbody>
                    <%
                        int index = project.lastIndexOf(":");
                        String pro = project.substring(0, index);
                        String fix = project.substring((index + 1));
                        if (rs != null) {
                            String totalissuenos = "";
                                while (rs.next()) {

                                    totalissuenos = totalissuenos + "'" + rs.getString("issueid").trim() + "',";
                                }
                           
                            Map<String, Integer> lastAsigneeAgeList = new HashMap<String, Integer>();
                            Map<String, Integer> fileCountList = new HashMap<String, Integer>();
                            if (totalissuenos.contains(",")) {
                                totalissuenos = totalissuenos.substring(0, totalissuenos.length() - 1);
                                lastAsigneeAgeList = GetAge.issuelastAsigneeAge(totalissuenos);
                                fileCountList = IssueDetails.displayFilesCount(totalissuenos);
                            }
                                rs.beforeFirst();

                           
                                while (rs.next()) {

                                    String module = rs.getString("module");
                                    String iss = rs.getString("issueid");
                                    String severity = rs.getString("severity");
                                    String createdBy = rs.getString("createdby");
                                    String sub = rs.getString("subject");
                                    if (sub.length() > 42) {
                                        sub = sub.substring(0, 42) + "...";
                                    }
                                    String desc = rs.getString("description");
                                    String type = rs.getString("type");
                                    String assignedTo = rs.getString("assignedto");

                                    Date modified = rs.getDate("modifiedon");

                                    SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yy");

                                    Date created = rs.getDate("createdon");
                                    String fullModule = module;
                                    if (module.length() > 10) {
                                        module = module.substring(0, 10) + "...";
                                    }
                                    String createdon = "NA";
                                    if (created != null) {
                                        createdon = sdf.format(created);
                                    }

                                    Date dueDateFormat = rs.getDate("due_date");
                                    String dueDate = "NA";
                                    if (dueDateFormat != null) {
                                        dueDate = sdf.format(dueDateFormat);
                                    }
                                    String modifiedOn = "NA";
                                    if (modified != null) {
                                        modifiedOn = sdf.format(modified);
                                    }
                                    age = rs.getInt("age");
                                    int lastAsigneeAge = 1;
                                    if (lastAsigneeAgeList.containsKey(iss)) {
                                        lastAsigneeAge = lastAsigneeAgeList.get(iss);
                                    }
                                    if (lastAsigneeAge == 1) {
                                        lastAsigneeAge = age;
                                    }
                                    if (lastAsigneeAge == 0) {
                                        lastAsigneeAge = lastAsigneeAge + 1;
                                    }
                                                                    // to fetch the firstname & lastname from user table

                                    //int size = hm.size();
                                    //int selectedUser 		= Integer.parseInt(userId);
                                    //String result		= (String)hm.get(selectedUser);
                                    //logger.info("SELECTED EMPLOYEE:"+ selectedUser +"::"+result);
                                    String s1 = "S1- Fatal";
                                    String s2 = "S2- Critical";
                                    String s3 = "S3- Important";
                                    String s4 = "S4- Minor";

                                  int i = 1;
                                    if ((i % 2) != 0) {
                        %>
                        <tr class="zebralinealter" height="28" style="padding: 5px;">
                            <%
                            } else {
                            %>

                        <tr class="zebraline" height="28" style="padding: 5px;">
                            <%
                                }
                            %>


    <%
                                if (severity.equals(s1)) {
                            %>
                            <td   width="1%" style="background-color:#FF0000; " bgcolor="#FF0000"></td>
                            <%
                            } else if (severity.equals(s2)) {
                            %>
                            <td   width="1%" style="background-color:#DF7401; " bgcolor="#DF7401"></td>
                            <%
                            } else if (severity.equals(s3)) {
                            %>
                            <td  width="1%" style="background-color:#F7FE2E; " bgcolor="#F7FE2E"></td>
                            <%
                            } else if (severity.equals(s4)) {
                            %>
                            <td   width="1%" style="background-color:#04B45F; " bgcolor="#04B45F"></td>
                            <%
                                }
                            int uid = (Integer) session.getAttribute("userid_curr");
                            int roleId = (Integer) session.getAttribute("Role");
                            int pmanager = Integer.parseInt(GetProjectManager.getManager(pro, fix));
                            //Displaying issues in editable mode for Admin and Project Manager
                            if ((roleId == 1) || (uid == pmanager)) {
                        %>
                        <td class="background"   TITLE="<%= type%>"><font
                                face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#0033FF"><%--<a
                                    href="<%= request.getContextPath()%>/admin/dashboard/UpdateIssueview.jsp?issueNo=<%=iss%>"><%= iss%></a>--%><a href="javascript:callissue('<%=iss%>','<%=project%>','<%=priority%>','<%=status%>','<%=roleId%>','<%=uid%>','<%=pmanager%>')" style="visibility: visible"><%=iss%>

                                </a></font></td>

                        <%
                        } else {
                        %>
                        <td class="background"   TITLE="<%= type%>"><font
                                face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#0033FF"><%--<a
                                    href="<%= request.getContextPath()%>/Issuesummaryview.jsp?issueid=<%=iss%>">--%><a href="javascript:callissue('<%=iss%>','<%=project%>','<%=priority%>','<%=status%>','<%=roleId%>','<%=uid%>','<%=pmanager%>')" style="visibility: visible"><%= iss%></a></font></td>
                                <%
                                    }
                                %>
                        <td class="background"  title="<%=fullModule%>"><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= module%></font></td>
                        <td class="background"   id="<%=iss%>tab" onmouseover="xstooltip_show('<%=iss%>', '<%=iss%>tab', 289, 49);" onmouseout="xstooltip_hide('<%=iss%>');" ><div class="issuetooltip" id="<%=iss%>"><%= desc%></div>
                            <font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= sub%></font></td>
                                <%

                                    int originator = Integer.parseInt(createdBy);

                                    String creator = (String) hm.get(originator);

                                    int holder = Integer.parseInt(assignedTo);

                                    String currentHolder = (String) hm.get(holder);

                                    if ((!dueDate.equalsIgnoreCase("NA")) && (CheckDate.getFlag(dueDate) == true)) {

                                %>
                        <td class="background"  ><font face="Verdana, Arial, Helvetica, sans-serif"
                                   size="1" color="RED"><%= dueDate%></font></td>
                                <%
                                } else {
                                %>
                        <td class="background"  ><font face="Verdana, Arial, Helvetica, sans-serif"
                                  size="1" color="#000000"><%= dueDate%></font></td>
                                <%
                                    }
                                %>
                        <td class="background"  ><font
                                face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= modifiedOn%></font></td>
                        <td class="background"  ><font
                                face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= creator%>
                            </font></td>
                        <td class="background"  ><font
                                face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= currentHolder%></font></td>


                        <%
                            int count1 = 0;
                            if (fileCountList.containsKey(iss)) {
                                count1 = fileCountList.get(iss);
                            }
                            if (count1 > 0) {
                        %>
                        <td class="background"  ><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"> <A onclick="viewFileAttachForIssue('<%=iss%>');" href="#">ViewFiles(<%=count1%>)</A></font></td>
                                    <%
                                    } else {
                                    %>
                        <td class="background"  ><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000">No Files</font></td>
                                <%
                                    }
                                %>
                        <td class="background"  align=center title="<%=lastAsigneeAge%>"><font
                                face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000" ><%=age%></font>
                        </td>

                        <%
                            }
                        %>
                    </tr>
                    <%
                        }
                    %>
                </TABLE>
                 </DIV>
                <%
                            }
                        
                    } catch (Exception e) {
                        logger.error("Exception:" + e);
                        //System.err.println(e);
                    } finally {
                        if (rs != null) {
                            rs.close();
                        }

                        if (ps != null) {
                            ps.close();
                        }
                        logger.debug("closing jdbc resources in finally block");
                        if (connection != null && !connection.isClosed()) {
                            connection.close();
                        }
                    }
                %>
                <div id="MDAVpopup" class="popup">
                    <h3 class="popupHeading">View Attached Files</h3>
                    <div>
                        <div class="clear"></div>
                        <div class="tableshow">
                            <div id="IssuePopupFiles">

                            </div>
                            <button class="custom-popup-close" onclick="closeIssuePopup();" type="button">close</button>

                        </div>
                    </div>
                </div>
                </BODY>
                <script type="text/javascript">
                    function callissue(issueid, project, priority, status, roleId, uid, pmanager) {

                        var userin = "statusWise";
                        var value = project.split(":");
                        for (var i = 0; i < value.length; i++) {
                            var project = value[0];
                            var version = value[1];
                        }

                        if ((roleId == 1) || (uid == pmanager)) {

                            location.href = "<%= request.getContextPath()%>/admin/dashboard/UpdateIssueview.jsp?issueNo=" + issueid + "&project=" + project + "&status=" + status + "&priority=" + priority + "&roleId=" + roleId + "&uid=" + uid + "&pmanager=" + pmanager + "&userin=" + userin;
                        } else {


                            location.href = "<%= request.getContextPath()%>/Issuesummaryview.jsp?issueid=" + issueid + "&project=" + project + "&status=" + status + "&priority=" + priority + "&roleId=" + roleId + "&uid=" + uid + "&pmanager=" + pmanager + "&userin=" + userin;
                        }
                    }

                </script>
                           <SCRIPT type="text/javascript" 	src="https://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>

                <SCRIPT type="text/javascript" src="<%=request.getContextPath()%>/javaScript/jquery.jscroll.js"></SCRIPT>

                <script src="<%=request.getContextPath()%>/javaScript/jquery.tablesorter1.js" type="text/javascript"></script>
                <script src="<%=request.getContextPath()%>/javaScript/jquery.tablesorter.widgets.js" type="text/javascript"></script>    
                <link rel="stylesheet" href="<%=request.getContextPath()%>/css/theme.blue1.css?test=3">
                <script type="text/javascript">

                                /*  $(document).ready(function () {
                                 $('.tablecontent').jscroll({
                                 padding: 20,
                                 loadingHtml: '<img class="imgloader" src="<%=request.getContextPath()%>/images/ajax-loader_1.gif"/>',
                                 contentLoader: '.tablecontent #searchTable tbody tr:last',
                                 nextSelector: 'a.jscroll-next:last'
                                 });
                                 });
                                 
                                 */
                                $.tablesorter.addParser({
                                    id: "ddMMMyy",
                                    is: function (s) {
                                        return false;
                                    },
                                    format: function (s, table) {
                                        var from = s.split("-");
                                        var year = "20" + from[2];
                                        var mon = from[1];
                                        var month = new Date(Date.parse(mon + " 1," + year)).getMonth();
                                        return new Date(year, month, from[0]).getTime() || '';
                                    },
                                    type: "numeric"
                                });

                                $(document).ready(function () {

                                    $("#searchTable").tablesorter({
                                        theme: 'blue',
                                        // hidden filter input/selects will resize the columns, so try to minimize the change
                                        widthFixed: true,
                                        // initialize zebra striping and filter widgets
                                        widgets: ["zebra", "filter"],
                                        headers: {5: {// <-- replace 6 with the zero-based index of your column
                                                sorter: 'ddMMMyy'
                                            }, 4: {// <-- replace 6 with the zero-based index of your column
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
                                            }, filter_formatter: {
                                                6: function ($cell, indx) {
                                                    return $.tablesorter.filterFormatter.select2($cell, indx, {
                                                        match: false // exact match only
                                                    });
                                                }
                                            }

                                        }

                                    });

                                });



                </script>
                </HTML>

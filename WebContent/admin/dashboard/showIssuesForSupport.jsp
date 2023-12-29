<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page import="org.apache.log4j.*"%>
<%@ page import="java.sql.*, com.pack.StringUtil"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="com.eminent.util.*,java.text.SimpleDateFormat"%>
<%@ page import="pack.eminent.encryption.*, dashboard.CheckDate"%>





<%
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Cache-Control", "no-store");
    response.setDateHeader("Expires", 0);
    response.setHeader("Pragma", "no-cache");

    //Configuring log4j properties
    Logger logger = Logger.getLogger("showIssuesForSupport");

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
        <script src="<%=request.getContextPath()%>/javaScript/jquery.js" type="text/javascript"></script>

        <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/fileAttach.js"></script>
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
                            int requestpage, pageone, pageremain, rowcount;
                            static int totalpage, pagemanipulation, presentpage, extra, issuenofrom, issuenoto;
                            int userid_curri, age;
                            HashMap hm;

                                                                                        %>
                        <%

                            Connection connection = null;
                            ResultSet rs = null;
                            PreparedStatement ps = null;
                            session.setAttribute("dashBoard", "ASAPIssuesForSupport");
                            session.setAttribute("forwardpage", "/admin/dashboard/showIssuesForSupport.jsp");
                            //int count =0;
                            try {
                                connection = MakeConnection.getConnection();
                                logger.debug("Connection:" + connection);

                                //hm = new HashMap<Integer,String>();
                                hm = MyIssue.getUser(connection);
                                logger.info("SIZE:" + hm.size());

                                if (connection != null) {
                                    String project = null;
                                    String phase = null;

                                    if (request.getParameter("issuestatus") == null) {

                                        project = request.getParameter("project");
                                        phase = request.getParameter("phase");

                                        boolean flag = false;

                                        if (project == null) {

                                            flag = true;

                                            project = (String) session.getAttribute("sapSupportProject");
                                            phase = (String) session.getAttribute("sapSupportPhase");

                                        }

                                        if (flag == false) {

                                            session.setAttribute("sapSupportProject", project);
                                            session.setAttribute("sapSupportPhase", phase);

                                        }

                                        logger.info("Project" + project);
                                        logger.info("Phase" + phase);

                                    } else {

                                        project = (String) session.getAttribute("sapSupportProject");
                                        phase = (String) session.getAttribute("sapSupportPhase");

                                        logger.info("Project" + project);
                                        logger.info("Phase" + phase);

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
                    // invoking the Query() of MyIssueBean
                    logger.debug("Requested Project:" + project);
                    int indexa = project.lastIndexOf(":");

                    String projecta = project.substring(0, indexa);
                    String versiona = project.substring((indexa + 1));

                    ps = connection.prepareStatement("select  i.issueid , module, severity, priority, type, subject, description, createdby, assignedto, createdon, due_date, modifiedon, s.status from issue i, issuestatus s,modules m, project p, issue_support where i.pid = p.pid and i.module_id=m.moduleid and pname = ? and version = ? and i.issueid = issue_support.issueid and issue_support.phase = ? and i.issueid = s.issueid and s.status != 'Closed' order by due_date asc, modifiedon asc, type asc,  severity asc", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                    ps.setString(1, projecta);
                    ps.setString(2, versiona);
                    ps.setString(3, phase);

                    rs = ps.executeQuery();

                    rs.last();
                    rowcount = rs.getRow();
                    rs.beforeFirst();

                    pageone = rowcount / 15;
                    pageremain = rowcount % 15;

                    logger.debug("Total No of records:" + rowcount);
                    if (pageremain > 0) {
                        totalpage = pageone + 1;
                    } else {
                        totalpage = pageone;
                    }
                    logger.debug("Total no of pages" + totalpage);
                    try {
                        String requestpag = request.getParameter("manipulation");
                        logger.debug("Requested page" + requestpag);
                        if (requestpag != null) {
                            requestpage = Integer.parseInt(requestpag);
                            if (requestpage == 1) {
                                presentpage = 1;
                                issuenofrom = 1;
                                issuenoto = issuenofrom + 14;
                                if (issuenoto > rowcount) {
                                    extra = issuenoto - rowcount;
                                    issuenoto = issuenoto - extra;
                                }
                                rs.beforeFirst();
                                logger.debug("Requested page First" + presentpage);
                            }
                            if (requestpage == 2) {
                                presentpage = presentpage - 1;
                                if (presentpage <= 0) {
                                    presentpage = 1;
                                }
                                if (presentpage == 1) {
                                    rs.beforeFirst();
                                    issuenofrom = 1;
                                    issuenoto = issuenofrom + 14;
                                    if (issuenoto > rowcount) {
                                        extra = issuenoto - rowcount;
                                        issuenoto = issuenoto - extra;
                                    }
                                } else {
                                    issuenofrom = ((presentpage - 1) * 15 + 1);
                                    rs.absolute(issuenofrom - 1);
                                    issuenoto = issuenofrom + 14;
                                    if (issuenoto > rowcount) {
                                        extra = issuenoto - rowcount;
                                        issuenoto = issuenoto - extra;
                                    }
                                }
                                logger.debug("Requested page Previous" + presentpage);
                            }
                            if (requestpage == 3) {
                                presentpage = presentpage + 1;
                                if (presentpage >= totalpage) {
                                    presentpage = totalpage;
                                }
                                issuenofrom = ((presentpage - 1) * 15 + 1);
                                rs.absolute(issuenofrom - 1);
                                logger.debug("Requested page Next" + presentpage);
                                issuenoto = issuenofrom + 14;
                                if (issuenoto > rowcount) {
                                    extra = issuenoto - rowcount;
                                    issuenoto = issuenoto - extra;
                                }
                            }
                            if (requestpage == 4) {

                                presentpage = totalpage;
                                logger.debug("Requested page Last" + presentpage);
                                issuenofrom = ((presentpage - 1) * 15 + 1);
                                rs.absolute(issuenofrom - 1);
                                issuenoto = issuenofrom + 14;
                                if (issuenoto > rowcount) {
                                    extra = issuenoto - rowcount;
                                    issuenoto = issuenoto - extra;
                                }
                            }
                        } else {
                            presentpage = 1;
                            issuenofrom = 1;
                            rs.beforeFirst();
                            issuenoto = issuenofrom + 14;
                            if (issuenoto > rowcount) {
                                extra = issuenoto - rowcount;
                                issuenoto = issuenoto - extra;
                            }
                        }
                    } catch (Exception e) {
                        logger.error("Exception:" + e);
                    }
                %>



                <table width="100%" height="15">
                    <tr>
                        <%
                            if (rowcount == 0) {
                        %>
                        <td align="left" width="100%">Displaying Issues&nbsp;<b><%= "0"%>&nbsp;-&nbsp;<%= issuenoto%></b>&nbsp;of&nbsp;<b><%= rowcount%></b>
                            with phase <b><%= phase%></b></td>
                            <%
                            } else {
                            %>
                        <td align="left" width="100%">Displaying Issues&nbsp;<b><%= issuenofrom%>&nbsp;-&nbsp;<%= issuenoto%></b>&nbsp;of&nbsp;<b><%= rowcount%></b>
                            with phase <b><%= phase%></b></td>
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
                <TABLE width="100%">
                    <TR bgcolor="C3D9FF" height="18">
                        <TD width="1%" TITLE="Severity"><font><b>S</b></font></TD>
                        <TD width="11%"><font><b>Issue No</b></font></TD>
                        <TD width="3%" TITLE="Priority"><font><b>P</b></font></TD>
                        <TD width="7%"><font><b>Module</b></font></TD>
                        <TD width="25%"><font><b>Subject</b></font></TD>
                        <TD width="11"><font><b>Status</b></font></TD>
                        <TD width="9%"><font><b>Due Date</b></font></TD>
                        <TD width="12%"><font><b>Created By</b></font></TD>
                        <TD width="10%"><font><b>Assigned To</b></font></TD>

                        <TD width="8%"><font><b>Refer</b></font></TD>
                        <TD width="6%" TITLE="In Days" ALIGN="center"><font><b>Age</b></font></TD>
                    </TR>

                    <%
                        int index = project.lastIndexOf(":");
                        String pro = project.substring(0, index);
                        String fix = project.substring((index + 1));
                        if (rs != null) {
                            for (int i = 1; i <= 15; i++) {
                                if (rs.next()) {

                                    String iss = rs.getString("issueid");
                                    String severity = rs.getString("severity");
                                    String createdBy = rs.getString("createdby");
                                    String sub = rs.getString("subject");
                                    String desc = rs.getString("description");
                                    String type = rs.getString("type");
                                    String assignedTo = rs.getString("assignedto");
                                    String priority = rs.getString("priority");

                                    String p = "NA";
                                    if (priority != null) {
                                        p = priority.substring(0, 2);
                                    }
                                    String status = rs.getString("status");
                                    SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yy");
                                    Date dueDateFormat = rs.getDate("due_date");
                                    String dueDate = "NA";
                                    if (dueDateFormat != null) {
                                        dueDate = sdf.format(dueDateFormat);
                                    }

                                    Date created = rs.getDate("createdon");

                                    String createdon = "NA";
                                    if (created != null) {
                                        createdon = sdf.format(created);
                                    }

                                    Date modified = rs.getDate("modifiedon");
                                    String modifiedOn = "NA";
                                    if (modified != null) {
                                        modifiedOn = sdf.format(modified);
                                    }
                                    String module = rs.getString("module");
                                    String fullModule = module;
                                    if (module.length() > 10) {
                                        module = module.substring(0, 10) + "...";
                                    }

                                    //       				SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yy");
                                    //       	            String dateString1 = sdf.format(modifiedon1);
                                    //       	            String create=sdf.format(createdon);
                                    age = GetAge.getIssueAge(createdon, status, modifiedOn);
                                    int lastAsigneeAge = GetAge.lastAsigneeAge(iss);
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


                    %>

                    <%            if ((i % 2) != 0) {
                    %>
                    <tr bgcolor="white" height="21">
                        <%
                        } else {
                        %>

                    <tr bgcolor="#E8EEF7" height="21">
                        <%
                            }
                        %>


                        <%
                            if (severity.equals(s1)) {
                        %>
                        <td width="1%" bgcolor="#FF0000"></td>
                        <%
                        } else if (severity.equals(s2)) {
                        %>
                        <td width="1%" bgcolor="#DF7401"></td>
                        <%
                        } else if (severity.equals(s3)) {
                        %>
                        <td width="1%" bgcolor="#F7FE2E"></td>
                        <%
                        } else if (severity.equals(s4)) {
                        %>
                        <td width="1%" bgcolor="#04B45F"></td>
                        <%
                            }

                            int uid = (Integer) session.getAttribute("userid_curr");
                            int roleId = (Integer) session.getAttribute("Role");
                            int pmanager = Integer.parseInt(GetProjectManager.getManager(pro, fix));
                            //Displaying issues in editable mode for Admin and Project Manager
                            if ((roleId == 1) || (uid == pmanager)) {


                        %>
                        <td width="11%" TITLE="<%= type%>"><font
                                face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#0033FF"><a
                                    href="<%= request.getContextPath()%>/admin/dashboard/UpdateIssueview.jsp?issueNo=<%=iss%>"><%= iss%></a></font></td>

                        <%
                        } else {
                        %>
                        <td width="11%" TITLE="<%= type%>"><font
                                face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#0033FF"><a
                                    href="<%= request.getContextPath()%>/Issuesummaryview.jsp?issueid=<%=iss%>"><%= iss%></a></font></td>
                                <%
                                    }
                                %>
                        <td width="3%"><font face="Verdana, Arial, Helvetica, sans-serif"
                                             size="1" color="#000000"><%= p%></font></td>
                        <td width="7%" title="<%=fullModule%>"><font face="Verdana, Arial, Helvetica, sans-serif"
                                                                     size="1" color="#000000"><%= module%></font></td>
                                <%
                                    if (sub.length() < 42) {
                                %>
                        <td width="25%" TITLE="<%= StringUtil.escapeHtmlTag(desc)%>"><font
                                face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= sub%></font></td>
                                <%
                                } else {
                                %>
                        <td width="25%" TITLE="<%= StringUtil.escapeHtmlTag(desc)%>"><font
                                face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= sub.substring(0, 42) + "..."%></font></td>
                                <%
                                    }

                                    int originator = Integer.parseInt(createdBy);

                                    String creator = (String) hm.get(originator);

                                    int holder = Integer.parseInt(assignedTo);

                                    String currentHolder = (String) hm.get(holder);


                                %>

                        <td width="9%"><font face="Verdana, Arial, Helvetica, sans-serif"
                                             size="1" color="#000000"><%= status%></font></td>
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
                        <td width="12%"><font
                                face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= creator%>
                            </font></td>
                        <td width="10%"><font
                                face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= currentHolder%></font></td>




                        <%

                            int count1 = 1;
                            PreparedStatement file_ps = connection.prepareStatement("select fileid,filename from fileattach where issueid=?");
                            file_ps.setString(1, iss);
                            ResultSet file_rs = file_ps.executeQuery();
                            if (file_rs != null) {
                                if (file_rs.next()) {

                                    count1++;
                        %>
                        <td width="8%"><font face="Verdana, Arial, Helvetica, sans-serif"
                                             size="1" color="#000000"> <A
                                    onclick="viewFileAttachForIssue('<%=iss%>');" href="#">ViewFiles</A></font></td>
                                    <%
                                            }
                                        }
                                        if (file_rs != null) {
                                            file_rs.close();
                                        }
                                        if (file_ps != null) {
                                            file_ps.close();
                                        }
                                        if (count1 == 1) {
                                    %>
                        <td width="8%"><font face="Verdana, Arial, Helvetica, sans-serif"
                                             size="1" color="#000000">No Files</font></td>
                                <%
                                    }


                                %>

                        <%
                        %>
                        <td width="8%" align=center title="<%=lastAsigneeAge%>"><font
                                face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%=age%></font>
                        </td>
                    </tr>
                    <%
                            }
                        }
                    %>

                    <%
                        }
                    %>
                </table>

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
                %> <%
                    if (rowcount > 0) {
                        if (request.getParameter("manipulation") == null && (rowcount / 16 == 0)) {
                            logger.debug("Caught in 1");
                %> <%
                } else if (request.getParameter("manipulation") == null) {
                %>
                <table align=right>
                    <tr>
                        <td>First</td>
                        <td>Previous</td>
                        <td><a href=<%= request.getContextPath()%>/admin/dashboard/showIssues.jsp?manipulation=3>Next</a></td>
                        <td><a href=<%= request.getContextPath()%>/admin/dashboard/showIssues.jsp?manipulation=4>Last</a></td>
                    </tr>
                </table>
                <%

                } else if (request.getParameter("manipulation").equals("4")) {
                    logger.debug("Caught in 2");
                %>
                <table align=right>
                    <tr>
                        <td><a href=<%= request.getContextPath()%>/admin/dashboard/showIssues.jsp?manipulation=1>First</a></td>
                        <td><a href=<%= request.getContextPath()%>/admin/dashboard/showIssues.jsp?manipulation=2>Previous</a></td>
                        <td>Next</td>
                        <td>Last</td>
                    </tr>
                </table>
                <%
                } else if (request.getParameter("manipulation").equals("1")) {
                %>
                <table align=right>
                    <tr>
                        <td>First</td>
                        <td>Previous</td>
                        <td><a href=<%= request.getContextPath()%>/admin/dashboard/showIssues.jsp?manipulation=3>Next</a></td>
                        <td><a href=<%= request.getContextPath()%>/admin/dashboard/showIssues.jsp?manipulation=4>Last</a></td>
                    </tr>
                </table>
                <%
                } else if (request.getParameter("manipulation").equals("3") && issuenoto == rowcount) {
                    logger.debug("Caught in 3");
                %>
                <table align=right>
                    <tr>
                        <td><a href=<%= request.getContextPath()%>/admin/dashboard/showIssues.jsp?manipulation=1>First</a></td>
                        <td><a href=<%= request.getContextPath()%>/admin/dashboard/showIssues.jsp?manipulation=2>Previous</a></td>
                        <td>Next</td>
                        <td>Last</td>
                    </tr>
                </table>
                <%

                } else if (request.getParameter("manipulation").equals("3")) {
                    logger.debug("Caught in 4");
                %>
                <table align=right>
                    <tr>
                        <td><a href=<%= request.getContextPath()%>/admin/dashboard/showIssues.jsp?manipulation=1>First</a></td>
                        <td><a href=<%= request.getContextPath()%>/admin/dashboard/showIssues.jsp?manipulation=2>Previous</a></td>
                        <td><a href=<%= request.getContextPath()%>/admin/dashboard/showIssues.jsp?manipulation=3>Next</a></td>
                        <td><a href=<%= request.getContextPath()%>/admin/dashboard/showIssues.jsp?manipulation=4>Last</a></td>
                    </tr>
                </table>
                <%

                } else if (request.getParameter("manipulation").equals("2") && issuenofrom == 1) {
                    logger.debug("Caught in 5");
                %>
                <table align=right>
                    <tr>
                        <td>First</td>
                        <td>Previous</td>
                        <td><a href=<%= request.getContextPath()%>/admin/dashboard/showIssues.jsp?manipulation=3>Next</a></td>
                        <td><a href=<%= request.getContextPath()%>/admin/dashboard/showIssues.jsp?manipulation=4>Last</a></td>
                    </tr>
                </table>
                <%

                } else if (request.getParameter("manipulation").equals("2")) {
                    logger.debug("Caught in 6");
                %>
                <table align=right>
                    <tr>
                        <td><a href=<%= request.getContextPath()%>/admin/dashboard/showIssues.jsp?manipulation=1>First</a></td>
                        <td><a href=<%= request.getContextPath()%>/admin/dashboard/showIssues.jsp?manipulation=2>Previous</a></td>
                        <td><a href=<%= request.getContextPath()%>/admin/dashboard/showIssues.jsp?manipulation=3>Next</a></td>
                        <td><a href=<%= request.getContextPath()%>/admin/dashboard/showIssues.jsp?manipulation=4>Last</a></td>
                    </tr>
                </table>
                <%

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
                </HTML>

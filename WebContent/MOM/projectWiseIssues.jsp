<%-- 
    Document   : projectWiseIssues
    Created on : Oct 18, 2013, 12:46:15 PM
    Author     : E0288
--%>

<%@page import="java.util.Map"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.text.*"%>
<%@ page import="java.sql.Date,pack.eminent.encryption.*,com.eminent.util.*, dashboard.CheckDate"%>
<%@ page import="org.apache.log4j.*, com.pack.StringUtil"%>
<%@ page import="java.util.HashMap,java.text.SimpleDateFormat"%>
<%@page import="com.eminentlabs.mom.MoMUtil"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <%
        String logoutcheck = (String) session.getAttribute("Name");
        if (logoutcheck == null) {
    %>
    <jsp:forward page="../SessionExpired.jsp"></jsp:forward>
    <%    }
    %>
    <%@ include file="../header.jsp"%>
    <%
        response.setHeader("session.cache_limiter", "private");
    %>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS Solution</title>
<LINK title=STYLE href="<%= request.getContextPath()%>/eminentech support files/main_ie.css?test=261020151225" type="text/css" rel="STYLESHEET">
        <script src="<%=request.getContextPath()%>/javaScript/XMLHttpRequest.js" type="text/javascript"></script>
        <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/fileAttach.js?test=261020151625"></script>
                <script src="<%=request.getContextPath()%>/javaScript/jquery.js" type="text/javascript"></script>

        <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/tooltip.js"></script>
    </head>
    <body>
        <%!    int requestpage, pageone, pageremain, rowcount, age;
            static int totalpage, pagemanipulation, presentpage, extra, issuenofrom, issuenoto;
            int userid_curri, absolte;
            HashMap hm;
        %>
        <table cellpadding="0" cellspacing="0" width="100%">
	<tr bgColor="#C3D9FF">
		<td bgcolor="#C3D9FF" align="left" width="100%"><font
			size="4" COLOR="#0000FF"><b> MoM Project wise issues </b></font></td>
	</tr>
</table>
        <jsp:useBean id="MyIssue" class="com.pack.MyIssueBean" />
        <%
            Connection connection = null;
            Statement stmt1 = null;
            
            ResultSet rs1 = null;
            
          
            Logger logger = Logger.getLogger("projectWiseIssues");
           
            int pId = 0;
            String projectMoMStatus="altogether";
            String query = "";
            if(request.getParameter("pId")!=null){
                
                pId = MoMUtil.parseInteger(request.getParameter("pId").trim(), 0);
            }
             if(request.getParameter("projectMoMStatus")!=null){
                projectMoMStatus = request.getParameter("projectMoMStatus");
            }
             
            try {
                absolte = 0;
                query = MoMUtil.getIssuesOnProjectStatus(pId, projectMoMStatus);
                connection = MakeConnection.getConnection();
                stmt1 = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                rs1 = stmt1.executeQuery(query);
                rs1.last();
                int rowcount = rs1.getRow();
                rs1.beforeFirst();
                pageone = rowcount / 100;
                pageremain = rowcount % 100;
                logger.info("Total No of records:" + rowcount);
                if (pageremain > 0) {
                    totalpage = pageone + 1;
                } else {
                    totalpage = pageone;
                }
                try {
                    String requestpag = request.getParameter("manipulation");
                    logger.debug("Requested page" + requestpag);
                    if (requestpag != null) {
                        requestpage = Integer.parseInt(requestpag);
                        if (requestpage == 1) {
                            presentpage = 1;
                            issuenofrom = 1;
                            issuenoto = issuenofrom + 99;
                            if (issuenoto > rowcount) {
                                extra = issuenoto - rowcount;
                                issuenoto = issuenoto - extra;
                            }
                            rs1.beforeFirst();
                            logger.debug("Requested page First" + presentpage);
                        }
                        if (requestpage == 2) {
                            presentpage = presentpage - 1;
                            if (presentpage <= 0) {
                                presentpage = 1;
                            }
                            if (presentpage == 1) {
                                rs1.beforeFirst();
                                issuenofrom = 1;
                                issuenoto = issuenofrom + 99;
                                if (issuenoto > rowcount) {
                                    extra = issuenoto - rowcount;
                                    issuenoto = issuenoto - extra;
                                }
                            } else {
                                issuenofrom = ((presentpage - 1) * 100 + 1);
                                absolte=issuenofrom - 1;
                                rs1.absolute(issuenofrom - 1);
                                issuenoto = issuenofrom + 99;
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
                            issuenofrom = ((presentpage - 1) * 100 + 1);
                            absolte=issuenofrom - 1;
                            rs1.absolute(issuenofrom - 1);
                            logger.debug("Requested page Next" + presentpage);
                            issuenoto = issuenofrom + 99;
                            if (issuenoto > rowcount) {
                                extra = issuenoto - rowcount;
                                issuenoto = issuenoto - extra;
                            }
                        }
                        if (requestpage == 4) {
                            presentpage = totalpage;
                            logger.debug("Requested page Last" + presentpage);
                            issuenofrom = ((presentpage - 1) * 100 + 1);
                            absolte=issuenofrom - 1;
                            rs1.absolute(issuenofrom - 1);
                            issuenoto = issuenofrom + 99;
                            if (issuenoto > rowcount) {
                                extra = issuenoto - rowcount;
                                issuenoto = issuenoto - extra;
                            }
                        }
                    } else {
                        presentpage = 1;
                        issuenofrom = 1;
                        rs1.beforeFirst();
                        issuenoto = issuenofrom + 99;
                        if (issuenoto > rowcount) {
                            extra = issuenoto - rowcount;
                            issuenoto = issuenoto - extra;
                        }
                    }
                } catch (Exception e) {
                    logger.error("Exception:----------" + e);
                    logger.error(e.getMessage());
                }
        %>
        <br/>
        <table width="100%">
            <tr height="10">
                <%
                    if (rowcount == 0) {
                %>
                <td align="left" width="100%">Displaying Issues&nbsp;<b><%= "0"%>&nbsp;-&nbsp;<%= issuenoto%></b>&nbsp;of&nbsp;<b><%= rowcount%></b>&nbsp;issues
                    </td>
                    <%
                    } else {
                    %>
                <td align="left" width="100%">Displaying Issues&nbsp;<b><%= issuenofrom%>&nbsp;-&nbsp;<%= issuenoto%></b>&nbsp;of&nbsp;<b><%= rowcount%></b>&nbsp;issues
                    </td>
                    <%
                        }
                    %>


                <td width="100%"></td>
                <td align="right" width="25">Severity</td>
                <TD align="right" width="25" bgcolor="#FF0000">S1</TD>
                <TD align="right" width="25" bgcolor="#DF7401">S2</TD>
                <TD align="right" width="25" bgcolor="#F7FE2E">S3</TD>
                <TD align="right" width="25" bgcolor="#04B45F">S4</TD>
            </tr>
        </table>
        <br>
        <TABLE width="100%">

            <TR bgcolor="#C3D9FF" height="21">
                <TD width="1%" TITLE="Severity"><font><b>S</b></font></TD>
                <TD width="10%"><font><b>Issue No</b></font></TD>
                <TD width="2%" TITLE="Priority"><font><b>P</b></font></TD>
                <TD width="10%"><font><b>Project</b></font></TD>
                <TD width="7%"><font><b>Module</b></font></TD>
                <TD width="29%"><font><b>Subject</b></font></TD>
                <TD width="10"><font><b>Status</b></font></TD>
                <TD width="7%"><font><b>Due Date</b></font></TD>
                <TD width="10%"><font><b>AssignedTo</b></font></TD>
                <TD width="8%"><font><b>Refer</b></font></TD>
                <TD width="3%" TITLE="In Days" ALIGN="CENTER"><font><b>Age</b></font></TD>
            </TR>


            <%
                if (rs1 != null) {
                    HashMap<Integer,String>  hm	= MyIssue.getUser(connection);
                    String totalissuenos = "";
                            for (int i = 1; i <= 100; i++) {
                                if (rs1.next()) {

                                    totalissuenos = totalissuenos + "'" + rs1.getString("issueid").trim() + "',";
                                }
                            }
                            Map<String, Integer> lastAsigneeAgeList = new HashMap<String, Integer>();
                            Map<String, Integer> fileCountList=new HashMap<String, Integer>();
                            if (totalissuenos.contains(",")) {
                                totalissuenos = totalissuenos.substring(0, totalissuenos.length() - 1);
                                lastAsigneeAgeList = GetAge.issuelastAsigneeAge(totalissuenos);
                                fileCountList=IssueDetails.displayFilesCount(totalissuenos);
                            }

                            if (absolte != 0) {
                                rs1.absolute(absolte);
                            } else {
                                rs1.beforeFirst();
                            }
                    for (int i = 1; i <= 100; i++) {
                        if (rs1.next()) {
                            String issueid = rs1.getString("issueid");
                            session.setAttribute("theissno", issueid);
                            String project = rs1.getString("project");
                            String module = rs1.getString("module");
                            String severity1 = rs1.getString("severity");
                            String assignedto1 = rs1.getString("assignedto");
                            String type = rs1.getString("type");
                            String status = rs1.getString("status");
                            String priority = rs1.getString("priority");
                            int typ = rs1.getInt("createdby");
                            String createdBy = (String) hm.get(new Integer(typ));

                            String p = "NA";
                            if (priority != null) {
                                p = priority.substring(0, 2);
                            }
                            String fullModule = module;
                            if (module.length() > 10) {
                                module = module.substring(0, 10) + "...";
                            }
                            SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yy");
                            Date dueDateFormat = rs1.getDate("due_date");
                            String dueDate = "NA";
                            if (dueDateFormat != null) {
                                dueDate = sdf.format(dueDateFormat);
                            }

                            Date created = rs1.getDate("createdon");
                            String createdon = "NA";
                            if (created != null) {
                                createdon = sdf.format(created);
                            }

                            Date modifiedon1 = rs1.getDate("modifiedon");

                            String dateString1 = sdf.format(modifiedon1);

                            age = rs1.getInt("age");
                            int lastAsigneeAge =1;
                                    if(lastAsigneeAgeList.containsKey(issueid)){
                                            lastAsigneeAge=lastAsigneeAgeList.get(issueid);
                                    }
                                    if (lastAsigneeAge == 1) {
                                        lastAsigneeAge = age;
                                    }
                                    if (lastAsigneeAge == 0) {
                                        lastAsigneeAge = lastAsigneeAge + 1;
                                    }
                           
                            String assignedto2="";
                            if(assignedto1!=null){
                                assignedto2=hm.get(new Integer(assignedto1));
                            }
                             
                            String type1 = rs1.getString("type");
                            String s1 = "S1- Fatal";
                            String s2 = "S2- Critical";
                            String s3 = "S3- Important";
                            String s4 = "S4- Minor";
                            String status1 = rs1.getString("status");

                            String subject1 = rs1.getString("subject");
                            if (subject1.length() > 42) {
                                subject1 = subject1.substring(0, 42) + "...";
                            }
                            String desc = rs1.getString("description");
            %>

            <%
                if ((i % 2) != 0) {
            %>
            <tr bgcolor="white" height="22">
                <%                } else {
                %>

            <tr bgcolor="#E8EEF7" height="22">
                <%                    }
                %>

                <% if (severity1.equals(s1)) {%>
                <td width="1%" bgcolor="#FF0000"></td>
                <%} else if (severity1.equals(s2)) {%>
                <td width="1%" bgcolor="#DF7401"></td>
                <%} else if (severity1.equals(s3)) {%>
                <td width="1%" bgcolor="#F7FE2E"></td>
                <%} else if (severity1.equals(s4)) {%>
                <td width="1%" bgcolor="#04B45F"></td>
                <%}%>
                <td width="10%" TITLE="<%= type%>"><A
                        HREF="<%=request.getContextPath()%>/Issuesummaryview.jsp?issueid=<%=issueid%>"><font
                            face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#0033FF">
                        <%=issueid%> </font></A></td>
                <td width="2%"><font face="Verdana, Arial, Helvetica, sans-serif"
                                     size="1" color="#000000"><%= p%></font></td>

                <td width="12%"><font  face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= project%></font></td>
                <td width="7%" title="<%=fullModule%>"><font	face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= module%></font></td>
                <td id="<%=issueid%>tab" onmouseover="xstooltip_show('<%=issueid%>', '<%=issueid%>tab', 289, 49);" onmouseout="xstooltip_hide('<%=issueid%>');" ><div class="issuetooltip" id="<%=issueid%>"><%= desc%></div><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= subject1%></font></td>
                    <%
                        String color = "";



                    %>
                <td width="10%" bgcolor="<%=color%>" title=""><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= status1%></font></td>


                <%
                    if ((status1 != null) && (!status1.equalsIgnoreCase("Closed")) && (!dueDate.equalsIgnoreCase("NA")) && CheckDate.getFlag(dueDate) == true) {
                %><td width="7%" title="Last Modified On <%= dateString1%>">
                    <font face="Verdana, Arial, Helvetica, sans-serif"
                          size="1" color="RED"><%= dueDate%></font></td>
                    <%
                    } else if ((status1.equalsIgnoreCase("Closed") && (CheckDate.getClosedIssueFlag(dueDate, dateString1) == true))) {
                    %>
                <td width="7%" title="Last Modified On <%= dateString1%>"><font
                        face="Verdana, Arial, Helvetica, sans-serif" size="1" color="RED"><%= dueDate%></font>
                </td>
                <%
                } else {
                %>
                <td width="9%" title="Last Modified On <%= dateString1%>">
                    <font face="Verdana, Arial, Helvetica, sans-serif" size="1"
                          color="#000000"><%= dueDate%></font>
                </td>
                <%
                    }
                %>
                <td width="10%" title="Created By <%= createdBy%>"><font
                        face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= assignedto2%></font></td>
                    <%
                        int count1 = 0;
                        if (fileCountList.containsKey(issueid)) {
                                    count1 = fileCountList.get(issueid);
                                }

                        if (count1 > 0) {
                    %>
                <td><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"> <A onclick="viewFileAttachForIssue('<%=issueid%>');" href="#"
>ViewFiles(<%=count1%>)</A></font></td>
                        <%
                        } else {
                        %>
                <td><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000">No Files</font></td>
                    <%                }
                    %>
                <td width="3%" align="center" title="<%=lastAsigneeAge%>"><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%=age%></font>
                </td>
            </tr>

            <%


                }
            %>

            <%

                }
                if (rowcount > 0) {
                    if (request.getParameter("manipulation") == null && (rowcount / 101 == 0)) {
                        logger.debug("Caught in 1");
            %>

            <%
            } else if (request.getParameter("manipulation") == null) {
            %>
            <table align=right>
                <tr>
                    <td>First</td>
                    <td>Prev</td>
                    <td><a href="<%=request.getContextPath()%>/MOM/projectWiseIssues.jsp?manipulation=3&pId=<%=pId%>&projectMoMStatus=<%=projectMoMStatus%>">Next</a></td>
                    <td><a href="<%=request.getContextPath()%>/MOM/projectWiseIssues.jsp?manipulation=4&pId=<%=pId%>&projectMoMStatus=<%=projectMoMStatus%>">Last</a></td>
                </tr>
            </table>
            <%

            } else if (request.getParameter("manipulation").equals("4")) {
                logger.debug("Caught in 2");
            %>
            <table align=right>
                <tr>
                    <td><a href="<%=request.getContextPath()%>/MOM/projectWiseIssues.jsp?manipulation=1&pId=<%=pId%>&projectMoMStatus=<%=projectMoMStatus%>">First</a></td>
                    <td><a href="<%=request.getContextPath()%>/MOM/projectWiseIssues.jsp?manipulation=2&pId=<%=pId%>&projectMoMStatus=<%=projectMoMStatus%>">Prev</a></td>
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
                    <td>Prev</td>
                    <td><a href="<%=request.getContextPath()%>/MOM/projectWiseIssues.jsp?manipulation=3&pId=<%=pId%>&projectMoMStatus=<%=projectMoMStatus%>">Next</a></td>
                    <td><a href="<%=request.getContextPath()%>/MOM/projectWiseIssues.jsp?manipulation=4&pId=<%=pId%>&projectMoMStatus=<%=projectMoMStatus%>">Last</a></td>
                </tr>
            </table>
            <%
            } else if (request.getParameter("manipulation").equals("3") && issuenoto == rowcount) {
                logger.debug("Caught in 3");
            %>
            <table align=right>
                <tr>
                    <td><a href="<%=request.getContextPath()%>/MOM/projectWiseIssues.jsp?manipulation=1&pId=<%=pId%>&projectMoMStatus=<%=projectMoMStatus%>">First</a></td>
                    <td><a href="<%=request.getContextPath()%>/MOM/projectWiseIssues.jsp?manipulation=2&pId=<%=pId%>&projectMoMStatus=<%=projectMoMStatus%>">Prev</a></td>
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
                    <td><a href="<%=request.getContextPath()%>/MOM/projectWiseIssues.jsp?manipulation=1&pId=<%=pId%>&projectMoMStatus=<%=projectMoMStatus%>">First</a></td>
                    <td><a href="<%=request.getContextPath()%>/MOM/projectWiseIssues.jsp?manipulation=2&pId=<%=pId%>&projectMoMStatus=<%=projectMoMStatus%>">Prev</a></td>
                    <td><a href="<%=request.getContextPath()%>/MOM/projectWiseIssues.jsp?manipulation=3&pId=<%=pId%>&projectMoMStatus=<%=projectMoMStatus%>">Next</a></td>
                    <td><a href="<%=request.getContextPath()%>/MOM/projectWiseIssues.jsp?manipulation=4&pId=<%=pId%>&projectMoMStatus=<%=projectMoMStatus%>">Last</a></td>
                </tr>
            </table>
            <%

            } else if (request.getParameter("manipulation").equals("2") && issuenofrom == 1) {
                logger.debug("Caught in 5");
            %>
            <table align=right>
                <tr>
                    <td>First</td>
                    <td>Prev</td>
                    <td><a href="<%=request.getContextPath()%>/MOM/projectWiseIssues.jsp?manipulation=3&pId=<%=pId%>&projectMoMStatus=<%=projectMoMStatus%>">Next</a></td>
                    <td><a href="<%=request.getContextPath()%>/MOM/projectWiseIssues.jsp?manipulation=4&pId=<%=pId%>&projectMoMStatus=<%=projectMoMStatus%>">Last</a></td>
                </tr>
            </table>
            <%

            } else if (request.getParameter("manipulation").equals("2")) {
                logger.debug("Caught in 6");
            %>
            <table align="right">
                <tr>
                    <td><a href="<%=request.getContextPath()%>/MOM/projectWiseIssues.jsp?manipulation=1&pId=<%=pId%>&projectMoMStatus=<%=projectMoMStatus%>">First</a></td>
                    <td><a href="<%=request.getContextPath()%>/MOM/projectWiseIssues.jsp?manipulation=2&pId=<%=pId%>&projectMoMStatus=<%=projectMoMStatus%>">Prev</a></td>
                    <td><a href="<%=request.getContextPath()%>/MOM/projectWiseIssues.jsp?manipulation=3&pId=<%=pId%>&projectMoMStatus=<%=projectMoMStatus%>">Next</a></td>
                    <td><a href="<%=request.getContextPath()%>/MoM/projectWiseIssues.jsp?manipulation=4&pId=<%=pId%>&projectMoMStatus=<%=projectMoMStatus%>">Last</a></td>
                </tr>
            </table>
            <%

                    }
                }
            %>
        </table>
        <%
                }



            } catch (Exception e) {
                logger.error("Exception:" + e);
                logger.error(e.getMessage());
            } finally {
                if (connection != null) {
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
    </body>
</html>

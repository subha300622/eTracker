<%@page import="com.eminent.issue.formbean.IssueSearchFormBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.util.List"%>
<%@page import="java.util.LinkedHashMap"%>
<%@page import="java.util.Map"%>
<%@page import="com.eminent.util.GetProjectMembers"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%
    //Configuring log4j properties

    Logger logger = Logger.getLogger("Issuesummaryview");

    String logoutcheck = (String) session.getAttribute("Name");
    if (logoutcheck == null) {
        response.sendRedirect(request.getContextPath() + "/SessionExpired.jsp");
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
    </HEAD>
    <LINK title=STYLE href="<%= request.getContextPath()%>/eminentech support files/main_ie.css?test=261020151225" type="text/css" rel="STYLESHEET">
    <script src="<%=request.getContextPath()%>/javaScript/XMLHttpRequest.js" type="text/javascript"></script>
    <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/fileAttach.js"></script>
    <script src="<%=request.getContextPath()%>/javaScript/jquery.js" type="text/javascript"></script>
    <link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/redmond/jquery-ui.css">
    <script src="//code.jquery.com/jquery-1.10.2.js"></script>
    <script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
    <script src="<%=request.getContextPath()%>/javaScript/prevnext.js?test=1289014" type="text/javascript"></script>
    <script type="text/javascript" >
        $(document).ready(function() {

            $('.credit').hide();
        });
        function  openEdit() {
            $('.credit').show();
            $('#crrow').css({backgroundColor: '#C3D9FE'});
            $('.crnormal').hide();
        }
        function  openNormal() {
            $('.credit').hide();
            $('#crrow').css({backgroundColor: '#E8EEF7'});
            $('.crnormal').show();
        }
        function printpost(post)
        {
            pp = window.open('profile.jsp?post_id=' + post, 'pp', 'size = maximize,location=no,statusbar=no,menubar=no,scrollbars=no width=900,height=400');
            pp.focus();
        }
    </script>
    <BODY>
        <FORM METHOD=POST ACTION="Updateform2.jsp"><%@ page import="org.apache.log4j.*"%>
            <%@ page import="java.sql.*,pack.eminent.encryption.*"%>
            <%@ page import="java.text.*,java.util.HashMap,java.util.Collection,java.util.Iterator"%>
            <%@ page import="java.sql.Date,com.eminent.util.IssueDetails"%>
            <%@ page import="com.pack.*"%>
            <%@ page language="java"%>
            <jsp:include page="/header.jsp" />
            <%String userin = request.getParameter("userin");%>
            <div align="center">
                <center>



                    <table align="center" width="100%" cellpadding="0" cellspacing="0">
                        <tr bgcolor="C3D9FF">
                            <td><font size="4" COLOR="#0000FF"><b>Issue Details </b></font></td> <%if (userin != null) {
                                    if ((userin.equalsIgnoreCase("MyAssignment")) || (userin.equalsIgnoreCase("MyIssues")) || (userin.equalsIgnoreCase("statusWise")) || (userin.equalsIgnoreCase("MyDashboard")) || (userin.equalsIgnoreCase("MySearches")) || (userin.equalsIgnoreCase("MyViews"))) {%><td class="previous" align="right"><img id="prev"  class="prevBtn" src="<%=request.getContextPath()%>/images/prev.png"  style="cursor: pointer;" ></img>Prev Next<img id="next" class="nextBtn" src="<%=request.getContextPath()%>/images/next.png"  style="cursor: pointer;" ></img></td><%}
                                        }%>
                        </tr>
                    </table>
                    <%String query_string_view = (String) session.getAttribute("IssueSummaryQuery");
                        String sorton = request.getParameter("sorton");
                        String sort_method = request.getParameter("sort_method");

                        String mail = (String) session.getAttribute("theName");
                        String url = null;
                        HashMap<Integer, String> member = GetProjectMembers.showUsers();
                        if (mail != null) {
                            url = mail.substring(mail.indexOf("@") + 1, mail.length());
                        }

                        String no = request.getParameter("issueno");
                        int count = 0;
                        if (url.equals("eminentlabs.net")) {
                            count = IssueDetails.eTrackerIssueSearchCount(null, no);
                        }
                    %> <br>

                    <table align=left width="100%" bgcolor="C3D9FF">
                        <tr>
                            <td><b>Issue Number <font color="#0000FF"><%= no%></font></b></td>
                            <td align="right">
                                <%if (url.equals("eminentlabs.net")) {%>
                                <span class="refer" style="color: blue;cursor: pointer;margin-right: 20px;">Reference<%if (count > 0) {%>
                                    (<%=count%>)
                                    <%}%></span>
                                    <%}%>
                                <a href="<%=request.getContextPath()%>/viewIssueDetails.jsp?issueid=<%= no%>"
                                   target="_blank">Print this Issue</a>
                            </td>
                        </tr>
                    </table>
                    <br>
                    <BR>
                    <%

                        Connection c = null;
                        Statement stmt = null, stmt1 = null, stmt3 = null, stmt4 = null, stmt5 = null, stmt6 = null, stmt7 = null, state = null, state1 = null;
                        PreparedStatement pt2 = null;
                        ResultSet rs = null, rs3 = null, result = null, result1 = null, rs4 = null, rs5 = null, rs6 = null, rs7 = null, rs8 = null;
                        String phase = null;
                        String subphase = null;
                        String subsubphase = null;
                        String subsubsubphase = null;
                        String projecttype = null;
                        String category = null;
                        String pro = "", fver = "", pri = "", iss = "";
                        try {
                            c = MakeConnection.getConnection();
                            stmt = c.createStatement();
                            stmt1 = c.createStatement();
                            stmt3 = c.createStatement();
                            stmt4 = c.createStatement();

                            rs = stmt.executeQuery("SELECT CUSTOMER, PNAME AS PROJECT ,PLATFORM, MODULE, FOUND_VERSION, SEVERITY, PRIORITY, TYPE, VERSION AS FIX_VERSION, RATING, FEEDBACK FROM ISSUE I, PROJECT P, MODULES M WHERE ISSUEID = '" + no + "' AND I.PID = P.PID AND I.MODULE_ID = M.MODULEID ");
                            if (rs != null) {
                                while (rs.next()) {
                                    String cus = rs.getString("customer");
                                    pro = rs.getString("project");
                                    String mod = rs.getString("module");
                                    String plat = rs.getString("platform");
                                    String ver = rs.getString("found_version");
                                    String sev = rs.getString("severity");
                                    pri = rs.getString("priority");
                                    String typ = rs.getString("type");
                                    fver = rs.getString("fix_version");
                                    String rating = rs.getString("rating");
                                    String feedback = rs.getString("feedback");

                                    ResultSet rs1 = stmt1.executeQuery("select status from issuestatus where issueid='" + no + "' ");//correct
                                    if (rs1 != null) {
                                        while (rs1.next()) {

                                            iss = (String) rs1.getString("status");
                                            rs3 = stmt3.executeQuery("select createdby,createdon,modifiedon  from issue where issueid='" + no + "' ");//correct
                                            if (rs3 != null) {
                                                while (rs3.next()) {
                                                    String f2 = "";
                                                    String l2 = "";
                                                    String full2 = "";
                                                    String creby = (String) rs3.getString("createdby");
                                                    state1 = c.createStatement();
                                                    result1 = state1.executeQuery("SELECT firstname,lastname FROM users where userid=" + creby);//CORRECT
                                                    if (result1.next()) {
                                                        f2 = result1.getString("firstname");
                                                        l2 = result1.getString("lastname");
                                                        full2 = f2 + " " + l2;
                                                    }
                                                    Date creon = rs3.getDate("createdon");
                                                    SimpleDateFormat sdf1 = new SimpleDateFormat("dd MMM yy");
                                                    String dateString1 = sdf1.format(creon);
                                                    Date mdion = rs3.getDate("modifiedon");
                                                    SimpleDateFormat sdf = new SimpleDateFormat("dd MMM yy");
                                                    String dateString = sdf.format(mdion);
                                                    //       System.out.println(creon);
                                                    rs4 = stmt4.executeQuery("select SUBJECT,DESCRIPTION,ASSIGNEDTO,COMMENT1,rootcause,expected_result FROM ISSUE where issueid='" + no + "' ");//CORRECT
                                                    String f1 = "";
                                                    String l1 = "";
                                                    String full = "";
                                                    if (rs4 != null) {
                                                        while (rs4.next()) {
                                                            String sub = (String) rs4.getString("subject");
                                                            String des = (String) rs4.getString("description");
                                                            String root_cau = rs4.getString("rootcause");
                                                            String exp_res = rs4.getString("expected_result");

                                                            int len = des.length();

                                                            int index = 0;
                                                            String des1 = null, nextline = "\n", substr = null;
                                                            if (len >= 130) {
                                                                des1 = des.substring(index, index + 130);
                                                                len = len - 130;
                                                                while ((len / 130) >= 1) {
                                                                    des1 = des1.concat(nextline);
                                                                    index = index + 130;
                                                                    substr = des.substring(index, index + 130);
                                                                    des1 = des1.concat(substr);
                                                                    len = len - 130;
                                                                }
                                                                index = index + 130;
                                                                des1 = des1.concat(nextline);
                                                                des1 = des1.concat(des.substring(index));
                                                            } else {
                                                                des1 = des.substring(index);
                                                            }

                                                            len = exp_res.length();
                                                            index = 0;
                                                            String exp_res1 = null;
                                                            if (len >= 130) {
                                                                exp_res1 = exp_res.substring(index, index + 130);
                                                                len = len - 130;
                                                                while ((len / 130) >= 1) {
                                                                    exp_res1 = exp_res1.concat(nextline);
                                                                    index = index + 130;
                                                                    substr = exp_res.substring(index, index + 130);
                                                                    exp_res1 = exp_res1.concat(substr);
                                                                    len = len - 130;
                                                                }
                                                                index = index + 130;
                                                                exp_res1 = exp_res1.concat(nextline);
                                                                exp_res1 = exp_res1.concat(exp_res.substring(index));
                                                            } else {
                                                                exp_res1 = exp_res.substring(index);
                                                            }

                                                            String assi = (String) rs4.getString("assignedto");
                                                            state = c.createStatement();
                                                            result = state.executeQuery("SELECT firstname,lastname FROM users where userid=" + assi);//CORRECT
                                                            if (result.next()) {
                                                                f1 = result.getString("firstname");
                                                                l1 = result.getString("lastname");
                                                                full = f1 + " " + l1;
                                                            }
                                                            String comm = (String) rs4.getString("comment1");
                                                            //	System.out.println(sub+assi);
                                                            stmt5 = c.createStatement();
                                                            rs5 = stmt5.executeQuery("SELECT category from project where pname = '" + pro + "'");//CORRECT
                                                            if (rs5 != null) {
                                                                if (rs5.next()) {

                                                                    category = rs5.getString(1);
                                                                }
                                                            }

                                                            if (category.equalsIgnoreCase("SAP Project")) {
                                                                stmt6 = c.createStatement();

                                                                rs6 = stmt6.executeQuery("SELECT type from project_type,project where project.pid=project_type.pid and project.pname='" + pro + "' and category='" + category + "'");//CORRECT
                                                                if (rs6 != null) {
                                                                    if (rs6.next()) {

                                                                        projecttype = rs6.getString(1);
                                                                    }
                                                                }

                                                                stmt7 = c.createStatement();
                                                                String tablename = "issue_" + projecttype.toLowerCase();

                                                                rs7 = stmt7.executeQuery("SELECT phase,subphase,subsubphase,subsubsubphase from " + tablename + " where issueid='" + no + "'");//CORRECT
                                                                if (rs7 != null) {
                                                                    if (rs7.next()) {

                                                                        phase = rs7.getString(1);
                                                                        subphase = rs7.getString(2);
                                                                        subsubphase = rs7.getString(3);
                                                                        subsubsubphase = rs7.getString(4);

                                                                    }
                                                                }
                                                            }
                                                            int role = 0;
                                                            boolean flag = true;
                                                            HashMap<String, String> userDetail = GetProjectMembers.getMembers(pro, fver, creby, assi);
                                                            String currentuser = ((Integer) session.getAttribute("userid_curr")).toString();
                                                            role = (Integer) session.getAttribute("Role");
                                                            if (userDetail.get(currentuser) == null && role != 1) {
                                                                flag = false;
                    %>

                    <table>
                        <tr align="center" ><td><font color="red">You are not authorised to access this issue.</font></td></tr>
                    </table>
                    <p style="height: 250px;"></p>
                    <%} else {%>
                    <table width="100%" bgcolor="E8EEF7">
                        <tr height="21">
                            <td width="12%"><B>Customer </B></td>
                            <td width="24%"><B></B><%= cus%></td>
                            <td width="11%"><B>Product </B></td>
                            <td width="22%"><B></B><%= pro%></td>
                            <td width="10%"><B>Version </B></td>
                            <td width="21%"><B></B><%=ver%></td>
                        </tr>
                        <tr height="21">
                            <td width="12%"><B>Platform </B></td>
                            <td width="24%"><B></B><%= plat%></td>
                            <td width="11%"><B>Module </B></td>
                            <td width="22%"><B></B><%= mod%></td>
                            <td width="10%"><B>Severity </B></td>
                            <td width="21%"><B></B><%= sev%></td>
                        </tr>
                        <tr height="21">
                            <td width="12%"><B>Priority </B></td>
                            <td width="24%"><B></B><%= pri%></td>
                            <td width="11%"><B>IssueStatus</B></td>
                            <td width="22%"><B></B><%=iss%></td>
                            <td width="10%"><B>Type </B></td>
                            <td width="21%"><B></B><%=typ%></td>
                        </tr>
                        <tr height="21">
                            <td width="12%"><B>Assigned To</B></td>
                            <td width="24%"><B></B><%= full%></td>
                            <td width="11%"><B>Created by </B></td>
                            <td width="22%"><B></B><%= full2%></td>
                            <td width="10%"><B>DateCreated </B></td>
                            <td width="21%"><B></B><%= dateString1%></td>
                        </tr>
                        <tr height="21">
                            <td width="12%"><B>DateModified </B></td>
                            <td width="24%"><B></B><%= dateString%></td>



                            <td width="11%"><B>Files Attached </B></td>
                                    <%
                                        int count1 = 1;
                                        String sql3 = "select count(*) from fileattach where issueid='" + no + "' ";
                                        pt2 = c.prepareStatement(sql3);
                                        rs8 = pt2.executeQuery();
                                        if (rs8 != null) {
                                            if (rs8.next()) {
                                                count1 = rs8.getInt(1);;
                                                logger.debug("count1" + count1);

                                            }
                                        }

                                        if (count1 > 0) {

                                            if (!url.equals("continental-corporation.com")) {
                                    %>
                            <td> <A	onclick="viewFileAttachForIssue('<%=no%>');" href="#"
                                    >ViewFiles(<%=count1%>)</A></td>
                                    <%} else {%>
                            <td> ViewFiles</td>
                            <%}%>
                            <%
                            } else {
                            %>
                            <td ><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000">No Files</font></td>
                                    <%
                                        }
                                    %>
                                    <%
                                        if (fver != null) {

                                    %>

                            <td width="10%"><B>Fix Version </B></td>
                            <td width="21%"><B></B><%=fver%></td>
                        </tr>

                        <%
                            }
                            String[][] crIdDetails = IssueDetails.getCRIDS(no);
                            if (crIdDetails.length == 0) {

                            } else {%>
                        <tr  style="font-weight: bold;" id="crrow" ><td>CR ID <a  onclick="export2Excel();" href="#">Export</a></td><td class="crnormal" onclick="openEdit();" style="cursor: pointer;color:  #3333cc;" title="Expand All">View CRID(<%=crIdDetails.length%>)</td><td  class="credit" colspan="2" onclick="openNormal();" title="Collapse All" style="cursor: pointer;">CR ID Description</td><td  class="credit" >Created On</td><td  class="credit" >Status</td><td  class="credit" >Created By</td></tr>
                        <%

                            for (int i = 0; i < crIdDetails.length; i++) {
                                if (crIdDetails[i][0] != null) {
                                    String key = crIdDetails[i][0].trim();
                                    String desc = crIdDetails[i][1].trim();
                                    String createdBy = crIdDetails[i][3].trim();
                                    String createdOn = crIdDetails[i][4].trim();
                                    String crstatus = crIdDetails[i][5].trim();

                                    if (i % 2 == 0) {%>
                        <tr class="credit"  style="background-color:#FFFFFF;"  >  
                            <%} else {%>
                        <tr class="credit" style="background-color:#C3D9FE;" >
                            <%}%>

                            <td ><%=key%></td>
                            <td  colspan="2"><%=desc%></td>
                            <td ><%=createdOn%></td>
                            <td ><%=crstatus%></td>
                            <td >
                                <%if (!createdBy.equalsIgnoreCase("Nil")) {%>
                                <%=member.get(Integer.valueOf(createdBy))%>
                                <%} else {%>
                                Nil
                                <% }%></td>
                        </tr>

                        <% }
                                }
                            }

                            if (category.equalsIgnoreCase("SAP Project")) {
                        %>

                        <%
                            if (phase != null) {
                        %>
                        <tr height="21">
                            <td width="12%"><b>Phase</b></td>
                            <td colspan="5" align="left"><B></B><%=phase%></td>
                        </tr>
                        <%
                            }
                            if (subphase != null) {
                        %>
                        <tr height="21">
                            <td width="12%"><b>Sub Phase</b></td>
                            <td colspan="5" align="left"><B></B><%=subphase%></td>
                        </tr>
                        <%
                            }
                            if (subsubphase != null) {
                        %>
                        <tr height="21">
                            <td width="12%"><b>Sub Sub Phase</b></td>
                            <td colspan="5" align="left"><B></B><%=subsubphase%></td>
                        </tr>
                        <%
                            }
                            if (subsubsubphase != null) {
                        %>
                        <tr height="21">
                            <td width="12%"><b>Sub Sub Sub Phase</b></td>
                            <td colspan="5" align="left"><B></B><%=subsubsubphase%></td>
                        </tr>
                        <%
                            }
                        %>

                        <%
                            }
                        %>

                        <tr height="21">
                            <td width="12%"><b>Subject</b></td>
                            <td colspan="5" align="left"><B></B><%=sub%></td>
                        </tr>
                        <tr height="21">
                            <td width="12%"><b>Description</b></td>
                            <td colspan="5" align="left"><B></B><%=des1%></td>
                        <tr height="21">
                            <td width="12%"><b>Root Cause</b></td>
                            <td colspan="5" align="left"><B></B><%=root_cau%></td>
                        </tr>

                        <tr height="21">
                            <td width="12%"><b>Expected Result</b></td>
                            <td colspan="5" align="left"><B></B><%=exp_res1%></td>
                        </tr>
                        <%
                            if (iss.equalsIgnoreCase("Closed")) {
                                if (rating != null) {
                        %>
                        <tr height="21">
                            <td width="12%"><b>User Rating</b></td>
                            <td colspan="5" align="left"><B></B><%= rating%></td>
                        </tr>
                        <%
                            }
                            if (feedback != null) {
                        %>
                        <tr height="21">
                            <td width="12%"><b>User Feedback</b></td>
                            <td colspan="5" align="left"><B></B><%= feedback%></td>
                        </tr>
                        <%
                                }
                            }
                        %>

                    </table>

                    <table width="100%" bgcolor="E8EEF7">

                        <tr>
                            <td><input type="hidden" name="issueId" id="issueId" value="<%=no%>" /></td>
                            <td><input type="hidden" name="customer" value="<%=cus%>" /></td>
                            <td><input type="hidden" name="project" id="project" value="<%=pro%>" /></td>
                            <td><input type="hidden" name="version" value="<%=ver%>" /></td>
                            <td><input type=hidden name="module" value="<%=mod%>" /></td>
                            <td><input type="hidden" name="type" value="<%=typ%>" /></td>
                            <td><input type="hidden" name="sev" value="<%=sev%>" /></td>
                            <td><input type="hidden" name="pri" id="priority" value="<%=pri%>" /></td>
                            <td><input type="hidden" name="creby" value="<%=creby%>" /></td>
                            <td><input type="hidden" name="creon" value="<%=dateString%>" /></td>
                            <td><input type="hidden" name="modon" value="<%= dateString1%>" /></td>
                            <td><input type="hidden" name="sub" id="sub" value="<%=sub%>"/></td>
                            <td><input type="hidden" name="fixversion" id="fversion" value="<%=fver%>" /></td>
                            <td><input type="hidden" name="status" id="status" value="<%=iss%>" /></td>
                            <td><input type="hidden" name="sorton" id="sorton" value="<%=sorton%>" /></td>
                            <td><input type="hidden" name="sort_method" id="sort_method" value="<%=sort_method%>" /></td>
                            <td><input type="hidden" name="userin" id="userin" value="<%=userin%>" /></td>

                        <tr>
                    </table>
                    <table width="100%" bgcolor="E8EEF7">
                        <tr height="21">
                            <td width="19%">
                                <div align="right"><font size="2"
                                                         face="Verdana, Arial, Helvetica, sans-serif"> </font></div>
                            </td>
                            <td width="30%" align=right><font size="2"
                                                              face="Verdana, Arial, Helvetica, sans-serif"> </font></td>
                            <td width="32%">
                                <div align="left"><font size="2"
                                                        face="Verdana, Arial, Helvetica, sans-serif"> </font></div>
                            </td>
                            <td width="19%"><font size="2"
                                                  face="Verdana, Arial, Helvetica, sans-serif"> </font></td>
                        </tr>
                        <tr>
                            <td width="19%" height="2">&nbsp;</td>
                            <td width="30%" height="2">&nbsp;</td>
                            <td width="32%" height="2">
                                <div align="left"><font size="2"
                                                        face="Verdana, Arial, Helvetica, sans-serif"> </font><font size="2"
                                                                                               face="Verdana, Arial, Helvetica, sans-serif"> </font></div>
                            </td>
                            <td width="19%" height="2"><font size="2"
                                                             face="Verdana, Arial, Helvetica, sans-serif"> </font></td>
                        </tr>
                        <tr>
                            <td width="100%"><font size="2"
                                                   face="Verdana, Arial, Helvetica, sans-serif"></font></td>
                        </tr>
                    </table>
                    <%

                        if (!url.equals("continental-corporation.com")) {
                    %>
                    <iframe
                        src="<%=request.getContextPath()%>/comments.jsp?issueId=<%= no%>"
                        scrolling="auto" frameborder="2" height="20%" width="100%"></iframe>
                        <%
                            }
                        %>
                        <%
                                                                }
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }

                            } catch (Exception e) {
                                //		out.println("Done Exception"+e);
                            } finally {
                               
                                if (result != null) {
                                    result.close();
                                }
                                if (result1 != null) {
                                    result1.close();
                                }
                                 if (rs != null) {
                                    rs.close();
                                }
                                if (rs3 != null) {
                                    rs3.close();
                                }
                                if (rs4 != null) {
                                    rs4.close();
                                }
                                if (rs5 != null) {
                                    rs5.close();
                                }
                                if (rs6 != null) {
                                    rs6.close();
                                }
                                if (rs7 != null) {
                                    rs7.close();
                                }
                                if (rs8 != null) {
                                    rs8.close();
                                }
                                if (pt2 != null) {
                                    pt2.close();
                                }
                                if (stmt != null) {
                                    stmt.close();
                                }
                                if (stmt1 != null) {
                                    stmt1.close();
                                }
                                if (stmt3 != null) {
                                    stmt3.close();
                                }
                                if (stmt4 != null) {
                                    stmt4.close();
                                }
                                if (stmt5 != null) {
                                    stmt5.close();
                                }
                                if (stmt6 != null) {
                                    stmt6.close();
                                }
                                if (stmt7 != null) {
                                    stmt7.close();
                                }
                                if (state != null) {
                                    state.close();
                                }
                                if (state1 != null) {
                                    state1.close();
                                }
                                if (c != null) {
                                    c.close();
                                }
                            }
                        %>
                </center>
            </div>
        </FORM>
        <div class="refissuepopupa chartarea" style="display: none;">
            <img src="<%=request.getContextPath()%>/images/file-progress.gif" style="margin:5% 20% auto;"/>
            <div>

            </div>
        </div>

        <script type="text/javascript">
            function trim(str) {
                while (str.charAt(str.length - 1) === " ")
                    str = str.substring(0, str.length - 1);
                while (str.charAt(0) === " ")
                    str = str.substring(1, str.length);
                return str;
            }
            $('.refer').click(function(e) {
                $('.refissuepopupa').dialog("open");
                $(".refissuepopupa").dialog({position: {my: "right center", at: "right bottom"}
                });
            });
            $(function() {
                $(".refissuepopupa").dialog({
                    autoOpen: false,
                    width: 600,
                    maxHeight: 500,
                    title: "Reference Issues",
                    position: {my: "left top", at: "right bottom", of: '.refer'},
                    show: {
                        effect: "slide",
                        direction: "right",
                        duration: 1000
                    },
                    hide: {
                        effect: "slide",
                        direction: "right",
                        duration: 1000
                    }
                });
            });
            $(".refer").click(function(e) {
                $(".refissuepopupa > img").show();
                $(".refissuepopupa > div").html("");
                $(".refissuepopupa").dialog("open");
                var issueId = $.trim($("#issueId").val());
                var sub = $.trim($("#sub").val());
                $.ajax({
                    url: '<%=request.getContextPath()%>/referenceIssues.jsp',
                    data: {issueId: issueId, sub: sub, random: Math.random(1, 10)},
                    async: true,
                    type: 'GET',
                    success: function(responseText, statusTxt, xhr) {
                        if (statusTxt === "success") {
                            var result = $.trim(responseText);
                            $(".refissuepopupa > div").html(result);
                            $(".refissuepopupa > img").hide();
                        }
                    }});
            });
            <%int uid = (Integer) session.getAttribute("userid_curr");
                if (uid == 212) {%>
            $(document).ready(function() {
                $('.refer').trigger('click');
            });
            <%}%>
        </script>
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
        $('#prev').click(function() {

            var userin = "<%=userin%>";
            var clickb = "prev";
            var prev;
            prev = callfunc(clickb);


            var text = "<%=request.getContextPath()%>/Issuesummaryview.jsp?issueid=" + trim(prev) + "&sorton=" + "<%=sorton%>" + "&sort_method=" + "<%=sort_method%>" + "&userin=" + "<%=userin%>" + "&project=" + "<%=pro%>" + "&version=" + "<%=fver%>" + "&priority=" + "<%=pri%>" + "&status=" + "<%=iss%>";
            window.location = text;

        });


        $('#next').click(function() {

            var userin = "<%=userin%>";
            var clickb = "next";
            var next;
            //next = callfun(sorton, sort_method, issueid, userin, clickb);
            next = callfunc(clickb);

            var text = "<%=request.getContextPath()%>/Issuesummaryview.jsp?issueid=" + trim(next) + "&sorton=" + "<%=sorton%>" + "&sort_method=" + "<%=sort_method%>" + "&userin=" + "<%=userin%>" + "&project=" + "<%=pro%>" + "&version=" + "<%=fver%>" + "&priority=" + "<%=pri%>" + "&status=" + "<%=iss%>";
            window.location = text;
        });
        $(document).ready(function() {



            var userin = "<%=userin%>";
            var position;



            position = callpos();


            if (position == "middle") {
                $(".nextBtn").removeClass("nextInactive");
                $(".prevBtn").removeClass("prevInactive");

            } else if (position == "last") {

                $(".prevBtn").removeClass("prevInactive");
                $(".nextBtn").addClass("nextInactive");

            } else if (position == "first") {

                $('#prev').addClass('prevInactive');

                $('#next').removeClass('nextInactive');

            } else if (position == "one") {
                $('#prev').addClass('prevInactive');
                $('#next').addClass('nextInactive');

            }


        });

        $(document).ready(function() {

            $("#prev").one('click', function(e) {
                e.preventDefault();
                e.stopPropagation();

                $(this).prop('disabled', true);
            });
            $("#next").one('click', function(e) {
                e.preventDefault();
                e.stopPropagation();

                $(this).prop('disabled', true);
            });
            
             function export2Excel()
            {
            window.open("<%=request.getContextPath()%>/exportCR.jsp?issue=" +  <%=no%> + ", '_blank');             
            }
        });
    </script>
    <style>
        .nextInactive,
        .nextInactive:hover,
        .prevInactive:hover,
        .prevInactive{
            opacity: 0.3;
            cursor:default;
            pointer-events: none;
        }
    </style>
</HTML>
<%@page import="java.util.ArrayList"%>
<%@page import="com.eminent.issue.formbean.IssueSearchFormBean"%>
<%@page import="java.util.List"%>
<%@page import="java.util.LinkedHashMap"%>
<%@page import="java.util.Map"%>
<%@ page import="org.apache.log4j.*"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.lang.String"%>
<%
    //Configuring log4j properties
    Logger logger = Logger.getLogger("UpdateIssueView1");
    String logoutcheck = (String) session.getAttribute("Name");

    if (logoutcheck == null) {
        logger.fatal("==============Session Expired===============");
%>
<jsp:forward page="../SessionExpired.jsp"></jsp:forward>
<%
    }

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
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
    <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/fileAttach.js?test=261020151625"></script>
    <script src="<%=request.getContextPath()%>/javaScript/jquery.js" type="text/javascript"></script>

    <script type="text/javascript" language="JavaScript">
        function calcCharLeft(theForm)
        {
            var mytext = theForm.description.value;
            var availChars = 450;
            if (mytext.length > availChars) {
                theForm.description.value = mytext.substring(0, availChars);
                theForm.description.focus();
                return false;
            }
            return true;
        }
        function textCounter(field, cntfield, maxlimit) {
            if (field.value.length > maxlimit)
            {
                field.value = field.value.substring(0, maxlimit);
                alert('Description size is exceeding 2000 characters');
            }
            else
                cntfield.value = maxlimit - field.value.length;
        }
        function printpost(post)
        {
            pp = window.open('profile.jsp?post_id=' + post, 'pp', 'size = maximize,location=no,statusbar=no,menubar=no,scrollbars=no width=900,height=400');
            pp.focus();
        }

        function fun(theForm)
        {
            if (theForm.comments.value.length <= 0)
            {
                alert('Enter your comments');
                theForm.comments.focus();
                return false;
            }

            if (theForm.comments.value.length > 2000)
            {
                alert('Comments Should not exceed 2000 Characters');
                theForm.comments.focus();
                return false;
            }

            return true;

        }
    </SCRIPT>

    <BODY>
        <FORM name="theForm" onSubmit='return fun(this)'
              action="modifyIssue.jsp" method="post"><%@ page
                import="java.sql.*"%> <%@ page
                    import="java.text.*"%> <%@ page
                        import="java.sql.Date"%> <%@ page
                            import="com.pack.*"%> <%@ page
                                import="pack.eminent.encryption.*"%> <%@ page
                                    language="java"%> <%@ include file="../header.jsp"%>
                                    <%String userin = request.getParameter("userin");%>
                                    <div align="center">
                                        <center>
                                            <table cellpadding="0" cellspacing="0" width="100%">
                                                <tr border="2" bgcolor="#C3D9FF">
                                                    <td border="1" align="left" width="70%"><font size="4"
                                                                                                  COLOR="#0000FF"><b>My Assignments </b></font><FONT SIZE="3"
                                                                                                           COLOR="#0000FF"> </FONT></td><%if (userin != null) {
                                                                                                                   if ((userin.equalsIgnoreCase("MyAssignment")) || (userin.equalsIgnoreCase("MyIssues")) || (userin.equalsIgnoreCase("statusWise")) || (userin.equalsIgnoreCase("MyDashboard")) || (userin.equalsIgnoreCase("MySearches")) || (userin.equalsIgnoreCase("MyViews"))) {%><td class="previous" align="right"><img id="prev"  class="prevBtn" src="<%=request.getContextPath()%>/images/prev.png"  style="cursor: pointer;" ></img>Prev Next<img id="next" class="nextBtn" src="<%=request.getContextPath()%>/images/next.png"  style="cursor: pointer;" ></img></td><%}
                                                        }%>
                                                <td colspan="3" align="CENTER" height="21"><font face="Tahoma"
                                                                                                 size="3" color="#0000FF"><%= "Updated Successfully"%></font></td>
                                                </tr>
                                            </table>
                                            <%

                                                
                                                String sorton = request.getParameter("sorton");
                                                String issueId = request.getParameter("issueid");
                                                String sort_method = request.getParameter("sort_method");

                                             

                                                String no = (String) request.getParameter("issueno");
                                                session.setAttribute("theissu", no);
                                            %> <br>

                                            <table align=left width="100%" bgcolor="C3D9FF">
                                                <tr>
                                                    <td><b>Issue Number <font color="#0000FF"><%= session.getAttribute("theissu")%></font></b></td>
                                                </tr>
                                            </table>
                                            <br>
                                            <BR>

                                            <table width="100%" bgcolor="E8EEF7">
                                                <jsp:useBean id="UpdateIssue" class="com.pack.UpdateIssueBean" />
                                                <jsp:useBean id="id" class="com.eminent.util.IssueDetails" />

                                                <%!
                                                    HashMap hm;
                                                                                                                                                                                                                                                                                                                                                                                                                            %>
                                                <%
                                                    List<IssueSearchFormBean> searchResults = new ArrayList<IssueSearchFormBean>();
                                                    Connection connection = null;
                                                    Statement state = null;
                                                    ResultSet resultset = null, result = null, rs2 = null, rs3 = null, rs4 = null, resultset1 = null, prj_count = null, rs5 = null;
                                                    PreparedStatement pt2 = null, pt1 = null, pt4 = null;

                                                    try {
                                                        connection = MakeConnection.getConnection();

                                                        String theissu = (String) session.getAttribute("theissu");
                                                        state = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                                                        resultset = state.executeQuery("SELECT CUSTOMER, PNAME AS PROJECT,amanager, dmanager, pmanager, found_version, VERSION AS FIX_VERSION, MODULE, PLATFORM,SEVERITY,PRIORITY,TYPE,createdby,assignedto,createdon,modifiedon, due_date, subject,description,comment1,rootcause,expected_result,estimated_time,SAP_ISSUE_TYPE FROM ISSUE I, PROJECT P, MODULES M WHERE I.PID = P.PID  AND MODULEID = MODULE_ID AND ISSUEID='" + theissu + "'");//CHANGED
                                                        if (resultset != null) {
                                                            while (resultset.next()) {
                                                                String cus = resultset.getString("customer");
                                                                String pro = resultset.getString("project");
                                                                String ver = resultset.getString("found_version");
                                                                String fix = resultset.getString("fix_version");
                                                                String mod = resultset.getString("module");
                                                                String pla = resultset.getString("platform");
                                                                String sev = resultset.getString("severity");
                                                                String pri = resultset.getString("priority");
                                                                String typ = resultset.getString("type");
                                                                int creby = resultset.getInt("createdby");

                                                                if (hm == null) {
                                                                    hm = UpdateIssue.showUsers(connection);
                                                                }

                                                                String createdBy = (String) hm.get(creby);

                                                                Date creon = resultset.getDate("createdon");
                                                                SimpleDateFormat sdf = new SimpleDateFormat("dd MMM yy");
                                                                String dateString = sdf.format(creon);
                                                                Date mdion = resultset.getDate("modifiedon");
                                                                SimpleDateFormat sdf1 = new SimpleDateFormat("dd MMM yy");
                                                                String dateString1 = sdf1.format(mdion);
                                                                String sub = resultset.getString("subject");
                                                                String des = resultset.getString("description");
                                                                String com1 = resultset.getString("comment1");
                                                                String root_cau = resultset.getString("rootcause");
                                                                String exp_res = resultset.getString("expected_result");

                                                                int len = des.length();
                                                                int index = 0;
                                                                String des1 = null, nextline = "\n", substr = null;
                                                                if (len >= 130) {
                                                                    des1 = des.substring(index, index + 130);
                                                                    len = len - 130;
                                                                    while ((len / 130) >= 1) {
                                                                        des1 = des1.concat(nextline);
                                                                        index = index + 130;
                                                                        substr = des.substring(index, index + 129);
                                                                        des1 = des1.concat(substr);
                                                                        len = len - 130;
                                                                    }
                                                                    index = index + 130;
                                                                    des1 = des1.concat(nextline);
                                                                    des1 = des1.concat(des.substring(index));
                                                                } else {
                                                                    des1 = des.substring(index);
                                                                }

                                                                searchResults = id.eTrackerIssueSearch(sub, theissu);
                                                                len = exp_res.length();
                                                                index = 0;
                                                                String exp_res1 = null;
                                                                if (len >= 130) {
                                                                    exp_res1 = exp_res.substring(index, index + 130);
                                                                    len = len - 130;
                                                                    while ((len / 130) >= 1) {
                                                                        exp_res1 = exp_res1.concat(nextline);
                                                                        index = index + 130;
                                                                        substr = exp_res.substring(index, index + 129);
                                                                        exp_res1 = exp_res1.concat(substr);
                                                                        len = len - 130;
                                                                    }
                                                                    index = index + 130;
                                                                    exp_res1 = exp_res1.concat(nextline);
                                                                    exp_res1 = exp_res1.concat(exp_res.substring(index));
                                                                } else {
                                                                    exp_res1 = exp_res.substring(index);
                                                                }

                                                %>
                                                <tr height="21">
                                                    <td width="15%"><B>Customer </B></td>
                                                    <td width="3%"><B></B></td>
                                                    <td height="21" width="25%" align="left" color="#bbbbbb"><%= cus%></td>
                                                    <td width="15%"><B>Product </B></td>
                                                    <td width="3%"><B></B></td>
                                                    <td height="21" width="25%"><%= pro%></td>
                                                    <td width="15%"><B>FoundVersion </B></td>
                                                    <td width="3%"><B></B></td>
                                                    <td height="21" width="25%"><%= ver%></td>
                                                </tr>
                                                <tr>
                                                    <td width="15%"><B>type </B></td>
                                                    <td width="3%"><B></B></td>
                                                    <td height="21" width="25%"><%= typ%></td>
                                                    <td width="15%"><B>Module </B></td>
                                                    <td width="3%"><B></B></td>
                                                    <td height="21" width="25%"><%= mod%></td>
                                                    <td width="15%"><B>Platform</B></td>
                                                    <td width="3%"><B></B></td>
                                                    <td height="21" width="25%"><%= pla%></td>
                                                </tr>
                                                <tr height="21">
                                                    <td width="15%"><B>Severity </B></td>
                                                    <td width="3%"><B></B></td>
                                                    <td height="21" width="25%"><%=sev%></td>
                                                    <td width="15%"><B>Priority</B></td>
                                                    <td width="3%"><B></B></td>
                                                    <td height="21" width="25%"><%=pri%></td>
                                                    <td width="10%"><B>IssueStatus</B></td>
                                                            <%
                                                                String sql1 = "select status from issuestatus where issueid='" + theissu + "' ";
                                                                pt1 = connection.prepareStatement(sql1, ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                                                                rs2 = pt1.executeQuery();
                                                                String sta = "";
                                                                if (rs2 != null) {
                                                                    while (rs2.next()) {
                                                                        sta = rs2.getString("status");
                                                                    }
                                                                }
                                                                if (rs2 != null) {
                                                                    rs2.close();
                                                                }
                                                                if (pt1 != null) {
                                                                    pt1.close();
                                                                }
                                                                //				int role	= (Integer)session.getAttribute("Role");
%>
                                                    <td width="3%"><B></B></td>
                                                    <td height="21" width="25%"><%= sta%></td>
                                                </tr>
                                                <tr>
                                                    <td width="15%"><B>DateCreated </B></td>
                                                    <td width="3%"><B></B></td>
                                                    <td height="21" width="25%"><%= dateString%></td>
                                                    <td width="15%"><B>DateModified </B></td>
                                                    <td width="3%"><B></B></td>
                                                    <td height="21" width="25%"><%= dateString1%></td>
                                                    <td width="15%"><B>CreatedBy </B></td>
                                                    <td width="3%"><B></B></td>
                                                    <td height="21" width="25%"><%= createdBy%></td>
                                                </tr>
                                                <tr>
                                                    <%

                                                        String sql2 = "select assignedto from issue where issueid='" + theissu + "' ";
                                                        pt4 = connection.prepareStatement(sql2);
                                                        rs4 = pt4.executeQuery();
                                                        //int assi=0;
                                                        String assi = null;
                                                        if (rs4 != null) {
                                                            while (rs4.next()) {
                                                                //		assi = rs4.getInt("assignedto");
                                                                assi = (String) rs4.getString("assignedto");
                                                            }
                                                        }
                                                        if (rs4 != null) {
                                                            rs4.close();
                                                        }
                                                        if (pt4 != null) {
                                                            pt4.close();
                                                        }
                                                        String full = null, f1 = null, l1 = null;
                                                        state = connection.createStatement();
                                                        result = state.executeQuery("SELECT firstname,lastname FROM users where userid=" + assi);//CORRECT
                                                        if (result.next()) {
                                                            f1 = result.getString("firstname");
                                                            l1 = result.getString("lastname");
                                                            full = f1 + " " + l1;
                                                        }
                                                    %>
                                                    <td width="10%"><B>AssignedTo</B></td>
                                                    <td width="3%"><B></B></td>
                                                    <td height="21" width="25%"><%= full%></td>


                                                    <td width="15%" colspan="2"><B>Files Attached </B></td>


                                                    <%
                                                        int count1 = 1;
                                                        String sql3 = "select fileid,filename from fileattach where issueid='" + theissu + "' ";
                                                        pt2 = connection.prepareStatement(sql3);
                                                        rs3 = pt2.executeQuery();
                                                        if (rs3 != null) {
                                                            if (rs3.next()) {
                                                                count1++;
                                                                logger.debug("count1" + count1);
                                                    %>
                                                    <td width="8%" id="filesIssue"><A
                                                            onclick="viewFileAttachForIssue('<%=theissu%>');" href="#"
                                                            >ViewFiles</A></td>
                                                            <%					}
                                                                }
                                                                if (rs3 != null) {
                                                                    rs3.close();
                                                                }
                                                                if (pt2 != null) {
                                                                    pt2.close();
                                                                }
                                                                if (count1 == 1) {
                                                            %>
                                                    <td width="8%" id="filesIssue"><font face="Verdana, Arial, Helvetica, sans-serif"
                                                                                         size="1">No Files</font></td>
                                                            <%
                                                                }
                                                            %>

                                                    <td width="15%"><B>Fix Version</B></td>
                                                    <td width="3%"><B></B></td>
                                                    <td width="25%"><%= fix%></td>
                                                </tr>
                                            </table>

                                            <table width="100%" border="0" bgcolor="#E8EEF7" cellpadding="2">
                                                <tr>
                                                    <td height="21" width="12%"><b>Subject</b></td>
                                                    <td height="21" width="100%" align="left"><B>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</B><%=sub%></td>
                                                </tr>

                                                <tr>
                                                    <td height="21" width="12%"><b>Description</b></td>
                                                    <td height="21" width="100%" align="left"><B>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</B><%=des1%></td>
                                                </tr>

                                                <tr height="21">
                                                    <td width="12%"><b>Root Cause</b></td>
                                                    <td width="100%" align="left"><B></B><%=root_cau%></td>
                                                </tr>

                                                <tr height="21">
                                                    <td width="12%"><b>Expected Result</b></td>
                                                    <td width="100%" align="left"><B></B><%=exp_res1%></td>
                                                </tr>
                                            </table>

                                            <table width="100%" bgcolor="E8EEF7">

                                                <tr>

                                                    <td><input type="hidden" name="customer" value="<%=cus%>" /></td>
                                                    <td><input type="hidden" name="project" id="project" value="<%=pro%>" /></td>
                                                    <td><input type="hidden" name="version" value="<%=ver%>" /></td>
                                                    <td><input type="hidden" name="oldfixversion" id="fversion" value="<%=fix%>" /></td>
                                                    <td><input type="hidden" name="module" value="<%=mod%>" /></td>
                                                    <td><input type="hidden" name="platform" value="<%=pla%>" /></td>
                                                    <td><input type="hidden" name="type" value="<%=typ%>" /></td>
                                                    <td><input type="hidden" name="sev" value="<%=sev%>" /></td>
                                                    <td><input type="hidden" name="pri" id="priority" value="<%=pri%>" /></td>
                                                    <td><input type="hidden" name="creby" value="<%=creby%>" /></td>
                                                    <td><input type="hidden" name="creon" value="<%=dateString%>" /></td>
                                                    <td><input type="hidden" name="modon" value="<%= dateString1%>" /></td>
                                                    <td><input type="hidden" name="sub"
                                                               value="<%=StringUtil.encodeHtmlTag(sub)%>" /></td>
                                                    <td><input type="hidden" name="des"
                                                               value="<%=StringUtil.encodeHtmlTag(des1)%>" /></td>
                                                    <td><input type="hidden" name="com1"
                                                               value="<%=StringUtil.encodeHtmlTag(com1)%>" /></td>
                                                    <td><input type="hidden" name="issu" value="<%=theissu%>" /></td>
                                                    <td><input type=hidden name="rootcause"
                                                               value="<%=StringUtil.encodeHtmlTag(root_cau)%>" /></td>
                                                    <td><input type=hidden name="expected_result"
                                                               value="<%=StringUtil.encodeHtmlTag(exp_res1)%>" /></td>
                                                     <td><input type="hidden" name="status" id="status" value="<%=sta%>" /></td>
                                                    
                                                    <td><input type="hidden" name="sorton" id="sorton" value="<%=sorton%>" /></td>
                                                    <td><input type="hidden" name="sort_method" id="sort_method" value="<%=sort_method%>" /></td>
                                                    <td><input type="hidden" name="userin" id="userin" value="<%=userin%>" /></td>
                                                <tr>
                                            </table>
                                            <iframe
                                                src="../comments.jsp?issueid=<%= session.getAttribute("theissu")%>"
                                                scrolling="auto" frameborder="2" height="45%" width="100%"></iframe></center>
                                    </div>
                                </FORM>
                                <%

                                            }
                                        }
                                        if (resultset != null) {
                                            resultset.close();
                                        }
                                        if (state != null) {
                                            state.close();
                                        }

                                    } catch (Exception e) {
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


                            </BODY>
                            <%-- Edit  by sowjanya--%>
                            <script type="text/javascript">
                                $('#prev').click(function() {
                                    
                                    var userin = "<%=userin%>";
                                  
                                    var clickb = "prev";
                                    var prev;
                                    prev = callfunc(clickb);

                                    var text = "<%=request.getContextPath()%>/MyAssignment/UpdateIssueview.jsp?issueid=" + prev + "&sorton=" + "<%=sorton%>" + "&sort_method=" + "<%=sort_method%>" + "&userin=" + "<%=userin%>";
                                    window.location = text;

                                });


                                $('#next').click(function() {
                                   
                                    var userin = "<%=userin%>";
                                    
                                    var clickb = "next";
                                    var next;
                                    next = callfunc(clickb);

                                    var text = "<%=request.getContextPath()%>/MyAssignment/UpdateIssueview.jsp?issueid=" + next + "&sorton=" + "<%=sorton%>" + "&sort_method=" + "<%=sort_method%>" + "&userin=" + "<%=userin%>";
                                    window.location = text;
                                });
                                $(document).ready(function() {
                                    var sorton = "<%=sorton%>";
                                    
                                   
                                 


                                    var position;
                                    console.log("length of sorton in updateIssueview:" );
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
                            <%-- Edit end by sowjanya--%>
                        </HTML>

<%@page import="com.eminent.tags.Tags"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Map"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%
    String logoutcheck = (String) session.getAttribute("Name");
    if (logoutcheck == null) {
%>
<jsp:forward page="../SessionExpired.jsp"></jsp:forward>
<%
    }
%>
<HTML>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
    <title>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS
        Solution</title>
    <META NAME="Generator" CONTENT="EditPlus">
    <META NAME="Author" CONTENT="">
    <META NAME="Keywords" CONTENT="">
    <META NAME="Description" CONTENT="">
    <LINK title=STYLE href="<%= request.getContextPath()%>/eminentech support files/main_ie.css?test=261020151225" type="text/css" rel="STYLESHEET">
    <script src="<%=request.getContextPath()%>/javaScript/XMLHttpRequest.js" type="text/javascript"></script>
    <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/fileAttach.js"></script>
    <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/tooltip.js"></script>
    <script src="<%=request.getContextPath()%>/javaScript/jquery.js" type="text/javascript"></script>
    <LINK title=STYLE href="<%= request.getContextPath()%>/multiple-select.css" type="text/css" rel="STYLESHEET">

    <script type="text/javascript">
        function showPrint(issueid) {
            window.open("<%=request.getContextPath()%>/viewIssueDetails.jsp?issueid=" + issueid);
        }


    </script>
</HEAD>
<script language="JavaScript">
    function printpost(post)
    {
        pp = window.open('profile.jsp?post_id=' + post, 'pp', 'size = maximize,location=no,statusbar=no,menubar=no,scrollbars=no width=900,height=400');
        pp.focus();
    }
</script>
<style fprolloverstyle>
    A:hover {
        color: #FF0000;
        font-weight: bold
    }
</style>
<BODY BGCOLOR="#FFFFFF">
    <%@ page import="java.sql.*,pack.eminent.encryption.*,java.lang.String, com.pack.StringUtil"%>
    <%@ page import="org.apache.log4j.*,com.eminent.util.*, dashboard.CheckDate"%>
    <%@ page import="java.text.*,java.util.HashMap, com.eminent.util.FlagFinder"%>
    <%@ include file="../header.jsp"%>

    <div align="center">
        <jsp:useBean id="tagc" class="com.eminent.tags.TagController"/>
        <center><jsp:useBean id="MyIssue" class="com.pack.MyIssueBean" />
            <%
                String team = (String) session.getAttribute("team");
                  String mail = (String) session.getAttribute("theName");
            String url = null;
            if (mail != null) {
                url = mail.substring(mail.indexOf("@") + 1, mail.length());
            }
            %>

            <%!
                String query_id = null;
                String des = null, query_string = null;
                int rowcount, age, absolte;
                String IssuedayHistory = "no";
                String issueRating = "no";
                List<String> allissueNo = new ArrayList<String>();
                                                                                                                                                                                                                                                                                        %> 

            <table cellpadding="0" cellspacing="0" width="100%">
                <tr border="2" bgcolor="#C3D9FF">
                    <td border="1" align="left" ><font size="4"
                                                       COLOR="#0000FF"><b>My Views</b></font> <FONT SIZE="3"
                                                                     COLOR="#0000FF"></FONT></td>

                    <td style="float: right;margin-right: 10px;min-width: 200px;">
                        <div>
                            <label><B>Select Tags :</B></label>
                            <span class="selectTag">
                                <select  name="tagnames" id="tagnames" >
                                    <option value="" selected="">Select</option>
                                    <%
                                        tagc.getAllTagsByUser(request);
                                        if (tagc.getTagList() == null || tagc.getTagList().isEmpty()) {
                                        } else {
                                            for (Tags tag : tagc.getTagList()) {

                                    %>
                                    <option value="<%=tag.getTagId()%>" ><%=tag.getTagName()%></option>
                                    <%
                                            }
                                        }

                                    %> 
                                </select> </span>
                            <span style="color: blue;font-weight: bold;cursor: pointer;position: " onclick="addTag();">AddTag</span>
                        </div>
                    </td>
                    <td  border="1" align="right"><font size="2"
                                                        face="Verdana, Arial, Helvetica, sans-serif">Export to <a href="javascript:void(0)" onclick="ExportToExcel()" >Excel</a></font></td>

                </tr>
            </table>
            <%                    session.setAttribute("forwardpage", "/MyQuery/MyQueryRun.jsp");
                int id = 0;
                String issueid = "";
                String subject = "";
                String project = "";
                String module = "";
                String severity = "";
                String priority = "";
                String assignedTo = "";
                String rating = "";
                String feedback = "";

                Logger logger = Logger.getLogger("IssueSummaryView");

                Connection connection = null;
                ResultSet rs = null;
                Statement st = null;

                try {
                    connection = MakeConnection.getConnection();
                    query_id = request.getParameter("query_id");

                    if (query_id == null) {

                    } else {
                        MyIssue.ReQueryRequest(connection, query_id, request);
                    }

                    query_string = (String) session.getAttribute("IssueSummaryQuery");
                    IssuedayHistory = (String) session.getAttribute("IssuedayHistory");
                    issueRating = (String) session.getAttribute("issueRating");
                    if (IssuedayHistory == null) {
                        IssuedayHistory = "no";
                    }

                    HashMap<Integer, String> hm = MyIssue.getUser(connection);
                    if (IssuedayHistory.equalsIgnoreCase("yes")) {

                        Map<String, List<IssueHistory>> issuesHistoryMap = IssueDetails.checkIssueHistory(query_string, hm);

            %>


            <span style="float: left"> This list shows <b>1 </b>-<b> <%=issuesHistoryMap.size()%>  </b> of <b><%=issuesHistoryMap.size()%> </b>  issues  history search by you .</span>
            <br/> <TABLE width="100%" id="searchTable" class="tablesorter" style="border: 1px solid black;border-collapse: collapse;">
                <% int maxlenght = 1;
                    for (Map.Entry<String, List<IssueHistory>> entrySet : issuesHistoryMap.entrySet()) {
                        if (entrySet.getValue().size() > maxlenght) {
                            maxlenght = entrySet.getValue().size();
                        }
                    }%>

                <tr>
                    <th style="border: 1px solid #C3D9FF;color: #191910;font-size: 13px;text-align: center">Issue No</th>
                    <th colspan="<%=maxlenght%>" style="border: 1px solid #C3D9FF;color: #191910;font-size: 13px;">Day History</th>
                </tr>
                <%   for (Map.Entry<String, List<IssueHistory>> entrySet : issuesHistoryMap.entrySet()) {%>

                <tr style="border: 1px solid #C3D9FF;">
                    <td rowspan="2" style="border:2px solid #C3D9FF;">
                        <A HREF="javascript:showPrint('<%=entrySet.getKey()%>')">
                            <font face="Verdana, Arial, Helvetica, sans-serif" size="1"
                                  color="#0033FF"> <%=entrySet.getKey()%> </font></A></td>



                    <% for (IssueHistory ish : entrySet.getValue()) {%>
                    <td style="border: 2px solid #C3D9FF;"><%=ish.getUserName()%></td>
                    <%}%>
                </tr>
                <tr style="height: 21px"> 
                    <% for (IssueHistory ish : entrySet.getValue()) {%>
                    <td style="border: 1px solid #C3D9FF; min-width: 130px;"><span style="font-weight: bold;font-size: 13px;"><%=ish.getDays()%></span> <span>(<%=ish.getStatus()%>)</span></td>

                    <%}%>

                </tr>

                <%  }    %>  
            </table>
            <% } else {

                String status = "";
                String s1 = "S1- Fatal";
                String s2 = "S2- Critical";
                String s3 = "S3- Important";
                String s4 = "S4- Minor";
                if (connection != null) {
                    logger.info("Inside Pagination");

                    des = request.getParameter("desc");

                    //String desc = request.getParameter("desc");
                    logger.info("here" + query_id);

                    if (query_id == null) {
                        logger.info("Getting Query from session");
                        query_id = (String) session.getAttribute("query_id");
                        des = (String) session.getAttribute("des");
                    }

                    session.setAttribute("query_id", query_id);
                    session.setAttribute("des", des);

                    logger.info("Query id from session" + query_id);
                    absolte = 0;

                    st = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                    rs = st.executeQuery(query_string);
                    rs.last();
                    rowcount = rs.getRow();
                    if (rs != null) {
            %>

            <br>
            <table width="100%">
                <tr height="10">

                    <td class="pager" width="65%">
                        <span class="pagedisplay">

                            Display total:<b><%=rowcount%></b>  Issues 

                        </span>
                    </td>


                    <td width="20%">
                        <div><input type="button" id="addIssueToTag" value="Add Issue In Tag"><span id="errormsg"></span></div>

                    </td>

                    <TD align="right" width="25">Severity</td>
                    <TD width="1%" bgcolor="#FF0000">S1</TD>
                    <TD width="1%" bgcolor="#DF7401">S2</TD>
                    <TD width="1%" bgcolor="#F7FE2E">S3</TD>
                    <TD width="1%" bgcolor="#04B45F">S4</TD>
                </tr>
            </table>
            <br>

            <TABLE width="100%"  id="searchTable" class="tablesorter">
                <thead>
                    <tr style="background-color:#C3D9FF">
                        <th width="1%" class="filter-false" TITLE="Severity"><font><b>S</b></font></th>
                        <th width="11%" ><font><b>Issue No</b></font></th>
                        <th width="3%" class="filter-false"><font><b>P</b></font></th>
                        <th width="10%" class="filter-select filter-match" data-placeholder="Select a Project"><font><b>Project</b></font></th>
                        <th width="7%" class="filter-select filter-match" data-placeholder="Select a Module"><font><b>Module</b></font></th>
                        <th width="25%" ><font><b>Subject</b></font></th>
                        <th width="12%" class="filter-select filter-match" data-placeholder="Select a status" ><font><b>Status</b></font></th>
                        <th width="8%" class="filter-false"><font><b>Due Date</b></font></th>
                        <th width="13%" class="filter-select filter-match" data-placeholder="Select Assigned To"><font><b>Assigned To</b></font></th>
                        <th width="9%" class="filter-false"><font><b>Refer</b></font></th>
                        <th width="2%" TITLE="In Days" class="header sorter-digit" data-placeholder="Try >10"><font><b>Age</b></font></th>
                    </tr>
                </thead> <tbody>
                    <% rs.beforeFirst();
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

                        if (absolte != 0) {
                            rs.absolute(absolte);
                        } else {
                            rs.beforeFirst();
                        }
                        int i = 0;
                        while (rs.next()) {
                            issueid = rs.getString("issueid");
                            subject = rs.getString("subject");
                            if (subject.length() > 42) {
                                subject = subject.substring(0, 42) + "...";
                            }
                            project = rs.getString("project");
                            module = rs.getString("module");
                            String fullModule = module;
                            if (module.length() > 10) {
                                module = module.substring(0, 10) + "...";
                            }
                            severity = rs.getString("severity");
                            priority = rs.getString("priority");
                            String p = "NA";
                            if (priority != null) {
                                p = priority.substring(0, 2);
                            }
                            assignedTo = rs.getString("assignedto");
                            status = rs.getString("status");
                            String type = rs.getString("type");

                            int typ = rs.getInt("createdby");
                            String createdBy = "";
                            if (typ != 0) {
                                createdBy = (String) hm.get(new Integer(typ));
                            }
                            Date modifiedOn = rs.getDate("modifiedon");

                            SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yy");
                            String dateString1 = sdf.format(modifiedOn);

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
                            rating = rs.getString("rating");
                            age = GetAge.getIssueAge(createdon, status, dateString1);
                            int lastAsigneeAge = 1;
                            if (lastAsigneeAgeList.containsKey(issueid)) {
                                lastAsigneeAge = lastAsigneeAgeList.get(issueid);
                            }
                            if (lastAsigneeAge == 1) {
                                lastAsigneeAge = age;
                            }
                            if (lastAsigneeAge == 0) {
                                lastAsigneeAge = lastAsigneeAge + 1;
                            }
                            if (assignedTo != null) {
                                id = Integer.parseInt(assignedTo);
                            }
                            assignedTo = hm.get(id);
                    %>

                    <%
                        if ((i % 2) != 0) {
                    %>
                    <tr class="zebraline" height="22">
                        <%
                        } else {
                        %>

                    <tr class="zebralinealter" height="22">
                        <%
                            }
                        %>
                        <% if (severity.equals(s1)) {%>
                        <td  style="background-color: #FF0000;"    ></td>
                        <%} else if (severity.equals(s2)) {%>
                        <td style="background-color: #DF7401;" ></td>
                        <%} else if (severity.equals(s3)) {%>
                        <td style="background-color: #F7FE2E;"   ></td>
                        <%} else if (severity.equals(s4)) {%>
                        <td style="background-color: #04B45F;"   ></td>
                        <%}%>
                <input type="hidden" id="sorton" name="sorton"/>
                <input type="hidden" id="sort_method" name="sort_method"/>
                <td class="background"   TITLE="<%= type%>"><input type="checkbox" name="check[]" class="checkIssue"  value="<%=issueid%>" id="notchecked" />
                    <%--<A HREF="<%=request.getContextPath()%>/Issuesummaryview.jsp?issueid=<%=issueid%>">
                        <font face="Verdana, Arial, Helvetica, sans-serif" size="1"
                              color="#0033FF">--%><A href="javascript:callissue('<%=issueid%>')" style="visibility: visible">
                        <%=issueid%> </font></A></td>
                <td class="background"  ><font face="Verdana, Arial, Helvetica, sans-serif"
                                               size="1" color="#000000"><%= p%></font></td>
                <td class="background"  ><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= project%></font>

                </td>
                <td class="background"   title="<%=fullModule%>"><font	face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= module%></font></td>
                        <%
                            if (FlagFinder.isDescription(query_id) == true) {
                                String desc = rs.getString("description");
                        %>
                <td class="background"   id="<%=issueid%>tab" onmouseover="xstooltip_show('<%=issueid%>', '<%=issueid%>tab', 289, 49);" onmouseout="xstooltip_hide('<%=issueid%>');" >
                    <font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= subject%></font><div class="issuetooltip" id="<%=issueid%>"><%= desc%></div></td>
                        <%
                        } else {

                        %>
                <td class="background"  ><font
                        face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= subject%></font></td>
                        <%
                            }


                        %>
                        <%        String color = "";
                            if (status.equalsIgnoreCase("Closed")) {
                                if (rating != null) {
                                    if (rating.equalsIgnoreCase("Excellent")) {
                                        color = "#336600";

                                    } else if (rating.equalsIgnoreCase("Good")) {
                                        color = "#33CC66";

                                    } else if (rating.equalsIgnoreCase("Average")) {
                                        color = "#CC9900";

                                    } else if (rating.equalsIgnoreCase("Need Improvement")) {
                                        color = "#CC0000";

                                    }
                                }

                            }
                            if (feedback == null) {
                                feedback = "";
                            }
                            logger.info("Closed Color" + color);
                        %>
                <td class="background" style="background-color: <%=color%>"   title="<%=feedback%>" onclick="showPrint('<%=issueid%>');" style="cursor: pointer;"><font
                        face="Verdana, Arial, Helvetica, sans-serif" size="1" ><%= status%></font>
                </td>
                <td class="background"   title="Last Modified On <%= dateString1%>">
                    <%
                        if ((status != null) && (!status.equalsIgnoreCase("Closed")) && (!dueDate.equalsIgnoreCase("NA")) && CheckDate.getFlag(dueDate) == true) {
                    %> <font
                        face="Verdana, Arial, Helvetica, sans-serif" size="1" color="RED"><%= dueDate%></font>
                        <%
                        } else {
                        %>
                    <font face="Verdana, Arial, Helvetica, sans-serif" size="1"
                          color="#000000"><%= dueDate%></font>

                    <%
                        }
                    %>

                </td>
                <td class="background"   title="Created By <%= createdBy%>"><font
                        face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= assignedTo%></font>
                </td>
                <%
                    int count1 = 0;
                    if (fileCountList.containsKey(issueid)) {
                        count1 = fileCountList.get(issueid);
                    }
                    if (count1 > 0) {
                %>
                <td class="background"  ><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"> <A onclick="viewFileAttachForIssue('<%=issueid%>');" href="#"
                                                                                                                         >ViewFiles(<%=count1%>)</A></font></td>
                            <%
                            } else {
                            %>
                <td class="background"  ><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000">No Files</font></td>
                        <%
                            }
                        %>
                <td class="background"  align="center" title="<%=lastAsigneeAge%>"><font
                        face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= age%></font>
                </td>
                </tr>
                <%
                    }
                %>
                </tbody>
                <!--                <tfoot>
                                    <tr>
                                        <td colspan="10">
                                            <div class="pager"><nav class="left"> # per page: <a href="#">10</a> | <a href="#" >25</a> | <a href="#">50</a>|<a href="#" class="current">100</a>
                                                </nav> 
                                                <nav class="right"> <span class="prev"> <img
                                                            src="<%=request.getContextPath()%>/images/prev.png" /> Prev&nbsp; </span> <span
                                                        class="pagecount"></span> &nbsp;<span class="next">Next <img
                                                            src="<%=request.getContextPath()%>/images/next.png" /> </span> </nav></div>
                                        </td>
                                    </tr>
                                </tfoot>-->
            </TABLE>
            <%

                            }
                        }
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                    logger.error(e.getMessage());
                } finally {
                    if (rs != null) {
                        rs.close();
                    }
                    if (connection != null) {
                        connection.close();
                    }
                    if (st != null) {
                        st.close();
                    }
                    session.removeAttribute("IssuedayHistory");
                }%>
        </center>
    </div>
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
    <div id="overlay"></div>
    <div id="tagpopup" class="popup">
        <h3 class="popupHeading">Add Tag</h3>
        <div>
            <div class="inputDiv">  <div style="color:red;" id="errortagmsg"></div>
                <div style="color:green;" id="tagmsg"></div>
            </div>
            <br/>
            <div class="inputDiv">
                <label style="text-align: left;float: left;width: 100px;">Enter Tag Name:</label>  <span><input type="text" name="tag" id="tag" size="25" maxlength="50" style="width: 200px;height: 21px"/></span> 
            </div>
            <div class="clear"></div>
            <div  class="inputDiv">
                <label style="text-align: left;float: left;width: 100px;">Tag Type:</label> 
                <span><Select id="tagType" style="width: 200px;height: 21px">
                        <option value="0">Individual tag</option>
                        <option  value="1">Common tag</option>
                    </select>
                </span>
            </div>
            <div  class="inputDiv" >
                <label style="text-align: left;float: left;width: 100px;">Select user:</label> 
                <Select id="userdeshBorad" multiple="">
                    <%
                        HashMap<Integer, String> deshBordUser = tagc.getAllDeshBoradUser();
                        if (deshBordUser == null || deshBordUser.isEmpty()) {

                        } else {
                            for (Map.Entry<Integer, String> entrySet : deshBordUser.entrySet()) {


                    %>
                    <option value="<%=entrySet.getKey()%>"><%=entrySet.getValue()%></option>
                    <%}
                        }%>
                </select>

            </div>
            <div  class="inputDiv">
                <input type="hidden" name="action" value="Create"/>
                <input type="button" value="Create Tag" id="createTag" style="width: 100px"/>
                <button class="custom-popup-close" onclick="javascript:closeTag();" type="button">close</button>
            </div>
        </div>
    </div>
<LINK title=STYLE href="<%= request.getContextPath()%>/eminentech support files/main_ie.css?test=261020151225" type="text/css" rel="STYLESHEET">
<script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/fileAttach.js?test=261020151625"></script>
<script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/tooltip.js"></script>
<script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/checkSubmit.js"></script>
<SCRIPT type="text/javascript" 	src="https://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
<script src="<%= request.getContextPath()%>/javaScript/jquery.multiple.select.js"></script>

<SCRIPT type="text/javascript" src="<%=request.getContextPath()%>/javaScript/jquery.jscroll.js"></SCRIPT>

<script src="<%=request.getContextPath()%>/javaScript/jquery.tablesorter1.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/javaScript/jquery.tablesorter.widgets.js" type="text/javascript"></script>    
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/theme.blue1.css?test=3">

<script type="text/javascript">
                    $('#userdeshBorad').multipleSelect({
                        filter: true,
                        maxHeight: 150,
                        width: 200
                    });

                    $(document).ready(function()
                    {
                        // call the tablesorter plugin
                        $(".tablesorter").tablesorter({
                            theme: 'blue',
                            // hidden filter input/selects will resize the columns, so try to minimize the change
                            widthFixed: true,
                            // initialize zebra striping and filter widgets
                            widgets: ["zebra", "filter"],
                            headers: {7: {// <-- replace 6 with the zero-based index of your column
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
                                },
                                filter_formatter: {
                                    8: function($cell, indx) {
                                        return $.tablesorter.filterFormatter.select2($cell, indx, {
                                            match: false // exact match only
                                        });
                                    }
                                }
                            }

                        });
                    });
                    function ExportToExcel() {
                        var headerSortDown = $('.tablesorter-headerAsc').text();
                        var headerSortUp = $(".tablesorter-headerDesc").text();
                        var issueHistory = "<%=IssuedayHistory%>";
                        var issueRating = "<%=issueRating%>";

                        //   var headerSortDown = $(".headerSortDown").text();
                        // var headerSortUp = $(".headerSortUp").text();
                        window.open("<%=request.getContextPath()%>/IssueSummary/exportexcelIssueSummary.jsp?headerSortUp=" + headerSortUp + "&headerSortDown=" + headerSortDown + "&issueHistory=" + issueHistory + "&issueRating=" + issueRating, '_blank');
                    }

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
</style>
</BODY>
<script type="text/javascript">
    function callissue(issueid) {
        var team = '<%=team%>';
         var mail = '<%=url%>';
        var d = new Date();
        var n = d.getHours();
        var sorton;
        var sort_method;
        var headerSortDown = $('.tablesorter-headerAsc').text();

        var headerSortUp = $(".tablesorter-headerDesc").text();

        if (headerSortDown.length > 0) {
            sorton = headerSortDown;
            sort_method = "headerSortDown";
        } else if (headerSortUp.length > 0) {
            sorton = headerSortUp;
            sort_method = "headerSortUp";
        }

        document.getElementById("sorton").value = sorton;
        document.getElementById("sort_method").value = sort_method;

         if (mail === 'eminentlabs.net') {
            if (n > 8 && n < 18) {
                var result;
                $.ajax({url: '<%=request.getContextPath()%>/admin/project/checkPlannedSeq.jsp',
                    data: {issueid: issueid, random: Math.random(1, 10)},
                    async: true,
                    type: 'GET',
                    success: function(data) {
                        result = $.trim(data);
                    }, complete: function() {
                        if (result === '') {
                            location.href = '<%=request.getContextPath()%>/Issuesummaryview.jsp?issueid=' + issueid + '&sorton=' + sorton + '&sort_method=' + sort_method + '&userin=MyViews&planSeq=yes';
                        } else {
                            alert(result);
                        }
                    }
                });
            } else {
                location.href = '<%=request.getContextPath()%>/Issuesummaryview.jsp?issueid=' + issueid + '&sorton=' + sorton + '&sort_method=' + sort_method + '&userin=MyViews&planSeq=yes';

            }
        } else {
            location.href = '<%=request.getContextPath()%>/Issuesummaryview.jsp?issueid=' + issueid + '&sorton=' + sorton + '&sort_method=' + sort_method + '&userin=MyViews&planSeq=yes';

        }
    }

</script>
<script type="text/javascript">


    function addTag() {
        $('#overlay').attr('height', $(window).height());
        $('#overlay').fadeIn('fast', 'swing');
        $('#tagpopup').fadeIn('fast', 'swing');
        $('#tag').val('');
        $("span.error2").remove();
        enableTagSubmit();
    }
    function closeTag() {
        $('#overlay').fadeOut('fast', 'swing');
        $('#tagpopup').fadeOut('fast', 'swing');
        getAllTag();
    }

    $('#createTag').click(function() {

        $("span.error2").remove();
        var tag = $.trim($('#tag').val());
        var tagType = $.trim($("#tagType").val());
        var user = [];
        $("#userdeshBorad option:selected").each(function() {
            user.push($(this).val());
        });
        var count = 0;
        disableTagSubmit();
        if (tag.length == 0) {
            $("<span class='error2'>Please enter tag name </span>").insertAfter("#errortagmsg");
            $("#tagnames").focus();
            count = 1;
        } else if (tag.length > 20) {
            $("<span class='error2'>Please enter tag name less than 20 characters</span>").insertAfter("#errortagmsg");
            $("#tagnames").focus();
            count = 1;
        } else if (tagType == 0) {
            if (user.length > 0) {
                $("<span class='error2'>You can not select user for this tag type</span>").insertAfter("#errortagmsg");
                $("#userdeshBorad").focus();
                count = 1;
            }
        } else if (tagType == 1) {
            var v = user.length;
            if (user.length === 0) {
                $("<span class='error2'>Please select user for this tag type</span>").insertAfter("#errortagmsg");
                $("#userdeshBorad").focus();
                count = 1;
            }
        }

        if (count === 0) {
            $.ajax({
                url: '<%=request.getContextPath()%>/admin/project/checkuniqueTag.jsp',
                data: {tag: tag, tagType: tagType, random: Math.random(1, 10)},
                async: true,
                type: 'GET',
                success: function(responseText, statusTxt, xhr) {
                    if (statusTxt === "success") {

                        var result = $.trim(responseText);
                        if (result == "true") {
                            createTag();
                        } else if (result == "false") {
                            $("<span class='error2'>Already exists.</span>").insertAfter("#errortagmsg");
                            enableTagSubmit();
                        } else if (result == "falseChangeType") {
                            if (tagType == 1) {
                                $("<span class='error2'>select Individual tag </span>").insertAfter("#errortagmsg");
                                enableTagSubmit();
                            } else {
                                $("<span class='error2'>Already exists.</span>").insertAfter("#errortagmsg");
                                enableTagSubmit();
                            }
                        }
                    }
                }
            });
        } else {
            enableTagSubmit();
        }
    });
    function createTag() {
        var tag = $('#tag').val();
        var Create = 'Create';
        var tagType = $("#tagType option:selected").val();
        var user = [];
        $("#userdeshBorad option:selected").each(function() {
            user.push($(this).val());
        });
        var userid = "";
        for (var i = 0, n = user.length; i < n; i++) {
            userid += user[i] + ",";
        }
        userid = userid.substr(0, userid.length - 1);
        $.ajax({
            url: '<%=request.getContextPath()%>/admin/project/createTag.jsp',
            data: {tag: tag, tagType: tagType, userid: userid, action: Create, random: Math.random(1, 10)},
            async: true,
            type: 'Post',
            success: function(responseText, statusTxt, xhr) {
                if (statusTxt === "success") {
                    var result = $.trim(responseText);
                    if (result == "true") {
                        $("<span class='error2' style='color:green'>Tag create successfully.</span>").insertAfter("#tagmsg");
                    } else {
                        $("<span class='error2'>Already exists.</span>").insertAfter("#errortagmsg");
                    }
                } else {
                    $("<span class='error2'>Please Try/Again</span>").insertAfter("#errortagmsg");
                }
            }
        });
        enableTagSubmit();
    }
    $('#tagnames').change(function() {
        var tagid = $("#tagnames option:selected").val();
        $.ajax({
            url: '<%=request.getContextPath()%>/IssueSummary/getAlltageIssue.jsp',
            data: {tagid: tagid, random: Math.random(1, 10)},
            async: true,
            type: 'GET',
            success: function(responseText, statusTxt, xhr) {
                if (statusTxt === "success") {
                    var result = $.trim(responseText);
                    if (result != "") {
                        var allissue = result;
                        var issuearr = allissue.split(',');
                        $(".checkIssue").each(function() {
                            var notmatch = "false";
                            for (var i = 0; i < issuearr.length; i++) {
                                if (issuearr[i] === $(this).val()) {
                                    $(this).prop("checked", true);
                                    $(this).attr("id", $(this).val() + "checked");
                                    $(this).removeAttr("style");
                                    notmatch = "true";
                                }
                            }
                            if (notmatch == "false") {
                                $(this).prop("checked", false);
                                $(this).attr("id", 'notchecked');
                            }
                        });
                    } else {
                        $(".checkIssue").each(function() {
                            $(this).prop("checked", false);
                            $(this).attr("id", 'notchecked');
                        });
                    }
                }
            }
        });
    });
    function getAllTag() {
        $.ajax({
            url: '<%=request.getContextPath()%>/admin/project/retrieveAlltags.jsp',
            data: {random: Math.random(1, 10)},
            async: true,
            type: 'GET',
            success: function(responseText, statusTxt, xhr) {
                if (statusTxt === "success") {
                    var result = $.trim(responseText);
                    //  $(".selectTag").html('');
                    //  $(".selectTag").html(result);
                    $("#tagnames").html('');
                    $("#tagnames").html(result);
                }
            }
        });
    }



    $('#addIssueToTag').click(function() {
        $('span.error2').remove();
        var selected = [];
        $(".checkIssue:checked").each(function() {
            selected.push($(this).val());
        });
        var tag = $("#tagnames option:selected").val();
        if (selected.length == 0) {
            $("<span class='error2'>Select at least one issue</span>").insertAfter("#addIssueToTag");
        } else if (isNaN(parseInt(tag))) {
            $("<span class='error2'>Select a tag </span>").insertAfter("#addIssueToTag");
            $("#tagnames").focus();
        } else {
            var issueids = "";
            for (var i = 0, n = selected.length; i < n; i++) {
                issueids += selected[i] + ",";
            }

            var create = 'Create';
            $.ajax({
                url: '<%=request.getContextPath()%>/admin/project/createTagIssue.jsp',
                data: {action: create, tagId: tag, issueId: issueids, random: Math.random(1, 10)},
                async: true,
                type: 'Post',
                success: function(responseText, statusTxt, xhr) {
                    if (statusTxt === "success") {
                        $("<span class='error2' style='color:green'>Issue add successfully </span>").insertAfter("#addIssueToTag");
                        $(".checkIssue:checked").each(function() {
                            $(this).attr("id", $(this).val() + "checked");
                        });
                    } else {
                        $("<span class='error2'>Please Try/Again</span>").insertAfter("#addIssueToTag");
                    }
                }
            });
        }
    });
    $(".checkIssue").click(function() {
        $('span.error2').remove();
        var currThis = $(this);
        var tag = $("#tagnames option:selected").val();
        var issueId = $(this).val();
        var id = $(currThis).attr("id");
        if (tag != "") {
            if (id == "notchecked") {
            } else {
                if (!$(this).is(':checked')) {
                    $.ajax({
                        url: '<%=request.getContextPath()%>/IssueSummary/deleteIssueTag.jsp',
                        data: {tagId: tag, issueId: issueId, random: Math.random(1, 10)},
                        async: true,
                        type: 'Post',
                        success: function(responseText, statusTxt, xhr) {
                            if (statusTxt === "success") {
                                var result = $.trim(responseText);
                                if (result == "true") {
                                    $("<span class='error2' style='color:green'>Issue delete successfully</span>").insertAfter("#addIssueToTag");
                                    $(currThis).prop("checked", false);
                                    $(this).attr("id", 'notchecked');
                                } else {
                                    $(currThis).prop("checked", true);
                                    $("<span class='error2'>Please Try/Again</span>").insertAfter("#addIssueToTag");
                                    $(this).attr("id", $(this).val() + "checked");
                                }
                            } else {
                                $(currThis).prop("checked", true);
                                $("<span class='error2'>Please Try/Again</span>").insertAfter("#addIssueToTag");
                                $(this).attr("id", $(this).val() + "checked");
                            }
                        }
                    });
                }
            }
        }
    });



    function disableTagSubmit() {
        document.getElementById('createTag').value = 'Processing';
        document.getElementById('createTag').disabled = true;
        return true;
    }
    function enableTagSubmit() {
        document.getElementById('createTag').value = 'Create Tag';
        document.getElementById('createTag').disabled = false;
    }


</script>
</HTML>
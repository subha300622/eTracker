<%-- 
    Document   : ermMyViews
    Created on : Feb 25, 2014, 10:58:10 AM
    Author     : E0288
--%>

<%@page import="java.util.Map"%>
<%@page import="com.eminent.tags.Tags"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="com.eminent.util.MyViewUtils"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="org.apache.log4j.PropertyConfigurator"%>
<%@page import="org.apache.log4j.Logger"%>
<%@page import="com.eminentlabs.erm.ERMUtil"%>
<%@page import="com.eminentlabs.erm.MyQuery"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <%
        Logger logger = Logger.getLogger("ermMyViews");

        String logoutcheck = (String) session.getAttribute("Name");
        if (logoutcheck == null) {
            logger.fatal("================Session expired===================");
    %>
    <jsp:forward page="../SessionExpired.jsp"></jsp:forward>
    <%
        }
    %>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <LINK title=STYLE
              href="<%= request.getContextPath()%>/eminentech support files/main_ie.css" type="text/css" rel=STYLESHEET>
        <title>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS
            Solution</title>
    </head>
    <jsp:useBean id="tagCon" class="com.eminent.tags.TagController"></jsp:useBean>
        <body>
        <%@ include file="/header.jsp"%>
        <br/>

        <table cellpadding="0" cellspacing="0" width="100%">
            <tr border="2" bgcolor="#C3D9FF">
                <td border="1" align="left" width="100%"><font size="4"
                                                               COLOR="#0000FF"><b> My Views </b></font> <FONT SIZE="3"
                                                               COLOR="#0000FF"></FONT></td></tr>
        </table>
        <br/>
         <input type="hidden" id="saveView" value="<%=request.getParameter("saveView")%>"/>
        <table style="text-align: center;width: 100%;">
            
            <%
                List<MyQuery> myViews = ERMUtil.getMyViews(request);
                SimpleDateFormat sdf = new SimpleDateFormat("dd MMM yyyy");
                int i = 0;
                
                if (request.getParameter("status") != null) {
            %>

            <br>
            <tr>
                <td align=center><FONT SIZE="4" COLOR="#33CC33" style="font-weight: bold;">You
                    have successfully Deleted the Search : </FONT> <FONT SIZE="4" COLOR="#0000FF">
                    <%= request.getParameter("status")%></FONT>
                </td>
            </tr>

            <%
            } else if (request.getParameter("saveView") != null) {%>
            <tr>
                <td align=center> 
                   
                    <FONT SIZE="4" COLOR="#33CC33" style="font-weight: bold;">You
                    have successfully Saved the Search : </FONT> <FONT SIZE="4" COLOR="#0000FF" style="font-weight: bold;">
                    <%= request.getParameter("saveView")%></FONT>
                </td>
            </tr>
            <% } else if (request.getParameter("errormessage") != null) {%>
            <tr>
                <td align=center> <FONT SIZE="4" COLOR="red" style="font-weight: bold;">
                    <%= request.getParameter("errormessage")%></FONT>
                </td>
            </tr>
            <% }
            %>
            <tr>
                <td> <div id="errormsg"></div></td>
            </tr>
        </table>

        <table width="100%">
            <tr>
                <td align="left" width="70%">This list shows <b><%=myViews.size()%></b>
                    views saved by you.</td>
            </tr>
        </table>
        <table width="100%">
            <tr bgcolor="#C3D9FF" height="21">
                <td width="12%"><font><b>View Name</b></font></td>
                <td width="12%"><font><b>Description</b></font></td>
                <td width="12%"><font><b>Created On</b></font></td>
                <td width="12%"><font><b>Manage</b></font></td>
            </tr>

            <%for (MyQuery mq : myViews) {
                    if ((i % 2) != 0) {%>
            <tr bgcolor="#E8EEF7" height="21">
                <%} else {%>
            <tr bgcolor="white" height="21">
                <%}
                    i++;
                %><td><%
                    if (mq.getSearchType() == null) {
                        mq.setSearchType("APM");
                    }
                    if (mq.getSearchType().equalsIgnoreCase("APM")) {%>
                    <A HREF="<%=request.getContextPath()%>/MyQuery/MyQueryRun.jsp?query_id=<%= mq.getQueryId()%>&desc=<%=mq.getDescription()%>"><%= mq.getName()%>(<%=MyViewUtils.getIssueCount(mq.getQueryString())%>)</A>
                        <%} else if (mq.getSearchType().equalsIgnoreCase("ERM")) {%>
                    <A HREF="<%=request.getContextPath()%>/ERM/ermSearchResults.jsp?query_id=<%= mq.getQueryId()%>"><%= mq.getName()%>(<%=MyViewUtils.getIssueCount(mq.getQueryString())%>)</A>
                        <% }
                        %>
                </td>
                <td><%=mq.getDescription()%></td>
                <td><%=sdf.format(mq.getCreatedon())%></td>
                <td>
                    <%if (mq.getSearchType().equalsIgnoreCase("APM")) {%>
                    <a href="<%=request.getContextPath()%>/MyQuery/MyQueryEdit.jsp?query_id=<%= mq.getQueryId()%>"> Edit View </a>
                    <%} else if (mq.getSearchType().equalsIgnoreCase("ERM")) {%>
                    <a href="<%=request.getContextPath()%>/ERM/ermSearch.jsp?queryId=<%= mq.getQueryId()%>"> Edit View </a>
                    <%}%>
                    &nbsp; | <a href="<%=request.getContextPath()%>/ERM/ermDeleteView.jsp?queryId=<%= mq.getQueryId()%>"> Delete View</a></td>
            </tr>

            <%}%>
        </table>
        <br/><%
           tagCon.getAllTagsByUser(request);
            int total = 0;
            if (tagCon.getTagList()==null || tagCon.getTagList().isEmpty()) {

            } else {
                total = tagCon.getTagList().size();
          

        %>
        <div class="clear">

        </div>
        <div>
            <span style="font-size: 12px">This list shows <b><%=total%></b> Tags.</span>

        </div>
        <table style="width:50%" id="filtersort" class="tablesorter">
            <thead>
                <tr style="background-color: #C3D9FF;height: 21px"  >
                    <th ><font><b>Tag Name</b></font></th>
                    <th  class="filter-false"><font><b>Tag Type</b></font></th>
                    <th class="filter-select filter-match" data-placeholder="Select" ><b>Created By</b></th>
                    <th  class="filter-false"><font><b>Manage</b></font></th>
                </tr></thead>
            <tbody>
                <%

                    int j = 0;
                   
                        Map<Long, Integer> map = tagCon.getCountissueTagMap();
                        for (Tags tag : tagCon.getTagList()) {
                            j++;
                            if ((j % 2) != 0) {%>
                <tr style=height:21px" class="zebraline">
                    <%} else {%>
                <tr style="height:21px" class="zebralinealter">
                    <%}

                        Integer count = map.get(tag.getTagId());
                        if (count == null) {
                            count = 0;
                        }
                        String type = "";
                        if (tag.getTagType() == 0) {
                            type = "Individual tag";

                        } else {
                            type = "Common tag";
                        }
                        String creator = "";
                        if (tagCon.getUserMap().isEmpty()) {
                        } else {
                            creator = tagCon.getUserMap().get(tag.getUserId());
                        }
                    %>
                    <td class="background"><a href="<%=request.getContextPath()%>/MyQuery/IssueByTag.jsp?tagId=<%=tag.getTagId()%>"><%=tag.getTagName()%>(<%=count%>)</a> </td>
                    <td class="background"><%=type%></td>
                    <td class="background"><%=creator%></td>
                    <td class="background">
                        <%int roleId = (Integer) session.getAttribute("Role");
                            Integer userId = (Integer) request.getSession().getAttribute("userid_curr");
                            if ((userId == tag.getUserId().intValue()) || roleId == 1) {%>
                              <a href="javascript:void(0)" class="tagDelete" id="<%=tag.getTagId()%>">Edit Tag</a> || 
                        <a href="javascript:void(0)" class="tagDelete" id="<%=tag.getTagId()%>">Delete Tag</a>
                        <%}%>
                    </td>
                </tr>
                <%
                         }
                    }%>
            </tbody>
        </table>
            
            
            
            
        <SCRIPT type="text/javascript" 	src="https://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
        <script src="<%=request.getContextPath()%>/javaScript/jquery.tablesorter1.js" type="text/javascript"></script>
        <script src="<%=request.getContextPath()%>/javaScript/jquery.tablesorter.widgets.js" type="text/javascript"></script>    

        <link rel="stylesheet" href="<%=request.getContextPath()%>/css/theme.blue1.css?test=3">

        <script type="text/javascript">

            $(document).ready(function ()
            {
                var saveView = $('#saveView').val();
                if(saveView===null || saveView === "null"){
                    
                }else{                 
                             parent.treeframe.location.reload();   
                }
                // call the tablesorter plugin
                $(".tablesorter").tablesorter({
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

            $(".tagDelete").click(function () {
                $('span.error2').remove();
                if (confirm("Are you sure to delete this  tag ?") === true) {
                    var tagId = $(this).attr('id');
                    var curr = $(this);
                    $.ajax({
                        url: '<%=request.getContextPath()%>/MyQuery/deleteTag.jsp',
                        data: {tagId: tagId, random: Math.random(1, 10)},
                        async: true,
                        type: 'Post',
                        success: function (responseText, statusTxt, xhr) {
                            if (statusTxt === "success") {
                                var result = $.trim(responseText);
                                if (result ==="true") {
                                    $("<span class='error2' style='color:green'>Tag delete successfully</span>").insertAfter("#errormsg");
                                    $(curr).parent().parent('tr').remove();
                                    $('html,body').scrollTop(0);
                                } else {
                                    $("<span class='error2'>You canot delete tag is mapped other place </span>").insertAfter("#errormsg");
                                    $('html,body').scrollTop(0);
                                }
                            } else {
                                $("<span class='error2'>You canot delete tag is mapped other place </span>").insertAfter("#errormsg");
                                $('html,body').scrollTop(0);
                            }
                        }
                    });
                }
            });
        </script>
    </body>
</html>

<%-- 
Document   : IssueByTag
    Created on : 28 Jun, 2016, 3:40:38 PM
    Author     : admin
--%>

<%@page import="java.util.HashMap"%>
<%@page import="dashboard.CheckDate"%>
<%@page import="com.eminent.issue.formbean.IssueFormBean"%>
<%@page import="java.util.Map"%>
<%@page import="com.eminentlabs.mom.MoMUtil"%>
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
        Logger logger = Logger.getLogger("IssueSearchbyTag");
        Long tagId = MoMUtil.parseLong(request.getParameter("tagId"), 0l);
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
    <LINK title=STYLE href="<%= request.getContextPath()%>/eminentech support files/main_ie.css" type="text/css" rel=STYLESHEET>
    <title>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS Solution</title>
    <script src="<%=request.getContextPath()%>/javaScript/jquery.js" type="text/javascript"></script>
    <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/tooltip.js"></script>
    <script>
        $(".Ajax-loder").show();
    </script>
</head>
<body>
    <%@ include file="/header.jsp"%>
    <div class="Ajax-loder">

        <div class="bg"></div>

        <img class="loading" src="<%=request.getContextPath()%>/images/276 (1).GIF"
             alt="loading...." /></div>
    <br/>
    <jsp:useBean id="tagCon" class="com.eminent.tags.TagController"></jsp:useBean>
    <%
        String team = (String) session.getAttribute("team");
         String mail = (String) session.getAttribute("theName");
            String url = null;
            if (mail != null) {
                url = mail.substring(mail.indexOf("@") + 1, mail.length());
            }
    %>

    <table cellpadding="0" cellspacing="0" width="100%">
        <tr style="border:2px;background-color:#C3D9FF">
            <td style="border:1px;width: 70%;text-align: left"><font size="4" COLOR="#0000FF"><b>Tag Issues </b></font> <FONT SIZE="3" COLOR="#0000FF"></FONT></td>
            <td><div>
                    <label><strong>Select Tag:</strong></label> 
                    <select   name = "tagnames" id ="tagnames" size = "1" style="min-width: 200px;"> 
                        <option value = "" selected = "" > Select </ option>
                            <%
                                tagCon.getAllTagsByUser(request);
                                if (tagCon.getTagList().isEmpty()) {
                                } else {
                                    for (Tags tag : tagCon.getTagList()) {
                                        if (tag.getTagId() == tagId) {
                            %>
                        <option value="<%=tag.getTagId()%>" selected=""><%=tag.getTagName()%></option>
                        <%} else {%>
                        <option value="<%=tag.getTagId()%>" ><%=tag.getTagName()%></option>
                        <%
                                    }
                                }
                            }
                        %> 
                    </select>
                    <span style="color: blue;font-weight: bold;cursor: pointer;position: " onclick="addTag();">Add Tag</span>
                </div></td>
            <td border="1" align="right" style="width: 10%;"><font size="2"
                                                                   face="Verdana, Arial, Helvetica, sans-serif">Export to <a href="<%=request.getContextPath()%>/MyQuery/exportexcelIssueByTag.jsp?tagId=<%=tagId%>" target="_blank"   >Excel</a></font></td>

        </tr>
    </table>
    <br/>


    <div class="clear">
    </div>
    <div class="issuedisplay">
        <jsp:useBean id="tagc" class="com.eminent.tags.TagIssueController"></jsp:useBean>
        <%
            tagc.getAllIssueByTag(request);
            Map<String, String> serVartiyColor = tagc.getServrityMap();
            int roleId = (Integer) session.getAttribute("Role");
            if (tagc.getListIssueFormBean().isEmpty()) {
        %>
        <div><b>NO Issue under this tag</b></div>
        <%} else {
            session.setAttribute("forwardpage", "/MyQuery/IssueByTag.jsp?tagId=" + tagId + "");
        %>
        <div class="tablecontent">

            <div>
                <div style="float:left;width: 45%">
                    Display total:<b><%=tagc.getListIssueFormBean().size()%></b>  Issues 
                </div>
                <div style="float: left;width: 40%;">
                    <input type="button" id="addIssueToTag" value="Add Issue In Tag"><span id="errormsg"></span>
                </div>
                <div  style="float:right;width: 12%;">
                    <span>Severity</span>
                    <span style="background:#FF0000">S1</span>
                    <span style="background:#DF7401">S2</span>
                    <span style="background:#F7FE2E">S3</span>
                    <span style="background:#04B45F">S4</span>
                </div>
            </div>
            <br/>
            <TABLE width="100%" id="filtersort" class="tablesorter">
                <thead>
                    <TR style="background-color:#C3D9FF">
                        <td width="1%" class="filter-false" TITLE="Severity"><font><b>S</b></font></td>
                        <td width="11%" ><font><b>Issue No</b></font></td>
                        <td width="3%" class="filter-false"><font><b>P</b></font></td>
                        <td width="10%" class="filter-select filter-match" data-placeholder="Select a Project"><font><b>Project</b></font></td>
                        <td width="7%" class="filter-select filter-match" data-placeholder="Select a Module"><font><b>Module</b></font></td>
                        <td width="25%" ><font><b>Subject</b></font></td>
                        <td width="12%" class="filter-select filter-match" data-placeholder="Select a status" ><font><b>Status</b></font></td>
                        <td width="8%" class="filter-false"><font><b>Due Date</b></font></td>
                        <td width="13%" class="filter-select filter-match" data-placeholder="Select Created By"><font><b>Assigned To</b></font></td>
                        <td width="9%" class="filter-false"><font><b>Refer</b></font></td>
                        <td width="2%" TITLE="In Days"  data-placeholder="Try >10"><font><b>Age</b></font></td>
                    </TR>
                </thead>
                <tbody>
                    <%      int i = 0;
                        for (IssueFormBean issueFormBean : tagc.getListIssueFormBean()) {
                            i++;
                            if ((i % 2) != 0) {
                    %>
                    <tr class="zebralinealter" height="21">
                        <%
                        } else {
                        %>

                    <tr class="zebraline" height="21">
                        <%
                            }
                        %>

                        <%
                            for (Map.Entry<String, String> entrySet : serVartiyColor.entrySet()) {

                                if (issueFormBean.getSeverity().equalsIgnoreCase(entrySet.getKey())) {%>
                        <td style="background-color: <%=entrySet.getValue()%>">&nbsp; </td>
                        <% }
                            }

                            if (roleId == 1) {
                        %>
                        <td class="background"  title="<%=issueFormBean.getType()%>"><a  href="<%= request.getContextPath()%>/admin/dashboard/UpdateIssueview.jsp?issueNo=<%=issueFormBean.getIssueId()%>"><%= issueFormBean.getIssueId()%></a></td>

                        <%
                        } else {
                        %>
                        <td  class="background"  title="<%=issueFormBean.getType()%>"><input type="checkbox" name="check" class="checkIssue"  value="<%=issueFormBean.getIssueId()%>" checked="true"/><a  href="javascript:callissue('<%=issueFormBean.getIssueId()%>')" style="visibility: visible"><%= issueFormBean.getIssueId()%></a></td>
                            <%
                                }
                                String priority = issueFormBean.getPriority().substring(0, 2);
                            %>
                        <td class="background" ><%=priority%></font></td>

                        <td class="background"><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= issueFormBean.getpName()%></font></td>

                        <td class="background" width="8%" title="<%=issueFormBean.getmName()%>"><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000">
                            <% String module = issueFormBean.getmName();
                                if (module.length() > 10) {
                                    module = module.substring(0, 10) + "...";
                                }%> 
                            <%= module%>
                            </font></td>
                        <td class="background" id="<%=issueFormBean.getIssueId()%>tab" onmouseover="xstooltip_show('<%=issueFormBean.getIssueId()%>', '<%=issueFormBean.getIssueId()%>tab', 289, 49);" onmouseout="xstooltip_hide('<%=issueFormBean.getIssueId()%>');" ><div class="issuetooltip" id="<%=issueFormBean.getIssueId()%>"><%= issueFormBean.getDescription()%></div><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= issueFormBean.getSubject()%></font></td>
                        <td class="background"  onclick="showPrint('<%=issueFormBean.getIssueId()%>');" style="cursor: pointer;background-color: <%=issueFormBean.getRatingColor()%>"><%= issueFormBean.getStatus()%></font></td>

                        <%

                            String dueDate = issueFormBean.getDueDate();
                            if ((!dueDate.equalsIgnoreCase("NA")) && (CheckDate.getFlag(dueDate) == true)) {

                        %>
                        <td class="background" ><font face="Verdana, Arial, Helvetica, sans-serif"
                                                      size="1" color="RED"><%= dueDate%></font></td>
                            <%
                            } else {
                            %>
                        <td class="background" ><font face="Verdana, Arial, Helvetica, sans-serif"
                                                      size="1" color="#000000"><%= dueDate%></font></td>
                            <%
                                }
                                int asign = MoMUtil.parseInteger(issueFormBean.getAssignto(), 0);
                                String assignto = (String) tagc.getUserMap().get(asign);
                            %>



                        <td class="background"><font
                                face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= assignto%>
                            </font></td>



                        <%

                            int count = 0;
                            if (tagc.getFileCountList().containsKey(issueFormBean.getIssueId())) {
                                count = tagc.getFileCountList().get(issueFormBean.getIssueId());
                            }
                            if (count > 0) {
                        %>
                        <td class="background"><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"> <a onclick="viewFileAttachForIssue('<%=issueFormBean.getIssueId()%>')" href="javascript:void(0)">View Files(<%=count%>)</a></font></td>
                            <%
                            } else {
                            %>
                        <td class="background"><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000">No Files</font></td>
                            <%
                                }
                                int age = 0;
                                for (Map.Entry<String, Integer> entrySet : tagc.getAgeofIssue().entrySet()) {
                                    if (entrySet.getKey().equalsIgnoreCase(issueFormBean.getIssueId())) {
                                        age = entrySet.getValue();
                                    }
                                }
                            %>
                        <td class="background" ><%=age%></td>


                    </tr>
                    <%

                        }
                    %>
                </tbody>
            </table>

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

        <%}%>
        <LINK title=STYLE href="<%= request.getContextPath()%>/eminentech support files/main_ie.css?test=261020151225" type="text/css" rel="STYLESHEET">
        <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/fileAttach.js?test=261020151625"></script>
        <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/tooltip.js"></script>
        <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/checkSubmit.js"></script>
        <SCRIPT type="text/javascript" 	src="https://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>

        <SCRIPT type="text/javascript" src="<%=request.getContextPath()%>/javaScript/jquery.jscroll.js"></SCRIPT>

        <script src="<%=request.getContextPath()%>/javaScript/jquery.tablesorter1.js" type="text/javascript"></script>
        <script src="<%=request.getContextPath()%>/javaScript/jquery.tablesorter.widgets.js" type="text/javascript"></script>    
        <link rel="stylesheet" href="<%=request.getContextPath()%>/css/theme.blue1.css?test=3">

        <script type="text/javascript">


                        function tagDownload()
                        {

                            var tab_text = "<table border='2px'><tr >";
                            var j = 0;
                            tab = document.getElementById('filtersort'); // id of table
                            for (j = 0; j < tab.rows.length; j++)
                            {
                                tab_text = tab_text + tab.rows[j].innerHTML + "</tr>";
                            }
                            tab_text = tab_text + "</table>";
                            tab_text = tab_text.replace(/<A[^>]*>|<\/A>/g, "");//remove if u want links in your table
                            tab_text = tab_text.replace(/<img[^>]*>/gi, ""); // remove if u want images in your table
                            tab_text = tab_text.replace(/<input[^>]*>|<\/input>/gi, ""); // reomves input params
                            var ua = window.navigator.userAgent;
                            var msie = ua.indexOf("MSIE ");
                            var currentdate = new Date();
                            var datetime = currentdate.getDate() + "-" + (currentdate.getMonth() + 1) + "-" + currentdate.getFullYear() + " @ " + currentdate.getHours() + "_" + currentdate.getMinutes() + "_" + currentdate.getSeconds();
                            if (msie > 0 || !!navigator.userAgent.match(/Trident.*rv\:11\./))      // If Internet Explorer
                            {
                                txtArea1.document.open("txt/html", "replace");
                                txtArea1.document.write(tab_text);
                                txtArea1.document.close();
                                txtArea1.focus();
                                sa = txtArea1.document.execCommand("SaveAs", true, "TagDownload.xls");
                            } else {                //other browser not tested on IE 11
                                var uri = 'data:application/vnd.ms-excel,' + encodeURIComponent(tab_text);
                                var downloadLink = document.createElement("a");
                                downloadLink.href = uri;
                                downloadLink.download = "TagDownload.xls";
                                document.body.appendChild(downloadLink);
                                downloadLink.click();
                                document.body.removeChild(downloadLink);
                                //sa = window.open('data:application/vnd.ms-excel,' + encodeURIComponent(tab_text));
                                //  return (sa);
                            }
                        }
                        $.tablesorter.addParser({
                            id: "ddMMMyy",
                            is: function(s) {
                                return false;
                            },
                            format: function(s, table) {
                                var from = s.split("-");
                                var year = "20" + from[2];
                                var mon = from[1];
                                var month = new Date(Date.parse(mon + " 1," + year)).getMonth();
                                return new Date(year, month, from[0]).getTime() || '';
                            },
                            type: "numeric"
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
                        $(".checkIssue").click(function() {
                            $('span.error2').remove();
                            var currThis = $(this);
                            var tag = $("#tagnames option:selected").val();
                            var issueId = $(this).val();
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
                                                $("<span class='error2' style='color:green'>Issue delete successfully</span>").insertAfter("#errormsg");
                                                $(currThis).prop("checked", false);
                                            } else {
                                                $(currThis).prop("checked", true);
                                                $("<span class='error2'>Please Try/Again</span>").insertAfter("#errormsg");
                                            }
                                        } else {
                                            $(currThis).prop("checked", true);
                                            $("<span class='error2'>Please Try/Again</span>").insertAfter("#errormsg");
                                        }
                                    }
                                });

                            }
                        });

                        $('#addIssueToTag').click(function() {
                            $('span.error2').remove();
                            var selected = [];
                            $("input:checkbox[name=check]:checked").each(function() {
                                selected.push($(this).val());
                            });
                            var tag = $("#tagnames option:selected").val();
                            if (selected.length == 0) {
                                $("<span class='error2'>Select at least one issue</span>").insertAfter("#errormsg");
                            } else if (isNaN(parseInt(tag))) {
                                $("<span class='error2'>Select a tag </span>").insertAfter("#errormsg");
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
                                            $("<span class='error2' style='color:green'>Issues added successfully </span>").insertAfter("#errormsg");
                                        } else {
                                            $("<span class='error2'>Please Try/Again</span>").insertAfter("#errormsg");
                                        }
                                    }
                                });
                            }
                        });

        </script>
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
                        HashMap<Integer, String> deshBordUser = tagCon.getAllDeshBoradUser();
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
    <script>
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
        function showPrint(issueid) {
            window.open("<%=request.getContextPath()%>/viewIssueDetails.jsp?issueid=" + issueid);
        }
        $("#tagnames").change(function() {
            $(".Ajax-loder").fadeIn();
            var tag = $("#tagnames option:selected").val();
            if (tag == "") {
            } else {
                $.ajax({
                    url: '<%=request.getContextPath()%>/MyQuery/tagwiseIssue.jsp',
                    data: {tagId: tag, random: Math.random(1, 10)},
                    async: true,
                    type: 'Post',
                    success: function(responseText, statusTxt, xhr) {
                        if (statusTxt === "success") {
                            var result = $.trim(responseText);
                            $(".issuedisplay").html('');
                            $(".issuedisplay").html(result);
                        }
                    }
                });
            }
            $(".Ajax-loder").fadeOut();
        });

        $('#createTag').click(function() {
            disableTagSubmit();
            $("span.error2").remove();
            var tag = $.trim($('#tag').val());
            var tagType = $.trim($("#tagType").val());
            var user = [];
            $("#userdeshBorad option:selected").each(function() {
                user.push($(this).val());
            });
            var count = 0;
            if (tag.length == 0) {
                $("<span class='error2'>Please enter tag name </span>").insertAfter("#errortagmsg");
                $("#tagnames").focus();
                count = 1;
            } else if (tag.length > 20) {
                $("<span class='error2'>Please enter tag name less than 20 characters</span>").insertAfter("#errortagmsg");
                $("#tagnames").focus();
                count = 1;
                enableTagSubmit();
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

        function getAllTag() {
            var tagId = $("#tagnames option:selected").val();
            $.ajax({
                url: '<%=request.getContextPath()%>/admin/project/retrieveAlltags.jsp',
                data: {tagId: tagId, random: Math.random(1, 10)},
                async: true,
                type: 'GET',
                success: function(responseText, statusTxt, xhr) {
                    if (statusTxt === "success") {
                        var result = $.trim(responseText);
                        $("#tagnames").html('');
                        $("#tagnames").html(result);
                    }
                }
            });
        }

        function disableTagSubmit() {
            document.getElementById('createTag').value = 'Processing';
            document.getElementById('createTag').disabled = true;
            return true;
        }
        function enableTagSubmit() {
            document.getElementById('createTag').value = 'Create Tag';
            document.getElementById('createTag').disabled = false;
        }

        function callissue(issueid) {
            var team = '<%=team%>';
              var mail = '<%=url%>';
            var d = new Date();
            var n = d.getHours();
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
                                location.href = '<%=request.getContextPath()%>/Issuesummaryview.jsp?planSeq=yes&issueid=' + issueid;
                            } else {
                                alert(result);
                            }
                        }
                    });
                } else {
                    location.href = '<%=request.getContextPath()%>/Issuesummaryview.jsp?planSeq=yes&issueid=' + issueid;

                }
            } else {
                location.href = '<%=request.getContextPath()%>/Issuesummaryview.jsp?planSeq=yes&issueid=' + issueid;
            }
        }
    </script>
    <LINK title=STYLE href="<%= request.getContextPath()%>/multiple-select.css" type="text/css" rel="STYLESHEET">

    <link rel="stylesheet" href="<%= request.getContextPath()%>//css/jquery-ui.css"/>
    <script src="<%= request.getContextPath()%>/javaScript/jquery-ui.js"></script>
    <script src="<%= request.getContextPath()%>/javaScript/jquery.multiple.select.js"></script>

    <style>
        .ms-drop input[type="checkbox"] {
            float: left;
        }
        .ms-drop ul > li label {
            font-weight: bold;
            white-space: nowrap;
            text-align: left;
            float: left;
        }
    </style>
    <script type="text/javascript">
        $('#userdeshBorad').multipleSelect({
            filter: true,
            maxHeight: 150,
            width: 200
        }
        );
        $(".Ajax-loder").fadeOut(100);
    </script>
</body>
</html>

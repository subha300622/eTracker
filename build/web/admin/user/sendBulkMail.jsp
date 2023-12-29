<%-- 
    Document   : sendBulkMail
    Created on : 29 Jun, 2017, 3:50:05 PM
    Author     : EMINENT
--%>

<%@page import="com.eminent.timesheet.specifiedAllUsers"%>
<%@page import="com.eminent.timesheet.CreateTimeSheet"%>
<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="org.apache.log4j.Logger,pack.eminent.encryption.*,com.pack.SessionCounter,java.util.*,com.eminent.util.*,java.text.SimpleDateFormat"%>
<%
    Logger logger = Logger.getLogger("ViewUser");

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
    <script type="text/javascript" src="<%= request.getContextPath()%>/ckeditor_4.5.9_standard/ckeditor/ckeditor.js"></script>          <script type="text/javascript">    CKEDITOR.timestamp = '21072016';</script>
    <LINK title=STYLE href="<%= request.getContextPath()%>/eminentech support files/main_ie.css?test=15072016145412312312123" type="text/css" rel=STYLESHEET>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/theme.blue1.css?test=150720161404">

    <TITLE>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS
        Solution</TITLE>
    <script src="<%= request.getContextPath()%>/javaScript/jquery.js" type="text/javascript" />
    <script src="<%= request.getContextPath()%>/javaScript/jquery-1.10.2.js"></script>
    <script src="<%=request.getContextPath()%>/javaScript/XMLHttpRequest.js" type="text/javascript"></script>
    <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/checkSubmit.js"></script>

    <script language="JavaScript">
        var xmlhttp = createRequest();

        function printpost(post)

        {
            pp = window.open('./profile.jsp?post_id=' + post, 'pp', 'size = maximize,location=no,statusbar=no,menubar=no,scrollbars=no width=900,height=400');
            pp.focus();
        }

        var form = 'showusers' //form name

        function SetChecked(val, chkName)
        {
            dml = document.forms[form];
            len = dml.elements.length;
            var i = 0;
            for (i = 0; i < len; i++)
            {
                if (dml.elements[i].name == chkName)
                {
                    dml.elements[i].checked = val;
                }
            }
        }
        function textCounter(field, cntfield, maxlimit) {
            if (document.getElementById('typeSelector').value == '') {
                alert("Please Select Type.");
                document.getElementById('typeSelector').focus();
                return false;
            }
            if (field.value.length > maxlimit)
            {
                field.value = field.value.substring(0, maxlimit);
                alert('Subject size is exceeding 160 characters');
            }
            else
                cntfield.value = maxlimit - field.value.length;
        }
        function textcounter(field, cntfield, maxlimit) {
            if (field.value.length > maxlimit)
            {
                field.value = field.value.substring(0, maxlimit);
                alert('Subject size is exceeding 200 characters');
            }
            else
                cntfield.value = maxlimit - field.value.length;
        }

        function ValidateForm()
        {
            var checked = $("input:checkbox[name=send]:checked").length;
            if (checked == 0) {
                alert("Please Select at least one user to send sms or mail");
                return false;
            }
            if ($('input[name="sms"]:checked').val() == "mail") {

                if (document.getElementById('typeSelector').value == '') {
                    alert("Please Select Type.");
                    document.getElementById('typeSelector').focus();
                    return false;
                }
                if ($('input:radio[name="dynradio"]').is(":checked") == false) {
                    alert("Please Select Subject to send.");
                    $('#dynradio').focus();
                    return false;

                }
            } else if ($('input[name="sms"]:checked').val() == "sms") {

                if ($('#smssubject').val() == '') {
                    alert("Please Enter Subject.");
                    $('#smssubject').focus();
                    return false;
                }
                if (document.getElementById('typeSelector').value == '') {
                    alert("Please Select Type.");
                    document.getElementById('typeSelector').focus();
                    return false;
                }

            }
            disableSubmit();
            return true;
        }
    </script>

</head>
<body>
    <jsp:useBean id="mmc" class="com.pack.controller.MailMaintanceController"/>
    <%
        mmc.sendMailContentToUsers(request);
    %>

    <jsp:useBean id="admin" class="com.pack.AdminBean" />
    <%@ include file="/header.jsp"%>
    <%List<specifiedAllUsers> ul = admin.getAllSpecificUsers();%>
    <table cellpadding="0" cellspacing="0" width="100%" bgColor="#C3D9FF">
        <tr border="2">
            <td border="1" align="left"><font size="4" COLOR="#0000FF"><b>Send GST SMS</b> </font><FONT SIZE="3" COLOR="#0000FF"> </FONT>
            <td border="1" align="right" style="width: 10%;"><font size="2"   face="Verdana, Arial, Helvetica, sans-serif">Export to <a href="javascript:void(0)" onclick="exportToExcel()" >Excel</a></font></td></td></tr>


    </table>
    <br>

    <TABLE width="100%" border="0"  >
        <tr> 
            <td style="text-align: left;">
                <a href="<%= request.getContextPath()%>/admin/user/mailMaintance.jsp">Mail-Content Maintenance</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <a href="<%= request.getContextPath()%>/admin/user/mailFromExcel.jsp">Mail From Excel</a></td>
            <td align="right"><a href="javascript:SetChecked()"><font
                        face="Arial, Helvetica, sans-serif" size="2">Select All</font></a> <a
                    href="javascript:resetChecked()"><font
                        face="Arial, Helvetica, sans-serif" size="2">Clear All</font></a></td>

        </tr>
    </TABLE>


    <%
        String message = mmc.getMessage();
        List<String> mailNotSent = mmc.getMailnotSent();
        List<String> remainContacts = mmc.getRemainContacts();
        request.setAttribute("mailNotsent", mailNotSent);
        if (message != null) {
            if (message.equalsIgnoreCase("Mail Not Sent")) {
    %>  <div style="text-align: center;color: red;font-weight: bold;"><%=message%>(<a href="#" id="mailnotsent"><%=mailNotSent.size()%></a>)</div>
    <%} else if (message.equalsIgnoreCase("Mail Sent Limit Crossed")) {%>
    <div style="text-align: center;color: yellowgreen;font-weight: bold;">Mail Sent Limit Crossed(<a href="#" id="contactMailNotSent"> <%=remainContacts.size()%></a>)</div>
    <%} else if (message.equalsIgnoreCase("Mail Not Sent,Mail Sent Limit Crossed")) {%>
    <div style="text-align: center;color: red;font-weight: bold;">Mail Not sent(<a href="#" id="mailnotsent"><%=mailNotSent.size()%></a>)</div>
    <div style="text-align: center;color: yellowgreen;font-weight: bold;">Mail Sent Limit Crossed( <a href="#" id="contactMailNotSent"> <%=remainContacts.size()%></a>)</div>
    <%} else {%>
    <div style="text-align: center;color: #33CC33;font-weight: bold;"><%=message%></div>
    <%}
        }%>
    <form name="theForm" id="theForm"   onsubmit="return ValidateForm(this);"  method="post" action="<%=request.getContextPath()%>/admin/user/sendBulkMail.jsp">
        <table align="center" bgcolor="#E8EEF7" width="100%">
            <tr>
                <td align="center"><input type="radio" name="sms" id="sms" value="sms">SMS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <input type="radio" name="sms" id="mail" value="mail">Mail&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>

            </tr>
        </table>
        <div id="typeSelectordiv" style="display: none" align="center">
            <table bgcolor="#E8EEF7"  width="100%" align="center">
                <tr>
                    <td ><b>Type :</b> <select name="typeSelector" id="typeSelector"   onchange="typeSelectorfunc();">
                            <option value="">Select type</option>
                            <option value="Contact">Contact</option>
                            <option value="Lead">Lead</option>
                            <option value="Opportunity">Opportunity</option>
                            <option value="Account">Account</option></select>
                    </td>
                </tr>
            </table>
        </div>
        <div id="subjecttextArea" style="display: none" align="center">
            <table bgcolor="#E8EEF7" width="100%">
                <tr>
                    <td><b> Subject:</b></td>
                    <td colspan="4" ><font size="2"
                                           face="Verdana, Arial, Helvetica, sans-serif"> <textarea
                                rows="3" cols="60" name="smssubject" id="smssubject" maxlength="3000"
                                onKeyDown="textCounter(document.theForm.smssubject, document.theForm.remLen, 160);"
                                onKeyUp="textCounter(document.theForm.smssubject, document.theForm.remLen, 160);"></textarea></font>
                    </td><td><input readonly type="text" name="remLen"
                                    size="1" maxlength="4" value="160"/>
                    </td>


                </tr>


            </table>

        </div>


        <div id="mailArea" style="display: none" align="center" bgcolor="#E8EEF7" >
            <table id="maildetails" style="width: 100%">
                <tbody>

                </tbody>
            </table>
        </div>
    </div>


    <br>
    <br>
    <table width=100% id="user" class="tablesorter">

        <thead>
            <tr class="tablesorter-ignoreRow" >
                <td class="pager" colspan="3" style="background-color: white">
                    <span class="pagedisplay"></span>
                </td>
                <td colspan="4" style="background-color: white">
                    <div class="pager"><nav class="left"> # per page: <a href="#">10</a> | <a href="#" >25</a> | <a href="#">50</a>|<a href="#" class="current">100</a>
                        </nav> 
                        <nav class="right"> <span class="prev"> <img
                                    src="<%=request.getContextPath()%>/images/prev.png" /> Prev&nbsp; </span> <span
                                class="pagecount"></span> &nbsp;<span class="next">Next <img
                                    src="<%=request.getContextPath()%>/images/next.png" /> </span> </nav></div>
                </td>
            </tr>
            <tr bgColor="#C3D9FF" height="9">

                <th width="30%" ><font><b>Name</b></font></th>
                <th width="15%" class="filter-select filter-match" data-placeholder="Select a Type" ><font><b>Type</b></font></th>
                <th width="20%" ><font><b>Company</b></font></th>
                <th width="23%" class="filter-select filter-match" data-placeholder="Select a Status"><font><b>Status</b></font></th>
                <th width="20%" ><font><b>Email</b></font></th>
                <th width="10%" ><font><b>Mobile</b></font></th>
                <th width="10%" ><font><b>Phone</b></font></th>
            </tr>
        </thead> 
        <tbody> 

            <%          //  List<specifiedAllUsers> ul = Admin.getAllSpecificUsers();

                for (specifiedAllUsers u : ul) {
            %>
            <tr >

                <td width="30%" title="<%=u.getTitle()%>"><input type="checkbox" class="idselected" name="send" id="send" value="<%=u.getUserid()%>"><%=u.getName()%></td>
                <td width="15%" ><%=u.getTeam()%></td>
                <td width="20%" ><%=u.getCompany()%></td>
                <td width="23%" ><%=u.getRoleName()%> </td>
                <td width="20%" ><%=u.getEmail()%></td>
                <td width="10%" >
                    <%if (u.getMobile() == null) {%>                  
                    <%} else {%>
                    <%=u.getMobile()%>
                    <%}%>
                </td>
                <td width="10%" ><%=u.getPhone()%></td>
            </tr>
            <%}%>
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
    <table>
        <tr>

            <td colspan="6" align="center"><input type="submit" name="submit" id="submit"  vaue="Submit" ></td>
        </tr>
    </table>

</form>
<div id="overlay"> </div>
<div id="viewContactpopup" class="popup"> 
    <h3 class="popupHeading">Limit Crossed contacts</h3>
    <br/>

    <br/>
    <div class="clear"></div>
    <div class="tableshow">
        <div  style="width: 100%;" class="mid" id="MDAVpopupFiles">
            <table id="contactTable" style="width: 100%;">

                <%  int j = 0;

                    for (String mail : remainContacts) {
                        j++;
                        if (j % 2 == 0) {
                %>
                <tr style="height:21px;" bgcolor="#E8EEF7">

                    <%} else {%>
                <tr style="height:21px;"  >
                    <%}%>
                    <td style="width: 5%;"><%=j%></td>
                    <td style="width: 20%;"><%=mail%></td>

                </tr>

                <%}%>

            </table>
        </div> 
        <button class="custom-popup-close" onclick="javascript:closeViewContact();" type="button">close</button>
    </div></div>
<div id="overlay"> </div>
<div id="viewMailnotsentpopup" class="popup"> 
    <h3 class="popupHeading">Mail Not sent</h3>
    <table><tr>  <td border="1" align="right" style="width: 10%;"><font size="2"   face="Verdana, Arial, Helvetica, sans-serif">Export to <a href="javascript:void(0)" onclick="exportToExcelMailNotSent()" >Excel</a></font></td></tr></table>
    <br/>

    <br/>
    <div class="clear"></div>
    <div class="tableshow">
        <div  style="width: 100%;" class="mid" id="MDAVpopupFiles">
            <table id="mailNotSentContacts" style="width: 100%;">


                <%  int m = 0;

                    for (String mail : mailNotSent) {
                        m++;
                        if (m % 2 == 0) {
                %>
                <tr style="height:21px;" bgcolor="#E8EEF7">

                    <%} else {%>
                <tr style="height:21px;"  >
                    <%}%>
                    <td style="width: 5%;"><%=m%></td>
                    <td style="width: 20%;"><%=mail%></td>

                </tr>

                <%}%>

            </table>
        </div> 
        <button class="custom-popup-close" onclick="javascript:closeViewmailnotsentUsers();" type="button">close</button>
    </div></div>

</body>

<SCRIPT type="text/javascript" 	src="https://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>

<link rel="stylesheet" href="<%= request.getContextPath()%>//css/jquery-ui.css"/>
<script src="<%= request.getContextPath()%>/javaScript/jquery-ui.js"></script>


<script src="<%=request.getContextPath()%>/javaScript/jquery.tablesorter1.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/javaScript/jquery.tablesorter.widgets.js" type="text/javascript"></script>    
<script src="<%=request.getContextPath()%>/javaScript/jquery.tablesorter.pager.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/javaScript/pager-custom-controls.js" type="text/javascript"></script>
<script type="text/javascript">

            $('.idselected').click(function () {
                //if ($('input[name="sms"]:checked').val() == "mail") {
                if (document.getElementById('typeSelector').value == '') {
                    alert("Please Select Type.");
                    document.getElementById('typeSelector').focus();
                    return false;
                }
                // }

            });

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
            function SetChecked()
            {
                //$('input:checkbox').removeAttr('checked');
                var test1 = $("tr[class=odd] input:checkbox");
                var testeven = $("tr[class=even] input:checkbox");
                var rowslen = test1.length;
                var testevenlen = testeven.length;
                for (var m = 0; m < rowslen; m++) {
                    test1[m].checked = true;
                }
                for (var m = 0; m < testevenlen; m++) {
                    testeven[m].checked = true;
                }
            }

            function resetChecked() {
                var test1 = $("tr[class=odd] input:checkbox");
                var testeven = $("tr[class=even] input:checkbox");
                var rowslen = test1.length;
                var testevenlen = testeven.length;
                for (var m = 0; m < rowslen; m++) {
                    test1[m].checked = false;
                }
                for (var m = 0; m < testevenlen; m++) {
                    testeven[m].checked = false;
                }
            }
            $("#sms").click(function () {
                document.getElementById('typeSelectordiv').style.display = 'none';
                $('#mailArea').hide();
                document.getElementById('typeSelectordiv').style.display = 'block';
                $('#subjecttextArea').show();
            });
            $("#mail").click(function () {
                document.getElementById('typeSelectordiv').style.display = 'none';
                $('#subjecttextArea').hide();
                document.getElementById('typeSelectordiv').style.display = 'block';
                $('#mailArea').show();
            });
            function typeSelectorfunc() {

                var type = document.getElementById('typeSelector').value;
                if (type != '') {
                    $(".tablesorter-filter").each(function () {
                        var val = this.getAttribute("data-column");
                        if (val == "1") {
                            this.value = type;
                            $("table.tablesorter").trigger("search");
                        }
                    });
                }
                if ($('input[name="sms"]:checked').val() == "mail") {
                    $.ajax({
                        url: '<%=request.getContextPath()%>/admin/user/mailSmsDetails.jsp',
                        data: {type: type, random: Math.random(1, 10)},
                        async: true,
                        type: 'GET',
                        dateType: 'json',
                        success: function (json) {
                            var i = 1;
                            $('#maildetails tbody').children('tr').remove();
                            for (var key in json) {

                                var item = json[key];
                                if (i % 2 != 0) {

                                    $('#maildetails tbody').append('<tr class="zebralinealter" height="28" style="padding: 5px;"><td title="' + item.substr(item.indexOf("&&&%%%") + 6, item.length) + '"><input type="radio" id="dynradio" name="dynradio"  value="' + key + '" />' + item.substr(0, item.indexOf("&&&%%%")) + '</td></tr>');
                                } else {
                                    $('#maildetails tbody').append('<tr class="zebraline" height="28" style="padding: 5px;"><td title="' + item.substr(item.indexOf("&&&%%%") + 6, item.length) + '"><input type="radio" id="dynradio" name="dynradio"  value="' + key + '" />' + item.substr(0, item.indexOf("&&&%%%")) + '</td></tr>');
                                }
                                i++;
                            }

                        }
                    });
                }
            }
            function exportToExcel() {
                var contacttype = $('.tablesorter-filter[data-column=1]').val();
                var headerSortDown = $('.tablesorter-headerAsc').text();
                var headerSortUp = $(".tablesorter-headerDesc").text();
                if (headerSortDown !== "Type") {
                    headerSortDown = "";
                }
                if (headerSortUp !== "Type") {
                    headerSortUp = "";
                }
                if (contacttype.length > 0) {
                    headerSortDown = "";
                    headerSortUp = "";
                }
                window.open("<%=request.getContextPath()%>/admin/user/exportExcelMail.jsp?type=" + contacttype + "&headerSortDown=" + headerSortDown + "&headerSortUp=" + headerSortUp, '_blank');
            }
            $('#contactMailNotSent').click(function () {
                $('#overlay').fadeIn('fast', 'swing');
                $('#viewContactpopup').fadeIn('fast', 'swing');
            });
            function closeViewContact() {

                $('#overlay').fadeOut('fast', 'swing');
                $('#viewContactpopup').fadeOut('fast', 'swing');
            }
            $('#mailnotsent').click(function () {
                $('#overlay').fadeIn('fast', 'swing');
                $('#viewMailnotsentpopup').fadeIn('fast', 'swing');
            })
            function closeViewmailnotsentUsers() {

                $('#overlay').fadeOut('fast', 'swing');
                $('#viewMailnotsentpopup').fadeOut('fast', 'swing');
            }
//            function exportToExcel() {
//
//                window.open("<%=request.getContextPath()%>/admin/user/exportExcelMailNotSentContact.jsp", '_blank');
//            }
//            function typeSelectorfuncs() {
//
//                var type = document.getElementById('typeSelector').value;
//                if (type != '') {
//                    $(".tablesorter-filter").each(function () {
//                        var val = this.getAttribute("data-column");
//                        if (val == "1") {
//                            this.value = type;
//                            $("table.tablesorter").trigger("search");
//                        }
//                    });
//                }
//            }
            function exportToExcelMailNotSent()
            {
                var d = new Date();
                var n = d.getTime();
                var tab_text = "<table border='2px'><tr bgcolor='#754040 '>";
                var j = 0;
                tab = document.getElementById('mailNotSentContacts'); // id of table
                for (j = 0; j < tab.rows.length; j++)
                {
                    tab_text = tab_text + tab.rows[j].innerHTML + "</tr>";
                }
                tab_text = tab_text + "</table>";
                tab_text = tab_text.replace(/<A[^>]*>|<\/A>/g, ""); //remove if u want links in your table
                tab_text = tab_text.replace(/<img[^>]*>/gi, ""); // remove if u want images in your table
                tab_text = tab_text.replace(/<input[^>]*>|<\/input>/gi, ""); // reomves input params
                var ua = window.navigator.userAgent;
                var msie = ua.indexOf("MSIE ");
                if (msie > 0 || !!navigator.userAgent.match(/Trident.*rv\:11\./))      // If Internet Explorer
                {
                    txtArea1.document.open("txt/html", "replace");
                    txtArea1.document.write(tab_text);
                    txtArea1.document.close();
                    txtArea1.focus();
                    sa = txtArea1.document.execCommand("SaveAs", true, "MailNotsentList" + n + ".xls");
                }
                else {               //other browser not tested on IE 11
                    var uri = 'data:application/vnd.ms-excel,' + encodeURIComponent(tab_text);
                    var downloadLink = document.createElement("a");
                    downloadLink.href = uri;
                    downloadLink.download = "MailNotsentList.xls";
                    document.body.appendChild(downloadLink);
                    downloadLink.click();
                    document.body.removeChild(downloadLink);
                    //    sa = window.open('data:application/vnd.ms-excel,' + encodeURIComponent(tab_text));
                }

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
    .tablesorter-blue tbody tr.odd > td {
        background-color: #E8EEF7;
    }
    .tablesorter-blue tbody tr.even > td {
        background-color: white;
    }



</style>
</html>

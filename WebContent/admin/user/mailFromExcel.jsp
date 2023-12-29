<%-- 
    Document   : mailFromExcel
    Created on : 29 Jun, 2017, 3:55:32 PM
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
    <LINK title=STYLE href="<%= request.getContextPath()%>/eminentech support files/main_ie.css?test=150720161454123123" type="text/css" rel=STYLESHEET>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/theme.blue1.css?test=150720161404">

    <TITLE>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS
        Solution</TITLE>
    <script src="<%= request.getContextPath()%>/javaScript/jquery.js" type="text/javascript" />
    <script src="<%= request.getContextPath()%>/javaScript/jquery-1.10.2.js"></script>
    <script type="text/javascript" src="<%= request.getContextPath()%>/ckeditor_4.5.9_standard/ckeditor/ckeditor.js"></script>          <script type="text/javascript">    CKEDITOR.timestamp = '21072016';</script>
    <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/checkSubmit.js"></script>
    <script type="text/javascript">
        function editorTextCounter(field, cntfield, maxlimit)
        {
            if (field > maxlimit)
            {

                if (maxlimit === 200)
                    alert('Subject size is exceeding 200 characters');
                else
                    alert('Subject size is exceeding 200 characters');
            }
            else
                cntfield.value = maxlimit - field;
        }
        function editorTextcounter(field, cntfield, maxlimit)
        {
            if (field > maxlimit)
            {

                if (maxlimit === 4000)
                    alert('Comments size is exceeding 4000 characters');
                else
                    alert('Comments size is exceeding 4000 characters');
            }
            else
                cntfield.value = maxlimit - field;
        }

        function textCounter(field, cntfield, maxlimit) {
            if (field.value.length > maxlimit)
            {
                field.value = field.value.substring(0, maxlimit);
                alert('Content size is exceeding maxlimit characters');
            }
            else
                cntfield.value = maxlimit - field.value.length;
        }
    </script>
</head>
<body>

    <jsp:useBean id="mmc" class="com.pack.controller.MailMaintanceController" />
    <jsp:useBean id="CalculateIssue" class="com.pack.CalculateIssueValue" />
    <%
        mmc.attachUpload(request, response, pageContext.getServletContext());

    %>
    <%@ include file="/header.jsp"%>
    <div class="Ajax-loder">

        <div class="bg"></div>

        <img class="loading" src="<%=request.getContextPath()%>/images/276 (1).GIF"
             alt="loading...." /></div>
    <table cellpadding="0" cellspacing="0" width="100%" bgColor="#C3D9FF">
        <tr border="2">
            <td border="1" align="left"><font size="4" COLOR="#0000FF"><b>Mail from excel</b> </font><FONT SIZE="3" COLOR="#0000FF"> </FONT></td>

        </tr>
    </table>
    <br/>
    <br/>
    <TABLE width="100%" border="0"  >
        <tr> 
            <td style="text-align: left;"><a href="<%= request.getContextPath()%>/admin/user/sendBulkMail.jsp">Send Mail</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <a href="<%= request.getContextPath()%>/admin/user/mailMaintance.jsp">Mail-Content Maintenance</a></td>


        </tr>
    </TABLE>
    <br/>
    <br/>
    <%int i = 0;
        String message = mmc.getMessage();

        List<String> remainContacts = mmc.getRemainContacts();
        List<String> existed = mmc.getExisted();
        List<String> mailNotSent = mmc.getMailnotSent();
        if (message != null) {
            if (message.contains("Limit crossed")) {%>
    <div style="text-align: center;color: yellowgreen;font-weight: bold;">Mail Sent Limit Crossed(<a href="#" id="contactMailNotSent"> <%=remainContacts.size()%>)</a></div>
    <%} else if (message.equalsIgnoreCase("Mail Not sent")) {
    %>
    <div style="text-align: center;color: red;font-weight: bold;"><%=message%>(<a href="#" id="mailnotsent"><%=mailNotSent.size()%></a>)</div>
    <%} else if (message.contains("Already Existing Contacts are")) {%>
    <div  style = "text-align: center;color: blue;font-weight: bold;" > <%= message%>(<a href="#" id="existed"><%=existed.size()%> </a>)</div>
    <%} else if (message.equalsIgnoreCase("Already Existing Contacts are,Mail Not sent")) {%>
    <div  style = "text-align: center;color: blue;font-weight: bold;" >Already Existing Contacts are(<a href="#" id="existed"><%=existed.size()%></a>)</div>
    <div style="text-align: center;color: red;font-weight: bold;">Mail Not sent(<a href="#" id="mailnotsent"><%=mailNotSent.size()%></a>)</div>
    <%} else if (message.equalsIgnoreCase("Already Existing Contacts are,Limit Crossed.")) {%>
    <div  style = "text-align: center;color: blue;font-weight: bold;" > Already Existing Contacts are(<a href="#" id="existed"><%=existed.size()%> </a>)</div>
    <div style="text-align: center;color: yellowgreen;font-weight: bold;">Mail Sent Limit Crossed(<a href="#" id="contactMailNotSent"> <%=remainContacts.size()%></a>)</div>
    <%} else if (message.equalsIgnoreCase("Mail Not sent,Limit Crossed.")) {%>
    <div style="text-align: center;color: red;font-weight: bold;">Mail Not sent(<a href="#" id="mailnotsent"><%=mailNotSent.size()%></a>)</div>
    <div style="text-align: center;color: yellowgreen;font-weight: bold;">Mail Sent Limit Crossed(<a href="#" id="contactMailNotSent"> <%=remainContacts.size()%></a>)</div>
    <%} else if (message.equalsIgnoreCase("Already Existing Contacts are,Mail Not sent,Limit Crossed.")) {%>
    <div  style = "text-align: center;color: blue;font-weight: bold;" >Already Existing Contacts are(<a href="#" id="existed"><%=existed.size()%> </a>)</div>
    <div style="text-align: center;color: red;font-weight: bold;">Mail Not sent(<a href="#" id="mailnotsent"><%=mailNotSent.size()%></a>)</div>
    <div style="text-align: center;color: yellowgreen;font-weight: bold;">Mail Sent Limit Crossed( <a href="#" id="contactMailNotSent"> <%=remainContacts.size()%></a>)</div>
    <%} else if (message.equalsIgnoreCase("Reading excel Sheet is failed.")) {%>
    <div  style = "text-align: center;color: red;font-weight: bold;" ><%=message%></div>
    <%} else {%>
    <div  style = "text-align: center;color: #04B45F;font-weight: bold;" > <%=message%></div>
    <%}
        }%>
    <form name="theForm" id="theForm"  
          onsubmit="return fun(this);"   method="post" action="<%=request.getContextPath()%>/admin/user/mailFromExcel.jsp" enctype="multipart/form-data">
        <table width="100%" border="0" bgColor="#E8EEF7" cellspacing="2" id="alingment">
            <tbody>
                <tr></tr>
                <tr>
                    <td><b>Upload the mails</b></td><td><input type="file" id="excelupload" name="excelupload" size="80" onchange="checkExcelFile()"  /> </td>

                    <td align=center><FONT SIZE="4" COLOR="#330000"><b>File
                                type should be .xlsx,.xls
                                It's size should be less than 12MB(aprox.)</b></FONT></td>

                </tr>
                <tr>
                    <td ><b>Upload Attachment</b></td><td><input type="file" id="docattach" name="docattach[]" multiple="multiple" /></td>
                </tr>
                <tr></tr>
                <tr></tr>
                <tr></tr>
                <tr><td><b> Subject:</b></td>

                    <td colspan="4" align="left"><font size="2"
                                                       face="Verdana, Arial, Helvetica, sans-serif"> <textarea
                                rows="3" cols="60" name="subject" id="subject" maxlength="3000"
                                onKeyDown="textCounter(document.theForm.subject, document.theForm.remLen, 200);"
                                onKeyUp="textCounter(document.theForm.subject, document.theForm.remLen, 200);"></textarea></font>
                    </td><td><input readonly type="text" name="remLen"
                                    size="1" maxlength="4" value="200"/>
                    </td>



                    </td>
                </tr>
                <tr></tr>
                <tr></tr>
                <tr></tr>
                <tr></tr>
                <tr>
                    <td><b>Content:</b></td>

                    <td colspan="4" align="left"><font size="2"
                                                       face="Verdana, Arial, Helvetica, sans-serif"> <textarea
                                rows="3" cols="60" name="content" id="content"></textarea></font>
                    </td>

            <script type="text/javascript">
                CKEDITOR.replace('content', {height: 100});

            </script>
            </td>
            </tr>
            <tr></tr>
            <tr></tr>
            <tr></tr>
            <tr></tr>
            <tr>
            <input type="hidden" name="smsid"  id="smsid" value=""/>
            <td colspan="3" align="center"><input type="submit" id="submit" value="Submit" name="submit"></td>
            </tr>

            </tbody>
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
                    <!-- <tr  style="background-color:#C3D9FE;font-weight: bold;height:21px;">
                         <td style="width: 5%">S.No</td>
                         <td style="width: 20%;">Mail Id</td>
                     </tr>-->
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
    <div id="viewExistedUserspopup" class="popup"> 
        <h3 class="popupHeading">Already Existed Contacts</h3>
        <br/>

        <br/>
        <div class="clear"></div>
        <div class="tableshow">
            <div  style="width: 100%;" class="mid" id="MDAVpopupFiles">
                <table id="existedContactTable" style="width: 100%;">
                    <!-- <tr  style="background-color:#C3D9FE;font-weight: bold;height:21px;">
                         <td style="width: 5%">S.No</td>
                         <td style="width: 20%;">Mail Id</td>
                     </tr>-->
                    <%  int k = 0;

                        for (String mail : existed) {
                            k++;
                            if (k % 2 == 0) {
                    %>
                    <tr style="height:21px;" bgcolor="#E8EEF7">

                        <%} else {%>
                    <tr style="height:21px;"  >
                        <%}%>
                        <td style="width: 5%;"><%=k%></td>
                        <td style="width: 20%;"><%=mail%></td>

                    </tr>

                    <%}%>

                </table>
            </div> 
            <button class="custom-popup-close" onclick="javascript:closeViewExistedUsers();" type="button">close</button>
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

                    <!-- <tr  style="background-color:#C3D9FE;font-weight: bold;height:21px;">
                         <td style="width: 5%">S.No</td>
                         <td style="width: 20%;">Mail Id</td>
                     </tr>-->
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
    <iframe id="txtArea1" style="display:none"></iframe>
</body>
<script type="text/javascript">

    function checkExcelFile()
    {

        $('.errorExcel').remove();
        var fi = document.getElementById('excelupload');

        var ext = $('#excelupload').val().split('.').pop().toLowerCase();
        if ($.inArray(ext, ['xlsx', 'xls', 'xlsm', 'xltx']) == -1) {
            $("<span class='error12 errorExcel'>Upload only Excel sheet format files</span>").insertAfter("#excelupload");
            document.getElementById("excelupload").value = "";
            theForm.excelupload.focus();
            return false;
        } else {
            $('.errorExcel').remove();
            $(this).css({"border-color": ""});
        }
        var fsize;
        if ($.browser.msie) {
            if ($.browser.version <= 9) {
                fsize = document.getElementById('excelupload').size;

            }
        } else {
            fsize = fi.files.item(0).size; // THE SIZE OF THE FILE.
        }
        if (fsize > 12582912) {

            $("<span class='error12 erroruser'>Maximum 12 MB Size allowed</span>").insertAfter("#excelupload");
            document.getElementById("excelupload").value = "";
            document.theForm.excelupload.focus();
            return false;
        }
        else {

            $('.erroruser').remove();
            $('#excelupload').css({"border-color": ""});

            return true;
        }
    }


    function fun() {
        $('.errorExcel').remove();
        var val = $('#excelupload').val();
        if (val == '')
        {
            $("<span class='error12 errorExcel'>Please Upload excel sheet</span>").insertAfter("#excelupload");
            document.getElementById("excelupload").value = "";
            document.theForm.excelupload.focus();
            return false;
        }
        disableSubmit();
        return true;
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
    $('#existed').click(function () {
        $('#overlay').fadeIn('fast', 'swing');
        $('#viewExistedUserspopup').fadeIn('fast', 'swing');
    })
    function closeViewmailnotsentUsers() {

        $('#overlay').fadeOut('fast', 'swing');
        $('#viewMailnotsentpopup').fadeOut('fast', 'swing');
    }
    function closeViewExistedUsers() {

        $('#overlay').fadeOut('fast', 'swing');
        $('#viewExistedUserspopup').fadeOut('fast', 'swing');
    }
//    function exportToExcel() {
//
//        window.open("<%=request.getContextPath()%>/admin/user/exportExcelMailNotSentContact.jsp", '_blank');
//    }

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

        tab_text = tab_text.replace(/<A[^>]*>|<\/A>/g, "");//remove if u want links in your table
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
    $('#submit').click(function () {
        $(".Ajax-loder").fadeIn('fast', 'swing');
    });
    $(".Ajax-loder").fadeOut();
</script>
<style>
    .error12{
        color: red;
        font-size: 12px;
    }
</style>
</html>



<%-- 
    Document   : mailMaintance
    Created on : 27 Jun, 2017, 10:36:30 AM
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
    <LINK title=STYLE href="<%= request.getContextPath()%>/eminentech support files/main_ie.css?test=150720161454" type="text/css" rel=STYLESHEET>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/theme.blue1.css?test=150720161404">

    <TITLE>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS
        Solution</TITLE>
    <script src="<%= request.getContextPath()%>/javaScript/jquery.js" type="text/javascript" />
    <script src="<%= request.getContextPath()%>/javaScript/jquery-1.10.2.js"></script>
    <script type="text/javascript" src="<%= request.getContextPath()%>/ckeditor_4.5.9_standard/ckeditor/ckeditor.js"></script>          <script type="text/javascript">    CKEDITOR.timestamp = '21072016';</script>
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
        function fun() {
            if (document.getElementById('typeSelector').value == '') {
                alert("Please Select Type..")
                document.getElementById('typeSelector').focus();
                return false;
            }
        }
        function textCounter(field, cntfield, maxlimit) {
            if (field.value.length > maxlimit)
            {
                field.value = field.value.substring(0, maxlimit);
                alert('Description size is exceeding maxlimit characters');
            }
            else
                cntfield.value = maxlimit - field.value.length;
        }
    </script>
</head>
<body>

    <jsp:useBean id="mmc" class="com.pack.controller.MailMaintanceController" />
    <jsp:useBean id="CalculateIssue" class="com.pack.CalculateIssueValue" />
    <%@ include file="/header.jsp"%>

    <table cellpadding="0" cellspacing="0" width="100%" bgColor="#C3D9FF">
        <tr border="2">
            <td border="1" align="left"><font size="4" COLOR="#0000FF"><b>Mailcontent Maintance</b> </font><FONT SIZE="3" COLOR="#0000FF"> </FONT></td>

        </tr>
    </table>
    <br/>
    <br/>
    <TABLE width="100%" border="0"  >
        <tr> 
            <td style="text-align: left;"><a href="<%= request.getContextPath()%>/admin/user/sendBulkMail.jsp">Send Mail</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <a href="<%= request.getContextPath()%>/admin/user/mailFromExcel.jsp">Mail From Excel</a></td>


        </tr>
    </TABLE>
    <%int i = 0;
        String message = request.getParameter("message");
        if (message != null) {%>
    <div id="msg" style="text-align: center;color: #33CC33;font-weight: bold;"><%=message%></div>
    <%}%>
    <form name="theForm" id="theForm" onsubmit="return fun(this);" method="post" action="<%=request.getContextPath()%>/admin/user/mailAdd.jsp">
        <table width="100%" border="0" bgColor="#E8EEF7" cellspacing="2" id="alingment">
            <tbody>
                <tr>
                    <td><b>Type :</b> </td>
                    <td><select name="typeSelector" id="typeSelector">
                            <option value="">Select Type..</option>
                            <option value="Lead">Lead</option>
                            <option value="Contact">Contact</option>
                            <option value="Opportunity">Opportunity</option>
                            <option value="Account">Account</option></select>
                    </td>
                </tr>
                <tr></tr>
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
                                rows="3" cols="60" name="content" id="content" maxlength="4000"
                                onKeyDown="textCounter(document.theForm.content, document.theForm.remLen1, 4000);"
                                onKeyUp="textCounter(document.theForm.content, document.theForm.remLen1, 4000);"></textarea></font>
                    </td><td><input readonly type="text" name="remLen1"
                                    size="1" maxlength="4" value="4000"/>
                    </td>

            <script type="text/javascript">
                CKEDITOR.replace('content', {height: 100});
                var editor_data = CKEDITOR.instances.content.getData();
                CKEDITOR.instances["content"].on("instanceReady", function ()
                {

                    //set keyup event
                    this.document.on("keyup", updateContent);
                    //and paste event
                    this.document.on("paste", updateContent);

                });
                function updateContent()
                {
                    CKEDITOR.tools.setTimeout(function ()
                    {
                        var desc = CKEDITOR.instances.content.getData();
                        var leng = desc.length;
                        editorTextcounter(leng, document.theForm.remLen1, 4000);

                    }, 0);
                }
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
    <div style="color:red" id="errormsg" align="center"></div>
    <%if (mmc.allMails().size() > 0) {%>
    <table width=100% id="maillist">
        <TR bgColor="#C3D9FF" height="9">
            <TD width="20%"><font><b>Type</b></font></TD>
            <TD width="30%"><font><b>Subject</b></font></TD>
            <TD width="30%"><font><b>Content</b></font></TD>
            <TD width="20%"><font><b>Manage</b></font></TD>
        </TR>
        <%for (SendSms sm : mmc.allMails()) {

                if ((i % 2) != 0) {

        %>
        <tr bgcolor="white" height="21" id="mailId<%=sm.getId()%>">
            <%
            } else {
            %>
        <tr bgcolor="#E8EEF7" height="21" id="mailId<%=sm.getId()%>">
            <%
                }
            %>
            <td width="20%"><%=sm.getType()%></td>
            <td width="30%"><%=sm.getSubject()%></td>
            <td width="30%"><%=sm.getDescription()%></td>
            <td width="20%"><span onclick="editMail('<%=sm.getId()%>');" style="color: blue;cursor: pointer; ">Edit</span> || <span onclick="deleteMail('<%=sm.getId()%>');" style="color: blue;cursor: pointer;">Delete</span> </td>
        </tr>
        <% i++;
            }%>
    </table><%}%>
</body>
<script type="text/javascript">
    function editMail(mailId) {

        $.ajax({
            url: '<%=request.getContextPath()%>/admin/user/mailSmsDetails.jsp',
            data: {id: mailId, action: "edit", random: Math.random(1, 10)},
            async: true,
            type: 'GET',
            success: function (responseText, statusTxt, xhr) {
                var result = $.trim(responseText);

                document.getElementById('smsid').value = mailId;
                document.getElementById('typeSelector').value = result.substring(0, result.indexOf("&&&&"));
                result = result.substring(result.indexOf("&&&&") + 4, result.length);
                CKEDITOR.instances['subject'].setData(result.split("%%%%$$$$")[0]);
                CKEDITOR.instances['content'].setData(result.split("%%%%$$$$")[1]);


            }
        });

    }
    function deleteMail(mailId) {
        $.ajax({
            url: '<%=request.getContextPath()%>/admin/user/mailSmsDetails.jsp',
            data: {id: mailId, action: "delete", random: Math.random(1, 10)},
            async: true,
            type: 'GET',
            success: function (responseText, statusTxt, xhr) {
                var result = $.trim(responseText);

                $('#msg').remove();
                document.getElementById('errormsg').innerHTML = result;

                $('#mailId' + mailId).remove();
            }
        });

    }
</script>
</html>


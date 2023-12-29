<%-- 
    Document   : reimbursementEdit
    Created on : 17 Aug, 2016, 4:17:22 PM
    Author     : EMINENT
--%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Comparator"%>
<%@page import="java.util.Collections"%>
<%@page import="com.eminentlabs.mom.reimbursement.ReimbursementComments"%>
<%@page import="com.eminentlabs.mom.reimbursement.ReimbursementBill"%>
<%@page import="com.eminentlabs.mom.reimbursement.ReimbursementVouchers"%>
<%@page import="java.util.Map"%>
<%@page import="org.apache.log4j.Logger"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Cache-Control", "no-store");
    response.setDateHeader("Expires", 0);
    response.setHeader("Pragma", "no-cache");

    Logger logger = Logger.getLogger("MOM");
    String logoutcheck = (String) session.getAttribute("Name");
    if (logoutcheck == null) {
        logger.fatal("==============Session Expired===============");
%>
<jsp:forward page="../SessionExpired.jsp"></jsp:forward>
<%
    }

%>
<html>
    <html>
        <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS Solution</title>
        <link title=STYLE href="<%=request.getContextPath()%>/eminentech support files/main_ie.css?test=03082015" type="text/css" rel="STYLESHEET"/>
        <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/checkSubmit.js"></script>
        <link rel="stylesheet" href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.10.0/themes/cupertino/jquery-ui.css">
        <script src="//code.jquery.com/jquery-1.10.2.js"></script>
        <script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
        <style type="text/css">
            select,textArea {
                padding: 8px;
                border-radius: 6px;
                border: 1px solid #CCC;
                width: 350px;
            }

            .ui-datepicker-calendar {
                display: none;
            }
        </style>
        <script type="text/javascript">
            function createStatusbar(obj)
            {
                this.statusbar = $("<div class='statusbar '></div>");
                this.filename = $("<div class='filename'></div>").appendTo(this.statusbar);
                this.size = $("<div class='filesize'></div>").appendTo(this.statusbar);

                obj.after(this.statusbar);


                this.setFileNameSize = function (name, size)
                {
                    var sizeStr = "";
                    var sizeKB = size / 1024;
                    if (parseInt(sizeKB) > 1024)
                    {
                        var sizeMB = sizeKB / 1024;
                        sizeStr = sizeMB.toFixed(2) + " MB";
                    } else
                    {
                        sizeStr = sizeKB.toFixed(2) + " KB";
                    }

                    this.filename.html('File Name :' + name);
                    this.size.html('File Name :' + sizeStr);
                }

            }

            function handleFileUpload(files, obj)
            {

                var status = new createStatusbar(obj); //Using this we can set progress.
                status.setFileNameSize(files[0].name, files[0].size);
            }

        </script>
    </head>
    <body>
        <%@ include file="../header.jsp"%>
        <jsp:useBean id="rvc" class="com.eminentlabs.mom.reimbursement.controller.ReimbursementVouchersController"></jsp:useBean>
        <%rvc.editAll(request, pageContext.getServletContext());
            Integer userid_curr = (Integer) session.getAttribute("userid_curr");
            SimpleDateFormat sdf = new SimpleDateFormat("MMMM yyyy");
        %>
        <table cellpadding="0" cellspacing="0" width="100%">
            <tr style="height: 21px;" border="2" bgcolor="#C3D9FF">
                <td border="1" align="left" width="70%">
                    <font size="4" COLOR="#0000FF"><b>Expenses upload</b></font>
                </td>
            </tr>
        </table>
        <br/>
        <%if (rvc.getMessage() == null) {%>

        <%} else {%>
        <div class="success"><%=rvc.getMessage()%></div>
        <%}   %>

        <form name="theForm" enctype="multipart/form-data" method="post" action="editReimbursement.jsp" onsubmit="return validate();">
            <table style="width:100%;padding: 1%;" bgColor=#E8EEF7 border="0" >
                <%
                    if (rvc.getReimbursementVoucher().getStatus() == 5 || rvc.getReimbursementVoucher().getStatus() == -1) {%>
                <tr>
                    <td><strong>Requested By </strong></td>
                    <td>
                        <%=rvc.getAllEminentMembers().get(rvc.getReimbursementVoucher().getRequestedBy())%> 
                    </td>
                </tr>
                <tr>
                    <td><strong>Status </strong></td>
                    <td><%=rvc.statusMapCollection().get(rvc.getReimbursementVoucher().getStatus())%></td>
                </tr>
                <tr>
                    <td height="21" style="width: 15%;"><b>
                            Period
                        </b></td>                                
                    <td><%=sdf.format(rvc.getReimbursementVoucher().getPeriod())%></td>
                </tr>
                <tr>
                    <td><strong>Assigned To </strong></td>
                    <td><%=rvc.getAllEminentMembers().get(rvc.getReimbursementVoucher().getAssignedTo())%></td>
                </tr>
                <%} else {
                    if (rvc.getReimbursementModerator().contains(2) || rvc.getReimbursementModerator().contains(3)) {%>
                <tr style="height: 30px;">
                    <td ><strong>Requested By </strong></td>
                    <td >
                        <b> <%=rvc.getAllEminentMembers().get(rvc.getReimbursementVoucher().getRequestedBy())%> </b>
                    </td>
                </tr>
                <tr class="assigned-area">
                    <td ><strong>Assigned To </strong></td>
                    <td>

                        <select name="assignedTo" id="assignedTo">
                            <option value="" disabled="">Select</option>

                            <%for (Map.Entry<Integer, String> entry : rvc.getAllEminentMembers().entrySet()) {%>
                            <option value="<%=entry.getKey()%>"
                                    <%if (entry.getKey().equals(rvc.getReimbursementVoucher().getAssignedTo())) {%>
                                    selected
                                    <%}%>
                                    ><%=entry.getValue()%></option>
                            <%}%>
                        </select>

                    </td>
                </tr>
                <%}
                    if (rvc.getReimbursementVoucher().getRequestedBy().equals(userid_curr) || rvc.getReimbursementModerator().contains(2) || rvc.getReimbursementModerator().contains(3)) {%>
                <tr>
                    <td><strong>Status </strong></td>
                    <td>
                        <select name="status" id="status">
                            <option value="" disabled="">Select</option>

                            <%
                                if (rvc.getStatusMapCollectionByLogiUser().containsKey(rvc.getReimbursementVoucher().getStatus())) {

                                } else {%>
                            <option value="<%=rvc.getReimbursementVoucher().getStatus()%>" selected=""><%=rvc.statusMapCollection().get(rvc.getReimbursementVoucher().getStatus())%></option>
                            <% }
                                for (Map.Entry<Integer, String> entry : rvc.getStatusMapCollectionByLogiUser().entrySet()) {%>
                            <option value="<%=entry.getKey()%>" 
                                    <%if (entry.getKey().equals(rvc.getReimbursementVoucher().getStatus())) {%>
                                    selected
                                    <%}%>
                                    ><%=entry.getValue()%></option>
                            <%}%>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td height="21" style="width: 15%;"><b>
                            Period
                        </b></td> 

                    <td><input type="text" id="period" name="period" value="<%=sdf.format(rvc.getReimbursementVoucher().getPeriod())%>" class="date-picker" /></td>
                </tr>
                <tr>
                    <td height="21" style="width: 15%;">
                        <b>
                            Upload Excel
                        </b>
                    </td>                                
                    <td>
                        <input type="file" id="files" name="files" class="file" />
                    </td>
                </tr>
                <tr>
                    <td height="21" style="width: 15%;"><b>
                            Upload Bill
                        </b></td>                                
                    <td>
                        <input type="file" id="bills" name="bills" class="file" />
                    </td>
                </tr>
                <%} else {%>
                <tr>
                    <td><strong>Requested By </strong></td>
                    <td>
                        <%=rvc.getAllEminentMembers().get(rvc.getReimbursementVoucher().getRequestedBy())%> 
                    </td>
                </tr>
                <tr>
                    <td><strong>Status </strong></td>
                    <td><%=rvc.statusMapCollection().get(rvc.getReimbursementVoucher().getStatus())%></td>
                </tr>
                <tr>
                    <td height="21" style="width: 15%;"><b>
                            Period
                        </b></td>                                
                    <td><%=sdf.format(rvc.getReimbursementVoucher().getPeriod())%></td>
                </tr>
                <tr>
                    <td><strong>Assigned To </strong></td>
                    <td><%=rvc.getAllEminentMembers().get(rvc.getReimbursementVoucher().getAssignedTo())%></td>
                </tr>
                <%}%>
                <tr>
                    <td><strong>Voucher </strong></td>
                    <td>
                        <a href="<%=request.getContextPath()%>/Reimbursement_vouchers/<%=rvc.getReimbursementVoucher().getFileName()%>" target="_blank"><%=rvc.getReimbursementVoucher().getFileName()%></a>                 
                    </td>
                </tr>
                <%if (!rvc.getReimbursementVoucher().getReimbursementBillList().isEmpty()) {%>
                <tr>
                    <td><strong>Bills </strong></td>
                    <td>
                        <% for (ReimbursementBill bill : rvc.getReimbursementVoucher().getReimbursementBillList()) {%>
                        <a href="<%=request.getContextPath()%>/Reimbursement_vouchers/<%=bill.getFilename()%>" target="_blank"><%=bill.getFilename()%></a><br/>
                        <%}%>
                    </td>
                </tr>
                <%}%>
                 <%  if (rvc.getApproverMaintanance().getReimbursementApprover() == null) { %>
                        <div class="error" style="font-size: 14px;color: red; text-align: center;">Approver is not maintained</div>
                        <%} else {%>
                <tr class="commenter-area">
                    <td height="21" style="width: 15%;"><b>
                            Comments
                        </b>
                    </td>                                
                    <td><textarea id="comments" name="comments" cols="60" rows="4" ></textarea></td>
                </tr>
                <tr>
                    <td align="center"><img id="progressbar" style='display: none;' src='/eTracker/images/file-progress.gif'/></td>
                </tr>
                <tr>
                    <td>&nbsp;</td>
                    <td>
                        <input type="hidden" name="rvid" id="rvid" value="<%=rvc.getReimbursementVoucher().getRvid()%>"/>                       
                        <input type="submit" value="Update" name="submit" id="submit">
                            <input
                                type="reset" id="reset" value="Reset">
                    </td>
                </tr>             
                <%}}%>
            </table>
        </form>

        <div class="component subdivContainer"> 
            <table  class="overflow-y bordertable" id="materialTable" style="border-collapse:collapse;width: 100%;" >
                <thead>  
                    <tr style="">
                        <th class="bordertable"  style="width: 10%;color: #000;" align="center">CommentedBy</th>
                        <th class="bordertable"  style="width: 10%;color: #000;"align="center">TimeStamp</th>
                        <th class="bordertable"  align="center" style="color: #000;">Comments History</th>
                        <th class="bordertable" style="width: 10%;color: #000;" align="center">Status</th>
                        <th class="bordertable" style="width: 10%;color: #000;" align="center">CommentedTo</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        Collections.sort(rvc.getReimbursementVoucher().getReimbursementCommentsList(), new Comparator<ReimbursementComments>() {

                            public int compare(ReimbursementComments o1, ReimbursementComments o2) {

                                return o1.getCommentDate().compareTo(o2.getCommentDate());

                            }
                        });
                        for (ReimbursementComments reimbursementComments : rvc.getReimbursementVoucher().getReimbursementCommentsList()) {%>
                    <tr style="min-height: 21px;height: 21px;">
                        <td><%= rvc.getAllEminentMembers().get(reimbursementComments.getCommentedby())%></td>
                        <td><%= reimbursementComments.getCommentDate()%></td>
                        <td><%= reimbursementComments.getComments()%></td>
                        <td><%=rvc.statusMapCollection().get(reimbursementComments.getStatus())%></td>
                        <td><%= rvc.getAllEminentMembers().get(reimbursementComments.getCommentedto())%></td>
                    </tr>
                    <%}%>
                </tbody>
            </table>


            <script type="text/javascript">
                var date = new Date();
                date.setMonth(date.getMonth() + 1);
                $(function () {
                    $('.date-picker').datepicker({
                        changeMonth: true,
                        changeYear: true,
                        showButtonPanel: true,
                        dateFormat: 'MM yy',
                        showOn: "button",
                        buttonImage: "/eTracker/images/calendar.gif",
                        buttonImageOnly: true,
                        maxDate: date,
                        onClose: function () {
                            var iMonth = $("#ui-datepicker-div .ui-datepicker-month :selected").val();
                            var iYear = $("#ui-datepicker-div .ui-datepicker-year :selected").val();
                            $(this).datepicker('setDate', new Date(iYear, iMonth, 1));
                            $(this).datepicker('refresh');

                        },
                        beforeShow: function () {
                            if ((selDate = $(this).val()).length > 0) {

                                iYear = selDate.substring(selDate.length - 4, selDate.length);
                                iMonth = jQuery.inArray(selDate.substring(0, selDate.length - 5), $(this).datepicker('option', 'monthNames'));
//                        alert(iYear + "," +iMonth );
                                $(this).datepicker('option', 'defaultDate', new Date(iYear, iMonth, 1));
                                $(this).datepicker('setDate', new Date(iYear, iMonth, 1));
                            }
                        }

                    });

                });
                $(".date-picker").focus(function () {
                    $(".ui-datepicker-calendar").hide();
                    $("#ui-datepicker-div").position({
                        my: "center top",
                        at: "center bottom",
                        of: $(this)
                    });
                });
                $(document).on('change', '#status', function () {
                    var status = $("#status").val();
                    status = $.trim(status);
                    if (status == '2') {
                        $(".assigned-area").show();
                    } else {
                        $(".assigned-area").hide();
                    }
                });
                function validate()
                {
                <%
                    if (rvc.getReimbursementVoucher().getStatus() == 4 || rvc.getReimbursementVoucher().getStatus() == -1) {%>
                    var status = $("#status").val();
                    status = $.trim(status);
                    var period = $("#period").val();
                    period = $.trim(period);
                    if (status.length == 0) {
                        alert("Please select status");
                        return false;
                    }

                    if (period.length == 0) {
                        alert("Please pick period");
                        return false;
                    }
                    var extensions = new Array("xls", "xlsx");

                    var image_file = $('#files').val();

                    var image_length = $.trim(image_file).length;

                    var pos = image_file.lastIndexOf('.') + 1;

                    var ext = image_file.substring(pos, image_length);

                    var final_ext = ext.toLowerCase();

                    for (i = 0; i < extensions.length; i++)
                    {
                        if (extensions[i] == final_ext)
                        {
                            document.getElementById('submit').value = 'Processing';
                            document.getElementById('submit').disabled = true;
                            document.getElementById('progressbar').style.visibility = 'visible';
                            return true;
                        }
                    }
                    if (image_length == 0) {

                    } else {
                        alert("You must upload a file with one of the following extensions: " + extensions.join(', ') + ".");
                        return false;
                    }
                <%}%>



                    monitorSubmit();
                }
                $("#status").trigger("change");
                $("#submit,#reset").button();
            </script>
    </body>
</html>

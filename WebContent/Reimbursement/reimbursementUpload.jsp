<%-- 
    Document   : reimbursementUpload
    Created on : 16 Aug, 2016, 11:42:40 AM
    Author     : EMINENT
--%>

<%@page import="java.util.Arrays"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ResourceBundle"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.eminentlabs.mom.reimbursement.ReimbursementBill"%>
<%@page import="com.eminentlabs.mom.reimbursement.ReimbursementVouchers"%>
<%@page import="java.util.Map"%>
<%@page import="org.apache.log4j.Logger"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@  taglib  prefix="c"   uri="http://java.sun.com/jstl/core"  %>   
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
            <script src="<%=request.getContextPath()%>/javaScript/jquery.tablesorter1.js" type="text/javascript"></script>
            <script src="<%=request.getContextPath()%>/javaScript/jquery.tablesorter.widgets.js" type="text/javascript"></script>    
            <link rel="stylesheet" href="<%=request.getContextPath()%>/css/theme.blue1.css?test=3">
            <script type="text/javascript">
                function showPrint(issueid) {
                    window.open("<%=request.getContextPath()%>/viewIssueDetails.jsp?issueid=" + issueid);
                }
                function createStatusbar(obj)
                {
                    this.statusbar = $("<div class='statusbar '></div>");
                    this.filename = $("<div class='filename'></div>").appendTo(this.statusbar);
                    this.size = $("<div class='filesize'></div>").appendTo(this.statusbar);

                    obj.after(this.statusbar);


                    this.setFileNameSize = function(name, size)
                    {
                        var sizeStr = "";
                        var sizeKB = size / 1024;
                        if (parseInt(sizeKB) > 1024)
                        {
                            var sizeMB = sizeKB / 1024;
                            sizeStr = sizeMB.toFixed(2) + " MB";
                        }
                        else
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
            <style type="text/css">
                select,textArea {
                    padding: 6px;
                    border-radius: 6px;
                    border: 1px solid #CCC;
                    width: 190px;
                }
                .ui-datepicker-calendar {
                    display: none;
                }
            </style>

        </head>
        <body>
            <%@ include file="../header.jsp"%>
            <jsp:useBean id="rvc" class="com.eminentlabs.mom.reimbursement.controller.ReimbursementVouchersController"></jsp:useBean>
            <jsp:useBean id="mas" class="com.eminent.issue.formbean.MyAsignmentIssues" /> 
    <jsp:useBean id="smmc" class="com.eminentlabs.mom.controller.SendMomMaintainController"></jsp:useBean>

            <%String mail = (String) session.getAttribute("theName");
                rvc.setAll(request, pageContext.getServletContext());
                ResourceBundle rb = ResourceBundle.getBundle("Resources");
                String mods = rb.getString("mom-mods");
                String noOfIds[] = mods.split(",");
                List<String> modList = Arrays.asList(noOfIds);
                int assignedto = (Integer) session.getAttribute("userid_curr");
                SimpleDateFormat sdf = new SimpleDateFormat("MMM yyyy");
                int wrmSize = mas.wrmIssues().size();
                 smmc.getLocationNBranch(assignedto);
            %>

            <table cellpadding="0" cellspacing="0" width="100%">
                <tr style="height: 21px;" border="2" bgcolor="#C3D9FF">
                    <td border="1" align="left" width="70%">
                        <font size="4" COLOR="#0000FF"><b>Expenses upload</b></font>
                    </td>
                </tr>
            </table>
            <br/>
            <table cellpadding="0" cellspacing="0" width="100%">

                <tr>
                    <td style="height: 25px;">
                        <a href="<%=request.getContextPath()%>/MOM/addTask.jsp"> Add Issue / Task</a>&nbsp;&nbsp;&nbsp;&nbsp;
                        <a href="<%=request.getContextPath()%>/MOM/viewTask.jsp" style="cursor: pointer;">View Issue / Task</a> &nbsp;&nbsp;&nbsp;
<%if (smmc.getSendMomMaintenance() != null && smmc.getSendMomMaintenance().getUserId() != null && smmc.getSendMomMaintenance().getUserId().intValue() == assignedto) {
                    %>
                        <a href="<%=request.getContextPath()%>/MOM/mom.jsp" style="cursor: pointer;">Send MOM</a> &nbsp;&nbsp;&nbsp;
                        <a href="<%=request.getContextPath()%>/MOM/plannedIssuesReport.jsp" style="cursor: pointer;">Planned Issue Report</a> &nbsp;&nbsp;&nbsp;
                        <a href="<%=request.getContextPath()%>/MOM/feedBackCommand.jsp" style="cursor: pointer;">FeedBack</a> &nbsp;&nbsp;&nbsp;
                        <a title="Fine Management" href="<%=request.getContextPath()%>/MOM/addFineAmtForUser.jsp" style="cursor: pointer;">Fine Mgmt</a> &nbsp;&nbsp;
                        <a href="<%=request.getContextPath()%>/MOM/projectWiseClosedReport.jsp" style="cursor: pointer;">PM'S Rank</a> &nbsp;&nbsp;&nbsp;
                        <%                 } else {
                        %>
                        <a href="<%=request.getContextPath()%>/MOM/fineAmtReort.jsp" style="cursor: pointer;">Fine Amount </a> &nbsp;&nbsp;&nbsp;
                        <a href="<%=request.getContextPath()%>/MOM/fineReport.jsp" style="cursor: pointer;">Fine Report</a> &nbsp;&nbsp;&nbsp;
                        <%}%>
                        <a href="weekPerformers.jsp" style="cursor: pointer;">Team Performance</a> &nbsp;&nbsp;&nbsp;
                        <a href="<%=request.getContextPath()%>/MOM/bestPMNTeam.jsp" style="cursor: pointer;">Best PM/Team</a> &nbsp;&nbsp;&nbsp;
                        <a href="<%=request.getContextPath()%>/MOM/dueDateReport.jsp" style="cursor: pointer; ">DDR</a> &nbsp;&nbsp;&nbsp;
                        <a href="<%=request.getContextPath()%>/MOM/wrmIssues.jsp" style="cursor: pointer; ">WRM Issues (<%=wrmSize%>)</a> &nbsp;&nbsp;&nbsp;
                        <a href="<%=request.getContextPath()%>/Reimbursement/reimbursementUpload.jsp" style="cursor: pointer;font-weight: bold; ">Reimbursement</a> &nbsp;&nbsp;&nbsp;
                        <%
                            if (rvc.getReimbursementModerator().contains(2) || assignedto==104|| mail.equals("accounts@eminentlabs.net")) {
                        %>
                        <a href="<%=request.getContextPath()%>/Reimbursement/reimbursementSearch.jsp" style="cursor: pointer; ">Reimbursement Search</a> &nbsp;&nbsp;&nbsp;
                        <%}%>

                    </td>
                </tr>
            </table>
            <%if (rvc.getMessage() == null) {%>

            <%} else {%>
            <div class="success" style="color: #00f;"><%=rvc.getMessage()%></div>
            <%}%>
            <%if (request.getParameter("message") == null) {%>

            <%} else {%>
            <div class="success" style="color: #00f;"><%=request.getParameter("message")%></div>
            <%}%>
            <br/>
            <form name="theForm" enctype="multipart/form-data" method="post" action="reimbursementUpload.jsp" onsubmit="return validate()">
                <table width="70%" bgColor=#E8EEF7 border="0" align="center">
                    <% if (rvc.getReimbursementModerator().contains(2)) {%>
                    <tr>
                        <td><strong>Requested By </strong></td>
                        <td>

                            <select name="requestedBy" id="requestedBy">
                                <option value="">Select</option>

                                <%for (Map.Entry<Integer, String> userBean : rvc.getMember().entrySet()) {%>
                                <option value="<%=userBean.getKey()%>"><%=userBean.getValue()%></option>
                                <%}%>
                            </select>

                        </td>
                    </tr>

                    <%} %>
                    <tr>
                        <td><strong>Status </strong></td>
                        <td>
                            <select name="status" id="status">
                                <option value="" disabled="">Select</option>

                                <%
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
                        <td><input type="text" id="period" name="period" class="date-picker" /></td>
                    </tr>
                    <tr>
                        <td height="21" style="width: 15%;"><b>
                                Upload Excel
                            </b></td>                                
                        <td><input type="file" id="files" name="files" class="file" /></td>
                    </tr>
                    <tr>

                        <td height="21" style="width: 15%;"><b>
                                Upload Bill
                            </b></td>                                
                        <td><input type="file" id="bills" name="bills" class="file" /></td>
                    </tr>

                    <tr>
                        <td align="center"><img id="progressbar" style='display: none;' src='/eTracker/images/file-progress.gif'/></td>
                    </tr>
                    <tr>
                        <td></td><td ><a target="_blank" href="<%=request.getContextPath()%>/Reimbursement_vouchers/ReimbursementVoucher.xls">Click here to download format</a></td>
                    </tr>
                    <tr>
                        <td>&nbsp;</td>
                        <td><input type="submit" value="Submit" name="submit" id="submit"> <input
                                type="reset" id="reset" value=" Reset "></td>
                    </tr>             

                </table>
            </form>
            <br/>
            <div >
                <table style="width: 100%;" id="filtersort">
                    <thead style="background-color: #C3D9FF;height: 21px;font-weight: bold; ">
                    <th>S.No</th>
                    <th class="filter-select filter-match" data-placeholder="All">Requested By</th>
                    <th>Period</th>
                    <th class="filter-select filter-match" data-placeholder="All">Status</th>
                    <th class="filter-select filter-match" data-placeholder="All">Assigned To</th>
                    <th>Created On</th>
                    <th>Excel & Bills</th>
                    <th class="filter-false">Manage</th>
                    </thead>
                    <%int i = 0;
                        for (ReimbursementVouchers reimbursementVouchers : rvc.getReimbursementVoucherses()) {
                            if ((i % 2) == 0) {
                    %>
                    <tr class="zebralinealter" style="height: 21px;">
                        <%} else {%>
                    <tr class="zebraline" style="height: 21px;">
                        <%}
                            i++;%>
                        <td class="background"><%=i%></td>
                        <td class="background"><a href="<%=request.getContextPath()%>/Reimbursement/reimbursementEdit.jsp?rvid=<%=reimbursementVouchers.getRvid()%>" ><%=rvc.getAllEminentMembers().get(reimbursementVouchers.getRequestedBy())%></a></td>
                        <td class="background"><%=sdf.format(reimbursementVouchers.getPeriod())%></td>
                        <td class="background"><%=rvc.statusMapCollection().get(reimbursementVouchers.getStatus())%></td>
                        <td class="background" title="<%=rvc.getAllEminentMembers().get(reimbursementVouchers.getUploadedBy())%>"><%=rvc.getAllEminentMembers().get(reimbursementVouchers.getAssignedTo())%></td>
                        <td class="background" title="<fmt:formatDate pattern="dd-MMM-yyyy HH:mm:ss" value="<%=reimbursementVouchers.getModifiedon()%>"/>"><fmt:formatDate pattern="dd-MMM-yyyy HH:mm:ss" value="<%=reimbursementVouchers.getCreatedon()%>"/></td>
                        <td class="background"><a href="<%=request.getContextPath()%>/Reimbursement_vouchers/<%=reimbursementVouchers.getFileName()%>" target="_blank"><%=reimbursementVouchers.getFileName()%></a>

                            <%for (ReimbursementBill reimbursementBill : reimbursementVouchers.getReimbursementBillList()) {%>

                            <div><a href="<%=request.getContextPath()%>/Reimbursement_vouchers/<%=reimbursementBill.getFilename()%>" target="_blank"><%=reimbursementBill.getFilename()%></a>
                                <%if (reimbursementVouchers.getStatus() == 0) {%>
                                <img src="<%=request.getContextPath()%>/images/remove.gif" alt="Remove Bil" style="cursor: pointer;" class="removebill" billid="<%=reimbursementBill.getBid()%>"/>
                                <%}%>
                            </div>
                            <%}%>
                        </td>

                        <td class="background">
                            <%if (reimbursementVouchers.getStatus() == 0) {%>
                            <a href="javascript:;" id="<%=reimbursementVouchers.getRvid()%>" class="rvDel">Delete</a>

                            <%} else {%>
                            <%}%>
                        </td>
                    </tr>
                    <%}%>
                </table>
            </div>
            <script type="text/javascript">
                $("#submit").click(function() {

                });
                $(".rvDel").click(function() {
                    var id = $(this).attr('id');
                    var curr = $(this);
                    if (confirm("Do you want to delete it?")) {
                        $.ajax({
                            url: '<%=request.getContextPath()%>/Reimbursement/deleteReimbursement.jsp',
                            data: {rvid: id, rand: Math.random(1, 10)},
                            async: false,
                            type: 'POST',
                            success: function(responseText, statusTxt, xhr) {

                                if (statusTxt == "success") {
                                    var result = $.trim(responseText);
                                    if (result === "true") {
                                        curr.parent().parent().remove();
                                        $(".message").html("Expences removed successfully.");

                                    } else {
                                        $(".message").html("Please Try/Again");
                                    }
                                }
                            }
                        });
                    } else {

                    }
                });
                var date = new Date();
                $(function() {
                    $('.date-picker').datepicker({
                        changeMonth: true,
                        changeYear: true,
                        showButtonPanel: true,
                        dateFormat: 'MM yy',
                        showOn: "button",
                        buttonImage: "/eTracker/images/calendar.gif",
                        buttonImageOnly: true,
                        maxDate: date,
                        onClose: function() {
                            var iMonth = $("#ui-datepicker-div .ui-datepicker-month :selected").val();
                            var iYear = $("#ui-datepicker-div .ui-datepicker-year :selected").val();
                            $(this).datepicker('setDate', new Date(iYear, iMonth, 1));
                            $(this).datepicker('refresh');

                        },
                        beforeShow: function() {
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
                $(".date-picker").focus(function() {
                    $(".ui-datepicker-calendar").hide();
                    $("#ui-datepicker-div").position({
                        my: "center top",
                        at: "center bottom",
                        of: $(this)
                    });
                });

                $(".removebill").click(function() {
                    var id = $(this).attr('billid');
                    var curr = $(this);
                    if (confirm("Do you want to delete bill?")) {
                        $.ajax({
                            url: '<%=request.getContextPath()%>/Reimbursement/deleteReimbursementBill.jsp',
                            data: {rbid: id, rand: Math.random(1, 10)},
                            async: false,
                            type: 'POST',
                            success: function(responseText, statusTxt, xhr) {

                                if (statusTxt == "success") {
                                    var result = $.trim(responseText);
                                    if (result === "true") {
                                        curr.parent().remove();
                                        $(".message").html("Bill removed successfully.");

                                    } else {
                                        $(".message").html("Please Try/Again");
                                    }
                                }
                            }
                        });
                    } else {

                    }
                });
            </script>
            <script type="text/javascript">

                $(document).on('change', '#status', function() {
                    var status = $("#status").val();
                    status = $.trim(status);
                    if (status == '2') {
                        $(".assigned-area").show();
                    } else {
                        $(".assigned-area").hide();
                    }
                });

                $("#status").trigger("change");
                $("#submit,#reset").button();
                function validate()
                {
                    var status = $("#status").val();
                    status = $.trim(status);

                    var period = $("#period").val();
                    period = $.trim(period);
                    if (status.length == 0) {
                        alert("Please select status");
                        return false;
                    }
                <% if (rvc.getReimbursementModerator().contains(2)) {%>
                    var requestedBy = $("#requestedBy").val();
                    requestedBy = $.trim(requestedBy);
                    if (requestedBy.length == 0) {
                        alert("Please selecte requested by");
                        return false;
                    }
                <%}%>
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

                    alert("You must upload a file with one of the following extensions: " + extensions.join(', ') + ".");
                    return false;
                    monitorSubmit();
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
                $(function() {

                    // call the tablesorter plugin
                    $("#filtersort").tablesorter({
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
                            }

                        }

                    });
                });
            </script>
        </body>
    </html>

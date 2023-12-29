<%-- 
    Document   : addTargetCountAjax
    Created on : 31 May, 2016, 9:59:12 AM
    Author     : admin
--%>

<%@page import="com.pack.controller.formbean.EditmoduleFormBean"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
        <meta http-equiv="X-UA-Compatible" content="IE=Edge">

    </head>
    <body>
        <jsp:useBean id="vmc" class="com.pack.controller.ViewModulesController"/>
        <%
            List<EditmoduleFormBean> list = vmc.addTargetCountAjax(request);
        %>
        <div>
            <span id="msg"></span>
            <div style="height:300px;overflow:auto;">
                <table>
                    <tr>
                        <th><b> Module</b></th><th><b>Target</b></th>
                    <tr>
                        <%for (EditmoduleFormBean emfb : list) {%>
                    <tr>
                        <td>
                            <b><%=emfb.getModule()%></b>
                            <input type="hidden" name="mid" value="<%=emfb.getModuleid()%>" >
                        </td> 
                        <td>
                            <input type="text" name="moduleTarget" class="moduleTarget"   maxlength="10" value="<%=((emfb.getTarget() == 0) ? "" : emfb.getTarget())%>" style="font-size: 14px;min-width:180px;">
                            <input type="hidden" name="moduleTargetId" class="moduleTargetId" value="<%=emfb.getTargetId()%>">
                        </td> 
                    </tr>
                    <%}%>

                </table>
            </div>

          <input type="button" class="addtarget ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" value="Submit" >
        </div>

    </body>
    <style>
        .error2{
            color: red;
        }
        .addtarget{ 
            border: 1px solid #79b7e7;
            background: #d0e5f5 ;
            font-weight: bold;
            color: #1d5987;
            cursor: pointer;
            border-radius: 2px;
            margin-left:50px;
        }
       
    </style>
    <script>

        $(".addtarget").on("click", function () {
            $('span.error2').remove();
            var count = 0;
            $('input[name=moduleTarget]').each(function () {
                var moduleTarget = $.trim($(this).val());
                if (moduleTarget.length == 0)
                {
                } else if (isNaN(moduleTarget)) {
                    $("<span class='error2'>Please enter the Target only digits</span>").insertAfter(this);
                    $(this).val('');
                    $(this).focus();
                    count = 1;
                } else if (parseInt(moduleTarget) > 999) {
                    $("<span class='error2'>Please enter less than 999 target.</span>").insertAfter(this);
                    $(this).val('');
                    $(this).focus();
                    count = 1;
                }
            });
            var currtform = "";
            if (count == 0) {
                $('input[name=mid]').each(function () {
                    var currval = $.trim($(this).val());
                    var currtarget = $(this).closest('td').next('td').find('.moduleTarget').val();
                    var tid = $(this).closest('td').next('td').find('.moduleTargetId').val();
                    if ($.trim(currtarget).length == 0) {
                        currtarget = 0;
                    }
                    currtform = currtform + currval + "-" + currtarget + "-" + tid + "\n";
                });
            }
            if ($.trim(currtform).length == 0 && count == 1) {
            } else {
                $.ajax({
                    url: '<%=request.getContextPath()%>/admin/project/saveUpdateModuleTarget.jsp',
                    data: {currtform: currtform, random: Math.random(1, 10)},
                    async: true,
                    type: 'Post',
                    success: function (responseText, statusTxt, xhr) {
                        if (statusTxt === "success") {
                            var result = $.trim(responseText);
                            if (result == "false") {
                                $("<span class='error2'>Please Try/Agin</span>").insertAfter("#msg");
                            } else {
                                $("<span class='error2'style='color:green'>Target save successfully.</span>").insertAfter("#msg");
                                updatedCount();
                                $(".addTargetCount").dialog("close");
                            }
                        } else {
                            $("<span class='error2'>Please Try/Agin</span>").insertAfter("#msg");
                        }
                    }
                });
            }
        });
        $(document).ready(function () {
            $(".moduleTarget").keypress(function (e) {
                if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {
                    $("#errmsg").html("Digits Only").show().fadeOut("slow");
                    return false;
                }
            });
        });
    </script>
</html>
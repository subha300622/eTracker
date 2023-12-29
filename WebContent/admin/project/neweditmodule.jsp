<%-- 
    Document   : neweditmodule
    Created on : 25 Apr, 2016, 12:46:25 PM
    Author     : admin
--%>
<%@page import="com.pack.controller.formbean.EditmoduleFormBean"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.eminent.util.GetProjectMembers"%>
<%@ page language="java" contentType="text/html"
         pageEncoding="UTF-8"%>
<%@ page import="org.apache.log4j.*"%>
<%

    Logger logger = Logger.getLogger("Edit Module");

    String logoutcheck = (String) session.getAttribute("Name");
    if (logoutcheck == null) {
%>
<jsp:forward page="../SessionExpired.jsp"></jsp:forward>
<%
    }
%>
<!DOCTYPE HTML PUBLIC "-//W3 C//DTD HTML 4.01 Transitional//EN">

<html>

    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
        <meta http-equiv="Content-Type" content="text/html ">
        <LINK title=STYLE
              href="<%= request.getContextPath()%>/eminentech support files/main_ie.css"
              type=text/css rel=STYLESHEET>
        <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/checkSubmit.js"></script>
        <title>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS
            Solution</title>


        <!-- Start Of Java Script For Front End Validation -->

        <SCRIPT type="text/javascript">

            /* Function To Validate The Input Form Data */
            function fun(theForm)
            {

                /* This Loop Checks Whether There Is Any Integer Present In The Project Name Field */
                if ((theForm.module.value) === '')
                {
                    alert('Please enter the module name ');
                    document.theForm.module.value = "";
                    theForm.module.focus();
                    return false;
                }
                var moduleTarget = $.trim($("#moduleTarget").val());
                moduleTarget = parseInt(moduleTarget);
                if(isNaN(moduleTarget)){
                   alert('Enter only digits');
                    $("#moduleTarget").val('');
                    $("#moduleTarget").focus();
                    return false;
                }else if(moduleTarget>999){
                    alert('Enter only three digits ');
                    $("#moduleTarget").val('');
                    $("#moduleTarget").focus();
                    return false;
                }

                if (theForm.module.value.length > 25)
                {
                    alert('Size of the module name should be less than 25 characters');
                    document.theForm.module.value = "";
                    theForm.module.focus();
                    theForm.module.select();
                    return false;
                }
                monitorSubmit();
            }
//            function findDuplicateModule() {
//                var moduleName = $('#module').val();
//                alert(moduleName);
//                var projectId = $('#pid').val();
//                if (moduleName !== "") {
//                    $.ajax({
//                        type: "POST",
//                        url: "./findDuplicateModule.jsp",
//                        data: "module=" + moduleName + "&pid=" + projectId,
//                        success: function (response) {
//                            // we have the response
//                            alert(response);
//                            if (response === "false") {
//                                return true;
//                            } else {
//                                $('#module').val('');
//                                alert(moduleName + ' Module already exists');
//                                return false;
//                            }
//                            //                        $("#teamFinal option:contains(" + response + ")").attr('selected', 'selected');
//                        },
//                        error: function (e) {
//                            alert('Error: ' + e);
//                        }
//                    });
//                }
//            }

            function findDuplicateModule() {
                var moduleName = $('#module').val();
                var projectId = $('#pid').val();
                if (moduleName !== "") {
                    $.ajax({
                        url: 'alreadyModuleExist.jsp',
                        data: {pid: projectId, mname: moduleName, random: Math.random(1, 10)},
                        async: false,
                        type: 'GET',
                        success: function (responseText, statusTxt, xhr) {
                            if (statusTxt === "success") {
                                var result = $.trim(responseText);
                                if (result == "false") {
                                    return true;
                                } else if (result == "true") {
                                    $('#module').val('');
                                    alert(moduleName + ' Module already exists');
                                    return false;
                                }
                            } else {
                                alert("Something went wrong. Please try again.");
                            }
                        }
                    });
                }
            }
            /** Function To Check Whether There Is Any Integer Present In The Form Input From The User */

            function isPositiveInteger(str)
            {
                var pattern = "abcdefghijklmnopqrstuvwxyz. ABCDEFGHIJKLMNOPQRSTUVWXYZ-'"
                var i = 0;
                do
                {
                    var pos = 0;
                    for (var j = 0; j < pattern.length; j++)
                        if (str.charAt(i) === pattern.charAt(j))
                        {
                            pos = 1;
                            break;
                        }
                    i++;
                } while (pos === 1 && i < str.length);
                if (pos === 0)
                    return false;
                return true;
            }
        </SCRIPT>
    </head>


    <%@ page import="com.pack.*,pack.eminent.encryption.*"%>
    <!-- End Of Java Script Code -->
    <body>

        <jsp:include page="/header.jsp" />


        <!-- Table To Display The Formatted String "Add New User" -->

        <table cellpadding="0" cellspacing="0" width="100%">

            <tr border="2" bgcolor="#C3D9FF">

                <td border="1" align="left" width="100%"><font size="4"
                                                               COLOR="#0000FF"><b> Edit Module</b> </font> <FONT SIZE="3"
                                                               COLOR="#0000FF"> </FONT></td>

            </tr>

        </table>
        <BR>
        <!-- Table To Display The Form Input Elements First Name, Last Name, Email Id, Password, Confirm Password, Company, Phone, Mobile  And The Submit, Reset Buttons-->

        <FORM name="theForm" onsubmit='return fun(this)'
              action="<%=request.getContextPath()%>/admin/project/moduleupdate.jsp"
              method="post"><%@ page import="java.sql.*"%>
            <jsp:useBean id="apmController" class="com.pack.controller.AdminEditModuleController" /> <%
                EditmoduleFormBean emfb = apmController.getAllModuleByProject(request);
            %>

            <TABLE width="100%" bgColor=#e8eef7 border="0">
                <TBODY>
                    <tr>
                        <td><input type="hidden" name="mid"  maxlength="20" size=20
                                   value="<%=emfb.getModuleid()%>"> <strong class="style20"></strong></td>
                    </tr>
                    <tr>

                        <td width="20%"><strong>Module </strong></td>
                        <td><input type="text" name="module" id="module" maxlength="20" size=20
                                   value="<%=StringUtil.encodeHtmlTag(emfb.getModule())%>" onblur="findDuplicateModule()"> <span class="style13"></span></td>
                    </tr>
                    <%if (!emfb.getTeamMembers().isEmpty() && emfb.getCategory().equalsIgnoreCase("SAP Project")) {%>
                    <tr>
                        <td width="10%"><strong>Customer Process Owner</strong></td>
                        <td><select name="customerOwner" 
                                    >
                                <option value="">--Select One--</option>
                                <%for (Map.Entry<String, String> team : emfb.getTeamMembers().entrySet()) {
                                        if (!emfb.getEminentUsers().containsKey(Integer.parseInt(team.getKey()))) {
                                            if (emfb.getcOwner() == Integer.parseInt(team.getKey())) {%>
                                <option value="<%=team.getKey()%>" selected><%=team.getValue()%></option>
                                <%} else {
                                %>

                                <option value="<%=team.getKey()%>" ><%=team.getValue()%></option>
                                <%}
                                        }
                                    }%>
                            </select> </td>
                    </tr>

                    <tr>
                        <td width="10%"><strong>Internal Process Owner</strong></td>
                        <td><select name="internalOwner" >
                                <option value="">--Select One--</option>
                                <%for (Map.Entry<String, String> team : emfb.getTeamMembers().entrySet()) {

                                        if (emfb.getiOwner() == Integer.parseInt(team.getKey())) {%>
                                <option value="<%=team.getKey()%>" selected><%=team.getValue()%></option>
                                <%} else {
                                %>
                                <option value="<%=team.getKey()%>" ><%=team.getValue()%></option>
                                <%}
                                    }%>

                            </select></td>
                    </tr>
                    <tr>
                        <td width="10%"><strong>Target</strong></td>
                        <td><input type="text" name="moduleTarget" id="moduleTarget"  value="<%=emfb.getTarget()%>" maxlength="10"><input type="hidden" value="<%=emfb.getTargetId()%>" name="targetId">  <span id="errmsg" style="color: red"></span></td>

                    </tr>
                    <%}%>
                    <tr>
                        <td><input type="hidden" name="pid" id="pid" maxlength="20" size=20
                                   value="<%=emfb.getPid()%>"> <strong class="style20"></strong></td>
                    </tr>
                    <TR>
                        <TD>&nbsp;</TD>
                        <TD><INPUT type=submit value=Update name=submit id="submit">&nbsp;&nbsp;&nbsp;&nbsp;<INPUT type="reset"  name=reset id="reset">
                        </TD>
                    </TR>
                </TBODY>
            </TABLE>
        </FORM>
        <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/jquery-1.10.2.js"></script>
        <script>
                                       $(document).ready(function () {
                                           $("#moduleTarget").keypress(function (e) {
                                               if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {
                                                   $("#errmsg").html("Digits Only").show().fadeOut("slow");
                                                   return false;
                                               }
                                           });
                                       });
        </script>

        <BR>
    </body>
</html>
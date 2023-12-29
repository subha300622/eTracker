<%@ page language="java" contentType="text/html"
         pageEncoding="UTF-8"%>
<%
    String logoutcheck = (String) session.getAttribute("Name");
    if (logoutcheck == null) {
%>
<jsp:forward page="../SessionExpired.jsp"></jsp:forward>
<%
    }
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
        <meta http-equiv="Content-Type" content="text/html ">
        <LINK title=STYLE
              href="<%= request.getContextPath()%>/eminentech support files/main_ie.css"
              type="text/css" rel="STYLESHEET">
        <title>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS
            Solution</title>
        <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/jquery-1.10.2.js"></script>

    </head>

    <!-- Start Of Java Script For Front End Validation -->

    <SCRIPT language=JAVASCRIPT type="text/javascript">


        /** Java Script Function For Trimming A String To Get Only The Required String Input */



        /** Function To Set Focus On The Project Name Field In The Form */



        /* Function To Set Focus On The Project Name Field In The Form */
        function check(theForm) {
            $("#moduleExist").html('');
            var module = document.theForm.mname.value;
            var moduleTarget = $.trim($('#moduleTarget').val());

            if (moduleTarget.length == 0) {
                alert('Please enter the Target ');
                $("#moduleTarget").focus();
                return  false;
            } else if (isNaN(moduleTarget)) {
                alert('Please enter the Target only digits ');
                $("#moduleTarget").val('');
                $("#moduleTarget").focus();
                return  false;
            } else if (parseInt(moduleTarget) > 999) {
                alert('Please enter the  only three digits no ');
                $("#moduleTarget").val('');
                $("#moduleTarget").focus();
                return  false;
            } else if (module == '') {
                alert('Please enter the module name ');
                document.theForm.mname.value = "";
                theForm.mname.focus();
                return  false;
            } else if (document.theForm.mname.value.length > 20) {
                alert('Size of the module name should be less than 20 characters');
                document.theForm.mname.value = "";
                theForm.mname.focus();
                return  false;
            } else if (module != '') {
                var pid = $("#pid").val();
                $.ajax({
                    url: 'alreadyModuleExist.jsp',
                    data: {pid: pid, mname: module, random: Math.random(1, 10)},
                    async: false,
                    type: 'GET',
                    success: function (responseText, statusTxt, xhr) {
                        if (statusTxt === "success") {
                            var result = $.trim(responseText);
                            if (result == "false") {
                                if (confirm("Do you want to Add One more Module?.."))
                                {
                                    location = 'addNewModuleTwo.jsp?mname=' + module + '&moduleTarget=' + moduleTarget;
                                } else {
                                    location = 'addNewModules.jsp?mname=' + module + '&moduleTarget=' + moduleTarget;
                                }
                            } else if (result == "true") {
                                $("#moduleExist").html("This Module Already Exist.Please enter another Module");
                                return  false;
                            } else {
                                alert("Something went wrong. Please try again.");
                                return  false;
                            }
                        } else {
                            alert("Something went wrong. Please try again.");
                            return  false;
                        }
                    }
                });
            }
        }

        /** Function To Check Whether There Is Any Integer Present In The Form Input From The User */


        function noenter() {
            if ((window.event && window.event.keyCode == 13) && (document.theForm.mname.value) == '') {
                alert('Please enter the module name ');
                document.theForm.mname.value = "";
                theForm.mname.focus();
            }
            return !(window.event && window.event.keyCode == 13);
        }
        function setFocus() {
            document.theForm.mname.focus();
        }
        window.onload = setFocus;
        //-->

    </SCRIPT>

    <!-- End Of Java Script Code -->

    <body>

        <!-- Declaring The Form And Its Attributes -->

        <FORM name=theForm onsubmit="return fun(this)" method=post
              onReset="return setFocus()"><!-- Table To Display Current User And The Links For User Profile, Mails, And Logout -->

            <jsp:include page="/header.jsp" /> <br>
            <br>
            <br>
            <br>
            <br>
            <br>
            <br>
            <br>
            <br>
            <br>
            <br>
            <br>
            <!-- Table To Display The Formatted String "Add New Project" -->

            <table width="35%" border="0" align="center" bgcolor="E8EEF7">

                <tr border="2">

                    <td border="1" align="center" width="100%"><font size="4"
                                                                     COLOR="#0000FF"><b> Add New Modules</b> </font> <FONT SIZE="3"
                                                                              COLOR="#0000FF"> </FONT></td>

                </tr>

            </table>



            <!-- Table To Display The Form Input Elements Project Name, Version, Project Manager, Customer  And The Submit, Reset Buttons-->

            <TABLE width="35%" border="0" align="center" bgcolor="#E8EEF7">

                <TBODY>

                    <tr>

                        <td width="35%"><strong>Module Name </strong></td>

                        <td><input type="text" name="mname" maxlength="20" size="20"
                                   onkeypress="return noenter()"> <strong class="style20"></strong>
                        </td>
                        <td><input type="hidden" name="pid" maxlength="20" size="20"
                                   value="<%=session.getAttribute("projectid")%>"> <strong
                                   class="style20"></strong></td>
                    </tr>
                    <tr>
                        <td width="10%"><strong>Target</strong></td>
                        <td><input type="text" name="moduleTarget" id="moduleTarget"   maxlength="10"> <span id="errmsg" style="color: red"></span></td>

                    </tr>

                    <TR cols=2>
                        <td align="right"><INPUT type=button value="Submit"
                                                 name="submit" onClick='check(this.form)'></td>
                        <td align="left"><INPUT type=reset value="Reset" name="reset"></td>
                    </TR>
                    <tr>
                        <td colspan="2">
                            <span id="moduleExist" style="color: red"></span>
                        </td>
                    </tr>



                </TBODY>

            </TABLE>



        </FORM>
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

    </body>

</html>
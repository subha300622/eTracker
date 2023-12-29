<%@page import="com.eminentlabs.crm.persistence.CrmCompanyPlants"%>
<%@page import="com.eminentlabs.crm.persistence.CrmCompanySales"%>
<%@page import="com.eminentlabs.crm.persistence.CrmCompetitors"%>
<%@page import="com.eminentlabs.crm.persistence.ContactWorkHistory"%>
<%@page import="com.eminentlabs.crm.CRMUtil"%>
<%@ page language="java" contentType="text/html"
         pageEncoding="UTF-8"%>
<%@ page import="java.sql.*,pack.eminent.encryption.*,java.util.*,com.eminent.util.*,org.apache.log4j.*,java.text.*"%>
<%

    Logger logger = Logger.getLogger("MyCRM Contact Issue View");

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
    <LINK title=STYLE href="<%= request.getContextPath()%>/eminentech support files/main_ie.css" type=text/css rel=STYLESHEET>
    <title>eTracker&#0153; - Eminentlabs&#0153; CRM,APM,ERM and PTS Solution</title>
    <script type="text/javascript" src="<%= request.getContextPath()%>/ckeditor_4.5.9_standard/ckeditor/ckeditor.js"></script>
    <script src="<%=request.getContextPath()%>/javaScript/jquery-1.10.2.js"></script>  
    <script src="<%=request.getContextPath()%>/javaScript/jquery-ui.js"></script>
</head>
<script language=javascript	src="<%= request.getContextPath()%>/eminentech support files/datetimepicker.js"></script>
<script language=javascript src="<%= request.getContextPath()%>/javaScript/checkSubmit.js"></script>

<style>
    .sales,.employees,.itSpend,.erpSpend {
        width: 110px;
    }
</style>
<SCRIPT>

    function createRequest() {
        var reqObj = null;
        try {
            reqObj = new ActiveXObject("Msxml2.XMLHTTP");
        } catch (err) {
            try {
                reqObj = new ActiveXObject("Microsoft.XMLHTTP");
            } catch (err2) {
                try {
                    reqObj = new XMLHttpRequest();
                } catch (err3) {
                    reqObj = null;
                }
            }
        }
        return reqObj;
    }
    function moveContact()
    {
        if (document.theForm.movetolead.checked == true) {
            if (confirm("Do you want to Move Lead"))
            {
                xmlhttp = createRequest();
                if (!xmlhttp && typeof XMLHttpRequest != 'undefined') {
                    xmlhttp = new XMLHttpRequest();
                }
                if (xmlhttp != null) {

                    var contactmail = theForm.email.value;
                    xmlhttp.open("GET", "<%=request.getContextPath()%>/admin/customer/leadCheck.jsp?name=" + contactmail + "&rand=" + Math.random(1, 10), true);
                    xmlhttp.onreadystatechange = userAlert;
                    xmlhttp.send(null);
                }
                $("#commentsp").html("Why Eminentlabs?");
                document.theForm.movetolead.checked = true;
            } else
            {
                $("#commentsp").html("Comments");
                document.theForm.movetolead.checked = false;
            }
        } else
        {
            $("#commentsp").html("Comments");
            document.theForm.movetolead.checked = false;
        }
    }
    function userAlert() {

        if (xmlhttp.readyState == 4) {
            if (xmlhttp.status == 200) {

                var module = xmlhttp.responseText.split(",");
                var flag = module[1];
                if (flag == 'yes') {

                    alert("Selected Contact Name Already Exists in CRM Lead");
                    document.theForm.movetolead.checked = false;
                    theForm.title.focus();
                } else {
                    theForm.movetolead.checked = true;
                }


            }
        }
    }
    function trim(str)
    {
        while (str.charAt(str.length - 1) == " ")
            str = str.substring(0, str.length - 1);
        while (str.charAt(0) == " ")
            str = str.substring(1, str.length);
        return str;
    }
    function textCounter(field, cntfield, maxlimit)
    {
        if (field.value.length > maxlimit)
        {
            field.value = field.value.substring(0, maxlimit);
            alert('Comments size is exceeding 4000 characters');
        } else
            cntfield.value = maxlimit - field.value.length;
    }
    function editorTextCounter(field, cntfield, maxlimit)
    {
        if (field > maxlimit)
        {

            if (maxlimit == 2000)
                alert('Comments size is exceeding 2000 characters');
            else
                alert('Comments size is exceeding 2000 characters');
        } else
            cntfield.value = maxlimit - field;
    }
    function isDate(str)
    {
        var pattern = "1234567890-"
        var i = 0;
        do
        {
            var pos = 0;
            for (var j = 0; j < pattern.length; j++)
                if (str.charAt(i) == pattern.charAt(j))
                {
                    pos = 1;
                }
            i++;
        } while (pos == 1 && i < str.length)
        if (pos == 0)
            return false;
        return true;
    }

    function isNumber(str)
    {
        var pattern = "0123456789"
        var i = 0;
        do
        {
            var pos = 0;
            for (var j = 0; j < pattern.length; j++)
                if (str.charAt(i) == pattern.charAt(j))
                {
                    pos = 1;
                }
            i++;
        } while (pos == 1 && i < str.length)
        if (pos == 0)
            return false;
        return true;
    }

    /** Function To Check Whether There Is Any Integer Present In The Form Input From The User */
    function pk_fixnewlines_textarea(val) {
        // Adjust newlines so can do correct character counting for MySQL. MySQL counts a newline as 2 characters.
        if (val.indexOf('\r\n') != -1)
            val = val.replace(new RegExp("\\n", "g"), "\r\n"); // this is IE on windows. Puts both characters for a newline, just what MySQL does. No need to alter
        else if (val.indexOf('\r') != -1)
            val = val.replace(new RegExp("\\n", "g"), "\r\n"); // this is IE on a Mac. Need to add the line feed
        else if (val.indexOf('\n') != -1)
            val = val.replace(new RegExp("\\n", "g"), "\r\n"); // this is Firefox on any platform. Need to add carriage return
        else
            ; // no newlines in the textarea
        return val;
    }
    function isPositiveInteger(str)
    {
        var pattern = "abcdefghijklmnopqrstuvwxyz,.:;[]{}!@#$&*()-_+/ ABCDEFGHIJKLMNOPQRSTUVWXYZ-1234567890\n\r"
        var i = 0;
        var blnResult = true;
        var strChar;
        str = pk_fixnewlines_textarea(str);
        for (i = 0; i < str.length && blnResult == true; i++)
        {
            strChar = str.charAt(i);
            if (pattern.indexOf(strChar) == -1)
            {
                blnResult = false;
            }
        }

        return blnResult;
    }
    function isPositiveInteger1(str)
    {
        var pattern = "abcdefghijklmnopqrstuvwxyz.-_ ABCDEFGHIJKLMNOPQRSTUVWXYZ123456789"
        var i = 0;
        do
        {
            var pos = 0;
            for (var j = 0; j < pattern.length; j++)
                if (str.charAt(i) == pattern.charAt(j))
                {
                    pos = 1;
                }
            i++;
        } while (pos == 1 && i < str.length)
        if (pos == 0)
            return false;
        return true;
    }



    /** Function To Validate The Input Form Data */
    function fun(theForm)
    {
        if (trim(theForm.title.value) == '')
        {
            alert('Please enter the Title ');
            document.theForm.title.value = "";
            theForm.title.focus();
            return false;
        }
        if (!isPositiveInteger1(trim(theForm.title.value)))
        {
            alert('Please enter the AlphaNumerical only in the Title ');
            document.theForm.title.value = "";
            theForm.title.focus();
            return false;
        }
        if (trim(theForm.firstname.value) == '')
        {
            alert('Please enter the First Name ');
            document.theForm.firstname.value = "";
            theForm.firstname.focus();
            return false;
        }
        if (!isPositiveInteger1(trim(theForm.firstname.value)))
        {
            alert('Please enter the AlphaNumerical Characters only in the First Name ');
            document.theForm.firstname.value = "";
            theForm.firstname.focus();
            return false;
        }
        if ((theForm.lastname.value) == '')
        {
            alert('Please enter the Last Name');
            document.theForm.lastname.value = "";
            theForm.lastname.focus();
            return false;
        }
        if (!isPositiveInteger1(trim(theForm.lastname.value)))
        {
            alert('Please enter the Last Name with AlphaNumerical only');
            document.theForm.lastname.value = "";
            theForm.lastname.focus();
            return false;
        }
        if (trim(theForm.phone.value) == '')
        {
            alert('Please enter the Phone ');
            document.theForm.phone.value = "";
            theForm.phone.focus();
            return false;
        }
        if (!isNumber(trim(theForm.phone.value)))
        {
            alert('Please enter the Numerical Characters only in the Phone ');
            theForm.phone.focus();
            return false;
        }



        if (trim(theForm.email.value) == '')
        {
            alert('Please enter the valid Email ');
            document.theForm.email.value = "";
            theForm.email.focus();
            return false;
        }
        if (!(/^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/.test(theForm.email.value)))
        {
            alert("Invalid E-mail Address! Please re-enter.")
            document.theForm.email.value = "";
            theForm.email.focus();
            return (false);
        }
        var mail = theForm.email.value;
        var user = mail.indexOf('@');
        var len = mail.length;
        var id = mail.substring(user + 1, len);
        var id1 = mail.substring(0, user - 1);
        if (!((user >= 0))) {
            alert('Enter the valid Email Address');
            document.theForm.email.value = "";
            theForm.email.focus();
            return false;
        }

        if (len < 5) {
            alert('Size of the Email should be more than 4 charactes ');
            document.theForm.email.value = "";
            theForm.email.focus();
            return false;
        }
        if (document.getElementById('assignedto').value == '--Select One--')
        {
            alert("Please choose a Assigned to Name");
            document.getElementById('assignedto').focus();
            return false;
        }
        if (trim(theForm.mobile.value) == '')
        {
            alert('Please enter Mobile ');
            document.theForm.mobile.value = "";
            theForm.mobile.focus();
            return false;
        }
        if (!isNumber(trim(theForm.mobile.value)))
        {
            alert('Please enter the Numerical Characters only in the Mobile ');
            theForm.mobile.focus();
            return false;
        }
        if (trim(theForm.company.value) == '')
        {
            alert('Please enter the Company ');
            document.theForm.company.value = "";
            theForm.company.focus();
            return false;
        }

        if (!isPositiveInteger(trim(theForm.company.value)))
        {
            alert('Please enter the AlphaNumerical only in the Company ');
            document.theForm.company.value = "";
            theForm.company.focus();
            return false;
        }


        if (!isPositiveInteger(trim(theForm.reportsto.value)) && trim(theForm.reportsto.value) != '')
        {
            alert('Please enter the AlphaNumerical only in the Reports To ');
            document.theForm.reportsto.value = "";
            theForm.reportsto.focus();
            return false;
        }
        if (document.getElementById('accounts').value == '--Select Account--')
        {
            alert("Please choose a Account Name");
            document.getElementById('accounts').focus();
            return false;
        }
        if (trim(document.getElementById('duedate').value) == "")
        {
            alert("Please Enter the Due Date ");
            document.theForm.duedate.focus();
            return false;
        }
        if (!isDate(trim(document.getElementById('duedate').value)))
        {
            alert('Please enter the valid Due Date');
            document.theForm.duedate.value = "";
            theForm.duedate.focus();
            return false;
        }
        var str = document.getElementById('duedate').value;
        var first = str.indexOf("-");
        var last = str.lastIndexOf("-");
        var year = str.substring(last + 1, last + 5);
        var month = str.substring(first + 1, last);
        var date = str.substring(0, first);
        var form_date = new Date(year, month - 1, date);
        var current_date = new Date();
        var current_year = current_date.getYear();
        var current_month = current_date.getMonth();
        var current_date = current_date.getDate();
        var today = new Date(current_year, current_month, current_date);
        if (form_date.getTime() < today.getTime()) {
            alert('Due Date cannot be less than Today');
            document.theForm.duedate.value = "";
            theForm.duedate.focus();
            return false;
        }
        if (trim(document.getElementById('erp').value) === "")
        {
            alert("Please select ERP ");
            document.getElementById('erp').focus();
            return false;
        }

        if (trim(document.getElementById('vendor').value) == "")
        {
            alert("Please select vendor ");
            document.getElementById('vendor').focus();
            return false;
        } else {
            if (trim(document.getElementById('vendor').value) == "new" && trim(document.getElementById('newVendor').value) == "")
            {
                alert("Please enter new vendor ");
                document.getElementById('newVendor').focus();
                return false;
            }
        }
        if (trim(document.getElementById('meetingdate').value) === "")
        {
            alert("Please Enter the Meeting Date ");
            document.theForm.meetingdate.focus();
            return false;
        }
        if (!isDate(trim(document.getElementById('meetingdate').value)))
        {
            alert('Please enter the valid Meeting Date');
            document.theForm.meetingdate.value = "";
            theForm.duedate.focus();
            return false;
        }
        var mtr = document.getElementById('meetingdate').value;
        var first = mtr.indexOf("-");
        var last = mtr.lastIndexOf("-");
        var year = mtr.substring(last + 1, last + 5);
        var month = mtr.substring(first + 1, last);
        var date = mtr.substring(0, first);
        var mrt_date = new Date(year, month - 1, date);
        if (mrt_date.getTime() < today.getTime()) {
            alert('Meeting Date cannot be less than Today');
            document.theForm.meetingdate.value = "";
            theForm.meetingdate.focus();
            return false;
        }
        if (trim(document.getElementById('meetingtime').value) === "--None--")
        {
            alert("Please select Meeting Time ");
            document.getElementById('meetingtime').focus();
            return false;
        }
        if (trim(document.getElementById('industry').value) == "")
        {
            alert("Please select industry ");
            document.getElementById('industry').focus();
            return false;
        } else {
            if (trim(document.getElementById('industry').value) == "new" && trim(document.getElementById('newIndustry').value) == "")
            {
                alert("Please enter new industry ");
                document.getElementById('newIndustry').focus();
                return false;
            }
        }
//        if (!(/^[0-9a-zA-Z\_,/ ]+$/.test(theForm.mailingstreet.value)) && trim(theForm.mailingstreet.value) != '') {
//            alert("Special characters are not allowed in street! Please re-enter.")
//            document.theForm.mailingstreet.value = "";
//            theForm.mailingstreet.focus();
//            return (false);
//        }
        if (trim(document.getElementById('mailingarea').value) == "")
        {
            alert("Please select area ");
            document.getElementById('mailingarea').focus();
            return false;
        } else {
            if (trim(document.getElementById('mailingarea').value) == "new" && trim(document.getElementById('newMailingarea').value) == "")
            {
                alert("Please enter new area ");
                document.getElementById('newMailingarea').focus();
                return false;
            }
        }
        if (trim(document.getElementById('mailingcity').value) == "")
        {
            alert("Please select city ");
            document.getElementById('mailingcity').focus();
            return false;
        } else {
            if (trim(document.getElementById('mailingcity').value) == "new" && trim(document.getElementById('newMailingcity').value) == "")
            {
                alert("Please enter new city ");
                document.getElementById('newMailingcity').focus();
                return false;
            }
        }

        if (trim(document.getElementById('mailingstate').value) == "")
        {
            alert("Please select state ");
            document.getElementById('mailingstate').focus();
            return false;
        } else {
            if (trim(document.getElementById('mailingstate').value) == "new" && trim(document.getElementById('newMailingstate').value) == "")
            {
                alert("Please enter new state ");
                document.getElementById('newMailingstate').focus();
                return false;
            }
        }

        if (!isNumber(trim(theForm.mailingzip.value)) && trim(theForm.mailingzip.value) != '')
        {
            alert('Please enter the AlphaNumerical only in the Zip ');
            theForm.zip.focus();
            return false;
        }
        if (trim(document.getElementById('mailingcountry').value) == "")
        {
            alert("Please select country ");
            document.getElementById('mailingcountry').focus();
            return false;
        } else {
            if (trim(document.getElementById('mailingcountry').value) == "new" && trim(document.getElementById('newMailingcountry').value) == "")
            {
                alert("Please enter new country");
                document.getElementById('newMailingcountry').focus();
                return false;
            }
        }


        /*  	if (!isPositiveInteger(trim(theForm.otherstreet.value)) && trim(theForm.otherstreet.value)!='')
         {
         alert('Please enter the AlphaNumerical only in the otherstreet ');
         document.theForm.otherstreet.value="";
         theForm.otherstreet.focus();
         return false;
         }
         if (!isPositiveInteger(trim(theForm.othercity.value)) && trim(theForm.othercity.value)!='')
         {
         alert('Please enter the AlphaNumerical only in the othercity ');
         document.theForm.othercity.value="";
         theForm.othercity.focus();
         return false;
         }
         if (!isPositiveInteger(trim(theForm.otherstate.value)) && trim(theForm.otherstate.value)!='')
         {
         alert('Please enter the AlphaNumerical only in the otherstate ');
         document.theForm.mailingstate.value="";
         theForm.mailingstate.focus();
         return false;
         }
         if (!isPositiveInteger(trim(theForm.otherzip.value)) && trim(theForm.otherzip.value)!='')
         {
         alert('Please enter the AlphaNumerical only in the otherzip ');
         document.theForm.zip.value="";
         theForm.zip.focus();
         return false;
         }
         if (!isPositiveInteger(trim(theForm.othercountry.value)) && trim(theForm.othercountry.value)!='')
         {
         alert('Please enter the AlphaNumerical only in the othercountry ');
         document.theForm.othercountry.value="";
         theForm.othercountry.focus();
         return false;
         }
         */
        if (!isNumber(trim(theForm.fax.value)) && trim(theForm.fax.value) != '')
        {
            alert('Please enter the Numerical Characters only in the Fax ');
            theForm.fax.focus();
            return false;
        }
        if (!isNumber(trim(theForm.homephone.value)) && trim(theForm.homephone.value) != '')
        {
            alert('Please enter the Numerical Characters only in the Home Phone ');
            theForm.homephone.focus();
            return false;
        }
        if (!isNumber(trim(theForm.otherphone.value)) && trim(theForm.otherphone.value) != '')
        {
            alert('Please enter the Numerical Characters only in the Other Phone ');
            theForm.otherphone.focus();
            return false;
        }

        if (!isPositiveInteger(trim(theForm.assistant.value)) && trim(theForm.assistant.value) != '')
        {
            alert('Please enter the AlphaNumerical only in the Assistant ');
            document.theForm.assistant.value = "";
            theForm.assistant.focus();
            return false;
        }
        if (!isNumber(trim(theForm.asstphone.value)) && trim(theForm.asstphone.value) != '')
        {
            alert('Please enter the Numerical Characters only in the Asst.Phone ');
            theForm.asstphone.focus();
            return false;
        }
        var str = document.theForm.birthdate.value;
        var first = str.indexOf("-");
        var last = str.lastIndexOf("-");
        var year = str.substring(last + 1, last + 5);
        var month = str.substring(first + 1, last);
        var date = str.substring(0, first);
        var form_date = new Date(year, month - 1, date);
        var current_date = new Date();
        if (!(theForm.birthdate.value) == '')
        {
            if (form_date.getFullYear() > (current_date.getFullYear() - 18))
            {
                window.alert("Enter the valid Date of Birth");
                theForm.birthdate.focus();
                document.theForm.birthdate.value = "";
                return false;
            }

        }

        if (trim(document.getElementById('department').value) == "")
        {
            alert("Please select department ");
            document.getElementById('department').focus();
            return false;
        } else {
            if (trim(document.getElementById('department').value) == "new" && trim(document.getElementById('newDepartment').value) == "")
            {
                alert("Please enter new department");
                document.getElementById('newDepartment').focus();
                return false;
            }
        }





        //    if(theForm.comments.value.length<=0)
        //  	{
        //	   		alert('Enter your comments');
        //		    theForm.comments.focus();
        //		    return false;
        //    	}
        //
        //	if(theForm.comments.value.length>4000)
        //  	{
        //	    	alert('Comments Should not exceed 4000 Characters');
        //		    theForm.comments.focus();
        //		    return false;
        //	}
        var count = 0;
        var contactType = $('#contactType :selected').val();
        if (contactType === 'Normal') {
        } else {
            if (theForm.submited === 'Update') {
                $('.error2').remove();
                var i = 0;
                var curryear = 0;
                $('select[name*="empCompany"]').each(function () {
                    var empCompany = $(this).val();
                    empCompany = $.trim(empCompany);
                    if (empCompany.length == 0) {
                        $("<div class='error2'>select the company</div>").insertAfter("#empCompany" + i);
                        count++;
                        $("#newempCompany" + i).focus();
                    } else if (empCompany === 'new' && $('#newempCompany' + i).val().length === 0) {
                        $("<div class='error2'>enter the company</div>").insertAfter("#newempCompany" + i);
                        count++;
                        $("#newempCompany" + i).focus();
                    }
                    if ($('#fromYear' + i).val().length == 0) {
                        $("<div class='error2'>select the year</div>").insertAfter("#fromYear" + i);
                        count++;
                        $("#fromYear" + i).focus();
                    }

                    if ($('#toYear' + i).val().length == 0) {
                        $("<div class='error2'>select the  year</div>").insertAfter("#toYear" + i);
                        count++;
                        $("#toYear" + i).focus();
                    } else if ($('#fromYear' + i).val() > $('#toYear' + i).val()) {
                        $("<div class='error2'>correct the year</div>").insertAfter("#toYear" + i);
                        count++;
                        $("#toYear" + i).focus();
                    } else {
                        if (i > 0) {
                            curryear = i;
                            curryear--;
                            var fromYear = $('#fromYear' + i).val();
                            var pfromYear = $('#fromYear' + curryear).val();
                            var toYear = $('#toYear' + i).val();
                            if (fromYear > pfromYear || toYear > pfromYear) {
                                $("<div class='error2'>correct the year</div>").insertAfter("#toYear" + i);
                                count++;
                                $("#toYear" + i).focus();
                            }
                        }
                    }
                    if ($('#role' + i).val().length == 0) {
                        $("<div class='error2'>select the role</div>").insertAfter("#role" + i);
                        count++;
                        $("#role" + i).focus();
                    } else if ($('#role' + i).val() === 'new' && $('#newrole' + i).val().length === 0) {
                        $("<div class='error2'>enter the role</div>").insertAfter("#newrole" + i);
                        count++;
                        $("#newrole" + i).focus();
                    }
                    i++;
                });


                if (contactType === 'Decision Maker') {
                    var j = 1, k = 1;
                    var a = 0;
                    $('select[name="companyCompetitors"]').each(function () {

                        a++;
                        var companyCompetitors = $(this).val();
                        if (companyCompetitors.length == 0) {
                            $("<div class='error2'>select the competitor</div>").insertAfter("#companyCompetitors" + j);
                            count++;
                            $("#companyCompetitors" + j).focus();
                        } else if (companyCompetitors === 'new' && $('#newcompanyCompetitors' + j).val().length === 0) {
                            $("<div class='error2'>enter the competitor</div>").insertAfter("#newcompanyCompetitors" + j);
                            count++;
                            $("#newcompanyCompetitors" + j).focus();
                        } else {
                            var b = 0;
                            $('select[name="companyCompetitors"]').each(function () {
                                b++;
                                if (a != b) {
                                    var sameval = $.trim($(this).val());
                                    if (companyCompetitors != 'new' && companyCompetitors == sameval) {
                                        $("<div class='error2'>Duplicate competitor</div>").insertAfter("#companyCompetitors" + j);
                                        count++;
                                    }
                                }
                            });
                        }

                        if ($('#competitorcity' + j).val().length == 0) {
                            $("<div class='error2'>select the city</div>").insertAfter("#competitorcity" + j);
                            count++;
                            $("#competitorcity" + j).focus();
                        } else if ($('#competitorcity' + j).val() === 'new' && $('#newcompetitorcity' + j).val().length === 0) {
                            $("<div class='error2'>enter the city</div>").insertAfter("#newcompetitorcity" + j);
                            count++;
                            $("#newcompetitorcity" + j).focus();
                        }
                        if ($('#competitorstate' + j).val().length == 0) {
                            $("<div class='error2'>select the state</div>").insertAfter("#competitorstate" + j);
                            count++;
                            $("#competitorstate" + j).focus();
                        } else if ($('#competitorstate' + j).val() === 'new' && $('#newcompetitorstate' + j).val().length === 0) {
                            $("<div class='error2'>enter the state</div>").insertAfter("#newcompetitorstate" + j);
                            count++;
                            $("#newcompetitorstate" + j).focus();
                        }
                        if ($('#competitorcountry' + j).val().length == 0) {
                            $("<div class='error2'>select the country</div>").insertAfter("#competitorcountry" + j);
                            count++;
                            $("#competitorcountry" + j).focus();
                        } else if ($('#competitorcountry' + j).val() === 'new' && $('#newcompetitorcountry' + j).val().length === 0) {
                            $("<div class='error2'>enter the country</div>").insertAfter("#newcompetitorcountry" + j);
                            count++;
                            $("#newcompetitorcountry" + j).focus();
                        }
                        j++;
                    });
                    var m = 1;
                    $('input[name="year"]').each(function () {
                        if ($('#currency' + m).val().length == 0) {
                            $("<div class='error2'>select the currency</div>").insertAfter("#currency" + m);
                            count++;
                            $("#currency" + m).focus();
                        }
                        if ($('#sales' + m).val().length == 0) {
                            $("<div class='error2'>enter the sales</div>").insertAfter("#sales" + m);
                            count++;
                            $("#sales" + m).focus();
                        }
                        if ($('#employees' + m).val().length == 0) {
                            $("<div class='error2'>enter the no of employees</div>").insertAfter("#employees" + m);
                            count++;
                            $("#employees" + m).focus();
                        }
                        if ($('#itSpend' + m).val().length == 0) {
                            $("<div class='error2'>enter the spend amount for IT</div>").insertAfter("#itSpend" + m);
                            count++;
                            $("#itSpend" + m).focus();
                        }
                        if ($('#erpSpend' + m).val().length == 0) {
                            $("<div class='error2'>enter the spend amount for ERP/SAP</div>").insertAfter("#erpSpend" + m);
                            count++;
                            $("#erpSpend" + m).focus();
                        }

                        m++;
                    });
                }
            }
        }
        if (trim(CKEDITOR.instances.comments.getData()) == "")
        {
            if (trim(document.getElementById('exrating').value) == "Hot" && document.theForm.movetolead.checked == true) {
                alert("Please Enter the Why eminentlabs");
                CKEDITOR.instances.comments.focus();
                return false;
            } else {
                alert("Please Enter the Comments");
                CKEDITOR.instances.comments.focus();
                return false;
            }

        }
        if (trim(document.getElementById('exrating').value) == "Hot" && document.theForm.movetolead.checked == true && CKEDITOR.instances.comments.getData().length < 1000) {
            alert(" Please enter more than 1000 characters");
            CKEDITOR.instances.comments.focus();
            return false;
        }
        if (CKEDITOR.instances.comments.getData().length > 4000)
        {
            if (trim(document.getElementById('exrating').value) == "Hot" && document.theForm.movetolead.checked == true) {
                alert(" Why eminentlabs exceeds 4000 character");
            } else {
                alert(" Comments exceeds 4000 character");
            }
            CKEDITOR.instances.comments.focus();
            //        document.theForm.description.value == "";
            return false;
        }
        if (count === 0) {
            monitorSubmit();
        } else {
            return false;
        }

    }


    function funa(theForm)
    {

        alert(trim(theForm.title.value));
        if (trim(theForm.title.value) == '')
        {
            alert('Please enter the Title ');
            document.theForm.title.value = "";
            theForm.title.focus();
            return false;
        }
        if (!isPositiveInteger1(trim(theForm.title.value)))
        {
            alert('Please enter the AlphaNumerical only in the Title ');
            document.theForm.title.value = "";
            theForm.title.focus();
            return false;
        }
        if (trim(theForm.firstname.value) == '')
        {
            alert('Please enter the First Name ');
            document.theForm.firstname.value = "";
            theForm.firstname.focus();
            return false;
        }
        if (!isPositiveInteger1(trim(theForm.firstname.value)))
        {
            alert('Please enter the AlphaNumerical Characters only in the First Name ');
            document.theForm.firstname.value = "";
            theForm.firstname.focus();
            return false;
        }
        if ((theForm.lastname.value) == '')
        {
            alert('Please enter the Last Name');
            document.theForm.lastname.value = "";
            theForm.lastname.focus();
            return false;
        }
        if (!isPositiveInteger1(trim(theForm.lastname.value)))
        {
            alert('Please enter the Last Name with AlphaNumerical only');
            document.theForm.lastname.value = "";
            theForm.lastname.focus();
            return false;
        }
        if (trim(theForm.phone.value) == '')
        {
            alert('Please enter the Phone ');
            document.theForm.phone.value = "";
            theForm.phone.focus();
            return false;
        }
        if (!isNumber(trim(theForm.phone.value)))
        {
            alert('Please enter the Numerical Characters only in the Phone ');
            theForm.phone.focus();
            return false;
        }



        if (trim(theForm.email.value) == '')
        {
            alert('Please enter the valid Email ');
            document.theForm.email.value = "";
            theForm.email.focus();
            return false;
        }
        if (!(/^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/.test(theForm.email.value)))
        {
            alert("Invalid E-mail Address! Please re-enter.")
            document.theForm.email.value = "";
            theForm.email.focus();
            return (false);
        }
        var mail = theForm.email.value;
        var user = mail.indexOf('@');
        var len = mail.length;
        var id = mail.substring(user + 1, len);
        var id1 = mail.substring(0, user - 1);
        if (!((user >= 0))) {
            alert('Enter the valid Email Address');
            document.theForm.email.value = "";
            theForm.email.focus();
            return false;
        }

        if (len < 5) {
            alert('Size of the Email should be more than 4 charactes ');
            document.theForm.email.value = "";
            theForm.email.focus();
            return false;
        }
        if (document.getElementById('assignedto').value == '--Select One--')
        {
            alert("Please choose a Assigned to Name");
            document.getElementById('assignedto').focus();
            return false;
        }
        if (trim(theForm.mobile.value) == '')
        {
            alert('Please enter Mobile ');
            document.theForm.mobile.value = "";
            theForm.mobile.focus();
            return false;
        }
        if (!isNumber(trim(theForm.mobile.value)))
        {
            alert('Please enter the Numerical Characters only in the Mobile ');
            theForm.mobile.focus();
            return false;
        }
        if (trim(theForm.company.value) == '')
        {
            alert('Please enter the Company ');
            document.theForm.company.value = "";
            theForm.company.focus();
            return false;
        }

        if (!isPositiveInteger(trim(theForm.company.value)))
        {
            alert('Please enter the AlphaNumerical only in the Company ');
            document.theForm.company.value = "";
            theForm.company.focus();
            return false;
        }


        if (!isPositiveInteger(trim(theForm.reportsto.value)) && trim(theForm.reportsto.value) != '')
        {
            alert('Please enter the AlphaNumerical only in the Reports To ');
            document.theForm.reportsto.value = "";
            theForm.reportsto.focus();
            return false;
        }
        if (document.getElementById('accounts').value == '--Select Account--')
        {
            alert("Please choose a Account Name");
            document.getElementById('accounts').focus();
            return false;
        }
        if (trim(document.getElementById('duedate').value) == "")
        {
            alert("Please Enter the Due Date ");
            document.theForm.duedate.focus();
            return false;
        }
        if (!isDate(trim(document.getElementById('duedate').value)))
        {
            alert('Please enter the valid Due Date');
            document.theForm.duedate.value = "";
            theForm.duedate.focus();
            return false;
        }
        var str = document.getElementById('duedate').value;
        var first = str.indexOf("-");
        var last = str.lastIndexOf("-");
        var year = str.substring(last + 1, last + 5);
        var month = str.substring(first + 1, last);
        var date = str.substring(0, first);
        var form_date = new Date(year, month - 1, date);
        var current_date = new Date();
        var current_year = current_date.getYear();
        var current_month = current_date.getMonth();
        var current_date = current_date.getDate();
        var today = new Date(current_year, current_month, current_date);
        if (form_date.getTime() < today.getTime()) {
            alert('Due Date cannot be less than Today');
            document.theForm.duedate.value = "";
            theForm.duedate.focus();
            return false;
        }
        if (trim(document.getElementById('erp').value) === "")
        {
            alert("Please select ERP ");
            document.getElementById('erp').focus();
            return false;
        }

        if (trim(document.getElementById('vendor').value) == "")
        {
            alert("Please select vendor ");
            document.getElementById('vendor').focus();
            return false;
        } else {
            if (trim(document.getElementById('vendor').value) == "new" && trim(document.getElementById('newVendor').value) == "")
            {
                alert("Please enter new vendor ");
                document.getElementById('newVendor').focus();
                return false;
            }
        }
        if (trim(document.getElementById('meetingdate').value) === "")
        {
            alert("Please Enter the Meeting Date ");
            document.theForm.meetingdate.focus();
            return false;
        }
        if (!isDate(trim(document.getElementById('meetingdate').value)))
        {
            alert('Please enter the valid Meeting Date');
            document.theForm.meetingdate.value = "";
            theForm.duedate.focus();
            return false;
        }
        var mtr = document.getElementById('meetingdate').value;
        var first = mtr.indexOf("-");
        var last = mtr.lastIndexOf("-");
        var year = mtr.substring(last + 1, last + 5);
        var month = mtr.substring(first + 1, last);
        var date = mtr.substring(0, first);
        var mrt_date = new Date(year, month - 1, date);
        if (mrt_date.getTime() < today.getTime()) {
            alert('Meeting Date cannot be less than Today');
            document.theForm.meetingdate.value = "";
            theForm.meetingdate.focus();
            return false;
        }
        if (trim(document.getElementById('meetingtime').value) === "--None--")
        {
            alert("Please select Meeting Time ");
            document.getElementById('meetingtime').focus();
            return false;
        }
        if (trim(document.getElementById('industry').value) == "")
        {
            alert("Please select industry ");
            document.getElementById('industry').focus();
            return false;
        } else {
            if (trim(document.getElementById('industry').value) == "new" && trim(document.getElementById('newIndustry').value) == "")
            {
                alert("Please enter new industry ");
                document.getElementById('newIndustry').focus();
                return false;
            }
        }
//        if (!(/^[0-9a-zA-Z\_,/ ]+$/.test(theForm.mailingstreet.value)) && trim(theForm.mailingstreet.value) != '') {
//            alert("Special characters are not allowed in street! Please re-enter.")
//            document.theForm.mailingstreet.value = "";
//            theForm.mailingstreet.focus();
//            return (false);
//        }
        if (trim(document.getElementById('mailingarea').value) == "")
        {
            alert("Please select area ");
            document.getElementById('mailingarea').focus();
            return false;
        } else {
            if (trim(document.getElementById('mailingarea').value) == "new" && trim(document.getElementById('newMailingarea').value) == "")
            {
                alert("Please enter new area ");
                document.getElementById('newMailingarea').focus();
                return false;
            }
        }
        if (trim(document.getElementById('mailingcity').value) == "")
        {
            alert("Please select city ");
            document.getElementById('mailingcity').focus();
            return false;
        } else {
            if (trim(document.getElementById('mailingcity').value) == "new" && trim(document.getElementById('newMailingcity').value) == "")
            {
                alert("Please enter new city ");
                document.getElementById('newMailingcity').focus();
                return false;
            }
        }

        if (trim(document.getElementById('mailingstate').value) == "")
        {
            alert("Please select state ");
            document.getElementById('mailingstate').focus();
            return false;
        } else {
            if (trim(document.getElementById('mailingstate').value) == "new" && trim(document.getElementById('newMailingstate').value) == "")
            {
                alert("Please enter new state ");
                document.getElementById('newMailingstate').focus();
                return false;
            }
        }

        if (!isNumber(trim(theForm.mailingzip.value)) && trim(theForm.mailingzip.value) != '')
        {
            alert('Please enter the AlphaNumerical only in the Zip ');
            theForm.zip.focus();
            return false;
        }
        if (trim(document.getElementById('mailingcountry').value) == "")
        {
            alert("Please select country ");
            document.getElementById('mailingcountry').focus();
            return false;
        } else {
            if (trim(document.getElementById('mailingcountry').value) == "new" && trim(document.getElementById('newMailingcountry').value) == "")
            {
                alert("Please enter new country");
                document.getElementById('newMailingcountry').focus();
                return false;
            }
        }


        /*  	if (!isPositiveInteger(trim(theForm.otherstreet.value)) && trim(theForm.otherstreet.value)!='')
         {
         alert('Please enter the AlphaNumerical only in the otherstreet ');
         document.theForm.otherstreet.value="";
         theForm.otherstreet.focus();
         return false;
         }
         if (!isPositiveInteger(trim(theForm.othercity.value)) && trim(theForm.othercity.value)!='')
         {
         alert('Please enter the AlphaNumerical only in the othercity ');
         document.theForm.othercity.value="";
         theForm.othercity.focus();
         return false;
         }
         if (!isPositiveInteger(trim(theForm.otherstate.value)) && trim(theForm.otherstate.value)!='')
         {
         alert('Please enter the AlphaNumerical only in the otherstate ');
         document.theForm.mailingstate.value="";
         theForm.mailingstate.focus();
         return false;
         }
         if (!isPositiveInteger(trim(theForm.otherzip.value)) && trim(theForm.otherzip.value)!='')
         {
         alert('Please enter the AlphaNumerical only in the otherzip ');
         document.theForm.zip.value="";
         theForm.zip.focus();
         return false;
         }
         if (!isPositiveInteger(trim(theForm.othercountry.value)) && trim(theForm.othercountry.value)!='')
         {
         alert('Please enter the AlphaNumerical only in the othercountry ');
         document.theForm.othercountry.value="";
         theForm.othercountry.focus();
         return false;
         }
         */
        if (!isNumber(trim(theForm.fax.value)) && trim(theForm.fax.value) != '')
        {
            alert('Please enter the Numerical Characters only in the Fax ');
            theForm.fax.focus();
            return false;
        }
        if (!isNumber(trim(theForm.homephone.value)) && trim(theForm.homephone.value) != '')
        {
            alert('Please enter the Numerical Characters only in the Home Phone ');
            theForm.homephone.focus();
            return false;
        }
        if (!isNumber(trim(theForm.otherphone.value)) && trim(theForm.otherphone.value) != '')
        {
            alert('Please enter the Numerical Characters only in the Other Phone ');
            theForm.otherphone.focus();
            return false;
        }

        if (!isPositiveInteger(trim(theForm.assistant.value)) && trim(theForm.assistant.value) != '')
        {
            alert('Please enter the AlphaNumerical only in the Assistant ');
            document.theForm.assistant.value = "";
            theForm.assistant.focus();
            return false;
        }
        if (!isNumber(trim(theForm.asstphone.value)) && trim(theForm.asstphone.value) != '')
        {
            alert('Please enter the Numerical Characters only in the Asst.Phone ');
            theForm.asstphone.focus();
            return false;
        }
        var str = document.theForm.birthdate.value;
        var first = str.indexOf("-");
        var last = str.lastIndexOf("-");
        var year = str.substring(last + 1, last + 5);
        var month = str.substring(first + 1, last);
        var date = str.substring(0, first);
        var form_date = new Date(year, month - 1, date);
        var current_date = new Date();
        if (!(theForm.birthdate.value) == '')
        {
            if (form_date.getFullYear() > (current_date.getFullYear() - 18))
            {
                window.alert("Enter the valid Date of Birth");
                theForm.birthdate.focus();
                document.theForm.birthdate.value = "";
                return false;
            }

        }

        if (trim(document.getElementById('department').value) == "")
        {
            alert("Please select department ");
            document.getElementById('department').focus();
            return false;
        } else {
            if (trim(document.getElementById('department').value) == "new" && trim(document.getElementById('newDepartment').value) == "")
            {
                alert("Please enter new department");
                document.getElementById('newDepartment').focus();
                return false;
            }
        }





        //    if(theForm.comments.value.length<=0)
        //  	{
        //	   		alert('Enter your comments');
        //		    theForm.comments.focus();
        //		    return false;
        //    	}
        //
        //	if(theForm.comments.value.length>4000)
        //  	{
        //	    	alert('Comments Should not exceed 4000 Characters');
        //		    theForm.comments.focus();
        //		    return false;
        //	}



        if (trim(CKEDITOR.instances.comments.getData()) == "")
        {
            if (trim(document.getElementById('exrating').value) == "Hot" && document.theForm.movetolead.checked == true) {
                alert("Please Enter the Why eminentlabs");
                CKEDITOR.instances.comments.focus();
                return false;
            } else {
                alert("Please Enter the Comments");
                CKEDITOR.instances.comments.focus();
                return false;
            }

        }
        if (trim(document.getElementById('exrating').value) == "Hot" && document.theForm.movetolead.checked == true && CKEDITOR.instances.comments.getData().length < 1000) {
            alert(" Please enter more than 1000 characters");
            CKEDITOR.instances.comments.focus();
            return false;
        }
        if (CKEDITOR.instances.comments.getData().length > 4000)
        {
            if (trim(document.getElementById('exrating').value) == "Hot" && document.theForm.movetolead.checked == true) {
                alert(" Why eminentlabs exceeds 4000 character");
            } else {
                alert(" Comments exceeds 4000 character");
            }
            CKEDITOR.instances.comments.focus();
            //        document.theForm.description.value == "";
            return false;
        }
        if (count === 0) {
            monitorSubmit();
        } else {
            return false;
        }

    }
    /** Function To Set Focus On The Project Name Field In The Form */

    function setFocus() {
        document.theForm.firstname.focus();
    }
    window.onload = setFocus;
    //-->
    function showNew() {
        var industry = document.getElementById('industry').value;
        var divsToHide = document.getElementsByClassName("newIndustryTd");
        if (industry === 'new') {
            for (var i = 0; i < divsToHide.length; i++) {
                divsToHide[i].style.display = "block";
            }
        } else {
            for (var i = 0; i < divsToHide.length; i++) {
                divsToHide[i].style.display = "none";
            }
        }
    }

    function showNewVendor() {
        var vendor = document.getElementById('vendor').value;
        if (vendor === 'new') {
            document.getElementById('newVendor').style.display = "block";
        } else {
            document.getElementById('newVendor').style.display = "none";
        }
    }
    function showNewArea() {
        var mailingarea = document.getElementById('mailingarea').value;
        if (mailingarea === 'new') {
            document.getElementById('newMailingarea').style.display = "block";
        } else {
            document.getElementById('newMailingarea').style.display = "none";
        }
    }

    function showNewCity() {
        var mailingcity = document.getElementById('mailingcity').value;
        if (mailingcity === 'new') {
            document.getElementById('newMailingcity').style.display = "block";
        } else {
            document.getElementById('newMailingcity').style.display = "none";
        }
    }

    function showNewState() {
        var mailingstate = document.getElementById('mailingstate').value;
        if (mailingstate === 'new') {
            document.getElementById('newMailingstate').style.display = "block";
        } else {
            document.getElementById('newMailingstate').style.display = "none";
        }
    }

    function showNewCountry() {
        var mailingcountry = document.getElementById('mailingcountry').value;
        if (mailingcountry === 'new') {
            document.getElementById('newMailingcountry').style.display = "block";
        } else {
            document.getElementById('newMailingcountry').style.display = "none";
        }
    }
    function showNewDept() {
        var department = document.getElementById('department').value;
        if (department === 'new') {
            document.getElementById('newDepartment').style.display = "block";
        } else {
            document.getElementById('newDepartment').style.display = "none";
        }
    }
</SCRIPT>
<body>
    <jsp:include page="/header.jsp" />
    <BR>
    <!-- Table To Display The Formatted String "Add New User" -->
    <table  width="100%" bgcolor="#c3d9ff">
        <tr  >
            <td  align="left" ><font size="4"
                                     COLOR="#0000FF"><b> Edit Contact Information</b></font> <FONT SIZE="3"
                                                                              COLOR="#0000FF"> </FONT></td>
            <td  align="right"><strong><font size="10"
                                             COLOR="#FF0000">*</font> = Required Information</strong></td>
        </tr>
    </table>
    <BR>
    <FORM name=theForm onsubmit="return fun(this)"
          action="<%=request.getContextPath()%>/MyCRM/crmContactUpdate.jsp"
          method=post onReset="return setFocus()"><%@ page
            import="java.sql.*,pack.eminent.encryption.*"%> 
            <jsp:useBean id="Contact" class="com.eminent.customer.ContactRegistration"/>

            <%
                int contactid = Integer.parseInt(request.getParameter("contactid"));
                Connection connection = null;
                Statement st = null;
                ResultSet rs = null;
                try {

                    //Getting admin details
                    int adminUserId = 0;
                    String decisionMaker = "";
                    HashMap<String, String> hm = GetProjectMembers.getAdminDetail();
                    if (hm != null) {
                        adminUserId = Integer.parseInt(hm.get("userid"));
                    }

                    connection = MakeConnection.getConnection();
                    List<ContactWorkHistory> cwhs = null;
                    List<CrmCompetitors> competitorses = new ArrayList();
                    List<CrmCompanySales> companySaleses = new ArrayList();
                    List<CrmCompanyPlants> companyPlantses = new ArrayList();
                    Set<String> competitors = new TreeSet<String>();

                    List<String> currencies = CRMUtil.currencyTypes();
                    List<String> companies = CRMUtil.getCompany();
                    List<String> allCity = CRMUtil.getAllCities();
                    List<String> allStates = CRMUtil.getAllStates();
                    List<String> allCountries = CRMUtil.getAllCountries();

                    List<String> contactArea = CRMUtil.getArea("contact");
                    List<String> contactCity = CRMUtil.getCity("contact");
                    List<String> contactState = CRMUtil.getState("contact");
                    List<String> contactCountry = CRMUtil.getCountry("contact");

                    if (connection != null) {
                        cwhs = CRMUtil.getContactWorkHistory(connection, contactid);
                        st = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);

                        rs = st.executeQuery("Select EMAIL,FIRSTNAME,LASTNAME,ACCOUNTNAME, contact_owner, TITLE,PHONE,MOBILE,REPORTSTO,MAILINGSTREET,MAILINGCITY,MAILINGSTATE,MAILINGZIP,MAILINGCOUNTRY,OTHERSTREET,OTHERCITY,OTHERSTATE,OTHERZIP,OTHERCOUNTRY,FAX,HOMEPHONE,OTHERPHONE,ASSISTANT,ASSTPHONE,LEADSOURCE,BIRTHDATE,DEPARTMENT,DESCRIPTION,assignedto,company,duedate,rating,modifiedon,INTERESTED,ROLEID,ERP,vendor,MEETING_DATE,MEETING_TIME,mailingarea,INDUSTRY,CONTACT_TYPE  from contact where contactid=" + contactid);
                        if (rs != null) {
                            while (rs.next()) {

                                String firstname = rs.getString("FIRSTNAME");
                                String lastname = rs.getString("LASTNAME");
                                String contactOwner = rs.getString("CONTACT_OWNER");
                                String accountname = rs.getString("ACCOUNTNAME");
                                String title = rs.getString("TITLE");
                                String phone = rs.getString("PHONE");
                                String mobile = rs.getString("MOBILE");
                                String reportsto = rs.getString("REPORTSTO");
                                String company = rs.getString("company");
                                String email = rs.getString("EMAIL");
                                String mailingstreet = rs.getString("MAILINGSTREET");
                                String mailingcity = rs.getString("MAILINGCITY");
                                String mailingstate = rs.getString("MAILINGSTATE");
                                String mailingzip = rs.getString("MAILINGZIP");
                                String mailingcountry = rs.getString("MAILINGCOUNTRY");
                                String otherstreet = rs.getString("OTHERSTREET");
                                String othercity = rs.getString("OTHERCITY");
                                String otherstate = rs.getString("OTHERSTATE");
                                String otherzip = rs.getString("OTHERZIP");
                                String othercountry = rs.getString("OTHERCOUNTRY");
                                String fax = rs.getString("FAX");
                                String homephone = rs.getString("HOMEPHONE");
                                String otherphone = rs.getString("OTHERPHONE");
                                String assistant = rs.getString("ASSISTANT");
                                String asstphone = rs.getString("ASSTPHONE");
                                String leadsource = rs.getString("LEADSOURCE");
                                String birthdate = rs.getString("BIRTHDATE");
                                String department = rs.getString("DEPARTMENT");
                                String description = rs.getString("DESCRIPTION");
                                String erp = rs.getString("ERP");
                                String vendor = rs.getString("vendor");
                                String time = rs.getString("MEETING_TIME");
                                String mailingarea = rs.getString("mailingarea");
                                String type = rs.getString("CONTACT_TYPE");
                                java.util.Date meetingDate = rs.getDate("MEETING_DATE");

                                String rating = rs.getString("rating");

                                int assi = rs.getInt("assignedto");

                                java.util.Date due = rs.getDate("duedate");

                                SimpleDateFormat dfm = new SimpleDateFormat("d-M-yyyy");
                                String dueDate = "NA";
                                if (due != null) {
                                    dueDate = dfm.format(due);
                                }

                                String meeting = "NA";
                                if (meetingDate != null) {
                                    meeting = dfm.format(meetingDate);
                                }
                                logger.info("Meeting Date" + meeting);
                                logger.info("Meeting Time" + time);

                                SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yy");

                                java.sql.Date modifiedOn = rs.getDate("modifiedon");

                                String modified = "NA";
                                if (modifiedOn != null) {
                                    modified = sdf.format(modifiedOn);
                                }

                                String product = rs.getString("INTERESTED");
                                int roleid = rs.getInt("ROLEID");
                                int industryId = rs.getInt("INDUSTRY");

                                if (firstname == null) {
                                    firstname = "";
                                }
                                if (lastname == null) {
                                    lastname = "";
                                }
                                if (accountname == null) {
                                    accountname = "";
                                }
                                if (phone == null) {
                                    phone = "";
                                }
                                if (mobile == null) {
                                    mobile = "";
                                }
                                if (title == null) {
                                    title = "";
                                }
                                if (reportsto == null) {
                                    reportsto = "";
                                }
                                if (email == null) {
                                    email = "";
                                }
                                if (mailingstreet == null) {
                                    mailingstreet = "";
                                }
                                if (mailingarea == null) {
                                    mailingarea = "";
                                }
                                if (mailingcity == null) {
                                    mailingcity = "";
                                }
                                if (mailingstate == null) {
                                    mailingstate = "";
                                }
                                if (mailingzip == null) {
                                    mailingzip = "";
                                }
                                if (mailingcountry == null) {
                                    mailingcountry = "";
                                }
                                if (otherstreet == null) {
                                    otherstreet = "";
                                }
                                if (othercity == null) {
                                    othercity = "";
                                }
                                if (otherstate == null) {
                                    otherstate = "";
                                }
                                if (otherzip == null) {
                                    otherzip = "";
                                }
                                if (othercountry == null) {
                                    othercountry = "";
                                }
                                if (fax == null) {
                                    fax = "";
                                }
                                if (homephone == null) {
                                    homephone = "";
                                }
                                if (otherphone == null) {
                                    otherphone = "";
                                }
                                if (assistant == null) {
                                    assistant = "";
                                }
                                if (asstphone == null) {
                                    asstphone = "";
                                }
                                if (birthdate == null) {
                                    birthdate = "";
                                }
                                if (department == null) {
                                    department = "";
                                }
                                if (description == null) {
                                    description = "";
                                }
                                if (company == null) {
                                    company = "";
                                }
                                if (rating == null) {
                                    rating = "NA";
                                }
                                if (product == null) {
                                    product = "NA";
                                }
                                if (leadsource == null) {
                                    leadsource = "--None--";
                                }
                                if (erp == null) {
                                    erp = "";
                                }
                                if (vendor == null) {
                                    vendor = "";
                                }
                                if (time == null) {
                                    time = "--None--";
                                }
                                decisionMaker = CRMUtil.getDecisionMaker(connection, company);
                                int curr_year = Calendar.getInstance().get(Calendar.YEAR);
                                int latestOfSales = curr_year;
                                if (type.equalsIgnoreCase("Decision Maker")) {
                                    competitorses = CRMUtil.getCompetitors(connection, company);
                                    companySaleses = CRMUtil.getCompanySales(connection, company);
                                    for (CrmCompanySales sales : companySaleses) {
                                        latestOfSales = sales.getSalesYear();
                                        break;
                                    }
                                }
                                companyPlantses = CRMUtil.getCompanyPlants(connection, company);
                                competitors = CRMUtil.getCompetitorByIndustry(connection, company, industryId);

            %>

            <table width="100%" bgColor=#E8EEF7  align="center">
                <TBODY>


                    <tr>
                        <td width="10%"><strong>Title<font size="10"
                                                           COLOR="#FF0000">*</font></strong></td>
                        <td width="21%"><input type="text" name="title" id="title" maxlength="30" size=14
                                               value="<%=title%>"><strong class="style20"></strong></td>
                        <td width="10%"><strong>First Name<font size="10"
                                                                COLOR="#FF0000">*</font></strong></td>
                        <td width="25%"><input type="text" name="firstname" id="firstname" maxlength="30" size=25
                                               value="<%=firstname%>"><strong class="style20"></strong></td>
                        <td width="12%"><strong>Last Name <font size="10"
                                                                COLOR="#FF0000">*</font></strong></td>
                        <td width="23%"><input type="text" name="lastname" id="lastname" maxlength="30" size=20
                                               value="<%=lastname%>"><strong class="style20"></strong></td>
                    </tr>

                    <tr>


                        <td width="10%"><strong>Phone<font size="10"
                                                           COLOR="#FF0000">*</font></strong></td>
                        <td width="21%"><input type="text" name="phone" id="phone" maxlength="15" size=14
                                               value="<%=phone%>"><strong class="style20"></strong></td>
                        <td width="10%"><strong>Email<font size="10"
                                                           COLOR="#FF0000">*</font></strong></td>
                        <td width="25%"><input type="text" name="email" id="email" maxlength="60" size=25
                                               value="<%=email%>"><strong class="style20"></strong></td>
                        <td width="12%"><strong>Assigned To <font size="10" COLOR="#FF0000">*</font></strong></td>
                        <td width="23%">
                            <select name="assignedto" id="assignedto" size="1">
                                <option value="--Select One--" selected>--Select One--</option>
                                <%

                                    HashMap al;

                                    String pro = "CRM";
                                    String fix = "1.0";
                                    al = GetProjectMembers.getBDMembers(pro, fix);
                                    if (al != null) {

                                        Collection set = al.keySet();
                                        Iterator iter = set.iterator();
                                        int assigned = 0;
                                        int useridassi = 0;

                                        while (iter.hasNext()) {

                                            String key = (String) iter.next();
                                            String nameofuser = (String) al.get(key);
                                            logger.info("Userid" + key);
                                            logger.info("Name" + nameofuser);

                                            // String commentedby=GetProjectMembers.getUserName(rs.getString("commentedby"));
                                            nameofuser = nameofuser.substring(0, nameofuser.indexOf(" ") + 2);

                                            useridassi = Integer.parseInt(key);
                                            if (useridassi == assi) {
                                                assigned = useridassi;
                                %>
                                <option value="<%=assigned%>" selected><%=nameofuser%></option>
                                <%
                                } else {
                                    assigned = useridassi;
                                %>
                                <option value="<%=assigned%>"><%=nameofuser%></option>
                                <%
                                            }
                                        }
                                    }
                                %>
                            </select></td>





                    </tr>
                    <tr>
                        <td width="10%"><strong>Mobile<font size="10"
                                                            COLOR="#FF0000">*</font></strong></td>
                        <td width="21%"><input type="text" name="mobile" id="mobile" maxlength="15" size=14
                                               value="<%=mobile%>"><strong class="style20"></strong></td>

                        <td width="10%"><strong>Company<font size="10"
                                                             COLOR="#FF0000">*</font></strong></td>
                        <td width="23%"><input type="text" name="company" id="company" maxlength="60" size=25
                                               value="<%=company%>"><strong class="style20"></strong></td>

                        <td width="12%"><strong>Reports to</strong></td>
                        <td width="23%"><input type="text" name="reportsto" id="reportsto" maxlength="30" size=20
                                               value="<%=reportsto%>"><strong class="style20"></strong></td>
                    </tr>

                    <tr>
                        <%
                            String[] ratingExist = {"Hot", "Warm", "Cold"};
                        %>
                        <td width="10%"><strong>Rating</strong></td>
                        <td width="21%"> 
                            <input type="hidden" id="exrating" value="<%= rating%>">
                            <SELECT NAME="rating" id="rating" size="1">
                                <%
                                    for (int i = 0; i < ratingExist.length; i++) {
                                        if (rating.equalsIgnoreCase(ratingExist[i])) {
                                %>
                                <option value="<%= rating%>" selected><%= rating%></option>
                                <%
                                } else {
                                %>
                                <option value="<%= ratingExist[i]%>"><%= ratingExist[i]%></option>
                                <%
                                        }
                                    }
                                %>
                            </SELECT></td>


                        <td width="10%"><strong>Accounts <font size="10"
                                                               COLOR="#FF0000">*</font></strong></td>
                                    <%
                                        PreparedStatement ps1 = null;
                                        ResultSet rs1 = null;

                                        ps1 = connection.prepareStatement("SELECT accountname  FROM account GROUP BY accountname Order by accountname asc");
                                        rs1 = ps1.executeQuery();
                                        String accounts = "";
                                    %>
                        <td width="23%"><select name="accounts" id="accounts" size="1">
                                <option value="--Select Account--" selected>--Select
                                    Account--</option>
                                    <%
                                        while (rs1.next()) {
                                            accounts = rs1.getString(1);
                                            if (accounts.equals(accountname)) {
                                    %>
                                <option value="<%=accounts%>" selected><%=accounts%></option>
                                <%
                                } else {
                                %>
                                <option value="<%=accounts%>"><%=accounts%></option>
                                <%
                                        }
                                    }
                                    if (rs1 != null) {
                                        rs1.close();
                                    }
                                    if (ps1 != null) {
                                        ps1.close();
                                    }
                                %>
                            </select></td>


                        <td width="12%"><strong>Contact Owner</strong></td>
                        <td width="23%"><input type="text" name="owner" id="owner" maxlength="30" size=20
                                               value="<%= GetProjectMembers.getUserName(contactOwner)%>" readonly=true><strong
                                               class="style20"></strong></td>


                    </tr>
                    <tr>
                        <td width="10%"><strong>Due Date<font size="10"	COLOR="#FF0000">*</font></strong></td>
                        <td width="21%"><input type="text" name="duedate" id="duedate" value="<%=dueDate%>"maxlength="10" size="14" readonly /><a href="javascript:NewCal('duedate','ddmmyyyy')"> <img src="<%=request.getContextPath()%>/images/newhelp.gif" 	border="0" width="16" height="16" alt="Pick a date"></a></td>
                        <td width="10%"><strong>Modified On</strong></td>
                        <td width="21%"><input type="text" name="modifiedon" id="modifiedon" value="<%=modified%>"maxlength="10" size="14" readonly /></td>
                        <td width="12%"><strong>Interested In </strong></td>
                        <td width="23%">

                            <select name="product" size="1" id="product">
                                <%					String products[] = {"eTracker", "eOutSource", "ERPDS"};
                                    for (int i = 0; i < products.length; i++) {
                                        if (product.equals(products[i])) {
                                %>
                                <option value="<%= product%>" selected><%= product%></option>
                                <%
                                } else {
                                %>
                                <option value="<%= products[i]%>"><%= products[i]%></option>
                                <%
                                        }

                                    }

                                %>
                            </select>
                        </td>

                    </tr>
                    <tr>
                        <td width="10%"><strong>ERP<font size="10" COLOR="#FF0000">*</font></strong></td>
                        <td width="25%">
                            <select name="erp" id="erp" size="1">
                                <option value="" disabled selected>Select</option>
                                <%for (String erpName : Contact.erpList()) {%>
                                <option value="<%=erpName%>"
                                        <%if (erpName.equalsIgnoreCase(erp)) {%>
                                        selected
                                        <%}%>
                                        ><%=erpName%></option>
                                <% }%>
                            </select>
                        </td>
                        <td width="10%"><strong>Vendor<font size="10" COLOR="#FF0000">*</font></strong></td>
                        <td width="25%">
                            <select name="vendor" id="vendor" onchange="javascript:showNewVendor();">
                                <option value="" disabled selected>Select</option>
                                <%for (String ven : CRMUtil.getVendors("contact")) {
                                        if (vendor.equals(ven)) {
                                %>
                                <option selected><%=ven%></option>
                                <% } else {%>
                                <option ><%=ven%></option>
                                <% }
                                    }%>
                                <option value="new">New</option>
                            </select>
                            <input type="text" name="newVendor" id="newVendor" maxlength="100" style="display: none;"  size="20">
                        </td>
                        <td width="10%">
                            <strong>Meeting<font size="10" COLOR="#FF0000">*</font></strong>
                        </td>
                        <td>
                            <input type="text" name="meetingdate" id="meetingdate" value="<%=meeting%>" maxlength="10" size="5" readonly /><a href="javascript:NewCal('meetingdate','ddmmyyyy')"> <img src="<%=request.getContextPath()%>/images/newhelp.gif" 	border="0" width="16" height="16" alt="Pick a date"></a>
                            <SELECT NAME="meetingtime" id="meetingtime" size="1">
                                <%
                                    String[] meetingTime = {"--None--", "First Half", "Second Half"};
                                    for (int i = 0; i < meetingTime.length; i++) {
                                        if (time.equals(meetingTime[i])) {
                                %>
                                <option value="<%= time%>" selected><%= time%></option>
                                <%
                                } else {
                                %>
                                <option value="<%= meetingTime[i]%>"><%= meetingTime[i]%></option>
                                <%
                                        }
                                    }
                                %>

                            </SELECT>
                        </td>
                    </tr>
                    <tr>
                        <td width="10%"><strong>Industry <font size="10" COLOR="#FF0000">*</font></strong></td>
                        <td width="25%">
                            <select name="industry" id="industry" onchange="javascript:showNew();">
                                <option value="" disabled selected>Select</option>
                                <%for (Map.Entry<Integer, String> ind : CRMUtil.getIndustry().entrySet()) {
                                        if (industryId == ind.getKey().intValue()) {
                                %>
                                <option value="<%=ind.getKey()%>" selected><%=ind.getValue()%></option>
                                <% } else {%>
                                <option value="<%=ind.getKey()%>"><%=ind.getValue()%></option>
                                <% }
                                    }%>
                                <option value="new">New</option>
                            </select>
                            <input type="text" name="newIndustry" id="newIndustry" class="newIndustryTd" maxlength="100" size=25 style="display: none;"
                                   ><strong class="style20"></strong>
                        </td>
                    </tr>
                    <tr>
                        <td width="10%"><strong>Type<font size="10" COLOR="#FF0000">*</font></strong></td>
                        <td width="25%">
                            <input type="hidden" id="decisionId" value="<%=decisionMaker%>"/>
                            <select name="contactType" id="contactType" size="1">
                                <%for (String contactType : Contact.contactType()) {%>
                                <option value="<%=contactType%>"
                                        <%if (contactType.equalsIgnoreCase(type)) {%>
                                        selected
                                        <%}%>
                                        ><%=contactType%></option>
                                <% }%>
                            </select>
                            <%if (!decisionMaker.equals("")) {%>
                            <span id="showDecision" style="display: none;">
                                Decision maker = <A HREF="<%=request.getContextPath()%>/MyCRM/contactIssueView.jsp?contactid=<%=decisionMaker.split("-")[0]%>"><font
                                        face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%=decisionMaker.split("-")[1]%> </font></A>
                            </span>
                            <%}%>
                        </td>
                    </tr>
                    <tr class="emlpoyeement" style="display: none;"><td width="100%" bgcolor="white" colspan=6 height="10"></td></tr>
                    <tr class="emlpoyeement" bgcolor="C3D9FF" style="display: none;">
                        <td colspan=7><strong >Employment History</strong></td>
                    </tr>

                    <tr class="emlpoyeement" style="display: none;"><td colspan=7 id="employeeData">
                            <table width="80%">
                                <tr>
                                    <th ></th>
                                    <th ><strong style="color: #000000">Company<font size="10" COLOR="#FF0000">*</font></strong></th>
                                    <th ><strong style="color: #000000">From<font size="10" COLOR="#FF0000">*</font></strong></th>
                                    <th ><strong style="color: #000000">To<font size="10" COLOR="#FF0000">*</font></strong></th>
                                    <th ><strong style="color: #000000">Role<font size="10" COLOR="#FF0000">*</font></strong></th>
                                </tr>
                                <%if (cwhs.isEmpty()) {%>
                                <%for (int i = 0; i < 4; i++) {%>

                                <tr id="<%=i%>">
                                    <%if (i == 0) {%>
                                    <td><strong>Current<font size="10" COLOR="#FF0000">*</font></strong></td>
                                                <%} else {%>
                                    <td><strong>Previous<font size="10" COLOR="#FF0000">*</font></strong></td>
                                                <%}%>
                                    <td >

                                        <select name="empCompany" id="empCompany<%=i%>" class="empCompany" >
                                            <option value=""  selected>Select</option>

                                            <%if (i == 0) {%>
                                            <option selected><%=company%></option>                                         
                                            <%}%>

                                            <%for (String dpt : companies) {
                                            %>
                                            <option ><%=dpt%></option>
                                            <%  }%>
                                            <option value="new">New</option>
                                        </select>
                                        <br/>
                                        <span><input type="text" name="newempCompany"  id="newempCompany<%=i%>" maxlength="200" size=30
                                                     style="display: none;"  ><strong class="style20"></strong>
                                        </span>
                                    </td>
                                    <td > <select name="fromYear" id="fromYear<%=i%>" class="fromYear" >
                                            <option value=""  selected>Select</option>
                                            <%for (int year : CRMUtil.getYears()) {
                                            %>
                                            <option ><%=year%></option>
                                            <%  }%>
                                        </select>
                                    </td>
                                    <td >
                                        <select name="toYear" id="toYear<%=i%>" class="toYear" >

                                            <%if (i == 0) {%>
                                            <option ><%=curr_year%></option>
                                            <%} else {%>
                                            <option value=""  selected>Select</option>
                                            <%for (int year : CRMUtil.getYears()) {
                                            %>
                                            <option ><%=year%></option>
                                            <%  }%>                                               
                                            <%}%>

                                        </select>

                                    </td>
                                    <td >
                                        <select name="role" id="role<%=i%>" class="role"  >
                                            <option value=""  selected>Select</option>
                                            <%for (String dpt : CRMUtil.getRoles()) {
                                            %>
                                            <option ><%=dpt%></option>
                                            <%  }%>
                                            <option value="new">New</option>
                                        </select>
                                        <br/>
                                        <span><input type="text" name="newrole" id="newrole<%=i%>" maxlength="100" size=30
                                                     style="display: none;"  ><strong class="style20"></strong>
                                        </span>
                                    </td>
                                </tr>
                                <%}%>
                                <%} else {%>
                                <%int i = 0;
                                    for (ContactWorkHistory cwh : cwhs) {
                                        cwh.setRole(cwh.getRole() == null ? "" : cwh.getRole());
                                        cwh.setCompany(cwh.getCompany() == null ? "" : cwh.getCompany());
                                %>

                                <tr id="<%=i%>">
                                    <%if (i == 0) {%>
                                    <td><strong>Current<font size="10" COLOR="#FF0000">*</font></strong></td>
                                                <%} else {%>
                                    <td><strong>Previous<font size="10" COLOR="#FF0000">*</font></strong></td>
                                                <%}%>
                                    <td>
                                        <select name="empCompany" id="empCompany<%=i%>" class="empCompany" >
                                            <option value=""  selected>Select</option>
                                            <%for (String dpt : companies) {
                                            %>
                                            <option  <%if (cwh.getCompany().equalsIgnoreCase(dpt)) {%>
                                                selected
                                                <%}%>><%=dpt%></option>
                                            <%  }%>
                                            <option value="new">New</option>
                                        </select>
                                        <input type="text" name="newempCompany"  id="newempCompany<%=i%>" maxlength="200" size=30
                                               style="display: none;"  ><strong class="style20"></strong>
                                    </td>
                                    <td> <select name="fromYear" id="fromYear<%=i%>" class="fromYear"  >
                                            <option value=""  selected>Select</option>
                                            <%for (int year : CRMUtil.getYears()) {
                                            %>
                                            <option <%if (cwh.getFromYear() == year) {%>
                                                selected
                                                <%}%>>
                                                <%=year%></option>
                                                <%  }%>
                                        </select>
                                    </td>
                                    <td>
                                        <select name="toYear" id="toYear<%=i%>" class="toYear" >
                                            <option value=""  selected>Select</option>
                                            <%for (int year : CRMUtil.getYears()) {
                                            %>
                                            <option<%if (cwh.getToYear() == year) {%>
                                                selected
                                                <%}%> ><%=year%></option>
                                            <%  }%>
                                        </select>

                                    </td>
                                    <td>
                                        <select name="role" id="role<%=i%>" class="role"  >
                                            <option value=""  selected>Select</option>
                                            <%for (String dpt : CRMUtil.getRoles()) {
                                            %>
                                            <option <%if (cwh.getRole().equalsIgnoreCase(dpt)) {%>
                                                selected
                                                <%}%>><%=dpt%></option>
                                            <%  }%>
                                            <option value="new">New</option>
                                        </select>
                                        <input type="text" name="newrole" id="newrole<%=i%>" maxlength="100" size=30
                                               style="display: none;"  ><strong class="style20"></strong>
                                    </td>
                                </tr>
                                <%i++;
                                    }%>
                                <%if (cwhs.size() <= 5) {%>

                                <%for (; i < 4; i++) {%>
                                <tr id="<%=i%>">
                                    <td><strong>Previous<font size="10" COLOR="#FF0000">*</font></strong></td>
                                    <td >
                                        <select name="empCompany" id="empCompany<%=i%>" class="empCompany" >
                                            <option value=""  selected>Select</option>
                                            <%if (i == 0) {%>
                                            <option selected><%=company%></option>                                         
                                            <%}%>
                                            <%for (String dpt : companies) {
                                            %>
                                            <option ><%=dpt%></option>
                                            <%  }%>
                                            <option value="new">New</option>
                                        </select>
                                        <br/>
                                        <span><input type="text" name="newempCompany"  id="newempCompany<%=i%>" maxlength="200" size=30
                                                     style="display: none;"  ><strong class="style20"></strong>
                                        </span>
                                    </td>
                                    <td > <select name="fromYear" id="fromYear<%=i%>" class="fromYear" >
                                            <option value=""  selected>Select</option>
                                            <%for (int year : CRMUtil.getYears()) {
                                            %>
                                            <option ><%=year%></option>
                                            <%  }%>
                                        </select>
                                    </td>
                                    <td >
                                        <select name="toYear" id="toYear<%=i%>" class="toYear" >

                                            <%if (i == 0) {%>
                                            <option ><%=curr_year%></option>
                                            <%} else {%>
                                            <option value=""  selected>Select</option>
                                            <%for (int year : CRMUtil.getYears()) {
                                            %>
                                            <option ><%=year%></option>
                                            <%  }%>                                               
                                            <%}%>

                                        </select>

                                    </td>
                                    <td >
                                        <select name="role" id="role<%=i%>" class="role"  >
                                            <option value=""  selected>Select</option>
                                            <%for (String dpt : CRMUtil.getRoles()) {
                                            %>
                                            <option ><%=dpt%></option>
                                            <%  }%>
                                            <option value="new">New</option>
                                        </select>
                                        <br/>
                                        <span><input type="text" name="newrole" id="newrole<%=i%>" maxlength="100" size=30
                                                     style="display: none;"  ><strong class="style20"></strong>
                                        </span>
                                    </td>
                                </tr>
                                <%}%>
                                <%}%>
                                <%}%>

                            </table>
                        </td>
                    </tr>
                    <tr class="decisionMakerTab" style="display: none;"><td width="100%" bgcolor="white" colspan=6 height="10"></td></tr>
                    <tr class="decisionMakerTab" bgcolor="C3D9FF" style="display: none;">
                        <td colspan=7><strong >Competitor Details</strong></td>
                    </tr>

                    <tr class="decisionMakerTab" style="display: none;"><td colspan=7 id="competitorData">
                            <table width="80%">
                                <tr>
                                    <th ></th>
                                    <th ><strong style="color: #000000">Company<font size="10" COLOR="#FF0000">*</font></strong></th>
                                    <th ><strong style="color: #000000">City<font size="10" COLOR="#FF0000">*</font></strong></th>
                                    <th ><strong style="color: #000000">State<font size="10" COLOR="#FF0000">*</font></strong></th>
                                    <th ><strong style="color: #000000">Country<font size="10" COLOR="#FF0000">*</font></strong></th>
                                </tr>
                                <%
                                    if (competitorses.isEmpty()) {

                                        for (int i = 1; i <= 10; i++) {%>

                                <tr id="<%=i%>">
                                    <td><strong>Competitors<%=i%><font size="10" COLOR="#FF0000">*</font></strong></td>
                                    <td>
                                        <select name="companyCompetitors" id="companyCompetitors<%=i%>" class="companyCompetitors">
                                            <option value=""  selected>Select</option>
                                            <%for (String dpt : competitors) {%>
                                            <option ><%=dpt%></option>
                                            <%  }%>
                                            <option value="new">New</option>
                                        </select>
                                        <input type="text" name="newcompanyCompetitors"  id="newcompanyCompetitors<%=i%>" maxlength="200" size=30
                                               style="display: none;"  ><strong class="style20"></strong>
                                        </span>
                                    </td>
                                    <td > <select name="competitorcity" id="competitorcity<%=i%>" class="competitorcity" >
                                            <option value=""  selected>Select</option>
                                            <%for (String city : allCity) {
                                            %>                                          
                                            <option ><%=city%></option>
                                            <%}%>
                                            <option value="new">New</option>
                                        </select>                        
                                        <input type="text" name="newcompetitorcity" id="newcompetitorcity<%=i%>" maxlength="30" size=25
                                               style="display: none;"    ><strong class="style20"></strong>
                                    </td>
                                    <td >
                                        <select name="competitorstate" id="competitorstate<%=i%>" class="competitorstate">
                                            <option value=""  selected>Select</option>
                                            <%for (String state : allStates) {
                                            %>
                                            <option ><%=state%></option>
                                            <% }%>
                                            <option value="new">New</option>
                                        </select>

                                        <input type="text" name="newcompetitorstate" id="newcompetitorstate<%=i%>" maxlength="30"
                                               style="display: none;"  size=20 ><strong class="style20"></strong>
                                    </td>


                                    <td >
                                        <select name="competitorcountry" id="competitorcountry<%=i%>" class="competitorcountry">
                                            <%if (i <= 5) {%>
                                            <option value="India"  selected>India</option>
                                            <%} else {%>
                                            <option value=""  selected>Select</option>

                                            <%for (String country : allCountries) {
                                            %>
                                            <option ><%=country%></option>
                                            <% }%>
                                            <option value="new">New</option>
                                            <%}%>
                                        </select>
                                        <input type="text" name="newcompetitorcountry" id="newcompetitorcountry<%=i%>" maxlength="100" size=30
                                               style="display: none;"  ><strong class="style20"></strong>
                                    </td>
                                </tr>
                                <%}
                                } else {
                                    int i = 1;
                                    for (CrmCompetitors cc : competitorses) {
                                        cc.setCompetitor(cc.getCompetitor() == null ? "" : cc.getCompetitor());
                                        cc.setCity(cc.getCity() == null ? "" : cc.getCity());
                                        cc.setState(cc.getState() == null ? "" : cc.getState());
                                        cc.setCountry(cc.getCountry() == null ? "" : cc.getCountry());%>

                                <tr id="<%=i%>">
                                    <td><strong>Competitors<%=i%><font size="10" COLOR="#FF0000">*</font></strong></td>
                                    <td>
                                        <select name="companyCompetitors" id="companyCompetitors<%=i%>" class="companyCompetitors">
                                            <option value=""selected >Select</option>                                
                                            <%for (String dpt : competitors) {%>
                                            <option <%if (cc.getCompetitor().equalsIgnoreCase(dpt)) {%>
                                                selected
                                                <%}%>><%=dpt%></option>
                                            <%  }%>
                                            <option value="new">New</option>
                                        </select>
                                        <input type="text" name="newcompanyCompetitors"  id="newcompanyCompetitors<%=i%>" maxlength="200" size=30
                                               style="display: none;"  ><strong class="style20"></strong>
                                        </span>
                                    </td>
                                    <td > <select name="competitorcity" id="competitorcity<%=i%>" class="competitorcity" >
                                            <option value=""  selected>Select</option>
                                            <%for (String city : allCity) {
                                            %>                                          
                                            <option <%if (cc.getCity().equalsIgnoreCase(city)) {%>
                                                selected
                                                <%}%>><%=city%></option>
                                            <%}%>
                                            <option value="new">New</option>
                                        </select>                        
                                        <input type="text" name="newcompetitorcity" id="newcompetitorcity<%=i%>" maxlength="30" size=25
                                               style="display: none;"    ><strong class="style20"></strong>
                                    </td>
                                    <td >
                                        <select name="competitorstate" id="competitorstate<%=i%>" class="competitorstate">
                                            <option value=""  selected>Select</option>
                                            <%for (String state : allStates) {
                                            %>
                                            <option <%if (cc.getState().equalsIgnoreCase(state)) {%>
                                                selected
                                                <%}%>><%=state%></option>
                                            <% }%>
                                            <option value="new">New</option>
                                        </select>

                                        <input type="text" name="newcompetitorstate" id="newcompetitorstate<%=i%>" maxlength="30"
                                               style="display: none;"  size=20 ><strong class="style20"></strong>
                                    </td>


                                    <td >
                                        <select name="competitorcountry" id="competitorcountry<%=i%>" class="competitorcountry">
                                            <%if (i <= 5) {%>
                                            <option value="India"  selected>India</option>
                                            <%} else {%>
                                            <option value=""  selected>Select</option>

                                            <%for (String country : allCountries) {
                                            %>
                                            <option <%if (cc.getCountry().equalsIgnoreCase(country)) {%>
                                                selected
                                                <%}%>><%=country%></option>
                                            <% }%>
                                            <option value="new">New</option>
                                            <%}%>
                                        </select>
                                        <input type="text" name="newcompetitorcountry" id="newcompetitorcountry<%=i%>" maxlength="100" size=30
                                               style="display: none;"  ><strong class="style20"></strong>
                                    </td>
                                </tr>
                                <%i++;
                                    }

                                    for (; i <= 10; i++) {%>

                                <tr id="<%=i%>">
                                    <td><strong>Competitors<%=i%><font size="10" COLOR="#FF0000">*</font></strong></td>
                                    <td>
                                        <select name="companyCompetitors" id="companyCompetitors<%=i%>" class="companyCompetitors">
                                            <option value=""  selected>Select</option>
                                            <%for (String dpt : competitors) {%>
                                            <option ><%=dpt%></option>
                                            <%  }%>
                                            <option value="new">New</option>
                                        </select>
                                        <input type="text" name="newcompanyCompetitors"  id="newcompanyCompetitors<%=i%>" maxlength="200" size=30
                                               style="display: none;"  ><strong class="style20"></strong>
                                        </span>
                                    </td>
                                    <td > <select name="competitorcity" id="competitorcity<%=i%>" class="competitorcity" >
                                            <option value=""  selected>Select</option>
                                            <%for (String city : allCity) {
                                            %>                                          
                                            <option ><%=city%></option>
                                            <%}%>
                                            <option value="new">New</option>
                                        </select>                        
                                        <input type="text" name="newcompetitorcity" id="newcompetitorcity<%=i%>" maxlength="30" size=25
                                               style="display: none;"    ><strong class="style20"></strong>
                                    </td>
                                    <td >
                                        <select name="competitorstate" id="competitorstate<%=i%>" class="competitorstate">
                                            <option value=""  selected>Select</option>
                                            <%for (String state : allStates) {
                                            %>
                                            <option ><%=state%></option>
                                            <% }%>
                                            <option value="new">New</option>
                                        </select>

                                        <input type="text" name="newcompetitorstate" id="newcompetitorstate<%=i%>" maxlength="30"
                                               style="display: none;"  size=20 ><strong class="style20"></strong>
                                    </td>


                                    <td >
                                        <select name="competitorcountry" id="competitorcountry<%=i%>" class="competitorcountry">
                                            <%if (i <= 5) {%>
                                            <option value="India"  selected>India</option>
                                            <%} else {%>
                                            <option value=""  selected>Select</option>

                                            <%for (String country : allCountries) {
                                            %>
                                            <option ><%=country%></option>
                                            <% }%>
                                            <option value="new">New</option>
                                            <%}%>
                                        </select>
                                        <input type="text" name="newcompetitorcountry" id="newcompetitorcountry<%=i%>" maxlength="100" size=30
                                               style="display: none;"  ><strong class="style20"></strong>
                                    </td>
                                </tr>
                                <%}
                                    }%>
                            </table>
                        </td>
                    </tr>
                    <tr class="decisionMakerTab" style="display: none;"><td width="100%" bgcolor="white" colspan=6 height="10"></td></tr>
                    <tr class="decisionMakerTab" bgcolor="C3D9FF" style="display: none;">
                        <td colspan=7><strong >Company Details</strong></td>
                    </tr>

                    <tr class="decisionMakerTab" style="display: none;"><td colspan=7 id="companyData">
                            <table width="80%">
                                <tr>
                                    <th ><strong style="color: #000000">Year<font size="10" COLOR="#FF0000">*</font></strong></th>
                                    <th ><strong style="color: #000000">Currency<font size="10" COLOR="#FF0000">*</font></strong></th>
                                    <th ><strong style="color: #000000">Sales#<font size="10" COLOR="#FF0000">*</font></strong></th>
                                    <th ><strong style="color: #000000">Employees#<font size="10" COLOR="#FF0000">*</font></strong></th>
                                    <th ><strong style="color: #000000">IT Spend<font size="10" COLOR="#FF0000">*</font></strong></th>
                                    <th ><strong style="color: #000000">ERP/SAP Spend<font size="10" COLOR="#FF0000">*</font></strong></th>
                                </tr>
                                <%if (companySaleses.isEmpty()) {
                                        for (int i = 1; i <= 5; i++) {%>
                                <tr>
                                    <td><input type="text" name="year" class="year" id="year<%=i%>" value="<%=curr_year%>" readonly/></td>
                                    <td>
                                        <select name="currency" id="currency<%=i%>" class="currency">
                                            <option value=""  selected>Select</option>
                                            <%for (String curr : currencies) {
                                            %>
                                            <option ><%=curr%></option>
                                            <% }%>
                                        </select>                                        
                                    </td>
                                    <td><input type="number" name="sales" class="sales" id="sales<%=i%>" min="0" onkeypress="return isNumber(event)"/></td>
                                    <td><input type="number" name="employees" class="employees" id="employees<%=i%>" min="0" onkeypress="return isNumber(event)" /></td>
                                    <td><input type="number" name="itSpend" class="itSpend" id="itSpend<%=i%>" min="0" onkeypress="return isNumber(event)"/></td>
                                    <td><input type="number" name="erpSpend" class="erpSpend" id="erpSpend<%=i%>" min="0" onkeypress="return isNumber(event)"/></td>
                                </tr>
                                <%curr_year--;
                                    }
                                } else {
                                    int i = 1;
                                    curr_year = Calendar.getInstance().get(Calendar.YEAR);
                                    if (curr_year != latestOfSales) {
                                        for (int j = 0; j <= (curr_year - latestOfSales); j++) {%>
                                <tr>
                                    <td><input type="text" name="year" class="year" id="year<%=i%>" value="<%=curr_year%>" readonly/></td>

                                    <td>
                                        <select name="currency" id="currency<%=i%>" class="currency">
                                            <option value=""  selected>Select</option>
                                            <%for (String curr : currencies) {
                                            %>
                                            <option ><%=curr%></option>
                                            <% }%>
                                        </select>                                        
                                    </td>
                                    <td><input type="number" name="sales" class="sales" id="sales<%=i%>" min="0" onkeypress="return isNumber(event)"/></td>
                                    <td><input type="number" name="employees" class="employees" id="employees<%=i%>" min="0" onkeypress="return isNumber(event)" /></td>
                                    <td><input type="number" name="itSpend" class="itSpend" id="itSpend<%=i%>" min="0" onkeypress="return isNumber(event)"/></td>
                                    <td><input type="number" name="erpSpend" class="erpSpend" id="erpSpend<%=i%>" min="0" onkeypress="return isNumber(event)"/></td>
                                </tr> 
                                <% curr_year--;
                                            i++;
                                        }
                                    }
                                    for (CrmCompanySales ccs : companySaleses) {%>
                                <tr>
                                    <td><input type="text" name="year" class="year" id="year<%=i%>" value="<%=ccs.getSalesYear()%>" readonly/></td>
                                    <td>
                                        <select name="currency" id="currency<%=i%>" class="currency">
                                            <option value=""  selected>Select</option>
                                            <%for (String curr : currencies) {%>
                                            <option <%if (ccs.getCurrency() != null && ccs.getCurrency().equalsIgnoreCase(curr)) {%>
                                                selected
                                                <%}%>><%=curr%></option>
                                            <% }%>
                                        </select>                                        
                                    </td>
                                    <td><input type="number" name="sales" class="sales" id="sales<%=i%>" min="0" value="<%=ccs.getSales()%>"  onkeypress="return isNumber(event)"/></td>
                                    <td><input type="number" name="employees" class="employees" id="employees<%=i%>" min="0" value="<%=ccs.getEmployees()%>"  onkeypress="return isNumber(event)" /></td>
                                    <td><input type="number" name="itSpend" class="itSpend" id="itSpend<%=i%>" min="0" value="<%=ccs.getItSpend()%>"  onkeypress="return isNumber(event)"/></td>
                                    <td><input type="number" name="erpSpend" class="erpSpend" id="erpSpend<%=i%>" min="0" value="<%=ccs.getErpSpend()%>"  onkeypress="return isNumber(event)"/></td>
                                </tr>
                                <%
                                            i++;
                                        }
                                    }%>
                            </table>
                        </td>
                    </tr>
                    <tr><td width="100%" bgcolor="white" colspan=6 height="10"></td></tr>
                    <tr bgcolor="C3D9FF">
                        <td colspan=7><strong >Address Information</strong> &nbsp;&nbsp;&nbsp;<a href="#" id="addPlant"style="cursor: pointer;"> Add Plant Address</a>
                            <input type="hidden" name="ownerid" id="ownerid" value="<%=contactOwner%>">
                            <input type="hidden" name="contactid" id="contactid" value="<%=contactid%>"></td>
                    </tr>

                    <tr>
                        <td width="10%"><strong>Street</strong></td>
                        <td width="21%"> <textarea name="mailingstreet" id="mailingstreet" wrap="physical" cols="13"
                                                   rows="2"><%=mailingstreet%></textarea></td>

                        <td width="10%"><strong>Area/Location</strong></td>
                        <td width="23%">
                            <select name="mailingarea" id="mailingarea" onchange="javascript:showNewArea();">
                                <option value="" disabled selected>Select</option>
                                <%for (String area : contactArea) {
                                        if (mailingarea.equals(area)) {
                                %>
                                <option selected><%=area%></option>
                                <% } else {%>
                                <option ><%=area%></option>
                                <% }
                                    }%>
                                <option value="new">New</option>
                            </select>
                            <input type="text" name="newMailingarea" id="newMailingarea" maxlength="50" size=25
                                   style="display: none;"  ><strong class="style20"></strong>
                        </td>


                        <td width="10%"><strong>City</strong></td>
                        <td width="23%">
                            <select name="mailingcity" id="mailingcity" onchange="javascript:showNewCity();">
                                <option value="" disabled selected>Select</option>
                                <%for (String city : contactCity) {
                                        if (mailingcity.equals(city)) {
                                %>
                                <option selected><%=city%></option>
                                <% } else {%>
                                <option ><%=city%></option>
                                <% }
                                    }%>
                                <option value="new">New</option>
                            </select>                        
                            <input type="text" name="newMailingcity" id="newMailingcity" maxlength="30" size=25
                                   style="display: none;"    ><strong class="style20"></strong>
                        </td>




                    </tr>
                    <tr>
                        <td width="10%"><strong>Zip</strong></td>
                        <td width="21%"><input type="text" name="mailingzip" id="mailingzip" maxlength="30" size=14
                                               value="<%=mailingzip%>"><strong class="style20"></strong></td>
                        <td width="12%"><strong>State</strong></td>
                        <td width="23%">
                            <select name="mailingstate" id="mailingstate" onchange="javascript:showNewState();">
                                <option value="" disabled selected>Select</option>
                                <%for (String state : contactState) {
                                        if (mailingstate.equals(state)) {
                                %>
                                <option selected><%=state%></option>
                                <% } else {%>
                                <option ><%=state%></option>
                                <% }
                                    }%>
                                <option value="new">New</option>
                            </select>

                            <input type="text" name="newMailingstate" id="newMailingstate" maxlength="30"
                                   style="display: none;"  size=20 ><strong class="style20"></strong></td>


                        <td width="10%"><strong>Country</strong></td>
                        <td width="23%">

                            <select name="mailingcountry" id="mailingcountry" onchange="javascript:showNewCountry();">
                                <option value="" disabled selected>Select</option>
                                <%for (String country : contactCountry) {
                                        if (mailingcountry.equals(country)) {
                                %>
                                <option selected><%=country%></option>
                                <% } else {%>
                                <option ><%=country%></option>
                                <% }
                                    }%>
                                <option value="new">New</option>
                            </select>    
                            <input type="text" name="newMailingcountry" id="newMailingcountry" maxlength="30"
                                   style="display: none;"     size=25 ><strong class="style20"></strong></td>


                    </tr>

                    <tr class="plantTab" style="display: none;"><td width="100%" bgcolor="white" colspan=6 height="10"></td></tr>
                    <tr class="plantTab" bgcolor="C3D9FF" style="display: none;">
                        <td colspan=7><strong >Plant Address </strong></td>
                    </tr>

                    <tr class="plantTab" style="display: none;"><td colspan=7>
                            <table width="80%" id="plantTable">
                                <thead>
                                    <tr>
                                        <th ><strong style="color: #000000">Area<font size="10" COLOR="#FF0000">*</font></strong></th>
                                        <th ><strong style="color: #000000">City<font size="10" COLOR="#FF0000">*</font></strong></th>
                                        <th ><strong style="color: #000000">State<font size="10" COLOR="#FF0000">*</font></strong></th>
                                        <th ><strong style="color: #000000">Country<font size="10" COLOR="#FF0000">*</font></strong></th>
                                    </tr>
                                </thead>
                                <%if (!companyPlantses.isEmpty()) {
                                        for (CrmCompanyPlants ccp : companyPlantses) {%>
                                <tr>
                                    <td>
                                        <input type="hidden" name="plantid" value="<%=ccp.getPlantId()%>"/>
                                        <select name="plantarea" id="plantarea<%=ccp.getPlantId()%>" >
                                            <%for (String area : contactArea) {%>
                                            <option <%if (ccp.getPlantArea().equals(area)) {%>
                                                selected
                                                <%}%>><%=area%></option>
                                            <% }%>
                                        </select>
                                    </td>

                                    <td>
                                        <select name="plantcity" id="plantcity<%=ccp.getPlantId()%>" >
                                            <%for (String city : contactCity) {%>
                                            <option <%if (ccp.getPlantCity().equals(city)) {%>
                                                selected
                                                <%}%>><%=city%></option>
                                            <% }%>
                                        </select>
                                    </td>
                                    <td>
                                        <select name="plantstate" id="plantstate<%=ccp.getPlantId()%>" >
                                            <%for (String state : contactState) {%>
                                            <option <%if (ccp.getPlantState().equals(state)) {%>
                                                selected
                                                <%}%>><%=state%></option>
                                            <% }%>
                                        </select>
                                    </td>

                                    <td>
                                        <select name="plantcountry" id="plantcountry<%=ccp.getPlantId()%>" >
                                            <%for (String country : contactCountry) {%>
                                            <option <%if (ccp.getPlantCountry().equals(country)) {%>
                                                selected
                                                <%}%>><%=country%></option>
                                            <% }%>
                                        </select>
                                    </td>                       
                                </tr>
                                <%}
                                    }%>
                            </table>
                        </td>
                    </tr>

                    <tr><td width="100%" bgcolor="white" colspan=6 height="10"></td></tr>

                    <tr bgcolor="C3D9FF">
                        <td colspan=6><strong>Additional Information</strong></td>
                    </tr>


                    <tr>
                        <td width="10%"><strong>Fax</strong></td>
                        <td width="21%"><input type="text" name="fax" id="fax" maxlength="30" size=14
                                               value="<%=fax%>"><strong class="style20"></strong></td>
                        <td width="10%"><strong>Home Phone</strong></td>
                        <td width="23%"><input type="text" name="homephone" id="homephone" maxlength="30" size=25
                                               value="<%=homephone%>"><strong class="style20"></strong></td>
                        <td width="12%"><strong>Other Phone</strong></td>
                        <td width="23%"><input type="text" name="otherphone" id="otherphone" maxlength="30" size=20
                                               value="<%=otherphone%>"><strong class="style20"></strong></td>

                    </tr>

                    <tr>

                        <td width="10%"><strong>Department</strong></td>
                        <td width="21%">

                            <select name="department" id="department" onchange="javascript:showNewDept();">
                                <option value="" disabled selected>Select</option>
                                <%for (String dpt : CRMUtil.getDepartments("contact")) {
                                        if (department.equals(dpt)) {
                                %>
                                <option selected><%=dpt%></option>
                                <% } else {%>
                                <option ><%=dpt%></option>
                                <% }
                                    }%>
                                <option value="new">New</option>
                            </select>
                            <input type="text" name="newDepartment" id="newDepartment" maxlength="30" size=14
                                   style="display: none;"  ><strong class="style20"></strong></td>

                        <td width="10%"><strong>Assistant</strong></td>
                        <td width="23%"><input type="text" name="assistant" id="assistant" maxlength="30" size=25
                                               value="<%=assistant%>"><strong class="style20"></strong></td>

                        <td width="12%"><strong>Asst. Phone</strong></td>
                        <td width="23%"><input type="text" name="asstphone" id="asstphone" maxlength="30" size=20
                                               value="<%=asstphone%>"><strong class="style20"></strong></td>
                    </tr>
                    <tr>
                        <td width="10%"><strong>Birthdate</strong></td>
                        <td width="21%"><input type="text" name="birthdate" id="birthdate" maxlength="30" size=14
                                               value="<%=birthdate%>" readonly="true"> <strong
                                               class="style20"></strong><a
                                               href="javascript:NewCal('birthdate','ddmmyyyy')"> <img
                                    src="<%=request.getContextPath()%>/images/newhelp.gif" width="16" height="16" border="0"
                                    alt="Pick a date"></a></td>
                        <td width="10%"><strong>Lead Source</strong></td>

                        <td align="left" width="23%">
                            <SELECT NAME="leadsource" id="leadsource" size="1">
                                <%
                                    String[] leadsourceExist = {"--None--", "Advertisement", "Employee Referrel", "External Referrel", "partner", "public relataion", "seminar-internal", "Trade Show", "web", "Word of mouth", "others"};
                                    for (int i = 0; i < leadsourceExist.length; i++) {
                                        if (leadsource.equals(leadsourceExist[i])) {
                                %>
                                <option value="<%= leadsource%>" selected><%= leadsource%></option>
                                <%
                                } else {
                                %>
                                <option value="<%= leadsourceExist[i]%>"><%= leadsourceExist[i]%></option>
                                <%
                                        }
                                    }
                                %>
                            </SELECT>
                        </td>

                        <%
                            if (rating.equalsIgnoreCase("Hot") && roleid == 2 && accounts != null && dueDate != "NA") {%>
                        <td width="12%"><strong>Move to Lead</strong></td>
                        <td width="23%"><input type="checkbox" name="movetolead" id="movetolead"	size=20  value="<%=contactid%>" onclick="moveContact()"><strong class="style20"></strong></td>
                            <%}%>

                    </tr>

                    <tr><td width="100%" bgcolor="white" colspan=6 height="10"></td></tr>
                    <tr bgcolor="C3D9FF" width="100%">
                        <td colspan=6 width="100%"><strong>Description</strong></td>
                    </tr>

                    <tr >

                        <td colspan=6><%=description%></td>
                    </tr>

                    <tr height="21">
                        <td width="100%" class="textdisplay" align="left" colspan=6>
                            <p class="textdisplay" id="commentsp"><b>Comments</b></p>
                        </td>
                    </tr>
                    <tr height="21">
                        <td align="center" colspan=5><font size="2"	face="Verdana, Arial, Helvetica, sans-serif">
                                <textarea rows="3" cols="68" name="comments" maxlength="4000"
                                          onKeyDown="textCounter(document.theForm.comments, document.theForm.remLen1, 4000)"
                                          onKeyUp="textCounter(document.theForm.comments, document.theForm.remLen1, 4000)"></textarea></font>
                            <input readonly type="text" name="remLen1" id="remLen1" size="3"
                                   maxlength="3" value="4000">characters left</td>
                <script type="text/javascript">
                    CKEDITOR.replace('comments', {toolbar: 'Basic', height: 100});
                    var editor_data = CKEDITOR.instances.comments.getData();
                    CKEDITOR.instances["comments"].on("instanceReady", function ()
                    {

                        //set keyup event
                        this.document.on("keyup", updateExpectedResult);
                        //and paste event
                        this.document.on("paste", updateExpectedResult);
                    });
                    function updateExpectedResult()
                    {
                        CKEDITOR.tools.setTimeout(function ()
                        {
                            var desc = CKEDITOR.instances.comments.getData();
                            var leng = desc.length;
                            editorTextCounter(leng, document.getElementById('remLen1'), 4000);
                        }, 0);
                    }
                </script>
                </tr>


                <tr align="center">
                    <td></td><td></td><td></td>
                    <td  align="center">
                        <INPUT type=submit onclick="this.form.submited = this.value;" value=Update name=submit>
                        <INPUT type=submit onclick="this.form.submited = this.value;"  value=Draft  name=submit>
                        <input type=reset value=Reset id=reset name=reset>
                    </td>
                    <td></td>
                    <td></td>
                </tr>
                </TBODY>
            </table>
            <%
                session.setAttribute("name", firstname);
                session.setAttribute("category", "contact");
            %> <iframe
                src="./commentHistory.jsp?contactId=<%= contactid%>" scrolling="auto"
                frameborder="2" height="45%" width="100%"></iframe> <br>
            <br>
            <br>


        </FORM>

        <%
                        }
                    }
                }
            } catch (Exception ex) {
                ex.printStackTrace();
                logger.error(ex.getMessage());
            } finally {
                if (rs != null) {
                    rs.close();
                }
                if (st != null) {
                    st.close();
                }

                if (connection != null) {

                    connection.close();

                }

            }
        %>
        <BR>


        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>


        <script>

                            jQuery(document).ready(function () {
                                var rowCount = $('#plantTable tr').length;
                                if (rowCount > 1) {
                                    $(".plantTab").show();
                                }

                                var contactType = $('#contactType :selected').val();
                                if (contactType === 'Normal') {
                                    $(".emlpoyeement").hide();
                                    $(".decisionMakerTab").hide();
                                } else if (contactType === 'Influencer') {
                                    $(".emlpoyeement").show();
                                    $(".decisionMakerTab").hide();
                                } else if (contactType === 'Decision Maker') {
                                    $(".emlpoyeement").show();
                                    $(".decisionMakerTab").show();
                                    $("#contactType option[value='Normal']").remove();
                                }


                            });
                            $("#contactType").on('change', function () {
                                $("#showDecision").hide();
                                var contactType = $(this).val();
                                if (contactType === 'Normal') {
                                    $(".emlpoyeement").hide();
                                    $(".decisionMakerTab").hide();
                                } else if (contactType === 'Influencer') {
                                    $(".emlpoyeement").show();
                                    $(".decisionMakerTab").hide();
                                } else if (contactType === 'Decision Maker') {
                                    var decisionId = $('#decisionId').val();
                                    var contactId = $('#contactid').val();
                                    if (decisionId === '') {
                                        $(".emlpoyeement").show();
                                        $(".decisionMakerTab").show();
                                    } else if (decisionId.split("-")[0] !== contactId) {
                                        $("#contactType").val("Influencer");
                                        $(".emlpoyeement").show();
                                        $("#showDecision").show();
                                        $(".decisionMakerTab").hide();
                                    } else {
                                        $(".emlpoyeement").show();
                                        $(".decisionMakerTab").show();
                                    }
                                }
                            });
                            $(document).on("change", ".empCompany", function () {
                                var empCompany = $(this).attr('id');
                                if ($('#' + empCompany).val() === 'new') {
                                    $('#new' + empCompany).show();
                                } else {
                                    $('#new' + empCompany).hide();
                                }
                            });
                            $(document).on("change", ".role", function () {
                                var role = $(this).attr('id');
                                if ($('#' + role).val() === 'new') {
                                    $('#new' + role).show();
                                } else {
                                    $('#new' + role).hide();
                                }
                            });
                            $(document).on("change", ".companyCompetitors", function () {
                                var competitorid = $(this).attr('id');
                                var competitor = $('#' + competitorid).val();
                                if (competitor === 'new') {
                                    $('#new' + competitorid).show();
                                } else {
                                    var id = competitorid.split("companyCompetitors")[1];
                                    $('#new' + competitorid).hide();
                                    $.ajax({
                                        url: '<%=request.getContextPath()%>/MyCRM/getAddressByCompany.jsp',
                                        data: {company: competitor, rand: Math.random(1, 10)},
                                        async: false,
                                        type: 'GET',
                                        success: function (responseJson, statusTxt, xhr) {
                                            if (statusTxt == "success") {
                                                var city = '';
                                                var state = '';
                                                var country = '';
                                                for (var key in responseJson) {
                                                    if (key == 'city') {
                                                        city = responseJson[key];
                                                    } else if (key == 'state') {
                                                        state = responseJson[key];
                                                    } else if (key == 'country') {
                                                        country = responseJson[key];
                                                    }
                                                }

                                                if (city.length > 0) {
                                                    $('#competitorcity' + id).val(city);
                                                }
                                                if (state.length > 0) {
                                                    $('#competitorstate' + id).val(state);
                                                }
                                                if (country.length > 0) {
                                                    $('#competitorcountry' + id).val(country);
                                                }

                                            }
                                        }
                                    }
                                    );
                                }
                            });
                            $(document).on("change", ".competitorcity", function () {
                                var competitorcity = $(this).attr('id');
                                if ($('#' + competitorcity).val() === 'new') {
                                    $('#new' + competitorcity).show();
                                } else {
                                    $('#new' + competitorcity).hide();
                                }
                            });
                            $(document).on("change", ".competitorstate", function () {
                                var competitorstate = $(this).attr('id');
                                if ($('#' + competitorstate).val() === 'new') {
                                    $('#new' + competitorstate).show();
                                } else {
                                    $('#new' + competitorstate).hide();
                                }
                            });
                            $(document).on("change", ".competitorcountry", function () {
                                var competitorcountry = $(this).attr('id');
                                if ($('#' + competitorcountry).val() === 'new') {
                                    $('#new' + competitorcountry).show();
                                } else {
                                    $('#new' + competitorcountry).hide();
                                }
                            });
                            $(document).on("click", "#addPlant", function () {

                                $('.plantTab').show();
                                var rowCount = $('#plantTable tr').length;
                                var info = " <tr><td><select name='plantarea' id='plantarea" + rowCount + "'   class='plantarea' >";
                                $("#mailingarea option").each(function () {
                                    if ($(this).val() != 'new') {
                                        info = info + "<option value='" + $(this).val() + "' >" + $(this).text() + "</option>";
                                    }
                                });
                                info = info + "</select></td><td><select name='plantcity' id='plantcity" + rowCount + "'   class='plantcity' >";
                                $("#mailingarea option").each(function () {
                                    if ($(this).val() != 'new') {
                                        info = info + "<option value='" + $(this).val() + "' >" + $(this).text() + "</option>";
                                    }
                                });
                                info = info + "</select></td><td><select name='plantstate' id='plantstate" + rowCount + "' class='plantstate'   >";
                                $("#mailingstate option").each(function () {
                                    if ($(this).val() != 'new') {
                                        info = info + "<option value='" + $(this).val() + "' >" + $(this).text() + "</option>";
                                    }
                                });
                                info = info + "</select></td><td><select name='plantcountry' id='plantcountry" + rowCount + "'  class='plantcountry' >";
                                $("#mailingcountry option").each(function () {
                                    if ($(this).val() != 'new') {
                                        info = info + "<option value='" + $(this).val() + "' >" + $(this).text() + "</option>";
                                    }
                                });
                                info = info + "</select><img src='<%=request.getContextPath()%>/images/remove.gif'  class='deleteTr' id=''></img><input type='hidden' name='plantid' value='0'></td></tr>";
                                $("#plantTable").append(info);
                            });
                            $(document).on("click", ".deleteTr", function () {
                                var obj = $(this).parent().parent();
                                obj.remove();
                            });
                            function isNumber(evt) {
                                evt = (evt) ? evt : window.event;
                                var charCode = (evt.which) ? evt.which : evt.keyCode;
                                if (charCode > 31 && (charCode < 48 || charCode > 57)) {
                                    return false;
                                }
                                return true;
                            }

        </script>
    </body>
</html>

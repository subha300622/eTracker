<%@page import="com.eminentlabs.crm.persistence.CrmCompanyPlants"%>
<%@page import="com.eminentlabs.crm.persistence.CrmCompanySales"%>
<%@page import="com.eminentlabs.crm.persistence.CrmCompetitors"%>
<%@page import="com.eminentlabs.crm.persistence.ContactWorkHistory"%>
<%@page import="com.eminentlabs.crm.CRMUtil"%>
<%@ page language="java" contentType="text/html"
         pageEncoding="UTF-8"%>
<%@ page import="org.apache.log4j.*,java.text.*" %>
<%

    Logger logger = Logger.getLogger("MyCRM Lead Issue View");

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
          type=text/css rel=STYLESHEET>
    <title>eTracker&#0153; - Eminentlabs CRM,APM,ERM and PTS Solution</title>
    <script language=javascript	src="<%= request.getContextPath()%>/eminentech support files/datetimepicker.js"></script>
    <script language=javascript src="<%= request.getContextPath()%>/javaScript/checkSubmit.js"></script>
    <script type="text/javascript" src="<%= request.getContextPath()%>/ckeditor_4.5.9_standard/ckeditor/ckeditor.js"></script>
</head>
<SCRIPT language=JAVASCRIPT type="text/javascript">
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
    function moveLead()
    {
        if (document.theForm.movetoopportunity.checked == true) {
            if (confirm("Do you want to Move Opportunity"))
            {
                xmlhttp = createRequest();
                if (!xmlhttp && typeof XMLHttpRequest != 'undefined') {
                    xmlhttp = new XMLHttpRequest();
                }
                if (xmlhttp != null) {

                    var company = trim(theForm.company.value);
                    xmlhttp.open("GET", "<%=request.getContextPath()%>/admin/customer/opportunityCheck.jsp?name=" + company + "&rand=" + Math.random(1, 10), true);
                    xmlhttp.onreadystatechange = userAlert;
                    xmlhttp.send(null);
                }


            } else
            {
                document.theForm.movetoopportunity.checked = false;
            }
        }


    }
    function userAlert() {

        if (xmlhttp.readyState == 4) {
            if (xmlhttp.status == 200) {

                var module = xmlhttp.responseText.split(",");
                var flag = module[1];

                if (flag == 'yes') {

                    alert("Selected Lead name is already exist in Opportunity");
                    document.theForm.movetoopportunity.checked = false;
                    theForm.title.focus();
                } else {
                    theForm.movetoopportunity.checked = true;
                }


            }
        }
    }

    function isDate(str)
    {
        var pattern = "0123456789-"
        var i = 0;
        do
        {
            var pos = 0;
            for (var j = 0; j < pattern.length; j++)
                if (str.charAt(i) == pattern.charAt(j))
                {
                    pos = 1;
                    break;
                }
            i++;
        } while (pos == 1 && i < str.length)
        if (pos == 0)
            return false;
        return true;
    }
    function trim(str)
    {
        while (str.charAt(str.length - 1) == " ")
            str = str.substring(0, str.length - 1);
        while (str.charAt(0) == " ")
            str = str.substring(1, str.length);
        return str;
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
    function isNumber(str)
    {
        var pattern = "0123456789+- ."
        var i = 0;
        do
        {
            var pos = 0;
            for (var j = 0; j < pattern.length; j++)
                if (str.charAt(i) == pattern.charAt(j))
                {
                    pos = 1;
                    break;
                }
            i++;
        } while (pos == 1 && i < str.length)
        if (pos == 0)
            return false;
        return true;
    }
    function pk_fixnewlines_textarea(val) {
        // Adjust newlines so can do correct character counting for MySQL. MySQL counts a newline as 2 characters.
        if (val.indexOf('\r\n') != -1)
            val = val.replace(new RegExp("\\n", "g"), "\r\n"); // this is IE on windows. Puts both characters for a newline, just what MySQL does. No need to alter
        else if (val.indexOf('\r') != -1)
            val = val.replace(new RegExp("\\n", "g"), "\r\n");        // this is IE on a Mac. Need to add the line feed
        else if (val.indexOf('\n') != -1)
            val = val.replace(new RegExp("\\n", "g"), "\r\n");        // this is Firefox on any platform. Need to add carriage return
        else
            ;                                           // no newlines in the textarea
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
        var pattern = "abcdefghijklmnopqrstuvwxyz,.:-_ ABCDEFGHIJKLMNOPQRSTUVWXYZ";
        var i = 0;
        do
        {
            var pos = 0;
            for (var j = 0; j < pattern.length; j++)
                if (str.charAt(i) == pattern.charAt(j))
                {
                    pos = 1;
                    break;
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
        /** This Loop Checks Whether There Is Any Integer Present In The Project Name Field */
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
            document.theForm.phone.value = "";
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
        if (!isPositiveInteger(trim(theForm.email.value)))
        {
            alert('Please enter the AlphaNumerical only in the Email ');
            document.theForm.email.value = "";
            theForm.email.focus();
            return false;
        }
        if (!(/^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,4})+$/.test(theForm.email.value)))
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
            document.theForm.mobile.value = "";
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
            document.theForm.mobile.value = "";
            theForm.mobile.focus();
            return false;
        }
        if (document.getElementById('leadstatus').value == '--Select One--')
        {
            alert("Please choose a Lead Status");
            document.getElementById('leadstatus').focus();
            return false;
        }
        if (document.getElementById('assignedto').value == '--Select One--')
        {
            alert("Please choose a Assigned to Name");
            document.getElementById('assignedto').focus();
            return false;
        }
        if (document.getElementById('rating').value == '--Select One--')
        {
            alert("Please choose a Rating");
            document.getElementById('rating').focus();
            return false;
        }
        if (!isPositiveInteger(trim(theForm.website.value)) && trim(theForm.website.value) != '')
        {
            alert('Please enter the AlphaNumerical only in the website ');
            document.theForm.website.value = "";
            theForm.website.focus();
            return false;
        }
        if (trim(theForm.leadpotential.value) == '')
        {
            alert('Please enter Lead Potential ');
            document.theForm.leadpotential.value = "";
            theForm.leadpotential.focus();
            return false;
        }
        if (!isNumber(trim(theForm.leadpotential.value)))
        {
            alert('Please enter the Numerical only in the Lead Potential ');
            document.theForm.leadpotential.value = "";
            theForm.leadpotential.focus();
            return false;
        }
        if (trim(document.getElementById('duedate').value) == 'NA')
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

        if (form_date < today) {
            alert('Due Date cannot be less than Today');
            document.theForm.duedate.value = "";
            theForm.duedate.focus();
            return false;
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
        if (document.getElementById('product').value == '--Select One--')
        {
            alert("Please Select the Product ");
            document.theForm.product.focus();
            return false;
        }
//        if(trim(theForm.street.value) != ''){
//                if (!(/^[0-9a-zA-Z\_,/ ]+$/.test(theForm.street.value)) ) {
//            alert("Special characters are not allowed in street! Please re-enter.")
//            theForm.street.value = "";
//            theForm.street.focus();
//            return (false);
//        }
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


        if (!isPositiveInteger(trim(theForm.zip.value)) && trim(theForm.zip.value) != '')
        {
            alert('Please enter the AlphaNumerical only in the zip ');
            document.theForm.zip.value = "";
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


        if (!isPositiveInteger(trim(theForm.noofemployees.value)) && trim(theForm.noofemployees.value) != '')
        {
            alert('Please enter the Numerical only in the noofemployees ');
            document.theForm.noofemployees.value = "";
            theForm.noofemployees.focus();
            return false;
        }
        if (!isPositiveInteger(trim(theForm.annualrevenue.value)) && trim(theForm.annualrevenue.value) != '')
        {
            alert('Please enter the AlphaNumerical only in the annualrevenue ');
            document.theForm.annualrevenue.value = "";
            theForm.annualrevenue.focus();
            return false;
        }

        var count = 0;
        var leadType = $('#leadType :selected').val();
        if (leadType === 'Normal') {
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


                if (leadType === 'Decision Maker') {
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

        if (trim(CKEDITOR.instances.comments.getData()) == "")
        {
            alert("Please Enter the Comments");
            CKEDITOR.instances.comments.focus();
            return false;
        }
        if (CKEDITOR.instances.comments.getData().length > 4000)
        {
            alert(" Comments exceeds 4000 character");
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
    function setFocus() {
        document.theForm.title.focus();
    }
    window.onload = setFocus;


    function textCounter(field, cntfield, maxlimit)
    {
        if (field.value.length > maxlimit)
        {
            field.value = field.value.substring(0, maxlimit);
            alert('Comments size is exceeding 4000 characters');
        } else
            cntfield.value = maxlimit - field.value.length;
    }

    function call(theForm)
    {

        //		if(theForm.comments.value.length<=0) 
        //  		{
        //	   		alert('Enter your comments'); 
        //		    theForm.comments.focus(); 
        //		    return false;
        //    	}
        //	
        //		if(theForm.comments.value.length>4000) 
        //  		{
        //	    	alert('Comments Should not exceed 4000 Characters'); 
        //		    theForm.comments.focus(); 
        //		    return false;
        //	    }

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
</SCRIPT>
<body>
    <jsp:include page="/header.jsp" />
    <jsp:useBean id="Contact" class="com.eminent.customer.ContactRegistration"/>

    <BR>
    <!-- Table To Display The Formatted String "Add New User" -->
    <table cellpadding="0" cellspacing="0" width="100%">
        <tr border="2" bgcolor="#c3d9ff">
            <td border="1" align="left" width="100%"><font size="4"
                                                           COLOR="#0000FF"><b> Edit Lead</b></font> <FONT SIZE="3"
                                                               COLOR="#0000FF"> </FONT></td>
        </tr>
    </table>
    <BR>
    <FORM name="theForm" onsubmit="return fun(this)"	action="<%=request.getContextPath()%>/MyCRM/crmIssueUpdate.jsp"	method="post" onReset="return setFocus()">
        <%@ page import="java.sql.*,pack.eminent.encryption.*,com.eminent.util.*,java.util.*"%> <%
            int leadid = Integer.parseInt(request.getParameter("leadid"));
            Connection connection = null;
            Statement st = null;
            ResultSet rs = null;
            int assi = 0;
            String decisionMaker = "";
            try {

                //Getting admin details
                int adminUserId = 0;
                HashMap<String, String> hm = GetProjectMembers.getAdminDetail();
                if (hm != null) {
                    adminUserId = Integer.parseInt(hm.get("userid"));
                }
                List<ContactWorkHistory> cwhs = null;
                List<CrmCompetitors> competitorses = new ArrayList();
                List<CrmCompanySales> companySaleses = new ArrayList();
                Set<String> competitors = new TreeSet<String>();
                List<String> companies = CRMUtil.getCompany();
                List<String> allCity = CRMUtil.getAllCities();
                List<String> allStates = CRMUtil.getAllStates();
                List<String> allCountries = CRMUtil.getAllCountries();
                List<String> currencies = CRMUtil.currencyTypes();

                connection = MakeConnection.getConnection();
                if (connection != null) {
                    cwhs = CRMUtil.getLeadWorkHistory(connection, leadid);

                    st = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);

                    rs = st.executeQuery("Select COMPANY,FIRSTNAME,LASTNAME,TITLE,LEADSTATUS,PHONE,EMAIL,RATING,STREET,CITY,STATE,ZIP,COUNTRY,WEBSITE,NOOFEMPLOYEES,ANNUALREVENUE,LEADSOURCE,INDUSTRY,DESCRIPTION,MOBILE,LEADPOTENTIAL,INTERESTED,ASSIGNEDTO,DUEDATE,LEAD_OWNER,ROLEID,erp,vendor,MEETING_DATE,MEETING_TIME,area,LEAD_TYPE from lead where leadid=" + leadid);
                    if (rs != null) {
                        while (rs.next()) {
                            String company = rs.getString("COMPANY");
                            String firstname = rs.getString("FIRSTNAME");
                            String lastname = rs.getString("LASTNAME");
                            String title = rs.getString("TITLE");
                            String leadstatus = rs.getString("LEADSTATUS");
                            String phone = rs.getString("PHONE");
                            String email = rs.getString("EMAIL");
                            String website = rs.getString("WEBSITE");
                            String annualrevenue = rs.getString("ANNUALREVENUE");
                            String leadsource = rs.getString("LEADSOURCE");
                            int industryId = rs.getInt("INDUSTRY");
                            String noofemployees = rs.getString("NOOFEMPLOYEES");
                            String rating = rs.getString("RATING");
                            String description = rs.getString("DESCRIPTION");
                            String street = rs.getString("STREET");
                            String city = rs.getString("CITY");
                            String state = rs.getString("STATE");
                            String zip = rs.getString("ZIP");
                            String country = rs.getString("COUNTRY");
                            String mobile = rs.getString("MOBILE");
                            String leadpotential = rs.getString("LEADPOTENTIAL");
                            String product = rs.getString("INTERESTED");
                            String assignedto = rs.getString("ASSIGNEDTO");
                            String owner = rs.getString("LEAD_OWNER");
                            int roleid = rs.getInt("ROLEID");
                            String erp = rs.getString("erp");
                            String vendor = rs.getString("vendor");
                            String time = rs.getString("MEETING_TIME");
                            java.util.Date meetingDate = rs.getDate("MEETING_DATE");
                            java.util.Date due = rs.getDate("duedate");
                            String area = rs.getString("area");
                            String type = rs.getString("LEAD_TYPE");

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

                            if (company == null) {
                                company = "";
                            }
                            if (firstname == null) {
                                firstname = "";
                            }
                            if (lastname == null) {
                                lastname = "";
                            }
                            if (phone == null) {
                                phone = "";
                            }
                            if (email == null) {
                                email = "";
                            }
                            if (title == null) {
                                title = "";
                            }
                            if (website == null) {
                                website = "";
                            }
                            if (leadsource == null) {
                                leadsource = "";
                            }
                            if (leadstatus == null) {
                                leadstatus = "";
                            }

                            if (rating == null) {
                                rating = "";
                            }
                            if (noofemployees == null) {
                                noofemployees = "";
                            }
                            if (annualrevenue == null) {
                                annualrevenue = "";
                            }
                            if (description == null) {
                                description = "";
                            }
                            if (street == null) {
                                street = "";
                            }
                            if (city == null) {
                                city = "";
                            }
                            if (state == null) {
                                state = "";
                            }
                            if (zip == null) {
                                zip = "";
                            }
                            if (country == null) {
                                country = "";
                            }
                            if (mobile == null) {
                                mobile = "";
                            }
                            if (leadpotential == null) {
                                leadpotential = "";
                            }
                            if (product == null) {
                                product = "NA";
                            }

                            if (assignedto != null) {
                                assi = Integer.parseInt(assignedto);
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

                            if (area == null) {
                                area = "";
                            }

                            decisionMaker = CRMUtil.getDecisionMakerLead(connection, company);
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
                            competitors = CRMUtil.getCompetitorByIndustry(connection, company, industryId);


        %>

        <table width="100%" bgColor=#E8EEF7 border="0" align="center">
            <TBODY>
                <tr bgcolor="C3D9FF">
                    <td><strong>Lead Information</strong></td>
                    <td align="right"><strong><font size="10"
                                                    COLOR="#FF0000">*</font> = Required Information</strong></td>
                </tr>
            </tbody>
        </table>
        <table width="100%" bgColor=#E8EEF7 border="0" align="center">
            <TBODY>
                <tr>
                    <td width="10%"><strong>Title<font size="10" COLOR="#FF0000">*</font></strong></td>
                    <td width="21%"><input type="text" name="title" maxlength="30" size=14 value="<%=title%>"><strong class="style20"></strong></td>
                    <td width="10%"><strong>First Name<font size="10" COLOR="#FF0000">*</font></strong></td>
                    <td width="25%"><input type="text" name="firstname" maxlength="30" size=25 value="<%=firstname%>"><strong class="style20"></strong></td>
                    <td width="12%"><strong>Last Name <font size="10" COLOR="#FF0000">*</font></strong></td>
                    <td width="23%"><input type="text" name="lastname" maxlength="30" size=20 value="<%=lastname%>"><strong class="style20"></strong></td>
                </tr>
                <tr>

                    <td width="10%"><strong>Phone<font size="10" COLOR="#FF0000">*</font></strong></td>
                    <td width="21%"><input type="text" name="phone" maxlength="15" size=14 value="<%=phone%>"><strong class="style20"></strong></td>
                    <td width="10%"><strong>Email<font size="10" COLOR="#FF0000">*</font></strong></td>
                    <td width="25%"><input type="text" name="email" maxlength="60" size=25 value="<%=email%>"><strong class="style20"></strong></td>
                    <td width="12%"><strong>Company<font size="10" COLOR="#FF0000">*</font></strong></td>
                    <td width="23%"><input type="text" name="company" maxlength="30" size=20 value="<%=company%>"><strong class="style20"></strong></td>
                </tr>
                <tr>
                    <td width="10%"><strong>Mobile<font size="10" COLOR="#FF0000">*</font></strong></td>
                    <td width="21%"><input type="text" name="mobile" maxlength="15" size=14 value="<%=mobile%>"><strong class="style20"></strong></td>
                    <td width="10%"><strong>Lead Status<font size="10" COLOR="#FF0000">*</font></strong></td>
                    <td align="left" width="25%">
                        <SELECT NAME="leadstatus" id="leadstatus" size="1">
                            <%
                                String[] leadstatusExist = {"--Select One--", "Open", "leaded", "Qualified", "UnQualified"};
                                for (int i = 0; i < leadstatusExist.length; i++) {
                                    if (leadstatus.equalsIgnoreCase(leadstatusExist[i])) {
                            %>
                            <option value="<%= leadstatus%>" selected><%= leadstatus%></option>
                            <%
                            } else {
                            %>
                            <option value="<%= leadstatusExist[i]%>"><%= leadstatusExist[i]%></option>
                            <%
                                    }
                                }
                            %>
                        </SELECT>
                    </td>
                    <td width="12%"><strong>Assigned To <font size="10" COLOR="#FF0000">*</font></strong></td>
                    <td width="23%"><select name="assignedto" id="assignedto" size="1">
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
                        </select>
                    </td>
                </tr>



                <tr>
                    <td width="10%"><strong>Rating</strong></td>
                    <td><SELECT NAME="rating" id="rating" size="1">

                            <%
                                String[] ratingExist = {"--Select One--", "Hot", "Warm", "Cold"};
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
                    <td width="10%"><strong>Web Site</strong></td>
                    <td><input type="text" name="website" maxlength="60" size=25 value="<%=website%>"><strong
                            class="style20"></strong></td>
                    <td width="10%"><strong>Lead Potential<font size="10"	COLOR="#FF0000">*</font></strong></td>
                    <td><input type="text" name="leadpotential" maxlength="30" size=20 value="<%=leadpotential%>"><strong class="style20"></strong></td>

                </tr>
                <tr>
                    <td width="10%"><strong>Due Date<font size="10"	COLOR="#FF0000">*</font></strong></td>
                    <td width="21%"><input type="text" name="duedate" id="duedate" value="<%=dueDate%>" maxlength="10" size="12" readonly /><a href="javascript:NewCal('duedate','ddmmyyyy')"> <img src="<%=request.getContextPath()%>/images/newhelp.gif" 	border="0" width="16" height="16" alt="Pick a date"></a></td>
                    <td width="10%"><strong>Interested In<font size="10" COLOR="#FF0000">*</font></strong></td>
                    <td width="25%">
                        <select name="product" id="product" size="1">
                            <%
                                String prod = "NA";
                                if (product != null) {
                                    prod = product;
                                }
                                String[] products = {"--Select One--", "eTracker", "eOutSource", "ERPDS"};
                                for (int i = 0; i < products.length; i++) {
                                    if (prod.equalsIgnoreCase(products[i])) {
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
                    <td width="10%"><strong>Lead Owner</strong></td>
                    <td><input type="text" name="leadowner" maxlength="30" size=25
                               value="<%=GetProjectManager.getUserName(Integer.parseInt(owner))%>"
                               readonly="readonly"><strong class="style20"></strong></td>
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
                            <%}%>
                        </select>
                    </td>
                    <td width="10%"><strong>Vendor<font size="10" COLOR="#FF0000">*</font></strong></td>
                    <td width="25%">
                        <select name="vendor" id="vendor" onchange="javascript:showNewVendor();">
                            <option value="" disabled selected>Select</option>
                            <%for (String ven : CRMUtil.getVendors("lead")) {
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
                    <td width="10%"><strong>Type<font size="10" COLOR="#FF0000">*</font></strong></td>
                    <td width="25%">
                        <input type="hidden" id="decisionId" value="<%=decisionMaker%>"/>
                        <select name="leadType" id="leadType" size="1">
                            <%for (String leadType : Contact.contactType()) {%>
                            <option value="<%=leadType%>"
                                    <%if (leadType.equalsIgnoreCase(type)) {%>
                                    selected
                                    <%}%>
                                    ><%=leadType%></option>
                            <% }%>
                        </select>
                        <%if (!decisionMaker.equals("")) {%>
                        <span id="showDecision" style="display: none;">
                            Decision maker = <A HREF="<%=request.getContextPath()%>/MyCRM/crmIssueView.jsp?leadid=<%=decisionMaker.split("-")[0]%>"><font
                                    face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%=decisionMaker.split("-")[1]%> </font></A>
                        </span>
                        <%}%>
                    </td>
                </tr>
                <tr class="emlpoyeement" style="display: none;"><td width="100%" bgcolor="white" colspan=6 height="10"></td></tr>
                <tr class="emlpoyeement" bgcolor="C3D9FF" style="display: none;">
                    <td colspan=7><strong >Employment History</strong></td>
                </tr>

                <tr class="emlpoyeement" style="display: none;"><td colspan=7>
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

                <tr class="decisionMakerTab" style="display: none;"><td colspan=7>
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
                                        <%for (String ccity : allCity) {
                                        %>                                          
                                        <option ><%=ccity%></option>
                                        <%}%>
                                        <option value="new">New</option>
                                    </select>                        
                                    <input type="text" name="newcompetitorcity" id="newcompetitorcity<%=i%>" maxlength="30" size=25
                                           style="display: none;"    ><strong class="style20"></strong>
                                </td>
                                <td >
                                    <select name="competitorstate" id="competitorstate<%=i%>" class="competitorstate">
                                        <option value=""  selected>Select</option>
                                        <%for (String cstate : allStates) {
                                        %>
                                        <option ><%=cstate%></option>
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

                                        <%for (String ccountry : allCountries) {
                                        %>
                                        <option ><%=ccountry%></option>
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
                                        <%for (String ccity : allCity) {
                                        %>                                          
                                        <option <%if (cc.getCity().equalsIgnoreCase(ccity)) {%>
                                            selected
                                            <%}%>><%=ccity%></option>
                                        <%}%>
                                        <option value="new">New</option>
                                    </select>                        
                                    <input type="text" name="newcompetitorcity" id="newcompetitorcity<%=i%>" maxlength="30" size=25
                                           style="display: none;"    ><strong class="style20"></strong>
                                </td>
                                <td >
                                    <select name="competitorstate" id="competitorstate<%=i%>" class="competitorstate">
                                        <option value=""  selected>Select</option>
                                        <%for (String cstate : allStates) {
                                        %>
                                        <option <%if (cc.getState().equalsIgnoreCase(cstate)) {%>
                                            selected
                                            <%}%>><%=cstate%></option>
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

                                        <%for (String ccountry : allCountries) {
                                        %>
                                        <option <%if (cc.getCountry().equalsIgnoreCase(ccountry)) {%>
                                            selected
                                            <%}%>><%=ccountry%></option>
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
                                        <%for (String ccity : allCity) {
                                        %>                                          
                                        <option ><%=ccity%></option>
                                        <%}%>
                                        <option value="new">New</option>
                                    </select>                        
                                    <input type="text" name="newcompetitorcity" id="newcompetitorcity<%=i%>" maxlength="30" size=25
                                           style="display: none;"    ><strong class="style20"></strong>
                                </td>
                                <td >
                                    <select name="competitorstate" id="competitorstate<%=i%>" class="competitorstate">
                                        <option value=""  selected>Select</option>
                                        <%for (String cstate : allStates) {
                                        %>
                                        <option ><%=cstate%></option>
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

                                        <%for (String ccountry : allCountries) {
                                        %>
                                        <option ><%=ccountry%></option>
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

                <tr class="decisionMakerTab" style="display: none;"><td colspan=7>
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
                                        <%for (String curr : currencies) {%>
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
                    <td colspan=4><strong>Address Information</strong></td>
                    <td><input type="hidden" name="owner" value="<%=owner%>"></td>
                    <td><input type="hidden" name="leadid" value="<%=leadid%>"></td>
                </tr>



                <tr>
                    <td width="10%"><strong>Street</strong></td>
                    <td width="21%"><textarea name="street" wrap="physical" cols="13" rows="2"><%=street%></textarea></td>

                    <td width="10%"><strong>Area/Location</strong></td>
                    <td width="21%"> <select name="mailingarea" id="mailingarea" onchange="javascript:showNewArea();">
                            <option value="" disabled selected>Select</option>
                            <%for (String areaa : CRMUtil.getArea("lead")) {
                                    if (area.equals(areaa)) {
                            %>
                            <option selected><%=areaa%></option>
                            <% } else {%>
                            <option ><%=areaa%></option>
                            <% }
                                }%>
                            <option value="new">New</option>
                        </select>
                        <input type="text" name="newMailingarea" id="newMailingarea" maxlength="50" size=25
                               style="display: none;"  ><strong class="style20"></strong></td>

                    <td width="10%"><strong>City</strong></td>
                    <td width="25%"><select name="mailingcity" id="mailingcity" onchange="javascript:showNewCity();">
                            <option value="" disabled selected>Select</option>
                            <%for (String cty : CRMUtil.getCity("lead")) {
                                    if (city.equals(cty)) {
                            %>
                            <option selected><%=cty%></option>
                            <% } else {%>
                            <option ><%=cty%></option>
                            <% }
                                }%>
                            <option value="new">New</option>
                        </select>                        
                        <input type="text" name="newMailingcity" id="newMailingcity" maxlength="30" size=25
                               style="display: none;"    ><strong class="style20"></strong></td>


                </tr>
                <tr>
                    <td width="12%"><strong>State</strong></td>
                    <td width="23%">  <select name="mailingstate" id="mailingstate" onchange="javascript:showNewState();">
                            <option value="" disabled selected>Select</option>
                            <%for (String sta : CRMUtil.getState("lead")) {
                                    if (state.equals(sta)) {
                            %>
                            <option selected><%=sta%></option>
                            <% } else {%>
                            <option ><%=sta%></option>
                            <% }
                                }%>
                            <option value="new">New</option>
                        </select>

                        <input type="text" name="newMailingstate" id="newMailingstate" maxlength="30"
                               style="display: none;"  size=20 ><strong class="style20"></strong></td>
                    <td width="10%"><strong>Zip</strong></td>
                    <td width="21%"><input type="text" name="zip" maxlength="30" size=14 value="<%=zip%>"><strong
                            class="style20"></strong></td>

                    <td width="10%"><strong>Country</strong></td>
                    <td width="25%"><select name="mailingcountry" id="mailingcountry" onchange="javascript:showNewCountry();">
                            <option value="" disabled selected>Select</option>
                            <%for (String ctry : CRMUtil.getCountry("lead")) {
                                    if (country.equals(ctry)) {
                            %>
                            <option selected><%=ctry%></option>
                            <% } else {%>
                            <option ><%=ctry%></option>
                            <% }
                                }%>
                            <option value="new">New</option>
                        </select>
                        <input type="text" name="newMailingcountry" id="newMailingcountry" maxlength="30"
                               style="display: none;"     size=25 ><strong class="style20"></strong>
                    </td>


                </tr>
                <tr><td width="100%" bgcolor="white" colspan=6 height="10"></td></tr>


                <tr bgcolor="C3D9FF">
                    <td colspan=6><strong>Additional Information</strong></td>
                </tr>


                <tr>
                    <td width="10%" ><strong>Annual Revenue</strong></td>
                    <%

                        String[] annualrevenueExist = {"--Select One--", "$200K - $1 Million", "$1 million - $10 million", "$10 million - $100 million", "$100 million - $1 billion", "Above $1 billion"};
                    %>
                    <td ><SELECT NAME="annualrevenue" size="1">
                            <%
                                for (int i = 0; i < annualrevenueExist.length; i++) {
                                    if (annualrevenue.equals(annualrevenueExist[i])) {
                            %>
                            <option value="<%= annualrevenue%>" selected><%= annualrevenue%></option>
                            <%
                            } else {
                            %>
                            <option value="<%= annualrevenueExist[i]%>"><%= annualrevenueExist[i]%></option>
                            <%
                                    }
                                }
                            %>
                        </SELECT><strong class="style20"></strong></td>

                    <td width="10%"><strong>No of employees</strong></td>
                    <%
                        String[] noofEmployees = {"--Select One--", "0 - 50 employees", "51 - 200 employees", "200 - 500 employees", "500 - 2000 employees", "2000 + employees"};
                    %>

                    <td ><SELECT NAME="noofemployees" size="1">
                            <%
                                for (int i = 0; i < noofEmployees.length; i++) {
                                    if (noofemployees.equals(noofEmployees[i])) {
                            %>
                            <option value="<%= noofemployees%>" selected><%= noofemployees%></option>
                            <%
                            } else {
                            %>
                            <option value="<%= noofEmployees[i]%>"><%= noofEmployees[i]%></option>
                            <%
                                    }
                                }
                            %>
                        </SELECT></td>

                    <%
                        int pmanager = Integer.parseInt(GetProjectManager.getManager("CRM", "1.0"));
                        if (rating.equalsIgnoreCase("Hot") && roleid == 2/**
                                 * &&(pmanager==assi||assi==adminUserId)
                                 */
                                ) {%>
                    <td ><strong>Move to Opportunity</strong></td>
                    <td ><input type="checkbox" name="movetoopportunity"	size=20  value="<%=leadid%>" onclick="moveLead()"><strong class="style20"></strong></td>
                        <%} %>
                </tr>
                <tr>

                    <td width="10%"><strong>Industry</strong></td>
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

                    <td width="10%"><strong>Lead Source</strong></td>
                    <%
                        String[] leadsourceExist = {"--None--", "Advertisement", "Employee Referrel", "External Referrel", "partner", "public relataion", "seminar-internal", "Trade Show", "web", "Word of mouth", "others"};
                    %>
                    <td align="left" width="35%"><SELECT NAME="leadsource" size="1">
                            <%
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
                        </SELECT></td>
                </tr>

                <tr><td width="100%" bgcolor="white" colspan=6 height="10"></td></tr>
                <tr bgcolor="C3D9FF">
                    <td colspan=6><strong>Descriptive Information</strong></td>
                </tr>

                <tr>
                    <td width="10%" colspan=6><strong>Description</strong></td>
                </tr>
                <tr colspan=6>
                    <td ><%=description%></td>
                </tr>

                <tr height="21">
                    <td width="10%" class="textdisplay" align="left">
                        <p class="textdisplay"><b>Comments</b></p>
                    </td>
                </tr>
                <tr height="21">
                    <td width="10%"><strong></strong></td>
                    <td width="90%" align="left" colspan=5><font size="2"
                                                                 face="Verdana, Arial, Helvetica, sans-serif"> <textarea
                                rows="3" cols="68" name="comments" maxlength="4000"
                                onKeyDown="textCounter(document.theForm.comments, document.theForm.remLen1, 4000)"
                                onKeyUp="textCounter(document.theForm.comments, document.theForm.remLen1, 4000)"></textarea></font>
                        <input readonly type="text" name="remLen1" id="remLen1" size="3" maxlength="3" value="4000">characters left</td>
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
                        editorTextCounter(leng, document.getElementById('remLen1'), 2000);

                    }, 0);
                }
            </script>
            </tr>
            <tr align="center">
                <td></td><td></td><td></td>
                <td  align="center">                       
                    <INPUT type=submit onclick="this.form.submited = this.value;" value=Update name=submit>
                    <INPUT type=submit onclick="this.form.submited = this.value;"  value=Draft  name=submit>
                    <INPUT type=reset value=Reset id=reset name=reset>
                </td>
                <td></td>
                <td></td>
            </tr>
        </table>
        <%
            session.setAttribute("name", firstname);
            session.setAttribute("category", "lead");

        %> <iframe src="./commentHistory.jsp?leadId=<%= leadid%>"
                scrolling="auto" frameborder="2" height="45%" width="100%"></iframe> <br>
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
            if (st != null) {
                st.close();
            }
            if (rs != null) {
                rs.close();
            }
            if (connection != null) {
                connection.close();
                logger.info("connection closed");
            }
            if (connection.isClosed()) {
                logger.info("Connection is Closed");
            } else {
                logger.info("Connection not Closed");
            }

        }
    %>
    <BR>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
    <script>

                        jQuery(document).ready(function () {
                            var leadType = $('#leadType :selected').val();
                            if (leadType === 'Normal') {
                                $(".emlpoyeement").hide();
                                $(".decisionMakerTab").hide();
                            } else if (leadType === 'Influencer') {
                                $(".emlpoyeement").show();
                                $(".decisionMakerTab").hide();
                            } else if (leadType === 'Decision Maker') {
                                $(".emlpoyeement").show();
                                $(".decisionMakerTab").show();
                                $("#leadType option[value='Normal']").remove();
                            }


                        });
                        $("#leadType").on('change', function () {
                            $("#showDecision").hide();
                            var leadType = $(this).val();
                            if (leadType === 'Normal') {
                                $(".emlpoyeement").hide();
                                $(".decisionMakerTab").hide();
                            } else if (leadType === 'Influencer') {
                                $(".emlpoyeement").show();
                                $(".decisionMakerTab").hide();
                            } else if (leadType === 'Decision Maker') {
                                var decisionId = $('#decisionId').val();
                                var contactId = $('#leadid').val();
                                if (decisionId === '') {
                                    $(".emlpoyeement").show();
                                    $(".decisionMakerTab").show();
                                } else if (decisionId.split("-")[0] !== contactId) {
                                    $("#leadType").val("Influencer");
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

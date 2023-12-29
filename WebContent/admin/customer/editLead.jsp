<%@page import="com.eminentlabs.crm.CRMUtil"%>
<%@page import="com.eminentlabs.crm.persistence.CrmCompanySales"%>
<%@page import="com.eminentlabs.crm.persistence.CrmCompetitors"%>
<%@page import="com.eminentlabs.crm.persistence.ContactWorkHistory"%>
<%@page import="com.eminentlabs.crm.dto.MailCampaignDetails"%>
<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="org.apache.log4j.*,java.text.*" %>
<%

    Logger logger = Logger.getLogger("Add New Contact");

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
          type="text/css" rel=STYLESHEET>
    <script language=javascript	src="<%= request.getContextPath()%>/eminentech support files/simpleUtilities.js"></script>
    <title>eTracker&#0153; - Eminentlabs CRM,APM,ERM and PTS Solution</title>
    <script language=javascript	src="<%= request.getContextPath()%>/eminentech support files/datetimepicker.js"></script>
    <script language=javascript src="<%= request.getContextPath()%>/javaScript/checkSubmit.js"></script>
    <script src="<%= request.getContextPath()%>/javaScript/jquery.js" type="text/javascript" />
    <script src="<%= request.getContextPath()%>/javaScript/jquery-1.10.2.js"></script>
</head>
<script>
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
                    xmlhttp.open("GET", "opportunityCheck.jsp?name=" + company + "&rand=" + Math.random(1, 10), true);
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

                    alert("Selected Lead Name Already Exists in CRM Opprotunity");
                    document.theForm.movetoopportunity.checked = false;
                    theForm.title.focus();
                } else {
                    theForm.movetoopportunity.checked = true;
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

    function isPositiveInteger(str)
    {
        var pattern = "/\r?\n|\r/abcdefghijklmnopqrstuvwxyz,.?:;[]{}!@#$&*()-_+/ ABCDEFGHIJKLMNOPQRSTUVWXYZ-1234567890"
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
    function isPositiveInteger1(str)
    {
        var pattern = "abcdefghijklmnopqrstuvwxyz,.:-_ ABCDEFGHIJKLMNOPQRSTUVWXYZ"
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
        if (trim(document.theForm.duedate.value) == "")
        {
            alert("Please Enter the Due Date ");
            document.theForm.duedate.focus();
            return false;
        }
        if (trim(document.theForm.duedate.value) == "NA")
        {
            alert("Please Enter the Due Date ");
            document.theForm.duedate.focus();
            return false;
        }
        if (!isDate(trim(theForm.duedate.value)))
        {
            alert('Please enter the valid Due Date');
            document.theForm.duedate.value = "";
            theForm.duedate.focus();
            return false;
        }
        var str = document.theForm.duedate.value;
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
        if (trim(document.getElementById('erp').value) == "")
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
        if (document.getElementById('product').value == '--Select One--')
        {
            alert("Please Select the Product ");
            document.theForm.product.focus();
            return false;
        }

        if (!isPositiveInteger(trim(theForm.street.value)) && trim(theForm.street.value) != '')
        {
            alert('Please enter valid data in the street');
            document.theForm.street.value = "";
            theForm.street.focus();
            return false;
        }
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

        if (theForm.comments.value.length <= 0)
        {
            alert('Enter your comments');
            theForm.comments.focus();
            return false;
        }

        if (theForm.comments.value.length > 4000)
        {
            alert('Comments Should not exceed 4000 Characters');
            theForm.comments.focus();
            return false;
        }
        monitorSubmit();
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

        if (theForm.comments.value.length <= 0)
        {
            alert('Enter your comments');
            theForm.comments.focus();
            return false;
        }

        if (theForm.comments.value.length > 4000)
        {
            alert('Comments Should not exceed 4000 Characters');
            theForm.comments.focus();
            return false;
        }
        monitorSubmit();
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
</script>
<body>
    <jsp:include page="/header.jsp" />
    <jsp:useBean id="Contact" class="com.eminent.customer.ContactRegistration"/>
    <jsp:useBean id="mcc" class="com.eminentlabs.crm.controller.MailCampaignController" />

    <BR>
    <!-- Table To Display The Formatted String "Add New User" -->
    <table cellpadding="0" cellspacing="0" width="100%">
        <tr border="2" bgcolor="#c3d9ff">
            <td border="1" align="left" width="100%"><font size="4"
                                                           COLOR="#0000FF"><b> Edit Lead</b></font> <FONT SIZE="3"
                                                               COLOR="#0000FF"> </FONT></td>
            <td  align="center" ><font size="5" COLOR="#0000FF"><b><a href="#" id="mailcampaign"> MailCampaign details</a> </b></font> <FONT SIZE="3"
                                                                                                                                                 COLOR="#0000FF"> </FONT></td>
        </tr>
    </table>
    <BR>
    <FORM name="theForm" onsubmit="return fun(this)"	action="<%=request.getContextPath()%>/admin/customer/updatelead.jsp"	method="post" onReset="return setFocus()">
        <%@ page import="java.sql.*,pack.eminent.encryption.*,com.eminent.util.*,java.util.*"%> <%
            int leadid = Integer.parseInt(request.getParameter("leadid"));
            Connection connection = null;
            Statement st = null;
            ResultSet rs = null;
            int assi = 0;
            try {
                connection = MakeConnection.getConnection();
                List<ContactWorkHistory> cwhs = null;
                List<CrmCompetitors> competitorses = new ArrayList();
                List<CrmCompanySales> companySaleses = new ArrayList();
                if (connection != null) {
                    cwhs = CRMUtil.getLeadWorkHistory(connection, leadid);
                    st = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);

                    rs = st.executeQuery("Select COMPANY,FIRSTNAME,LASTNAME,TITLE,LEADSTATUS,PHONE,EMAIL,RATING,STREET,CITY,STATE,ZIP,COUNTRY,WEBSITE,NOOFEMPLOYEES,ANNUALREVENUE,LEADSOURCE,INDUSTRY,DESCRIPTION,MOBILE,LEADPOTENTIAL,INTERESTED,ASSIGNEDTO,DUEDATE,LEAD_OWNER,ROLEID,erp,vendor,area,LEAD_TYPE from lead where leadid=" + leadid);
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
                            String erp = rs.getString("erp");
                            String vendor = rs.getString("vendor");
                            String area = rs.getString("area");
                            int roleid = rs.getInt("ROLEID");
                            String type = rs.getString("LEAD_TYPE");
                            java.util.Date due = rs.getDate("duedate");
                            SimpleDateFormat dfm = new SimpleDateFormat("d-M-yyyy");
                            String dueDate = "NA";
                            if (due != null) {
                                dueDate = dfm.format(due);
                            }

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
                            if (erp == null) {
                                erp = "";
                            }
                            if (vendor == null) {
                                vendor = "";
                            }
                            if (assignedto != null) {
                                assi = Integer.parseInt(assignedto);
                            }
                            if (area == null) {
                                area = "";
                            }

                            if (type.equalsIgnoreCase("Decision Maker")) {
                                competitorses = CRMUtil.getCompetitors(connection, company);
                                companySaleses = CRMUtil.getCompanySales(connection, company);
                            }
        %>

        <TABLE width="100%"  bgcolor="C3D9FF" border="0" align="center">
            <TBODY>
                <tr>
                    <td><strong>Lead Information</strong></td>
                    <td align="right"><strong><font size="10"
                                                    COLOR="#FF0000">*</font> = Required Information</strong></td>
                </tr>
            </tbody>
        </table>
        <TABLE width="100%" bgColor=#E8EEF7 border="0" align="center">
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
                                String[] leadstatusExist = {"--Select One--", "Open", "Contacted", "Qualified", "UnQualified"};
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
                    <td width="10%"><strong>Interested In<font size="10" COLOR="#FF0000">*</font></td>
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
                    <td width="10%"><strong>Type<font size="10" COLOR="#FF0000">*</font></strong></td>
                    <td width="25%">
                        <select name="leadType" id="leadType" size="1">
                            <option><%=type%></option>
                        </select>                        
                    </td>

                </tr>


                <%if (!cwhs.isEmpty()) {%>
                <tr class="emlpoyeement" ><td width="100%" bgcolor="white" colspan=6 height="10"></td></tr>
                <tr class="emlpoyeement" bgcolor="C3D9FF" >
                    <td colspan=7><strong >Employment History</strong></td>
                </tr>
                <tr class="emlpoyeement" ><td colspan=7>
                        <table width="80%">
                            <tr>
                                <th ><strong style="color: #000000">Company<font size="10" COLOR="#FF0000">*</font></strong></th>
                                <th ><strong style="color: #000000">From<font size="10" COLOR="#FF0000">*</font></strong></th>
                                <th ><strong style="color: #000000">To<font size="10" COLOR="#FF0000">*</font></strong></th>
                                <th ><strong style="color: #000000">Role<font size="10" COLOR="#FF0000">*</font></strong></th>
                            </tr>
                            <%for (ContactWorkHistory cwh : cwhs) {%>
                            <tr >
                                <td><%=cwh.getCompany()%></td>
                                <td><%=cwh.getFromYear()%></td>
                                <td><%=cwh.getToYear()%></td>
                                <td ><%=cwh.getRole()%></td>
                            </tr>                              
                            <%}%>
                        </table>
                        <%}%>
                        <% if (!competitorses.isEmpty()) {%>
                <tr class="decisionMakerTab" ><td width="100%" bgcolor="white" colspan=6 height="10"></td></tr>
                <tr class="decisionMakerTab" bgcolor="C3D9FF" >
                    <td colspan=7><strong >Competitor Details</strong></td>
                </tr>
                <tr class="decisionMakerTab" ><td colspan=7>
                        <table width="80%">
                            <tr>
                                <th ><strong style="color: #000000">Competitor<font size="10" COLOR="#FF0000">*</font></strong></th>
                                <th ><strong style="color: #000000">City<font size="10" COLOR="#FF0000">*</font></strong></th>
                                <th ><strong style="color: #000000">State<font size="10" COLOR="#FF0000">*</font></strong></th>
                                <th ><strong style="color: #000000">Country<font size="10" COLOR="#FF0000">*</font></strong></th>
                            </tr>
                            <%  for (CrmCompetitors cc : competitorses) {%>
                            <tr>
                                <td><%=cc.getCompetitor()%></td>
                                <td><%=cc.getCity()%></td>
                                <td><%=cc.getState()%></td>
                                <td ><%=cc.getCountry()%></td>
                            </tr>
                            <%}%>
                        </table>
                        <%}%>


                        <%if (!companySaleses.isEmpty()) {%>
                <tr class="decisionMakerTab" ><td width="100%" bgcolor="white" colspan=6 height="10"></td></tr>
                <tr class="decisionMakerTab" bgcolor="C3D9FF" >
                    <td colspan=7><strong >Company Details</strong></td>
                </tr>
                <tr class="decisionMakerTab" ><td colspan=7>
                        <table width="80%">
                            <tr>
                                <th ><strong style="color: #000000">Year<font size="10" COLOR="#FF0000">*</font></strong></th>
                                <th ><strong style="color: #000000">Sales#<font size="10" COLOR="#FF0000">*</font></strong></th>
                                <th ><strong style="color: #000000">Employees#<font size="10" COLOR="#FF0000">*</font></strong></th>
                                <th ><strong style="color: #000000">IT Spend<font size="10" COLOR="#FF0000">*</font></strong></th>
                                <th ><strong style="color: #000000">ERP/SAP Spend<font size="10" COLOR="#FF0000">*</font></strong></th>
                            </tr>
                            <%  for (CrmCompanySales ccs : companySaleses) {%>
                            <tr>
                                <td><%=ccs.getSalesYear()%></td>
                                <td><%=ccs.getSales()%></td>
                                <td><%=ccs.getEmployees()%></td>
                                <td><%=ccs.getItSpend()%></td>
                                <td><%=ccs.getErpSpend()%></td>
                            </tr>
                            <%}%>
                        </table>
                        <%}%>


                <tr><td width="100%" bgcolor="white" colspan=6 height="10"></td></tr>
                <tr bgcolor="C3D9FF">
                    <td colspan=6  bgcolor="C3D9FF"><strong>Address Information</strong>
                        <input type="hidden" name="leadid" value="<%=leadid%>">
                        <input type="hidden" name="owner" value="<%=owner%>"></td>
                </tr>



                <tr>
                    <td width="10%"><strong>Street</strong></td>
                    <td width="21%"><textarea name="street" wrap="physical" cols="13" rows="2"><%=street%></textarea></td>

                    <td width="10%"><strong>Area\Location</strong></td>
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
                        <% if (rating.equalsIgnoreCase("Hot") && roleid == 2) {%>
                    <td width="12%"><strong>Move to Opportunity</strong></td>
                    <td width="23%"><input type="checkbox" name="movetoopportunity"	size="20" value="<%=leadid%>" onclick="moveLead();"><strong class="style20"></strong></td>
                        <%}%>
                </tr>
                <tr>

                    <td width="10%"><strong>Industry</strong></td>
                      <td width="25%">
                       <select name="industry" id="industry" onchange="javascript:showNew();">
                                <option value=""  selected>Select</option>
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
                    <%                            String[] leadsourceExist = {"--None--", "Advertisement", "Employee Referrel", "External Referrel", "partner", "public relataion", "seminar-internal", "Trade Show", "web", "Word of mouth", "others"};
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
                        <input readonly type="text" name="remLen1" size="3"
                               maxlength="3" value="4000">characters left</td>
                </tr>
                <tr align="center">
                    <td></td><td></td><td></td>
                    <TD  align="center"><INPUT type="submit" value=Update
                                               name="submit" id="submit">
                        <INPUT type="reset" value="Reset"	name="reset" id="reset"></TD>
                    </td>
                    <td></td>
                    <td></td>
                </tr>
        </table>
        <%
            session.setAttribute("name", firstname);
            session.setAttribute("category", "lead");

        %> <iframe src="./comments.jsp?leadId=<%= leadid%>"
                scrolling="auto" frameborder="2" height="45%" width="100%"></iframe> <br>
        <br>
        <br>


    </FORM>

    <%
                    }
                }
            }
        } catch (Exception ex) {
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
    <div id="overlay"> </div>
    <div id="viewMailCampaignpopup" class="popup"> 
        <h3 class="popupHeading">MaiCampaign Details</h3>
        <br/>

        <br/>
        <div class="clear"></div>
        <div class="tableshow">
            <div  style="width: 100%;" class="mid" id="MDAVpopupFiles">
                <table id="contactTable" style="width: 100%;">
                    <tr  style="background-color:#C3D9FE;font-weight: bold;height:21px;">
                        <td style="width: 5%">S.No</td>
                        <td style="width: 40%;">Subject</td>
                        <td style="width: 10%;">Mail Date</td>
                        <td style="width: 15%;">Sent By</td>
                    </tr>
                    <%List<MailCampaignDetails> mcclist = new ArrayList<MailCampaignDetails>();
                        int j = 0;
                        mcclist = mcc.allDetails(leadid, "Lead");
                        if (mcclist.size() > 0) {
                            for (MailCampaignDetails mc : mcclist) {
                                j++;
                                if (j % 2 == 0) {%>
                    <tr style="height:21px;" bgcolor="#E8EEF7">
                        <%} else {%>
                    <tr style="height:21px;" ><%}%>

                        <td width="5%"><%=j%></td>
                        <td width="40%"><%=mc.getSubject()%></td>
                        <td width="10%"><%=mc.getMaildate()%></td>
                        <td width="15%"><%=mc.getSentby()%></td>
                    </tr>

                    <%  }
                        }%>

                    <td></td>


                </table>
            </div> 
            <button class="custom-popup-close" onclick="javascript:closeViewCampaign();" type="button">close</button>
        </div></div>

</body>
<script type="text/javascript">
    $('#mailcampaign').click(function () {
        $('#overlay').fadeIn('fast', 'swing');
        $('#viewMailCampaignpopup').fadeIn('fast', 'swing');
    });
    function closeViewCampaign() {

        $('#overlay').fadeOut('fast', 'swing');
        $('#viewMailCampaignpopup').fadeOut('fast', 'swing');
    }
</script>
</html>
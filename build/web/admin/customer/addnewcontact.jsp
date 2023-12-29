
<%@page import="com.eminentlabs.crm.CRMUtil"%>
<%@ page language="java" contentType="text/html"
         pageEncoding="UTF-8"%>
<%@ page import="java.sql.*,pack.eminent.encryption.*,java.util.*,com.eminent.util.*"%>
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
    <LINK title=STYLE href="<%= request.getContextPath()%>/eminentech support files/main_ie.css" type="text/css" rel=STYLESHEET>
    <title>eTracker&#0153; - Eminentlabs&#0153; CRM,APM,ERM and PTS Solution</title>

    <script type="text/javascript"	src="<%= request.getContextPath()%>/eminentech support files/datetimepicker.js"></script>
    <script type="text/javascript"  src="<%= request.getContextPath()%>/javaScript/checkSubmit.js"></script>
    <script  type="text/javascript">
        function trim(str)
        {
            while (str.charAt(str.length - 1) == " ")
                str = str.substring(0, str.length - 1);
            while (str.charAt(0) == " ")
                str = str.substring(1, str.length);
            return str;
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
                        break;
                    }
                i++;
            } while (pos == 1 && i < str.length)
            if (pos == 0)
                return false;
            return true;
        }

        function isNumber(str)
        {
            var pattern = "0123456789.+- "
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

        /** Function To Check Whether There Is Any Integer Present In The Form Input From The User */

        function isPositiveInteger(str)
        {
            var pattern = "/\r?\n|\r/abcdefghijklmnopqrstuvwxyz,.?:;[]{}!@#$&*()-_+ ABCDEFGHIJKLMNOPQRSTUVWXYZ-1234567890"
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
            var pattern = "abcdefghijklmnopqrstuvwxyz.-_ ABCDEFGHIJKLMNOPQRSTUVWXYZ123456789"
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

            if (trim(document.getElementById('title').value) == '')
            {
                alert('Please enter the Title ');
                document.getElementById('title').value = "";
                document.getElementById('title').focus();
                return false;
            }
            if (!isPositiveInteger1(trim(document.getElementById('title').value)))
            {
                alert('Please enter the AlphaNumerical only in the Title ');
                document.getElementById('title').value = "";
                document.getElementById('title').focus();
                return false;
            }
            if (trim(document.getElementById('firstname').value) == '')
            {
                alert('Please enter the First Name ');
                document.getElementById('firstname').value = "";
                document.getElementById('firstname').focus();
                return false;
            }
            if (!isPositiveInteger1(trim(document.getElementById('firstname').value)))
            {
                alert('Please enter the AlphaNumerical Characters only in the First Name ');
                document.getElementById('firstname').value = "";
                document.getElementById('firstname').focus();
                return false;
            }
            if ((document.getElementById('lastname').value) == '')
            {
                alert('Please enter the Last Name');
                document.getElementById('lastname').value = "";
                document.getElementById('lastname').focus();
                return false;
            }
            if (!isPositiveInteger1(trim(document.getElementById('lastname').value)))
            {
                alert('Please enter the Last Name with AlphaNumerical only');
                document.getElementById('lastname').value = "";
                document.getElementById('lastname').focus();
                return false;
            }
            if (trim(document.getElementById('phone').value) == '')
            {
                alert('Please enter the Phone ');
                document.getElementById('phone').value = "";
                document.getElementById('phone').focus();
                return false;
            }
            if (!isNumber(trim(document.getElementById('phone').value)))
            {
                alert('Please enter the Numerical Characters only in the Phone ');
                document.getElementById('phone').value = "";
                document.getElementById('phone').focus();
                return false;
            }



            if (trim(document.getElementById('email').value) == '')
            {
                alert('Please enter the valid Email ');
                document.getElementById('email').value = "";
                document.getElementById('email').focus();
                return false;
            }
            if (!isPositiveInteger(trim(document.getElementById('email').value)))
            {
                alert('Please enter the AlphaNumerical only in the Email ');
                document.getElementById('email').value = "";
                document.getElementById('email').focus();
                return false;
            }
            if (!(/^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,4})+$/.test(document.getElementById('email').value)))
            {
                alert("Invalid E-mail Address! Please re-enter.")
                document.getElementById('email').value = "";
                document.getElementById('email').focus();
                return (false);
            }
            var mail = theForm.email.value;
            var user = mail.indexOf('@');
            var len = mail.length;
            var id = mail.substring(user + 1, len);
            var id1 = mail.substring(0, user - 1);

            if (!((user >= 0))) {
                alert('Enter the valid Email Address');
                document.getElementById('email').value = "";
                document.getElementById('email').focus();
                return false;
            }

            if (len < 5) {
                alert('Size of the Email should be more than 4 charactes ');
                document.getElementById('email').value = "";
                document.getElementById('email').focus();
                return false;
            }
            if (document.getElementById('assignedto').value == '--Select One--')
            {
                alert("Please choose a Assigned to Name");
                document.getElementById('assignedto').focus();
                return false;
            }
            if (trim(document.getElementById('mobile').value) == '')
            {
                alert('Please enter Mobile ');
                document.getElementById('mobile').value = "";
                document.getElementById('mobile').focus();
                return false;
            }
            if (!isNumber(trim(document.getElementById('mobile').value)))
            {
                alert('Please enter the Numerical Characters only in the Mobile ');
                document.getElementById('mobile').value = "";
                document.getElementById('mobile').focus();
                return false;
            }
            if (!(document.getElementById('personalemail').value == '')) {
                if (!(/^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,4})+$/.test(document.getElementById('personalemail').value)))
                {
                    alert("Invalid Personal E-mail Address! Please re-enter.")
                    document.getElementById('personalemail').value = "";
                    document.getElementById('personalemail').focus();
                    return (false);
                }
            }
            if (trim(document.getElementById('company').value) == '')
            {
                alert('Please enter the Company ');
                document.getElementById('company').value = "";
                document.getElementById('company').focus();
                return false;
            }

            if (!isPositiveInteger(trim(document.getElementById('company').value)))
            {
                alert('Please enter the AlphaNumerical only in the Company ');
                document.getElementById('company').value = "";
                document.getElementById('company').focus();
                return false;
            }


            if (!isPositiveInteger1(trim(document.getElementById('reportsto').value)) && trim(document.getElementById('reportsto').value) != '')
            {
                alert('Please enter the AlphaNumerical only in the Reports To ');
                document.getElementById('reportsto').value = "";
                document.getElementById('reportsto').focus();
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
                alert("Please enter vendor ");
                document.getElementById('vendor').focus();
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
            if (document.getElementById('account').value == '--Select Account--')
            {
                alert("Please choose a Account Name");
                document.getElementById('account').focus();
                return false;
            }
            if (trim(document.getElementById('duedate').value) == "")
            {
                alert("Please Enter the Due Date ");
                document.getElementById('duedate').focus();
                return false;
            }
            if (!isDate(trim(document.getElementById('duedate').value)))
            {
                alert('Please enter the valid Due Date');
                document.getElementById('duedate').value = "";
                document.getElementById('duedate').focus();
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
                document.getElementById('duedate').value = "";
                document.getElementById('duedate').focus();
                return false;
            }

     if (!(/^[0-9a-zA-Z\_,/]+$/.test(theForm.mailingstreet.value)) && trim(theForm.mailingstreet.value) != '') {
            alert("Special characters are not allowed in street! Please re-enter.")
            document.theForm.mailingstreet.value = "";
            theForm.mailingstreet.focus();
            return (false);
        }

            if (trim(document.getElementById('mailingarea').value) === '')
            {
                alert('Please enter the  Area/Location ');
                document.getElementById('mailingarea').value = "";
                document.getElementById('mailingarea').focus();
                return false;
            }
            if (!isPositiveInteger(trim(document.getElementById('mailingcity').value)) && trim(document.getElementById('mailingcity').value) != '')
            {
                alert('Please enter the AlphaNumerical only in the City ');
                document.getElementById('mailingcity').value = "";
                document.getElementById('mailingcity').focus();
                return false;
            }
            if (!isPositiveInteger(trim(document.getElementById('mailingstate').value)) && trim(document.getElementById('mailingstate').value) != '')
            {
                alert('Please enter the AlphaNumerical only in the State ');
                document.getElementById('mailingstate').value = "";
                document.getElementById('mailingstate').focus();
                return false;
            }
            if (!isNumber(trim(document.getElementById('mailingzip').value)) && trim(document.getElementById('mailingzip').value) != '')
            {
                alert('Please enter the AlphaNumerical only in the Zip ');
                document.getElementById('mailingzip').value = "";
                document.getElementById('mailingzip').focus();
                return false;
            }
            if (!isPositiveInteger(trim(document.getElementById('mailingcountry').value)) && trim(document.getElementById('mailingcountry').value) != '')
            {
                alert('Please enter the AlphaNumerical only in the Country ');
                document.getElementById('mailingcountry').value = "";
                document.getElementById('mailingcountry').focus();
                return false;
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
            if (!isNumber(trim(document.getElementById('fax').value)) && trim(document.getElementById('fax').value) != '')
            {
                alert('Please enter the Numerical Characters only in the Fax ');
                document.getElementById('fax').value = "";
                document.getElementById('fax').focus();
                return false;
            }
            if (!isNumber(trim(document.getElementById('homephone').value)) && trim(document.getElementById('homephone').value) != '')
            {
                alert('Please enter the Numerical Characters only in the Home Phone ');
                document.getElementById('homephone').value = "";
                document.getElementById('homephone').focus();
                return false;
            }
            if (!isNumber(trim(theForm.otherphone.value)) && trim(theForm.otherphone.value) != '')
            {
                alert('Please enter the Numerical Characters only in the Other Phone ');
                document.theForm.otherphone.value = "";
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
            if (!isNumber(trim(document.getElementById('asstphone').value)) && trim(document.getElementById('asstphone').value) != '')
            {
                alert('Please enter the Numerical Characters only in the Asst.Phone ');
                document.getElementById('asstphone').value = "";
                document.getElementById('asstphone').focus();
                return false;
            }

            if (!isPositiveInteger(trim(document.getElementById('department').value)) && trim(document.getElementById('department').value) != '')
            {
                alert('Please enter the AlphaNumerical only in the Department ');
                document.getElementById('department').value = "";
                document.getElementById('department').focus();
                return false;
            }
            monitorSubmit();
            return true;
        }

        /** Function To Set Focus On The Project Name Field In The Form */

        function setFocus() {
            document.getElementById('firstname').focus();
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
    </script>
</head>
<body>
    <jsp:useBean id="Contact" class="com.eminent.customer.ContactRegistration"/>

    <FORM name=theForm action="<%=request.getContextPath()%>/admin/customer/contact.jsp"
          method=post onsubmit="return fun(this)" onReset="return setFocus()">
        <%@ include file="/header.jsp"%>
        <div align="center">
            <center>
                <table  width="100%">
                    <tr bgcolor="C3D9FF">
                        <td align="left" width="100%"><font size="4" COLOR="#0000FF"><b>
                                    Add New Contact</b></font> <FONT SIZE="3" COLOR="#0000FF"> </FONT></td>
                    </tr>
                </table>

                <table width="100%" bgColor=#E8EEF7  align="center">
                    <TBODY>
                        <tr bgcolor="C3D9FF">
                            <td colspan=2><strong>Contact Information</strong></td>
                            <td><input type="hidden" name="owner" value="<%=session.getAttribute("uid")%>"></td>
                            <td align="right" colspan=3><strong><font size="10"
                                                                      COLOR="#FF0000">*</font> = Required Information</strong></td>
                        </tr>

                        <tr>
                            <td width="10%"><strong>Title<font size="10"
                                                               COLOR="#FF0000">*</font></strong></td>
                            <td width="21%"><input type="text" name="title" id="title" maxlength="30" size=14
                                                   ><strong class="style20"></strong></td>
                            <td width="10%"><strong>First Name<font size="10"
                                                                    COLOR="#FF0000">*</font></strong></td>
                            <td width="25%"><input type="text" name="firstname" id="firstname" maxlength="30" size=25
                                                   ><strong class="style20"></strong></td>
                            <td width="12%"><strong>Last Name <font size="10"
                                                                    COLOR="#FF0000">*</font></strong></td>
                            <td width="23%"><input type="text" name="lastname" id="lastname" maxlength="30" size=20
                                                   ><strong class="style20"></strong></td>
                        </tr>

                        <tr>


                            <td width="10%"><strong>Phone<font size="10"
                                                               COLOR="#FF0000">*</font></strong></td>
                            <td width="21%"><input type="text" name="phone" id="phone" maxlength="15" size=14
                                                   ><strong class="style20"></strong></td>
                            <td width="10%"><strong>Official Email<font size="10"
                                                                        COLOR="#FF0000">*</font></strong></td>
                            <td width="25%"><input type="text" name="email" id="email" maxlength="60" size=25
                                                   ><strong class="style20"></strong></td>
                            <td width="12%"><strong>Assigned To <font size="10" COLOR="#FF0000">*</font></strong></td>
                            <td width="23%">
                                <select name="assignedto" id="assignedto" size="1">

                                    <%

                                        HashMap al;

                                        String pro = "CRM";
                                        String fix = "1.0";
                                        String manager = GetProjectManager.getManager(pro, fix);
                                        int userId = (Integer) session.getAttribute("userid_curr");
                                        if (userId == Integer.parseInt(manager)) {
                                            al = GetProjectMembers.getBDMembers(pro, fix);
                                            logger.info("In CRM Manager box");
                                        } else {
                                            al = new HashMap<String, String>();
                                            al.put(manager, GetProjectManager.getUserFullName(Integer.parseInt(manager)));
                                            logger.info("In CRM User box");
                                        }
                                        Collection set = al.keySet();
                                        Iterator iter = set.iterator();
                                        int assigned = 0;
                                        int useridassi = 0;
                                        //Default assinedto should be Gopal (Refer issueid E31072010001)
                                        int defaultAssigned = 212;

                                        while (iter.hasNext()) {

                                            String key = (String) iter.next();
                                            String nameofuser = (String) al.get(key);
                                            logger.info("Userid" + key);
                                            logger.info("Name" + nameofuser);

                                            nameofuser = nameofuser.substring(0, nameofuser.indexOf(" ") + 2);

                                            useridassi = Integer.parseInt(key);

                                            assigned = useridassi;
                                            if (defaultAssigned == assigned) {
                                    %>

                                    <option value="<%=assigned%>" selected><%=nameofuser%></option>
                                    <%
                                    } else {

                                    %>

                                    <option value="<%=assigned%>"><%=nameofuser%></option>
                                    <%
                                            }
                                        }
                                    %>
                                </select></td>





                        </tr>
                        <tr>
                            <td width="10%"><strong>Mobile<font size="10"
                                                                COLOR="#FF0000">*</font></strong></td>
                            <td width="21%"><input type="text" name="mobile" id="mobile" maxlength="15" size=14
                                                   ><strong class="style20"></strong></td>
                            <td width="10%"><strong>Personal Email</strong></td>
                            <td width="25%"><input type="text" name="personalemail" id="personalemail" maxlength="60" size=25
                                                   ><strong class="style20"></strong></td>
                            <td width="10%"><strong>Company<font size="10"
                                                                 COLOR="#FF0000">*</font></strong></td>
                            <td width="23%"><input type="text" name="company" id="company" maxlength="60" size=25
                                                   ><strong class="style20"></strong></td>


                        </tr>
                        <tr>
                            <%
                                String[] ratingExist = {"Hot", "Warm", "Cold"};
                            %>
                            <td width="10%"><strong>Rating</strong></td>
                            <td width="21%">
                                <SELECT NAME="rating"  id="rating" size="1">

                                    <option value="Hot" selected>Hot</option>
                                    <option value="Warm">Warm</option>
                                    <option value="Cold">Cold</option>
                                </SELECT></td>


                            <td width="10%"><strong>Accounts <font size="10"
                                                                   COLOR="#FF0000">*</font></strong></td>
                                        <%
                                            PreparedStatement ps1 = null;
                                            ResultSet rs1 = null;
                                            Connection con = null;
                                            try {

                                                con = MakeConnection.getConnection();
                                                ps1 = con.prepareStatement("SELECT accountname  FROM account GROUP BY accountname Order by accountname asc");
                                                rs1 = ps1.executeQuery();
                                                String accounts = "";
                                        %>
                            <td><select name="account" id="account" size="1">
                                    <option value="--Select Account--" selected>--Select Account--</option>
                                    <%
                                        String defaultAccount = "Eminentlabs";
                                        while (rs1.next()) {
                                            accounts = rs1.getString(1);
                                            if (accounts.equalsIgnoreCase(defaultAccount)) {
                                    %>
                                    <option value="<%=accounts%>" selected><%=accounts%></option>
                                    <%
                                    } else {

                                    %>
                                    <option value="<%=accounts%>"><%=accounts%></option>
                                    <%
                                                }
                                            }

                                        } catch (Exception e) {
                                            logger.error(e.getMessage());
                                        } finally {
                                            if (rs1 != null) {
                                                rs1.close();
                                            }
                                            if (ps1 != null) {
                                                ps1.close();
                                            }
                                            if (con != null) {
                                                con.close();
                                            }
                                        }
                                    %>
                                </select></td>







                            <td width="12%"><strong>Due Date<font size="10"	COLOR="#FF0000">*</font></strong></td>
                            <td width="23%"><input type="text" name="duedate" id="duedate" maxlength="10" size="14" readonly /><a href="javascript:NewCal('duedate','ddmmyyyy')"> <img src="<%=request.getContextPath()%>/images/newhelp.gif" 	border="0" width="16" height="16" alt="Pick a date"></a></td>



                        </tr>	
                        <tr>

                            <td width="10%"><strong>Intrested In<font size="10" COLOR="#FF0000">*</font></strong></td>
                            <td width="25%">
                                <select name="product" id="product" size="1">
                                    <option value="eTracker">eTracker</option>
                                    <option value="eOutSource">eOutSource</option>
                                    <option value="ERPDS">ERPDS</option>
                                </select>
                            </td>
                            <td width="12%"><strong>Reports to</strong></td>
                            <td width="23%"><input type="text" name="reportsto" id="reportsto" maxlength="30" size=20
                                                   ><strong class="style20"></strong></td>
                            <td width="10%"><strong>ERP<font size="10" COLOR="#FF0000">*</font></strong></td>
                            <td width="25%">
                                <select name="erp" id="erp" size="1">
                                    <option value="" disabled selected>Select</option>
                                    <%for (String erp : Contact.erpList()) {%>
                                    <option value="<%=erp%>"><%=erp%></option>
                                    <% }%>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td width="10%"><strong>Vendor<font size="10" COLOR="#FF0000">*</font></strong></td>
                            <td width="25%">
                                <select name="vendor" id="vendor" onchange="javascript:showNewVendor();">
                                    <option value="" disabled selected>Select</option>
                                    <%for (String ven : CRMUtil.getVendors("contact")) {
                                    %>                           
                                    <option ><%=ven%></option>
                                    <%
                                        }%>
                                    <option value="new">New</option>
                                </select>
                                <input type="text" name="newVendor" id="newVendor" maxlength="100" style="display: none;"  size="20">
                            </td>



                            <td width="10%"><strong>Industry <font size="10" COLOR="#FF0000">*</font></strong></td>
                            <td width="25%">
                                <select name="industry" id="industry" onchange="javascript:showNew();">
                                    <option value="" disabled selected>Select</option>
                                    <%for (Map.Entry<Integer, String> ind : CRMUtil.getIndustry().entrySet()) {%>
                                    <option value="<%=ind.getKey()%>"><%=ind.getValue()%></option>
                                    <% }%>
                                    <option value="new">New</option>
                                </select>
                                <input type="text" name="newIndustry" id="newIndustry" class="newIndustryTd" maxlength="100" size=25 style="display: none;"
                                       ><strong class="style20"></strong>
                            </td>

                        </tr>
                        <tr><td width="100%" bgcolor="white" colspan=6 height="10"></td></tr>
                        <tr bgcolor="C3D9FF">
                            <td colspan=6><strong >Address Information</strong></td>
                            <td><input type="hidden" name="contactid"
                                       ></td>
                        </tr>

                        <tr>
                            <td width="10%"><strong>Street</strong></td>
                            <td width="21%"> <textarea name="mailingstreet" id="mailingstreet" wrap="physical" cols="13" rows="2"></textarea></td>
                            <td width="10%"><strong>Area/Location</strong></td>
                            <td width="23%">
                                <select name="mailingarea" id="mailingarea" onchange="javascript:showNewArea();">
                                    <option value="" disabled selected>Select</option>
                                    <%for (String area : CRMUtil.getArea("contact")) {
                                    %>                            
                                    <option ><%=area%></option>
                                    <%
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
                                    <%for (String city : CRMUtil.getCity("contact")) {
                                    %>                           
                                    <option ><%=city%></option>
                                    <% }%>
                                    <option value="new">New</option>
                                </select>                        
                                <input type="text" name="newMailingcity" id="newMailingcity" maxlength="30" size=25
                                       style="display: none;"    ><strong class="style20"></strong>
                            </td>
                        </tr>
                        <tr>
                            <td width="12%"><strong>State</strong></td>
                            <td width="23%">
                                <select name="mailingstate" id="mailingstate" onchange="javascript:showNewState();">
                                    <option value="" disabled selected>Select</option>
                                    <%for (String state : CRMUtil.getState("contact")) {
                                    %>                                   
                                    <option ><%=state%></option>
                                    <% }%>
                                    <option value="new">New</option>
                                </select>
                                <input type="text" name="newMailingstate" id="newMailingstate" maxlength="30"
                                       style="display: none;"  size=20 ><strong class="style20"></strong>
                            </td>

                            <td width="10%"><strong>Zip</strong></td>
                            <td width="21%"><input type="text" name="mailingzip" id="mailingzip" maxlength="30" size=14
                                                   ><strong class="style20"></strong></td>

                            <td width="10%"><strong>Country</strong></td>
                            <td width="23%">
                                <select name="mailingcountry" id="mailingcountry" onchange="javascript:showNewCountry();">
                                    <option value="" disabled selected>Select</option>
                                    <%for (String country : CRMUtil.getCountry("contact")) {
                                    %>
                                    <option ><%=country%></option>
                                    <% }%>
                                    <option value="new">New</option>
                                </select>    
                                <input type="text" name="newMailingcountry" id="newMailingcountry" maxlength="30"
                                       style="display: none;"     size=25 ><strong class="style20"></strong>
                            </td>


                        <tr><td width="100%" bgcolor="white" colspan=6 height="10"></td></tr>

                        <tr bgcolor="C3D9FF">
                            <td colspan=6><strong>Additional Information</strong></td>
                        </tr>


                        <tr>
                            <td width="10%"><strong>Fax</strong></td>
                            <td width="21%"><input type="text" name="fax" id="fax" maxlength="30" size=14
                                                   ><strong class="style20"></strong></td>
                            <td width="10%"><strong>Home Phone</strong></td>
                            <td width="23%"><input type="text" name="homephone" id="homephone" maxlength="30" size=25
                                                   ><strong class="style20"></strong></td>
                            <td width="12%"><strong>Other Phone</strong></td>
                            <td width="23%"><input type="text" name="otherphone"  id="otherphone" maxlength="30" size=20
                                                   ><strong class="style20"></strong></td>

                        </tr>

                        <tr>

                            <td width="10%"><strong>Department</strong></td>
                            <td width="21%">
                                <select name="department" id="department" onchange="javascript:showNewDept();">
                                    <option value="" disabled selected>Select</option>
                                    <%for (String dpt : CRMUtil.getDepartments("contact")) {
                                    %>
                                    <option ><%=dpt%></option>
                                    <% }%>
                                    <option value="new">New</option>
                                </select>
                                <input type="text" name="newDepartment" id="newDepartment" maxlength="30" size=14
                                       style="display: none;"  ><strong class="style20"></strong>
                            </td>

                            <td width="10%"><strong>Assistant</strong></td>
                            <td width="23%"><input type="text" name="assistant" id="assistant" maxlength="30" size=25
                                                   ><strong class="style20"></strong></td>

                            <td width="12%"><strong>Asst. Phone</strong></td>
                            <td width="23%"><input type="text" name="asstphone" id="asstphone" maxlength="30" size=20
                                                   ><strong class="style20"></strong></td>
                        </tr>
                        <tr>
                            <td width="10%"><strong>Birthdate</strong></td>
                            <td width="21%"><input type="text" name="birthdate" id="birthdate" maxlength="30" size=14
                                                   readonly="true"> <strong
                                                   class="style20"></strong><a
                                                   href="javascript:NewCal('birthdate','ddmmyyyy')"> <img
                                        src="images/newhelp.gif" width="16" height="16" border="0"
                                        alt="Pick a date"></a></td>
                            <td width="10%"><strong>Lead Source</strong></td>

                            <td align="left" width="23%">
                                <SELECT NAME="leadsource" id="leadsource" size="1">

                                    <option value="--None--" selected>--None--</option>
                                    <option value="Advertisement">Advertisement</option>
                                    <option value="Employee Referral">Employee Referral</option>
                                    <option value="External Referral">External Referral</option>
                                    <option value="Partner">Partner</option>
                                    <option value="Public Relation">Public Relation</option>
                                    <option value="Seminar-Internal">Seminar-Internal</option>
                                    <option value="Seminar-Partner">Seminar-Partner</option>
                                </SELECT></td>



                        </tr>
                    </tbody>
                </table>
                <br>
                <table width="100%" bgColor=#E8EEF7 border="0" align="center">
                    <TBODY>
                        <tr bgcolor="C3D9FF">
                            <td><strong>Descriptive Information</strong></td>
                        </tr>
                    </tbody>
                </table>
                <table width="100%" bgColor=#E8EEF7 border="0" align="center">
                    <TBODY>
                        <tr>
                            <td width="10%"><strong>Description</strong></td>
                            <td><textarea name="description" id="description" wrap="physical" cols="69"
                                          rows="2"></textarea></td>
                        </tr>
                    </tbody>
                </table>
                <TABLE width="100%" bgColor=#E8EEF7 border="0" align="center">
                    <TBODY>
                        <tr>
                            <TD>&nbsp;</TD>
                            <TD align=right><INPUT type=submit id="submit" value=Submit name=submit></TD>
                            <TD><INPUT type=reset id="reset" value=" Reset "></TD>
                        </tr>
                    </TBODY>
                </TABLE>
            </center>
        </div>
    </FORM>

</body>
</html>
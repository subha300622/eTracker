<%@ page language="java" contentType="text/html"
         pageEncoding="UTF-8"%>
<%@ page import="java.sql.*,pack.eminent.encryption.*,java.util.*,com.eminent.util.*,org.apache.log4j.*,java.text.*"%>
<%Logger logger = Logger.getLogger("editContact");
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
    <title>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS
        Solution</title>

    <script type="text/javascript" src="<%= request.getContextPath()%>/eminentech support files/dbpicker.js"></script>
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
            }
            while (pos == 1 && i < str.length)
            if (pos == 0)
                return false;
            return true;
        }

        function isNumber(str)
        {
            var pattern = "0123456789."
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
            }
            while (pos == 1 && i < str.length)
            if (pos == 0)
                return false;
            return true;
        }

        /** Function To Check Whether There Is Any Integer Present In The Form Input From The User */

        function isPositiveInteger(str)
        {
            var pattern = "abcdefghijklmnopqrstuvwxyz,.?:;[]{}!@#$&*()-_+ ABCDEFGHIJKLMNOPQRSTUVWXYZ-1234567890"
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
            }
            while (pos == 1 && i < str.length)
            if (pos == 0)
                return false;
            return true;
        }
        function isCompany(str)
        {
            var pattern = "abcdefghijklmnopqrstuvwxyz.-_ ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890";
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
            }
            while (pos == 1 && i < str.length)
            if (pos == 0)
                return false;
            return true;
        }
        function isPositiveInteger1(str)
        {
            var pattern = "abcdefghijklmnopqrstuvwxyz.-_ ABCDEFGHIJKLMNOPQRSTUVWXYZ";
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
            }
            while (pos == 1 && i < str.length)
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
                alert('Please enter the Alphabets only in the Title ');
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
                alert('Please enter the Alphabet Characters only in the First Name ');
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
                alert('Please enter the Last Name with Alphabets only');
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
            if (trim(theForm.company.value) == '')
            {
                alert('Please enter the Company ');
                document.theForm.company.value = "";
                theForm.company.focus();
                return false;
            }
            if (!isCompany(trim(theForm.company.value)))
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
            if (!(theForm.personalemail.value == '')) {
                if (!(/^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,4})+$/.test(theForm.personalemail.value)))
                {
                    alert("Invalid Personal E-mail Address! Please re-enter.")
                    document.theForm.personalemail.value = "";
                    theForm.personalemail.focus();
                    return (false);
                }
            }
            if (!isPositiveInteger(trim(theForm.reportsto.value)) && trim(theForm.reportsto.value) != '')
            {
                alert('Please enter the AlphaNumerical only in the Reports To ');
                document.theForm.reportsto.value = "";
                theForm.reportsto.focus();
                return false;
            }
            if (!(/^[0-9a-zA-Z\_,/]+$/.test(theForm.mailingstreet.value)) && trim(theForm.mailingstreet.value) != '') {
                alert("Special characters are not allowed in street! Please re-enter.")
                document.theForm.mailingstreet.value = "";
                theForm.mailingstreet.focus();
                return (false);
            }
            if (!isPositiveInteger(trim(theForm.mailingcity.value)) && trim(theForm.mailingcity.value) != '')
            {
                alert('Please enter the AlphaNumerical only in the City ');
                document.theForm.mailingcity.value = "";
                theForm.mailingcity.focus();
                return false;
            }
            if (!isPositiveInteger(trim(theForm.mailingstate.value)) && trim(theForm.mailingstate.value) != '')
            {
                alert('Please enter the AlphaNumerical only in the State ');
                document.theForm.mailingstate.value = "";
                theForm.mailingstate.focus();
                return false;
            }
            if (!isPositiveInteger(trim(theForm.mailingzip.value)) && trim(theForm.mailingzip.value) != '')
            {
                alert('Please enter the AlphaNumerical only in the Zip ');
                document.theForm.zip.value = "";
                theForm.zip.focus();
                return false;
            }
            if (!isPositiveInteger(trim(theForm.mailingcountry.value)) && trim(theForm.mailingcountry.value) != '')
            {
                alert('Please enter the AlphaNumerical only in the Country ');
                document.theForm.mailingcountry.value = "";
                theForm.mailingcountry.focus();
                return false;
            }

            if (!isNumber(trim(theForm.fax.value)) && trim(theForm.fax.value) != '')
            {
                alert('Please enter the Numerical Characters only in the Fax ');
                document.theForm.fax.value = "";
                theForm.fax.focus();
                return false;
            }
            if (!isNumber(trim(theForm.homephone.value)) && trim(theForm.homephone.value) != '')
            {
                alert('Please enter the Numerical Characters only in the Home Phone ');
                document.theForm.homephone.value = "";
                theForm.homephone.focus();
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
            if (!isNumber(trim(theForm.asstphone.value)) && trim(theForm.asstphone.value) != '')
            {
                alert('Please enter the Numerical Characters only in the Asst.Phone ');
                document.theForm.asstphone.value = "";
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


            if (!isPositiveInteger(trim(theForm.department.value)) && trim(theForm.department.value) != '')
            {
                alert('Please enter the AlphaNumerical only in the Department ');
                document.theForm.department.value = "";
                theForm.department.focus();
                return false;
            }


            return true;
        }

        /** Function To Set Focus On The Project Name Field In The Form */

        function setFocus() {
            document.theForm.firstname.focus();
        }
        window.onload = setFocus;

    </script>
</head>
<body>
    <jsp:include page="/header.jsp" />
    <BR>
    <!-- Table To Display The Formatted String "Add New User" -->
    <table cellpadding="0" cellspacing="0" width="100%">
        <tr border="2" bgcolor="#c3d9ff">
            <td border="1" align="left" width="100%"><font size="4"
                                                           COLOR="#0000FF"><b> Edit Contact</b></font> <FONT SIZE="3"
                                                                  COLOR="#0000FF"> </FONT></td>
        </tr>
    </table>
    <BR>
    <FORM name=theForm onsubmit="return fun(this)"
          action="<%=request.getContextPath()%>/contact/updatecontact.jsp"
          method=post onReset="return setFocus()">
        <%@ page import="java.sql.*,pack.eminent.encryption.*"%> <%
            int contactid = Integer.parseInt(request.getParameter("contactid"));
            Connection connection = null;
            Statement st = null;
            ResultSet rs = null;
            try {
                connection = MakeConnection.getConnection();
                if (connection != null) {
                    st = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);

                    rs = st.executeQuery("Select EMAIL,PERSONALEMAIL,FIRSTNAME,LASTNAME,ACCOUNTNAME,TITLE,PHONE,MOBILE,company,REPORTSTO,MAILINGSTREET,MAILINGCITY,MAILINGSTATE,MAILINGZIP,MAILINGCOUNTRY,OTHERSTREET,OTHERCITY,OTHERSTATE,OTHERZIP,OTHERCOUNTRY,FAX,HOMEPHONE,OTHERPHONE,ASSISTANT,ASSTPHONE,LEADSOURCE,BIRTHDATE,DEPARTMENT,DESCRIPTION,CONTACT_OWNER,erp from contact where contactid=" + contactid);
                    if (rs != null) {
                        while (rs.next()) {

                            String firstname = rs.getString("FIRSTNAME");
                            String lastname = rs.getString("LASTNAME");
                            String accountname = rs.getString("ACCOUNTNAME");
                            String title = rs.getString("TITLE");
                            String phone = rs.getString("PHONE");
                            String mobile = rs.getString("MOBILE");
                            String reportsto = rs.getString("REPORTSTO");
                            String email = rs.getString("EMAIL");
                            String pmail = rs.getString("PERSONALEMAIL");
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
                            String contactOwner = rs.getString("CONTACT_OWNER");
                            String company = rs.getString("company");
                            String erp = rs.getString("erp");

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
                            if (pmail == null) {
                                pmail = "";
                            }
                            if (mailingstreet == null) {
                                mailingstreet = "";
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


        %>

        <table width="100%" bgColor=#E8EEF7 border="0" align="center">
            <TBODY>
                <tr bgcolor="C3D9FF">
                    <td><strong>Edit Contact Information</strong></td>
                    <td align="right"><strong><font size="10"
                                                    COLOR="#FF0000">*</font> = Required Information</strong></td>
                </tr>
            </tbody>
        </table>
        <table width="100%" bgColor=#E8EEF7 border="0" align="center">
            <TBODY>

                <tr>
                    <td width="10%"><strong>Title<font size="10"
                                                       COLOR="#FF0000">*</font></strong></td>
                    <td width="21%"><input type="text" name="title" maxlength="30" size=14
                                           value="<%=title%>"><strong class="style20"></strong></td>
                    <td width="10%"><strong>First Name<font size="10"
                                                            COLOR="#FF0000">*</font></strong></td>
                    <td width="23%"><input type="text" name="firstname" maxlength="30" size=25
                                           value="<%=firstname%>"><strong class="style20"></strong></td>
                    <td width="10%"><strong>Last Name <font size="10"
                                                            COLOR="#FF0000">*</font></strong></td>
                    <td width="23%"><input type="text" name="lastname" maxlength="30" size=25
                                           value="<%=lastname%>"><strong class="style20"></strong></td>

                </tr>
                <tr>
                    <td width="10%"><strong>Phone<font size="10"
                                                       COLOR="#FF0000">*</font></strong></td>
                    <td width="21%"><input type="text" name="phone" maxlength="15" size=14
                                           value="<%=phone%>"><strong class="style20"></strong></td>
                    <td width="10%"><strong>Official Email<font size="10"
                                                                COLOR="#FF0000">*</font></strong></td>
                    <td width="23%"><input type="text" name="email" maxlength="60" size=25
                                           value="<%=email%>"><strong class="style20"></strong></td>
                    <td width="10%"><strong>Company<font size="10"
                                                         COLOR="#FF0000">*</font></strong></td>
                    <td width="23%"><input type="text" name="company" maxlength="60" size=25
                                           value="<%=company%>"><strong class="style20"></strong></td>
                </tr>
                <tr>
                    <td width="10%"><strong>Mobile<font size="10"
                                                        COLOR="#FF0000">*</font></strong></td>
                    <td width="21%"><input type="text" name="mobile" maxlength="15" size=14
                                           value="<%=mobile%>"><strong class="style20"></strong></td>
                    <td width="10%"><strong>Personal Email</strong></td>
                    <td width="23%"><input type="text" name="personalemail" maxlength="60" size=25
                                           value="<%=pmail%>"><strong class="style20"></strong></td>
                    <td width="10%"><strong>Reports to</strong></td>
                    <td width="23%"><input type="text" name="reportsto" maxlength="30" size=25
                                           value="<%=reportsto%>"><strong class="style20"></strong></td>
                </tr>
                <tr>

                </tr>
            </tbody>
        </table>
        <br>
        <table width="100%" bgColor=#E8EEF7 border="0" align="center">
            <TBODY>
                <tr bgcolor="C3D9FF">
                    <td><strong>Address Information</strong></td>
                    <td><input type="hidden" name="contactid"
                               value="<%=contactid%>"></td>
                </tr>
            </tbody>
        </table>

        <TABLE width="100%" bgColor=#E8EEF7 border="0" align="center">
            <TBODY>
                <tr>
                    <td width="10%"><strong>Street</strong></td>
                    <td width="21%"><textarea name="mailingstreet" wrap="physical" cols="13"
                                              rows="2"><%=mailingstreet%></textarea></td>
                    <td width="10%"><strong>City</strong></td>
                    <td width="23%"> <input type="text" name="mailingcity" maxlength="30" size=25
                                            value="<%=mailingcity%>"><strong class="style20"></strong></td>

                    <td width="10%"><strong>State</strong></td>
                    <td width="23%"><input type="text" name="mailingstate" maxlength="30"
                                           size=25 value="<%=mailingstate%>"><strong class="style20"></strong></td>

                </tr>


                <tr>
                    <td width="10%"><strong> Zip</strong></td>
                    <td width="21%"><input type="text" name="mailingzip" maxlength="30" size=14
                                           value="<%=mailingzip%>"><strong class="style20"></strong></td>

                    <td width="10%"><strong>Country</strong></td>
                    <td width="23%"><input type="text" name="mailingcountry" maxlength="30"
                                           size=25 value="<%=mailingcountry%>"><strong class="style20"></strong></td>

                </tr>
            </tbody>
        </table>
        <br>
        <TABLE width="100%" bgColor=#E8EEF7 border="0" align="center">

            <TBODY>

                <tr bgcolor="C3D9FF">
                    <td><strong>Additional Information</strong></td>
                </tr>
            </tbody>
        </table>
        <TABLE width="100%" bgColor=#E8EEF7 border="0" align="center">

            <TBODY>

                <tr>
                    <td width="10%"><strong>Fax</strong></td>
                    <td width="21%"><input type="text" name="fax" maxlength="30" size=14
                                           value="<%=fax%>"><strong class="style20"></strong></td>
                    <td width="10%"><strong>Home Phone</strong></td>
                    <td width="23%"><input type="text" name="homephone" maxlength="30" size=25
                                           value="<%=homephone%>"><strong class="style20"></strong></td>
                    <td width="10%"><strong>Other Phone</strong></td>
                    <td width="23%"><input type="text" name="otherphone" maxlength="30" size=25
                                           value="<%=otherphone%>"><strong class="style20"></strong></td>
                    </td>


                </tr>
                <tr>

                    <td width="10%"><strong>Department</strong></td>
                    <td width="21%"><input type="text" name="department" maxlength="30" size=14
                                           value="<%=department%>"><strong class="style20"></strong></td>

                    <td width="10%"><strong>Assistant</strong></td>
                    <td width="23%"><input type="text" name="assistant" maxlength="30" size=25
                                           value="<%=assistant%>"><strong class="style20"></strong></td>

                    <td width="10%"><strong>Asst. Phone</strong></td>
                    <td width="23%"> <input type="text" name="asstphone" maxlength="30" size=25
                                            value="<%=asstphone%>"><strong class="style20"></strong></td>
                </tr>
                <tr>

                    <td width="10%"><strong>Birthdate</strong></td>
                    <td width="21%"><input type="text" name="birthdate" maxlength="30" size=14
                                           value="<%=birthdate%>" readonly="true"> <a
                                           href="javascript:NewCal('birthdate','ddmmyyyy')"> <img
                                src="images/newhelp.gif" width="16" height="16" border="0"
                                alt="Pick a date"></a></td>
                    <td width="10%"><strong>Lead Source</strong></td>
                    <%
                        String[] leadsourceExist = {"--None--", "Advertisement", "Employee Referrel", "External Referrel", "partner", "public relataion", "seminar-internal", "Trade Show", "web", "Word of mouth", "others"};
                    %>
                    <td align="left" width="23%"><SELECT NAME="leadsource" size="1">
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

            </tbody>
        </table>


        <TABLE width="100%" bgColor=#E8EEF7 border="0" align="center">
            <TBODY>
                <tr>
                    <TD>&nbsp;</TD>
                    <TD align=right><INPUT type=submit value=Submit name=submit></TD>
                    <TD><INPUT type=reset value=" Reset "></TD>
                </TR>
            </TBODY>
        </TABLE>
        <br>
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
            //					rs.close();

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
</body>
</html>
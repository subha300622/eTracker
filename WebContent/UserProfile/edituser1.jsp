<%@page import="com.pack.StringUtil"%>
<%@ page language="java" contentType="text/html"
         pageEncoding="UTF-8"%>
<%
    Logger logger = Logger.getLogger("edituser1");
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
        <title>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS
            Solution</title>
        <script language="JavaScript">

            <!--
                function cancelUpdate() {
                location = 'profile.jsp';
            }
            /** Java Script Function For Trimming A String To Get Only The Required String Input */

            function trim(str) {
                while (str.charAt(str.length - 1) == " ")
                    str = str.substring(0, str.length - 1);
                while (str.charAt(0) == " ")
                    str = str.substring(1, str.length);
                return str;
            }

            /** Function To Check Whether There Is Any Integer Present In The Form Input From The User */

            function isPositiveInteger(str) {
                var pattern = "abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLMNOPQRSTUVWXYZ"
                var i = 0;
                do {
                    var pos = 0;
                    for (var j = 0; j < pattern.length; j++)
                        if (str.charAt(i) == pattern.charAt(j)) {
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

            function isPositiveInteger1(str) {
                var pattern = "abcdefghijklmnopqrstuvwxyz. ABCDEFGHIJKLMNOPQRSTUVWXYZ@"
                var i = 0;
                do {
                    var pos = 0;
                    for (var j = 0; j < pattern.length; j++)
                        if (str.charAt(i) == pattern.charAt(j)) {
                            pos = 1;
                            break;
                        }
                    i++;
                } while (pos == 1 && i < str.length)
                if (pos == 0)
                    return false;
                return true;
            }
            function isPositiveInteger2(str) {
                var pattern = "abcdefghijklmnopqrstuvwxyz. ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890!@#$%^&*()-_+=|[];',./{}:<>?"
                var i = 0;
                do {
                    var pos = 0;
                    for (var j = 0; j < pattern.length; j++)
                        if (str.charAt(i) == pattern.charAt(j)) {
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
            function isCompany(str) {
                var pattern = "abcdefghijklmnopqrstuvwxyz. ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890 &-'."
                var i = 0;
                do {
                    var pos = 0;
                    for (var j = 0; j < pattern.length; j++)
                        if (str.charAt(i) == pattern.charAt(j)) {
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
            var digits = "0123456789";
            var phoneNumberDelimiters = "()- ";
            var validWorldPhoneChars = phoneNumberDelimiters + "+";
            var minDigitsInIPhoneNumber = 10;

            function isInteger(s)
            {
                var i;
                for (i = 0; i < s.length; i++)
                {
                    var c = s.charAt(i);
                    if (((c < "0") || (c > "9")))
                        return false;
                }
                return true;
            }

            function stripCharsInBag(s, bag)
            {
                var i;
                var returnString = "";
                for (i = 0; i < s.length; i++)
                {
                    var c = s.charAt(i);
                    if (bag.indexOf(c) == -1)
                        returnString += c;
                }
                return returnString;
            }

            function checkInternationalPhone(strPhone)
            {
                s = stripCharsInBag(strPhone, validWorldPhoneChars);
                return (isInteger(s) && s.length >= minDigitsInIPhoneNumber);
            }


            function isNumber(str) {
                var pattern = "0123456789()"
                var i = 0;
                do {
                    var pos = 0;
                    for (var j = 0; j < pattern.length; j++)
                        if (str.charAt(i) == pattern.charAt(j)) {
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

            function fun(theForm) {

                /** This Loop Checks Whether There Is Any Input Data Present In The First Name Info Field */

                if ((theForm.firstName.value) == '') {
                    alert('Please enter the Firstname  ');
                    document.theForm.firstName.value = "";
                    theForm.firstName.focus();
                    return false;
                }


                /** This Loop Checks Whether There Is Any Integer Present In The First Name Field */

                if (!isPositiveInteger(trim(theForm.firstName.value))) {
                    alert('Please enter the Alphabetical only in the FirstName ');
                    document.theForm.firstName.value = "";
                    theForm.firstName.focus();
                    return false;
                }

                /** This Loop Checks Whether There Is Any Input Data Present In The Last Name Field */

                if ((theForm.lastName.value) == '') {
                    alert('Please enter the Lastname ');
                    document.theForm.lastName.value = "";
                    theForm.lastName.focus();
                    return false;
                }



                /** This Loop Checks Whether There Is Any Integer Present In The Last Name Field */

                if (!isPositiveInteger(trim(theForm.lastName.value))) {
                    alert('Please enter  Alphabetical only in the "LastName" box');
                    document.theForm.lastName.value = "";
                    theForm.lastName.focus();
                    return false;
                }
                /** This Loop Checks Whether There Is Any Input Data Present In The Company Field */

                if ((theForm.company.value) == '')
                {
                    alert('Please enter the Company Name ');
                    theForm.company.focus();
                    return false;
                }

                /** This Loop Checks Whether There Is Any Integer Present In The Company Field */

                if (!isCompany(trim(theForm.company.value))) {
                    alert('Please enter a Alphabetical only in the "Company" box');
                    document.theForm.company.value = "";
                    theForm.company.focus();
                    return false;
                }


                if ((theForm.phone.value) == '') {
                    alert('Please enter the Phone Number ');
                    theForm.phone.focus();
                    return false;
                }

                if ((theForm.phone.value == null) || (theForm.phone.value == ""))
                {
                    alert("Please Enter your Counter code in Phone Number");
                    theForm.phone.focus();
                    return false;
                }
                if (!isNumber(trim(theForm.phone.value)))
                {
                    alert('Please enter number only in the "phone" box');
                    document.theForm.phone.value = "";
                    theForm.phone.focus();
                    return false;
                }
                if ((theForm.phone1.value == null) || (theForm.phone1.value == ""))
                {
                    alert("Please Enter your Area code in Phone Number");
                    theForm.phone1.focus();
                    return false;
                }
                if (!isNumber(trim(theForm.phone1.value)))
                {
                    alert('Please enter number only in the "phone" box');
                    document.theForm.phone1.value = "";
                    theForm.phone1.focus();
                    return false;
                }
                if ((theForm.phone2.value == null) || (theForm.phone2.value == ""))
                {
                    alert("Please Enter your Phone Number");
                    theForm.phone2.focus();
                    return false;
                }
                if (!isNumber(trim(theForm.phone2.value)))
                {
                    alert('Please enter number only in the "phone" box');
                    document.theForm.phone2.value = "";
                    theForm.phone2.focus();
                    return false;
                }


                if ((theForm.phone2.value.length) < 6) {
                    alert('Size of the phone should be more than 10 charactes ');
                    document.theForm.phone2.value = "";
                    theForm.phone2.focus();
                    return false;
                }
                if ((theForm.phone2.value.length) > 10) {
                    alert('Size of the phone should not be more than 12 charactes ');
                    document.theForm.phone2.value = "";
                    theForm.phone2.focus();
                    return false;
                }




                /** This Loop Checks Whether There Is Any Input Data Present In The Mobile Field */
                if (!isNumber(trim(theForm.mobile.value))) {
                    alert('Please enter number only in the "mobile" box');
                    document.theForm.mobile.value = "";
                    theForm.mobile.focus();
                    return false;
                }
                var ph = theForm.phone.value;
                var mo = theForm.mobile.value;
                var ch01 = "0000000000";
                var ch02 = "00000000000";
                var ch03 = "000000000000";
                var ch11 = "1111111111";
                var ch12 = "11111111111";
                var ch13 = "111111111111";
                if (ph == ch01 || ph == ch02 || ph == ch03 || ph == ch11 || ph == ch12 || ph == ch13)
                {
                    alert('Please enter valid phone number only in the "phone" box');
                    document.theForm.phone.value = "";
                    theForm.phone.focus();
                    return false;

                }
                if (mo == ch01 || mo == ch02 || mo == ch03 || mo == ch11 || mo == ch12 || mo == ch13)
                {
                    alert('Please enter valid phone number only in the "phone" box');
                    document.theForm.mobile.value = "";
                    theForm.mobile.focus();
                    return false;

                }

                if ((theForm.mobile.value) == '') {
                    alert('Please enter the Country code in Mobile Number ');
                    theForm.mobile.focus();
                    return false;
                }
                if ((theForm.mobile1.value) == '') {
                    alert('Please enter the Mobile Number ');
                    theForm.mobile1.focus();
                    return false;
                }
                if ((theForm.mobile1.value.length) < 10) {
                    alert('Size of the mobile should be more than 10 charactes ');
                    document.theForm.mobile1.value = "";
                    theForm.mobile1.focus();
                    return false;
                }
                if ((theForm.mobile1.value.length) > 12) {
                    alert('Size of the mobile should not be more than 12 charactes ');
                    document.theForm.mobile1.value = "";
                    theForm.mobile1.focus();
                    return false;
                }
                if (!isNumber(trim(theForm.mobile1.value))) {
                    alert('Please enter number only in the "mobile" box');
                    document.theForm.mobile1.value = "";
                    theForm.mobile1.focus();
                    return false;
                }

                if ((theForm.mobile.value == null) || (theForm.mobile.value == ""))
                {
                    alert("Please Enter your mobile Number")
                    theForm.mobile.focus()
                    return false
                }
                return true;

            }
            /** Function To Set Focus On The First Name Field In The Form */

            function setFocus() {
                document.theForm.firstName.focus();
            }

            window.onload = setFocus;
            //-->

        </SCRIPT>

    </head>
    <body>
        <FORM name=theForm onSubmit="return fun(this)"
              action="<%=request.getContextPath()%>/UserProfile/userupdate1.jsp"
              method=post onReset="return setFocus()"><!--<table width="100%" bgcolor="#EEEEEE" valign="right" height="5%"
              border="0">
      
              <tr>
      
      
                      <td border="0" align="left" width="800"><b><font size="3"
                              COLOR="#0000FF"> Current User: </font></b><FONT SIZE="3"
                              COLOR="#0000FF"> &nbsp;<b>&nbsp;<%=session.getAttribute("fName")%>&nbsp; <%=session.getAttribute("lName")%>
                      </b>
                      </FONT></td>
      <td width="6%" align="center" border="1">
                              <font size="2" face="Verdana, Arial, Helvetica, sans-serif">
                              <A HREF="<%= request.getContextPath()%>/logout.jsp" target="_parent">Logout</A>
                              </font>
                      </td>
      </tr>
      </table>--> <%@ include file="../header.jsp"%>
            <div align="center">
                <center><BR>

                    <TABLE width="100%">

                        <TR >
                            <TD align="left"  bgcolor="#E8EEF7">
                                <B>Edit Profile:</B>
                            </TD>
                        </TR>

                    </TABLE>


                    <br>

                    <%@ page
                    import="java.sql.*,pack.eminent.encryption.*"%> <%
                        int a, b, c, d, e;
                        String phone, phone1, phone2, mobile, mobile1;

                        Connection connection = null;
                        Statement st = null;
                        ResultSet rs = null;
                        try {
                            String email1 = (String) session.getAttribute("Name");
                            connection = MakeConnection.getConnection();

                            if (connection != null) {
                                st = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                                rs = st.executeQuery("SELECT FIRSTNAME,LASTNAME,COMPANY,EMAIL,PASSWORD,MOBILE,PHONE,SECRET,ANSWER,MOBILEOPERATOR from users where email='" + StringUtil.fixSqlFieldValue(email1) + "' ");
                                ResultSetMetaData rsmd = rs.getMetaData();
                                int columnCount = rsmd.getColumnCount();
                                //                       System.out.println("No of Column"+columnCount);
                                int i = 0;
                                while (i <= columnCount) {

                                    //           System.out.println("meta"+rsmd.getColumnName(i));
                                    i++;
                                }

                                if (rs != null) {
                                    while (rs.next()) {
                                        String fname = rs.getString("firstname");
                                        String lname = rs.getString("lastname");
                                        String company = rs.getString("company");
                                        String email = rs.getString("email");
                                        String mobileget = rs.getString("mobile");
                                        String phoneget = rs.getString("phone");
                                        String secret = rs.getString("secret");
                                        String answer = rs.getString("answer");
                                        String operate = rs.getString("MOBILEOPERATOR");
                                        a = phoneget.length();
                                        b = phoneget.indexOf("-");
                                        c = phoneget.lastIndexOf("-");
                                        d = mobileget.length();
                                        e = mobileget.indexOf("-");
                                        phone = phoneget.substring(1, b);
                                        phone1 = phoneget.substring(b + 1, c);
                                        phone2 = phoneget.substring(c + 1, a);
                                        mobile = mobileget.substring(1, e);
                                        mobile1 = mobileget.substring(e + 1, d);
                        %>

                        <TABLE width="100%" bgColor=#E8EEF7 border="0">
                            <TBODY>
                                <%
                                    if (request.getParameter("profilestatus") != null && request.getParameter("profilestatus").equals("true")) {
                                %>
                                <TR>
                                    <TD colspan="10" align="center"><B><FONT SIZE="4"
                                                                             COLOR="#33CC33"> Your profile has been changed!</FONT></B></TD>
                                </TR>
                                <%
                                    }
                                %>
                                <tr height="40">
                                    <td width="15%"><strong>First Name </strong></td>
                                    <td width="17%"><input type="text" name="firstName" maxlength="25" size="25"
                                                           value="<%=fname%>"> <strong class="style20"></strong></td>
                                    <td width="12%"><strong>Last Name </strong></td>
                                    <td width="15%"><input type="text" name="lastName" maxlength="25" size="20"
                                                           value="<%=lname%>"> <strong class="style20"></strong></td>
                                    <td width="12%"><strong>Company</strong></td>
                                    <td width="21%"><input type="text" name="company" maxlength="30" size="25"
                                                           value="<%=company%>"/> <strong class="style20"></strong></td>

                                </tr>
                                <tr height="40">

                                    <td width="15%"><strong>Phone</strong></td>
                                    <td width="20%"><input type="text" name="phone" maxlength="4"
                                                           value="<%=phone%>" size=5 style="width: 20%;"> <input type="text" name="phone1"
                                                           maxlength="5" value="<%=phone1%>" size=5 style="width: 25%;"> <input type="text"
                                                           name="phone2" maxlength="10" value="<%=phone2%>" size=15 style="width: 48%;"></td>
                                    <td style="width: 15%;"><strong>Mobile</strong></td>
                                    <td width="20%"><input type="text" name="mobile" maxlength="4"
                                                           value="<%=mobile%>" size=4 style="width: 25%;"> <input type="text"
                                                           name="mobile1" maxlength="10" size=13 value="<%=mobile1%>"></td>
                                    <td width="12%"><strong>E-mail</strong></td>
                                    <td width="21%"><input type="text" name="userEmail" readonly="true"
                                                           maxlength="60" size="25" value="<%=email%>" readonly="true"/><strong
                                                           class="style20"></strong></td>
                                </tr>


                                <%

                                    String operator1 = "AIRTEL";
                                    String operator2 = "VODAFONE";
                                    String operator3 = "SPICE";
                                    String operator4 = "BSNL";
                                    String operator5 = "OTHERS";
                                    String operator;

                                %>
                                <TR height="40">

                                    <td width="15%"><strong>Secret Question</strong></td>
                                    <td width="20%"><input type="text" name="secret" maxlength="50" size="25"
                                                           value="<%= secret%>"><strong class="style20"></strong></td>

                                    <td width="12%"><strong>Secret Answer</strong></td>
                                    <td width="15%"><input type="text" name="answer" maxlength="20" size="20"
                                                           value="<%= answer%>"><strong class="style20"></strong></td>
                                    <td width="15%"><strong>Mobile Operator</strong></td>
                                    <td width="17%"><select name="operator" id="operator" style="width: 95%;">
                                            <option value="">[Select a Operator]</option>
                                            <%

                                                if (operator1.equals(operate)) {
                                                    operator = operator1;
                                            %>
                                            <option value="<%=operator%>" selected><%=operator%></option>
                                            <%
                                            } else {
                                                operator = operator1;
                                            %>
                                            <option value="<%=operator%>"><%=operator%></option>
                                            <%
                                                }
                                                if (operator2.equals(operate)) {
                                                    operator = operator2;
                                            %>
                                            <option value="<%=operator%>" selected><%=operator%></option>
                                            <%
                                            } else {
                                                operator = operator2;
                                            %>
                                            <option value="<%=operator%>"><%=operator%></option>
                                            <%
                                                }
                                                if (operator3.equals(operate)) {
                                                    operator = operator3;
                                            %>
                                            <option value="<%=operator%>" selected><%=operator%></option>
                                            <%
                                            } else {
                                                operator = operator3;
                                            %>
                                            <option value="<%=operator%>"><%=operator%></option>
                                            <%
                                                }

                                                if (operator4.equals(operate)) {
                                                    operator = operator4;
                                            %>
                                            <option value="<%=operator%>" selected><%=operator%></option>
                                            <%
                                            } else {
                                                operator = operator4;
                                            %>
                                            <option value="<%=operator%>"><%=operator%></option>
                                            <%
                                                }

                                                if (operator5.equals(operate)) {
                                                    operator = operator5;
                                            %>
                                            <option value="<%=operator%>" selected><%=operator%></option>
                                            <%
                                            } else {
                                                operator = operator5;
                                            %>
                                            <option value="<%=operator%>"><%=operator%></option>
                                            <%
                                                }
                                            %>
                                        </SELECT></td>

                                </tr>

                                <tr><td>&nbsp;</td></tr>


                                <TR align="center">

                                    <TD colspan="10"><INPUT type=submit value=Update name=submit> <INPUT
                                            type=button value=" Cancel " onclick="javascript:cancelUpdate();"></TD>
                                </TR>
                            </TBODY>
                        </TABLE>

                        <%
                                        }
                                    }
                                }
                            } catch (Exception ex) {
                                //		System.err.println("Exception in editUser"+ex);
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

                        %> <BR>
                    </center>
                </div>
            </FORM>
        </body>
    </html>
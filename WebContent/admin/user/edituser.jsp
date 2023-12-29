<%@page import="com.eminent.util.GetProjectMembers"%>
<%@page import="com.eminent.branch.Branches"%>
<%@page import="com.pack.StringUtil"%>
<%@page import="org.apache.log4j.Logger"%>
<%@page import="com.eminent.leaveUtil.LeaveUtil"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.LinkedHashMap"%>
<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.text.SimpleDateFormat" %>
<%@page import="com.eminent.issue.ApmTeam"%>
<%Logger logger = Logger.getLogger("editUser");
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
    <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/checkSubmit.js"></script>
    <title>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS
        Solution</title>
</head>

<!-- Start Of Java Script For Front End Validation -->

<script language="JavaScript">

<!--

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
            var pattern = "abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLMNOPQRSTUVWXYZ'"
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
            } while (pos == 1 && i < str.length)
            if (pos == 0)
                return false;
            return true;
        }
        function isPositiveInteger3(str) {
            var pattern = "abcdefghijklmnopqrstuvwxyz. ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890.-'&"
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
            } while (pos == 1 && i < str.length)
            if (pos == 0)
                return false;
            return true;
        }




        /** Function To Validate The Input Form Data */

        function fun(theForm) {

            /** This Loop Checks Whether There Is Any Input Data Present In The First Name Info Field */

            if ((theForm.firstName.value) == '') {
                alert('Please enter the Firstname ');
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
                alert('Please enter a Alphabetical only in the "LastName" box');
                document.theForm.lastName.value = "";
                theForm.lastName.focus();
                return false;
            }

            /** This Loop Checks Whether There Is Any Input Data Present In The Email Address Field */

            if ((theForm.userEmail.value) == '') {
                alert('Please enter the Email Address');
                document.theForm.userEmail.value = "";
                theForm.userEmail.focus();
                return false;
            }


            if (!(/^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,4})+$/.test(theForm.userEmail.value)))
            {
                alert("Invalid E-mail Address! Please re-enter.")
                document.theForm.userEmail.value = "";
                theForm.userEmail.focus();
                return (false);
            }



            /** This Loop Checks Whether There Is Any Input Data Present In The Company Field */

            if ((theForm.company.value) == '') {
                alert('Please enter the Company Name ');
                theForm.company.focus();
                return false;
            }

            /** This Loop Checks Whether There Is Any Integer Present In The Company Field */

            if (!isPositiveInteger3(trim(theForm.company.value))) {
                alert('Please enter the valid characters only in the "Company" box');
                document.theForm.company.value = "";
                theForm.company.focus();
                return false;
            }




            /** This Loop Checks Whether There Is Any Input Data Present In The Phone Field */
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
            if (!isNumber(trim(theForm.mobile1.value))) {
                alert('Please enter number only in the "mobile" box');
                document.theForm.mobile1.value = "";
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

            if ((theForm.mobile.value == null) || (theForm.mobile.value == ""))
            {
                alert("Please Enter your mobile Number")
                theForm.mobile.focus()
                return false
            }
            return true;
            disableSubmit();
        }
        /** Function To Set Focus On The First Name Field In The Form */

        function setFocus() {
            document.theForm.firstName.focus();
        }

        window.onload = setFocus;
        //-->

    </script>
    <!-- End Of Java Script Code -->
    <body>

    <jsp:include page="/header.jsp" />

    <BR>
    <!-- Table To Display The Formatted String "Add New User" -->

    <table cellpadding="0" cellspacing="0" width="100%">

        <tr border="2" bgcolor="#c3d9ff">

            <td border="1" align="left" width="100%"><font size="4"
                                                           COLOR="#0000FF"><b> Edit User</b> </font> <FONT SIZE="3"
                                                                COLOR="#0000FF"> </FONT></td>

        </tr>

    </table>
    <BR>
    <jsp:useBean id="atc" class="com.eminent.issue.controller.ApmTeamController"/>
    <jsp:useBean id="mwd" class="com.eminent.branch.BranchController"></jsp:useBean>
        <FORM name=theForm onsubmit="return fun(this)"
              action="<%=request.getContextPath()%>/admin/user/userupdate.jsp"
        method=post onReset="return setFocus()">
        <%@ page import="java.sql.*,pack.eminent.encryption.*,com.eminent.util.GetProjectManager"%> 
        <%mwd.getAllBranches();
            int a, b, c, d, e;
            Map<Integer, String> role = new LinkedHashMap();
            role.put(2, "APM");
            role.put(3, "CRM");
            role.put(4, "ERM");
            role.put(5, "Network");
            String phone1, phone2, phone, mobile1, mobile;
            int userid = (Integer) session.getAttribute("uid");
            String email1 = request.getParameter("emailID");
            session.setAttribute("mail", email1);
            email1.trim();
            Connection connection = null;
            Statement st = null;
            ResultSet rs = null;
            try {
                connection = MakeConnection.getConnection();
                if (connection != null) {
                    st = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                    rs = st.executeQuery("SELECT USERID,FIRSTNAME,LASTNAME,COMPANY,EMAIL,PASSWORD,MOBILE,PHONE,MOBILEOPERATOR,TEAM,LASTLOGGEDON,EMP_ID,BRANCH_ID,ROLEID from users where email='" + StringUtil.fixSqlFieldValue(email1) + "' ");
                    if (rs != null) {
                        while (rs.next()) {
                            int user = rs.getInt("userid");
                            String fname = rs.getString("firstname");

                            String lname = rs.getString("lastname");

                            String company = rs.getString("company");

                            String email = rs.getString("email");

                            //				String pwd=rs.getString("password");
                            String mobileget = rs.getString("mobile");

                            String phoneget = rs.getString("phone");

                            String team = rs.getString("team");
                            int branch = rs.getInt("BRANCH_ID");
                            int roleId = rs.getInt("ROLEID");

                            a = phoneget.length();

                            b = phoneget.indexOf("-");
                            c = phoneget.lastIndexOf("-");
                            d = mobileget.length();
                            e = mobileget.indexOf("-");
                            phone = phoneget.substring(1, b);

                            b++;
                            phone1 = phoneget.substring(b, c);
                            c++;
                            phone2 = phoneget.substring(c, a);

                            mobile = mobileget.substring(1, e);

                            e++;
                            mobile1 = mobileget.substring(e, d);

                            Timestamp loggedon = rs.getTimestamp("lastloggedon");
                            String lastLoggedOn = "NA";
                            if (loggedon != null) {
                                lastLoggedOn = new SimpleDateFormat("dd-MMM-yy HH:mm:ss").format(loggedon);
                            }


        %>

        <TABLE width="100%" bgColor=#e8eff7 border="0" align="center">
            <TBODY>
                <tr height="40">
                    <td width="12%"><strong>First Name </strong></td>
                    <td><input type="text" name="firstName" maxlength="25" size="25"
                               value="<%=fname%>"> <strong class="style20"></strong></td>
                    <td width="12%"><strong>Last Name </strong></td>
                    <td><input type="text" name="lastName" maxlength="25" size="25"
                               value="<%=lname%>"> <strong class="style20"></strong></td>
                    <td width="12%"><strong>Company</strong></td>
                    <td><input type="text" name="company" maxlength="30" size="25"
                               value="<%=company%>"/> <strong class="style20"></strong></td>


                </tr>
                <tr height="40">
                    <td><strong>Phone</strong></td>
                    <td><input type="text" name="phone" maxlength="4"
                               value="<%=phone%>" size=5 style="width: 20%;"> <input type="text" name="phone1"
                               maxlength="5" value="<%=phone1%>" size=5 style="width: 25%;"> <input type="text"
                               name="phone2" maxlength="10" value="<%=phone2%>" size=15 style="width: 48%;"></td>
                    <td><strong>Mobile</strong></td>
                    <td><input type="text" name="mobile" maxlength="4"
                               value="<%=mobile%>" size=5 style="width: 30%;"> <input type="text"
                               name="mobile1" maxlength="10" size=15 value="<%=mobile1%>"></td>
                    <td width="12%"><strong>E-mail</strong></td>
                    <td><input type="text" name="userEmail" readonly="true"
                               maxlength="60" size="25" value="<%=email%>" /><strong
                               class="style20"></strong></td>
                </tr>

                <tr height="40">
                    <td><strong>Team</strong></td>
                    <td>
                        <select
                            name="Team" size="1">

                            <% for (ApmTeam apmTeam : atc.findAllTeams()) {
                                    if (team.equals(apmTeam.getTeamName())) {
                            %>

                            <option value="<%=apmTeam.getTeamName()%>" selected><%=apmTeam.getTeamName()%></option>
                            <%

                            } else {
                            %>    
                            <option value="<%=apmTeam.getTeamName()%>"><%=apmTeam.getTeamName()%></option>
                            <%}
                                }
                            %>
                        </select>



                    </td>


                    <%
                        String mail = email1;
                        String url = null;
                        if (mail != null) {
                            url = mail.substring(mail.indexOf("@") + 1, mail.length());
                        }
                        if (url.equals("eminentlabs.net")) {
                            String empId = rs.getString("EMP_ID");
                            if (empId == "" || empId == null) {
                                empId = "";
                            }
                    %>
                    <td width="20%"><strong>Employee ID</strong></td>
                    <td><input type="text" name="empId" 
                               maxlength="60" size="25" value="<%=empId%>"/><strong
                               class="style20"></strong></td>
                        <%
                            }
                        %>
                    <td align="left" height="30" width="22%"><B>Last Logged On</B></td>

                    <td align="left" height="30"><a href="<%= request.getContextPath()%>/admin/user/userLoginHistory.jsp?userId=<%=user%>"><%=lastLoggedOn%></a>             
                </tr>
                <tr height="40">

                    <td><strong>Branch</strong></td>
                    <td>
                        <input type="hidden" name="branch" value="<%=branch%>"/>
                        <input type="hidden" name="userId" value="<%=user%>"/>
                        <select id="newBranch" name="newBranch">
                            <%if (!mwd.getBranches().isEmpty()) {
                                for (Branches branches : mwd.getBranches()) {%>
                            <option value="<%=branches.getBranchId()%>" <%if (branches.getBranchId() == branch) {%> selected=""
                                    <%}%> ><%=branches.getLocation()%></option>
                            <%}
                            }%>                                                
                        </select>



                    </td>

                    <td>

                        <select id="role" name="role">
                            <%
                            for (Map.Entry<Integer, String> entry : role.entrySet()) {%>
                            <option value="<%=entry.getKey()%>" <%if (entry.getKey().intValue() == roleId) {%> selected=""
                                    <%}%> ><%=entry.getValue()%></option>
                            <%}
                            %>                                                
                        </select>



                    </td>
                </tr>
                <tr height="40">

                    <td align="left" height="30" width="30%"><B>Projects Involved</B></td>

                    <td align="left" height="30" colspan="5"><%=GetProjectManager.getProjects(user)%>
                    <td>
                </tr>
                <TR >


                    <TD align="center" colspan="10"><INPUT type=submit value=Update name=submit>&nbsp;&nbsp;&nbsp;&nbsp;<INPUT
                            type=reset value=" Reset "></TD>

                </TR>
            </TBODY>
        </TABLE>

        <%
            if (url.equals("eminentlabs.net")) {
                Map leaveTypeDetails = LeaveUtil.leaveDetailsByUser(user, GetProjectMembers.getBranchId(user));
                LinkedHashMap<String, String> avail = new LinkedHashMap<String, String>();
                avail.put("Casual Leave", "Casual");
                avail.put("Sick Leave", "Sick");
                avail.put("Privilege Leave", "Privilege");
                avail.put("Absent", "Absent");
        %>
        <br/>
        <table cellpadding="0" cellspacing="0" width="100%">

            <tr border="2" bgcolor="#c3d9ff">

                <td border="1" align="left" width="100%"><font size="4"
                                                               COLOR="#0000FF"><b> Leave Details</b> </font> <FONT SIZE="3"
                                                                        COLOR="#0000FF"> </FONT></td>

            </tr>

        </table>
        <br/>       
        <table   style=" width: 40%;border-collapse: collapse;border:1px solid black;">
            <tr style="font-weight: bold;border:1px solid black; "><td style="border:1px solid black; ">Leave Type</td><td style="text-align: center;border:1px solid black;">Eligible</td><td style="text-align: center;border:1px solid black;">Availed</td><td style="text-align: center;border:1px solid black;">Balance</td></tr>
            <%for (Map.Entry entry : avail.entrySet()) {%>
            <tr style="border:1px solid black; "> <td style="font-weight: bold;"><%=entry.getValue()%></td>
                <%
                    float total = 8;
                    float availed = 0;
                    if (leaveTypeDetails.get(entry.getKey()) != null) {
                        availed = (Float) leaveTypeDetails.get(entry.getKey());
                    }
                    float balance = total - availed;
                    if (entry.getKey().equals("Absent")) {
                        total = 0;
                        balance = 0;
                    }
                %>
                <td style="text-align: center;border:1px solid black;"><%=total%></td>
                <td style="text-align: center;border:1px solid black;">

                    <%=availed%></td>

                <td style="text-align: center;border:1px solid black;"><%=balance%></td>
            </tr>
            <%}%>


        </table>

        <%}%>

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
            try {
                if (rs != null) {
                    rs.close();
                }
            } catch (Exception ex) {
                logger.error(ex.getMessage());
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
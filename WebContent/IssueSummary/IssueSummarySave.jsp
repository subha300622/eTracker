<html>
    <%
        String logoutcheck = (String) session.getAttribute("Name");
        if (logoutcheck == null) {
    %>
    <jsp:forward page="../SessionExpired.jsp"></jsp:forward>
    <%
        }
    %>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">

    <meta http-equiv="Content-Language" content="en-us">
    <title>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS
        Solution</title>
    <LINK title=STYLE
          href="<%= request.getContextPath()%>/eminentech support files/main_ie.css"
          type=text/css rel=STYLESHEET>
    <style fprolloverstyle>
        A:hover {
            color: #FF0000;
            font-weight: bold
        }
    </style>
</head>
<body bgcolor="#FFFFFF">
    <%@ page language="java"%>
    <script language="JavaScript">
        function printpost(post)
        {
            pp = window.open('profile.jsp?post_id=' + post, 'pp', 'size = maximize,location=no,statusbar=no,menubar=no,scrollbars=no width=900,height=400');
            pp.focus();
        }
        function fun(sqlForm)
        {
            if ((sqlForm.queryname.value) == '')
            {
                alert('Query Name Should not be Blank!!!...');
                document.sqlForm.queryname.value = "";
                sqlForm.queryname.focus();
                return false;
            }
            if ((sqlForm.queryname.value) == 'null')
            {
                alert('Query Name Should not be NULL!!!...');
                document.sqlForm.queryname.value = "";
                sqlForm.queryname.focus();
                return false;
            }
            if ((sqlForm.queryname.value.length) < 1)
            {
                alert('Query Name Length Should be Minimum 2 & Maximum 30 Characters');
                document.sqlForm.queryname.value = "";
                sqlForm.queryname.focus();
                return false;
            }
            if ((sqlForm.queryname.value.length) > 45)
            {
                alert('Query Name Length Should be Minimum 2 & Maximum 30 Characters');
                document.sqlForm.queryname.value = "";
                sqlForm.queryname.focus();
                return false;
            }
            if ((sqlForm.description.value) == '')
            {
                alert('Description Should not be blank!!!...');
                document.sqlForm.description.value = "";
                sqlForm.description.focus();
                return false;
            }
            if ((sqlForm.description.value) == 'null')
            {
                alert('Description Should not be NULL!!!...');
                document.sqlForm.description.value = "";
                sqlForm.description.focus();
                return false;
            }
            if ((sqlForm.description.value.length) > 100)
            {
                alert('Description should be less than 100 chars');
                document.sqlForm.description.value = "";
                sqlForm.description.focus();
                return false;
            }
            return true;
            parent.treeframe.location.reload();
        }
        function setFocus()
        {
            document.sqlForm.queryname.focus();
        }
        window.onload = setFocus;

    </script>
<BODY>
    <%@ include file="../header.jsp"%>
    <table cellpadding="0" cellspacing="0" width="100%" bgcolor="#C3D9FF">
        <tr border="2">
            <td border="1" align="left"><font size="4" COLOR="#0000FF"><b>
                    APM Issues Search Result </b></font> <FONT SIZE="3" COLOR="#0000FF"></FONT></td>


        </tr>
    </table>
    <%
        String query = request.getParameter("querystring");
        String issuedayHistory = request.getParameter("issuedayHistory");
        String query_name = (String) session.getAttribute("query_name");
        String description = (String) session.getAttribute("description");
        String issueRating = request.getParameter("issueRating");
    %>
    <FORM name="sqlForm" action="./uploadsql.jsp" method="post"
          onsubmit="return fun(this)">

        <TABLE bgColor=#E8EEF7 border=0 width="50%" align="center">
            <%
                if (request.getParameter("querystatus") != null) {
            %>
            <tr>
                <td colspan="2"><font face="Tahoma" size="2" color="red">Search
                    Name Already Exists!</font></td>
            </tr>
            <%
                }

                if (request.getParameter("queryname") != null) {
            %>
            <tr>
                <td>Save This Search As:</td>
                <td><input type="text" name="queryname" size="30" maxlength="100"
                           value="<%= request.getParameter("queryname")%>"></td>
            </tr>
            <%
            } else if (query_name != null) {
            %>
            <tr>
                <td>Save This Search As:</td>
                <td><input type="text" name="queryname" size="30" maxlength="100"
                           value="<%=query_name%>"></td>
            </tr>
            <%
            } else {
            %>
            <tr>
                <td>Save This Search As:</td>
                <td><input type="text" name="queryname" size="30" maxlength="100"></td>
            </tr>
            <%
                }
                if (request.getParameter("description") != null) {
            %>
            <tr>
                <td>Enter the Search Description:</td>
                <td><input type="text" name="description" size="30"
                           maxlength="100" value="<%= request.getParameter("description")%>"></td>
            </tr>
            <%

            } else if (description != null) {
            %>
            <tr>
                <td>Enter the Search Description:</td>
                <td><input type="text" name="description" size="30"
                           maxlength="100" value="<%=description%>"></td>
            </tr>
            <%

            } else {
            %>
            <tr>
                <td>Enter the Search Description:</td>
                <td><input type="text" name="description" size="30"
                           maxlength="100"></td>
            </tr>
            <%
                }
            %>

            <%
                String buttonvalue = "Save My Search";
                if (query_name != null) {
                    buttonvalue = "Update My Search";
                }
            %>

            <tr>
                <td><input type="hidden" name="querystring" size="30"
                           maxlength="100" value="<%= query%>"></td>
                <td><input type="hidden" name="issuedayHistory" size="30"
                           maxlength="100" value="<%=issuedayHistory%>"><input type="hidden" name="issuerating" size="30"
                           maxlength="100" value="<%=issueRating%>"></td>
            </tr>
        </TABLE>
        <table width="50%" border="0" bgcolor="#E8EEF7" cellpadding="2"
               align="center">
            <tr>
                <TD>&nbsp;</TD>
                <TD align="center"><INPUT type=submit value="<%=buttonvalue%>"
                                          name=submit>&nbsp;&nbsp;&nbsp;&nbsp;<INPUT type=reset
                                          value=" Reset "></TD>
            </tr>
        </table>
    </FORM>
</body>
</html>
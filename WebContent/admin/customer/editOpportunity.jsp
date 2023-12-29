<%@page import="com.eminentlabs.crm.dto.MailCampaignDetails"%>
<%@ page language="java" contentType="text/html"
         pageEncoding="UTF-8"%>
<%@ page import="com.eminent.util.*,org.apache.log4j.*,java.util.*"%>
<%

    Logger logger = Logger.getLogger("Edit Opportunity");

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
    <script language=javascript	src="<%= request.getContextPath()%>/eminentech support files/simpleUtilities.js"></script>
</head>
<script language=javascript src="<%= request.getContextPath()%>/eminentech support files/datetimepicker.js"></script>
<script language=javascript src="<%= request.getContextPath()%>/javaScript/checkSubmit.js"></script>
<script src="<%= request.getContextPath()%>/javaScript/jquery.js" type="text/javascript" />
<script src="<%= request.getContextPath()%>/javaScript/jquery-1.10.2.js"></script>
<SCRIPT language=JAVASCRIPT type="text/javascript">

    function createRequest() {
        var reqObj = null;
        try {
            reqObj = new ActiveXObject("Msxml2.XMLHTTP");
        }
        catch (err) {
            try {
                reqObj = new ActiveXObject("Microsoft.XMLHTTP");
            }
            catch (err2) {
                try {
                    reqObj = new XMLHttpRequest();
                }
                catch (err3) {
                    reqObj = null;
                }
            }
        }
        return reqObj;
    }

    function moveOpportunity() {
        if (document.theForm.movetoopportunity.checked == true) {
            if (confirm("Do you want to Move Account"))
            {
                xmlhttp = createRequest();
                if (!xmlhttp && typeof XMLHttpRequest != 'undefined') {
                    xmlhttp = new XMLHttpRequest();
                }
                if (xmlhttp != null) {

                    var opportunity = theForm.opportunityname.value;
                    xmlhttp.open("GET", "accountCheck.jsp?name=" + opportunity + "&rand=" + Math.random(1, 10), true);
                    xmlhttp.onreadystatechange = userAlert;
                    xmlhttp.send(null);
                }

            }
            else
            {
                document.theForm.movetoopportunity.checked = false
            }
        }
    }


    function userAlert() {

        if (xmlhttp.readyState == 4) {
            if (xmlhttp.status == 200) {

                var module = xmlhttp.responseText.split(",");
                var flag = module[1];

                if (flag == 'yes') {

                    alert("Selected Opportunity  Name Already Exists in CRM Account");
                    document.theForm.movetoopportunity.checked = false;
                    theForm.opportunityname.focus();
                }
                else {
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
        var pattern = "+- 0123456789."
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
        var pattern = "/\r?\n|\r/abcdefghijklmnopqrstuvwxyz,.?:;[]{}!@#$&*()-_+\ ABCDEFGHIJKLMNOPQRSTUVWXYZ-1234567890/"
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

        if ((theForm.opportunityname.value) == '')
        {
            alert('Please enter the Opportunity Name ');
            document.theForm.opportunityname.value = "";
            theForm.opportunityname.focus();
            return false;
        }
        if (!isPositiveInteger(trim(theForm.opportunityname.value)))
        {
            alert('Please enter the valid Opportunity Name ');
            document.theForm.opportunityname.value = "";
            theForm.opportunityname.focus();
            return false;
        }
        if (document.getElementById('stage').value == '--None--')
        {
            alert("Please select Stage.");
            document.getElementById('stage').focus();
            return false;
        }
        /*	if (document.getElementById('accountname').value == '--Select Account--')
         {
         alert("Please choose a Account Name");
         document.getElementById('accountname').focus();
         return false;
         }
         */
        if ((theForm.probability.value) == '')
        {
            alert('Please enter the Probability ');
            document.theForm.probability.value = "";
            theForm.probability.focus();
            return false;
        }
        if (!isNumber(trim(theForm.probability.value)))
        {
            alert('Please enter the Numerical only in the Probability ');
            document.theForm.probability.value = "";
            theForm.probability.focus();
            return false;
        }
        if (!isNumber(trim(theForm.amount.value)) && (theForm.amount.value) != '')
        {
            alert('Please enter the Numerical only in the amount ');
            document.theForm.amount.value = "";
            theForm.amount.focus();
            return false;
        }
        if (document.getElementById('assignedto').value == '--Select One--')
        {
            alert("Please choose a Assigned to Name");
            document.getElementById('assignedto').focus();
            return false;
        }
        if ((theForm.closedate.value) == '' || (theForm.closedate.value) == 'NA')
        {
            alert('Please enter the Closing Date ');
            document.theForm.closedate.value = "";
            theForm.closedate.focus();
            return false;
        }
        if (!isPositiveInteger(trim(theForm.closedate.value)))
        {
            alert('Please enter the Closing Date ');
            document.theForm.closedate.value = "";
            theForm.closedate.focus();
            return false;
        }
        if (!isPositiveInteger(trim(theForm.nextstep.value)) && (theForm.nextstep.value) != '')
        {
            alert('Please enter the nextstep ');
            document.theForm.nextstep.value = "";
            theForm.nextstep.focus();
            return false;
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
        /** This Loop Checks Whether There Is Any Input Data Present In The Version Info Field */
        //return true;
    }

    /** Function To Set Focus On The Project Name Field In The Form */

    function setFocus() {
        document.theForm.closedate.focus();
    }
    window.onload = setFocus;
    //-->


    function textCounter(field, cntfield, maxlimit)
    {
        if (field.value.length > maxlimit)
        {
            field.value = field.value.substring(0, maxlimit);
            alert('Comments size is exceeding 4000 characters');
        }
        else
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

</SCRIPT>
<body>
    <jsp:include page="/header.jsp" />
    <jsp:useBean id="mcc" class="com.eminentlabs.crm.controller.MailCampaignController" />
    <BR>
    <!-- Table To Display The Formatted String "Add New User" -->
    <table cellpadding="0" cellspacing="0" width="100%">
        <tr border="2" bgcolor="#c3d9ff">
            <td border="1" align="left" width="100%"><font size="4"
                                                           COLOR="#0000FF"><b> Edit Opportunity</b></font> <FONT SIZE="3"
                                                                      COLOR="#0000FF"> </FONT></td>
            <td  align="center" ><font size="5" COLOR="#0000FF"><b><a href="#" id="mailcampaign"> MailCampaign details</a> </b></font> <FONT SIZE="3"
                                                                                                                                                 COLOR="#0000FF"> </FONT></td>
        </tr>
    </table>
    <BR>
    <FORM name=theForm onsubmit="return fun(this)"
          action="<%=request.getContextPath()%>/admin/customer/updateopportunity.jsp"
          method=post onReset="return setFocus()"><%@ page
        import="java.sql.*,pack.eminent.encryption.*,java.text.*"%> <%
            int opportunityid = Integer.parseInt(request.getParameter("opportunityid"));
            Connection connection = null;
            Statement st = null;
            ResultSet rs = null;
            try {
                connection = MakeConnection.getConnection();
                if (connection != null) {
                    st = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                    rs = st.executeQuery("SELECT OPPORTUNITYNAME,TYPE,CLOSE_DATE,STAGE,PROBABILITY,AMOUNT,LEADSOURCE,NEXTSTEP,DESCRIPTION,OPPORTUNITY_OWNER,ASSIGNEDTO,PHONE,WEBSITE from OPPORTUNITY where OPPORTUNITYID=" + opportunityid);
                    if (rs != null) {
                        while (rs.next()) {
                            String opportunityname = rs.getString("OPPORTUNITYNAME");
                            String owner = rs.getString("OPPORTUNITY_OWNER");
                            String typ = rs.getString("TYPE");
                            java.sql.Date closedate = rs.getDate("CLOSE_DATE");
                            String stage = rs.getString("STAGE");
                            String probability = rs.getString("PROBABILITY");
                            String amount = rs.getString("AMOUNT");
                            String leadsourc = rs.getString("LEADSOURCE");
                            String nextstep = rs.getString("NEXTSTEP");
                            String description = rs.getString("DESCRIPTION");
                            int assi = rs.getInt("ASSIGNEDTO");
                            String phone = rs.getString("PHONE");
                            String website = rs.getString("WEBSITE");

                            String type = "NA";
                            if (typ != null) {
                                type = typ;
                            }

                            SimpleDateFormat dfm = new SimpleDateFormat("d-M-yyyy");
                            String dueDate = "NA";
                            if (closedate != null) {
                                dueDate = dfm.format(closedate);
                            }
                            String leadsource = "NA";
                            if (leadsourc != null) {
                                leadsource = leadsourc;
                            }
                            String NextStep = "";
                            if (nextstep != null) {
                                NextStep = nextstep;
                            }
                            String Description = "";
                            if (description != null) {
                                Description = description;
                            }

            %>

            <table width="100%" bgColor=#E8EEF7 border="0" align="center">
                <TBODY>

                    <tr>
                        <td width="20%"><b>Opportunity Name</b><font size="10"
                                                                     COLOR="#FF0000">*</font></td>
                        <td><input type="text" name="opportunityname" maxlength="50"
                                   size=25 value="<%=opportunityname%>"><strong class="style20"></strong></td>
                            <%
                                String[] stageExist = {"--None--", "Prospecting", "Qualification", "Needs Analysis", "Value Proposition",
                                    "Id. Decision makers", "Perception Analysis", "Proposal/Price Quote", "Negotiation/Review", "Perception Analysis", "Closed Won",
                                    "Closed Lost"};
                            %>
                        <td width="20%"><strong>Stage</strong><font size="10" COLOR="#FF0000">*</font></td>
                        <td align="left" width="35%"><SELECT NAME="stage" id="stage" size="1">
                                <%
                                    for (int i = 0; i < stageExist.length; i++) {

                                        if (stage.equals(stageExist[i])) {

                                %>
                                <option value="<%= stage%>" selected><%= stage%></option>
                                <%
                                } else {

                                %>
                                <option value="<%= stageExist[i]%>"><%= stageExist[i]%></option>
                                <%
                                        }
                                    }
                                %>
                            </SELECT></td>
                    </tr>
                    <tr>


                        <td width="20%"><strong>Probability(%)<font size="10" COLOR="#FF0000">*</font></strong></td>
                        <td><input type="text" name="probability" maxlength="3" size=25 value="<%=probability%>"></td>
                        <td width="20%"><strong>Amount</strong></td>
                        <td><input type="text" name="amount" maxlength="11" size=25	value="<%=amount%>"><strong class="style20"></strong></td>

                    </tr>
                    <tr>
                        <%
                            String[] typeExist = {"--None--", "Existing Business", "New Business"};
                        %>
                        <td width="20%"><strong>Type</strong></td>
                        <td align="left" width="35%"><SELECT NAME="type" id="type" size="1">
                                <%
                                    for (int i = 0; i < typeExist.length; i++) {

                                        if (type.equalsIgnoreCase(typeExist[i])) {

                                %>
                                <option value="<%= type%>" selected><%= type%></option>
                                <%
                                } else {

                                %>
                                <option value="<%= typeExist[i]%>"><%= typeExist[i]%></option>
                                <%
                                        }
                                    }
                                %>
                            </SELECT></td>
                        <td width="12%"><strong>Assigned To <font size="10" COLOR="#FF0000">*</font></strong></td>
                        <td width="23%"><select name="assignedto" id="assignedto"size="1">
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

                        <td width="20%"><strong>Closing Date</strong><font size="10" COLOR="#FF0000">*</font></td>
                        <td><input type="text" name="closedate" id="closedate"
                                   readonly="true" maxlength="10" size=12 value="<%=dueDate%>"><a
                                   href="javascript:NewCal('closedate','ddmmyyyy')"> <img
                                    src="images/newhelp.gif" width="16" height="16" border="0"
                                    alt="Pick a date"></a> </td>
                        <td width="20%"><strong>opportunity Owner</strong></td>
                        <td><input type="text" name="opportunityowner" maxlength="30" size=25 value="<%=GetProjectManager.getUserName(Integer.parseInt(owner))%>" readonly=true><strong class="style20"></strong></td>
                    </tr>

                    <tr bgcolor="C3D9FF">
                        <td colspan=2><strong>Additional Information</strong></td>
                        <td><input type="hidden" name="owner"  size=25 value="<%=owner%>"></td>
                        <td><input type="hidden" name="opportunityid" value="<%=opportunityid%>"></td>
                    </tr>

                    <tr>
                        <%
                            String[] leadsourceExist = {"--None--", "Advertisement", "Employee Referrel", "External Referrel", "Partner", "Public Relataion", "Seminar-Internal", "Seminar-Partner", "Trade Show", "Web", "Word of mouth", "Others"};
                        %>
                        <td width="20%"><strong>Lead Source</strong></td>
                        <td align="left"><SELECT NAME="leadsource" size="1">
                                <%
                                    for (int i = 0; i < leadsourceExist.length; i++) {

                                        if (leadsource.equalsIgnoreCase(leadsourceExist[i])) {

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
                            <% if (stage.equalsIgnoreCase("Closed Won")) {%>
                        <td ><strong>Move to Account</strong></td>
                        <td ><input type="checkbox" name="movetoopportunity"	size=20 " value="<%=opportunityid%>" onclick="moveOpportunity();"><strong class="style20"></strong></td>
                            <%}%>
                    </tr>
                    <tr>
                        <td width="20%"><strong>Next Step</strong></td>
                        <td><input type="text" name="nextstep" maxlength="30" size=25
                                   value="<%=NextStep%>"><strong class="style20"></strong></td>
                    </tr>

                    <tr bgcolor="C3D9FF" >
                        <td colspan="4"><strong>Descriptive Information</strong></td>
                    </tr>

                    <tr>
                        <td width="10%"><strong>Description</strong></td>
                        <td colspan=3><%=Description%></td>
                    </tr>

                    <tr height="21">
                        <td width="100%" class="textdisplay" align="left" colspan="4">
                            <p class="textdisplay"><b>Comments</b></p>
                        </td>
                    </tr>
                    <tr height="21">
                        <td width="20%"></td>
                        <td width="60%" align="center" colspan="3"><font size="2"
                                                                         face="Verdana, Arial, Helvetica, sans-serif"> <textarea
                                    rows="3" cols="60" name="comments"
                                    onKeyDown="textCounter(document.theForm.comments, document.theForm.remLen1, 4000)"
                                    onKeyUp="textCounter(document.theForm.comments, document.theForm.remLen1, 4000)"></textarea></font>
                            <input readonly type="text" name="remLen1" size="3"
                                   maxlength="3" value="4000">characters left</td>
                    </tr>
            </table>
            <table width="100%" border="0" bgcolor="#e8eef7" cellpadding="2"
                   align="center">
                <tr align="center">
                    <td></td>
                    <TD colspan="4" align="center"><INPUT type=submit value=Update
                                                          name=submit>
                        <INPUT type=reset value=Reset	name=reset></TD>
                </tr>
                <tr><td><input type="hidden" value="<%=phone%>" name="phone"></td><td><input type="hidden" value="<%=website%>" name="website"></td></tr>
            </table>
            <%
                session.setAttribute("name", opportunityname);
                session.setAttribute("category", "opportunity");

            %> <iframe
                src="./comments.jsp?opportunityId=<%= opportunityid%>"
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
                            mcclist = mcc.allDetails(opportunityid, "Opportunity");
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
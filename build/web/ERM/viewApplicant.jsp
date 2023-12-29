<%@page import="org.apache.log4j.Logger"%>
<%@page import="pack.eminent.encryption.MakeConnection"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.eminentlabs.erm.ERMUtil"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.eminent.util.GetProjectMembers"%>
<%@page import="java.util.Map"%>
<%@page import="com.eminent.issue.controller.ApmComponentIssueController"%>
<%@page import="com.eminent.issue.ApmComponentIssues"%>
<%@page import="java.util.regex.Pattern"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%
    Logger logger = Logger.getLogger("View Issue Details");
    String logoutcheck = (String) session.getAttribute("Name");
    if (logoutcheck == null) {
        logger.fatal("==============Session Expired===============");
%>
<jsp:forward page="SessionExpired.jsp"></jsp:forward>
<%
    }

%>
<HTML>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
    <TITLE>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS Solution</TITLE>
    <LINK title=STYLE href="<%= request.getContextPath()%>/eminentech support files/main_ie.css?test=261020151225" type="text/css" rel="STYLESHEET">
    <script src="<%=request.getContextPath()%>/javaScript/XMLHttpRequest.js" type="text/javascript"></script>
    <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/fileAttach.js"></script>
    <script src="<%=request.getContextPath()%>/javaScript/jquery.js" type="text/javascript"></script>
    <style type="text/css">
        TH {
            font-weight:  bold;
            font-size:  11px;
            background:#000099;
            color:  white;
            font-family:  Arial, Helvetica;
            text-align:  left;
        }
    </style>
    <script type="text/javascript" >
        $(document).ready(function () {

            $('.credit').hide();
        });
        function  openEdit() {
            $('.credit').show();
            $('.crnormal').hide();
        }
        function  openNormal() {
            $('.credit').hide();
            $('.crnormal').show();
        }
        function KillBrowser()
        {
            opener.focus();
            self.close();
        }
    </script>

</HEAD>
<BODY>
    <jsp:useBean id="av" class="com.eminentlabs.erm.ApplicantView"></jsp:useBean>
    <%
        av.viewApplicant(request);
    %>
    <table align="center" width="100%" cellpadding="0" cellspacing="0">
        <tr style="height: 20px;">

            <td width="145" align="left"><a
                    href="https://www.eminentlabs.net" target="_new"><img border="0" height="28"
                                                                     alt="Eminentlabs Software Pvt. Ltd."
                                                                     src="<%=request.getContextPath()%>/eminentech support files/Eminentlabs.png"></a></td>
            <td align="right">
                <img alt="Eminentlabs Software Pvt Ltd" height="25" src="<%= request.getContextPath()%>/eminentech support files/Eminentlabs_logo.gif">
            </td>
        </tr>
    </table>   <br>  
    <table align="center" width="100%" bgcolor="C3D9FF">
        <tr>
            <td><font size="4" COLOR="#0000FF"><b> Detail of applicant -</b> <b><%= av.getApplicantId()%></b></font></td>
        </tr>
    </table>
    <br>


    <table width="100%" bgcolor="E8EEF7">
        <tr height="21">
            <td align="left" width="100%"><b><font color="#0000FF">CITIZEN CHARTER</font></b></td>
        </tr>
    </table>
    <table width="100%" bgcolor="E8EEF7">
        <tr >
            <td ><B>Have you read the book "Governance for Growth in India" by APJ Abdul Kalam?</B> &nbsp;&nbsp;&nbsp;<%=av.getApj()%></td>
        </tr>
        <tr height="21">
            <td ><B>1. How clean, safe, free drinking water can be provided to everyone in India by 2020? Write in detail. </B></td>
        </tr>
        <tr>
            <td colspan="2" style="text-align: justify"><%= av.getWater()%><br></td>
        </tr>
        <tr>
            <td ><B>2. Have you filed any RTI so far ? If so please share details. </B></td>
        </tr>
        <tr>
            <td colspan="2" style="text-align: justify"><%=av.getRti()%><br></td>
        </tr>
        <tr>
            <td ><B>3. How RTE have changed the children educational status in your native or place of birth ? </B></td>
        </tr>
        <tr>
            <td colspan="2" style="text-align: justify"><%= av.getRte()%><br></td>
        </tr>

        <tr >
            <td ><B>4. How many of your family, relatives, friends smoke tobacco products or drink alcohol ? What steps have you taken so far to help them overcome their habits? </B></td>
        </tr>
        <tr>
            <td colspan="2" style="text-align: justify"><%= av.getHabits()%><br></td>
        </tr>
        <tr>
            <td ><B>5. What % of your salary you are planning to dedicate in your work life to the above social cause ? </B></td>
        </tr>
        <tr>
            <td colspan="2" style="text-align: justify"><%= av.getSocial()%><br></td>
        </tr>
    </table>
    <table width="100%" bgcolor="E8EEF7">
        <tr height="21">
            <td align="left" width="100%"><b><font color="#0000FF">User
                        Information </font></b></td>
        </tr>
    </table>
    <table width="100%" bgcolor="E8EEF7">
        <tr height="21">
            <td width="10%"><B>Name </B></td>

            <td width="20%">
                <%=av.getFullName()%></td>		


            <td width="15%"><B>Phone </B></td>
            <td width="20%"><%=av.getPhone()%></td>
            <td width="15%"><B>Mobile </B></td>
            <td width="30%"><%= av.getMobile()%></td>
        </tr>

        <tr height="21">
            <td width="10%"><B>Mail </B></td>

            <td width="20%"><%= av.getMailId()%></td>
            <td width="15%"><B>Current Location </B></td>
            <td width="20%"><%= av.getLocation()%></td>
            <td width="15%"><B>Referred By </B></td>
            <td width="30%"><%=av.getRefBy()%></td>
        </tr>
        <tr height="21">
            <td width="15%"><B>Fake?</B></td>
            <td width="20%"> 
                <%if (av.getIsFake() == 1) {%> Yes<%} else {%>No<%}%>
            </td>
        </tr>
    </table>
    <table width="100%" bgcolor="E8EEF7">
        <tr height="21">
            <td align="left" width="100%"><B><font color="#0000FF">Educational
                        Details </font></B></td>
        </tr>
    </table>
    <table width="100%" bgcolor="E8EEF7">
        <tr height="21">
            <td width="10%"><B>UG Degree </B></td>
            <td width="20%"><%= av.getUg()%></td>
            <td width="15%"><B>UG Branch </B></td>
            <td width="20%"><%= av.getUgBranch()%></td>
            <td width="15%"><B>UG Institute</B></td>
            <td width="30%"><%= av.getUgInstitue()%></td>
        </tr>
        <tr height="21">
            <td width="10%"><B>UG Year </B></td>
            <td width="20%"><%= av.getUgYear()%></td>
            <td width="15%"><B>UG Percentage </B></td>
            <td width="20%"><%= av.getUgPer()%></td>
        </tr>
        <%if (av.getPg() != "") {%>
        <tr height="21">
            <td width="10%"><B>PG Degree </B></td>
            <td width="20%"><%= av.getPg()%></td>
            <td width="15%"><B>PG Branch </B></td>
            <td width="20%"><%= av.getPgBranch()%></td>
            <td width="15%"><B>PG Institute</B></td>
            <td width="30%"><%= av.getPgInstitue()%></td>
        </tr>

        <tr height="21">
            <td width="10%"><B>PG Year </B></td>
            <td width="20%"><%= av.getPgYear()%></td>
            <td width="15%"><B>PG Percentage </B></td>
            <td width="20%"><%= av.getPgPer()%></td>
        </tr>
        <%}%>
    </table>
    <table width="100%" bgcolor="E8EEF7">
        <tr height="21">
            <td align="left" width="100%"><B><font color="#0000FF">Skills
                        and Experience</font></B></td>
        </tr>
    </table>
    <table width="100%" bgcolor="E8EEF7">
        <tr height="21">
            <td width="10%"><B>SAP Exp </B></td>
            <td width="20%"><%=av.getSapExp()%></td>
            <td width="15%"><B>Functional Area </B></td>

            <td width="20%"><%= av.getFunctionalArea() == null ? "" : av.getFunctionalArea()%></td>
            <td width="15%"><B>Total Experience </B></td>

            <td width="30%"><%=av.getTotalExp()%>
            </td>
        </tr>

        <tr height="21">
            <td width="10%"><B>Expertise </B></td>
            <td width="20%"><%= av.getExpertise()%></td>
            <td width="15%"><B>Languages </B></td>

            <td width="20%"><font
                    face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= av.getFullLang()%></font></td>

            <td width="15%"><B>ERP Packages </B></td>
            <td width="30%"><font
                    face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= av.getErpPackages()%></font></td>

        </tr>
        <tr height="21">

            <td width="10%"><B>OS </B></td>

            <td width="20%"><font
                    face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= av.getOs()%></font></td>


            <td width="15%"><B>Database </B></td>

            <td width="20%"><font
                    face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= av.getDataBase()%></font></td>

            <td width="15%"><B>Tools & Utilities </B></td>

            <td width="30%"><font
                    face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= av.getToolsAndUtil()%></font></td>

    </table>
    <table width="100%" bgcolor="E8EEF7">
        <tr height="21">
            <td align="left" width="100%"><B><font color="#0000FF">Previous
                        Experience</font></B></td>
        </tr>
    </table>
    <table width="100%" bgcolor="E8EEF7">
        <tr height="21">

            <td width="10%"><B>Prev Employer </B></td>

            <td width="20%"><%= av.getPrevEmployer()%></td>
            <td width="10%"><B>Prev Designation </B></td>
            <td width="20%"><%= av.getPrevDesignation()%></td>
            <td width="15%"><B>Prev CTC </B></td>
            <td width="20%"><%= av.getPrevCtc()%> &nbsp; LPA in INR</td>
        </tr>
        <tr height="21">
            <td width="10%"><B>Prev. Join Date </B></td>
            <td width="20%"><%= av.getPrevJoinDate()%></td>
            <td width="15%"><B>Prev Relieving Date </B></td>
            <td width="20%"><%= av.getPrevRelDate()%></td>
            <td width="15%"><B>Prev Role </B></td>
            <td width="20%"><%= av.getPrevRole()%></td>

        </tr>

        <tr height="21">
            <td width="10%"><B>Job Profile </B></td>
            <td width="30%" colspan="5"><%= av.getJobProfile()%></td>
        </tr>
    </table>
    <table width="100%" bgcolor="E8EEF7">
        <tr height="21">
            <td align="left" width="100%"><B><font color="#0000FF">Desired
                        Job</font></B></td>
        </tr>
    </table>
    <table width="100%" bgcolor="E8EEF7">
        <tr height="21">
            <td width="10%"><B>Job Type </B></td>

            <td width="20%"><%= av.getJobType()%></td>
            <td width="15%"><B>Desired Position</B></td>
            <td width="20%"><%= av.getDesiredPosition()%></td>
            <td width="15%"><B>Desired Location </B></td>
            <td width="30%"><%= av.getDesiredLocation()%></td>
        </tr>
        <tr style="height:30px;">
            <td width="10%"><b>Status</b></td>
            <td align="left" width="20%">

                <%  if (av.getStatuses().containsKey(av.getStatus())) {%>
                <%=av.getStatuses().get(av.getStatus())%>
                <%}%>

            </td>               
            <td align="left" width="15%"><b>Assigned To</b></td>

            <td  align="left">
                <%if (av.getEminentUsers().containsKey(av.getAssignedTo())) {%>
                <%=av.getEminentUsers().get(av.getAssignedTo())%>
                <% }%>

            </td>

        </tr>     

    </table>

    <%

        Connection connection = null;
        PreparedStatement st = null;
        ResultSet rs = null;
        Map hm = new HashMap<Integer, String>();
        hm = ERMUtil.ermApplicantStatus();

        try {
            connection = MakeConnection.getConnection();
            st = connection.prepareStatement("select commentedby,to_char(COMMENTEDON,'dd-Mon-yyyy') as commentdate,COMMENTEDON,COMMENTS,APPLICANT_STATUS,COMMENTEDTO from erm_applicant_comment where APPLICANTID=? order by COMMENTEDON asc");
            st.setString(1, av.getApplicantId());
            rs = st.executeQuery();

            if (rs.next()) {
    %>
    <table width="100%" class="overflow-y bordertable" id="materialTable" style="border-collapse:collapse;">
        <THEAD>
            <tr>
                <th class="bordertable" align="center">CommentedBy</th>
                <th class="bordertable" align="center">TimeStamp</th>
                <th class="bordertable" align="center">Comments History</th>
                <th class="bordertable" align="center">Status</th>
                <th class="bordertable" align="center">CommentedTo</th>

            </tr>
        </thead>
        <%
            do {

                String commentedby = GetProjectMembers.getUserName(rs.getString("commentedby"));
                commentedby = commentedby.substring(0, commentedby.indexOf(" ") + 2);

                String commentedto = rs.getString("COMMENTEDTO");
                if (!commentedto.equals("Nil")) {
                    commentedto = GetProjectMembers.getUserName(rs.getString("COMMENTEDTO"));
                    commentedto = commentedto.substring(0, commentedto.indexOf(" ") + 2);
                }


        %>
        <tbody><tr>
                <td class="bordertable" align="left" width="12%"><%=commentedby%></td>
                <td class="bordertable" align="left" width="9%"><%= rs.getString("commentdate")%><%=" "%><%= rs.getTime("COMMENTEDON")%></td>
                <td class="bordertable" align="justify" width="42%"><%= rs.getString("COMMENTS")%></td>

                <td class="bordertable" align="left" width="9%"><%= hm.get(rs.getInt("APPLICANT_STATUS"))%></td>
                <td class="bordertable" align="left" width="12%"><%= commentedto%></td>

            </tr>


            <%
                } while (rs.next());
            %>

            <%
            } else {
            %>
            <%
                    }
                } catch (Exception e) {
                    logger.error(e);
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

            <tr align="center" >
                <td colspan="8" style="border: 0px ">
                    <input type="button" id="print" value="Print"
                            />
                    <input type="button"
                           id="Close" value="Close" onclick="javascript:KillBrowser();" /></td>
            </tr>
        </tbody>
    </table>

    <br>
    <br>
    <TABLE bgColor="#C3D9FF" border=0 width="100%">
        <tbody>
            <TR>
                <TD align=center noWrap vAlign=top width="50%" height="150%">
                    <font face="Verdana" size="4" color="#666666">
                        KPI Tracker&#153;, ERPDS&#153;, EWE&#153;, eTracker&#153;, eOutsource&#153;, Rightshore&#153; are registered trademarks of Eminentlabs&#153; Software Private Limited
                    </font>
                </TD>

            </TR>
        </TBODY>
    </TABLE>
</center>
</div>

</BODY>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/component.css?test=1" />

<script src="<%=request.getContextPath()%>/javaScript/jquery.stickyheader.js"></script>
<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery-throttle-debounce/1.1/jquery.ba-throttle-debounce.min.js"></script>

<script type="text/javascript">
  $("#print").click(function () {
                           $("#print").hide();
                           $("#Close").hide();
                           window.print();
                           $("#print").show();
                           $("#Close").show();
                       });</script>
</HTML>

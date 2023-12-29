<%-- 
    Document   : crmSummary
    Created on : 03-Aug-2017, 11:15:49
    Author     : Tamilvelan
--%>
<%@page import="com.eminent.util.GetProjectMembers"%>
<%@page import="java.util.Map"%>
<%@page import="com.eminent.customer.CRMSummaryCount"%>
<%@page import="java.util.HashMap"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page import="org.apache.log4j.*"%>

<%@ page import="com.eminent.customer.ContactUtil"%>





<%
    session.setAttribute("forwardpage", "/MyCRM/crmContactIssues.jsp");
//			response.setHeader("Cache-Control","no-cache");
//			response.setHeader("Cache-Control","no-store");
//			response.setDateHeader("Expires", 0);
//		 	response.setHeader("Pragma","no-cache");

    //Configuring log4j properties
    Logger logger = Logger.getLogger("CRM Summary");

    String logoutcheck = (String) session.getAttribute("Name");
    if (logoutcheck == null) {
        logger.fatal("================Session expired===================");
%>
<jsp:forward page="../SessionExpired.jsp"></jsp:forward>
<%
    }

%>

<HTML>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
    <TITLE>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS
        Solution</TITLE>
    <META NAME="Generator" CONTENT="EditPlus">
    <META NAME="Author" CONTENT="">
    <META NAME="Keywords" CONTENT="">
    <META NAME="Description" CONTENT="">
    <LINK title=STYLE
          href="<%= request.getContextPath()%>/eminentech support files/main_ie.css"
          type=text/css rel=STYLESHEET>
    <script language="JavaScript">

        function check(searchContact) {
            if ((searchContact.contactName.value == null) || (searchContact.contactName.value == ""))
            {
                alert("Please Enter Contact Name ")
                searchContact.contactName.focus()
                return false
            }
            return true
        }
    </script>

</HEAD>

<style fprolloverstyle>
    a {
        text-decoration: none;
    }
    A:hover {
        color: #FF0000;
        font-weight: bold
    }
    .crmsearch{
        cursor: pointer;
        text-decoration: underline;
        text-decoration-color: blue;
    }
</style>
<BODY BGCOLOR="#FFFFFF">

    <%@ include file="../header.jsp"%>


    <table width="100%">
        <tr>
            <td colspan="3">
                <%int roleId = (Integer) session.getAttribute("Role");
                    if (roleId == 1) {
                %>
                <a href="<%=request.getContextPath()%>/admin/customer/crmPerformance.jsp" style="cursor: pointer">CRM Performance Chart</a> &nbsp;&nbsp;&nbsp;&nbsp;              
                <%}%>
                <a href="<%=request.getContextPath()%>/MyCRM/crmSummary.jsp" style="font-weight: bold;cursor: pointer">CRM Summary</a> &nbsp;&nbsp;&nbsp;&nbsp;              
                <a href="<%=request.getContextPath()%>/MyCRM/crmAnalysis.jsp" style="cursor: pointer">CRM Analysis</a> &nbsp;&nbsp;&nbsp;&nbsp;
                                <a href="<%=request.getContextPath()%>/MyCRM/industryMaintenance.jsp" style="cursor: pointer">Industry Maintenance</a> &nbsp;&nbsp;&nbsp;&nbsp;

            </td>
        </tr>
    </table>
    <br>



    <table cellpadding="0" cellspacing="0" width="100%">
        <tr border="2" bgcolor="#E8EEF7">
            <td bgcolor="#E8EEF7" border="1" align="left"><font size="4"
                                                                COLOR="#0000FF"> <b> CRM Summary </b></font><FONT SIZE="3"
                                                                  COLOR="#0000FF"> </FONT></td>

        </tr>
    </table>
    <br>
    <%
        Map<Integer, CRMSummaryCount> crmSummary = ContactUtil.getCRMSummary();
        HashMap<Integer, String> users = GetProjectMembers.showUsers();
    %>
    <!--        </br> </br> </br>     </br>-->

    <div class="tablecontent">
        <table>
            <thead>
                <tr>
                    <TH rowspan="4"><font><b>Name</b></font></TH>
                    <TH colspan="4" style="text-align: center;"><font><b> Contact</b></font></TH>
                    <TH colspan="4" style="text-align: center;"><font><b>Lead</b></font></TH>
                    <TH rowspan="4"><font><b>Opportunity</b></font></TH>
                    <TH rowspan="4"><font><b>Total</b></font></TH>
                </tr>
                <tr >
                    <TH ><font><b>Normal</b></font></TH>
                    <TH><font><b>Influencer  &nbsp;<img src="<%=request.getContextPath()%>/images/star.png"  alt="Influencer"  title="Influencer contact"  style="cursor: pointer;height: 11px;"/></b></font></TH>
                    <TH><font><b>Decision Maker &nbsp;<img src="<%=request.getContextPath()%>/images/hammer.png"  alt="Decision Maker"  title="Decision Maker contact"  style="cursor: pointer;height: 11px;"/> </b></font></TH>
                    <TH><font><b>Total Contact </b></font></TH>
                    <TH ><font><b>Normal</b></font></TH>
                    <TH><font><b>Influencer  &nbsp;<img src="<%=request.getContextPath()%>/images/star.png"  alt="Influencer"  title="Influencer contact"  style="cursor: pointer;height: 11px;"/></b></font></TH>
                    <TH><font><b>Decision Maker &nbsp;<img src="<%=request.getContextPath()%>/images/hammer.png"  alt="Decision Maker"  title="Decision Maker contact"  style="cursor: pointer;height: 11px;"/> </b></font></TH>
                    <TH><font><b>Total Lead </b></font></TH>
                </tr>

            </thead>
            <TBODY>
                <%  int i = 0, contactCount = 0, infontactCount = 0, descontactCount = 0, leadCount = 0, oppCount = 0, infleadCount = 0, desleadCount = 0;
                    for (Map.Entry<Integer, CRMSummaryCount> entry : crmSummary.entrySet()) {
                        contactCount = contactCount + entry.getValue().getContactCount();
                        infontactCount = infontactCount + entry.getValue().getInfContactCount();
                        descontactCount = descontactCount + entry.getValue().getDecsionContactCount();
                        leadCount = leadCount + entry.getValue().getLeadCount();
                        infleadCount = infleadCount + entry.getValue().getInfLeadCount();
                        desleadCount = desleadCount + entry.getValue().getDecsionLeadCount();

                        oppCount = oppCount + entry.getValue().getOppCount();
                        if ((i % 2) != 0) {
                %>
                <tr bgcolor="#E8EEF7" height="22">
                    <%
                    } else {
                    %>
                <tr bgcolor="white" height="22">
                    <%
                        }%>

                    <td><%=users.get(entry.getKey())%></td>
                    <td style="text-align: right;"><span class="crmsearch" userid="<%=entry.getKey()%>" heading="contact" contactType="Normal" ><%=entry.getValue().getContactCount()%></SPAN></td>
                    <td style="text-align: right;"><span class="crmsearch" userid="<%=entry.getKey()%>" heading="contact" contactType="Influencer" ><%=entry.getValue().getInfContactCount()%></SPAN></td>
                    <td style="text-align: right;"><span class="crmsearch" userid="<%=entry.getKey()%>" heading="contact" contactType="Decision Maker" ><%=entry.getValue().getDecsionContactCount()%></SPAN></td>
                    <td style="text-align: right;"><span class="crmsearch" userid="<%=entry.getKey()%>" heading="contact" contactType="" ><%=entry.getValue().getContactCount() + entry.getValue().getInfContactCount() + entry.getValue().getDecsionContactCount()%></SPAN></td>
                    <td style="text-align: right;"><span class="crmsearch" userid="<%=entry.getKey()%>" heading="lead" contactType="Normal" ><%=entry.getValue().getLeadCount()%></SPAN></td>
                    <td style="text-align: right;"><span class="crmsearch" userid="<%=entry.getKey()%>" heading="lead" contactType="Influencer" ><%=entry.getValue().getInfLeadCount()%></SPAN></td>
                    <td style="text-align: right;"><span class="crmsearch" userid="<%=entry.getKey()%>" heading="lead" contactType="Decision Maker" ><%=entry.getValue().getDecsionLeadCount()%></td>
                    <td style="text-align: right;"><span class="crmsearch" userid="<%=entry.getKey()%>" heading="lead" contactType="" ><%=entry.getValue().getLeadCount() + entry.getValue().getInfLeadCount() + entry.getValue().getDecsionLeadCount()%></SPAN></td>
                    <td style="text-align: right;"><span class="crmsearch" userid="<%=entry.getKey()%>" heading="opportunity" contactType="" ><%=entry.getValue().getOppCount()%></SPAN></td>
                    <td style="text-align: right;"><%=entry.getValue().getContactCount() + entry.getValue().getInfContactCount() + entry.getValue().getDecsionContactCount() + entry.getValue().getLeadCount() + entry.getValue().getOppCount() + entry.getValue().getInfLeadCount() + entry.getValue().getDecsionLeadCount()%></td>
                </tr>
                <%i++;
                    }%>
            </TBODY>
            <TFOOT>
                <tr style="background-color: yellow;font-weight: bold;">
                    <td style="text-align: right;">Total</td>
                    <td style="text-align: right;"><span class="crmsearch" userid="" heading="contact" contactType="Normal" ><%=contactCount%></SPAN></td>
                    <td style="text-align: right;"><span class="crmsearch" userid="" heading="contact" contactType="Influencer" ><%=infontactCount%></SPAN></td>
                    <td style="text-align: right;"><span class="crmsearch" userid="" heading="contact" contactType="Decision Maker" ><%=descontactCount%></SPAN></td>
                    <td style="text-align: right;"><span class="crmsearch" userid="" heading="contact" contactType="" ><%=contactCount + infontactCount + descontactCount%></SPAN></td>
                    <td style="text-align: right;"><span class="crmsearch" userid="" heading="lead" contactType="Normal" ><%=leadCount%></SPAN></td>
                    <td style="text-align: right;"><span class="crmsearch" userid="" heading="lead" contactType="Influencer" ><%=infleadCount%></SPAN></td>
                    <td style="text-align: right;"><span class="crmsearch" userid="" heading="lead" contactType="Decision Maker" ><%=desleadCount%></SPAN></td>
                    <td style="text-align: right;"><span class="crmsearch" userid="" heading="lead" contactType="" ><%=leadCount + infleadCount + desleadCount%></SPAN></td>
                    <td style="text-align: right;"><span class="crmsearch" userid="" heading="opportunity" contactType="" ><%=oppCount%></SPAN></td>
                    <td style="text-align: right;"><%=contactCount + infontactCount + descontactCount + leadCount + infleadCount + desleadCount + oppCount%></td>
                </tr>
            </TFOOT>
        </table>
        </br>
        </br>
        <table border="3" >
            <tr>
                <td>
                    <table >
                        <thead><th colspan="2">Date and Day</th><th colspan="2" align="center">South Region</th><th colspan="2" align="center">North Region</th></thead>
                        <thead>
                        <TH><font><b>Date</b></font></TH>
                        <TH><font><b>Day</b></font></TH>
                        <TH><font><b>First Half</b></font></TH>
                        <TH><font><b>Second Half</b></font></TH>
                        <TH><font><b>First Half</b></font></TH>
                        <TH><font><b>Second Half</b></font></TH>
                        </thead>
                        <%
                            try {
                                String meeting[][] = ContactUtil.getMeetingSummary();
                                for (int k = 0; k < meeting.length; k++) {
                                    if ((k % 2) != 0) {
                        %>
                        <tr bgcolor="#E8EEF7" height="22">
                            <%
                            } else {
                            %>

                        <tr bgcolor="white" height="22">
                            <%
                                }

                                for (int j = 0; j < 6; j++) {
                            %>        
                            <td <%if (j == 0) {%>width="75px"<%}%>><%=meeting[k][j]%></td>
                            <%
                                }
                            %>
                        </tr>
                        <%
                            }
                        %>
                    </table>
                </td>


                <%
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                %>

            </tr>
        </table>


    </div>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>

    <script>
        $(document).on('click', '.crmsearch', function () {
            var crmType = $.trim($(this).attr('heading'));
            var assignedTo = $.trim($(this).attr('userid'));
            var contactType = $.trim($(this).attr('contactType'));
            window.open("<%=request.getContextPath()%>/MyCRM/crmSearchResults.jsp?crmType=" + crmType + "&assignedTo=" + assignedTo + "&contactType=" + contactType + "");
        });
    </script>


</BODY>
</HTML>


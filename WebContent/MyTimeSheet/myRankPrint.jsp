<%-- 
    Document   : myRankPrint
    Created on : Jun 2, 2014, 10:43:42 AM
    Author     : E0288
--%>


<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="com.eminent.issue.formbean.IssueFormBean"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
	String logoutcheck=(String)session.getAttribute("Name");
	if(logoutcheck==null)
	{
		%>
<jsp:forward page="../SessionExpired.jsp"></jsp:forward>
<%

	}
%>
<html>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS Solution</title>
        <LINK title=STYLE href="<%= request.getContextPath()%>/eminentech support files/main_ie.css" type="text/css" rel="STYLESHEET">
        <script type="text/javascript">
            function callPrint(){       
            document.getElementById("print").style.display='none';
            window.print();
    }
        </script>
        <style type="text/css">
            .mom table
            {
                border-collapse:collapse;
            }
            .mom table, .mom td, .mom th 
            {
                border:1px solid black;
            }
        </style>
    </head>
    <body>
        <jsp:useBean id="tcir" class="com.eminent.issue.TeamClosedIssueReport"></jsp:useBean>
        <%tcir.setAll(request);%>
        <div style="text-align: center;">
            <center>
        <table align="center" width="70%" cellpadding="0" cellspacing="0">
                        <tr style="height: 20px;">

                            <td width="145" align="left"><a
                                    href="https://www.eminentlabs.net" target="_new"><img border="0" height="28"
                                                                                     alt="Eminentlabs Software Pvt. Ltd."
                                                                                     src="<%=request.getContextPath()%>/eminentech support files/Eminentlabs.png"></a></td>
                            <td align="right">
                                <img alt="Eminentlabs Software Pvt Ltd" height="25" src="<%= request.getContextPath()%>/eminentech support files/Eminentlabs_logo.gif">
                            </td>
                        </tr>
                    </table>
        <br/>
        <table  style="width: 70%;"><tr><td style="width: 55%;">The below list shows closed issues for <b><%=tcir.getMonths().get(tcir.getMonth())%>-<%=tcir.getYear()%></b></td><td id="print"><input type="button" name="print" value="Print"
                                                   onclick="javascript:callPrint()" /><input type="button"
                                                   name="Close" value="Close" onclick="javascript:window.close();" /></td><td style="text-align: right;color: #CC00CC;font-weight: bold;">** PM's are in Pink color</td></tr></table>
        <br/>
        <table class="mom" style="width: 70%;height:25px;text-align: left;font-weight: bold;border-collapse:collapse;"><tr style="background-color: #C3D9FF;"><td class="mom" style="width:40%;text-align: center;">Name</td><td class="mom" style="width:20%;text-align: center;"> Closed Count(Excellent Rating) </td><td class="mom" style="width:10%;text-align: center;">Rank</td></tr></table>
        <%
            int j = 0;
            int closedSize = -1;
            int rank=0;

            for (Map.Entry<Integer, List<IssueFormBean>> entry : tcir.getTeamClosedIssues().entrySet()) {
               String color="black";
                if(tcir.getPmanagers().contains(entry.getKey())){
                   color="#CC00CC";
               }
                j++;
                if (closedSize == -1) {
                    closedSize = entry.getValue().size();
                    rank=j;
                }else if(closedSize==entry.getValue().size()){
                    
                }else{
                    rank=j;
                }
%>
                <table class="mom" style="width: 70%;height:25px;text-align: left;font-weight: bold;border-collapse:collapse;"><tr ><td class="mom" style="width:40%;color: <%=color%>;"><%=tcir.getMember().get(entry.getKey())%></td><td class="mom" style="width: 20%;text-align: center;"><%=entry.getValue().size()%>(<%=tcir.getRatingwise().get(entry.getKey())==null?"0":tcir.getRatingwise().get(entry.getKey())%>)</td><td class="mom" style="width: 10%;text-align: center;"><%=rank%></td></tr></table>
                    

        
        <%closedSize = entry.getValue().size();}%>
        <br/>
         <br/>
                    <TABLE bgColor="#C3D9FF" border=0 width="70%">
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
    </body>
</html>


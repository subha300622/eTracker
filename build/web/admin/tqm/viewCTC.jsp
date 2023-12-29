<%-- 
    Document   : viewCTC
    Created on : 9 Mar, 2010, 11:14:28 AM
    Author     : Tamilvelan
--%>
<%@page  import="java.text.SimpleDateFormat,com.eminent.tqm.TqmUtil, com.eminent.tqm.TqmCtcm, com.eminent.util.GetProjectManager,com.eminent.util.GetProjects,java.util.*,org.apache.log4j.*"%>
<%

//	response.setHeader("Cache-Control","no-cache");
//	response.setHeader("Cache-Control","no-store");
//	response.setDateHeader("Expires", 0);
// 	response.setHeader("Pragma","no-cache");


	//Configuring log4j properties



	Logger logger = Logger.getLogger("View CTC");
	


	String logoutcheck=(String)session.getAttribute("Name");
	if(logoutcheck==null)
	{
		logger.fatal("=========================Session Expired======================");
		%>
<jsp:forward page="../SessionExpired.jsp"></jsp:forward>
<%
		//response.sendRedirect(request.getContextPath()+"/SessionExpired.jsp");
	}

%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="/header.jsp"%>
<html>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
        <meta http-equiv="Content-Type" content="text/html">
         <title>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS Solution</title>
        <LINK title=STYLE  href="<%= request.getContextPath() %>/eminentech support files/main_ie.css" type="text/css" rel="STYLESHEET">
         <script language=javascript src="<%= request.getContextPath() %>/javaScript/XMLHttpRequest.js"></script>
       <script type="text/javascript" language="JavaScript">
           function moveToCtcm()
{
    if(document.getElementById("move").checked==true){
        if (confirm("Do you want move this test case to PTCM"))
        {
            xmlhttp = createRequest();
            if (!xmlhttp && typeof XMLHttpRequest!='undefined') {
                xmlhttp = new XMLHttpRequest();
            }
            if(xmlhttp != null) {

                var ctcid=document.getElementById("move").value;
                xmlhttp.open("GET","moveCtcm.jsp?ctcid="+ctcid+"&rand="+Math.random(1,10), true);
                xmlhttp.onreadystatechange = userAlert;
                xmlhttp.send(null);
            }

        }

    }
}
function userAlert() {

        if (xmlhttp.readyState == 4) {
            if (xmlhttp.status == 200) {

            var module = xmlhttp.responseText.split(",");
            var flag = module[1];

            if(flag == 'yes'){

                alert("Selected Test case moved to CTCM");

            }
            else{
               alert("There is a problem in moving CTCM to PTCM");
            }
             var table = document.getElementById("ctc");
                table.deleteRow(5);
      	}
	}
}
       </script>
    </head>
    <body>
        <table width="100%">
            <tr bgcolor="#C3D9FF" width="100%">
                <td width="100%"> <b>Test Case Details</b></td>
                            </tr>
        </table>
        <br>
        <br>

       <%
                String ctcID=request.getParameter("ctcID");
                TqmCtcm ctc=TqmUtil.viewCTC(ctcID);
                try{
                    if(ctc!=null){
                        String functionality    =   ctc.getFunctionality();
                        String ctcId            =   ctc.getPtcid();
                        String desc             =   ctc.getDescription();
                        String expected         =   ctc.getExpectedresult();
                        String createdBy        =   GetProjectManager.getUserName(ctc.getCreatedby());
                        String approvedBy        =   GetProjectManager.getUserName(ctc.getApprovedby());


                         int role	= (Integer)session.getAttribute("Role");
                        %>
                        <table width="100%" id="ctc">

                            <tr  bgcolor="#E8EEF7">
                                <td width="15%"><b>Test Case ID</b></td><td><%=ctcId%></td>   <td  width="15%"><b>Created By</b></td><td><%=createdBy%></td>
                                <td width="15%"><b>Approved By</b></td><td><%=approvedBy%></td>
                            </tr>
                             <tr>
                                
                            </tr>
                            <tr>
                                <td><b>Functionality</b></td><td colspan="5"><%=functionality%></td>
                            </tr>
                            <tr  bgcolor="#E8EEF7">
                                <td><b>Description</b></td><td colspan="5"><%=desc%></td>
                            </tr>
                            <tr >
                                <td><b>Expected Result</b></td><td colspan="5"><%=expected%></td>
                            </tr>
                            <!--
                            <%if(role==1&&TqmUtil.isPtcExist(ctcID)){
                            %>
                            <tr id="moverow">
                                <td><b>Move to PTCM</b></td><td><input type="checkbox" name="move" id="move" value="<%=ctcId%>" onClick="moveToPtcm();"></td>

                            </tr>
                            -->
                            <%
                            }

                            %>
                        </table>
                        <%
                    }
                    else{
                         %>
            <br>
            <br>
            <br>
            <table align="center">
            <tr>
                <td width="100%"><b style="color:red">Test Case not available.</b></td>
            </tr>
            </table>
            <%
                    }
                }
                catch(Exception e){
                    logger.error(e.getMessage());
                }
        %>
    </body>
</html>

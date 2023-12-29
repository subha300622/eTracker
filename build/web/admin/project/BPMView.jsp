<%-- 
    Document   : BPMView
    Created on : 18 Oct, 2011, 8:38:26 PM
    Author     : Tamilvelan
--%>

<%@page import="org.apache.log4j.Logger,com.eminent.examples.ShowBPM" %>
<%@page import="com.eminent.examples.ViewBPM" %>
<%@page import="java.util.HashMap" %>
<%@page import="java.util.ArrayList" %>
<%@page import="java.util.Collection" %>
<%@page import="java.util.Iterator" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<%


	
	Logger logger = Logger.getLogger("ViewProject");
	
	String logoutcheck=(String)session.getAttribute("Name");
	if(logoutcheck==null)
	{
		logger.fatal("=========================Session Expired======================");
	%>
<jsp:forward page="/SessionExpired.jsp"></jsp:forward>
<%
	}
%>
<html>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
        <meta http-equiv="Content-Type" content="text/html">
        <LINK title=STYLE href="<%= request.getContextPath() %>/eminentech support files/main_ie.css" type="text/css" rel=STYLESHEET>
        <link rel="stylesheet" href="<%=request.getContextPath()%>/css/jquery.treeview.css" />
        <link rel="stylesheet" href="<%=request.getContextPath()%>/css/screen.css" />
        <script src="<%=request.getContextPath()%>/javaScript/jquery.js" type="text/javascript"></script>
        <script src="<%=request.getContextPath()%>/javaScript/jquery.cookie.js" type="text/javascript"></script>
        <script src="<%=request.getContextPath()%>/javaScript/jquery.treeview.js" type="text/javascript"></script>
<script type="text/javascript">
        $(document).ready(function(){

            $("#halfView").hide();

            $("#halfView").click(function(){

                $("#halfView").hide();
                $("#fullView").show();
               
            });
            $("#fullView").click(function(){

                $("#fullView").hide();
                $("#halfView").show();
               
            });

        });
    </script>
<script type="text/javascript">
		$(function() {
			$("#tree").treeview({
				collapsed: true,
				animated: "medium",
				control:"#sidetreecontrol",
				persist: "location"
			});
		})

	</script>
    </head>
    <body>
        <%@ include file="/header.jsp"%>

<table cellpadding="0" cellspacing="0" width="100%" bgColor="#C3D9FF">
	<tr >
		<td border="1" align="left" width="100%">
                    <font size="4" COLOR="#0000FF"><b>View Test Map</b></font>
                </td>
	</tr>
</table>

<div id="main">

<div id="sidetree">
<div class="treeheader">&nbsp;</div>
<div id="sidetreecontrol"><a href="?#" id="halfView" >Collapse All</a>  <a id="fullView" href="?#">Expand All</a></div>

<ul id="tree">
	

<%
   
    ArrayList<String> viewClient =ViewBPM.getClient();
    for( String clientName : viewClient) {
%>
        <li><b>Client:</b>
            <%=clientName%>
            <%
                 ArrayList<String> viewCompany =ViewBPM.getCompany(clientName);
                 if(viewCompany.size()>0){
                 %>
                 <ul>
                     <%
                        for( String company : viewCompany) {
                            %>
                            <li><b>Company:</b>
            <%=company%>
                    <%
                         ArrayList<String> businessProcess =ViewBPM.getBP(company);
                         if(viewCompany.size()>0){
                         %>
                         <ul>
                             <%
                                for( String bp : businessProcess) {
                                    %>
                                                <li><b>Business Process:</b>
                                    <%=bp%>
                                            <%
                                                 ArrayList<String> mainProcess =ViewBPM.getMainProcess(bp);
                                                 if(mainProcess.size()>0){
                                                 %>
                                                 <ul>
                                                     <%
                                                        for( String mp : mainProcess) {
                                                                        %>
                                                                        <li><b>Main Process:</b>
                                                                <%=mp%>
                                                        <%
                                                             ArrayList<String> subProcess =ViewBPM.getSubProcess(mp);
                                                             if(subProcess.size()>0){
                                                             %>
                                                             <ul>
                                                                 <%
                                                                    for( String sp : subProcess) {

                                                                            %>
                                                                            <li><b>Sub Process:</b>
                                                                                <%=sp%>
                                                                        <%
                                                                             ArrayList<String> scenario =ViewBPM.getScenario(sp);
                                                                             if(scenario.size()>0){
                                                                             %>
                                                                             <ul>
                                                                                 <%
                                                                                    for( String sc : scenario) {
                                                                                        %>
                                                                                        <li><b>Scenario:</b>
                                                                                                    <%=sc%>
                                                                                            <%
                                                                                                ArrayList<String> variant =ViewBPM.getVariant(sc);
                                                                                                 if(variant.size()>0){
                                                                                                
                                                                                                 %>
                                                                                                 <ul>
                                                                                                     <%
                                                                                                      for( String vt : variant) {
                                                                                                       
                                                                                                                    %>
                                                                                                                <li><b>Variant: </b>
                                                                                                                    <%=vt%>
                                                                                                            <%
                                                                                                                  ArrayList<String> testcase =ViewBPM.getTestcase(vt);
                                                                                                                 if(testcase.size()>0){
                                                                                                                 %>
                                                                                                                 <ul>
                                                                                                                     <%
                                                                                                                        for( String tc : testcase) {

                                                                                                                             %>
                                                                                                                                <li><b>Test Case:</b>
                                                                                                                                    <%=tc%>
                                                                                                                                     <%
                                                                                                                                ArrayList<String> testscript =ViewBPM.getTestScript(tc);
                                                                                                                             if(testscript.size()>0){
                                                                                                                             %>
                                                                                                                             <ul>
                                                                                                                                 <li>
                                                                                                                                     <table style="border:solid 1px #696969">
                                                                                                                                          <tr style="background-color: #C3D9FF;">
                                                                                                                                              <td><b>Seq #</b></td>
                                                                                                                                              <td><b>Test Step</b></td>
                                                                                                                                              <td><b>Test Script</b></td>
                                                                                                                                              <td><b>Expected Result</b></td>
                                                                                                                                              <td><b>Department User</b></td>
                                                                                                                                          </tr>
                                                                                                                                 <%
                                                                                                                                    int row    =   testscript.size()/5;
                                                                                                                                    int k=0;
                                                                                                                                    String color    ="white";
                                                                                                                                    for(int i=0;i<row;i++){
                                                                                                                                          if(( i % 2 ) != 0)
                                                                                                                                            {
                                                                                                                                                color="#E8EEF7";
                                                                                                                                            }
                                                                                                                                            else
                                                                                                                                            {

                                                                                                                                                color    ="white";

                                                                                                                                            }
                                                                                                                                                    

                                                                                                                                         %>
                                                                                                                                            
                                                                                                                                              
                                                                                                                                                   <tr bgcolor="<%=color%>">
                                                                                                                                                       <td><%=testscript.get(k)%></td>
                                                                                                                                                       <td><%=testscript.get(k+1)%></td>
                                                                                                                                                       <td><%=testscript.get(k+2)%></td>
                                                                                                                                                       <td><%=testscript.get(k+3)%></td>
                                                                                                                                                       <td><%=testscript.get(k+4)%></td>
                                                                                                                                                   </tr>
                                                                                                                                              

                                                                                                                                   
                                                                                                                                        <%
                                                                                                                                         k=k+5;
                                                                                                                                    }
                                                                                                                                   %>
                                                                                                                                    </table>
                                                                                                                             </li>
                                                                                                                             </ul>
                                                                                                                             <%
                                                                                                                             }
                                                                                                                        %>
                                                                                                                            
                                                                                                                        </li>
                                                                                                                            <%

                                                                                                                        }
                                                                                                                       %>
                                                                                                                 </ul>
                                                                                                                 <%
                                                                                                                 }
                                                                                                            %>
                                                                                                        </li>
                                                                                                            <%

                                                                                                        }
                                                                                                       %>
                                                                                                 </ul>
                                                                                                 <%
                                                                                                 }
                                                                                            %>
                                                                                        </li>
                                                    <%

                                                                                    }
                                                                                   %>
                                                                             </ul>
                                                                             <%
                                                                             }
                                                                        %>
                                                                    </li>
                                <%

                                                                    }
                                                                   %>
                                                             </ul>
                                                             <%
                                                             }
                                                        %>
                                                    </li>
                                            <%
                                                        }
                                                       %>
                                                 </ul>
                                                 <%
                                                 }
                                            %>
                                        </li>
                                <%
                                }
                               %>
                         </ul>
                         <%
                         }
                    %>
                </li>
        <%
                        }
                       %>
                 </ul>
                 <%
                 }
            %>
        </li>
<%
    }
    
    
%>
</ul>

</div>

</div>

    </body>
</html>

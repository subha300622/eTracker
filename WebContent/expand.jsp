<%-- 
    Document   : testMap
    Created on : 22 Oct, 2011, 10:44:43 PM
    Author     : Tamilvelan
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.eminent.util.GetProjectManager"%>
<%@page import="com.eminent.tqm.TqmTestcaseexecutionresult"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="com.eminent.tqm.TqmTestcaseresult"%>
<%@page import="com.eminent.tqm.TestCasePlan"%>
<%@page import="java.util.List"%>
<%@page import="org.apache.log4j.*,com.eminent.util.GetProjects,com.eminent.util.GetProjectMembers" %>
<%@page import="com.eminentlabs.userBPM.ViewBPM" %>
<%@page import="java.util.HashMap" %>
<%@page import="java.util.LinkedHashMap" %>
<%@page import="java.util.ArrayList" %>
<%@page import="java.util.Collection" %>
<%@page import="java.util.Iterator,dashboard.CheckCategory,dashboard.TestCases" %>


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
        <meta content="IE=EmulateIE8" http-equiv="X-UA-Compatible" >
        <title>eTracker&#0153; - Eminentlabs&#0153; CRM, BPM, APM, TQM, ERM and EPTS Solution</title>
       <LINK title=STYLE href="<%= request.getContextPath() %>/eminentech support files/main_ie.css" type="text/css" rel=STYLESHEET>
       <script src="<%=request.getContextPath()%>/javaScript/XMLHttpRequest.js" type="text/javascript"></script>
       <script src="<%=request.getContextPath()%>/javaScript/jquery.js" type="text/javascript"></script>
       <script src="<%=request.getContextPath()%>/javaScript/bp.js" type="text/javascript"></script>
       <script type="text/javascript" src="<%= request.getContextPath() %>/ckeditor_4.5.9_standard/ckeditor/ckeditor.js"></script>
       <style type="text/css">
           ul{list-style: none outside none;padding: 0;	margin: 0;margin-top: 4px;background-color: white;}
           ul li{padding: 3px 0px 3px 16px;margin: 0;}
           a{text-decoration: none;color: black;}
 
       </style>
       
                
    </head>
    <%
                String pid = request.getParameter("pid");
                String project  =   GetProjects.getProjectName(pid);
                String category  ="NA";
               if(project!=null){
                category = CheckCategory.getCategory(project);
               }
                String cases[][]     =   TestCases.showTestCases(pid);
                int noOfTestcases    =   cases.length;
               logger.info("Category :" +category);
               session.setAttribute("testMapPid", pid);
       
%>
    <body>
                <%@ include file="/header.jsp"%>
<table cellpadding="0" cellspacing="0" width="100%" bgColor="#C3D9FF">
	<tr >
		<td border="1" align="left" width="100%">
                    <font size="4" COLOR="#0000FF"><b>View <%=GetProjects.getProject(Integer.parseInt(pid))%> Test Map Tree</b></font>
                </td>
	</tr>
</table>
<table>
    <tr>
        <td>
            <a href="<%=request.getContextPath()%>/UserBPM/dashboardForCompany.jsp?pid=<%=pid%>">Test Map Dashboard View</a>&nbsp;&nbsp;&nbsp;
            <% if(category.equalsIgnoreCase("SAP Project")){
    %>
                <a href="<%=request.getContextPath()%>/admin/dashboard/projectChart.jsp?project=<%=project%>">Status-wise Dashboard</a>&nbsp;&nbsp;&nbsp;
<!--                <a href="<%=request.getContextPath()%>/UserBPM/dashboardForCompany.jsp?pid=<%=pid%>">View Test Map Dashboard</a>&nbsp;&nbsp;&nbsp;-->
    <%
    }
       %>
       <a href="<%=request.getContextPath()%>/admin/dashboard/modulewiseChart.jsp?project=<%=project%>">Module-wise Dashboard</a>&nbsp;&nbsp;&nbsp;
            
            <%
 if(noOfTestcases>0){
%>
                <a href="<%=request.getContextPath()%>/admin/dashboard/TestCasesChart.jsp?project=<%=pid%>">View Test Coverage</a>&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/UserProject/listProjectTestPlan.jsp?pid=<%=pid%>">View Test Plans</a>&nbsp;&nbsp;&nbsp;
                <%}%>
                <a href="<%=request.getContextPath()%>/admin/dashboard/projectPerformanceChart.jsp?pid=<%=pid%>">View Project Performance</a>&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/admin/dashboard/openIssueByProject.jsp?pid=<%=pid%>">View Issues</a>&nbsp;&nbsp;&nbsp;
        </td>
    </tr>
</table>
        <div  style="text-align: right;">
            <a  href="expand.jsp?pid=<%=pid%>" >Expand All</a>&nbsp;&nbsp;&nbsp;
            <a  href="testMap.jsp?pid=<%=pid%>" >Collapse All</a>&nbsp;&nbsp;&nbsp;
        </div>
                       <div id='divLoading' >
        <div class="loading" align="center" id="divImageLoader">
            <img src="/eTracker/images/file-progress.gif" alt="Loading..."/>  Loading ...
        </div>
    </div>
                <div>
                    <input type="hidden" value="<%=pid%>" id="pid"/>
                    <ul id="mainTree">
                <%

    ArrayList<String> viewClient =  ViewBPM.getClient(Integer.parseInt(pid));
    HashMap modules              =  GetProjects.getModules(pid);
    int companyCount             =  ViewBPM.getCompanyCount(Integer.parseInt(pid));
    for( String clientName : viewClient) {
%>
<li id="client">
    <div class="treeclass" onclick="javascript:viewCompany(<%=pid%>);"></div>
    <a href="#" onclick="javascript:viewCompany(<%=pid%>);"><b>Client: </b><%=clientName%> (<span id="ccount"><%=companyCount%></span>)</a>
    <span style='display:none;' onclick="javascript:editCompany(<%=pid%>);"><img style="position: realtive;"src="<%=request.getContextPath()%>/images/edit.png"/></span>
</li>
</ul></div>
<%}%>

       <!-- Page overlay and pop-ups must be outside the container div to avoid them being constrained by the container -->
		<div id="overlay"></div>
		<div id="comppopup" class="popup">
                    <h3 class="popupHeading">Add Company</h3>
			<div>
                            <div style="color:red;display: none;" id="errormsg">Please enter the correct company name</div>
				<p>Enter New Company Name/Code</p>
				<hr />
				<!-- Update form action -->
				
                                    <table>
                                        <tr style="height:50px;">
                                            <td>
                                                <label for="pswd">Company Name</label>
                                            </td>
                                            <td colspan="2">
                                                <input type="text" name="comp" id='comp'/>
                                            </td>
                                    </tr>
                                    <tr>
                                        <td colspan="3" align="right">
                                            <input type="hidden" name="pId" id='pId' />

                                        <input type="submit" value="Create Company" onclick='return createCompany(this)'/>
                     
                                        <input type="button" value="Cancel" onclick="javascript:closeCompany();"  />
                                        </td>
                                    </tr>
                                    </table>
			
			</div>
		</div>
                <div id="compEditpopup" class="popup">
                    <h3 class="popupHeading">Edit Company</h3>
			<div>
                            <div style="color:red;display: none;" id="editcerrormsg">Please enter the correct company name</div>
				<p>Edit Company Name/Code</p>
				<hr />
				<!-- Update form action -->
				
                                    <table>
                                        <tr style="height:50px;">
                                            <td>
                                                <label for="pswd">Company Name</label>
                                            </td>
                                            <td colspan="2">
                                                <input type="text" name="editcname" id='editcname'/>
                                            </td>
                                    </tr>
                                    <tr>
                                        <td colspan="3" align="right">
                                            <input type="hidden" name="editcid" id='editcid' />

                                        <input type="submit" value="Update Company" onclick='return updateCompany(this)'/>
                     
                                        <input type="button" value="Cancel" onclick="javascript:closeEditCompany();"  />
                                        </td>
                                    </tr>
                                    </table>
			
			</div>
		</div>
                <div id="BPpopup" class="popup">
			<h3 class="popupHeading">Add Business Process</h3>
			<div>
                            <div style="color:red;display: none;" id="bperrormsg">Please enter the correct BP name</div>
				<p>Enter New Business Process</p>
				<hr />
				<!-- Update form action -->

                                  <table>
                                        <tr style="height:50px;">
                                            <td>
                                                <label for="pswd">Busniess Process</label>
                                            </td>
                                            <td>
                                                <input type="text" name="bp" id='bp'/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2" align="right">
                                            <input type="hidden" name="compid" id='compid'/>
                                            <input type="submit" value="Create BP" onclick="javascript:createBP();"/>
                                            <input type="button" value="Cancel" onclick="javascript:closeBP();"/>
                                            </td>
                                        </tr>
                                  </table>

			</div>
		</div>
                 <div id="BPEditpopup" class="popup">
			<h3 class="popupHeading">Edit Business Process</h3>
			<div>
                            <div style="color:red;display: none;" id="bpediterrormsg">Please enter the correct BP name</div>
				<p>Edit Business Process</p>
				<hr />
				<!-- Update form action -->

                                  <table>
                                        <tr style="height:50px;">
                                            <td>
                                                <label for="pswd">Busniess Process</label>
                                            </td>
                                            <td>
                                                <input type="text" name="editbpname" id='editbpname'/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2" align="right">
                                            <input type="hidden" name="editbpid" id='editbpid'/>
                                            <input type="submit" value="Update BP" onclick="javascript:updateBP();"/>
                                            <input type="button" value="Cancel" onclick="javascript:closeEditBP();"/>
                                            </td>
                                        </tr>
                                  </table>

			</div>
		</div>
                <div id="MPpopup" class="popup">
			<h3 class="popupHeading">Add Main Process</h3>
			<div>
                            <div style="color:red;display: none;" id="mperrormsg">Please enter the correct MP name</div>
				<p>Enter New Main Process</p>
				<hr />
				<!-- Update form action -->
				
                                 <table>
                                        <tr style="height:50px;">
                                            <td>
                                                <label for="pswd">Main Process</label>
                                            </td>
                                            <td>
                                                <input type="text" name="mp" id='mp'/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2" align="right">
                                                <input type="hidden" name="bpid" id='bpid'/>
                                                <input type="submit" value="Create MP" onclick="javascript:createMP();"/>
                                                 <input type="button" value="Cancel" onclick="javascript:closeMP();"/>
                                            </td>
                                        </tr>
                                 </table>
			
			</div>
		</div>
                <div id="MPEditpopup" class="popup">
			<h3 class="popupHeading">Edit Main Process</h3>
			<div>
                            <div style="color:red;display: none;" id="mpediterrormsg">Please enter the correct MP name</div>
				<p>Edit Main Process</p>
				<hr />
				<!-- Update form action -->
				
                                 <table>
                                        <tr style="height:50px;">
                                            <td>
                                                <label for="pswd">Main Process</label>
                                            </td>
                                            <td>
                                                <input type="text" name="editmpname" id='editmpname'/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2" align="right">
                                                <input type="hidden" name="editmpid" id='editmpid'/>
                                                <input type="submit" value="Update MP" onclick="javascript:updateMP();"/>
                                                 <input type="button" value="Cancel" onclick="javascript:closeEditMP();"/>
                                            </td>
                                        </tr>
                                 </table>
			
			</div>
		</div>
                <div id="SPpopup" class="popup">
			<h3 class="popupHeading">Add Sub Process</h3>
			<div>
                            <div style="color:red;display: none;" id="sperrormsg">Please enter the correct Sub Process name</div>
				<p>Enter New Sub Process</p>
				<hr />
				<!-- Update form action -->
				
                                 <table>
                                        <tr style="height:50px;">
                                            <td>
                                                <label for="pswd">Sub Process</label>
                                            </td>
                                            <td>
                                                <input type="text" name="sp" id='sp'/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2" align="right">
                                                <input type="hidden" name="mpid" id='mpid'/>
                                                <input type="submit" value="Create SP" onclick="javascript:createSP();"/>
                                                <input type="button" value="Cancel" onclick="javascript:closeSP();"/>
                                            </td>
                                        </tr>
                                 </table>

			</div>
		</div>
                <div id="SPEditpopup" class="popup">
			<h3 class="popupHeading">Edit Sub Process</h3>
			<div>
                            <div style="color:red;display: none;" id="spediterrormsg">Please enter the correct Sub Process name</div>
				<p>Edit Sub Process</p>
				<hr />
				<!-- Update form action -->
				
                                 <table>
                                        <tr style="height:50px;">
                                            <td>
                                                <label for="pswd">Sub Process</label>
                                            </td>
                                            <td>
                                                <input type="text" name="editspname" id='editspname'/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2" align="right">
                                                <input type="hidden" name="editspid" id='editspid'/>
                                                <input type="submit" value="Update SP" onclick="javascript:updateSP();"/>
                                                <input type="button" value="Cancel" onclick="javascript:closeEditSP();"/>
                                            </td>
                                        </tr>
                                 </table>

			</div>
		</div>
                <div id="SCpopup" class="popup">
			<h3 class="popupHeading">Add Scenario</h3>
			<div>
                            <div style="color:red;display: none;" id="scerrormsg">Please enter the correct Scenario name</div>
				<p>Enter New Scenario</p>
				<hr />
				<!-- Update form action -->
				
                                  <table>
                                        <tr style="height:50px;">
                                            <td>
                                                <label for="pswd">Scenario</label>
                                            </td>
                                            <td>
                                                <input type="text" name="sc" id='sc'/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2" align="right">
                                                <input type="hidden" name="spid" id='spid'/>
                                                <input type="submit" value="Create Scenario" onclick="javascript:createSC()"/>
                                                <input type="button" value="Cancel" onclick="javascript:closeSC();"/>
                                            </td>
                                        </tr>
                                 </table>

			</div>
		</div>
                <div id="SCEditpopup" class="popup">
			<h3 class="popupHeading">Edit Scenario</h3>
			<div>
                            <div style="color:red;display: none;" id="scediterrormsg">Please enter the correct Scenario name</div>
				<p>Edit Scenario</p>
				<hr />
				<!-- Update form action -->
				
                                  <table>
                                        <tr style="height:50px;">
                                            <td>
                                                <label for="pswd">Scenario</label>
                                            </td>
                                            <td>
                                                <input type="text" name="editscname" id='editscname'/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2" align="right">
                                                <input type="hidden" name="editscid" id='editscid'/>
                                                <input type="submit" value="Update Scenario" onclick="javascript:updateSC()"/>
                                                <input type="button" value="Cancel" onclick="javascript:closeEditSC();"/>
                                            </td>
                                        </tr>
                                 </table>

			</div>
		</div>
                <div id="VTpopup" class="popup">
			<h3 class="popupHeading">Add Variant</h3>
			<div>
                            <div style="color:red;display: none;" id="vterrormsg">Please enter the correct Variant name</div>
				<p>Enter New Variant</p>
				<hr />
				<!-- Update form action -->
				
                                  <table>
                                        <tr style="height:20px;">
                                            <td>
                                                <label for="pswd">Variant Name</label>
                                            </td>
                                            <td>
                                                <input type="text" name="vt" id='vt'/>
                                            </td>
                                        </tr>
                                         <tr style="height:20px;">
                                            <td>
                                                <label for="pswd">Lead Module</label>
                                            </td>
                                            <td>
                                                <select name="lead" id='lead'>
                                                    <option value="">--Select One--</option>
                                                    <%
                                                            LinkedHashMap lhp=GetProjectMembers.sortHashMapByValues(modules,true);
                                                            LinkedHashMap im=(LinkedHashMap)lhp.clone();
                                                            Collection se=lhp.keySet();
                                                            Iterator iter=se.iterator();
                                                            while (iter.hasNext()) {
                                                             String key=(String)iter.next();
                                                             String nameofthemodule=(String)lhp.get(key);
                                                             %>
                                                             <option value="<%=key%>"><%=nameofthemodule%></option>
                                                             <%
                                                            }
                                                    %>
                                                </select>
                                            </td>
                                        </tr>
                                        <tr style="height:20px;">
                                            <td>
                                                <label for="pswd">Impacted Module</label>
                                            </td>
                                            <td>
                                                <select name="impact" id='impact'>
                                                    <option value="">--Select One--</option>
                                                    <%

                                                            Collection set=im.keySet();
                                                            Iterator ite=set.iterator();
                                                            while (ite.hasNext()) {
                                                             String key=(String)ite.next();
                                                             String nameofthemodule=(String)im.get(key);
                                                             %>
                                                             <option value="<%=key%>"><%=nameofthemodule%></option>
                                                             <%
                                                            }
                                                    %>
                                                </select>
                                            </td>
                                        </tr>
                                        <tr style="height:20px;">
                                            <td>
                                                <label for="pswd">Type</label>
                                            </td>
                                            <td>
                                                <select name="type" id='type'>
                                                    <option value="">--Select One--</option>
                                                    <option value="Master Data">Master Data</option>
                                                    <option value="Transaction">Transaction</option>
                                                </select>
                                            </td>
                                        </tr>
                                        <tr style="height:20px;">
                                            <td>
                                                <label for="pswd">Classification</label>
                                            </td>
                                            <td>
                                               
                                                 <select name="calssification" id='calssification'>
                                                    <option value="">--Select One--</option>
                                                    <option value="FT">FT</option>
                                                    <option value="IT">IT</option>
                                                </select>
                                            </td>
                                        </tr>
                                        <tr style="height:20px;">
                                            <td>
                                                <label for="pswd">Priority</label>
                                            </td>
                                            <td>
                                                <select name="priority" id='priority'>
                                                    <option value="">--Select One--</option>
                                                    <option value="Core">Core</option>
                                                    <option value="Critical">Critical</option>
                                                    <option value="Essential">Essential</option>
                                                </select>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2" align="right">
                                                <input type="hidden" name="scid" id='scid'/>
                                                <input type="submit" value="Create Variant" onclick="javascript:createVT();"/>
                                                <input type="button" value="Cancel" onclick="javascript:closeVT();"/>
                                            </td>
                                        </tr>
                                 </table>

			</div>
		</div>
                <div id="VTEditpopup" class="popup">
			<h3 class="popupHeading">Edit Variant</h3>
			<div>
                            <div style="color:red;display: none;" id="vtediterrormsg">Please enter the correct Variant name</div>
				<p>Edit Variant</p>
				<hr />
				<!-- Update form action -->
				
                                  <table>
                                        <tr style="height:50px;">
                                            <td>
                                                <label for="pswd">Variant</label>
                                            </td>
                                            <td>
                                                <input type="text" name="editvtname" id='editvtname'/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2" align="right">
                                                <input type="hidden" name="editvtid" id='editvtid'/>
                                                <input type="submit" value="Update Variant " onclick="javascript:updateVT()"/>
                                                <input type="button" value="Cancel" onclick="javascript:closeEditVT();"/>
                                            </td>
                                        </tr>
                                 </table>

			</div>
		</div>                             
                <div id="TCpopup" class="popup">
			<h3 class="popupHeading">Add Test Case</h3>
			<div>
                            <div style="color:red;display: none;" id="tcerrormsg">Please enter the correct Test Case name</div>
				<p>Enter New Test Case</p>
				<hr />
				<!-- Update form action -->

                                  <table>
                                        <tr style="height:50px;">
                                            <td>
                                                <label for="pswd">Test Case</label>
                                            </td>
                                            <td>
                                                <input type="text" name="tc" id='tc'/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2" align="right">
                                                <input type="hidden" name="vtid" id='vtid'/>
                                                <input type="submit" value="Create Test Case" onclick="javacript:createTC();"/>
                                                <input type="button" value="Cancel" onclick="javascript:closeTC();"/>
                                            </td>
                                        </tr>
                                 </table>
				
			</div>
		</div>
                <div id="TCEditpopup" class="popup">
			<h3 class="popupHeading">Edit Test Case</h3>
			<div>
                            <div style="color:red;display: none;" id="tcediterrormsg">Please enter the correct Test Case name</div>
				<p>Edit Test Case</p>
				<hr />
				<!-- Update form action -->

                                  <table>
                                        <tr style="height:50px;">
                                            <td>
                                                <label for="pswd">Test Case</label>
                                            </td>
                                            <td>
                                                <input type="text" name="edittcname" id='edittcname'/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2" align="right">
                                                <input type="hidden" name="edittcid" id='edittcid'/>
                                                <input type="submit" value="Update Test Case" onclick="javacript:updateTC();"/>
                                                <input type="button" value="Cancel" onclick="javascript:closeEditTC();"/>
                                            </td>
                                        </tr>
                                 </table>
				
			</div>
		</div>
                <div id="TSpopup" class="popup">
			<h3 class="popupHeading">Add Test Step</h3>
			<div>
                            <div style="color:red;display: none;" id="tserrormsg">Please enter the correct Test Step name</div>
				<p>Enter New Test Step</p>
				<hr />
				<!-- Update form action -->
				
                                  <table>
                                        <tr style="height:50px;">
                                            <td>
                                                <label for="pswd">Test Step</label>
                                            </td>
                                            <td>
                                                <input type="text" name="ts" id='ts'/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2" align="right">
                                                <input type="hidden" name="tcid" id='tcid'/>
                                                <input type="submit" value="Create Test Step" onclick="javascript:createTS();"/>
                                                <input type="button" value="Cancel" onclick="javascript:closeTS();"/>
                                            </td>
                                        </tr>
                                 </table>
				
			</div>
		</div>
                    <div id="TSEditpopup" class="popup">
			<h3 class="popupHeading">Edit Step</h3>
			<div>
                            <div style="color:red;display: none;" id="tsediterrormsg">Please enter the correct Test Step name</div>
				<p>Edit Test Step</p>
				<hr />
				<!-- Update form action -->
				
                                  <table>
                                        <tr style="height:50px;">
                                            <td>
                                                <label for="pswd">Test Step</label>
                                            </td>
                                            <td>
                                                <input type="text" name="edittsname" id='edittsname'/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2" align="right">
                                                <input type="hidden" name="edittsid" id='edittsid'/>
                                                <input type="submit" value="Update Test Step" onclick="javascript:updateTS();"/>
                                                <input type="button" value="Cancel" onclick="javascript:closeEditTS();"/>
                                            </td>
                                        </tr>
                                 </table>
				
			</div>
		</div>                                                
                <div id="TSCpopup" class="popup">
			<h3 class="popupHeading">Add Test Script</h3>
			<div>
                            <div style="color:red;display: none;" id="terrormsg">Please enter the correct Test Script name</div>
				<p>Enter New Test Step</p>
				    <table>
                                        <tr >
                                            <td>
                                                <label for="pswd">Test Script</label>
                                            </td>
                                            <td>
                                                <textarea  name="testScript" id='testScript' cols="35" rows="4"></textarea>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <label for="pswd">Expected Result</label>
                                            </td>
                                            <td>
                                                <textarea  name="expRslt" id='expRslt' cols="35" rows="4"></textarea>
                                            </td>
                                        </tr>
<!--                                        <script type="text/javascript">
                                            CKEDITOR.replaceAll(
                                                 
                                                    function( textarea, config ){
                                                        config.width	=	350;
                                                        config.height	=	50;
                                                        config.toolbar  =   [[ '']];
                                                    }
                                            );


                                    </script>-->
                                        <tr>
                                            <td colspan="2" align="right">
                                                <input type="hidden" name="tsid" id='tsid'/>
                                                <input type="hidden" name="pid" id='pid' value="<%=pid%>"/>
                                                <input type="submit" value="Create Test Script" onclick="javascript:createTSC();"/>
                                                <input type="button" value="Cancel" onclick="javascript:closeTSC();"/>
                                            </td>
                                        </tr>
                                 </table>

			</div>
		</div>
                                                
    </body>
    <script type="text/javascript">
          $(window).load(function () {
            $("#divLoading").fadeOut(100);
            
        });
          $(document).ready(function(){
        viewCompany("<%=pid%>");
                <%
    
    HashMap companyMap =   ViewBPM.getCompany(Integer.parseInt(pid));
    LinkedHashMap company=GetProjectMembers.sortHashMapByKeys(companyMap,true);
    if(company.size()>0){
        Collection nset=company.keySet();
        Iterator nite = nset.iterator();
        while (nite.hasNext()) {
            int key=(Integer)nite.next();
            int bpCount =   ViewBPM.getBPCount(key);
            if(bpCount>0){
            %>
                    viewBP(<%=key%>);
        
                   <%}
        HashMap bProcess =   ViewBPM.getBP(key);
    LinkedHashMap businessProcess=GetProjectMembers.sortHashMapByKeys(bProcess,true);
    String bpName  =   "";
    if(businessProcess.size()>0){
        Collection bpset=businessProcess.keySet();
        Iterator bpite = bpset.iterator();
        while (bpite.hasNext()) {
            int bpkey=(Integer)bpite.next();
           int mpCount         =   ViewBPM.getMPCount(bpkey);
           if(mpCount>0){
        %>
                viewMP(<%=bpkey%>);
    <%}
        HashMap mProcess =   ViewBPM.getMP(bpkey);
        LinkedHashMap mainProcess=GetProjectMembers.sortHashMapByKeys(mProcess,true);
        if(mainProcess.size()>0){
        Collection mpset=mainProcess.keySet();
        Iterator mpite = mpset.iterator();
        while (mpite.hasNext()) {
            int mpkey=(Integer)mpite.next();
    int spCount   =   ViewBPM.getSPCount(mpkey);
    if(spCount>0){
    %>
                    viewSP(<%=mpkey%>);
        <%}
        String mail=(String)session.getAttribute("theName");
     String url =   null;
     if(mail!=null){
        url=mail.substring(mail.indexOf("@")+1,mail.length());
     }

    HashMap sProcess =   ViewBPM.getSP(mpkey);
    LinkedHashMap subProcess=GetProjectMembers.sortHashMapByKeys(sProcess,true);
    if(subProcess.size()>0){
        Collection spset=subProcess.keySet();
        Iterator spite = spset.iterator();
        while (spite.hasNext()) {
            int spkey=(Integer)spite.next();
        int scCount   =   ViewBPM.getSCCount(spkey);
        if(scCount>0){
        %>
            viewSC(<%=spkey%>);
        
       <% }HashMap scenarioMap =   ViewBPM.getSC(spkey);
    LinkedHashMap scenario=GetProjectMembers.sortHashMapByKeys(scenarioMap,true);
    if(scenario.size()>0){
        Collection scset=scenario.keySet();
        Iterator scite = scset.iterator();
        while (scite.hasNext()) {
            int sckey=(Integer)scite.next();
       int vtCount   =   ViewBPM.getVTCount(sckey);
       if(vtCount>0){
       %>
            viewVT(<%=sckey%>);
            <%}HashMap variantMap =   ViewBPM.getVT(sckey);
    LinkedHashMap variant=GetProjectMembers.sortHashMapByKeys(variantMap,true);
    if(variant.size()>0){
        Collection vtset=variant.keySet();
        Iterator vtite = vtset.iterator();
        while (vtite.hasNext()) {
            int vtkey=(Integer)vtite.next();
           int tcCount   =   ViewBPM.getTCCount(vtkey);
           if(tcCount>0){
            %>
        
        viewTC(<%=vtkey%>);
        
        <%}
        HashMap tcase =   ViewBPM.getTC(vtkey);
    LinkedHashMap testcase=GetProjectMembers.sortHashMapByKeys(tcase,true);
    if(testcase.size()>0){
        Collection tcset=testcase.keySet();
        Iterator tcite = tcset.iterator();
        while (tcite.hasNext()) {
            int tckey=(Integer)tcite.next();
        int tSount   =   ViewBPM.getTSCount(tckey);
        if(tSount>0){
        %>
        viewTS(<%=tckey%>);
        <%}HashMap tstep =   ViewBPM.getTS(tckey);
    LinkedHashMap teststep=GetProjectMembers.sortHashMapByKeys(tstep,true);
    if(teststep.size()>0){
        Collection tsset=teststep.keySet();
        Iterator tsite = tsset.iterator();
        
        while (tsite.hasNext()) {
            int tskey=(Integer)tsite.next();
        int tscCount=ViewBPM.getTestScriptCount(tskey);
        if(tscCount>0){
        %>
                    viewTSC(<%=tskey%>);
       <%
        }}}
         }}}}}}}}
         }}
        }
    }}}
    %>
       });
        </script>
</html>

<%-- 
    Document   : valueReport
    Created on : 28 Nov, 2014, 12:21:26 PM
    Author     : Tamilvelan
--%>

<%@page pageEncoding="UTF-8"%>
<%@ page import="org.apache.log4j.*"%>
<%@page import="dashboard.* , java.applet.*,java.util.*,com.eminent.util.GetProjects,com.eminent.util.GetProjectMembers,dashboard.TestCases"%>

<%
		session.setAttribute("forwardpage","/admin/dashboard/displayChart.jsp");
                response.setHeader("Cache-Control","no-cache");
		response.setHeader("Cache-Control","no-store");
		response.setDateHeader("Expires", 0);
 		response.setHeader("Pragma","no-cache");
                        
                        //Configuring log4j properties
			
		
			
			Logger logger = Logger.getLogger("displayChart");
			
                        
                        String logoutcheck=(String)session.getAttribute("Name");
			if(logoutcheck==null)
			{
				
				%>
<jsp:forward page="/SessionExpired.jsp"></jsp:forward>
<%
			}


%>

<%--
The taglib directive below imports the JSTL library. If you uncomment it,
you must also add the JSTL library to the project. The Add Library... action
on Libraries node in Projects view can be used to add the JSTL 1.1 library.
--%>
<%--
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
--%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
<meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">



<title>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS
Solution</title>
<LINK title=STYLE
	href="<%= request.getContextPath() %>/eminentech support files/main_ie.css"
	type="text/css" rel=STYLESHEET>

 <style type="text/css">
.border th {

    text-align:  center;
}
.border table, .border tr , .border td {
    border: 1px solid #ccccff;
}
</style>
</head>

<script>
        function call(theForm)
			{
				var x=document.getElementById("project").value;
				theForm.action='displayChart.jsp?project='+x;
				theForm.submit();
			}
    </script>
<body>
<%@ include file="/header.jsp"%>
<table cellpadding="0" cellspacing="0" width="100%">
	<tr border="2" bgColor="#C3D9FF">
		<td bgcolor="#C3D9FF" border="1" align="left" width="100%"><font
			size="4" COLOR="#0000FF"><b>Value Generated Report</b></font></td>
	</tr>
</table>
<br>

<%!
       
       String[] priority  = {"P1-Now","P2-High","P3-Medium","P4-Low"};
       
       
       String[] status   = {"Unconfirmed", "Rejected", "Duplicate", "User Error","Documentation","Review","Training","Evaluation", "Investigation", "Confirmed","QA-BTC","QA-BTC Review", "Development",
                            "Workinprogress","Code Review","ReadytoBuild","QA-TCE", "Performance QA", "Verified"};
       
    %>
<%
       
       String project      = request.getParameter("project"); 
       String phase        = request.getParameter("phase");

       if(!project.equalsIgnoreCase("NA")){
       
       logger.info("Project :" +project);
       logger.info("Phase :" +phase);

       String category  ="NA";
       if(project!=null){
        category = CheckCategory.getCategory(project);
       }
       logger.info("Category :" +category);
       
       if(phase == null){
           
           ArrayList<String> parseDetails = dashboard.Project.getDetails(project);
           phase  = parseDetails.get(1);
           
       }
       
       //Identifying category and type provided it is a project
       
       
       HashMap<String,Integer> hm = dashboard.MaxIssue.getIssueCount(project);

       String pid           =   GetProjects.getProjectId(project);
       String cases[][]     =   TestCases.showTestCases(pid);
       int noOfTestcases    =   cases.length;
  // Get Project governance people
       HashMap managers     =   GetProjectMembers.getProjectManagers(pid);
       int      userId      =   (Integer)session.getAttribute("uid");
       int      roleId      =   (Integer)session.getAttribute("Role");

%>
<table width="100%">
            <tr>
                <td width="5%">
                    <a href="<%=request.getContextPath()%>/testMap.jsp?pid=<%=pid%>">Business Process Map</a>&nbsp;&nbsp;&nbsp;
                <%
    if(category.equalsIgnoreCase("SAP Project")){
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
                <a href="<%=request.getContextPath()%>/admin/dashboard/TestCasesChart.jsp?project=<%=pid%>">Test Coverage</a>&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/UserProject/listProjectTestPlan.jsp?pid=<%=pid%>&project=<%=project%>">Test Plans</a>&nbsp;&nbsp;&nbsp;
                <%}%>
                <a href="<%=request.getContextPath()%>/admin/dashboard/projectPerformanceChart.jsp?pid=<%=pid%>">Project Performance</a>&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/admin/dashboard/openIssueByProject.jsp?pid=<%=pid%>">View Issues</a>&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/MOM/momProjectTeamWise.jsp?pid=<%=pid%>" title="Weekly Review MoM">WRM</a>&nbsp;&nbsp;&nbsp; 
                 <a href="<%=request.getContextPath()%>/admin/dashboard/valueReport.jsp?pid=<%=pid%>&project=<%=project%>" title="Value Generated Report"><b>Value Generated</b></a>&nbsp;&nbsp;&nbsp; 
                </td>
            </tr>
        </table>

      
<table class="border" id="value" class="value">
      <tr>
            <th width="20%"><b>Issue Description</b></th>
            <th><b>Module</b></th>  
            <th><b>Beneficiary</b></th>
            <th width="35%"><b>Before</b></th>
            <th width="35%"><b>After</b></th>
              
        </tr>
        
    <tr><td>Auto email alert - Enhancement points</td><td>FI</td><td>Mr.Margabandu</td><td>Constant follow up from vendors on payments. Manual payment advise generation was available only for cheque payments.</td><td>Automatic email notifications sent to vendors once payment is made. System generates payment advises for cheque and e-payments also. Concerned authorities are CC'ed in emails</td></tr><tr><td>Summary report showing variable cost and fixed cost</td><td>FI</td><td>Mr.Margabandu</td><td>Unable to account for cost considering production and marketing overheads. Tedious XL work to arrive at the cost and variance</td><td>Report showing accurate calculations to support the costing process, accounting for production and marketing- fixed and variable costs. Production order wise, date range based reports can be generated</td></tr><tr><td>Auto posting of loan recovery</td><td>FI</td><td>Mr.Margabandu</td><td>Loan recovery from payroll was a manual activity consuming 2-3 days of work/month of Mr.Arun prasad. Prone to user errors</td><td>Automated the entire process of HR-FI integration on loan recovery process reducing the processing time to almost nil</td></tr><tr><td>Tds deduction on Before Service Tax amt</td><td>FI</td><td>Mr.Margabandu</td><td>TDS is calculated on the gross bill value</td><td>TDS changed to be calculated on net value before service tax as per new act</td></tr><tr><td>New financial statement version</td><td>FI</td><td>Mr.Margabandu</td><td>Financial statement version as per the old format since 2006 </td><td>Revised to the schedule VI format.</td></tr><tr><td>Asset master change upload program</td><td>FI</td><td>Mr.Margabandu</td><td>Mass asset master maintenance for asset depreciation key and useful life was not available</td><td>Upload program provided that saved 2 man days every month</td></tr><tr><td>Customer Payment Performance Report</td><td>FI</td><td>Mr.Margabandu</td><td>Manual excel calculation would be carried out for the monthly review meeting.</td><td>Report provided for customer payment performance. Which shows customer wise detailed informations like, Bill raised, Payment received and Status of the Customer like, Timely or Delayed</td></tr><tr><td>Depreciation according to useful lives as per the companies act, 2013</td><td>FI</td><td>Mr.Margabandu</td><td>Percentage based depreciation was there in place</td><td>Useful life based depreciation calculation has been enabled as per act</td></tr><tr><td>pay roll</td><td>HR</td><td>Ms.Vijaylakshmi</td><td>Possibility of making errors in processing increments without changing start date</td><td>Pop up to warn the user that the start date needs to be changed or kept as it is.</td></tr><tr><td>TEM training</td><td>HR</td><td>Mr.Subhashini</td><td>Training and Event Management module implemented but not used</td><td>Training provided to start using the current configurations</td></tr><tr><td>Over time report</td><td>HR</td><td>Ms.Vijaylakshmi</td><td>Manual extraction of data to calculate over time by day, week, month, quarter and year</td><td>Auto generated report to show over time by day, week, month, quarter and year</td></tr><tr><td>Item text to be copied from PR to PO</td><td>MM</td><td>Ms.Chitra, 
Mr.Srinivasan</td><td>Line item level detail was shown at the end of the PO. Possibility of vendors not paying attention to those details and hence supplying products that are not to specifications</td><td>Line item level details are now updated after each item in a PO. Internal notes. are maintained seperately</td></tr><tr><td>PAYMENT REQUEST-AUTO MAIL</td><td>MM</td><td>Mr.Srinivasan</td><td>Once PO is released, purchase dept follows up with finance dept through written forms to make payments</td><td>Automatic daily emails will be sent to finance dept until advance payment is made</td></tr><tr><td>Auto Vendor Master clean-up</td><td>MM</td><td>Mr.Srinivasan</td><td>Vendors with whom no active transactions have taken place in the last 1 year need to be deactivated from further order processing</td><td>Automatically deactivated vendors with whom no transactions took place in the last 1 year.</td></tr><tr><td>Consolidated List for Issuing of Grits on daily basis</td><td>MM</td><td>Mr.Kannan</td><td>Stores was getting multiple entries/reservations for issuing of goods</td><td>A consolidated report was generated that eased the process of issuing of goods to production by stores</td></tr><tr><td>auto co11n</td><td>MM</td><td>Mr.Kannan</td><td>Stores was issuing and confirming orders individually</td><td>Once stores issues all materials, a report would show the list of production orders that can be confirmed as a bulk instead of doing one by one</td></tr><tr><td>MRP</td><td>MM</td><td>Mr.Srinivasan</td><td>Based on current lot size configuration, there were a lot of round up of PR quantities. Resulted in multiple PR generation and hence unnecessary material quantity being procured</td><td>Configured monthly lot so that rounding up is not done for each and every transaction. System reconfigured to avoid unnecessary PR and material procurements</td></tr><tr><td>Tracking number column to be extended </td><td>MM</td><td>Ms.Chitra</td><td>There was no provision to track the flow from PR to PO based on internal reference number (40 character length)</td><td>Enabled an internal tracking reference number through which the flow form PR to PO can be tracked</td></tr><tr><td>Consumption pattern- 3 reports</td><td>PM</td><td>Mr.Selvam</td><td>Unable to find out the material consumption pattern of spare items</td><td>Report was generated to display the month wise consumption patten for the maintenance spare materials. </td></tr><tr><td>Check list for preventive maint</td><td>PM</td><td>Mr.Selvam</td><td>Recording results in the preventive maitenance procedure was a tedious process in SAP where user had to traverse through 4 different T-codes</td><td>Quality management concept of result recording was incorporated to ease the way in which results will be recorded. Users had to go through only 1 t-code</td></tr><tr><td>Grit planned order conversion with respect to FERT order</td><td>PP</td><td>Ms.Meenakshi</td><td>Material requirement was shown only for final FERT level items</td><td>System was configured to show material requirement based on nth level of bom explosion</td></tr><tr><td>RM set to Qty as "Zero" or lesser than Plan Qty</td><td>PP</td><td>Ms.Meenakshi</td><td>Shop floor vs SAP difference - Production would be confirmed even though SAP would report that inadequate materials are present for that production.</td><td>A validation was put in place such that production can be confirmed in SAP only if required material is available (physically and in SAP as well)</td></tr><tr><td>consolidation of RM</td><td>PP</td><td>Ms.Meenakshi</td><td>There was no end to end visibility into the following flow- each sales order, what all production orders are created and for those orders what materials are needed, what materials and how much is already available inhouse and what/how much need to be procured, considering open PO's. </td><td>Report to enable the planning team to make sure that the production flows are not disturbed because of lack of visibilty  into pending sales order-production order-grit/ROH material availability</td></tr><tr><td>registering of net weight for every item</td><td>QM</td><td>Ms.Meenakshi</td><td>There were instances where netweight was not getting updated properly in delivery challans and hence resulting in fines being paid when recorded net weight is found to be lower than the actual weight of the consignment</td><td>Validations were put in place to ensure the correct net weight and the gross weight are reported in DCs.</td></tr><tr><td>SL engraving</td><td>QM</td><td>Mr.Ramanathan</td><td>SL no engraving was error prone due to indisciple in confirmation process during different stages of production</td><td>Checks were put in place such that after each and every production stage, the responsible person will confirm the exact number of passes/failures. Thus ensuring smooth engraving process which happens post QC.</td></tr><tr><td>Authentication code for final inspection</td><td>QM</td><td>Mr.Ramanathan</td><td>It was difficult to find out who did result recording for a given lot</td><td>Authentication mechanism was put in place such that each and every user puts in a password post his/her result recording. Ensured accoutabilitu in QC process</td></tr><tr><td>Trading Purchase and Sales report</td><td>SD</td><td>Ms.Usha B</td><td> Currently when the stock is reviewed, the pipeline order quantity details is not available</td><td>Report that shows details of Purchase order details against the material - field required PO no. / date, PO qty, pending quantity from supplier</td></tr>
    <tr><td>Capturing Statutory forms (CT3 form) and Request for are3</td><td>SD</td><td>Ms.Usha B, 
Mr.Saravanan</td><td>Unable to track whether customer's CT3 forms are received or not. Manual generation of ARE3 forms</td><td>Validations were put in place to check if the correct CT3 forms are received from customers. ARE3 form generation was automated</td></tr><tr><td>Exclusion of value in Invoice/Packing List.</td><td>SD</td><td>Mr.Shiva</td><td>Value of goods in invoice/packing list need to be controlled based on certain customer's customs needs</td><td>Enabled option to generate invoices without values</td></tr></table>

	<% 
           
       
       }
    %>
	
</body>


</html>


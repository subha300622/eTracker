<%-- 
    Document   : addTEP
    Created on : 6 Jul, 2010, 8:54:47 AM
    Author     : Tamilvelan
--%>
<%@page  import="com.pack.StringUtil,org.apache.log4j.*,java.util.LinkedHashMap,java.util.List,java.util.HashMap,java.util.Map,java.util.Iterator,com.eminent.tqm.TqmPtcm,com.eminent.tqm.TestCasePlan,com.eminent.util.GetProjectMembers,com.eminent.util.GetProjects,com.eminent.util.GetProjectManager,java.text.SimpleDateFormat"%>
<%
//Configuring log4j properties
	
	Logger logger = Logger.getLogger("addTEP");
	
	String logoutcheck=(String)session.getAttribute("Name");
	if(logoutcheck==null)
	{
		logger.fatal("=========================Session Expired======================");
		%>
<jsp:forward page="../SessionExpired.jsp"></jsp:forward>
<%
        }
%>

<%@ include file="/header.jsp"%>

<html>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
       <script type="text/javascript" src="<%= request.getContextPath() %>/javaScript/checkSubmit.js"></script>
        <title>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS Solution</title>
        <LINK title=STYLE  href="<%= request.getContextPath() %>/eminentech support files/main_ie.css" type="text/css" rel="STYLESHEET">
        
       <script type="text/javascript">

        function call(Form)
			{
				var x=document.getElementById("createdby").value;
                                var pidValue=document.getElementById("pid").value;
                                var edate=document.getElementById("edate").value;
                                var tepId=document.getElementById("tepId").value;
				Form.action='addTEP.jsp?createdby='+x+'&pid='+pidValue+'&edate='+edate+'&tepId='+tepId;
                                Form.submit();

			}

           	function SetChecked(val,chkName)
	{
		dml=document.forms['theForm'];
		len = dml.elements.length;
		var i=0;
		for( i=0 ; i<len ; i++)
		{
			if (dml.elements[i].name===chkName)
			{
				dml.elements[i].checked=val;
			}
		}
	}

	function ValidateForm(dml,chkName)
	{
           	var form='theForm';

            var len = document.theForm.elements.length;
    //        alert(len);

            var i=0;
            var flag = false;

            for( i=0 ; i<len ; i++) {

			if ((document.theForm.elements[i].name===chkName) && (document.theForm.elements[i].checked===1)){

                            flag = true;
                        }

            }

                if( flag === true){
                      
                          count = (document.theForm.elements.length-3)/3;
                          check = true;
                       for( j = 0 ; j < count ; j++) {
                           var box = (j*3) + 3;
                           
                            if ((document.theForm.elements[box].id === 'ptcid') && (document.theForm.elements[box].checked)) {
                                    
                                    if (document.theForm.elements[box+2].value==="--Select One--") {

                                         alert('Please select Assigned To for the selected Test Cases');
                                         document.theForm.elements[box+2].focus();
                                         return false;
                                    }
                       /*             if (document.pid.elements[box-1].value=="--Select--") {

                                        check = false;
                                    }
*/
                            }
                        }


                   
                } else {
                    alert("Please select at least one record to approve");
                    return false;
                }
                monitorSubmit();
	}
        

       </script>
    </head>
    <body>
       <%
                String pid          =   request.getParameter("pid");
                String createdby    =   request.getParameter("createdby");
                if(createdby==null){
                    createdby="null";
                }
                LinkedHashMap lhp=GetProjectMembers.sortHashMapByValues(GetProjectMembers.getTestMembers(pid),true);
                Map users           =   lhp;
                Object[] userArray  =   users.entrySet().toArray();
                int noOfRecords     =   0;
                List    ptc         =   null;
%>
<table cellpadding="0" cellspacing="0" width="100%">
	<tr  bgcolor="#C3D9FF">
		<td align="left"><b> Project Test Cases</b></td>

	</tr>

        </table>
<br>
<form name="Form"   method="post">
<table bgcolor="#E8EEF7" width="100%">
    <tr align="center">
        <td><b>Test Cases Created By  :</b>
            <select id="createdby" name="createdby" onchange="javascript:call(this.form);">
                <option value=null>--Select All--</option>
        <%
            logger.info("PTC Created"+createdby);
            int createdUser =   0;
            if(!createdby.equalsIgnoreCase("null")){
                createdUser =   Integer.parseInt(createdby);
            }
            int noOfUser    =   userArray.length;
            for(int s=0;s<noOfUser;s++){
                Map.Entry entry = (Map.Entry) userArray[s];
                String Id   =   (String)entry.getKey();
                String name   =   (String)entry.getValue();
                name    =   name.substring(0, name.lastIndexOf(" ")+2);
                logger.info("Createdby-->"+createdby+"  Id-->"+Id);
        if(createdUser==Integer.parseInt(Id)){
%>
                <option value="<%=Id%>" selected><%=name%></option>
<%

                }else{
%>
                <option value="<%=Id%>"><%=name%></option>
<%
                }
            }
        %>
            </select>
            </td>
    </tr>
</table>
</form>
            <%

                String tepId    =   request.getParameter("tepId");
                String qManager =   request.getParameter("qm");
                String eDate    =   request.getParameter("edate");
                logger.info("tepId"+tepId);
                logger.info("pId"+pid);
                if(createdby.equalsIgnoreCase("null")){
                    ptc        =   TestCasePlan.listModulePTC(Integer.parseInt(pid), tepId);
                }else{
                    ptc        =   TestCasePlan.listModuleUserPTC(Integer.parseInt(pid), tepId,createdby);
                }
                noOfRecords =   ptc.size();
             %>
        <%
            
            try{
                int adminId =   GetProjectMembers.getAdminID();
                int userId  =   (Integer)session.getAttribute("uid");



                %>
<table width="100%">

	<tr >
		<td align="left" width="80%">This list shows <b> <%=noOfRecords %></b> Project Test Cases.</td>
                <td align="right"><a href="javascript:SetChecked(1,'ptcid')"><font
			face="Arial, Helvetica, sans-serif" size="2">Select All</font></a> <a
			href="javascript:SetChecked(0,'ptcid')"><font
			face="Arial, Helvetica, sans-serif" size="2">Clear All</font></a></td>
	</tr>
</table>
<br>
<form name="theForm" action="addTC.jsp" onsubmit="return ValidateForm('theForm','ptcid');" method="post">
<table width="100%">

    <tr bgcolor="#C3D9FF" >
        <td width="10%"><b>TestCaseId</b></td>
        <td width="10%"><b>Project</b></td>
        <td width="13%"><b>Module</b></td>
        <td width="15%"><b>Functionality</b></td>
        <td width="15%"><b>Description</b></td>
        <td width="15%"><b>Expected Result</b></td>
        <td width="10%"><b>Createdby</b></td>
        <td width="10%"><b>Due Date</b></td>
        <td width="10%"><b>AssignedTo</b></td>
        
    </tr>
    <%
     int k=1;
     String created   =  null;
     for (Iterator i = ptc.iterator(); i.hasNext();k++ ) {
            TqmPtcm t =(TqmPtcm)i.next();
            String ptcid     =   t.getPtcid();
            String func      =   t.getFunctionality();
            String desc      =   t.getDescription();
            String reslt     =   t.getExpectedresult();
            String project   =   GetProjects.getProjectName(((Integer)t.getPid()).toString());
            String module    =   GetProjects.getModuleName((t.getMid()).toString());
           created   =   GetProjectManager.getUserName(t.getCreatedby());
         
 //           if(ptcid=="Q12052010002"){
  //              logger.info("PTC IC-->"+ptcid);
    //            logger.info("Fuction-->"+func);
      //          logger.info("Desc-->"+desc);

   //         }

            java.util.Date date =t.getCreatedon();
            SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yy HH:mm:ss");
            String requestedOn  =   sdf.format(date);

            project=project.replace(":"," v");
            String funcTitle=func;
            String descTitle=desc;
            String rsltTitle=reslt;
            if(func.length()>30){
                func=func.substring(0,30)+"...";
                }
            if(desc.length()>30){
                desc=desc.substring(0,30)+"...";
                }
            if(reslt.length()>30){
                reslt=reslt.substring(0,30)+"...";
                }
                 logger.info("Result-->"+reslt);
                logger.info("Project-->"+project);
                logger.info("Created-->"+created);
                String color    =   "white";
          if(( k % 2 ) != 0)
                {
                    color    =   "white";
                }
                else
                {
                    color="#E8EEF7";
                }
%>
<tr bgcolor="<%=color%>" >
<td><input type="checkbox" name="ptcid" id="ptcid" value="<%=ptcid%>"><a href="viewPTC.jsp?ptcID=<%=ptcid%>"><%=ptcid%></a></td>
        <td><%=project%></td>
        <td><%=module%></td>
        <td title="<%=StringUtil.encodeHtmlTag(funcTitle)%>"><%=StringUtil.encodeHtmlTag(func)%></td>
        <td title="<%=StringUtil.encodeHtmlTag(descTitle)%>"><%=StringUtil.encodeHtmlTag(desc)%></td>
        <td title="<%=StringUtil.encodeHtmlTag(rsltTitle)%>"><%=StringUtil.encodeHtmlTag(reslt)%></td>

        <td><%=created%></td>
        <td><input type="text" name="duedate" id="duedate" value="<%=eDate%>" readonly size="8"/></td>
        <td><select id="assignedto" name="assignedto">
                <option value="--Select One--">--Select One--</option>
        <%
            int userSize    =   userArray.length;
            for(int s=0;s<userSize;s++){
                Map.Entry entry = (Map.Entry) userArray[s];
                String Id   =   (String)entry.getKey();
                String name   =   (String)entry.getValue();
          //      name    =   name.substring(0, name.lastIndexOf(" ")+2);
%>
                <option value="<%=Id%>"><%=name%></option>
<%
            }
        %>
            </select>
            </td>
    </tr>

               <%
                }
                }
            catch(Exception e){
                logger.error(e.getMessage());
                }
                if(noOfRecords>0){
%>
<tr><td><td colspan="4" align="right"><input type="submit"  id="submit"  value="Submit"><input type="reset"  id="reset" value="Reset"></td></tr>
<%}%>
<tr><td><input type="hidden" name="tepId" id="tepId" value="<%=tepId%>"><input type="hidden" name="pid" id="pid" value="<%=pid%>"><input type="hidden" name="edate" id="edate" value="<%=eDate%>"></td></tr>
    </table>
</form>
    </body>
</html>

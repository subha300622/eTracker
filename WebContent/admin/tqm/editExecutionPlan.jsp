<%-- 
    Document   : editExecutionPlan
    Created on : 9 Jul, 2010, 10:31:06 AM
    Author     : Tamilvelan
--%>
<%@page  import="java.text.SimpleDateFormat,com.eminent.tqm.TqmTestcaseplanstatus,java.util.List,com.eminent.timesheet.Users,com.eminent.util.GetProjects,com.eminent.tqm.TestCasePlan,com.eminent.tqm.TqmTestcaseexecutionplan,com.eminent.util.GetProjectMembers,java.util.HashMap,java.util.LinkedHashMap,java.util.Collection,java.util.Iterator,com.eminent.issue.Project"%>
<%
//Configuring log4j properties
	

	Logger logger = Logger.getLogger("Edit Execution Plan");
	

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

        <title>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS Solution</title>
        <LINK title=STYLE  href="<%= request.getContextPath() %>/eminentech support files/main_ie.css" type="text/css" rel="STYLESHEET">
        <script type="text/javascript" src="<%= request.getContextPath() %>/eminentech support files/datetimepicker.js"></script>
        <script type="text/javascript"  src="<%= request.getContextPath() %>/javaScript/checkSubmit.js">  </script>
        <script type="text/javascript">

     function isRepeat( m1, m2) {

            m1len = m1.length ;
            teamLength = m2.length;
            var flag = false;
            if ( teamLength != 0){
                for ( i = 0; i < m1len ; i++ ) {
                   if( m1.options[i].selected == true ){
                        for ( j = 0; j < teamLength ; j++ ) {
                            if ( flag == false) {
                                if(m1.options[i].value == m2.options[j].value){

                                    flag = true;

                                }
                            }
                        }
                    }
                }

            }
            return flag;

     }

     function one2two() {
            var m1 = document.executionpaln.modules;
            var m2 = document.executionpaln.modulesFinal;
            var m1len = m1.length ;
            var moduleFinalLength = m2.length;
            var flag = isRepeat(m1, m2);

        if( flag == true) {
            alert('There is a repetition in the selection');
        } else {
            for (var i = 0; i < m1len ; i++ ) {
                if (m1.options[i].selected == true ) {
                    m2len = m2.length;
                    m2.options[m2len]= new Option(m1.options[i].text,m1.options[i].value);
                }
            }

            for ( i = (m1len -1); i>=0; i--) {
                if (m1.options[i].selected == true ) {
                    m1.options[i] = null;
                }
            }
        }
    }

    function two2one() {
            var m1 = document.executionpaln.modules;
            var m2 = document.executionpaln.modulesFinal;
            m2len = m2.length ;
            teamLength = m1.length;
            teamSelectLength = m2.length;
            pM = false;
            removeModules();
   if (pM == false) {


            if ( m2len != 0){
                for ( i = 0; i < m2len ; i++ ) {
                   // alert(m2.options[i].text);
                   if( m2.options[i].selected == true ){
                       flag = false;
                        for ( j = 0; j < teamLength ; j++ ) {
                           // alert(m1.options[j].text);

                                if(m2.options[i].value == m1.options[j].value){
                                   flag =  true;

                                }
                            }
                            if(flag != true){
                                m1index = m1.length;
                                m1.options[m1index]= new Option(m2.options[i].text,m2.options[i].value);
                            }
                        }
                    }


                }

                    for ( i = (m2len -1); i>=0; i--) {
                        if (m2.options[i].selected == true ) {
                            m2.options[i] = null;
                        }
                    }
            }
    }





	function createRequest()
	{
		var reqObj = null;
		try
        {
		   reqObj = new ActiveXObject("Msxml2.XMLHTTP");
		}
		catch(err)
        {
		   try
           {
			reqObj = new ActiveXObject("Microsoft.XMLHTTP");
		   }
		   catch (err2)
           {
				try
                {
				   reqObj = new XMLHttpRequest();
				}
				catch (err3)
                {
				  reqObj = null;
				}
	   		}
		}
		return reqObj;
	}
        function getSelections(select)
        {
          var options = select.options,sOptions = [],opt, k=0,s=0;
          var total =   options.length;
        
          while(total> k){
                opt   =   options[k++]
                
                if(opt.selected){
                    sOptions[s] = opt.value;
                    s++;
                  }
          }
          return sOptions
        }
        function removeModules(){
            xmlhttp = createRequest();
            if (!xmlhttp && typeof XMLHttpRequest!='undefined')
            {
                xmlhttp = new XMLHttpRequest();
            }
            if(xmlhttp!=null){
                var modules   =   document.getElementById('modulesFinal');
                var planId    =   document.getElementById("planId").value;
                var selectedDesserts = getSelections(modules)
                var noOfModule  =   selectedDesserts.length;
                var module  =   "removeModules.jsp?planid="+planId;
              // test run through of returned array
              for(var k=0;k<selectedDesserts.length;k++){
                module = module+"&name="+selectedDesserts[k]
            }
             module=module+"&rand="+Math.random(1,10);
            xmlhttp.open("GET",module, true);
  //          xmlhttp.onreadystatechange = callback;
            xmlhttp.send(null);
            }
       }


	function totalHours()
	{
        xmlhttp = createRequest();
        if (!xmlhttp && typeof XMLHttpRequest!='undefined')
        {
            xmlhttp = new XMLHttpRequest();
        }
        if(xmlhttp != null)
        {
            var startDate = document.getElementById("startdate").value;
            var endDate = document.getElementById("enddate").value;
            xmlhttp.open("GET","getTotalHours.jsp?startDate="+startDate+"&endDate="+endDate+"&rand="+Math.random(1,10), true);
            xmlhttp.onreadystatechange = callback;
            xmlhttp.send(null);
        }
	}


	function callback()
	{
    	if (xmlhttp.readyState == 4)
	    {
			if (xmlhttp.status == 200)
          	{
                var name = xmlhttp.responseText.split(",");
                document.executionpaln.totalhours.value=name[1];
          	}
    	}
	}

        function callManagers()
	{
    	xmlhttp = createRequest();
        if (!xmlhttp && typeof XMLHttpRequest!='undefined')
        {
        	xmlhttp = new XMLHttpRequest();
       	}
        if(xmlhttp != null)
        {
            var prodId = document.getElementById('project').value;
            xmlhttp.open("GET","managerDetails.jsp?product="+prodId+"&rand="+Math.random(1,10), true);
            xmlhttp.onreadystatechange = callbackManagers;
            xmlhttp.send(null);
      	}
	}

	function callbackManagers()
	{
    	if (xmlhttp.readyState == 4)
    	{
	  	if (xmlhttp.status == 200)
          	{
            	var name = xmlhttp.responseText;
                var resultManager = xmlhttp.responseText.split(";");
                var resultManagers = resultManager[1].split(",");
                var objLinkList 	= eval("document.executionpaln.manager");
                objLinkList 	= eval("document.getElementById('manager')");
                objLinkList.length=0;
               for( var i=0;i<resultManagers.length-1;i++)
                {
                    var select=resultManagers[i].split("*");
                    objLinkList.length++;
                    objLinkList[i].text =select[1];
                    objLinkList[i].value = select[0];
             	}
	   		}
    	}
            callModules();
	}

	function callModules()
	{
    	xmlhttpMod = createRequest();
        if (!xmlhttpMod && typeof XMLHttpRequest!='undefined')
        {
        	xmlhttpMod = new XMLHttpRequest();
       	}
        if(xmlhttpMod != null)
        {
            var prodId = document.getElementById('project').value;

            xmlhttpMod.open("GET","moduleDetails.jsp?product="+prodId+"&rand="+Math.random(1,10), true);
            xmlhttpMod.onreadystatechange = callbackModules;
            xmlhttpMod.send(null);
      	}
	}

	function callbackModules()
	{
    	if (xmlhttpMod.readyState == 4)
    	{
	  		if (xmlhttpMod.status == 200)
          	{
            	var result = xmlhttpMod.responseText.split(";");
                var results = result[1].split(",");
                var objLinkList1 	= eval("document.executionpaln.modules");
                objLinkList1 	= eval("document.getElementById('modules')");
                objLinkList1.length=0;
                var modFinal	= eval("document.getElementById('modulesFinal')");
                modFinal.length=0;
               for( var i=0;i<results.length-1;i++)
                {
                    var select=results[i].split("*");
                    objLinkList1.length++;
                    objLinkList1[i].text =select[1];
                    objLinkList1[i].value = select[0];
             	}
	   		}
    	}
	}
</script>
        <script type="text/javascript">
            function trim(str)
            {
                while (str.charAt(str.length - 1)==" ")
                    str = str.substring(0, str.length - 1);
                    while (str.charAt(0)==" ")
                str = str.substring(1, str.length);
                    return str;
            }
                            function isPositiveInteger(str)
                {
		var pattern = "._1234567890"
		var i = 0;
		do
                {
    		var pos = 0;
    		for (var j=0; j<pattern.length; j++)
      			if (str.charAt(i)==pattern.charAt(j))
                {
					pos = 1;
                    break;
      			}
    			i++;
                }
	  	while (pos==1 && i<str.length)
  			if (pos==0)
	    		return false;
  		return true;
                }

            function validate(executionpaln){
                if (trim(document.getElementById("planname").value)=="")
                {
                        alert ( "Please enter the Test Execution Plan Name" );
                        executionpaln.planname.focus();
			return false;
                }
                if (trim(document.getElementById("planname").value).length<6)
                {
                        alert ( "Test Execution Plan Name should be greater than 6 characters" );
                        executionpaln.planname.focus();
			return false;
                }
                if (document.getElementById("project").value=="--Select One--")
                {
                        alert ( "Please select a Project" );
                        executionpaln.project.focus();
			return false;
                }
                if (document.getElementById("buildno").value=="")
                {
                        alert ( "Please enter the Build No" );
                        executionpaln.buildno.focus();
			return false;
                }
                if (!isPositiveInteger(trim(document.getElementById("buildno").value)))
                {
                        alert ( "Please enter the Build No" );
                        document.getElementById("buildno").focus();
			return false;
                }
                if (document.getElementById("manager").value=="--Select One--")
                {
                        alert ( "Please select a Quality Manager" );
                        executionpaln.manager.focus();
			return false;
                }
                if (document.getElementById("manager").value=="")
                {
                        alert ( "Please select a Quality Manager" );
                        executionpaln.manager.focus();
			return false;
                }
        
        var modulesFinal = document.getElementById("modulesFinal");
        var modulesFinalOptions = modulesFinal.options;
        var modulesFinalOLength = modulesFinalOptions.length;

        if (modulesFinalOLength < 1) {
            alert("Please Select Modules using the [>>] button to create paln");
            return false;
        }
        for (var i = 0; i < modulesFinalOLength; i++) {
        modulesFinalOptions[i].selected = true;
        }
        monitorSubmit();
       }

        </script>
    </head>
    <body>
        <form name="executionpaln" onsubmit="return validate(this)" action="updatePlan.jsp" method="post">
            <table width="100%">
                <tr bgcolor="#C3D9FF">
                    <td><b>Update Test Execution Plan</b></td>
                </tr>
            </table>
            <br>
            <br>
            <br>
            <br>

            <%
            try{
                String planId   =   request.getParameter("planId");
                TqmTestcaseexecutionplan   tep =   TestCasePlan.viewPlan(planId);
                // Select Project from DB
                HashMap projectList =   TestCasePlan.getActiveProjects();
                String planNamme    =   tep.getPlanname();
                String buildNo      =   tep.getBuildno();
                int project         =   tep.getPid();
                int qm              =   ((Users)tep.getQualitymanager()).getUserid();
                int statId          =   ((TqmTestcaseplanstatus)tep.getTqmTestcaseplanstatus()).getStatusid();
                java.util.Date startDate      =   tep.getPlannedstart();
                java.util.Date endDate        =   tep.getPlannedend();
                java.util.Date actualstartDate      =   tep.getActualstart();
                java.util.Date actualendDate        =   tep.getActualend();
                SimpleDateFormat dfm =  new SimpleDateFormat("d-M-yyyy");

                String startdate    =   dfm.format(startDate);
                String enddate      =   dfm.format(endDate);

                String actualstartdate    =   "NA";
                String actualenddate      =   "NA";
                if(actualstartDate!=null){
                    actualstartdate =   dfm.format(actualstartDate);
                }
                if(actualendDate!=null){
                    actualenddate =   dfm.format(actualendDate);
                }

            %>
            <table width="60%" bgColor=#E8EEF7 border="0" align="center">
                <tr>
                    <td><b>Plan Name</b><input type="hidden" id="planId" name="planId" value="<%=planId%>"/></td>
                    <td><input type="text" id="planname" name="planname" value="<%=planNamme%>"/></td>
               
                    <td><b>Project</b></td>
                    <td>
                        
                            <%
                            LinkedHashMap lhp=GetProjectMembers.sortHashMapByValues(projectList,true);
                            Collection se=lhp.keySet();
                            Iterator iter=se.iterator();
                            while (iter.hasNext()) {

                              int key=(Integer)iter.next();
                              String nameofproject=(String)lhp.get(key);
                              if(key==project){
                            %>
                            <input type="text" value="<%=nameofproject%>" name="project" id="project" readonly/>
                            <%}
                        }
                        %>
                      
                    </td>
                </tr>
                <tr>
                    <td><b>Build No</b></td>
                    <td><input type="text" id="buildno" name="buildno" value="<%=buildNo%>" readonly/></td>
    
                <%
                // Select Project from DB
                HashMap userList   =   GetProjectMembers.getProjectManagers(((Integer)project).toString());
             %>
               
                    <td width="15%"><b>Quality Manager</b></td>
                    <td>
                        <select id="manager" name="manager">
                            
                             <%
                            LinkedHashMap lhpUsers=GetProjectMembers.sortHashMapByValues(userList,true);
                            Collection set=lhpUsers.keySet();
                            Iterator itera=set.iterator();
                            while (itera.hasNext()) {

                              int key=(Integer)itera.next();
                              String nameofUsers=(String)lhpUsers.get(key);
                             if(key==qm){
                            %>
                            <option value="<%=key%>" selected><%=nameofUsers%></option>
                            <%}else{
                                                          %>
                            <option value="<%=key%>"><%=nameofUsers%></option>
                            <%}
                        
}
                            %>
                        </select>
                    </td>
                </tr>
                <tr>
			<td width="10%"><strong>Planned Start Date</strong></td>
			<td width="40%"><input type="Text" name="startdate" id="startdate" value="<%=startdate%>"readonly="true" maxlength="25" size="10">&nbsp;
			</td>
	
			<td width="10%"><strong>Planned End Date</strong></td>
			<td width="40%"><input type="Text" readonly="true" name="enddate" id="enddate" value="<%=enddate%>" maxlength="25" size="10">&nbsp;</td>
		</tr>
                <tr>
			<td width="10%"><strong>Actual Start Date</strong></td>
			<td width="40%"><input type="Text" name="startdate" id="startdate" value="<%=actualstartdate%>"readonly="true" maxlength="25" size="10">&nbsp;
			</td>
	
			<td width="10%"><strong>Actual End Date</strong></td>
			<td width="40%"><input type="Text" readonly="true" name="enddate" id="enddate" value="<%=actualenddate%>" maxlength="25" size="10">&nbsp;</td>
		</tr>
                <tr>
                   
                <%
                // Select Project from DB
                HashMap statusList   =   TestCasePlan.viewAllStatus();
                if(statId>0){
                    statusList.remove((Integer)0);
                }
                float completion   =   TestCasePlan.calculatePercentage(planId);
                if(completion<100){
                    statusList.remove((Integer)3);
                }
               
            %>

                    <td width="15%"><b>Status</b></td>
                    <td>
                        <select id="status" name="status">

                             <%
                          
                              Collection setStatusId=statusList.keySet();
                               Iterator iteratorStatus=setStatusId.iterator();
                             while (iteratorStatus.hasNext()){
                                 int statusId=(Integer)iteratorStatus.next();
                                 String statusName=(String)statusList.get(statusId);
                            
                             

                             if(statId==statusId){
                            %>
                            <option value="<%=statusId%>" selected><%=statusName%></option>
                            <%}else{
                                                          %>
                            <option value="<%=statusId%>"><%=statusName%></option>
                            <%}

}
                            %>
                        </select>
                    </td>
                </tr>
                <tr>
			<td width="15%"><strong>Modules</strong></td>
                        <%
        HashMap moduleList=TestCasePlan.getNonAssignedModules(((Integer)project).toString(),planId);
%>
			<td><SELECT id="modules" NAME="modules"
				 style="width: 200" width="200"
				size="6">
				<%
                            LinkedHashMap lhpModules=GetProjectMembers.sortHashMapByValues(moduleList,true);
                            Collection setModule=lhpModules.keySet();
                            Iterator iteratorModules=setModule.iterator();
                            while (iteratorModules.hasNext()) {

                              int key=(Integer)iteratorModules.next();
                              String nameofModule=(String)lhpModules.get(key);
                             
                         %>
                            <option value="<%=key%>" ><%=nameofModule%></option>
                            <%

}
                            %>
			</SELECT></td>

                        <td>
                            <p align="center"><input type="button" onClick="one2two()"	value=" >> "></p>
                            <p align="center"><input type="button" onClick="two2one()"	value=" << "></p>
                        </td>
                         <%
        HashMap moduleListAss=TestCasePlan.getAssignedModules(((Integer)project).toString(),planId);
%>
				                                            <td align="left"><select id=modulesFinal name=modulesFinal
						style="width: 200" width="200" size="6" multiple>
                                                                                    				<%
                            LinkedHashMap lhpAssModules=GetProjectMembers.sortHashMapByValues(moduleListAss,true);
                            Collection setAssModule=lhpAssModules.keySet();
                            Iterator iteratorAssModules=setAssModule.iterator();
                            while (iteratorAssModules.hasNext()) {

                              int key=(Integer)iteratorAssModules.next();
                              String nameofModule=(String)lhpAssModules.get(key);
                              if(TestCasePlan.checkModulePTC((Integer)project, planId, key)>0){
                         %>
                         <option value="<%=key%>" disabled><%=nameofModule%></option>
                            <%
                            }else{
                           %>
                         <option value="<%=key%>" ><%=nameofModule%></option>
                            <%
                            }

}
                            %>


                                                                                </select>

					</td>


		</tr>
                <tr>
                    <td align=right></td>
                    <td align="right"><INPUT type=submit id="submit" value=Update name=submit></td>
                            <td><INPUT type=reset id="reset" value=" Reset "></td>
                </tr>
                <%
                    }catch(Exception e){
                        logger.error(e.getMessage());
                        }




%>
            </table>
        </form>
    </body>
</html>


<%-- 
    Document   : executionPlan
    Created on : 18 Mar, 2010, 10:05:11 AM
    Author     : TAMILVELAN
--%>
<%@page import="com.eminent.util.GetProjects"%>
<%@page import="java.util.Map"%>
<%@page  import="com.eminent.tqm.TestCasePlan,com.eminent.util.GetProjectMembers,java.util.HashMap,java.util.LinkedHashMap,java.util.Collection,java.util.Iterator,com.eminent.issue.Project"%>
<%
//Configuring log4j properties
	

	Logger logger = Logger.getLogger("Execution Plan");
	
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
           var plannameCheck;
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
                if (trim(document.getElementById("planname").value).length>125)
                {
                        alert ( "Test Execution Plan Name should be lesser than 125 characters" );
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
                testPlanValidate();
                if(plannameCheck!=undefined){
                if (plannameCheck !== "") {
                            alert(plannameCheck);
                            document.getElementById("buildno").focus();
                            return false;
                        }
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
        var str   = document.executionpaln.startdate.value;
        var first = str.indexOf("-");
        var last  = str.lastIndexOf("-");
        var year         = str.substring(last+1,last+5);
        var month        = str.substring(first+1,last);
        var date         = str.substring(0,first);
        var form_date    = new Date(year,month-1,date);
        var current_date = new Date();

        str   = document.executionpaln.enddate.value;
        first = str.indexOf("-");
        last  = str.lastIndexOf("-");

        year      = str.substring(last+1,last+5);
        month     = str.substring(first+1,last);
        date      = str.substring(0,first);
        var end_date = new Date(year,month-1,date);

	if ((executionpaln.startdate.value)=='')
        {
    		alert('Please enter the Start date of the Execution Plan ');
		executionpaln.startdate.focus();
    		return false;
  	}
        if(form_date.getYear() < current_date.getYear())
        {
                window.alert("Enter the valid Start Date");
                executionpaln.startdate.focus();
                return false;
	}
        if(form_date.getYear() == current_date.getYear())
        {
	    if(form_date.getMonth() < current_date.getMonth())
            {
                    window.alert("Enter the valid Start Date");
                    executionpaln.startdate.focus();
                    return false;
	    }
	    if(form_date.getMonth() == current_date.getMonth())
	    {
	    	if(form_date.getDate() < current_date.getDate())
            	{
                    window.alert("Enter the valid Start Date");
                    executionpaln.startdate.focus();
                    return false;
	    	}
	    }
	}
        if ((executionpaln.enddate.value)=='')
        {
            alert('Please enter End date of the Execution Plan ');
            executionpaln.enddate.focus();
            return false;
	}
        if(end_date < form_date)
        {
            alert('Please enter the valid End Date');
            executionpaln.enddate.focus();
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
       var xmlhttpPlan;
       
            function testPlanValidate() {
                var planname = document.getElementById("planname").value;
                var buildno = document.getElementById("buildno").value;
                var project = document.getElementById("project").value;
                xmlhttpPlan = createRequest();
                if (xmlhttpPlan !== null) {
                    xmlhttpPlan.open("GET", "/eTracker/admin/tqm/checkPlanName.jsp?planname=" + planname + "&buildno=" + buildno + "&project=" + project + "&rand=" + Math.random(1, 10), false);
                    xmlhttpPlan.onreadystatechange = function() {
                        callbackPlanValidate();
                    };
                    xmlhttpPlan.send(null);
                } else {
                    alert('no ajax request');
                }
            }
            function callbackPlanValidate() {
                if (xmlhttpPlan.readyState === 4)
                {
                    if (xmlhttpPlan.status === 200)
                    {
                        var comp = xmlhttpPlan.responseText;
                        plannameCheck=comp;
                        

                    }
                }
            }
 
        </script>
    </head>
    <body>
        <form name="executionpaln" onsubmit="return validate(this)" action="createExecutionPlan.jsp" method="post">
            <table width="100%">
                <tr bgcolor="#C3D9FF">
                    <td><b>Create New Test Execution Plan</b></td>
                </tr>
            </table>
            <br>
            <br>
            <br>
            <br>

            <%
            String projectId=request.getParameter("pid");
            int pId  =   Integer.valueOf(projectId);
            String project      = GetProjects.getProjectName(projectId); 
            HashMap managerList=GetProjectMembers.getProjectManagers(projectId);
            HashMap moduleList=GetProjects.getModules(projectId);    
                
              
            %>
            <table width="60%" bgColor=#E8EEF7 border="0" align="center">
                <tr>
                    <td><b>Plan Name</b></td>
                    <td><input type="text" id="planname" name="planname" maxlength="125"/></td>
                
                    <td><b>Project</b></td>
                    <td>
                        <input type="text" name="projectname" value="<%=project%>" readonly />
                    </td>
                </tr>
                <tr>
                    <td><b>Build No</b></td>
                    <td><input type="text" id="buildno" name="buildno" onchange="testPlanValidate();"/></td>

                               
                    <td width="15%"><b>Quality Manager</b></td>
                    <td>
                        <select id="manager" name="manager">
                             <%
                            LinkedHashMap lhp=GetProjectMembers.sortHashMapByValues(managerList,true);
                            Collection se=lhp.keySet();
                            Iterator iter=se.iterator();
                            while (iter.hasNext()) {
                                int key=(Integer)iter.next();
                              String name=(String)lhp.get(key);
                            %>
                            <option value="<%=key%>"><%=name%></option>
                            <%}
                            %>
                        </select>
                    </td>
                </tr>
                <tr>
			<td width="10%"><strong>Start Date</strong></td>
			<td width="40%"><input type="Text" name="startdate"
				id="startdate" readonly="true" maxlength="25" size="15">&nbsp;
			<a href="javascript:NewCal('startdate','ddmmyyyy')"><img
				src="<%=request.getContextPath()%>/images/newhelp.gif" width="16" height="16" border="0"
				alt="Pick a date"></a></td>
	
			<td width="10%"><strong>End Date</strong></td>
			<td width="40%"><input type="Text" readonly="true" name="enddate" id="enddate"
				maxlength="25" size="15">&nbsp; <a
				href="javascript:NewCal('enddate','ddmmyyyy')"><img
				src="<%=request.getContextPath()%>/images/newhelp.gif" width="16" height="16" border="0"
				alt="Pick a date"></a></td>
		</tr>
                <tr>
			<td width="15%"><strong>Modules</strong></td>
			<td><SELECT id="modules" NAME="modules"
				 style="width: 200" width="200"
				size="6">
				<%
                            LinkedHashMap lhpa=GetProjectMembers.sortHashMapByValues(moduleList,true);
                            Collection sea=lhpa.keySet();
                            Iterator itera=sea.iterator();
                            while (itera.hasNext()) {
                                String key=(String)itera.next();
                                String name=(String)lhpa.get(key);
                            %>
                            <option value="<%=key.trim()%>"><%=name.trim()%></option>
                            <%}
                            %>
				
			</SELECT></td>
                       
                        <td>
                            <p align="center"><input type="button" onClick="one2two()"	value=" >> "></p>
                            <p align="center"><input type="button" onClick="two2one()"	value=" << "></p>
                        </td>
				                                            <td align="left"><select id=modulesFinal name=modulesFinal
						style="width:150px" width="200" size="6" multiple></select>

					</td>

					
		</tr>
                <tr>
                    <td align=right><input type="hidden" name="project" id="project" value="<%=pId%>"></td>
                    <td align=right><INPUT type=submit id="submit" value=Submit name=submit></td>
                    <td><INPUT type=reset id="reset" value=" Reset "></td>
                </tr>
            </table>
        </form>
    </body>
</html>

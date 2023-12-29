<%@ page import="java.util.*" language="java"
	contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="org.apache.log4j.*"%>

<%
//Configuring log4j properties

	

	Logger logger = Logger.getLogger("Add New Project");
	
	String logoutcheck=(String)session.getAttribute("Name");
	if(logoutcheck==null)
	{
		%>
<jsp:forward page="../SessionExpired.jsp"></jsp:forward>
<%
	}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
<meta http-equiv="Content-Type" content="text/html ">
<LINK title=STYLE
	href="<%= request.getContextPath() %>/eminentech support files/main_ie.css"
	type="text/css" rel=STYLESHEET>
<title>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS
Solution</title>
<script language=javascript
	src="<%= request.getContextPath() %>/eminentech support files/datetimepicker.js"></script>
<script language="JavaScript">
     
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
            var m1 = document.theForm.teamSelect;
            var m2 = document.theForm.teamFinal;
            m1len = m1.length ;
            teamFinalLength = m2.length;
            var flag = isRepeat(m1, m2);
            
        if( flag == true) {
            alert('There is a repetition in the selection');
        } else {    
            for ( i = 0; i < m1len ; i++ ) {
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
            var m1 = document.theForm.teamSelect;
            var m2 = document.theForm.teamFinal;
            m2len = m2.length ;
            teamLength = m1.length;
            teamSelectLength = m2.length;
            pM = false;
            for ( i = 0; i < m2len ; i++ ) {
                if(m2.options[i].selected == true && (m2.options[i].value == document.getElementById("projectManager").value)){
                    pM = true;
                    alert('This selection includes the PM. So change the PM')
                } 
            
            }
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
    
        
	function addPM(name){
            var m2 = document.theForm.teamFinal;
            teamFinalLength = m2.length;
            var pM = document.getElementById(name).value;
            var flag = true;
            if ( teamFinalLength != 0){
                for ( i = 0; i < teamFinalLength ; i++ ) {
                   if( pM == m2.options[i].value ){
                       flag = false;
                   }
                }
            }
            if( flag == true) {
                userName(name);
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
        
        function userName(name)
	{
        xmlhttp = createRequest();
        if (!xmlhttp && typeof XMLHttpRequest!='undefined') 
        {
            xmlhttp = new XMLHttpRequest();
        }
        if(xmlhttp != null)
        {
            
            var pM = document.getElementById(name).value;
            xmlhttp.open("GET","getUser.jsp?userId="+pM+"&rand="+Math.random(1,10), true);
            xmlhttp.onreadystatechange = function () {callbackUserName(name);}
            xmlhttp.send(null);
        }
	}


	function callbackUserName(name)
	{
              if (xmlhttp.readyState == 4) 
	    {
                if (xmlhttp.status == 200) 
          	{
       
                var nameofuser = xmlhttp.responseText.split(",");
                var m2 = document.theForm.teamFinal;
                teamFinalLength = m2.length;
                var pM = document.getElementById(name).value;
            
                m2.options[teamFinalLength]= new Option(nameofuser[1],pM);
          	}
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
                document.theForm.totalhours.value=name[1];
          	}
    	}
	}
        
                    
        function duplicateProject()
	{
        xmlhttp = createRequest();
        if (!xmlhttp && typeof XMLHttpRequest!='undefined') 
        {
            xmlhttp = new XMLHttpRequest();
        }
        if(xmlhttp != null)
        {
            var project = document.theForm.pname.value;
            var version = document.theForm.versionInfo.value;
            xmlhttp.open("GET","projectexist.jsp?project="+project+"&version="+version+"&rand="+Math.random(1,10), true);
            xmlhttp.onreadystatechange = callWarn;
            xmlhttp.send(null);
        }
	}


	function callWarn() 
	{
    	if (xmlhttp.readyState == 4) 
	    {
			if (xmlhttp.status == 200) 
          	{
                var name = xmlhttp.responseText.split(",");
                var flag = name[1];
                
                if(flag == 'yes'){
            
                    alert("This project is already present. So please enter something else");
                    document.theForm.pname.value = "";
                    document.theForm.versionInfo.value = "";
                    theForm.pname.focus(); 
                }
            
          	}
    	}
	}

                    
	function selectteams()
	{
    	xmlhttp = createRequest();
        if (!xmlhttp && typeof XMLHttpRequest!='undefined') 
        {
        	xmlhttp = new XMLHttpRequest();
       	}
        if(xmlhttp != null)
        {
        	var opt = document.theForm.team
            var numofoptions = opt.length
            var selValue = new Array
            var j = 0
            for (i=0; i<numofoptions; i++)
            {
            	if (opt[i].selected === true)
                {
                	selValue[j] = opt[i].value
                    j++
                }
          	}
            selValue = selValue.join(",");
            xmlhttp.open("GET","getTeamMembers.jsp?selValue="+selValue+"&rand="+Math.random(1,10), true);
            xmlhttp.onreadystatechange = callbackTeam;
            xmlhttp.send(null);
      	}
	}

	function callbackTeam() 
	{
    	if (xmlhttp.readyState == 4) 
    	{
	  		if (xmlhttp.status == 200) 
          	{
            	var name = xmlhttp.responseText;
                var results = xmlhttp.responseText.split(";");
                var objLinkList 	= eval("document.getElementById('TeamSelect')");
               
   //             objLinkList.length=0;
               
                for(i=0;i<results.length-1;i++)
                {
                    var select=results[i].split(",");
                    objLinkList.length++;
                    objLinkList[i].text =select[0];
                    objLinkList[i].value = select[1];
             	}
	   		}
    	}
	}
</script>
</head>

<!-- Start Of Java Script For Front End Validation -->

<SCRIPT language=JAVASCRIPT type="text/javascript">


	/** Java Script Function For Trimming A String To Get Only The Required String Input */

	function Activatetype() 
	{
		if (document.getElementById('category').value == '--Select One--') 
    	{
	        alert("The first \"Select\" option is not a valid selection. Please choose a (whatever).");
	        document.getElementById('category').focus();
	        return false;
    	}
	
		document.getElementById("projecttypelabel").style.visibility="hidden";
    	document.getElementById("projecttypelabel").style.position="absolute";                 
	    document.getElementById("projecttypelabel").value = "hello";
    	
    	if (document.getElementById('category').value == 'SAP Project') 
    	{
			document.getElementById("projecttypelabel").style.visibility="visible";
	        document.getElementById("projecttypelabel").style.Position="relative";
	        document.getElementById('projecttype').style.visibility = 'visible';
	        document.getElementById('projecttype').style.display = '';
	        document.getElementById('projecttype').disabled=false;
	        document.getElementById('projecttype').focus();
	        
	        return true;
    	}
	    else 
    	{
			document.getElementById("projecttypelabel").style.visibility="hidden";
	        document.getElementById("projecttypelabel").style.Position="relative";
	        document.getElementById('projecttype').disabled=true;
	        document.getElementById('projecttype').style.visibility = 'hidden';
	        document.getElementById('projecttype').style.display = 'none';
	        return true;
	    }
    	return true;
	}

	function Activate() 
	{
	    if (document.theForm.platform.value == '--Select One--') 
	    {
	        alert("The first \"Select\" option is not a valid selection. Please choose a (whatever).");
	        document.theForm.platform.focus();
	        return false;
	    }
	    if (document.theForm.platform.value == 'Others') 
	    {
	        document.theForm.platforms.style.visibility = 'visible';
	        document.theForm.platforms.style.display = '';
	        document.theForm.platforms.disabled=false;
	        document.theForm.platforms.focus();
	        document.theForm.platforms.select();
	        return true;
	    }
	    else 
	    {
	        document.theForm.platforms.disabled=true;
	        document.theForm.platforms.style.visibility = 'hidden';
	        document.theForm.platforms.style.display = 'none';
	        return true;
	    }
	    return true;
	}

	function trim(str)  
	{
	    while (str.charAt(str.length - 1)==" ") 
	   	str = str.substring(0, str.length - 1); 
	  	while (str.charAt(0)==" ") 
	    str = str.substring(1, str.length); 
	  	return str; 
	} 

	function isNumber(str)  
	{
		var pattern = "0123456789." 
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
 
	/** Function To Check Whether There Is Any Integer Present In The Form Input From The User */
	
	function isPositiveInteger(str)  
	{
		var pattern = "abcdefghijklmnopqrstuvwxyz. ABCDEFGHIJKLMNOPQRSTUVWXYZ-'" 
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

	function isPositiveInteger1(str)  
	{
		var pattern = "abcdefghijklmnopqrstuvwxyz. ABCDEFGHIJKLMNOPQRSTUVWXYZ-1234567890" 
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

	/** Function To Validate The Input Form Data */
	function fun(theForm)  
	{
  		if ( document.theForm.category.selectedIndex == 0 )
       	{
        	alert ( "Please select category." );
			return false;
    	}
        if (document.getElementById("category").value=="--Select Category--")
    	{
        	alert ( "Please select category." );
			return false;
    	}
        
        if (document.getElementById("customer").value=="--Select Customer--")
        {
    		alert('Please select the Customer Name ');
		theForm.customer.focus();
    		return false;
  	}
  	
        if ( document.theForm.platform.selectedIndex == 0 )
    	{
        	alert ( "Please select platform." );
			return false;
    	}
        if (document.getElementById("platform").value=="--Select One--")
    	{
        	alert ( "Please select platform." );
			return false;
    	}
		var x=document.getElementById("platform");
		if ((document.getElementById("platform").value=="Others") && theForm.platforms.value=='')
		{
    		alert('Please enter the  Platform');
    		theForm.platforms.focus();
    		return false;
		}
        if ((document.getElementById("platform").value=="Others") && !isPositiveInteger(trim(theForm.platforms.value)))
        {
	   		alert('Please enter the Alphabetical only in the Platform ');
			document.theForm.platforms.value="";
            theForm.platforms.focus();
            return false;
  		}
		/** This Loop Checks Whether There Is Any Integer Present In The Project Name Field */
		if ((theForm.pname.value)=='')  
		{
			alert('Please enter the project name '); 
			document.theForm.pname.value="";
			theForm.pname.focus();  
    		return false; 
		}
		if (!isPositiveInteger1(trim(theForm.pname.value)))  
		{
			alert('Please enter the Alphabetical only in the ProjectName '); 
			document.theForm.pname.value="";
   			theForm.pname.focus(); 
    		return false; 
		} 
        /** This Loop Checks Whether There Is Any Input Data Present In The Version Info Field */
		if ((theForm.versionInfo.value)=='')  
        {
	   		alert('Please enter the Version Info '); 
	   		document.theForm.versionInfo.value="";
	   		theForm.versionInfo.focus();  
    		return false; 
  		}
	  	if ((theForm.versionInfo.value.indexOf('.'))==-1 || (theForm.versionInfo.value.indexOf('.'))==0)
  		{
	   		alert('Please enter the Version Info with Valid data '); 
	   		document.theForm.versionInfo.value="";
	   		theForm.versionInfo.focus();  
            return false; 
        }
	  	if ((theForm.versionInfo.value.indexOf('0'))==0)
  		{
	   		alert('Please Enter the version info with valid data '); 
	   		document.theForm.versionInfo.value="";
	   		theForm.versionInfo.focus();  
    		return false; 
	  	}
		if (!isNumber(trim(theForm.versionInfo.value)))  
        {
    		alert('Please enter number only in the "versionInfo" box'); 
			document.theForm.versionInfo.value="";
    		theForm.versionInfo.focus(); 
    		return false; 
  		} 
         if ( document.theForm.phase.selectedIndex == 0 )
            {
                alert ( "Please select the phase." );
				return false;
            }
		    if (document.getElementById("phase").value=="--Select Phase--")
            {
               	alert ( "Please select Phase." );
				return false;
            }
             if ((document.getElementById("executiveSponsorer").value)=="--Select Manager--")
        {
    		alert('Please select the Executive Sponsorer name');
                theForm.executiveSponsorer.focus();
    		return false;
        }
        if ((document.getElementById("projectStakeholder").value)=="--Select Manager--")
        {
    		alert('Please enter the Project Stakeholder name');
                theForm.projectStakeholder.focus();
    		return false;
        }
        if ((document.getElementById("projectCoordinator").value)=="--Select Manager--")
        {
    		alert('Please enter the Project Coordinator name');
                theForm.projectCoordinator.focus();
    		return false;
        }
        if ((document.getElementById("accountManager").value)=="--Select Manager--")
        {
    		alert('Please enter the Account Manager name');
                theForm.accountManager.focus();
    		return false;
        }
        if ((document.getElementById("deliveryManager").value)=="--Select Manager--")
        {
    		alert('Please enter the Delivery Manager name');
                theForm.deliveryManager.focus();
    		return false;
        }
        if ((document.getElementById("projectManager").value)=="--Select Manager--")
        {
    		alert('Please enter the Project Manager name');
            theForm.projectManager.focus();
    		return false;
        }
	  
       
	 	
	  	/** This Loop Checks Whether There Is Any Input Data Present In The Project Manager Field */
	
	  	
                
        var str   = document.theForm.startdate.value;
        var first = str.indexOf("-");
        var last  = str.lastIndexOf("-");
        var year         = str.substring(last+1,last+5);
        var month        = str.substring(first+1,last);
        var date         = str.substring(0,first);
        var form_date    = new Date(year,month-1,date);
        var current_date = new Date();
	
        str   = document.theForm.enddate.value;
        first = str.indexOf("-");
        last  = str.lastIndexOf("-");
	
        year      = str.substring(last+1,last+5);
        month     = str.substring(first+1,last);
        date      = str.substring(0,first);
        var end_date = new Date(year,month-1,date);	
     
	  	if ((theForm.startdate.value)=='')  
        {
    		alert('Please enter the Start date of project '); 
			theForm.startdate.focus(); 
    		return false; 
  		}
        if(form_date.getYear() < current_date.getYear())
        {
			window.alert("Enter the valid Start Date");
			theForm.startdate.focus(); 
			return false;
		}
		if(form_date.getYear() == current_date.getYear())
        {
	    	if(form_date.getMonth() < current_date.getMonth())
            {
	    		window.alert("Enter the valid Start Date");
				theForm.startdate.focus(); 
				return false;
	    	}
	    	if(form_date.getMonth() == current_date.getMonth())
			{
	    		if(form_date.getDate() < current_date.getDate())
            	{
	    			window.alert("Enter the valid Start Date");
					theForm.startdate.focus(); 
					return false;
	    		}
	    	}
	    }
        if ((theForm.enddate.value)=='')  
        {
        	alert('Please enter End date of the project '); 
            theForm.enddate.focus(); 
            return false; 
		}
        if(end_date < form_date)
        {
	  		alert('Please enter the valid End Date');
			theForm.enddate.focus(); 
			return false; 	
       	}
       
            if (!isNumber(trim(theForm.totalhours.value)))  
            {
            	alert('Please enter the Total Hours in Numbers'); 
				document.theForm.totalhours.value="";
                theForm.totalhours.focus(); 
                return false; 
            }
            if ((theForm.totalhours.value)=='')  
            {
              	alert('Please enter the Total Hours '); 
	   			theForm.totalhours.focus(); 
            	return false; 
            }
           
            var n = document.getElementById('teamFinal').options.length
            if (n==0)
            {
                alert("please select the Team Members");
                return false;
            }
            var teamFinal = document.getElementById("teamFinal");
			var teamFinalOptions = teamFinal.options;
		  	var teamFinalOLength = teamFinalOptions.length;
	  		if (teamFinalOLength < 1) {
			    alert("No Selections in the team\nPlease Select using the [Add] button");
			    return false;
  			}
			for (var i = 0; i < teamFinalOLength; i++) {
    			teamFinalOptions[i].selected = true;
  			}
			return true;
            
            return true;
	}
	
	/** Function To Set Focus On The Project Name Field In The Form */
	
	function setFocus()  
	{
		document.theForm.pname.focus();
	}
	window.onload = setFocus;
//-->

</SCRIPT>

<!-- End Of Java Script Code -->

<body>

<!-- Declaring The Form And Its Attributes -->

<FORM name=theForm onsubmit="return fun(this)"
	action="<%=request.getContextPath() %>/admin/project/newproject.jsp"
	method=post onReset="return setFocus()"><!-- Table To Display Current User And The Links For User Profile, Mails, And Logout -->

<%@ include file="/header.jsp"%>
<%@ page import="java.sql.*,com.eminent.util.GetProjects,pack.eminent.encryption.*,com.eminent.util.GetProjectMembers,java.util.HashMap"%>
<%!
	Connection connection=null;
	ResultSet userResult=null;
	
%>
<%
    HashMap pm  =   GetProjectMembers.getAllMembers();

    HashMap am  =   (HashMap)pm.clone();
    HashMap es  =   (HashMap)pm.clone();
    HashMap ps  =   (HashMap)pm.clone();
    HashMap pc  =   (HashMap)pm.clone();
    HashMap dm  =   (HashMap)pm.clone();
    
%>
<div align="center">
<center><!-- Table To Display The Formatted String "Add New Project" -->
<table cellpadding="0" cellspacing="0" width="100%">
	<tr border="2" bgcolor="C3D9FF">
		<td border="1" align="left" width="100%"><font size="4"
			COLOR="#0000FF"><b> Add New Project</b></font> <FONT SIZE="3"
			COLOR="#0000FF"> </FONT></td>
	</tr>
</table>
<br>
<br>
<br>
<br>
<!-- Table To Display The Form Input Elements Project Name, Version, Project Manager, Customer  And The Submit, Reset Buttons-->
<TABLE width="100%" bgColor=#E8EEF7 border="0" align="center">
	<TBODY>
		<tr>
			<td width="15%"><strong>Category</strong></td>
			<td align="left" width="20%"><SELECT NAME="category" size="1"
				onChange="javascript:redirect(this.options.selectedIndex);javascript:Activatetype(this.value)">
				<option value="--Select One--" selected>--Select Category--</option>
				<option value="SAP Project">SAP Project</option>
				<option value="Project">Project</option>
				<option value="Product">Product</option>
				<option value="Outsource">OutSource</option>
			</SELECT></td>
			<td>
			<div id="projecttypelabel"	style="position: absolute; visibility: hidden"><B>Type</B></div>
			</td>
			<td><select id="projecttype" name="projecttype" size="1"
				disabled="disabled"
				onChange="javascript:redirect1(this.options.selectedIndex)">
				<option value="--Select One--" selected>--Select Type--</option>
				<option value="Implementation">Implementation</option>
				<option value="Upgradation">Upgradation</option>
				<option value="Support">Support</option>
			</select> <script language="javascript">
				document.getElementById('projecttype').style.visibility = 'hidden'; 
				document.getElementById('projecttype').style.display = 'none';
			</script> <input type="hidden" name="isTestingSubmit" value="true" /></td>
		</tr>
                <tr>
			<td width="15%"><strong>Customer</strong></td>
			<td>
                            <select name="customer" id="customer">
                                <option value="--Select Customer--">--Select Customer--</option>
                                <%
                                String customer[]   =   GetProjects.getCustomer();
                                for(int l=0;l<customer.length;l++){

                                    %>
                                    <option value="<%=customer[l]%>"><%=customer[l]%></option>
                                    <%
                                    }

                                %>
                            </select>

                        </td>
              
			<td width="15%"><strong>Platform </strong></td>
			<td align="left" width="20%"><SELECT NAME="platform" size="1"
				onChange="Activate(this.value);">
				<option value="--Select One--" selected>--Select One--</option>
				<option value="Windows">Windows</option>
				<option value="Unix">Unix</option>
				<option value="Linux">Linux</option>
				<option value="Mac">Mac</option>
				<option value="Others">Others</option>
			</SELECT></td>
			<td><input type="text" name="platforms" id="myval2"
				maxlength="20" size=20 disabled="disabled" style="height: 25px;" />
			<script language="javascript">
					document.getElementById('myval2').style.visibility = 'hidden';
					document.getElementById('myval2').style.display = 'none';
				</script> <input type="hidden" name="isTestSubmit" value="true" /></td>
		</tr>
		<tr>
			<td width="15%"><strong>Project Name </strong></td>
			<td><input type="text" name="pname" maxlength="20" size=25><strong
				class="style20"></strong></td>
		
			<td width="15%"><strong>Version Info </strong></td>
			<td><input type="text" name="versionInfo" maxlength="15" size=25 onblur="javascript:duplicateProject()"><span
				class="style13"></span></td>
                        <td width="15%"><strong>Phase</strong></td>
			<td align="left" width="20%"><SELECT id="phase" NAME="phase"
				size="1">
				<option value=" " selected>--Select Phase--</option>

			</SELECT></td>
		</tr>
               
                <tr>
                    <td width="15%"><strong>Executive Sponsorer</strong></td>
                    <td>
                        <select name="executiveSponsorer" size="1" onchange="addPM('executiveSponsorer') ">
				<option value="--Select Manager--" selected>--Select Executive Sponsorer--</option>
                                <%
                                        Collection setES=es.keySet();
			    		Iterator iterES = setES.iterator();
                                        while (iterES.hasNext()) {
                                              int key=(Integer)iterES.next();
                                              String nameofuser=(String)es.get(key);
                                 %>
                                               <option value="<%=key%>"><%=nameofuser %></option>
                                 <%
                                        }
                                %>
                        </select>
                    </td>
                
                    <td width="15%"><strong>Project Stakeholder</strong></td>
                    <td>
                         <select name="projectStakeholder" size="1" onchange="addPM('projectStakeholder') ">
				<option value="--Select Manager--" selected>--Select Project Stakeholder--</option>
                                 <%
                                        Collection setPS=ps.keySet();
			    		Iterator iterPS = setPS.iterator();
                                        while (iterPS.hasNext()) {
                                              int key=(Integer)iterPS.next();
                                              String nameofuser=(String)ps.get(key);
                                 %>
                                               <option value="<%=key%>"><%=nameofuser %></option>
                                 <%
                                        }
                                %>
                        </select>
                    </td>
                
                    <td width="15%"><strong>Project Coordinator</strong></td>
                    <td>
                         <select name="projectCoordinator" size="1" onchange="addPM('projectCoordinator') ">
				<option value="--Select Manager--" selected>--Select Project Coordinator--</option>
                                <%
                                        Collection setPC=pc.keySet();
			    		Iterator iterPC = setPS.iterator();
                                        while (iterPC.hasNext()) {
                                              int key=(Integer)iterPC.next();
                                              String nameofuser=(String)pc.get(key);
                                 %>
                                               <option value="<%=key%>"><%=nameofuser %></option>
                                 <%
                                        }
                                %>
                        </select>
                    </td>
              </tr>
                  <tr>
                    <td width="15%"><strong>Account Manager</strong></td>
                    <td>
                         <select name="accountManager" size="1" onchange="addPM('accountManager') ">
				<option value="--Select Manager--" selected>--Select Account Manager--</option>
                                 <%
                                        Collection setAM=am.keySet();
			    		Iterator iterAM = setAM.iterator();
                                        while (iterAM.hasNext()) {
                                              int key=(Integer)iterAM.next();
                                              String nameofuser=(String)am.get(key);
                                 %>
                                               <option value="<%=key%>"><%=nameofuser %></option>
                                 <%
                                        }
                                %>
                        </select>
                    </td>
                
                    <td width="15%"><strong>Delivery Manager</strong></td>
                    <td>
                        <select name="deliveryManager" size="1" onchange="addPM('deliveryManager') ">
				<option value="--Select Manager--" selected>--Select Delivery Manager--</option>
                                <%
                                        Collection setDM=dm.keySet();
			    		Iterator iterDM = setDM.iterator();
                                        while (iterDM.hasNext()) {
                                              int key=(Integer)iterDM.next();
                                              String nameofuser=(String)dm.get(key);
                                 %>
                                               <option value="<%=key%>"><%=nameofuser %></option>
                                 <%
                                        }
                                %>
                        </select>
                    </td>
               
			<td width="15%"><strong>Project Manager</strong></td>
			<%
                                String name = null;
                         %>
			<td><select name="projectManager" size="1" onchange="addPM('projectManager') ">
				<option value="--Select Manager--" selected>--Select Project
				Manager--</option>
				 <%
                                        Collection setPM=pm.keySet();
			    		Iterator iterPM = setPM.iterator();
                                        while (iterPM.hasNext()) {
                                              int key=(Integer)iterPM.next();
                                              String nameofuser=(String)pm.get(key);
                                 %>
                                               <option value="<%=key%>"><%=nameofuser %></option>
                                 <%
                                        }
                                %>
			</select></td>

		</tr>
		
		<tr>
			<td width="15%"><strong>Start Date</strong></td>
			<td width="20%"><input type="Text" name="startdate"
				id="startdate" readonly="true" maxlength="25" size="25"><a href="javascript:NewCal('startdate','ddmmyyyy')"><img
				src="images/newhelp.gif" width="16" height="16" border="0"
				alt="Pick a date"></a></td>
		
			<td width="15%"><strong>End Date</strong></td>
			<td width="20%"><input type="Text" readonly="true" name="enddate" id="enddate"
				maxlength="25" size="25"><a
				href="javascript:NewCal('enddate','ddmmyyyy')"><img
				src="images/newhelp.gif" width="16" height="16" border="0"
				alt="Pick a date"></a></td>
                        <td width="15%"><strong>Total Hours</strong></td>
			<td><input type="text" id="totalhours" name="totalhours"
				maxlength="30" size=25 onClick="javascript:totalHours();"></td>
		
		</tr>
		
		<tr>
			<td width="15%"><strong>Team</strong></td>
			<td><SELECT id="team" NAME="team"
				ONCHANGE="javascript:selectteams()" style="width: 200" width="200"
				size="6">
				<option value="XI">XI</option>
				<option value="BASIS">BASIS</option>
				<option value="ABAP">ABAP</option>
				<option value="MDM">MDM</option>
				<option value="MM">MM</option>
				<option value="PP">PP</option>
				<option value="FI">FI</option>
				<option value="BI">BI</option>
				<option value="SD">SD</option>
				<option value="EP">EP</option>
				<option value="HR">HR</option>
				<option value="NW ADMIN">NW ADMIN</option>
				<option value="ADMIN">ADMIN</option>
				<option value="CUSTOMER">CUSTOMER</option>
				<option value="DIRECTOR">DIRECTOR</option>
				<option value="SALES">SALES</option>
				<option value="INTERN">INTERN</option>
			</SELECT></td>
                        <td></td>
                        <td align="center"><select id=teamSelect name=teamSelect style="width: 200;" width="200" size="6" multiple></select>
					
					</td>
                        <td>
                            <p align="center"><input type="button" onClick="one2two()"	value=" >> "></p>
                            <p align="center"><input type="button" onClick="two2one()"	value=" << "></p>
                        </td>
					<td align="center"><select id=teamFinal name=teamFinal
						style="width: 200" width="200" size="6" multiple></select>
					
					</td>
		</tr>
         <!--
		<tr>
			<table width=100% bgColor=#E8EEF7 cellpadding="5" cellspacing="2"
				align="center">
				<tr>
					<td align="center"><select id=teamSelect name=teamSelect
						style="width: 200" width="200" size="8" multiple></select><br />
					<p align="center"><input type="button" onClick="one2two()"
						value=" Add "></p>
					</td>
					<td align="center"><select id=teamFinal name=teamFinal
						style="width: 200" width="200" size="8" multiple></select><br />
					<p align="center"><input type="button" onClick="two2one()"
						value=" Remove "></p>
					</td>
				</tr>
			</table>
		</tr>
            -->
		<tr>
			<TD>&nbsp;</TD>
                        <TD>&nbsp;</TD>
                        <TD align="right"><INPUT type=submit value=Submit name=submit></TD>
			<TD align="left">	<INPUT type=reset value=" Reset "></TD>
                        <TD>&nbsp;</TD>
                        <TD>&nbsp;</TD>
		</tr>
	</TBODY>
</TABLE>
</center>
</div>
</FORM>
<script>
	var groups=document.theForm.category.options.length
	var group=new Array(groups)
	for (i=0; i<groups; i++)
		group[i]=new Array()
	
	group[0][0]=new Option("--Select Phase--"," ");
	group[1][0]=new Option("--Select Phase--"," ");
		
	group[2][0]=new Option("--Select Phase--"," ");
	group[2][1]=new Option("To be started","To be started");
	group[2][2]=new Option("Requirment gathering","Requirment gathering");
	group[2][3]=new Option("Design Documentation","Design Documentation");
	group[2][4]=new Option("Database Design","Database Design");
	group[2][5]=new Option("User Unterface","User Unterface");
	group[2][6]=new Option("File names and flow review","File names and flow review");
	group[2][7]=new Option("Development","Development");
	group[2][8]=new Option("Testing","Testing");
	group[2][9]=new Option("Finished","Finished");
	group[2][10]=new Option("User Acceptance Testing","User Acceptance Testing");
	group[2][11]=new Option("Production","Production");
	group[2][12]=new Option("Maintenance","Maintenance");
	group[2][13]=new Option("End of Life","End of Life");
	group[2][14]=new Option("Closed","Closed");
	group[2][15]=new Option("Suspended","Suspended");
	group[2][16]=new Option("Pilot Demo","Pilot Demo");

	group[3][0]=new Option("--Select Phase--"," ");
	group[3][1]=new Option("To be started","To be started");
	group[3][2]=new Option("Requirment gathering","Requirment gathering");
	group[3][3]=new Option("Design Documentation","Design Documentation");
	group[3][4]=new Option("Database Design","Database Design");
	group[3][5]=new Option("User Unterface","User Unterface");
	group[3][6]=new Option("File names and flow review","File names and flow review");
	group[3][7]=new Option("Development","Development");
	group[3][8]=new Option("Testing","Testing");
	group[3][9]=new Option("Finished","Finished");
	group[3][10]=new Option("User Acceptance Testing","User Acceptance Testing");
	group[3][11]=new Option("Production","Production");
	group[3][12]=new Option("Maintenance","Maintenance");
	group[3][13]=new Option("End of Life","End of Life");
	group[3][14]=new Option("Closed","Closed");
	group[3][15]=new Option("Suspended","Suspended");
	group[3][16]=new Option("Pilot Demo","Pilot Demo");
	
        group[4][0]=new Option("--Select Phase--"," ");
	group[4][1]=new Option("To be started","To be started");
	group[4][2]=new Option("Requirment gathering","Requirment gathering");
	group[4][3]=new Option("Design Documentation","Design Documentation");
	group[4][4]=new Option("Database Design","Database Design");
	group[4][5]=new Option("User Unterface","User Unterface");
	group[4][6]=new Option("File names and flow review","File names and flow review");
	group[4][7]=new Option("Development","Development");
	group[4][8]=new Option("Testing","Testing");
	group[4][9]=new Option("Finished","Finished");
	group[4][10]=new Option("User Acceptance Testing","User Acceptance Testing");
	group[4][11]=new Option("Production","Production");
	group[4][12]=new Option("Maintenance","Maintenance");
	group[4][13]=new Option("End of Life","End of Life");
	group[4][14]=new Option("Closed","Closed");
	group[4][15]=new Option("Suspended","Suspended");
	group[4][16]=new Option("Pilot Demo","Pilot Demo");
	
	var temp=document.theForm.phase
	
	function redirect(x)
	{
		for(m=temp.options.length-1;m>0;m--)
			temp.options[m]=null
		for (i=0;i<group[x].length;i++)
			temp.options[i]=new Option(group[x][i].text,group[x][i].value)
		temp.options[0].selected=true
	}
	var projectgroups=document.theForm.projecttype.options.length
	var projectgroup=new Array(projectgroups)
	for (i=0; i<projectgroups; i++)
		projectgroup[i]=new Array()
	
		projectgroup[0][0]=new Option("--Select Phase--"," ");
		projectgroup[1][0]=new Option("--Select Phase--"," ");
		projectgroup[1][1]=new Option("Project Preparation","Project Preparation");
		projectgroup[1][2]=new Option("Business Blueprint","Business Blueprint");
		projectgroup[1][3]=new Option("Realization","Realization");
		projectgroup[1][4]=new Option("Final Preparation","Final Preparation");
		projectgroup[1][5]=new Option("Go Live & support","Go Live & support");
	
		projectgroup[2][0]=new Option("--Select Phase--"," ");
		projectgroup[2][1]=new Option("Project Preparation","Project Preparation");
		projectgroup[2][2]=new Option("Upgrade Blueprint","Upgrade Blueprint");
		projectgroup[2][3]=new Option("Upgrade Realization","Upgrade Realization");
		projectgroup[2][4]=new Option("Final Preparation for Cutover","Final Preparation for Cutover");
		projectgroup[2][5]=new Option("Production Cutover and Support","Production Cutover and Support");
		
		projectgroup[3][0]=new Option("--Select Phase--"," ");
		projectgroup[3][1]=new Option("Project Preparation","Project Preparation");
		projectgroup[3][2]=new Option("Support Blueprint","Support Blueprint");
		projectgroup[3][3]=new Option("Support Realization","Support Realization");
		projectgroup[3][4]=new Option("Final Preparation for Cutover","Final Preparation for Cutover");
		projectgroup[3][5]=new Option("Maintenence and edcuating end users","Maintenence and edcuating end users");
		
		var temp1=document.theForm.phase
		function redirect1(y)
		{
			for(m=temp1.options.length-1;m>0;m--)
				temp1.options[m]=null
			for (i=0;i<projectgroup[y].length;i++)
				temp1.options[i]=new Option(projectgroup[y][i].text,projectgroup[y][i].value)
			temp1.options[0].selected=true
		}
	
// -->
</script>
<BR>
<!-- Table To Display The Footer That Contains Terms Of Use And The Contact Email Address -->
</body>
</html>
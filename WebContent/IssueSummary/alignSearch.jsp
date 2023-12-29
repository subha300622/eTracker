<%-- 
    Document   : alignSearch
    Created on : Feb 18, 2012, 11:26:54 AM
    Author     : Tamilvelan
--%>
<%@ page import="org.apache.log4j.*,pack.eminent.encryption.*,dashboard.*,java.util.*"%>
<%
        response.setHeader("Cache-Control","no-cache");
	response.setHeader("Cache-Control","no-store");
	response.setDateHeader("Expires", 0);
	response.setHeader("Pragma","no-cache");
	//Configuring log4j properties




	

	Logger logger = Logger.getLogger("alignSearch");
	

	String logoutcheck=(String)session.getAttribute("Name");
	if(logoutcheck==null)
	{
		logger.fatal("=========================Session Expired======================");
		//response.sendRedirect(request.getContextPath()+"/SessionExpired.jsp");
		%>
<jsp:forward page="../SessionExpired.jsp"></jsp:forward>
<%
	}
%>

<!doctype html public "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
<title>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS
Solution</title>
<meta name="Generator" content="EditPlus">
<meta name="Author" content="">
<meta name="Keywords" content="">
<meta name="Description" content="">
<style>
    /* BE SURE TO INCLUDE THE CSS RESET FOUND IN THE DEMO PAGE'S CSS */
/*------------------------------------*\
	NAV
\*------------------------------------*/
#nav{
	list-style:none;
	font-weight:bold;
	margin-bottom:0px;
        margin-left: 10px;
        margin-top: -19px;
	/* Clear floats */

/*	width:1%;*/
	/* Bring the nav above everything else--uncomment if needed.
	position:relative;
	z-index:5;
	*/
}
#nav li{
	float:left;
	margin-right:0px;
	position:relative;
}
#nav a{
	display:block;
	padding:5px;
	color:black;
	background:#E8EEF7;
	text-decoration:none;
}
#nav a:hover{
	color:#fff;
	background:#6b0c36;
	text-decoration:underline;
}

/*--- DROPDOWN ---*/
#nav ul{
	background:#fff; /* Adding a background makes the dropdown work properly in IE7+. Make this as close to your page's background as possible (i.e. white page == white background). */
	background:rgba(255,255,255,0); /* But! Let's make the background fully transparent where we can, we don't actually want to see it if we can help it... */
	list-style:none;
	position:absolute;
	left:-9999px; /* Hide off-screen when not needed (this is more accessible than display:none;) */
}
#nav ul li{
	padding-top:1px; /* Introducing a padding between the li and the a give the illusion spaced items */
	float:none;
}
#nav ul a{
	white-space:nowrap; /* Stop text wrapping and creating multi-line dropdown items */
}
#nav li:hover ul{ /* Display the dropdown on hover */
	left:0; /* Bring back on-screen when needed */
}
#nav li:hover a{ /* These create persistent hover states, meaning the top-most link stays 'hovered' even when your cursor has moved down the list. */
	background:#6b0c36;
	text-decoration:underline;
}
#nav li:hover ul a{ /* The persistent hover state does however create a global style for links even before they're hovered. Here we undo these effects. */
	text-decoration:none;
}
#nav li:hover ul li a:hover{ /* Here we define the most explicit hover states--what happens when you hover each individual link. */
	background:#333;
}
.tr {height:30px;}
</style>
<LINK title=STYLE 	href="<%= request.getContextPath() %>/eminentech support files/main_ie.css" type="text/css" rel="STYLESHEET">
<script type="text/javascript" src="<%= request.getContextPath() %>/javaScript/checkSubmit.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/javaScript/jquery.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/javaScript/jqueryslidemenu.js"></script>
<script type="text/javascript"	src="<%= request.getContextPath() %>/eminentech support files/datetimepicker.js"></script>
<script type="text/javascript"	src="<%= request.getContextPath() %>/javaScript/XMLHttpRequest.js"></script>
<script type="text/javascript">
	window.history.forward(1);
        function changeDuedate(){
            var dueDate =   document.getElementById('duedate_param').value;
            if(dueDate=="Between"){

                document.getElementById('ddate').style.display='none';
                document.getElementById('ddaterange').style.display='block';
            }else{
                document.getElementById('ddate').style.display='block';
                document.getElementById('ddaterange').style.display='none';
            }
        }
         function changeCreatedOn(){
            var creParam =   document.getElementById('created_param').value;
            if(creParam=="Between"){

                document.getElementById('credate').style.display='none';
                document.getElementById('createdrange').style.display='block';
            }else{
                document.getElementById('credate').style.display='block';
                document.getElementById('createdrange').style.display='none';
            }
        }
         function changeUpdatedOn(){
            var modParam =   document.getElementById('updated_param').value;
            if(modParam=="Between"){

                document.getElementById('moddate').style.display='none';
                document.getElementById('modifiedrange').style.display='block';
            }else{
                document.getElementById('moddate').style.display='block';
                document.getElementById('modifiedrange').style.display='none';
            }
        }
            function trim(str)  {
  		while (str.charAt(str.length - 1)==" ")
                    str = str.substring(0, str.length - 1);
  		while (str.charAt(0)==" ")
                    str = str.substring(1, str.length);
  		return str;
            }
            function clearCRID(){
             if(document.getElementById('crid').value=='All Information'){
                    document.getElementById('crid').value='';
                    document.getElementById('crid').focus();
                }
            }
            function popCRID(){
             if(trim(document.getElementById('crid').value)==''){
                    document.getElementById('crid').value='All Information';

                }
            }
            function clearSearch(){
             if(document.getElementById('subject').value=='All Information'){
                    document.getElementById('subject').value='';
                    document.getElementById('subject').focus();
                }
            }
            function popSearch(){
             if(trim(document.getElementById('subject').value)==''){
                    document.getElementById('subject').value='All Information';

                }
            }
            function callcustomer()
            {

                    xmlhttp = createRequest();
                    if(xmlhttp != null)
                    {

                        var product = document.getElementById("product").value;;
                        xmlhttp.open("GET","${pageContext.servletContext.contextPath}/IssueSummary/CustomerDetails.jsp?product="+product+"&rand="+Math.random(1,10), false);
                        xmlhttp.onreadystatechange = callbackcustomer;
                        xmlhttp.setRequestHeader("Cache-Control", "no-cache")
                        xmlhttp.send(null);
                    }
            }


            function callbackcustomer()
            {
              if (xmlhttp.readyState == 4)
              {
                      if (xmlhttp.status == 200)
                      {
                            var name = xmlhttp.responseText;
                            var result = xmlhttp.responseText.split(";");
                             var results = result[1].split(",");
                            objLinkList 	= eval("document.getElementById('customer')");
                            objLinkList.length=0;
                            for(i=0;i<results.length-1;i++)
                            {
                                    objLinkList.length++;
                                     objLinkList[i].text =results[i];
                                    objLinkList[i].value = results[i];
                            }
                       }
                       else
                        {
                         }
                    }
            }


            function callversion()
            {
                    xmlhttp = createRequest();
                    if(xmlhttp != null)
                    {
                        var product = document.getElementById("product").value;
                         var customer = document.getElementById("customer").value;
                        xmlhttp.open("GET","${pageContext.servletContext.contextPath}/IssueSummary/VersionDetails.jsp?product="+product+"&customer="+customer+"&rand="+Math.random(1,10), false);
                        xmlhttp.onreadystatechange = callbackversion;
                        xmlhttp.send(null);
                    }


            }


            function callbackversion()
            {
              if (xmlhttp.readyState == 4)
              {
                      if (xmlhttp.status == 200)
                      {
                            var name = xmlhttp.responseText;
                             var result = xmlhttp.responseText.split(";");
                             var results = result[1].split(",");
                            objLinkList 	= eval("document.getElementById('version')");
                            objLinkList.length=0;
                            for(i=0;i<results.length-1;i++)
                            {
                                    objLinkList.length++;
                                     objLinkList[i].text =results[i];
                                    objLinkList[i].value = results[i];
                            }

                       }
                       else
                        {
                         }
                    }
            }
            function callfixversion()
            {
                    xmlhttp = createRequest();
                    if(xmlhttp != null)
                    {
                        var product = document.getElementById("product").value;
                        var customer = document.getElementById("customer").value;
                        var found = document.getElementById("version").value;
                        xmlhttp.open("GET","${pageContext.servletContext.contextPath}/IssueSummary/fixVersionDetails.jsp?product="+product+"&customer="+customer+"&version="+found+"&rand="+Math.random(1,10), false);
                        xmlhttp.onreadystatechange = callbackfixversion;
                        xmlhttp.send(null);
                    }


            }


            function callbackfixversion()
            {
              if (xmlhttp.readyState == 4)
              {
                      if (xmlhttp.status == 200)
                      {
                            var name = xmlhttp.responseText;
                             var result = xmlhttp.responseText.split(";");
                             var results = result[1].split(",");
                            objLinkList 	= eval("document.getElementById('fixversion')");
                            objLinkList.length=0;
                            for(i=0;i<results.length-1;i++)
                            {
                                    objLinkList.length++;
                                     objLinkList[i].text =results[i];
                                    objLinkList[i].value = results[i];
                            }

                       }
                       else
                        {
                         }
                    }
            }


            function callplatform()
            {
                    xmlhttp = createRequest();
                    if(xmlhttp != null)
                    {
                        var product = document.getElementById("product").value;
                         var customer = document.getElementById("customer").value;
                         var version = document.getElementById("fixversion").value;
                        xmlhttp.open("GET","${pageContext.servletContext.contextPath}/IssueSummary/PlatformDetails.jsp?product="+product+"&customer="+customer+"&version="+version+"&rand="+Math.random(1,10), false);
                        xmlhttp.onreadystatechange = callbackplatform;
                        xmlhttp.send(null);
                    }
            }

            function callbackplatform()
            {
              if (xmlhttp.readyState == 4)
              {
                      if (xmlhttp.status == 200)
                      {
                            var name = xmlhttp.responseText;
                             var result = xmlhttp.responseText.split(";");
                             var results = result[1].split(",");
                            objLinkList 	= eval("document.getElementById('platform')");
                            objLinkList.length=0;
                            for(i=0;i<results.length-1;i++)
                            {
                                    objLinkList.length++;
                                     objLinkList[i].text =results[i];
                                    objLinkList[i].value = results[i];
                            }
                       }
                       else
                        {
                         }
                    }
            }


            function callmodule()
            {
                    xmlhttp = createRequest();
                    if(xmlhttp != null)
                    {
                        var product = document.getElementById("product").value;
                         var customer = document.getElementById("customer").value;
                         var version = document.getElementById("version").value;
                         var fixversion = document.getElementById("fixversion").value;
                         var platform = document.getElementById("platform").value;
                        xmlhttp.open("GET","${pageContext.servletContext.contextPath}/IssueSummary/ModuleDetails.jsp?product="+product+"&customer="+customer+"&version="+version+"&platform="+platform+"&rand="+Math.random(1,10), false);
                        xmlhttp.onreadystatechange = callbackmodule;
                        xmlhttp.send(null);
                    }
            }


            function callbackmodule()
            {
              if (xmlhttp.readyState == 4)
              {
                      if (xmlhttp.status == 200)
                      {
                            var name = xmlhttp.responseText;
                            var result = xmlhttp.responseText.split(";");
                             var results = result[1].split(",");
                            objLinkList 	= eval("document.getElementById('module')");
                            objLinkList.length=0;
                            for(i=0;i<results.length-1;i++)
                            {
                                    objLinkList.length++;
                                     objLinkList[i].text =results[i];
                                    objLinkList[i].value = results[i];
                            }
                       }
                       else
                        {
                         }
                    }
            }
            function callfixmodule()
            {
                    xmlhttp = createRequest();
                    if(xmlhttp != null)
                    {
                        var product = document.getElementById("product").value;
                         var customer = document.getElementById("customer").value;
                         var version = document.getElementById("version").value;
                         var fixversion = document.getElementById("fixversion").value;
                         var platform = document.getElementById("platform").value;
                        xmlhttp.open("GET","${pageContext.servletContext.contextPath}/IssueSummary/ModuleDetails.jsp?product="+product+"&customer="+customer+"&version="+fixversion+"&platform="+platform+"&rand="+Math.random(1,10), false);
                        xmlhttp.onreadystatechange = callbackfixmodule;
                        xmlhttp.send(null);
                    }
            }


            function callbackfixmodule()
            {
              if (xmlhttp.readyState == 4)
              {
                      if (xmlhttp.status == 200)
                      {
                            var name = xmlhttp.responseText;
                            var result = xmlhttp.responseText.split(";");
                             var results = result[1].split(",");
                            objLinkList 	= eval("document.getElementById('module')");
                            objLinkList.length=0;
                            for(i=0;i<results.length-1;i++)
                            {
                                    objLinkList.length++;
                                     objLinkList[i].text =results[i];
                                    objLinkList[i].value = results[i];
                            }
                       }
                       else
                        {
                         }
                    }
            }
            function callstatus()
            {
                    xmlhttp = createRequest();
                    if(xmlhttp != null)
                    {
                        var product = document.getElementById("product").value;
                        var version = document.getElementById("fixversion").value;

                        xmlhttp.open("GET","${pageContext.servletContext.contextPath}/IssueSummary/statusDetails.jsp?product="+product+"&version="+version+"&rand="+Math.random(1,10), false);
                        xmlhttp.onreadystatechange = callbackstatus;
                        xmlhttp.send(null);
                    }
            }


            function callbackstatus()
            {
              if (xmlhttp.readyState == 4)
              {
                      if (xmlhttp.status == 200)
                      {
                            var name = xmlhttp.responseText;
                            var result = xmlhttp.responseText.split(";");
                             var results = result[1].split(",");
                            objLinkList 	= eval("document.getElementById('issuestatus')");
                            objLinkList.length=0;
                            for(i=0;i<results.length-1;i++)
                            {
                                    objLinkList.length++;
                                     objLinkList[i].text =results[i];
                                    objLinkList[i].value = results[i];
                            }
                       }
                       else
                        {
                         }
                    }
            }

            function callcreatedby()
            {
                    xmlhttp = createRequest();
                    if(xmlhttp != null)
                    {
                        var product = document.getElementById("product").value;
                         var customer = document.getElementById("customer").value;
                         var version = document.getElementById("fixversion").value;
                         var platform = document.getElementById("platform").value;
                        xmlhttp.open("GET","${pageContext.servletContext.contextPath}/IssueSummary/CreatedUserDetails.jsp?product="+product+"&customer="+customer+"&version="+version+"&platform="+platform+"&rand="+Math.random(1,10), false);
                        xmlhttp.onreadystatechange = callbackcreatedby;
                        xmlhttp.send(null);
                    }
            }


            function callbackcreatedby()
            {
              if (xmlhttp.readyState == 4)
              {
                      if (xmlhttp.status == 200)
                      {
                            var name = xmlhttp.responseText;

                            var results = xmlhttp.responseText.split(",");
                            objLinkList 	= eval("document.getElementById('createdby')");
                            objLinkList.length=1;
                            for(i=1;i<=results[0];i++)
                            {
                                    var k  =results[i];;
                                    var id   =   k.substring(0,k.indexOf('-'));
                                    var name   =   k.substring(k.indexOf('-')+1,k.length);

                                    objLinkList.length++;
                                    objLinkList[i].text =name;
                                    objLinkList[i].value = id;
                            }
                       }
                       else
                        {
                         }
                    }
            }

            function callassignedto()
            {
                    xmlhttp = createRequest();
                    if(xmlhttp != null)
                    {
                        var product = document.getElementById("product").value;
                         var customer = document.getElementById("customer").value;
                         var version = document.getElementById("fixversion").value;
                         var platform = document.getElementById("platform").value;
                        xmlhttp.open("GET","${pageContext.servletContext.contextPath}/IssueSummary/AssignedUserDetails.jsp?product="+product+"&customer="+customer+"&version="+version+"&platform="+platform+"&rand="+Math.random(1,10), false);
                        xmlhttp.onreadystatechange = callbackassignedto;
                        xmlhttp.send(null);
                    }
            }


            function callbackassignedto()
            {
              if (xmlhttp.readyState == 4)
              {
                      if (xmlhttp.status == 200)
                      {
                            var name = xmlhttp.responseText;
                             var results = xmlhttp.responseText.split(",");
                            objLinkList 	= eval("document.getElementById('assignedto')");
                            objLinkList.length=1;
                            for(i=1;i<=results[0];i++)
                            {
                                    var k  =results[i];;
                                    var id   =   k.substring(0,k.indexOf('-'));
                                    var name   =   k.substring(k.indexOf('-')+1,k.length);

                                    objLinkList.length++;
                                    objLinkList[i].text =name;
                                    objLinkList[i].value = id;
                            }
                       }
                       else
                        {
                         }
                    }
            }
	function printpost(post)
	{
		pp = window.open('profile.jsp?post_id=' + post,'pp','size = maximize,location=no,statusbar=no,menubar=no,scrollbars=no width=900,height=400');
		pp.focus();
	}
        function isPositiveInteger(str)  {
  		var pattern = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
  		var i = 0;
  		do  {
    		var pos = 0;
    		for (var j=0; j<pattern.length; j++)
      			if (str.charAt(i)==pattern.charAt(j)) {
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
        function isCharacter(str)  {
  		var pattern = "1234567890"
  		var i = 0;
  		do  {
    		var pos = 0;
    		for (var j=0; j<pattern.length; j++)
      			if (str.charAt(i)==pattern.charAt(j)) {
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
         function val(theForm)
        {
            var str   = document.getElementById("modifiedon").value;
            var current_date = new Date();
 //           alert(str);
            if(!(str=='All Information')){
                var first = str.indexOf("-");
                var last  = str.lastIndexOf("-");

                var year         = str.substring(last+1,last+5);
                var month        = str.substring(first+1,last);
                var date         = str.substring(0,first);
                var form_date    = new Date(year,month-1,date);


                if(current_date < form_date)
                {
                    alert('Please enter Valid Modified On date for Search');
                    theForm.modifiedon.value="All Information";
                    return false;
                }
                }
                var cre =   document.getElementById("date").value;
                if(!(cre=='All Information')){
                var first = cre.indexOf("-");
                var last  = cre.lastIndexOf("-");

                var year         = cre.substring(last+1,last+5);
                var month        = cre.substring(first+1,last);
                var date         = cre.substring(0,first);
                var credate    = new Date(year,month-1,date);


                if(current_date < credate)
                {
                    alert('Please enter Valid Created On date for Search');
                    theForm.date.value="All Information";
                    return false;
                }
                }
                var crid    =   document.getElementById("crid").value;
                 if(!(crid=='All Information')){
                     var first  =   crid.substring(0,4);
   //                  alert(first)
                     if (!isPositiveInteger((first)))  {
                        alert('Please Enter valid CR ID');
			document.theForm.crid.value="";
                        theForm.crid.focus();
                        return false;
                    }
                    var second  =   crid.substring(4,10);
     //                alert(second)
                    if (!isCharacter((second)))  {
                        alert('Please Enter valid CR ID ');
			document.theForm.crid.value="";
                        theForm.crid.focus();
                        return false;
                    }

                 }
                  disableSubmit();
                return true;
        }
	</script>
       </head>
<body bgcolor="#FFFFFF">
<FORM name="theForm" onsubmit='return val(this)' METHOD="POST" ACTION="<%=request.getContextPath()%>/IssueSummary/IssueSummarySearch.jsp">
<%@ page import="java.sql.*"%>
<%@ include file="../header.jsp"%>
<%!
	Connection connection;
	PreparedStatement ps1,ps2,ps3,ps4,ps5,ps6,ps7,ps8,ps9,ps10,ps11,fix_ps;
	ResultSet rs1,rs2,rs3,rs4,rs5,rs6,rs7,rs8,rs9,rs10,rs11,fix_rs;
        String flag="";
        ArrayList<String> al = null;
%> <%

        String userId = null;
        String months[]={"Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"};
            try {
		connection =MakeConnection.getConnection();
                 flag=request.getParameter("flag");
                if (flag==null)
                    {
                        if (session.getAttribute("description")!=null)
                        session.removeAttribute("description");
                        if (session.getAttribute("query_name")!=null)
                        session.removeAttribute("query_name");
                    }
    	%> <br>
<table cellpadding="0" cellspacing="0" width="100%">
	<tr border="2" bgColor="#C3D9FF">
		<td bgcolor="#C3D9FF" border="1" align="left" width="100%"><font
			size="4" COLOR="#0000FF"><b>Search Your APM Issues </b></font> <FONT SIZE="3"
			COLOR="#0000FF"> </FONT></td>
	</tr>
</table>
<br>
<table width="100%" border="0" bgColor="#E8EEF7" cellspacing="2"
	cellpadding="2" align="center">
	<tr>
		<td colspan="4">
		<div align="left"></div>
		<font size="2" face="Verdana, Arial, Helvetica, sans-serif">&nbsp;
		</font>
		<table width="100%" border="0" cellspacing="2" cellpadding="2">
<!--        		<tr>
				<td height="21" width="28%"><B>Project </B></td>
				<td height="21" width="25%"><B>Customer </B></td>
				<td height="21" width="24%"><B> Found Version</B></td>
				<td height="21" width="23%"><B> Fix Version</B></td>
			</tr>-->
			<tr>
				<td height="20" width="20%">
                                    <B>Project </B>

                                    <font size="2"
					face="Verdana, Arial, Helvetica, sans-serif"> <%


                                        Integer current_userId      = (Integer)session.getAttribute("userid_curr");
                                        int uid	 = current_userId;
                                        userId = current_userId.toString();
                                        int roleId   = (Integer)session.getAttribute("Role");
                                        if(roleId == 1){
                                            ps1 = connection.prepareStatement("SELECT PNAME  FROM PROJECT GROUP BY PNAME Order by upper(pname) asc");
                                        }else{
                                            ps1 = connection.prepareStatement("SELECT PNAME  FROM PROJECT P, USERPROJECT UP WHERE P.PID = UP.PID AND UP.USERID = "+uid+" GROUP BY PNAME Order by upper(pname) asc");
                                        }
					rs1 = ps1.executeQuery();
					String product="";
%>
                                        <select id="product" name="product" size="1"
					onChange="javascript:callcustomer();callversion();javascript:callfixversion();callplatform();javascript:callmodule();javascript:callstatus();javascript:callcreatedby();javascript:callassignedto();">
					<option selected>All Information</option>
					<%	        		while(rs1.next())
                                 {
	        			product= rs1.getString(1);
			            	if (product.trim().equalsIgnoreCase(request.getParameter("product")))
			            	{
%>
					<option value="<%=product%>" selected><%=product%></option>
					<%
					}
					else
					{
%>
					<option value="<%=product%>"><%=product%></option>
					<%
					}
				}
					if(rs1!=null)
					{
						rs1.close();
					}
					if(ps1!=null)
					{
						ps1.close();
					}
%>
				</select> </font></td>
				<td height="20" width="25%">
                                    <B>Customer </B>
                                    <font size="2"
					face="Verdana, Arial, Helvetica, sans-serif"> <%

					String prod1=request.getParameter("product");


                                         if(roleId == 1){
                                            ps2 = connection.prepareStatement("SELECT DISTINCT CUSTOMER FROM PROJECT ORDER BY UPPER(CUSTOMER) ASC");
                                          } else {
                                            ps2 = connection.prepareStatement("SELECT DISTINCT CUSTOMER FROM PROJECT WHERE PNAME IN ( SELECT PNAME  FROM PROJECT P, USERPROJECT UP WHERE P.PID = UP.PID AND UP.USERID = "+uid+" ) ORDER BY UPPER(CUSTOMER) ASC");
                                          }
                                                rs2 = ps2.executeQuery();


					String customer="";
%> <input name="hiddenprod" type="hidden" value="<%=prod1 %>"> <select
					id="customer" name="customer" size="1"
					onChange="javascript:callversion();javascript:callfixversion();callplatform();javascript:callmodule();">
					<option selected>All Information</option>
					<%					if(rs2!=null)
					{
				   		while(rs2.next())
				        {
				   			customer=rs2.getString(1);
			            	if (customer.equalsIgnoreCase(request.getParameter("customer")))
	    		        	{
%>
					<option value="<%=customer%>" selected><%=customer%></option>
					<%
							}
							else
							{
%>
					<option value="<%=customer%>"><%=customer%></option>
					<%
							}
						}
					}
					if(rs2!=null)
					{
						rs2.close();
					}
					if(ps2!=null)
					{
						ps2.close();
					}
%>
				</select> </font></td>
				<td height="20" width="20%">
                                    <B> Found Version</B>
                                    <font size="2"
					face="Verdana, Arial, Helvetica, sans-serif"> <%
					String prod2=request.getParameter("hiddenprod");
					String cus2=request.getParameter("customer");

					if(prod2!=null&&cus2!=null)
                                         {
                                            ps3 = connection.prepareStatement("SELECT FOUND_VERSION  FROM ISSUE WHERE CUSTOMER=? and PROJECT=? AND FOUND_VERSION IS NOT NULL GROUP BY FOUND_VERSION",ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_READ_ONLY);
                                            ps3.setString(1,cus2);
                                            ps3.setString(2,prod2);;
                                            rs3 = ps3.executeQuery();// CORRECT
                                         }
                                         else
                                         {
                                            if(roleId == 1) {
                                                ps3 = connection.prepareStatement("SELECT DISTINCT VERSION  FROM PROJECT ORDER BY VERSION ASC",ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_READ_ONLY);
                                            } else {
                                                ps3 = connection.prepareStatement("SELECT DISTINCT VERSION  FROM PROJECT WHERE PNAME IN ( SELECT PNAME  FROM PROJECT P, USERPROJECT UP WHERE P.PID = UP.PID AND UP.USERID = "+uid+" ) ORDER BY VERSION",ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_READ_ONLY);
                                            }
                                            rs3 = ps3.executeQuery();// CORRECT
                                         }
                                            String version="";
%> <input type="hidden" name="cus2" value="<%=cus2%>"> <input
					type="hidden" name="prod2" value="<%=prod2%>"> <select
					id="version" name="version" size="1"
					onChange="javascript:callfixversion();javascript:callplatform();javascript:callmodule();javascript:callstatus();">
					<option selected>All Information</option>
					<%					if(rs3!=null)
                                        {
		    			while(rs3.next())
				    	{
				        	version=rs3.getString(1);
		        		    if (version.equalsIgnoreCase(request.getParameter("version")))
				            {
%>
					<option value="<%=version%>" selected><%=version%></option>
					<%
							}
							else
							{
%>
					<option value="<%=version%>"><%=version%></option>
					<%
							}
						}
					}

%>
				</select></font></td>
				<td height="20" width="35%">
                                    <B> Fix Version</B>
                                    <font size="2"
					face="Verdana, Arial, Helvetica, sans-serif"> <%

                                         if(rs3 != null) {
                                             rs3.beforeFirst();
                                         }

                                            String fixversion="";
%> <input type="hidden" name="cus2" value="<%=cus2%>"> <input
					type="hidden" name="prod2" value="<%=prod2%>"> <select
					id="fixversion" name="fixversion" size="1"
					onChange="javascript:callplatform();javascript:callfixmodule();javascript:callstatus();">
					<option selected>All Information</option>
					<%					if(rs3!=null)
                                        {
		    			while(rs3.next())
				    	{
				        	fixversion=rs3.getString(1);
		        		    if (fixversion.equalsIgnoreCase(request.getParameter("fixversion")))
				            {
%>
					<option value="<%= fixversion %>" selected><%= fixversion %></option>
					<%
							}
							else
							{
%>
					<option value="<%= fixversion %>"><%= fixversion %></option>
					<%
							}
						}
					}
					if(rs3!=null)
					{
						rs3.close();
					}
					if(ps3!=null)
					{
						ps3.close();
					}
%>
				</select></font></td>
			</tr>
<!--			<tr>
				<td><B> Platform</B></td>
				<td><b>Module</b></td>
				<td><b>Severity</b></td>
				<td><b>Priority</b></td>
			</tr>-->
			<tr>
				<td height="20" width="15%">
                                    <B> Platform</B>
                                    <font size="2"
					face="Verdana, Arial, Helvetica, sans-serif"> <%
					String cus3=request.getParameter("customer");
					String prod3=request.getParameter("hiddenprod");
					String ver3=request.getParameter("version");
                                	if (cus2 !=null && prod2 !=null)
                                        {
                                                ps4 = connection.prepareStatement("SELECT DISTINCT PLATFORM FROM ISSUE WHERE CUSTOMER=? and PROJECT=? AND FOUND_VERSION=? AND PLATFORM IS NOT NULL GROUP BY PLATFORM");
                                                ps4.setString(1,cus3);
                                                ps4.setString(2,prod3);
                                                ps4.setString(3,ver3);
                                                rs4 = ps4.executeQuery();
                                         }
                                         else
                                         {
                                            if( roleId == 1){
                                                ps4 = connection.prepareStatement("SELECT DISTINCT PLATFORM FROM Project  ORDER BY UPPER(PLATFORM) ASC");
                                             } else {
                                                ps4 = connection.prepareStatement("SELECT DISTINCT PLATFORM FROM Project WHERE PNAME IN ( SELECT PNAME  FROM PROJECT P, USERPROJECT UP WHERE P.PID = UP.PID AND UP.USERID = "+uid+" ) ORDER BY UPPER(PLATFORM) ASC");
                                             }
                                             rs4 = ps4.executeQuery();
                                         }
					String platform="";
%> <input type="hidden" name="cus3" value="<%=cus3%>"> <input
					type="hidden" name="prod3" value="<%=prod3%>"> <input
					type="hidden" name="ver3" value="<%=ver3%>"> <select
					id="platform" name="platform" size="1" onchange="javascript:callmodule();">
					<option selected>All Information</option>
					<%					if(rs4!=null)
	    		    {
		    			while(rs4.next())
				    	{
				        	platform=rs4.getString(1);
		        		    if (platform.equalsIgnoreCase(request.getParameter("platform")))
				            {
%>
					<option value="<%=platform%>" selected><%=platform%></option>
					<%
							}
							else
							{
%>
					<option value="<%=platform%>"><%=platform%></option>
					<%
							}
						}
					}
					if(rs4!=null)
					{
						rs4.close();
					}
					if(ps4!=null)
					{
						ps4.close();
					}
%>
				</select></font></td>
				<td height="20" width="24%">
                                    <b>Module</b>
                                    <font size="2"
					face="Verdana, Arial, Helvetica, sans-serif"> <%
					String prod4=request.getParameter("product");
		                      if (cus2 !=null && prod2 !=null)
                                      {
                                            ps5 = connection.prepareStatement("SELECT DISTINCT MODULE FROM ISSUE WHERE ISSUE.PROJECT=? WHERE MODULE IS NOT NULL GROUP BY MODULE");
                                            ps5.setString(1,prod4);
                                            rs5 = ps5.executeQuery();

                                      }
                                      else
                                      {
                                            if (roleId == 1) {
                                                ps5 = connection.prepareStatement("SELECT DISTINCT MODULE FROM MODULES ORDER BY UPPER(MODULE)");
                                            } else {
                                                ps5 = connection.prepareStatement("SELECT DISTINCT MODULE FROM MODULES WHERE PID IN ( SELECT P.PID  FROM PROJECT P, USERPROJECT UP WHERE P.PID = UP.PID AND UP.USERID = "+uid+" ) ORDER BY UPPER(MODULE)");
                                            }

                                            rs5 = ps5.executeQuery();
                                      }
					String module="";
%> <input type="hidden" name="prod4" value="<%=prod4%>"> <select
					id="module" name="module" size="1">
					<option selected>All Information</option>
					<%
  					if(rs5!=null)
	    		                {
		    			while(rs5.next())
				    	{
				        	module=rs5.getString(1);
		        		    if (module.equalsIgnoreCase(request.getParameter("module")))
				            {
%>
					<option value="<%=module%>" selected><%=module%></option>
					<%
							}
							else
							{
%>
					<option value="<%=module%>"><%=module%></option>
					<%
							}
						}
					}
					if(rs5!=null)
					{
						rs5.close();
					}
					if(ps5!=null)
					{
						ps5.close();
					}
%>
				</select></font></td>
				<%
					String severity1="S1- Fatal";
					String severity2="S2- Critical";
					String severity3="S3- Important";
					String severity4="S4- Minor";
					String severity="";
%>

				<td align="left" width="25%">
                                    <b>Severity</b>
                                    <SELECT id="severity" NAME="severity" size="1">
					<OPTION>All Information</OPTION>
					<%
					if (severity1.equalsIgnoreCase(request.getParameter("severity")))
		           	{
						severity=severity1;
%>
					<option value="<%=severity%>" selected><%=severity%></option>
					<%
					}
					else
					{
						severity=severity1;
%>
					<option value="<%=severity%>"><%=severity%></option>
					<%
					}
					if (severity2.equalsIgnoreCase(request.getParameter("severity")))
	            	{
						severity=severity2;
%>
					<option value="<%=severity%>" selected><%=severity%></option>
					<%
					}
					else
					{
						severity=severity2;
%>
					<option value="<%=severity%>"><%=severity%></option>
					<%
					}
					if (severity3.equalsIgnoreCase(request.getParameter("severity")))
	            	{
						severity=severity3;
%>
					<option value="<%=severity%>" selected><%=severity%></option>
					<%
					}
					else
					{
						severity=severity3;
%>
					<option value="<%=severity%>"><%=severity%></option>
					<%
					}
					if (severity4.equalsIgnoreCase(request.getParameter("severity")))
	            	{
						severity=severity4;
%>
					<option value="<%=severity%>" selected><%=severity%></option>
					<%
					}
					else
					{
						severity=severity4;
%>
					<option value="<%=severity%>"><%=severity%></option>
					<%
					}
%>
				</SELECT></td>
				<td>
                                    <b>Priority</b>
				<%
				String priority1="P1-Now";
				String priority2="P2-High";
				String priority3="P3-Medium";
				String priority4="P4-Low";
				String priority="";
%>
                                    <SELECT id="priority" NAME="priority" size="1">
					<OPTION SELECTED>All Information</OPTION>
					<%
					if (priority1.equalsIgnoreCase(request.getParameter("priority")))
	            	{
						priority=priority1;
%>
					<option value="<%=priority%>" selected><%=priority%></option>
					<%
					}
					else
					{
						priority=priority1;
%>
					<option value="<%=priority%>"><%=priority%></option>
					<%
					}
					if (priority2.equalsIgnoreCase(request.getParameter("priority")))
	            	{
						priority=priority2;
%>
					<option value="<%=priority%>" selected><%=priority%></option>
					<%
					}
					else
					{
						priority=priority2;
%>
					<option value="<%=priority%>"><%=priority%></option>
					<%
					}
					if (priority3.equalsIgnoreCase(request.getParameter("priority")))
	            	{
						priority=priority3;
%>
					<option value="<%=priority%>" selected><%=priority%></option>
					<%
					}
					else
					{
						priority=priority3;
%>
					<option value="<%=priority%>"><%=priority%></option>
					<%
					}
					if (priority4.equalsIgnoreCase(request.getParameter("priority")))
	            	{
						priority=priority4;
%>
					<option value="<%=priority%>" selected><%=priority%></option>
					<%
					}
					else
					{
						priority=priority4;
%>
					<option value="<%=priority%>"><%=priority%></option>
					<%
					}
%>
				</SELECT></td>






			</tr>
<!--			<tr>
				<td><b>Type</b></td>
				<td><b>Issue Status</b></td>
				<td><b>Created</b>
                                     <select id="created_param" name="created_param" onchange="javascript:changeCreatedOn();">
                                        <option value="On">On</option>
                                        <option value="After">After</option>
                                        <option value="Before">Before</option>
                                        <option value="Between">Between</option>
                                    </select>
                                </td>
                                <td><b>Updated</b>
                                 <select id="updated_param" name="updated_param" onchange="javascript:changeUpdatedOn();">
                                        <option value="On">On</option>
                                        <option value="After">After</option>
                                        <option value="Before">Before</option>
                                        <option value="Between">Between</option>
                                    </select>
                                </td>

			</tr>-->


			<tr>
				<td>
                                    <b>Type</b>
				<%
						String type1="New Task";
						String type2="Enhancement";
						String type3="Bug";
						String type="";
%> <select id="type" name="type" size="1">
					<option selected>All Information</option>
					<%
						if (type1.equalsIgnoreCase(request.getParameter("type")))
		            	{
							type=type1;
%>
					<option value="<%=type%>" selected><%=type%></option>
					<%
						}
						else
						{
							type=type1;
%>
					<option value="<%=type%>"><%=type%></option>
					<%
						}
						if (type2.equalsIgnoreCase(request.getParameter("type")))
		            	{
							type=type2;
%>
					<option value="<%=type%>" selected><%=type%></option>
					<%
						}
						else
						{
							type=type2;
%>
					<option value="<%=type%>"><%=type%></option>
					<%
						}
						if (type3.equalsIgnoreCase(request.getParameter("type")))
		            	{
							type=type3;
%>
					<option value="<%=type%>" selected><%=type%></option>
					<%
						}
						else
						{
							type=type3;
%>
					<option value="<%=type%>"><%=type%></option>
					<%
						}
%>
				</select></td>

				<%

                    String statusLisType = dashboard.StatusList.getProjecType(userId);

                    ArrayList<String> statusList = dashboard.StatusList.getIssueSummaryStatusList(statusLisType);
                    statusList.add("Open Issues");

                    String editStatus=request.getParameter("issuestatus");
%>
				<td>
                                    <b>Issue Status</b>
                                    <SELECT id="issuestatus" NAME="issuestatus" size="1">
                                        <option value="All Information">All Information</option>

<%
                            for(int i = 0;i < statusList.size(); i++) {
                                if(statusList.get(i).equalsIgnoreCase(editStatus)){
 %>
                                        <OPTION value ="<%= statusList.get(i) %>" selected><%= statusList.get(i) %></OPTION>
 <%
                                }
%>
                                        <OPTION value ="<%= statusList.get(i) %>"><%= statusList.get(i) %></OPTION>
<%
                           }
%>
				</SELECT></td>
				<td>
                                    <b>Created On</b>
				<%
                                                   String dates;
                                                    dates = request.getParameter("date");
                                                //    logger.info("Date from request"+dates);
                                                    if(dates==null)
                                                     {
                                                             dates="All Information";
                                                     }
                                                    if (dates!=null && !dates.equals("All Information"))
                                                        {
                                                            logger.info(dates);


                                                            String day= null;
                                                            String mon= null;
                                                            String year= null;
                                                            String ret=null;
                                                            int first=dates.indexOf("-");
                                                            int last=dates.lastIndexOf("-");
                                                            day=dates.substring(0,first);
                                                            mon=dates.substring(first+1,last);
                                                            logger.info("mon"+mon);
                                                            year=dates.substring(last+1,last+3);
                                                            int month=0;
                                                           int x;
                                                            for(x=0;x<11;x++)
                                                            {
                                                                logger.info("Months"+months[x]+" ");
                                                                if (mon.trim().toUpperCase().equalsIgnoreCase(months[x].trim().toUpperCase()))
                                                                 {
                                                                    month=x;
                                                                    logger.info("months"+month);
                                                                    }
                                                            }
                                                            month++;
                                                            //String day=dates.substring(0,2);
                                                            //String mon=dates.subString(3,6);
                                                            //String year=dates.subString(7);
                                                            logger.info(day+month+year);
                                                            dates=day+"-"+month+"-"+"20"+year;
                                                        }
                                                        if(dates.equals("")||dates==null)
                                                        {
                                                            dates="All Information";
                                                        }

                                                  %>
                                        <span id="credate"> <input type="Text" id="date" name="date" value="<%=dates%>" readonly="true" maxlength="25" size="15"><a href="javascript:NewCal('date','ddmmyyyy')"><img src="../images/newhelp.gif" width="16" height="16" border="0" alt="Pick a date"></a></span>
                                        <span id="createdrange" style="display:none;">
                                        <b>From:</b>    <input type="text" id="createdfrom" name="createdfrom" value="<%=dates%>" readonly="true" maxlength="25"	size="8"/><a href="javascript:NewCal('createdfrom','ddmmyyyy')"><img src="../images/newhelp.gif" width="16" height="16" border="0" alt="Pick a date"></a>
                                        &nbsp;&nbsp;&nbsp;
                                        <b>To:</b><input type="text" id="createdto" name="createdto" value="<%=dates%>" readonly="true" maxlength="25"	size="8"/><a href="javascript:NewCal('createdto','ddmmyyyy')"><img src="../images/newhelp.gif" width="16" height="16" border="0" alt="Pick a date"></a>
                                        </span>
                                        </td>
                                        <%
		        							String createdby="";
											String f2="";
											String l2="";
											String full2="";
%>
				<td colspan="1">
                                    <b>Created By</b>
                                    <select id="createdby" name="createdby" size="1">
					<option selected>All Information</option>

					<%
                                                    //Displaying all the users for Admin
                                                    if(roleId == 1){
                                                    try
                                                    {
                                                    ps7 = connection.prepareStatement("select distinct firstname,lastname,createdby from users,issue,role where CREATEDBY IS NOT NULL AND to_char(userid) = createdby and role.roleid>=1 order by upper(firstname)");
                                                    rs7 = ps7.executeQuery();//CORRECT
                                                    while(rs7.next())
                                                    {
                                                    logger.debug("inside while");
                                                    createdby = rs7.getString("createdby");
                                                    f2 = rs7.getString("firstname");
                                                    l2 = rs7.getString("lastname");
                                                    full2=f2+" "+l2;
                                                    logger.debug("ASSIGNEDTO:"+createdby);
                                                    if(createdby.equalsIgnoreCase(request.getParameter("createdby")))
                                                    {
                                                    %>
					<option value="<%= createdby%>" selected="selected"><%= full2%></option>
					<%
                                                    }
                                                    else
                                                    {
                                                    %>
					<option value="<%= createdby%>"><%= full2%></option>
					<%
                                                    }

                                                    }
                                                    }
                                                    catch(Exception ex)
                                                    {
                                                    logger.error("Exception"+ex);
                                                    }
                                                    if(rs7!=null)
                                                    {
                                                    rs7.close();
                                                    }
                                                    if(ps7!=null)
                                                    {
                                                    ps7.close();
                                                    }
                                                    }else {
                                                     String created =   request.getParameter("createdby");
                                                    if(created==null){
                                                        created="All Information";
                                                     }
                                                    //Displaying the restricted users
                                                        al = CountIssue.getSpecificUsers(userId);
                                                        String getUser = null;

                                                         for(int i = 0;i < al.size();i+=2){
                                                        getUser = al.get(i);

                                                    if(created.equalsIgnoreCase(getUser)){
                                      %>
                                      <option value="<%= getUser %>" selected><%= al.get(i + 1) %>
                                      <%
                                                        }else{
                                        %>
					<option value="<%= getUser %>"><%= al.get(i + 1) %> <%
                                                    }
                                              }
                                                       }
                                                    %>

				</select></td>
			</tr>
<!--			<tr>
                                <td colspan="1"><b>Due Date</b>
                                    <select id="duedate_param" name="duedate_param" onchange="javascript:changeDuedate();">
                                        <option value="On">On</option>
                                        <option value="After">After</option>
                                        <option value="Before">Before</option>
                                        <option value="Between">Between</option>
                                    </select>
                                </td>
                                <td colspan="1"><b>CR ID</b></td>
				<td colspan="1"><b>CreatedBy</b></td>
				<td colspan="2"><b>AssignedTo</b></td>
			</tr>-->
			<tr>
                                                                  <td>
                                                                      <b>Due Date</b>
<%
                                                   String duedate = request.getParameter("duedate");
                                                //    logger.info("Date from request"+dates);
                                                    if(duedate==null)
                                                     {
                                                             duedate="All Information";
                                                     }
                                                    if (duedate!=null && !duedate.equals("All Information"))
                                                        {
                                                            logger.info(duedate);
                                                            String day= null;
                                                            String mon= null;
                                                            String year= null;
                                                            String ret=null;
                                                            int first=duedate.indexOf("-");
                                                            int last=duedate.lastIndexOf("-");
                                                            day=duedate.substring(0,first);
                                                            mon=duedate.substring(first+1,last);
                                                            logger.info("mon"+mon);
                                                            year=duedate.substring(last+1,last+3);
                                                            int month=0;
                                                           int x;
                                                            for(x=0;x<11;x++)
                                                            {
                                                                logger.info("Months"+months[x]+" ");
                                                                if (mon.trim().toUpperCase().equalsIgnoreCase(months[x].trim().toUpperCase()))
                                                                 {
                                                                    month=x;
                                                                    logger.info("months"+month);
                                                                    }
                                                            }
                                                            month++;
                                                            //String day=dates.substring(0,2);
                                                            //String mon=dates.subString(3,6);
                                                            //String year=dates.subString(7);
                                                            logger.info(day+month+year);
                                                            duedate=day+"-"+month+"-"+"20"+year;
                                                        }
                                                        if(duedate.equals("")||duedate==null)
                                                        {
                                                            duedate="All Information";
                                                        }

                                                  %>
                                         <span id="ddate" style="display:block;"><input type="text" id="duedate" name="duedate" value="<%=duedate%>" readonly="true" maxlength="25"	size="15"/><a href="javascript:NewCal('duedate','ddmmyyyy')"><img src="../images/newhelp.gif" width="16" height="16" border="0" alt="Pick a date"></a></span>
                                        <span id="ddaterange" style="display:none;">
                                        <b>From:</b>    <input type="text" id="duedatefrom" name="duedatefrom" value="<%=duedate%>" readonly="true" maxlength="25"	size="8"/><a href="javascript:NewCal('duedatefrom','ddmmyyyy')"><img src="../images/newhelp.gif" width="16" height="16" border="0" alt="Pick a date"></a>
                                        &nbsp;&nbsp;&nbsp;
                                        <b>To:</b><input type="text" id="duedateto" name="duedateto" value="<%=duedate%>" readonly="true" maxlength="25"	size="8"/><a href="javascript:NewCal('duedateto','ddmmyyyy')"><img src="../images/newhelp.gif" width="16" height="16" border="0" alt="Pick a date"></a>
                                        </span>
                                 </td>
                                <td>
                                    <b>CR ID</b>
                                    <%
                                            String crid =   request.getParameter("crid");
                                            if(crid==""||crid==null)
                                            {
                                                crid="All Information";
                                            }
                                    %>
                                    <input type="Text" id="crid" value="<%=crid%>" name="crid" maxlength="10" onclick="javascript:clearCRID()" onblur="javascript:popCRID();"></td>


				<td>
                                     <b>Updated On</b>
                                     <input type="text" id="duedate" name="duedate" value="<%=duedate%>" readonly="true" maxlength="25"	size="15"/><a href="javascript:NewCal('duedate','ddmmyyyy')"><img src="../images/newhelp.gif" width="16" height="16" border="0" alt="Pick a date"></a>
                                </td>
				<%
	        			String assignedto="";

%>
				<td colspan=2>
                                    <b>Assigned To</b>
                                    <select id="assignedto" name="assignedto" size="1">
					<option selected>All Information</option>
					<%
						if(roleId == 1) {
                                                //Displaying all users for Admin
						 ps7 = connection.prepareStatement("select distinct firstname,lastname,assignedto from users,issue,role where ASSIGNEDTO IS NOT NULL AND to_char(userid) = assignedto and role.roleid>=1 order by upper(firstname)");
						 //ps7.setString(1,assignedto);
				         rs7 = ps7.executeQuery();//CORRECT
				         while(rs7.next())
					     {
				        	 	assignedto = rs7.getString("assignedto");
					   	 		f2 = rs7.getString("firstname");
						        l2 = rs7.getString("lastname");
				               	full2=f2+" "+l2;
				               	logger.info("ASSIGNEDTO:"+assignedto);
                                                logger.info("ASSIGNEDTO from Edit:"+request.getParameter("assignedto"));
				               	if(assignedto.equalsIgnoreCase(request.getParameter("assignedto")))
				               	{
				               		%>
					<option value="<%=assignedto%>" selected="selected"><%=full2%></option>
					<%
				               	}
				               	else
				               	{
				               		%>
					<option value="<%=assignedto%>"><%=full2%></option>
					<%
				               	}

			              }
			              if(rs7!=null)
			              {
						   	rs7.close();
						  }
						  if(ps7!=null)
						  {
							ps7.close();
						  }
                                            } else {
                                            //Displaying the restricted users
                                                    al = CountIssue.getSpecificUsers(userId);
                                                    String getUser = null;
                                                    String assigned =   request.getParameter("assignedto");
                                                    if(assigned==null){
                                                        assigned="All Information";
                                                     }
                                                    for(int i = 0;i < al.size();i+=2){
                                                        getUser = al.get(i);

                                                    if(assigned.equalsIgnoreCase(getUser)){
                                      %>
                                      <option value="<%= getUser %>" selected><%= al.get(i + 1) %>
                                      <%
                                                        }else{
                                        %>
					<option value="<%= getUser %>"><%= al.get(i + 1) %> <%
                                                    }
                                              }
                                              }
%>

				</select></td>

			</tr>
<!--                        <tr>
                            <td></td>
                            <td></td>
                            <td><b>Search Text</b></td>
                            <td><b>Updated By</b></td>
                            
                        </tr>-->
                         <tr>
                             <td></td>
                             <td></td>
                             <td>
                                 <b>Search Text</b>
                                 <input type="text" id="subject" name="subject" maxlength="40" value="All Information" onclick="javascript:clearSearch();" onblur="javascript:popSearch();"/>
                             </td>
                             <td colspan="1">
                                 <b>Updated By</b>
                                 <select id="updatedby" name="updatedby" size="1">
					<option selected>All Information</option>

					<%
                                                    //Displaying all the users for Admin
                                                    if(roleId == 1){
                                                    try
                                                    {
                                                    ps8 = connection.prepareStatement("select distinct firstname,lastname,createdby from users,issue,role where CREATEDBY IS NOT NULL AND to_char(userid) = createdby and role.roleid>=1 order by upper(firstname)");
                                                    rs8 = ps8.executeQuery();//CORRECT
                                                    while(rs8.next())
                                                    {
                                                    logger.debug("inside while");
                                                    createdby = rs8.getString("createdby");
                                                    f2 = rs8.getString("firstname");
                                                    l2 = rs8.getString("lastname");
                                                    full2=f2+" "+l2;
                                                    logger.debug("ASSIGNEDTO:"+createdby);
                                                    if(createdby.equalsIgnoreCase(request.getParameter("createdby")))
                                                    {
                                                    %>
					<option value="<%= createdby%>" selected="selected"><%= full2%></option>
					<%
                                                    }
                                                    else
                                                    {
                                                    %>
					<option value="<%= createdby%>"><%= full2%></option>
					<%
                                                    }

                                                    }
                                                    }
                                                    catch(Exception ex)
                                                    {
                                                    logger.error("Exception"+ex);
                                                    }
                                                    if(rs8!=null)
                                                    {
                                                    rs8.close();
                                                    }
                                                    if(ps8!=null)
                                                    {
                                                    ps8.close();
                                                    }
                                                    }else {
                                                     String created =   request.getParameter("createdby");
                                                    if(created==null){
                                                        created="All Information";
                                                     }
                                                    //Displaying the restricted users
                                                        al = CountIssue.getSpecificUsers(userId);
                                                        String getUser = null;

                                                         for(int i = 0;i < al.size();i+=2){
                                                        getUser = al.get(i);

                                                    if(created.equalsIgnoreCase(getUser)){
                                      %>
                                      <option value="<%= getUser %>" selected><%= al.get(i + 1) %>
                                      <%
                                                        }else{
                                        %>
					<option value="<%= getUser %>"><%= al.get(i + 1) %> <%
                                                    }
                                              }
                                                       }
                                                    %>

				</select></td>
                             
                        </tr>
			<tr>
                            <td colspan="3" align="center"><input type="submit" id="submit"
					value="Search" name="search"></td>
			</tr>
		</table>
		<%
		}
	   	catch(Exception e)
   		{
                    logger.error("Exception in IssueSummary:"+e);
                    logger.error(e.getMessage());
   		}
                finally{
                    if(connection!=null)
                            connection.close();
                }
%>

</table>
<br>
<%
String ua = request.getHeader( "User-Agent" );
boolean isFirefox = ( ua != null && ua.indexOf( "Firefox/" ) != -1 );
boolean isMSIE = ( ua != null && ua.indexOf( "MSIE" ) != -1 );
response.setHeader( "Vary", "User-Agent" );
if (isFirefox)
{
%>


<table align="center">
	<tr>
		<td align="center"><FONT SIZE="3" COLOR="#FF0000">My
		Searches may not work properly in Mozilla FireFox Browser.</FONT></td>
	</tr>
	<tr>
		<td align="center"><FONT SIZE="3" COLOR="#FF0000">Please
		use Internet Explorer</FONT></td>
	</tr>

</table>
<%

}
%>
</FORM>
</body>
</html>

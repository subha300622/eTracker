<%-- 
    Document   : BPMViewTest
    Created on : 21 Oct, 2011, 12:04:11 PM
    Author     : Tamilvelan
--%>

<%@page import="org.apache.log4j.Logger,com.eminent.examples.ShowBPM" %>
<%@page import="com.eminentlabs.userBPM.ViewBPM" %>
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
        <script src="<%=request.getContextPath()%>/javaScript/XMLHttpRequest.js" type="text/javascript"></script>
        <script src="<%=request.getContextPath()%>/javaScript/jquery.js" type="text/javascript"></script>
        <script src="<%=request.getContextPath()%>/javaScript/jquery.cookie.js" type="text/javascript"></script>
        <script src="<%=request.getContextPath()%>/javaScript/jquery.treeview.js" type="text/javascript"></script>
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
            var pattern = "abcdefghijklmnopqrstuvwxyz,'.-_ ABCDEFGHIJKLMNOPQRSTUVWXYZ-1234567890"
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
            //$("#report").jExpand();
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
        var  xmlhttp = createRequest();
    	var showPopUp = function (popup) {
		$('#overlay').fadeIn('fast', 'swing');
		popup.center().fadeIn('fast', 'swing');
	};
        var closePopUp = function (popup) {
        popup.fadeOut('fast', 'swing');
        $('#overlay').fadeOut('fast', 'swing');
	};
        var submitProfileChangesForm = function() {
        var success = true;
        var fname		=	document.confirmProfileChangesForm.firstName.value;
        var lname		=	document.confirmProfileChangesForm.lastName.value;
        var usermail            =	document.confirmProfileChangesForm.useremail.value;
        var changedmail         =	document.confirmProfileChangesForm.email.value;
        var location            =	document.confirmProfileChangesForm.location.value;
        var cred		=       document.confirmProfileChangesForm.pswd.value;


        // Validation, Submission logic

        if (checkCredential())
        {
                updateProfile(fname,lname,changedmail,location);
                clearProfileChangesForm();
                closePopUp($('#saveChanges'));
                showPopUp($('#changeConfirm'));
                return false;
        }
        else
        {
                alert('Changes could not be saved');
        }
	};
    	function showCompany() {

		$('#overlay').fadeIn('fast', 'swing');
		$('#comppopup').center().fadeIn('fast', 'swing');

	};
        function createCompany(){

            var companyName =   document.getElementById('comp').value;
            if (trim(companyName)=='')
            {
   		document.getElementById('errormsg').style.display='block';
                document.getElementById('comp').focus();
                return false;
            }

            if (!isPositiveInteger(trim(companyName)))
            {
   		document.getElementById('errormsg').style.display='block';
               document.getElementById('comp').focus();
                return false;
            }
            
                if(xmlhttp!=null){

                xmlhttp.open("GET","${pageContext.servletContext.contextPath}/UserBPM/createCompany.jsp?company="+companyName+"&rand="+Math.random(1,10), false);

                xmlhttp.onreadystatechange = callbackCompany;
                xmlhttp.send(null);
                }else{
                    alert('no ajax request');
                }
            
        }
        function callbackCompany(){
            $('#overlay').fadeOut('fast', 'swing');
            $('#comppopup').center().fadeOut('fast', 'swing');
        }
	function addCompany(clientName) {

		alert('Alerting which clicking the client node');
                $('#'+clientName).append('<li class="expandable",">Company:Gmail<ul><li>BP:Add BP<li></ul></li>');
                 $('#'+clientName).append('<li>Company:yahoo<ul><li>BP:Add BP<li></ul></li>');
                  $('#'+clientName).append('<li>Company:hotmail<ul><li>BP:Add BP<li></ul></li>');
                   $('#'+clientName).append('<li>Company:rediffmail<ul><li>BP:Add BP<li></ul></li>');

	};
               
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
<div id="sidetreecontrol">
    <a href="?#" id="halfView" >Collapse All</a>  <a id="fullView" href="?#">Expand All</a>
</div>

<ul id="tree" >


<%

    ArrayList<String> viewClient =ViewBPM.getClient(10097);
    for( String clientName : viewClient) {
%>
<li id="<%=clientName%>" ><b>Client:</b>
            <%=clientName%>
            <ul>
                <li>Company:Add Company</li>
                <li>RBEI</li>
            </ul>
        </li>
       
<%}%>
</ul>

</div>

</div>
<!-- Page overlay and pop-ups must be outside the container div to avoid them being constrained by the container -->
		<div id="overlay"></div>
		<div id="comppopup" class="popup">
			<h3 class="popupHeading">Add Company</h3>
			<div>
                            <div style="color:red;display: none;" id="errormsg">Please enter the correct company name</div>
				<p>Enter New Company Name</p>
				<hr />
				<!-- Update form action -->
				<form action="" onSubmit='return createCompany(this)' method="post" name="confirmProfileChangesForm">
					<label for="pswd">Company</label>
					<input type="text" name="comp" id='comp'/>
                                        <input type="submit" value="Create Company"/>

				</form>
			</div>
		</div>
    </body>
</html>

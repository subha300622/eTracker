<%-- 
    Document   : treeView
    Created on : 24 Oct, 2011, 12:12:54 AM
    Author     : Tamilvelan
--%>
<%@page import="org.apache.log4j.*,com.eminent.examples.ShowBPM" %>
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
       <LINK title=STYLE href="<%= request.getContextPath() %>/eminentech support files/main_ie.css" type="text/css" rel=STYLESHEET>
       <script src="<%=request.getContextPath()%>/javaScript/XMLHttpRequest.js" type="text/javascript"></script>
       <script src="<%=request.getContextPath()%>/javaScript/jquery.js" type="text/javascript"></script>
       <style type="text/css">
           ul{list-style: none outside none;padding: 0;	margin: 0;margin-top: 4px;background-color: white;}
           ul li{padding: 3px 0px 3px 16px;margin: 0;}
           a{text-decoration: none;color: black;}
           a:link{color:black;}
       </style>
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
        function viewCompany() {

            if($('#client').has("ul").length===0){
		if(xmlhttp!=null){
                    var client  =   document.getElementById('pid').value;

                    xmlhttp.open("GET","${pageContext.servletContext.contextPath}/UserBPM/viewCompany.jsp?client="+client+"&rand="+Math.random(1,10), false);
                    xmlhttp.onreadystatechange = function(){
                        if (xmlhttp.readyState == 4)
                         {
                            if (xmlhttp.status == 200)
                            {
                                var comp = xmlhttp.responseText;
                                $('#client').append(comp);
                            }

                         }
                    };
                    xmlhttp.send(null);
                }
                }else{
               //     $('#client ul').toggle();
                }

	}
//        function callbackViewCompany(){
//             if (xmlhttp.readyState == 4)
//             {
//                if (xmlhttp.status == 200)
//                {
//                    var comp = xmlhttp.responseText;
//                    $('#client').append(comp);
//                }
//
//             }
//
//        }
        function showBP(compId) {
            alert(compId)
            document.getElementById('compid').value=compId;
		$('#overlay').fadeIn('fast', 'swing');
		$('#BPpopup').center().fadeIn('fast', 'swing');

	};
        function viewBP(company) {

            try{
                    if(xmlhttp!=null){
                        xmlhttp.open("GET","${pageContext.servletContext.contextPath}/UserBPM/viewBP.jsp?company="+company+"&rand="+Math.random(1,10), false);
                        
                        xmlhttp.onreadystatechange=function(){
                            callbackviewBP(company);
                        }
                        xmlhttp.send(null);
                        
                    }
                }catch(e){
                    alert(e);
                }
               

	}
          function callbackviewBP(company){
             if (xmlhttp.readyState == 4)
             {
                if (xmlhttp.status == 200)
                {
                    var comp = xmlhttp.responseText;
                    $('#c'+company).append(comp);
                }

             }

        }
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
                <br>
                <div>
                    <input type="hidden" value="10097" id="pid"/>
                    <ul>
                <%

    ArrayList<String> viewClient =ViewBPM.getClient(10097);
    for( String clientName : viewClient) {
%>
<li id="client">
    <a href="#" onclick="javascript:viewCompany();"><%=clientName%></a>

</li>
</ul></div>
<%}%>
      
    </body>
</html>

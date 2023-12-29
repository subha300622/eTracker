<%-- 
    Document   : adminBPM
    Created on : Jun 3, 2012, 1:29:44 PM
    Author     : Tamilvelan
--%>

<%@page import="org.apache.log4j.*,com.eminent.util.GetProjects,com.eminent.util.GetProjectMembers" %>
<%@page import="com.eminentlabs.userBPM.ViewBPM" %>
<%@page import="java.util.HashMap" %>
<%@page import="java.util.LinkedHashMap" %>
<%@page import="java.util.ArrayList" %>
<%@page import="java.util.Collection" %>
<%@page import="java.util.Iterator,dashboard.CheckCategory,dashboard.TestCases" %>

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
        <meta content="IE=EmulateIE8" http-equiv="X-UA-Compatible" >
        <title>eTracker&#0153; - Eminentlabs&#0153; CRM, BPM, APM, TQM, ERM and EPTS Solution</title>
       <LINK title=STYLE href="<%= request.getContextPath() %>/eminentech support files/main_ie.css" type="text/css" rel=STYLESHEET>
       <script src="<%=request.getContextPath()%>/javaScript/XMLHttpRequest.js" type="text/javascript"></script>
       <script src="<%=request.getContextPath()%>/javaScript/jquery.js" type="text/javascript"></script>
       <script src="<%=request.getContextPath()%>/javaScript/bp.js" type="text/javascript"></script>
       <style type="text/css">
           ul{list-style: none outside none;padding: 0;	margin: 0;margin-top: 4px;background-color: white;}
           ul li{padding: 3px 0px 3px 16px;margin: 0;}
           a{text-decoration: none;color: black;}
 
       </style>
<!--       <script type="text/javascript">
        var  xmlhttp = createRequest();
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
            var pattern = "abcdefghijklmnopqrstuvwxyz,'.-_ ABCDEFGHIJKLMNOPQRSTUVWXYZ-1234567890><"
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
        
    	var showPopUp = function (popup) {
		$('#overlay').fadeIn('fast', 'swing');
		popup.center().fadeIn('fast', 'swing');
	};
        var closePopUp = function (popup) {
        popup.fadeOut('fast', 'swing');
        $('#overlay').fadeOut('fast', 'swing');
	};
        var submitProfileChangesForm = function() {



        
	};
    	function showCompany() {
                
                document.getElementById('pId').value= document.getElementById('pid').value;
                $('#overlay').attr('height',$(window).height());
		$('#overlay').fadeIn('fast', 'swing');
		$('#comppopup').center().fadeIn('fast', 'swing');


	};

        function createCompany(){

            var companyName =   document.getElementById('comp').value;
            var pid         =   document.getElementById('pId').value;
            document.getElementById('comp').value='';
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

                xmlhttp.open("GET","${pageContext.servletContext.contextPath}/UserBPM/createCompany.jsp?company="+companyName+"&pid="+pid+"&rand="+Math.random(1,10), false);

                xmlhttp.onreadystatechange = function(){
                        callbackCompany();
                    };
                xmlhttp.send(null);
                }else{
                    alert('no ajax request');
                }

        }
        function callbackCompany(){
            $('#overlay').fadeOut('fast', 'swing');
            $('#comppopup').center().fadeOut('fast', 'swing');
            if (xmlhttp.readyState == 4)
             {
                if (xmlhttp.status == 200)
                {
                    var comp = xmlhttp.responseText;
                    $('#client ul li.lastcompany').before(comp);
                    
                }

             }
        }
        function closeCompany(){
            $('#overlay').fadeOut('fast', 'swing');
            $('#comppopup').center().fadeOut('fast', 'swing');

        }
        function viewCompany(pid) {

            $('#client div').toggleClass('treeExpand');
            if($('#client').has("ul").length==0){
		if(xmlhttp!=null){
                    var client  =   document.getElementById('pid').value;

                    xmlhttp.open("GET","${pageContext.servletContext.contextPath}/UserBPM/viewCompany.jsp?client="+client+"&pid="+pid+"&rand="+Math.random(1,10), false);
                    xmlhttp.onreadystatechange = function(){
                        callbackViewCompany();
                    };
                    xmlhttp.send(null);
                }
                }else{
                    $('#client ul').toggle('slow');
                }

	}
        function callbackViewCompany(){
             if (xmlhttp.readyState == 4)
             {
                if (xmlhttp.status == 200)
                {
                    var comp = xmlhttp.responseText;
                    $('#client').append(comp);
                }

             }
            
        }
        function showBP(compId) {
            document.getElementById('compid').value=compId;
		$('#overlay').fadeIn('fast', 'swing');
		$('#BPpopup').center().fadeIn('fast', 'swing');

	};
        function closeBP(){
            $('#overlay').fadeOut('fast', 'swing');
            $('#BPpopup').center().fadeOut('fast', 'swing');
        }
        function callbackBP(company){
            $('#overlay').fadeOut('fast', 'swing');
            $('#BPpopup').center().fadeOut('fast', 'swing');
            if (xmlhttp.readyState == 4)
             {
                if (xmlhttp.status == 200)
                {
                    var newBp = xmlhttp.responseText;
                    $('#'+company+' ul li.lastbp').before(newBp);

                }

             }
        }
        function viewBP(company) {
        $('#c'+company+' div').toggleClass('treeExpand');
        if($('#c'+company).has("ul").length==0){
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
                }else{
                    $('#c'+company+' ul').toggle('slow');
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
        function createBP(){

            var companyId    =   document.getElementById('compid').value;
    
            var bpName      =   document.getElementById('bp').value;
            document.getElementById('bp').value='';

            if (trim(bpName)=='')
            {
   		document.getElementById('bperrormsg').style.display='block';
                document.getElementById('bp').focus();
                return false;
            }

            if (!isPositiveInteger(trim(bpName)))
            {
   		document.getElementById('bperrormsg').style.display='block';
               document.getElementById('bp').focus();
                return false;
            }

            if(xmlhttp!=null){

                xmlhttp.open("GET","${pageContext.servletContext.contextPath}/UserBPM/createBP.jsp?company="+companyId+"&bpName="+bpName+"&rand="+Math.random(1,10), false);

                xmlhttp.onreadystatechange = function(){
                            callbackBP('c'+companyId);
                        };
                xmlhttp.send(null);
            }else{
                    alert('no ajax request');
            }

        }
        function showMP(bpId) {

                document.getElementById('bpid').value=bpId;
		$('#overlay').fadeIn('fast', 'swing');
		$('#MPpopup').center().fadeIn('fast', 'swing');

	};
        function closeMP(){
            $('#overlay').fadeOut('fast', 'swing');
            $('#MPpopup').center().fadeOut('fast', 'swing');
        }
        function appendMP(bp){
            $('#overlay').fadeOut('fast', 'swing');
            $('#MPpopup').center().fadeOut('fast', 'swing');
            if (xmlhttp.readyState == 4)
             {
                if (xmlhttp.status == 200)
                {
                    var newMp = xmlhttp.responseText;
                    $('#'+bp+' ul li.lastmp').before(newMp);

                }

             }
        }
        function viewMP(bpId) {
        $('#bp'+bpId+' div').toggleClass('treeExpand');
        if($('#bp'+bpId).has("ul").length==0){
            try{
		if(xmlhttp!=null){
                    xmlhttp.open("GET","${pageContext.servletContext.contextPath}/UserBPM/viewMP.jsp?bpId="+bpId+"&rand="+Math.random(1,10), false);
                    xmlhttp.onreadystatechange=function(){
                            callbackMP(bpId);
                    }
                    
                    xmlhttp.send(null);
                }
                }catch(e){
                    alert(e);
                }
            }else{
                    $('#bp'+bpId+' ul').toggle('slow');
                }

	}
        function callbackMP(bpId)
        {
            if (xmlhttp.readyState === 4 && xmlhttp.status === 200) {
                         var bp = xmlhttp.responseText;
                         $('#bp'+bpId).append(bp);

                    }
        }
        function createMP(){

            var bpId    =   document.getElementById('bpid').value;
            var mpName      =   document.getElementById('mp').value;
            document.getElementById('mp').value='';
            if (trim(mpName)=='')
            {
   		document.getElementById('mperrormsg').style.display='block';
                document.getElementById('mp').focus();
                return false;
            }

            if (!isPositiveInteger(trim(mpName)))
            {
   		document.getElementById('mperrormsg').style.display='block';
               document.getElementById('mp').focus();
                return false;
            }

            if(xmlhttp!=null){

                xmlhttp.open("GET","${pageContext.servletContext.contextPath}/UserBPM/createMP.jsp?bpId="+bpId+"&mpName="+mpName+"&rand="+Math.random(1,10), false);

                xmlhttp.onreadystatechange = function(){
                           appendMP('bp'+bpId);
                        };
                xmlhttp.send(null);
            }else{
                    alert('no ajax request');
            }

        }
        function showSP(mpId) {

            document.getElementById('mpid').value=mpId;
            $('#overlay').fadeIn('fast', 'swing');
            $('#SPpopup').center().fadeIn('fast', 'swing');

	};
        function closeSP(){
            $('#overlay').fadeOut('fast', 'swing');
            $('#SPpopup').center().fadeOut('fast', 'swing');
        }
        function appendSP(mp){
            $('#overlay').fadeOut('fast', 'swing');
            $('#SPpopup').center().fadeOut('fast', 'swing');
            if (xmlhttp.readyState == 4)
             {
                if (xmlhttp.status == 200)
                {
                    var newSp = xmlhttp.responseText;
                    $('#'+mp+' ul li.lastsp').before(newSp);

                }

             }
        }
        function viewSP(mpId) {
           $('#mp'+mpId+' div').toggleClass('treeExpand');
          if($('#mp'+mpId).has("ul").length==0){
              try{
		if(xmlhttp!=null){
                    xmlhttp.open("GET","${pageContext.servletContext.contextPath}/UserBPM/viewSP.jsp?mpId="+mpId+"&rand="+Math.random(1,10), false);
                    xmlhttp.onreadystatechange=function(){
                            callbackSP(mpId);
                    }
                    xmlhttp.send(null);
                    
                }
                }catch(e){
                    alert(e);
                }
                }else{
                    $('#mp'+mpId+' ul').toggle('slow');
                }
	}
        function callbackSP(mpId){
            if (xmlhttp.readyState === 4 && xmlhttp.status === 200) {
                         var sp = xmlhttp.responseText;
                         $('#mp'+mpId).append(sp);
                    }
        }
        function createSP(){

            var mpId    =   document.getElementById('mpid').value;
            var spName      =   document.getElementById('sp').value;
            document.getElementById('mpid').value='';
            if (trim(spName)=='')
            {
   		document.getElementById('sperrormsg').style.display='block';
                document.getElementById('sp').focus();
                return false;
            }

            if (!isPositiveInteger(trim(spName)))
            {
   		document.getElementById('sperrormsg').style.display='block';
               document.getElementById('sp').focus();
                return false;
            }

            if(xmlhttp!=null){

                xmlhttp.open("GET","${pageContext.servletContext.contextPath}/UserBPM/createSP.jsp?mpId="+mpId+"&spName="+spName+"&rand="+Math.random(1,10), false);

                xmlhttp.onreadystatechange = function(){
                    appendSP('mp'+mpId);
                };
                xmlhttp.send(null);
            }else{
                    alert('no ajax request');
            }

        }
        function showSC(spId) {

            document.getElementById('spid').value=spId;
            $('#overlay').fadeIn('fast', 'swing');
            $('#SCpopup').center().fadeIn('fast', 'swing');

	};
        function closeSC(){
            $('#overlay').fadeOut('fast', 'swing');
            $('#SCpopup').center().fadeOut('fast', 'swing');
        }
        function appendSC(scId){
            $('#overlay').fadeOut('fast', 'swing');
            $('#SCpopup').center().fadeOut('fast', 'swing');
            if (xmlhttp.readyState == 4)
            {
                    if (xmlhttp.status == 200)
                    {
                        var newSc = xmlhttp.responseText;
                        $('#'+scId+' ul li.lastsc').before(newSc);

                    }

            }
        }
        function viewSC(spId) {

             $('#sp'+spId+' div').toggleClass('treeExpand');
             if($('#sp'+spId).has("ul").length==0){
                 try{
                    if(xmlhttp!=null){
                        xmlhttp.open("GET","${pageContext.servletContext.contextPath}/UserBPM/viewSC.jsp?spId="+spId+"&rand="+Math.random(1,10), false);
                        xmlhttp.onreadystatechange=function(){
                                callbackSC(spId);
                        }
                        xmlhttp.send(null);

                    }
                }catch(e){
                    alert(e);
                }
                }else{
                    $('#sp'+spId+' ul').toggle('slow');
                }
	}
        function callbackSC(spId){
            if (xmlhttp.readyState === 4 && xmlhttp.status === 200) {
                         var sp = xmlhttp.responseText;
                         $('#sp'+spId).append(sp);
                    }
        }
        function createSC(){

            var spId    =   document.getElementById('spid').value;
            var scName      =   document.getElementById('sc').value;
            document.getElementById('spid').value='';
            if (trim(scName)=='')
            {
   		document.getElementById('scerrormsg').style.display='block';
                document.getElementById('sc').focus();
                return false;
            }

            if (!isPositiveInteger(trim(scName)))
            {
   		document.getElementById('scerrormsg').style.display='block';
                document.getElementById('sc').focus();
                return false;
            }

            if(xmlhttp!=null){

                xmlhttp.open("GET","${pageContext.servletContext.contextPath}/UserBPM/createSC.jsp?spId="+spId+"&scName="+scName+"&rand="+Math.random(1,10), false);

                xmlhttp.onreadystatechange = function(){
                    appendSC('sp'+spId)
                };
                xmlhttp.send(null);
            }else{
                    alert('no ajax request');
            }

        }
        function showVT(scId) {
            document.getElementById('scid').value=scId;
            $('#overlay').fadeIn('fast', 'swing');
            $('#VTpopup').center().fadeIn('fast', 'swing');

	};
        function closeVT(){
            $('#overlay').fadeOut('fast', 'swing');
            $('#VTpopup').center().fadeOut('fast', 'swing');
        }
        function appendVT(sc){
            $('#overlay').fadeOut('fast', 'swing');
            $('#VTpopup').center().fadeOut('fast', 'swing');
            if (xmlhttp.readyState == 4)
            {
                    if (xmlhttp.status == 200)
                    {
                        var newVt = xmlhttp.responseText;
                        $('#'+sc+' ul li.lastvt').before(newVt);

                    }

            }
        }
        function viewVT(scId) {
             $('#sc'+scId+' div').toggleClass('treeExpand');
             if($('#sc'+scId).has("ul").length==0){
                 try{
		if(xmlhttp!=null){
                    xmlhttp.open("GET","${pageContext.servletContext.contextPath}/UserBPM/viewVT.jsp?scId="+scId+"&rand="+Math.random(1,10), false);
                     xmlhttp.onreadystatechange=function(){
                            callbackVT(scId);
                    }
                    xmlhttp.send(null);

                }
                }catch(e){
                    alert(e);
                }
                }else{
                    $('#sc'+scId+' ul').toggle('slow');
                }
	}
        function callbackVT(scId){
            if (xmlhttp.readyState === 4 && xmlhttp.status === 200) {
                         var sc = xmlhttp.responseText;
                         $('#sc'+scId).append(sc);
                    }
        }
        function createVT(){

            var scId    =   document.getElementById('scid').value;

            var vtName      =   document.getElementById('vt').value;
            var leadModule  =   document.getElementById('lead').value;
            var impactModule=   document.getElementById('impact').value;
            var type        =   document.getElementById('type').value;
            var classification   =   document.getElementById('calssification').value;
            var priority  =   document.getElementById('priority').value;
            document.getElementById('vt').value='';
            if (trim(vtName)=='')
            {
   		document.getElementById('scerrormsg').style.display='block';
                document.getElementById('vt').focus();
                return false;
            }

            if (!isPositiveInteger(trim(vtName)))
            {
   		document.getElementById('vterrormsg').style.display='block';
               document.getElementById('vt').focus();
                return false;
            }

            if(xmlhttp!=null){

                xmlhttp.open("GET","${pageContext.servletContext.contextPath}/UserBPM/createVT.jsp?scId="+scId+"&vtName="+vtName+"&leadModule="+leadModule+"&impactModule="+impactModule+"&type="+type+"&classification="+classification+"&priority="+priority+"&rand="+Math.random(1,10), false);
                xmlhttp.onreadystatechange = function(){
                    appendVT('sc'+scId)
                };
                xmlhttp.send(null);
            }else{
                    alert('no ajax request');
            }

        }
        function showTC(vtId) {
            document.getElementById('vtid').value=vtId;
            $('#overlay').fadeIn('fast', 'swing');
            $('#TCpopup').center().fadeIn('fast', 'swing');

	};
        function closeTC(){
            $('#overlay').fadeOut('fast', 'swing');
            $('#TCpopup').center().fadeOut('fast', 'swing');
        }
        function appendTC(vt){
            $('#overlay').fadeOut('fast', 'swing');
            $('#TCpopup').center().fadeOut('fast', 'swing');
            if (xmlhttp.readyState == 4)
            {
                    if (xmlhttp.status == 200)
                    {
                        var newTC = xmlhttp.responseText;
                        $('#'+vt+' ul li.lasttc').before(newTC);

                    }

            }
        }
        function viewTC(vtId) {
             $('#vt'+vtId+' div').toggleClass('treeExpand');
             if($('#vt'+vtId).has("ul").length==0){
                 try{
		if(xmlhttp!=null){
                    xmlhttp.open("GET","${pageContext.servletContext.contextPath}/UserBPM/viewTC.jsp?vtId="+vtId+"&rand="+Math.random(1,10), false);
                     xmlhttp.onreadystatechange=function(){
                            callbackTC(vtId);
                    }
                    xmlhttp.send(null);

                }
                }catch(e){
                    alert(e);
                }
                }else{
                    $('#vt'+vtId+' ul').toggle('slow');
                }
	}
        function callbackTC(vtId){
            if (xmlhttp.readyState === 4 && xmlhttp.status === 200) {
                         var vt = xmlhttp.responseText;
                         $('#vt'+vtId).append(vt);
                    }
        }
        function createTC(){

            var vtId    =   document.getElementById('vtid').value;

            var tcName      =   document.getElementById('tc').value;
            document.getElementById('tc').value='';
            if (trim(tcName)=='')
            {
   		document.getElementById('tcerrormsg').style.display='block';
                document.getElementById('tc').focus();
                return false;
            }

            if (!isPositiveInteger(trim(tcName)))
            {
   		document.getElementById('tcerrormsg').style.display='block';
               document.getElementById('tc').focus();
                return false;
            }

            if(xmlhttp!=null){

                xmlhttp.open("GET","${pageContext.servletContext.contextPath}/UserBPM/createTC.jsp?vtId="+vtId+"&tcName="+tcName+"&rand="+Math.random(1,10), false);
                xmlhttp.onreadystatechange = function(){
                    appendTC('vt'+vtId)
                };
                xmlhttp.send(null);
            }else{
                    alert('no ajax request');
            }

        }
        function showTS(tcId) {
            document.getElementById('tcid').value=tcId;
            $('#overlay').fadeIn('fast', 'swing');
            $('#TSpopup').center().fadeIn('fast', 'swing');

	};
        function closeTS(){
            $('#overlay').fadeOut('fast', 'swing');
            $('#TSpopup').center().fadeOut('fast', 'swing');
        }
        function appendTS(tc){
            $('#overlay').fadeOut('fast', 'swing');
            $('#TSpopup').center().fadeOut('fast', 'swing');
            if (xmlhttp.readyState == 4)
            {
                if (xmlhttp.status == 200)
                {
                    var newTs = xmlhttp.responseText;
                    $('#'+tc+' ul li.lastts').before(newTs);

                }

            }
        }
        function viewTS(tcId) {
             $('#tc'+tcId+' div').toggleClass('treeExpand');
             if($('#tc'+tcId).has("ul").length==0){
                 try{
		if(xmlhttp!=null){
                    xmlhttp.open("GET","${pageContext.servletContext.contextPath}/UserBPM/viewTS.jsp?tcId="+tcId+"&rand="+Math.random(1,10), false);
                     xmlhttp.onreadystatechange=function(){
                            callbackTS(tcId);
                    }
                    xmlhttp.send(null);

                }
                }catch(e){
                    alert(e);
                }
                }else{
                    $('#tc'+tcId+' ul').toggle('slow');
                }
	}
        function callbackTS(tcId){
            if (xmlhttp.readyState === 4 && xmlhttp.status === 200) {
                         var ts = xmlhttp.responseText;
                         $('#tc'+tcId).append(ts);
                    }
        }
        function createTS(){

            var tcId    =   document.getElementById('tcid').value;

            var tsName      =   document.getElementById('ts').value;
            document.getElementById('ts').value='';
            if (trim(tsName)=='')
            {
   		document.getElementById('tserrormsg').style.display='block';
                document.getElementById('ts').focus();
                return false;
            }

            if (!isPositiveInteger(trim(tsName)))
            {
   		document.getElementById('tserrormsg').style.display='block';
               document.getElementById('ts').focus();
                return false;
            }

            if(xmlhttp!=null){

                xmlhttp.open("GET","${pageContext.servletContext.contextPath}/UserBPM/createTS.jsp?tcId="+tcId+"&tsName="+tsName+"&rand="+Math.random(1,10), false);
                xmlhttp.onreadystatechange = function(){
                    appendTS('tc'+tcId);
                };
                xmlhttp.send(null);
            }else{
                    alert('no ajax request');
            }

        }
         function showTSC(tsId) {
           document.getElementById('tsid').value=tsId;
            $('#overlay').fadeIn('fast', 'swing');
            $('#TSCpopup').center().fadeIn('fast', 'swing');

	};
        function closeTSC(){
            $('#overlay').fadeOut('fast', 'swing');
            $('#TSCpopup').center().fadeOut('fast', 'swing');
        }
        function viewTSC(tsId) {
             $('#ts'+tsId+' div').toggleClass('treeExpand');
             if($('#ts'+tsId).has("ul").length==0){
                 try{
		if(xmlhttp!=null){
                    xmlhttp.open("GET","${pageContext.servletContext.contextPath}/UserBPM/viewTestScript.jsp?tsId="+tsId+"&rand="+Math.random(1,10), false);
                     xmlhttp.onreadystatechange=function(){
                            callbackTSC(tsId);
                    }
                    xmlhttp.send(null);

                }
                }catch(e){
                    alert(e);
                }
                }else{
                    $('#ts'+tsId+'ul').toggle('slow');
                }
	}
        function callbackTSC(tsId){
            if (xmlhttp.readyState === 4 && xmlhttp.status === 200) {
                         var testscript = xmlhttp.responseText;
                         $('#ts'+tsId).append(testscript);
                    }
        }
        function createTSC(){

            var tsId    =   document.getElementById('tsid').value;
            var pId     =   document.getElementById('pid').value;
            var testScript      =   document.getElementById('testScript').value;
            document.getElementById('testScript').value='';
            var expRslt      =   document.getElementById('expRslt').value;
            document.getElementById('expRslt').value='';
            if (trim(testScript)=='')
            {
   		document.getElementById('terrormsg').style.display='block';
                document.getElementById('testScript').focus();
                return false;
            }

//            if (!isPositiveInteger(trim(testScript)))
//            {
//   		document.getElementById('terrormsg').style.display='block';
//               document.getElementById('testScript').focus();
//                return false;
//            }
            if (trim(expRslt)=='')
            {
   		document.getElementById('terrormsg').style.display='block';
                document.getElementById('expRslt').focus();
                return false;
            }

//            if (!isPositiveInteger(trim(expRslt)))
//            {
//   		document.getElementById('terrormsg').style.display='block';
//                document.getElementById('expRslt').focus();
//                return false;
//            }


            if(xmlhttp!=null){

                xmlhttp.open("GET","${pageContext.servletContext.contextPath}/UserBPM/createTestScript.jsp?tsId="+tsId+"&scriptName="+testScript+"&expRslt="+expRslt+"&pid="+pId+"&rand="+Math.random(1,10), false);
                xmlhttp.onreadystatechange = function(){
                    viewNewTSC(tsId)
                };
                xmlhttp.send(null);
            }else{
                    alert('no ajax request');
            }

        }
        var newRequest = createRequest();
        function viewNewTSC(tsId) {
          
                 try{
		if(newRequest!=null){
                    newRequest.open("GET",'${pageContext.servletContext.contextPath}/UserBPM/viewTestScript.jsp?tsId='+tsId+'&rand='+Math.random(1,10),true);
                     newRequest.onreadystatechange=function(){
                            $('#ts'+tsId+' ul').remove();
                            callbackTSCView(tsId);
                    }
                    newRequest.send(null);

                }
                }catch(e){
                    alert(e);
                }

	}
        function callbackTSCView(tsId){

            if (newRequest.readyState === 4 && newRequest.status === 200) {
                         var testscript = newRequest.responseText;
                         $('#ts'+tsId).append(testscript);
            }
            $('#overlay').fadeOut('fast', 'swing');
            $('#TSCpopup').center().fadeOut('fast', 'swing');
        }
        function showComments(ptcId){

             $('#'+ptcId+' div').toggleClass('treeExpand');

            if( $('#'+ptcId+' div').hasClass('treeExpand')){
            try{
		if(newRequest!=null){
                    newRequest.open("GET",'${pageContext.servletContext.contextPath}/UserBPM/executionHistory.jsp?ptcId='+ptcId+'&rand='+Math.random(1,10),true);
                     newRequest.onreadystatechange=function(){

                            callbackComments(ptcId);
                    }
                    newRequest.send(null);

                }
                }catch(e){
                    alert(e);
                }

        }else{
            $('#ptc'+ptcId+' td').remove();
        }

        }
        function callbackComments(ptcId){
            if (newRequest.readyState === 4 && newRequest.status === 200) {

                        var comments = newRequest.responseText;
                        document.getElementById('ptc'+ptcId).innerHTML=comments;

            }
        }
      </script>-->
                
    </head>

    <body>
                <%@ include file="/header.jsp"%>
<table cellpadding="0" cellspacing="0" width="100%" bgColor="#C3D9FF">
	<tr >
		<td border="1" align="left" width="100%">
                    <font size="4" COLOR="#0000FF"><b>Business Processes Map</b></font>
                </td>
	</tr>
</table>

                
                <br>
                <div>

                    <ul id="mainTree">
                <%
                HashMap bProcess =   ViewBPM.getAllBP();
    LinkedHashMap businessProcess=GetProjectMembers.sortHashMapByKeys(bProcess,true);
    String bpName  =   "";
    if(businessProcess.size()>0){
        Collection set=businessProcess.keySet();
        Iterator ite = set.iterator();
        int mpCount =   0;
        while (ite.hasNext()) {
            int key=(Integer)ite.next();
            String nameofbp=(String)businessProcess.get(key);
            mpCount         =   ViewBPM.getMPCount(key);
            %>
            <li id='bp<%=key%>' class='expandable'> <div class='treeclass' onclick='javascript:viewMP("<%=key%>")'></div><a href='#'  onclick='javascript:viewMP("<%=key%>")' ><b>Business Process:</b> <%=nameofbp%> (<%=mpCount%>) </a></li>
<%
        }
        

    }

    %>
</ul></div>
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
                                                <input type="hidden" name="pid" id='pid' value=""/>
                                                <input type="submit" value="Create Test Script" onclick="javascript:createTSC();"/>
                                                <input type="button" value="Cancel" onclick="javascript:closeTSC();"/>
                                            </td>
                                        </tr>
                                 </table>

			</div>
		</div>
    </body>
</html>

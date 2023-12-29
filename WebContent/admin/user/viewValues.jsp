<%--
    Document   : testEditPage
    Created on : Mar 16, 2009, 3:24:04 PM
    Author     : Tamilvelan
--%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="org.apache.log4j.Logger,pack.eminent.encryption.*,com.pack.SessionCounter,java.util.*,com.eminent.util.*"%>
<%
	Logger logger = Logger.getLogger("ViewValues");
	String logoutcheck=(String)session.getAttribute("Name");
	if(logoutcheck==null)
	{
             logger.fatal("================Session expired===================");
		%>
<jsp:forward page="../SessionExpired.jsp"></jsp:forward>
<%

	}
%>
 <%@ include file="/header.jsp"%>
 <%

        String pageToDisplay    =   request.getParameter("viewpage");

        String tablename    =   null;
        
        String header       =   "Value Administration";

        HashMap<String,Integer> hm=GetValues.checkValue();
        int bug         =   hm.get("bug");
        int enhancement =   hm.get("enhancement");
        int newtask     =   hm.get("newtask");

           if(pageToDisplay.equals("bug")){
                tablename   =   "VALUE_NONSAP_BUG";
                header      =   "Non SAP Bug Value Administration";
            }
            else if(pageToDisplay.equals("enhancement"))
            {
                 tablename  =   "VALUE_NONSAP_ENHANCEMENT";
                 header     =   "Non SAP Enhancement Value Administration";
            }
            else if(pageToDisplay.equals("newtask"))
            {
                tablename="VALUE_NONSAP_NEWTASK";
                header      =   "Non SAP New Task Value Administration";
            }



        ArrayList al=new ArrayList<String>();

        al  =   GetValues.getValue(pageToDisplay);
        logger.info("Size"+al.size());
        logger.info("Values"+al);
        int index   =   0;
 %>
<html>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
        <meta http-equiv="Content-Type" content="text/html">
        <title>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS Solution</title>
        <LINK title=STYLE	href="<%= request.getContextPath() %>/eminentech support files/main_ie.css"type=text/css rel=STYLESHEET>
        <script>
            function trim(str)  {
                while (str.charAt(str.length - 1)==" ")
                str = str.substring(0, str.length - 1);
                while (str.charAt(0)==" ")
                str = str.substring(1, str.length);
                return str;
        }
        function isNumber(str)
        {
            var pattern = "0123456789";
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
                if (pos==0){
                    return false;
                }
                return true;

        }


         function validate(stat){

             for(var i=1;i<=4;i++){
                 for(var j=1;j<=4;j++){
                     var status=stat+"P"+i+"S"+j;
                        if (trim(document.getElementById(status).value)=='')
                        {
                                alert('Please enter the '+status+' Value');
                                document.getElementById(status).value="";
                                 document.getElementById(status).style.display = '';
                                document.getElementById(status).focus();
                                return false;
                        }
                        if (!isNumber(trim(document.getElementById(status).value)))
                            {
                                alert('Please enter the Numericals only in the '+status+' Value ');
                                document.getElementById(status).value="";
                                document.getElementById(status).focus();
                                return false;
                        }

                 }
             }
               return true;

         }
             function flashRow(obj) {
            obj.bgColor = "#FFFF99";
            }
            function unFlashRow(obj) {
                obj.bgColor = "#F6F6F6";
            }

            function createRequestObject() {
                var xmlHttp;
                try {
                    // Firefox, Opera 8.0+, Safari
                    xmlHttp=new XMLHttpRequest();
                } catch (e) {
                    // Internet Explorer
                    try {
                        xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
                    } catch (e) {
                        try {
                            xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
                        } catch (e) {
                            alert("Your browser does not support AJAX!");
                            return false;
                          }
                      }
                  }
                return xmlHttp;
              }
              var http = createRequestObject();

            function sndReq(action) {

                http.open('get', action);
                http.onreadystatechange = setUnconfirmed;
                http.send(null);
            }

           function sndConfirmedReq(action) {

                http.open('get', action);
                http.onreadystatechange = setConfirmed;
                http.send(null);
            }
             function sndInvestigationReq(action) {

                http.open('get', action);
                http.onreadystatechange = setInvestigation;
                http.send(null);
            }
            function setConfirmed(){
                if(http.readyState==4){

                   if(http.status==200){
                       var res=http.responseText;
                   if(res==1){
                    document.getElementById('confirmedp1s1_readonly').innerHTML = document.getElementById('confirmedp1s1').value;
                    document.getElementById('confirmedp1s2_readonly').innerHTML = document.getElementById('confirmedp1s2').value;;
                    document.getElementById('confirmedp1s3_readonly').innerHTML = document.getElementById('confirmedp1s3').value;
                    document.getElementById('confirmedp1s4_readonly').innerHTML = document.getElementById('confirmedp1s4').value;

                    document.getElementById('confirmedp2s1_readonly').innerHTML = document.getElementById('confirmedp2s1').value;
                    document.getElementById('confirmedp2s2_readonly').innerHTML = document.getElementById('confirmedp2s2').value;
                    document.getElementById('confirmedp2s3_readonly').innerHTML = document.getElementById('confirmedp2s3').value;
                    document.getElementById('confirmedp2s4_readonly').innerHTML = document.getElementById('confirmedp2s4').value;

                    document.getElementById('confirmedp3s1_readonly').innerHTML = document.getElementById('confirmedp3s1').value;
                    document.getElementById('confirmedp3s2_readonly').innerHTML = document.getElementById('confirmedp3s2').value;
                    document.getElementById('confirmedp3s3_readonly').innerHTML = document.getElementById('confirmedp3s3').value;
                    document.getElementById('confirmedp3s4_readonly').innerHTML = document.getElementById('confirmedp3s4').value;

                    document.getElementById('confirmedp4s1_readonly').innerHTML = document.getElementById('confirmedp4s1').value;
                    document.getElementById('confirmedp4s2_readonly').innerHTML = document.getElementById('confirmedp4s2').value;
                    document.getElementById('confirmedp4s3_readonly').innerHTML = document.getElementById('confirmedp4s3').value;
                    document.getElementById('confirmedp4s4_readonly').innerHTML = document.getElementById('confirmedp4s4').value;

                    document.getElementById('confirmed_readonly').style.display = '';
                    document.getElementById('confirmed_edit').style.display = 'none';
                   }else{
                       document.getElementById('confirmed_edit').style.display = '';
                       document.getElementById('confirmed_readonly').style.display = 'none';
                       alert('Error Occurred, Please Contact Administrator');


                   }

                  }
                }
            }
            function setInvestigation(){
                if(http.readyState==4){
                    if(http.status==200){
                       var res=http.responseText;
                   if(res==1){
                    document.getElementById('investigationp1s1_readonly').innerHTML = document.getElementById('investigationp1s1').value;
                    document.getElementById('investigationp1s2_readonly').innerHTML = document.getElementById('investigationp1s2').value;;
                    document.getElementById('investigationp1s3_readonly').innerHTML = document.getElementById('investigationp1s3').value;
                    document.getElementById('investigationp1s4_readonly').innerHTML = document.getElementById('confirmedp1s4').value;

                    document.getElementById('investigationp2s1_readonly').innerHTML = document.getElementById('investigationp2s1').value;
                    document.getElementById('investigationp2s2_readonly').innerHTML = document.getElementById('investigationp2s2').value;
                    document.getElementById('investigationp2s3_readonly').innerHTML = document.getElementById('investigationp2s3').value;
                    document.getElementById('investigationp2s4_readonly').innerHTML = document.getElementById('investigationp2s4').value;

                    document.getElementById('investigationp3s1_readonly').innerHTML = document.getElementById('investigationp3s1').value;
                    document.getElementById('investigationp3s2_readonly').innerHTML = document.getElementById('investigationp3s2').value;
                    document.getElementById('investigationp3s3_readonly').innerHTML = document.getElementById('investigationp3s3').value;
                    document.getElementById('investigationp3s4_readonly').innerHTML = document.getElementById('investigationp3s4').value;

                    document.getElementById('investigationp4s1_readonly').innerHTML = document.getElementById('investigationp4s1').value;
                    document.getElementById('investigationp4s2_readonly').innerHTML = document.getElementById('investigationp4s2').value;
                    document.getElementById('investigationp4s3_readonly').innerHTML = document.getElementById('investigationp4s3').value;
                    document.getElementById('investigationp4s4_readonly').innerHTML = document.getElementById('investigationp4s4').value;

                    document.getElementById('investigation_readonly').style.display = '';
                    document.getElementById('investigation_edit').style.display = 'none';
                   }else{
                       document.getElementById('investigation_edit').style.display = '';
                       document.getElementById('investigation_readonly').style.display = 'none';
                       alert('Error Occurred, Please Contact Administrator');


                   }

                  }

                }
            }

            function setUnconfirmed(){
                if(http.readyState==4){

                  if(http.status==200){
                       var res=http.responseText;
                   if(res==1){
                    document.getElementById('unconfirmedp1s1_readonly').innerHTML = document.getElementById('unconfirmedp1s1').value;
                    document.getElementById('unconfirmedp1s2_readonly').innerHTML = document.getElementById('unconfirmedp1s2').value;
                    document.getElementById('unconfirmedp1s3_readonly').innerHTML = document.getElementById('unconfirmedp1s3').value;
                    document.getElementById('unconfirmedp1s4_readonly').innerHTML = document.getElementById('unconfirmedp1s4').value;

                    document.getElementById('unconfirmedp2s1_readonly').innerHTML = document.getElementById('unconfirmedp2s1').value;
                    document.getElementById('unconfirmedp2s2_readonly').innerHTML = document.getElementById('unconfirmedp2s2').value;
                    document.getElementById('unconfirmedp2s3_readonly').innerHTML = document.getElementById('unconfirmedp2s3').value;
                    document.getElementById('unconfirmedp2s4_readonly').innerHTML = document.getElementById('unconfirmedp2s4').value;

                    document.getElementById('unconfirmedp3s1_readonly').innerHTML = document.getElementById('unconfirmedp3s1').value;
                    document.getElementById('unconfirmedp3s2_readonly').innerHTML = document.getElementById('unconfirmedp3s2').value;
                    document.getElementById('unconfirmedp3s3_readonly').innerHTML = document.getElementById('unconfirmedp3s3').value;
                    document.getElementById('unconfirmedp3s4_readonly').innerHTML = document.getElementById('unconfirmedp3s4').value;

                    document.getElementById('unconfirmedp4s1_readonly').innerHTML = document.getElementById('unconfirmedp4s1').value;
                    document.getElementById('unconfirmedp4s2_readonly').innerHTML = document.getElementById('unconfirmedp4s2').value;
                    document.getElementById('unconfirmedp4s3_readonly').innerHTML = document.getElementById('unconfirmedp4s3').value;
                    document.getElementById('unconfirmedp4s4_readonly').innerHTML = document.getElementById('unconfirmedp4s4').value;

                    document.getElementById('unconfirmed_readonly').style.display = '';
                    document.getElementById('unconfirmed_edit').style.display = 'none';


                   }
                   else{
                        document.getElementById('unconfirmed_readonly').style.display = 'none';
                        document.getElementById('unconfirmed_edit').style.display = '';
                        alert('Error Occurred, Please Contact Administrator');
                   }
                  }
                }
            }






        function uncon_Edit(){

          document.getElementById('unconfirmed_readonly').style.display = 'none';
          document.getElementById('unconfirmed_edit').style.display = '';

          document.getElementById('rejected_readonly').style.display = '';
          document.getElementById('rejected_edit').style.display = 'none';

          document.getElementById('duplicate_readonly').style.display = '';
          document.getElementById('duplicate_edit').style.display = 'none';

		  document.getElementById('confirmed_readonly').style.display = '';
          document.getElementById('confirmed_edit').style.display = 'none';

          document.getElementById('investigation_readonly').style.display = '';
          document.getElementById('investigation_edit').style.display = 'none';

		  document.getElementById('development_readonly').style.display = '';
          document.getElementById('development_edit').style.display = 'none';

		  document.getElementById('workinprogress_readonly').style.display = '';
          document.getElementById('workinprogress_edit').style.display = 'none';

		  document.getElementById('codereview_readonly').style.display = '';
          document.getElementById('codereview_edit').style.display = 'none';

          document.getElementById('readytobuild_readonly').style.display = '';
          document.getElementById('readytobuild_edit').style.display = 'none';

          document.getElementById('qa_readonly').style.display = '';
          document.getElementById('qa_edit').style.display = 'none';

          document.getElementById('performancetesting_readonly').style.display = '';
          document.getElementById('performancetesting_edit').style.display = 'none';

          document.getElementById('verified_readonly').style.display = '';
          document.getElementById('verified_edit').style.display = 'none';

          document.getElementById('closed_readonly').style.display = '';
          document.getElementById('closed_edit').style.display = 'none';


        }
        function uncon_Save(){
            var status="unconfirmed";
            if(validate(status)){
                var statusid    =   document.getElementById('unconfirmedid').value;
                document.getElementById('unconfirmed_edit').style.display='none';

                var req = 'updateValue.jsp?stat='+statusid+'&unconfirmedp1s1=' + document.getElementById('unconfirmedp1s1').value+'&unconfirmedp1s2='+document.getElementById('unconfirmedp1s2').value+'&unconfirmedp1s3='+document.getElementById('unconfirmedp1s3').value+'&unconfirmedp1s4='+document.getElementById('unconfirmedp1s4').value+'&unconfirmedp2s1='+document.getElementById('unconfirmedp2s1').value+'&unconfirmedp2s2='+document.getElementById('unconfirmedp2s2').value+'&unconfirmedp2s3='+document.getElementById('unconfirmedp2s3').value+'&unconfirmedp2s4='+document.getElementById('unconfirmedp2s4').value+"&rand="+'&unconfirmedp3s1='+document.getElementById('unconfirmedp3s1').value+'&unconfirmedp3s2='+document.getElementById('unconfirmedp3s2').value+'&unconfirmedp3s3='+document.getElementById('unconfirmedp3s3').value+'&unconfirmedp3s4='+document.getElementById('unconfirmedp3s4').value+'&unconfirmedp4s1='+document.getElementById('unconfirmedp4s1').value+'&unconfirmedp4s2='+document.getElementById('unconfirmedp4s2').value+'&unconfirmedp4s3='+document.getElementById('unconfirmedp4s3').value+'&unconfirmedp4s4='+document.getElementById('unconfirmedp4s4').value+"&rand="+Math.random(1,10);
                sndReq(req);
            }

        }
        function uncon_Cancel(){
            document.getElementById('unconfirmed_readonly').style.display = '';
            document.getElementById('unconfirmed_edit').style.display = 'none';

        }

        function con_Edit(){

          document.getElementById('unconfirmed_readonly').style.display = '';
          document.getElementById('unconfirmed_edit').style.display = 'none';

          document.getElementById('rejected_readonly').style.display = '';
          document.getElementById('rejected_edit').style.display = 'none';

          document.getElementById('duplicate_readonly').style.display = '';
          document.getElementById('duplicate_edit').style.display = 'none';

		  document.getElementById('confirmed_readonly').style.display = 'none';
          document.getElementById('confirmed_edit').style.display = '';

          document.getElementById('investigation_readonly').style.display = '';
          document.getElementById('investigation_edit').style.display = 'none';

		  document.getElementById('development_readonly').style.display = '';
          document.getElementById('development_edit').style.display = 'none';

		  document.getElementById('workinprogress_readonly').style.display = '';
          document.getElementById('workinprogress_edit').style.display = 'none';

		  document.getElementById('codereview_readonly').style.display = '';
          document.getElementById('codereview_edit').style.display = 'none';

          document.getElementById('readytobuild_readonly').style.display = '';
          document.getElementById('readytobuild_edit').style.display = 'none';

          document.getElementById('qa_readonly').style.display = '';
          document.getElementById('qa_edit').style.display = 'none';

          document.getElementById('performancetesting_readonly').style.display = '';
          document.getElementById('performancetesting_edit').style.display = 'none';

          document.getElementById('verified_readonly').style.display = '';
          document.getElementById('verified_edit').style.display = 'none';

          document.getElementById('closed_readonly').style.display = '';
          document.getElementById('closed_edit').style.display = 'none';


        }
        function con_Save(){
            var status="confirmed";
            if(validate(status)){
                var statusid    =   document.getElementById('confirmedid').value;
                document.getElementById('confirmed_edit').style.display='none';

                var req = 'updateValue.jsp?stat='+statusid+'&confirmedp1s1=' + document.getElementById('confirmedp1s1').value+'&confirmedp1s2='+document.getElementById('confirmedp1s2').value+'&confirmedp1s3='+document.getElementById('confirmedp1s3').value+'&confirmedp1s4='+document.getElementById('confirmedp1s4').value+'&confirmedp2s1='+document.getElementById('confirmedp2s1').value+'&confirmedp2s2='+document.getElementById('confirmedp2s2').value+'&confirmedp2s3='+document.getElementById('confirmedp2s3').value+'&confirmedp2s4='+document.getElementById('confirmedp2s4').value+"&rand="+'&confirmedp3s1='+document.getElementById('confirmedp3s1').value+'&confirmedp3s2='+document.getElementById('confirmedp3s2').value+'&confirmedp3s3='+document.getElementById('confirmedp3s3').value+'&confirmedp3s4='+document.getElementById('confirmedp3s4').value+'&confirmedp4s1='+document.getElementById('confirmedp4s1').value+'&confirmedp4s2='+document.getElementById('confirmedp4s2').value+'&confirmedp4s3='+document.getElementById('confirmedp4s3').value+'&confirmedp4s4='+document.getElementById('confirmedp4s4').value+"&rand="+Math.random(1,10);
                sndConfirmedReq(req);
            }

        }
        function con_Cancel(){
            document.getElementById('confirmed_readonly').style.display = '';
            document.getElementById('confirmed_edit').style.display = 'none';

        }

          function in_Edit(){

         document.getElementById('unconfirmed_readonly').style.display = '';
          document.getElementById('unconfirmed_edit').style.display = 'none';

          document.getElementById('rejected_readonly').style.display = '';
          document.getElementById('rejected_edit').style.display = 'none';

          document.getElementById('duplicate_readonly').style.display = '';
          document.getElementById('duplicate_edit').style.display = 'none';

		  document.getElementById('confirmed_readonly').style.display = '';
          document.getElementById('confirmed_edit').style.display = 'none';

          document.getElementById('investigation_readonly').style.display = 'none';
          document.getElementById('investigation_edit').style.display = '';

		  document.getElementById('development_readonly').style.display = '';
          document.getElementById('development_edit').style.display = 'none';

		  document.getElementById('workinprogress_readonly').style.display = '';
          document.getElementById('workinprogress_edit').style.display = 'none';

		  document.getElementById('codereview_readonly').style.display = '';
          document.getElementById('codereview_edit').style.display = 'none';

          document.getElementById('readytobuild_readonly').style.display = '';
          document.getElementById('readytobuild_edit').style.display = 'none';

          document.getElementById('qa_readonly').style.display = '';
          document.getElementById('qa_edit').style.display = 'none';

          document.getElementById('performancetesting_readonly').style.display = '';
          document.getElementById('performancetesting_edit').style.display = 'none';

          document.getElementById('verified_readonly').style.display = '';
          document.getElementById('verified_edit').style.display = 'none';


          document.getElementById('closed_readonly').style.display = '';
          document.getElementById('closed_edit').style.display = 'none';


        }
        function in_Save(){
            var status="investigation";
            if(validate(status)){
                var statusid    =   document.getElementById('investigationid').value;
                document.getElementById('investigation_edit').style.display='none';

                var req = 'updateValue.jsp?stat='+statusid+'&investigationp1s1=' + document.getElementById('investigationp1s1').value+'&investigationp1s2='+document.getElementById('investigationp1s2').value+'&investigationp1s3='+document.getElementById('investigationp1s3').value+'&investigationp1s4='+document.getElementById('investigationp1s4').value+'&investigationp2s1='+document.getElementById('investigationp2s1').value+'&investigationp2s2='+document.getElementById('investigationp2s2').value+'&investigationp2s3='+document.getElementById('investigationp2s3').value+'&investigationp2s4='+document.getElementById('investigationp2s4').value+'&investigationp3s1='+document.getElementById('investigationp3s1').value+'&investigationp3s2='+document.getElementById('investigationp3s2').value+'&investigationp3s3='+document.getElementById('investigationp3s3').value+'&investigationp3s4='+document.getElementById('investigationp3s4').value+'&investigationp4s1='+document.getElementById('investigationp4s1').value+'&investigationp4s2='+document.getElementById('investigationp4s2').value+'&investigationp4s3='+document.getElementById('investigationp4s3').value+'&investigationp4s4='+document.getElementById('investigationp4s4').value+"&rand="+Math.random(1,10);
                sndInvestigationReq(req);
            }

        }
        function in_Cancel(){
            document.getElementById('investigation_readonly').style.display = '';
            document.getElementById('investigation_edit').style.display = 'none';

        }
        function sndRejectedReq(action) {

                http.open('get', action);
                http.onreadystatechange = setRejected;
                http.send(null);
            }
        function setRejected(){
                if(http.readyState==4){

                   if(http.status==200){
                       var res=http.responseText;
                   if(res==1){
                    document.getElementById('rejectedp1s1_readonly').innerHTML = document.getElementById('rejectedp1s1').value;
                    document.getElementById('rejectedp1s2_readonly').innerHTML = document.getElementById('rejectedp1s2').value;;
                    document.getElementById('rejectedp1s3_readonly').innerHTML = document.getElementById('rejectedp1s3').value;
                    document.getElementById('rejectedp1s4_readonly').innerHTML = document.getElementById('rejectedp1s4').value;

                    document.getElementById('rejectedp2s1_readonly').innerHTML = document.getElementById('rejectedp2s1').value;
                    document.getElementById('rejectedp2s2_readonly').innerHTML = document.getElementById('rejectedp2s2').value;
                    document.getElementById('rejectedp2s3_readonly').innerHTML = document.getElementById('rejectedp2s3').value;
                    document.getElementById('rejectedp2s4_readonly').innerHTML = document.getElementById('rejectedp2s4').value;

                    document.getElementById('rejectedp3s1_readonly').innerHTML = document.getElementById('rejectedp3s1').value;
                    document.getElementById('rejectedp3s2_readonly').innerHTML = document.getElementById('rejectedp3s2').value;
                    document.getElementById('rejectedp3s3_readonly').innerHTML = document.getElementById('rejectedp3s3').value;
                    document.getElementById('rejectedp3s4_readonly').innerHTML = document.getElementById('rejectedp3s4').value;

                    document.getElementById('rejectedp4s1_readonly').innerHTML = document.getElementById('rejectedp4s1').value;
                    document.getElementById('rejectedp4s2_readonly').innerHTML = document.getElementById('rejectedp4s2').value;
                    document.getElementById('rejectedp4s3_readonly').innerHTML = document.getElementById('rejectedp4s3').value;
                    document.getElementById('rejectedp4s4_readonly').innerHTML = document.getElementById('rejectedp4s4').value;

                    document.getElementById('rejected_readonly').style.display = '';
                    document.getElementById('rejected_edit').style.display = 'none';
                   }else{
                       document.getElementById('rejected_edit').style.display = '';
                       document.getElementById('rejected_readonly').style.display = 'none';
                       alert('Error Occurred, Please Contact Administrator');


                   }

                  }
                }
            }

        function rejected_Edit(){

          document.getElementById('unconfirmed_readonly').style.display = '';
          document.getElementById('unconfirmed_edit').style.display = 'none';

          document.getElementById('rejected_readonly').style.display = 'none';
          document.getElementById('rejected_edit').style.display = '';

          document.getElementById('duplicate_readonly').style.display = '';
          document.getElementById('duplicate_edit').style.display = 'none';

		  document.getElementById('confirmed_readonly').style.display = '';
          document.getElementById('confirmed_edit').style.display = 'none';

          document.getElementById('investigation_readonly').style.display = '';
          document.getElementById('investigation_edit').style.display = 'none';

		  document.getElementById('development_readonly').style.display = '';
          document.getElementById('development_edit').style.display = 'none';

		  document.getElementById('workinprogress_readonly').style.display = '';
          document.getElementById('workinprogress_edit').style.display = 'none';

		  document.getElementById('codereview_readonly').style.display = '';
          document.getElementById('codereview_edit').style.display = 'none';

          document.getElementById('readytobuild_readonly').style.display = '';
          document.getElementById('readytobuild_edit').style.display = 'none';

          document.getElementById('qa_readonly').style.display = '';
          document.getElementById('qa_edit').style.display = 'none';

          document.getElementById('performancetesting_readonly').style.display = '';
          document.getElementById('performancetesting_edit').style.display = 'none';

          document.getElementById('verified_readonly').style.display = '';
          document.getElementById('verified_edit').style.display = 'none';


          document.getElementById('closed_readonly').style.display = '';
          document.getElementById('closed_edit').style.display = 'none';



        }
        function rejected_Save(){
            var status="rejected";
            if(validate(status)){
                var statusid    =   document.getElementById('rejectedid').value;
                document.getElementById('rejected_edit').style.display='none';

                var req = 'updateValue.jsp?stat='+statusid+'&rejectedp1s1=' + document.getElementById('rejectedp1s1').value+'&rejectedp1s2='+document.getElementById('rejectedp1s2').value+'&rejectedp1s3='+document.getElementById('rejectedp1s3').value+'&rejectedp1s4='+document.getElementById('rejectedp1s4').value+'&rejectedp2s1='+document.getElementById('rejectedp2s1').value+'&rejectedp2s2='+document.getElementById('rejectedp2s2').value+'&rejectedp2s3='+document.getElementById('rejectedp2s3').value+'&rejectedp2s4='+document.getElementById('rejectedp2s4').value+"&rand="+'&rejectedp3s1='+document.getElementById('rejectedp3s1').value+'&rejectedp3s2='+document.getElementById('rejectedp3s2').value+'&rejectedp3s3='+document.getElementById('rejectedp3s3').value+'&rejectedp3s4='+document.getElementById('rejectedp3s4').value+'&rejectedp4s1='+document.getElementById('rejectedp4s1').value+'&rejectedp4s2='+document.getElementById('rejectedp4s2').value+'&rejectedp4s3='+document.getElementById('rejectedp4s3').value+'&rejectedp4s4='+document.getElementById('rejectedp4s4').value+"&rand="+Math.random(1,10);
                sndRejectedReq(req);
            }

        }
        function rejected_Cancel(){
            document.getElementById('rejected_readonly').style.display = '';
            document.getElementById('rejected_edit').style.display = 'none';

        }
        function sndDuplicateReq(action) {

                http.open('get', action);
                http.onreadystatechange = setDuplicate;
                http.send(null);
            }
function setDuplicate(){
                if(http.readyState==4){

                   if(http.status==200){
                       var res=http.responseText;
                   if(res==1){
                       alert('in side set duplicate');
                    document.getElementById('duplicatep1s1_readonly').innerHTML = document.getElementById('duplicatep1s1').value;
                    document.getElementById('duplicatep1s2_readonly').innerHTML = document.getElementById('duplicatep1s2').value;;
                    document.getElementById('duplicatep1s3_readonly').innerHTML = document.getElementById('duplicatep1s3').value;
                    document.getElementById('duplicatep1s4_readonly').innerHTML = document.getElementById('duplicatep1s4').value;

                    document.getElementById('duplicatep2s1_readonly').innerHTML = document.getElementById('duplicatep2s1').value;
                    document.getElementById('duplicatep2s2_readonly').innerHTML = document.getElementById('duplicatep2s2').value;
                    document.getElementById('duplicatep2s3_readonly').innerHTML = document.getElementById('duplicatep2s3').value;
                    document.getElementById('duplicatep2s4_readonly').innerHTML = document.getElementById('duplicatep2s4').value;

                    document.getElementById('duplicatep3s1_readonly').innerHTML = document.getElementById('duplicatep3s1').value;
                    document.getElementById('duplicatep3s2_readonly').innerHTML = document.getElementById('duplicatep3s2').value;
                    document.getElementById('duplicatep3s3_readonly').innerHTML = document.getElementById('duplicatep3s3').value;
                    document.getElementById('duplicatep3s4_readonly').innerHTML = document.getElementById('duplicatep3s4').value;

                    document.getElementById('duplicatep4s1_readonly').innerHTML = document.getElementById('duplicatep4s1').value;
                    document.getElementById('duplicatep4s2_readonly').innerHTML = document.getElementById('duplicatep4s2').value;
                    document.getElementById('duplicatep4s3_readonly').innerHTML = document.getElementById('duplicatep4s3').value;
                    document.getElementById('duplicatep4s4_readonly').innerHTML = document.getElementById('duplicatep4s4').value;

                    document.getElementById('duplicate_readonly').style.display = '';
                    document.getElementById('duplicate_edit').style.display = 'none';
                   }else{
                       document.getElementById('duplicate_edit').style.display = '';
                       document.getElementById('duplicate_readonly').style.display = 'none';
                       alert('Error Occurred, Please Contact Administrator');


                   }

                  }
                }
            }

 function duplicate_Edit(){

          document.getElementById('unconfirmed_readonly').style.display = '';
          document.getElementById('unconfirmed_edit').style.display = 'none';

          document.getElementById('rejected_readonly').style.display = '';
          document.getElementById('rejected_edit').style.display = 'none';

          document.getElementById('duplicate_readonly').style.display = 'none';
          document.getElementById('duplicate_edit').style.display = '';

		  document.getElementById('confirmed_readonly').style.display = '';
          document.getElementById('confirmed_edit').style.display = 'none';

          document.getElementById('investigation_readonly').style.display = '';
          document.getElementById('investigation_edit').style.display = 'none';

		  document.getElementById('development_readonly').style.display = '';
          document.getElementById('development_edit').style.display = 'none';

		  document.getElementById('workinprogress_readonly').style.display = '';
          document.getElementById('workinprogress_edit').style.display = 'none';

		  document.getElementById('codereview_readonly').style.display = '';
          document.getElementById('codereview_edit').style.display = 'none';

          document.getElementById('readytobuild_readonly').style.display = '';
          document.getElementById('readytobuild_edit').style.display = 'none';

          document.getElementById('qa_readonly').style.display = '';
          document.getElementById('qa_edit').style.display = 'none';

          document.getElementById('performancetesting_readonly').style.display = '';
          document.getElementById('performancetesting_edit').style.display = 'none';

          document.getElementById('verified_readonly').style.display = '';
          document.getElementById('verified_edit').style.display = 'none';


          document.getElementById('closed_readonly').style.display = '';
          document.getElementById('closed_edit').style.display = 'none';



        }
        function duplicate_Save(){
            var status="duplicate";
            if(validate(status)){
                var statusid    =   document.getElementById('duplicateid').value;
                document.getElementById('duplicate_edit').style.display='none';

                var req = 'updateValue.jsp?stat='+statusid+'&duplicatep1s1=' + document.getElementById('duplicatep1s1').value+'&duplicatep1s2='+document.getElementById('duplicatep1s2').value+'&duplicatep1s3='+document.getElementById('duplicatep1s3').value+'&duplicatep1s4='+document.getElementById('duplicatep1s4').value+'&duplicatep2s1='+document.getElementById('duplicatep2s1').value+'&duplicatep2s2='+document.getElementById('duplicatep2s2').value+'&duplicatep2s3='+document.getElementById('duplicatep2s3').value+'&duplicatep2s4='+document.getElementById('duplicatep2s4').value+"&rand="+'&duplicatep3s1='+document.getElementById('duplicatep3s1').value+'&duplicatep3s2='+document.getElementById('duplicatep3s2').value+'&duplicatep3s3='+document.getElementById('duplicatep3s3').value+'&duplicatep3s4='+document.getElementById('duplicatep3s4').value+'&duplicatep4s1='+document.getElementById('duplicatep4s1').value+'&duplicatep4s2='+document.getElementById('duplicatep4s2').value+'&duplicatep4s3='+document.getElementById('duplicatep4s3').value+'&duplicatep4s4='+document.getElementById('duplicatep4s4').value+"&rand="+Math.random(1,10);
                sndDuplicateReq(req);
            }

        }
        function duplicate_Cancel(){
            document.getElementById('duplicate_readonly').style.display = '';
            document.getElementById('duplicate_edit').style.display = 'none';

        }

        function sndDevelopmentReq(action) {

                http.open('get', action);
                http.onreadystatechange = setDevelopment;
                http.send(null);
            }
function setDevelopment(){
                if(http.readyState==4){

                   if(http.status==200){
                       var res=http.responseText;
                   if(res==1){
                    document.getElementById('developmentp1s1_readonly').innerHTML = document.getElementById('developmentp1s1').value;
                    document.getElementById('developmentp1s2_readonly').innerHTML = document.getElementById('developmentp1s2').value;;
                    document.getElementById('developmentp1s3_readonly').innerHTML = document.getElementById('developmentp1s3').value;
                    document.getElementById('developmentp1s4_readonly').innerHTML = document.getElementById('developmentp1s4').value;

                    document.getElementById('developmentp2s1_readonly').innerHTML = document.getElementById('developmentp2s1').value;
                    document.getElementById('developmentp2s2_readonly').innerHTML = document.getElementById('developmentp2s2').value;
                    document.getElementById('developmentp2s3_readonly').innerHTML = document.getElementById('developmentp2s3').value;
                    document.getElementById('developmentp2s4_readonly').innerHTML = document.getElementById('developmentp2s4').value;

                    document.getElementById('developmentp3s1_readonly').innerHTML = document.getElementById('developmentp3s1').value;
                    document.getElementById('developmentp3s2_readonly').innerHTML = document.getElementById('developmentp3s2').value;
                    document.getElementById('developmentp3s3_readonly').innerHTML = document.getElementById('developmentp3s3').value;
                    document.getElementById('developmentp3s4_readonly').innerHTML = document.getElementById('developmentp3s4').value;

                    document.getElementById('developmentp4s1_readonly').innerHTML = document.getElementById('developmentp4s1').value;
                    document.getElementById('developmentp4s2_readonly').innerHTML = document.getElementById('developmentp4s2').value;
                    document.getElementById('developmentp4s3_readonly').innerHTML = document.getElementById('developmentp4s3').value;
                    document.getElementById('developmentp4s4_readonly').innerHTML = document.getElementById('developmentp4s4').value;

                    document.getElementById('development_readonly').style.display = '';
                    document.getElementById('development_edit').style.display = 'none';
                   }else{
                       document.getElementById('development_edit').style.display = '';
                       document.getElementById('development_readonly').style.display = 'none';
                       alert('Error Occurred, Please Contact Administrator');


                   }

                  }
                }
            }

 function development_Edit(){

         document.getElementById('unconfirmed_readonly').style.display = '';
          document.getElementById('unconfirmed_edit').style.display = 'none';

          document.getElementById('rejected_readonly').style.display = '';
          document.getElementById('rejected_edit').style.display = 'none';

          document.getElementById('duplicate_readonly').style.display = '';
          document.getElementById('duplicate_edit').style.display = 'none';

		  document.getElementById('confirmed_readonly').style.display = '';
          document.getElementById('confirmed_edit').style.display = 'none';

          document.getElementById('investigation_readonly').style.display = '';
          document.getElementById('investigation_edit').style.display = 'none';

		  document.getElementById('development_readonly').style.display = 'none';
          document.getElementById('development_edit').style.display = '';

		  document.getElementById('workinprogress_readonly').style.display = '';
          document.getElementById('workinprogress_edit').style.display = 'none';

		  document.getElementById('codereview_readonly').style.display = '';
          document.getElementById('codereview_edit').style.display = 'none';

          document.getElementById('readytobuild_readonly').style.display = '';
          document.getElementById('readytobuild_edit').style.display = 'none';

          document.getElementById('qa_readonly').style.display = '';
          document.getElementById('qa_edit').style.display = 'none';

          document.getElementById('performancetesting_readonly').style.display = '';
          document.getElementById('performancetesting_edit').style.display = 'none';

          document.getElementById('verified_readonly').style.display = '';
          document.getElementById('verified_edit').style.display = 'none';


          document.getElementById('closed_readonly').style.display = '';
          document.getElementById('closed_edit').style.display = 'none';



        }
        function development_Save(){
            var status="development";
            if(validate(status)){
                var statusid    =   document.getElementById('developmentid').value;
                document.getElementById('development_edit').style.display='none';

                var req = 'updateValue.jsp?stat='+statusid+'&developmentp1s1=' + document.getElementById('developmentp1s1').value+'&developmentp1s2='+document.getElementById('developmentp1s2').value+'&developmentp1s3='+document.getElementById('developmentp1s3').value+'&developmentp1s4='+document.getElementById('developmentp1s4').value+'&developmentp2s1='+document.getElementById('developmentp2s1').value+'&developmentp2s2='+document.getElementById('developmentp2s2').value+'&developmentp2s3='+document.getElementById('developmentp2s3').value+'&developmentp2s4='+document.getElementById('developmentp2s4').value+"&rand="+'&developmentp3s1='+document.getElementById('developmentp3s1').value+'&developmentp3s2='+document.getElementById('developmentp3s2').value+'&developmentp3s3='+document.getElementById('developmentp3s3').value+'&developmentp3s4='+document.getElementById('developmentp3s4').value+'&developmentp4s1='+document.getElementById('developmentp4s1').value+'&developmentp4s2='+document.getElementById('developmentp4s2').value+'&developmentp4s3='+document.getElementById('developmentp4s3').value+'&developmentp4s4='+document.getElementById('developmentp4s4').value+"&rand="+Math.random(1,10);
                sndDevelopmentReq(req);
            }

        }
        function development_Cancel(){
            document.getElementById('development_readonly').style.display = '';
            document.getElementById('development_edit').style.display = 'none';

        }
 function sndWorkinprogressReq(action) {

                http.open('get', action);
                http.onreadystatechange = setWorkinprogress;
                http.send(null);
            }
function setWorkinprogress(){
                if(http.readyState==4){

                   if(http.status==200){
                       var res=http.responseText;
                   if(res==1){
                    document.getElementById('workinprogressp1s1_readonly').innerHTML = document.getElementById('workinprogressp1s1').value;
                    document.getElementById('workinprogressp1s2_readonly').innerHTML = document.getElementById('workinprogressp1s2').value;;
                    document.getElementById('workinprogressp1s3_readonly').innerHTML = document.getElementById('workinprogressp1s3').value;
                    document.getElementById('workinprogressp1s4_readonly').innerHTML = document.getElementById('workinprogressp1s4').value;

                    document.getElementById('workinprogressp2s1_readonly').innerHTML = document.getElementById('workinprogressp2s1').value;
                    document.getElementById('workinprogressp2s2_readonly').innerHTML = document.getElementById('workinprogressp2s2').value;
                    document.getElementById('workinprogressp2s3_readonly').innerHTML = document.getElementById('workinprogressp2s3').value;
                    document.getElementById('workinprogressp2s4_readonly').innerHTML = document.getElementById('workinprogressp2s4').value;

                    document.getElementById('workinprogressp3s1_readonly').innerHTML = document.getElementById('workinprogressp3s1').value;
                    document.getElementById('workinprogressp3s2_readonly').innerHTML = document.getElementById('workinprogressp3s2').value;
                    document.getElementById('workinprogressp3s3_readonly').innerHTML = document.getElementById('workinprogressp3s3').value;
                    document.getElementById('workinprogressp3s4_readonly').innerHTML = document.getElementById('workinprogressp3s4').value;

                    document.getElementById('workinprogressp4s1_readonly').innerHTML = document.getElementById('workinprogressp4s1').value;
                    document.getElementById('workinprogressp4s2_readonly').innerHTML = document.getElementById('workinprogressp4s2').value;
                    document.getElementById('workinprogressp4s3_readonly').innerHTML = document.getElementById('workinprogressp4s3').value;
                    document.getElementById('workinprogressp4s4_readonly').innerHTML = document.getElementById('workinprogressp4s4').value;

                    document.getElementById('workinprogress_readonly').style.display = '';
                    document.getElementById('workinprogress_edit').style.display = 'none';
                   }else{
                       document.getElementById('workinprogress_edit').style.display = '';
                       document.getElementById('workinprogress_readonly').style.display = 'none';
                       alert('Error Occurred, Please Contact Administrator');


                   }

                  }
                }
            }

 function workinprogress_Edit(){

          document.getElementById('unconfirmed_readonly').style.display = '';
          document.getElementById('unconfirmed_edit').style.display = 'none';

          document.getElementById('rejected_readonly').style.display = '';
          document.getElementById('rejected_edit').style.display = 'none';

          document.getElementById('duplicate_readonly').style.display = '';
          document.getElementById('duplicate_edit').style.display = 'none';

		  document.getElementById('confirmed_readonly').style.display = '';
          document.getElementById('confirmed_edit').style.display = 'none';

          document.getElementById('investigation_readonly').style.display = '';
          document.getElementById('investigation_edit').style.display = 'none';

		  document.getElementById('development_readonly').style.display = '';
          document.getElementById('development_edit').style.display = 'none';

		  document.getElementById('workinprogress_readonly').style.display = 'none';
          document.getElementById('workinprogress_edit').style.display = '';

		  document.getElementById('codereview_readonly').style.display = '';
          document.getElementById('codereview_edit').style.display = 'none';

          document.getElementById('readytobuild_readonly').style.display = '';
          document.getElementById('readytobuild_edit').style.display = 'none';

          document.getElementById('qa_readonly').style.display = '';
          document.getElementById('qa_edit').style.display = 'none';

          document.getElementById('performancetesting_readonly').style.display = '';
          document.getElementById('performancetesting_edit').style.display = 'none';

          document.getElementById('verified_readonly').style.display = '';
          document.getElementById('verified_edit').style.display = 'none';


          document.getElementById('closed_readonly').style.display = '';
          document.getElementById('closed_edit').style.display = 'none';



        }
        function workinprogress_Save(){
            var status="workinprogress";
            if(validate(status)){
                var statusid    =   document.getElementById('workinprogressid').value;
                document.getElementById('workinprogress_edit').style.display='none';

                var req = 'updateValue.jsp?stat='+statusid+'&workinprogressp1s1=' + document.getElementById('workinprogressp1s1').value+'&workinprogressp1s2='+document.getElementById('workinprogressp1s2').value+'&workinprogressp1s3='+document.getElementById('workinprogressp1s3').value+'&workinprogressp1s4='+document.getElementById('workinprogressp1s4').value+'&workinprogressp2s1='+document.getElementById('workinprogressp2s1').value+'&workinprogressp2s2='+document.getElementById('workinprogressp2s2').value+'&workinprogressp2s3='+document.getElementById('workinprogressp2s3').value+'&workinprogressp2s4='+document.getElementById('workinprogressp2s4').value+"&rand="+'&workinprogressp3s1='+document.getElementById('workinprogressp3s1').value+'&workinprogressp3s2='+document.getElementById('workinprogressp3s2').value+'&workinprogressp3s3='+document.getElementById('workinprogressp3s3').value+'&workinprogressp3s4='+document.getElementById('workinprogressp3s4').value+'&workinprogressp4s1='+document.getElementById('workinprogressp4s1').value+'&workinprogressp4s2='+document.getElementById('workinprogressp4s2').value+'&workinprogressp4s3='+document.getElementById('workinprogressp4s3').value+'&workinprogressp4s4='+document.getElementById('workinprogressp4s4').value+"&rand="+Math.random(1,10);
                sndWorkinprogressReq(req);
            }

        }
        function workinprogress_Cancel(){
            document.getElementById('workinprogress_readonly').style.display = '';
            document.getElementById('workinprogress_edit').style.display = 'none';

        }
        function sndCodeReviewReq(action) {

                http.open('get', action);
                http.onreadystatechange = setcodereview;
                http.send(null);
            }
function setcodereview(){
                if(http.readyState==4){

                   if(http.status==200){
                       var res=http.responseText;
                   if(res==1){
                    document.getElementById('codereviewp1s1_readonly').innerHTML = document.getElementById('codereviewp1s1').value;
                    document.getElementById('codereviewp1s2_readonly').innerHTML = document.getElementById('codereviewp1s2').value;;
                    document.getElementById('codereviewp1s3_readonly').innerHTML = document.getElementById('codereviewp1s3').value;
                    document.getElementById('codereviewp1s4_readonly').innerHTML = document.getElementById('codereviewp1s4').value;

                    document.getElementById('codereviewp2s1_readonly').innerHTML = document.getElementById('codereviewp2s1').value;
                    document.getElementById('codereviewp2s2_readonly').innerHTML = document.getElementById('codereviewp2s2').value;
                    document.getElementById('codereviewp2s3_readonly').innerHTML = document.getElementById('codereviewp2s3').value;
                    document.getElementById('codereviewp2s4_readonly').innerHTML = document.getElementById('codereviewp2s4').value;

                    document.getElementById('codereviewp3s1_readonly').innerHTML = document.getElementById('codereviewp3s1').value;
                    document.getElementById('codereviewp3s2_readonly').innerHTML = document.getElementById('codereviewp3s2').value;
                    document.getElementById('codereviewp3s3_readonly').innerHTML = document.getElementById('codereviewp3s3').value;
                    document.getElementById('codereviewp3s4_readonly').innerHTML = document.getElementById('codereviewp3s4').value;

                    document.getElementById('codereviewp4s1_readonly').innerHTML = document.getElementById('codereviewp4s1').value;
                    document.getElementById('codereviewp4s2_readonly').innerHTML = document.getElementById('codereviewp4s2').value;
                    document.getElementById('codereviewp4s3_readonly').innerHTML = document.getElementById('codereviewp4s3').value;
                    document.getElementById('codereviewp4s4_readonly').innerHTML = document.getElementById('codereviewp4s4').value;

                    document.getElementById('codereview_readonly').style.display = '';
                    document.getElementById('codereview_edit').style.display = 'none';
                   }else{
                       document.getElementById('codereview_edit').style.display = '';
                       document.getElementById('codereview_readonly').style.display = 'none';
                       alert('Error Occurred, Please Contact Administrator');


                   }

                  }
                }
            }

 function codereview_Edit(){

          document.getElementById('unconfirmed_readonly').style.display = '';
          document.getElementById('unconfirmed_edit').style.display = 'none';

          document.getElementById('rejected_readonly').style.display = '';
          document.getElementById('rejected_edit').style.display = 'none';

          document.getElementById('duplicate_readonly').style.display = '';
          document.getElementById('duplicate_edit').style.display = 'none';

		  document.getElementById('confirmed_readonly').style.display = '';
          document.getElementById('confirmed_edit').style.display = 'none';

          document.getElementById('investigation_readonly').style.display = '';
          document.getElementById('investigation_edit').style.display = 'none';

		  document.getElementById('development_readonly').style.display = '';
          document.getElementById('development_edit').style.display = 'none';

		  document.getElementById('workinprogress_readonly').style.display = '';
          document.getElementById('workinprogress_edit').style.display = 'none';

		  document.getElementById('codereview_readonly').style.display = 'none';
          document.getElementById('codereview_edit').style.display = '';

          document.getElementById('readytobuild_readonly').style.display = '';
          document.getElementById('readytobuild_edit').style.display = 'none';

          document.getElementById('qa_readonly').style.display = '';
          document.getElementById('qa_edit').style.display = 'none';

          document.getElementById('performancetesting_readonly').style.display = '';
          document.getElementById('performancetesting_edit').style.display = 'none';

          document.getElementById('verified_readonly').style.display = '';
          document.getElementById('verified_edit').style.display = 'none';


          document.getElementById('closed_readonly').style.display = '';
          document.getElementById('closed_edit').style.display = 'none';



        }
        function codereview_Save(){
            var status="codereview";
            if(validate(status)){
                var statusid    =   document.getElementById('codereviewid').value;
                document.getElementById('codereview_edit').style.display='none';

                var req = 'updateValue.jsp?stat='+statusid+'&codereviewp1s1=' + document.getElementById('codereviewp1s1').value+'&codereviewp1s2='+document.getElementById('codereviewp1s2').value+'&codereviewp1s3='+document.getElementById('codereviewp1s3').value+'&codereviewp1s4='+document.getElementById('codereviewp1s4').value+'&codereviewp2s1='+document.getElementById('codereviewp2s1').value+'&codereviewp2s2='+document.getElementById('codereviewp2s2').value+'&codereviewp2s3='+document.getElementById('codereviewp2s3').value+'&codereviewp2s4='+document.getElementById('codereviewp2s4').value+"&rand="+'&codereviewp3s1='+document.getElementById('codereviewp3s1').value+'&codereviewp3s2='+document.getElementById('codereviewp3s2').value+'&codereviewp3s3='+document.getElementById('codereviewp3s3').value+'&codereviewp3s4='+document.getElementById('codereviewp3s4').value+'&codereviewp4s1='+document.getElementById('codereviewp4s1').value+'&codereviewp4s2='+document.getElementById('codereviewp4s2').value+'&codereviewp4s3='+document.getElementById('codereviewp4s3').value+'&codereviewp4s4='+document.getElementById('codereviewp4s4').value+"&rand="+Math.random(1,10);
                sndCodeReviewReq(req);
            }

        }
        function codereview_Cancel(){
            document.getElementById('codereview_readonly').style.display = '';
            document.getElementById('codereview_edit').style.display = 'none';

        }

function sndReadytobuildReq(action) {

                http.open('get', action);
                http.onreadystatechange = setReadytobuild;
                http.send(null);
            }
function setReadytobuild(){
                if(http.readyState==4){

                   if(http.status==200){
                       var res=http.responseText;
                   if(res==1){
                    document.getElementById('readytobuildp1s1_readonly').innerHTML = document.getElementById('readytobuildp1s1').value;
                    document.getElementById('readytobuildp1s2_readonly').innerHTML = document.getElementById('readytobuildp1s2').value;;
                    document.getElementById('readytobuildp1s3_readonly').innerHTML = document.getElementById('readytobuildp1s3').value;
                    document.getElementById('readytobuildp1s4_readonly').innerHTML = document.getElementById('readytobuildp1s4').value;

                    document.getElementById('readytobuildp2s1_readonly').innerHTML = document.getElementById('readytobuildp2s1').value;
                    document.getElementById('readytobuildp2s2_readonly').innerHTML = document.getElementById('readytobuildp2s2').value;
                    document.getElementById('readytobuildp2s3_readonly').innerHTML = document.getElementById('readytobuildp2s3').value;
                    document.getElementById('readytobuildp2s4_readonly').innerHTML = document.getElementById('readytobuildp2s4').value;

                    document.getElementById('readytobuildp3s1_readonly').innerHTML = document.getElementById('readytobuildp3s1').value;
                    document.getElementById('readytobuildp3s2_readonly').innerHTML = document.getElementById('readytobuildp3s2').value;
                    document.getElementById('readytobuildp3s3_readonly').innerHTML = document.getElementById('readytobuildp3s3').value;
                    document.getElementById('readytobuildp3s4_readonly').innerHTML = document.getElementById('readytobuildp3s4').value;

                    document.getElementById('readytobuildp4s1_readonly').innerHTML = document.getElementById('readytobuildp4s1').value;
                    document.getElementById('readytobuildp4s2_readonly').innerHTML = document.getElementById('readytobuildp4s2').value;
                    document.getElementById('readytobuildp4s3_readonly').innerHTML = document.getElementById('readytobuildp4s3').value;
                    document.getElementById('readytobuildp4s4_readonly').innerHTML = document.getElementById('readytobuildp4s4').value;

                    document.getElementById('readytobuild_readonly').style.display = '';
                    document.getElementById('readytobuild_edit').style.display = 'none';
                   }else{
                       document.getElementById('readytobuild_edit').style.display = '';
                       document.getElementById('readytobuild_readonly').style.display = 'none';
                       alert('Error Occurred, Please Contact Administrator');


                   }

                  }
                }
            }

 function readytobuild_Edit(){


          document.getElementById('unconfirmed_readonly').style.display = '';
          document.getElementById('unconfirmed_edit').style.display = 'none';

          document.getElementById('rejected_readonly').style.display = '';
          document.getElementById('rejected_edit').style.display = 'none';

          document.getElementById('duplicate_readonly').style.display = '';
          document.getElementById('duplicate_edit').style.display = 'none';

		  document.getElementById('confirmed_readonly').style.display = '';
          document.getElementById('confirmed_edit').style.display = 'none';

          document.getElementById('investigation_readonly').style.display = '';
          document.getElementById('investigation_edit').style.display = 'none';

		  document.getElementById('development_readonly').style.display = '';
          document.getElementById('development_edit').style.display = 'none';

		  document.getElementById('workinprogress_readonly').style.display = '';
          document.getElementById('workinprogress_edit').style.display = 'none';

		  document.getElementById('codereview_readonly').style.display = '';
          document.getElementById('codereview_edit').style.display = 'none';

          document.getElementById('readytobuild_readonly').style.display = 'none';
          document.getElementById('readytobuild_edit').style.display = '';

          document.getElementById('qa_readonly').style.display = '';
          document.getElementById('qa_edit').style.display = 'none';

          document.getElementById('performancetesting_readonly').style.display = '';
          document.getElementById('performancetesting_edit').style.display = 'none';

          document.getElementById('verified_readonly').style.display = '';
          document.getElementById('verified_edit').style.display = 'none';


          document.getElementById('closed_readonly').style.display = '';
          document.getElementById('closed_edit').style.display = 'none';





        }
        function readytobuild_Save(){
            var status="readytobuild";
            if(validate(status)){
                var statusid    =   document.getElementById('readytobuildid').value;
                document.getElementById('readytobuild_edit').style.display='none';

                var req = 'updateValue.jsp?stat='+statusid+'&readytobuildp1s1=' + document.getElementById('readytobuildp1s1').value+'&readytobuildp1s2='+document.getElementById('readytobuildp1s2').value+'&readytobuildp1s3='+document.getElementById('readytobuildp1s3').value+'&readytobuildp1s4='+document.getElementById('readytobuildp1s4').value+'&readytobuildp2s1='+document.getElementById('readytobuildp2s1').value+'&readytobuildp2s2='+document.getElementById('readytobuildp2s2').value+'&readytobuildp2s3='+document.getElementById('readytobuildp2s3').value+'&readytobuildp2s4='+document.getElementById('readytobuildp2s4').value+"&rand="+'&readytobuildp3s1='+document.getElementById('readytobuildp3s1').value+'&readytobuildp3s2='+document.getElementById('readytobuildp3s2').value+'&readytobuildp3s3='+document.getElementById('readytobuildp3s3').value+'&readytobuildp3s4='+document.getElementById('readytobuildp3s4').value+'&readytobuildp4s1='+document.getElementById('readytobuildp4s1').value+'&readytobuildp4s2='+document.getElementById('readytobuildp4s2').value+'&readytobuildp4s3='+document.getElementById('readytobuildp4s3').value+'&readytobuildp4s4='+document.getElementById('readytobuildp4s4').value+"&rand="+Math.random(1,10);
                sndReadytobuildReq(req);
            }

        }
        function readytobuild_Cancel(){
            document.getElementById('readytobuild_readonly').style.display = '';
            document.getElementById('readytobuild_edit').style.display = 'none';

        }

        function sndqaReq(action) {

                http.open('get', action);
                http.onreadystatechange = setQA;
                http.send(null);
            }
        function setQA(){
                if(http.readyState==4){

                   if(http.status==200){
                       var res=http.responseText;
                   if(res==1){
                    document.getElementById('qap1s1_readonly').innerHTML = document.getElementById('qap1s1').value;
                    document.getElementById('qap1s2_readonly').innerHTML = document.getElementById('qap1s2').value;;
                    document.getElementById('qap1s3_readonly').innerHTML = document.getElementById('qap1s3').value;
                    document.getElementById('qap1s4_readonly').innerHTML = document.getElementById('qap1s4').value;

                    document.getElementById('qap2s1_readonly').innerHTML = document.getElementById('qap2s1').value;
                    document.getElementById('qap2s2_readonly').innerHTML = document.getElementById('qap2s2').value;
                    document.getElementById('qap2s3_readonly').innerHTML = document.getElementById('qap2s3').value;
                    document.getElementById('qap2s4_readonly').innerHTML = document.getElementById('qap2s4').value;

                    document.getElementById('qap3s1_readonly').innerHTML = document.getElementById('qap3s1').value;
                    document.getElementById('qap3s2_readonly').innerHTML = document.getElementById('qap3s2').value;
                    document.getElementById('qap3s3_readonly').innerHTML = document.getElementById('qap3s3').value;
                    document.getElementById('qap3s4_readonly').innerHTML = document.getElementById('qap3s4').value;

                    document.getElementById('qap4s1_readonly').innerHTML = document.getElementById('qap4s1').value;
                    document.getElementById('qap4s2_readonly').innerHTML = document.getElementById('qap4s2').value;
                    document.getElementById('qap4s3_readonly').innerHTML = document.getElementById('qap4s3').value;
                    document.getElementById('qap4s4_readonly').innerHTML = document.getElementById('qap4s4').value;

                    document.getElementById('qa_readonly').style.display = '';
                    document.getElementById('qa_edit').style.display = 'none';
                   }else{
                       document.getElementById('qa_edit').style.display = '';
                       document.getElementById('qa_readonly').style.display = 'none';
                       alert('Error Occurred, Please Contact Administrator');


                   }

                  }
                }
            }

 function qa_Edit(){



          document.getElementById('unconfirmed_readonly').style.display = '';
          document.getElementById('unconfirmed_edit').style.display = 'none';

          document.getElementById('rejected_readonly').style.display = '';
          document.getElementById('rejected_edit').style.display = 'none';

          document.getElementById('duplicate_readonly').style.display = '';
          document.getElementById('duplicate_edit').style.display = 'none';

		  document.getElementById('confirmed_readonly').style.display = '';
          document.getElementById('confirmed_edit').style.display = 'none';

          document.getElementById('investigation_readonly').style.display = '';
          document.getElementById('investigation_edit').style.display = 'none';

		  document.getElementById('development_readonly').style.display = '';
          document.getElementById('development_edit').style.display = 'none';

		  document.getElementById('workinprogress_readonly').style.display = '';
          document.getElementById('workinprogress_edit').style.display = 'none';

		  document.getElementById('codereview_readonly').style.display = '';
          document.getElementById('codereview_edit').style.display = 'none';

          document.getElementById('readytobuild_readonly').style.display = '';
          document.getElementById('readytobuild_edit').style.display = 'none';


          document.getElementById('qa_readonly').style.display = 'none';
          document.getElementById('qa_edit').style.display = '';

          document.getElementById('performancetesting_readonly').style.display = '';
          document.getElementById('performancetesting_edit').style.display = 'none';

           document.getElementById('verified_readonly').style.display = '';
          document.getElementById('verified_edit').style.display = 'none';


          document.getElementById('closed_readonly').style.display = '';
          document.getElementById('closed_edit').style.display = 'none';




        }
        function qa_Save(){
            var status="qa";
            if(validate(status)){
                var statusid    =   document.getElementById('qaid').value;
                document.getElementById('qa_edit').style.display='none';

                var req = 'updateValue.jsp?stat='+statusid+'&qap1s1=' + document.getElementById('qap1s1').value+'&qap1s2='+document.getElementById('qap1s2').value+'&qap1s3='+document.getElementById('qap1s3').value+'&qap1s4='+document.getElementById('qap1s4').value+'&qap2s1='+document.getElementById('qap2s1').value+'&qap2s2='+document.getElementById('qap2s2').value+'&qap2s3='+document.getElementById('qap2s3').value+'&qap2s4='+document.getElementById('qap2s4').value+"&rand="+'&qap3s1='+document.getElementById('qap3s1').value+'&qap3s2='+document.getElementById('qap3s2').value+'&qap3s3='+document.getElementById('qap3s3').value+'&qap3s4='+document.getElementById('qap3s4').value+'&qap4s1='+document.getElementById('qap4s1').value+'&qap4s2='+document.getElementById('qap4s2').value+'&qap4s3='+document.getElementById('qap4s3').value+'&qap4s4='+document.getElementById('qap4s4').value+"&rand="+Math.random(1,10);
                sndqaReq(req);
            }

        }
        function qa_Cancel(){
            document.getElementById('qa_readonly').style.display = '';
            document.getElementById('qa_edit').style.display = 'none';

        }

        function sndPerformancetestingReq(action) {

                http.open('get', action);
                http.onreadystatechange = setPerformancetesting;
                http.send(null);
            }
    function setPerformancetesting(){
                if(http.readyState==4){

                   if(http.status==200){
                       var res=http.responseText;
                   if(res==1){
                    document.getElementById('performancetestingp1s1_readonly').innerHTML = document.getElementById('performancetestingp1s1').value;
                    document.getElementById('performancetestingp1s2_readonly').innerHTML = document.getElementById('performancetestingp1s2').value;;
                    document.getElementById('performancetestingp1s3_readonly').innerHTML = document.getElementById('performancetestingp1s3').value;
                    document.getElementById('performancetestingp1s4_readonly').innerHTML = document.getElementById('performancetestingp1s4').value;

                    document.getElementById('performancetestingp2s1_readonly').innerHTML = document.getElementById('performancetestingp2s1').value;
                    document.getElementById('performancetestingp2s2_readonly').innerHTML = document.getElementById('performancetestingp2s2').value;
                    document.getElementById('performancetestingp2s3_readonly').innerHTML = document.getElementById('performancetestingp2s3').value;
                    document.getElementById('performancetestingp2s4_readonly').innerHTML = document.getElementById('performancetestingp2s4').value;

                    document.getElementById('performancetestingp3s1_readonly').innerHTML = document.getElementById('performancetestingp3s1').value;
                    document.getElementById('performancetestingp3s2_readonly').innerHTML = document.getElementById('performancetestingp3s2').value;
                    document.getElementById('performancetestingp3s3_readonly').innerHTML = document.getElementById('performancetestingp3s3').value;
                    document.getElementById('performancetestingp3s4_readonly').innerHTML = document.getElementById('performancetestingp3s4').value;

                    document.getElementById('performancetestingp4s1_readonly').innerHTML = document.getElementById('performancetestingp4s1').value;
                    document.getElementById('performancetestingp4s2_readonly').innerHTML = document.getElementById('performancetestingp4s2').value;
                    document.getElementById('performancetestingp4s3_readonly').innerHTML = document.getElementById('performancetestingp4s3').value;
                    document.getElementById('performancetestingp4s4_readonly').innerHTML = document.getElementById('performancetestingp4s4').value;

                    document.getElementById('performancetesting_readonly').style.display = '';
                    document.getElementById('performancetesting_edit').style.display = 'none';
                   }else{
                       document.getElementById('performancetesting_edit').style.display = '';
                       document.getElementById('performancetesting_readonly').style.display = 'none';
                       alert('Error Occurred, Please Contact Administrator');


                   }

                  }
                }
            }

 function performancetesting_Edit(){

          document.getElementById('unconfirmed_readonly').style.display = '';
          document.getElementById('unconfirmed_edit').style.display = 'none';

          document.getElementById('rejected_readonly').style.display = '';
          document.getElementById('rejected_edit').style.display = 'none';

          document.getElementById('duplicate_readonly').style.display = '';
          document.getElementById('duplicate_edit').style.display = 'none';

		  document.getElementById('confirmed_readonly').style.display = '';
          document.getElementById('confirmed_edit').style.display = 'none';

          document.getElementById('investigation_readonly').style.display = '';
          document.getElementById('investigation_edit').style.display = 'none';

		  document.getElementById('development_readonly').style.display = '';
          document.getElementById('development_edit').style.display = 'none';

		  document.getElementById('workinprogress_readonly').style.display = '';
          document.getElementById('workinprogress_edit').style.display = 'none';

		  document.getElementById('codereview_readonly').style.display = '';
          document.getElementById('codereview_edit').style.display = 'none';

          document.getElementById('readytobuild_readonly').style.display = '';
          document.getElementById('readytobuild_edit').style.display = 'none';

          document.getElementById('qa_readonly').style.display = '';
          document.getElementById('qa_edit').style.display = 'none';

          document.getElementById('performancetesting_readonly').style.display = 'none';
          document.getElementById('performancetesting_edit').style.display = '';

          document.getElementById('verified_readonly').style.display = '';
          document.getElementById('verified_edit').style.display = 'none';


          document.getElementById('closed_readonly').style.display = '';
          document.getElementById('closed_edit').style.display = 'none';


        }
        function performancetesting_Save(){
            var status="performancetesting";
            if(validate(status)){
                var statusid    =   document.getElementById('performancetestingid').value;
                document.getElementById('performancetesting_edit').style.display='none';

                var req = 'updateValue.jsp?stat='+statusid+'&performancetestingp1s1=' + document.getElementById('performancetestingp1s1').value+'&performancetestingp1s2='+document.getElementById('performancetestingp1s2').value+'&performancetestingp1s3='+document.getElementById('performancetestingp1s3').value+'&performancetestingp1s4='+document.getElementById('performancetestingp1s4').value+'&performancetestingp2s1='+document.getElementById('performancetestingp2s1').value+'&performancetestingp2s2='+document.getElementById('performancetestingp2s2').value+'&performancetestingp2s3='+document.getElementById('performancetestingp2s3').value+'&performancetestingp2s4='+document.getElementById('performancetestingp2s4').value+"&rand="+'&performancetestingp3s1='+document.getElementById('performancetestingp3s1').value+'&performancetestingp3s2='+document.getElementById('performancetestingp3s2').value+'&performancetestingp3s3='+document.getElementById('performancetestingp3s3').value+'&performancetestingp3s4='+document.getElementById('performancetestingp3s4').value+'&performancetestingp4s1='+document.getElementById('performancetestingp4s1').value+'&performancetestingp4s2='+document.getElementById('performancetestingp4s2').value+'&performancetestingp4s3='+document.getElementById('performancetestingp4s3').value+'&performancetestingp4s4='+document.getElementById('performancetestingp4s4').value+"&rand="+Math.random(1,10);
                sndPerformancetestingReq(req);
            }

        }
        function performancetesting_Cancel(){
            document.getElementById('performancetesting_readonly').style.display = '';
            document.getElementById('performancetesting_edit').style.display = 'none';

        }
    function sndVerifiedReq(action) {

                http.open('get', action);
                http.onreadystatechange = setVerified;
                http.send(null);
            }
    function setVerified(){
                if(http.readyState==4){

                   if(http.status==200){
                       var res=http.responseText;
                   if(res==1){
                    document.getElementById('verifiedp1s1_readonly').innerHTML = document.getElementById('verifiedp1s1').value;
                    document.getElementById('verifiedp1s2_readonly').innerHTML = document.getElementById('verifiedp1s2').value;;
                    document.getElementById('verifiedp1s3_readonly').innerHTML = document.getElementById('verifiedp1s3').value;
                    document.getElementById('verifiedp1s4_readonly').innerHTML = document.getElementById('verifiedp1s4').value;

                    document.getElementById('verifiedp2s1_readonly').innerHTML = document.getElementById('verifiedp2s1').value;
                    document.getElementById('verifiedp2s2_readonly').innerHTML = document.getElementById('verifiedp2s2').value;
                    document.getElementById('verifiedp2s3_readonly').innerHTML = document.getElementById('verifiedp2s3').value;
                    document.getElementById('verifiedp2s4_readonly').innerHTML = document.getElementById('verifiedp2s4').value;

                    document.getElementById('verifiedp3s1_readonly').innerHTML = document.getElementById('verifiedp3s1').value;
                    document.getElementById('verifiedp3s2_readonly').innerHTML = document.getElementById('verifiedp3s2').value;
                    document.getElementById('verifiedp3s3_readonly').innerHTML = document.getElementById('verifiedp3s3').value;
                    document.getElementById('verifiedp3s4_readonly').innerHTML = document.getElementById('verifiedp3s4').value;

                    document.getElementById('verifiedp4s1_readonly').innerHTML = document.getElementById('verifiedp4s1').value;
                    document.getElementById('verifiedp4s2_readonly').innerHTML = document.getElementById('verifiedp4s2').value;
                    document.getElementById('verifiedp4s3_readonly').innerHTML = document.getElementById('verifiedp4s3').value;
                    document.getElementById('verifiedp4s4_readonly').innerHTML = document.getElementById('verifiedp4s4').value;

                    document.getElementById('verified_readonly').style.display = '';
                    document.getElementById('verified_edit').style.display = 'none';
                   }else{
                       document.getElementById('verified_edit').style.display = '';
                       document.getElementById('verified_readonly').style.display = 'none';
                       alert('Error Occurred, Please Contact Administrator');


                   }

                  }
                }
            }

 function verified_Edit(){

          document.getElementById('verified_readonly').style.display = 'none';
          document.getElementById('verified_edit').style.display = '';

          document.getElementById('unconfirmed_readonly').style.display = '';
          document.getElementById('unconfirmed_edit').style.display = 'none';

          document.getElementById('rejected_readonly').style.display = '';
          document.getElementById('rejected_edit').style.display = 'none';

          document.getElementById('duplicate_readonly').style.display = '';
          document.getElementById('duplicate_edit').style.display = 'none';

		  document.getElementById('confirmed_readonly').style.display = '';
          document.getElementById('confirmed_edit').style.display = 'none';

          document.getElementById('investigation_readonly').style.display = '';
          document.getElementById('investigation_edit').style.display = 'none';

		  document.getElementById('development_readonly').style.display = '';
          document.getElementById('development_edit').style.display = 'none';

		  document.getElementById('workinprogress_readonly').style.display = '';
          document.getElementById('workinprogress_edit').style.display = 'none';

		  document.getElementById('codereview_readonly').style.display = '';
          document.getElementById('codereview_edit').style.display = 'none';

		  document.getElementById('readytobuild_readonly').style.display = '';
          document.getElementById('readytobuild_edit').style.display = 'none';


          document.getElementById('qa_readonly').style.display = '';
          document.getElementById('qa_edit').style.display = 'none';

          document.getElementById('performancetesting_readonly').style.display = '';
          document.getElementById('performancetesting_edit').style.display = 'none';

          document.getElementById('closed_readonly').style.display = '';
          document.getElementById('closed_edit').style.display = 'none';



        }
        function verified_Save(){
            var status="verified";
            if(validate(status)){
                var statusid    =   document.getElementById('verifiedid').value;
                document.getElementById('verified_edit').style.display='none';

                var req = 'updateValue.jsp?stat='+statusid+'&verifiedp1s1=' + document.getElementById('verifiedp1s1').value+'&verifiedp1s2='+document.getElementById('verifiedp1s2').value+'&verifiedp1s3='+document.getElementById('verifiedp1s3').value+'&verifiedp1s4='+document.getElementById('verifiedp1s4').value+'&verifiedp2s1='+document.getElementById('verifiedp2s1').value+'&verifiedp2s2='+document.getElementById('verifiedp2s2').value+'&verifiedp2s3='+document.getElementById('verifiedp2s3').value+'&verifiedp2s4='+document.getElementById('verifiedp2s4').value+"&rand="+'&verifiedp3s1='+document.getElementById('verifiedp3s1').value+'&verifiedp3s2='+document.getElementById('verifiedp3s2').value+'&verifiedp3s3='+document.getElementById('verifiedp3s3').value+'&verifiedp3s4='+document.getElementById('verifiedp3s4').value+'&verifiedp4s1='+document.getElementById('verifiedp4s1').value+'&verifiedp4s2='+document.getElementById('verifiedp4s2').value+'&verifiedp4s3='+document.getElementById('verifiedp4s3').value+'&verifiedp4s4='+document.getElementById('verifiedp4s4').value+"&rand="+Math.random(1,10);
                sndVerifiedReq(req);
            }

        }
        function verified_Cancel(){
            document.getElementById('verified_readonly').style.display = '';
            document.getElementById('verified_edit').style.display = 'none';

        }
function sndClosedReq(action) {

                http.open('get', action);
                http.onreadystatechange = setClosed;
                http.send(null);
            }
    function setClosed(){
                if(http.readyState==4){

                   if(http.status==200){
                       var res=http.responseText;
                   if(res==1){
                    document.getElementById('closedp1s1_readonly').innerHTML = document.getElementById('closedp1s1').value;
                    document.getElementById('closedp1s2_readonly').innerHTML = document.getElementById('closedp1s2').value;;
                    document.getElementById('closedp1s3_readonly').innerHTML = document.getElementById('closedp1s3').value;
                    document.getElementById('closedp1s4_readonly').innerHTML = document.getElementById('closedp1s4').value;

                    document.getElementById('closedp2s1_readonly').innerHTML = document.getElementById('closedp2s1').value;
                    document.getElementById('closedp2s2_readonly').innerHTML = document.getElementById('closedp2s2').value;
                    document.getElementById('closedp2s3_readonly').innerHTML = document.getElementById('closedp2s3').value;
                    document.getElementById('closedp2s4_readonly').innerHTML = document.getElementById('closedp2s4').value;

                    document.getElementById('closedp3s1_readonly').innerHTML = document.getElementById('closedp3s1').value;
                    document.getElementById('closedp3s2_readonly').innerHTML = document.getElementById('closedp3s2').value;
                    document.getElementById('closedp3s3_readonly').innerHTML = document.getElementById('closedp3s3').value;
                    document.getElementById('closedp3s4_readonly').innerHTML = document.getElementById('closedp3s4').value;

                    document.getElementById('closedp4s1_readonly').innerHTML = document.getElementById('closedp4s1').value;
                    document.getElementById('closedp4s2_readonly').innerHTML = document.getElementById('closedp4s2').value;
                    document.getElementById('closedp4s3_readonly').innerHTML = document.getElementById('closedp4s3').value;
                    document.getElementById('closedp4s4_readonly').innerHTML = document.getElementById('closedp4s4').value;

                    document.getElementById('closed_readonly').style.display = '';
                    document.getElementById('closed_edit').style.display = 'none';
                   }else{
                       document.getElementById('closed_edit').style.display = '';
                       document.getElementById('closed_readonly').style.display = 'none';
                       alert('Error Occurred, Please Contact Administrator');


                   }

                  }
                }
            }

 function closed_Edit(){

          document.getElementById('closed_readonly').style.display = 'none';
          document.getElementById('closed_edit').style.display = '';

          document.getElementById('unconfirmed_readonly').style.display = '';
          document.getElementById('unconfirmed_edit').style.display = 'none';

          document.getElementById('rejected_readonly').style.display = '';
          document.getElementById('rejected_edit').style.display = 'none';

          document.getElementById('duplicate_readonly').style.display = '';
          document.getElementById('duplicate_edit').style.display = 'none';

		  document.getElementById('confirmed_readonly').style.display = '';
          document.getElementById('confirmed_edit').style.display = 'none';

          document.getElementById('investigation_readonly').style.display = '';
          document.getElementById('investigation_edit').style.display = 'none';

		  document.getElementById('development_readonly').style.display = '';
          document.getElementById('development_edit').style.display = 'none';

		  document.getElementById('workinprogress_readonly').style.display = '';
          document.getElementById('workinprogress_edit').style.display = 'none';

		  document.getElementById('codereview_readonly').style.display = '';
          document.getElementById('codereview_edit').style.display = 'none';

		  document.getElementById('readytobuild_readonly').style.display = '';
          document.getElementById('readytobuild_edit').style.display = 'none';

          document.getElementById('qa_readonly').style.display = '';
          document.getElementById('qa_edit').style.display = 'none';

          document.getElementById('performancetesting_readonly').style.display = '';
          document.getElementById('performancetesting_edit').style.display = 'none';

          document.getElementById('verified_readonly').style.display = '';
          document.getElementById('verified_edit').style.display = 'none';


        }
        function closed_Save(){
            var status="closed";
            if(validate(status)){
                var statusid    =   document.getElementById('closedid').value;
                document.getElementById('closed_edit').style.display='none';

                var req = 'updateValue.jsp?stat='+statusid+'&closedp1s1=' + document.getElementById('closedp1s1').value+'&closedp1s2='+document.getElementById('closedp1s2').value+'&closedp1s3='+document.getElementById('closedp1s3').value+'&closedp1s4='+document.getElementById('closedp1s4').value+'&closedp2s1='+document.getElementById('closedp2s1').value+'&closedp2s2='+document.getElementById('closedp2s2').value+'&closedp2s3='+document.getElementById('closedp2s3').value+'&closedp2s4='+document.getElementById('closedp2s4').value+"&rand="+'&closedp3s1='+document.getElementById('closedp3s1').value+'&closedp3s2='+document.getElementById('closedp3s2').value+'&closedp3s3='+document.getElementById('closedp3s3').value+'&closedp3s4='+document.getElementById('closedp3s4').value+'&closedp4s1='+document.getElementById('closedp4s1').value+'&closedp4s2='+document.getElementById('closedp4s2').value+'&closedp4s3='+document.getElementById('closedp4s3').value+'&closedp4s4='+document.getElementById('closedp4s4').value+"&rand="+Math.random(1,10);
                sndClosedReq(req);
            }

        }
        function closed_Cancel(){
            document.getElementById('closed_readonly').style.display = '';
            document.getElementById('closed_edit').style.display = 'none';

        }


        </script>
    </head>
    <body>
        <%


        HashMap statuses =   new HashMap<String,String>();

        statuses=GetValues.getStatus();


        al  =   GetValues.getValue(pageToDisplay);

        int noofrows    =   al.size()/17;



        int p1s1total   =   0;
        int p1s2total   =   0;
        int p1s3total   =   0;
        int p1s4total   =   0;

        int p2s1total   =   0;
        int p2s2total   =   0;
        int p2s3total   =   0;
        int p2s4total   =   0;

        int p3s1total   =   0;
        int p3s2total   =   0;
        int p3s3total   =   0;
        int p3s4total   =   0;

        int p4s1total   =   0;
        int p4s2total   =   0;
        int p4s3total   =   0;
        int p4s4total   =   0;


        int rowno       =   0;

        logger.info("No of Rows"+noofrows);

        int p1s1=100;
        int p1s2=200;
              int p1s3=300;
        int p1s4=400;

        int p2s1=100;
        int p2s2=200;
        int p2s3=300;
        int p2s4=400;

        int p3s1=100;
        int p3s2=200;
        int p3s3=300;
        int p3s4=400;

        int p4s1=100;
        int p4s2=200;
        int p4s3=300;
        int p4s4=400;

%>

       <table width="100%">
       <tr border="0">
		<td bgcolor="#C3D9FF" border="0" align="left" width="100%" colspan="6"><font size="4" COLOR="#0000FF"><b><%=header%></b> </font></td>
	   </tr>
       <tr>
                 
                     <%
                     if(bug>0 && !pageToDisplay.equals("bug")){
                      %>
                      <td  align="left">
                       <a href="<%=request.getContextPath() %>/admin/user/viewValues.jsp?viewpage=bug">View Bug Value</a>&nbsp;&nbsp;&nbsp;&nbsp;

                     </td>
                      <%
                        }
                     %>
                
                
                      <%
                        if(enhancement>0 && !pageToDisplay.equals("enhancement")){
                        %>
                         <td  align="left">
                         <a href="<%=request.getContextPath() %>/admin/user/viewValues.jsp?viewpage=enhancement">View Enhancement Value</a>&nbsp;&nbsp;&nbsp;&nbsp;
                           </td>
                      <%
                        }
                     %>
               
                 
                      <%
                        if(newtask>0 && !pageToDisplay.equals("newtask")){
                       %>
                       <td  align="left">
                       <a href="<%=request.getContextPath() %>/admin/user/viewValues.jsp?viewpage=newtask">View New Task Value</a>&nbsp;&nbsp;&nbsp;&nbsp;
                       </td>
                <%
                        }
                     %>
                
             </tr>

       </table>

       <table align="center" border="0" cellpadding="2">
           <tr><td><b>Status</b></td><td><B>P1S1</B></td><td><B>P1S2</B></td><td><B>P1S3</B></td><td><B>P1S4</B></td><td><B>P2S1</B></td><td><B>P2S2</B></td><td><B>P2S3</B></td><td><B>P2S4</B></td><td><B>P3S1</B></td><td><B>P3S2</B></td><td><B>P3S3</B></td><td><B>P3S4</B></td><td><B>P4S1</B></td><td><B>P4S2</B></td><td><B>P4S3</B></td><td><B>P4S4</B><input type="hidden" name="tablename" value="<%=tablename%>"/></td></tr>
           <tr id="unconfirmed_readonly">
               <td><B><%=statuses.get(1)%></B></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="uncon_Edit();"> <div id="unconfirmedp1s1_readonly"><%=al.get(1)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="uncon_Edit();"> <div id="unconfirmedp1s2_readonly"><%=al.get(2)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="uncon_Edit();"> <div id="unconfirmedp1s3_readonly"><%=al.get(3)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="uncon_Edit();"> <div id="unconfirmedp1s4_readonly"><%=al.get(4)%></div></td>

               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="uncon_Edit();"> <div id="unconfirmedp2s1_readonly"><%=al.get(4)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="uncon_Edit();"> <div id="unconfirmedp2s2_readonly"><%=al.get(6)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="uncon_Edit();"> <div id="unconfirmedp2s3_readonly"><%=al.get(7)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="uncon_Edit();"> <div id="unconfirmedp2s4_readonly"><%=al.get(8)%></div></td>

               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="uncon_Edit();"> <div id="unconfirmedp3s1_readonly"><%=al.get(9)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="uncon_Edit();"> <div id="unconfirmedp3s2_readonly"><%=al.get(10)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="uncon_Edit();"> <div id="unconfirmedp3s3_readonly"><%=al.get(11)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="uncon_Edit();"> <div id="unconfirmedp3s4_readonly"><%=al.get(12)%></div></td>

               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="uncon_Edit();"> <div id="unconfirmedp4s1_readonly"><%=al.get(13)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="uncon_Edit();"> <div id="unconfirmedp4s2_readonly"><%=al.get(14)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="uncon_Edit();"> <div id="unconfirmedp4s3_readonly"><%=al.get(15)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="uncon_Edit();"> <div id="unconfirmedp4s4_readonly"><%=al.get(16)%></div></td>

           </tr>

           <tr id="unconfirmed_edit">
                 <td><B><%=statuses.get(1)%></B></td>
               <td>
                   <div id="unconfirmedp1s1_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(1)%>" id="unconfirmedp1s1" />
                   </div>
                   <span id="unconfirmedp1s1_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('unconfirmed_edit').style.display = 'none';
                        document.getElementById('unconfirmedp1s1_save').style.display = 'none';
                    </script>
               </td>
               <td>
                   <div id="unconfirmedp1s2_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(2)%>" id="unconfirmedp1s2" />
                       </div>
                   <span id="unconfirmedp1s2_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('unconfirmed_edit').style.display = 'none';
                        document.getElementById('unconfirmedp1s2_save').style.display = 'none';
                    </script>
               </td>
               <td>
                   <div id="unconfirmedp1s3_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(3)%>" id="unconfirmedp1s3" />
                       </div>
                   <span id="unconfirmedp1s3_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('unconfirmed_edit').style.display = 'none';
                        document.getElementById('unconfirmedp1s3_save').style.display = 'none';
                    </script>
               </td>
               <td>
                   <div id="unconfirmedp1s4_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(4)%>" id="unconfirmedp1s4" />
                       </div>
                   <span id="unconfirmedp1s4_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('unconfirmed_edit').style.display = 'none';
                        document.getElementById('unconfirmedp1s4_save').style.display = 'none';
                    </script>
               </td>


               <td>
                   <div id="unconfirmedp2s1_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(5)%>" id="unconfirmedp2s1" />
                   </div>
                   <span id="unconfirmedp2s1_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('unconfirmed_edit').style.display = 'none';
                        document.getElementById('unconfirmedp2s1_save').style.display = 'none';
                    </script>
               </td>
               <td>
                   <div id="unconfirmedp2s2_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(6)%>" id="unconfirmedp2s2" />
                       </div>
                   <span id="unconfirmedp2s2_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('unconfirmed_edit').style.display = 'none';
                        document.getElementById('unconfirmedp2s2_save').style.display = 'none';
                    </script>
               </td>
               <td>
                   <div id="unconfirmedp2s3_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(7)%>" id="unconfirmedp2s3" />
                       </div>
                   <span id="unconfirmedp2s3_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('unconfirmed_edit').style.display = 'none';
                        document.getElementById('unconfirmedp2s3_save').style.display = 'none';
                    </script>
               </td>
               <td>
                   <div id="unconfirmedp2s4_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(8)%>" id="unconfirmedp2s4" />
                       </div>
                   <span id="unconfirmedp2s4_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('unconfirmed_edit').style.display = 'none';
                        document.getElementById('unconfirmedp2s4_save').style.display = 'none';
                    </script>
               </td>

               <td>
                   <div id="unconfirmedp3s1_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(9)%>" id="unconfirmedp3s1" />
                   </div>
                   <span id="unconfirmedp3s1_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('unconfirmed_edit').style.display = 'none';
                        document.getElementById('unconfirmedp3s1_save').style.display = 'none';
                    </script>
               </td>
               <td>
                   <div id="unconfirmedp3s2_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(10)%>" id="unconfirmedp3s2" />
                       </div>
                   <span id="unconfirmedp3s2_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('unconfirmed_edit').style.display = 'none';
                        document.getElementById('unconfirmedp3s2_save').style.display = 'none';
                    </script>
               </td>
               <td>
                   <div id="unconfirmedp3s3_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(11)%>" id="unconfirmedp3s3" />
                       </div>
                   <span id="unconfirmedp3s3_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('unconfirmed_edit').style.display = 'none';
                        document.getElementById('unconfirmedp3s3_save').style.display = 'none';
                    </script>
               </td>
               <td>
                   <div id="unconfirmedp3s4_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(12)%>" id="unconfirmedp3s4" />
                       </div>
                   <span id="unconfirmedp3s4_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('unconfirmed_edit').style.display = 'none';
                        document.getElementById('unconfirmedp3s4_save').style.display = 'none';
                    </script>
               </td>

                <td>
                   <div id="unconfirmedp4s1_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(13)%>" id="unconfirmedp4s1" />
                   </div>
                   <span id="unconfirmedp4s1_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('unconfirmed_edit').style.display = 'none';
                        document.getElementById('unconfirmedp4s1_save').style.display = 'none';
                    </script>
               </td>
               <td>
                   <div id="unconfirmedp4s2_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(14)%>" id="unconfirmedp4s2" />
                       </div>
                   <span id="unconfirmedp4s2_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('unconfirmed_edit').style.display = 'none';
                        document.getElementById('unconfirmedp4s2_save').style.display = 'none';
                    </script>
               </td>
               <td>
                   <div id="unconfirmedp4s3_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(15)%>" id="unconfirmedp4s3" />
                       </div>
                   <span id="unconfirmedp4s3_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('unconfirmed_edit').style.display = 'none';
                        document.getElementById('unconfirmedp4s3_save').style.display = 'none';
                    </script>
               </td>
               <td>
                   <div id="unconfirmedp4s4_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(16)%>" id="unconfirmedp4s4" />
                       </div>
                   <span id="unconfirmedp4s4_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('unconfirmed_edit').style.display = 'none';
                        document.getElementById('unconfirmedp4s4_save').style.display = 'none';
                    </script>
               </td>

               <td>
                   <input type="button" value="Save" onClick="uncon_Save()" /> <input type="button" value="Cancel" onClick="uncon_Cancel();"/>
                   <input type="hidden" name="unconfirmedid" value="1"/>
               </td>
           </tr>
           <tr id="rejected_readonly">
               <td><B><%=statuses.get(2)%></B></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="rejected_Edit();"> <div id="rejectedp1s1_readonly"><%=al.get(18)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="rejected_Edit();"> <div id="rejectedp1s2_readonly"><%=al.get(19)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="rejected_Edit();"> <div id="rejectedp1s3_readonly"><%=al.get(20)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="rejected_Edit();"> <div id="rejectedp1s4_readonly"><%=al.get(21)%></div></td>

               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="rejected_Edit();"> <div id="rejectedp2s1_readonly"><%=al.get(22)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="rejected_Edit();"> <div id="rejectedp2s2_readonly"><%=al.get(23)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="rejected_Edit();"> <div id="rejectedp2s3_readonly"><%=al.get(24)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="rejected_Edit();"> <div id="rejectedp2s4_readonly"><%=al.get(25)%></div></td>

               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="rejected_Edit();"> <div id="rejectedp3s1_readonly"><%=al.get(26)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="rejected_Edit();"> <div id="rejectedp3s2_readonly"><%=al.get(27)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="rejected_Edit();"> <div id="rejectedp3s3_readonly"><%=al.get(28)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="rejected_Edit();"> <div id="rejectedp3s4_readonly"><%=al.get(29)%></div></td>

               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="rejected_Edit();"> <div id="rejectedp4s1_readonly"><%=al.get(30)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="rejected_Edit();"> <div id="rejectedp4s2_readonly"><%=al.get(31)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="rejected_Edit();"> <div id="rejectedp4s3_readonly"><%=al.get(32)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="rejected_Edit();"> <div id="rejectedp4s4_readonly"><%=al.get(33)%></div></td>

           </tr>

           <tr id="rejected_edit">
                 <td><B><%=statuses.get(2)%></B></td>
               <td>
                   <div id="rejectedp1s1_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(18)%>" id="rejectedp1s1" />
                   </div>
                   <span id="rejectedp1s1_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('rejected_edit').style.display = 'none';
                        document.getElementById('rejectedp1s1_save').style.display = 'none';
                    </script>
               </td>
               <td>
                   <div id="rejectedp1s2_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(19)%>" id="rejectedp1s2" />
                       </div>
                   <span id="rejectedp1s2_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('rejected_edit').style.display = 'none';
                        document.getElementById('rejectedp1s2_save').style.display = 'none';
                    </script>
               </td>
               <td>
                   <div id="rejectedp1s3_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(20)%>" id="rejectedp1s3" />
                       </div>
                   <span id="rejectedp1s3_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('rejected_edit').style.display = 'none';
                        document.getElementById('rejectedp1s3_save').style.display = 'none';
                    </script>
               </td>
               <td>
                   <div id="rejectedp1s4_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(21)%>" id="rejectedp1s4" />
                       </div>
                   <span id="rejectedp1s4_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('rejected_edit').style.display = 'none';
                        document.getElementById('rejectedp1s4_save').style.display = 'none';
                    </script>
               </td>


               <td>
                   <div id="rejectedp2s1_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(22)%>" id="rejectedp2s1" />
                   </div>
                   <span id="rejectedp2s1_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('rejected_edit').style.display = 'none';
                        document.getElementById('rejectedp2s1_save').style.display = 'none';
                    </script>
               </td>
               <td>
                   <div id="rejectedp2s2_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(23)%>" id="rejectedp2s2" />
                       </div>
                   <span id="rejectedp2s2_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('rejected_edit').style.display = 'none';
                        document.getElementById('rejectedp2s2_save').style.display = 'none';
                    </script>
               </td>
               <td>
                   <div id="rejectedp2s3_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(24)%>" id="rejectedp2s3" />
                       </div>
                   <span id="rejectedp2s3_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('rejected_edit').style.display = 'none';
                        document.getElementById('rejectedp2s3_save').style.display = 'none';
                    </script>
               </td>
               <td>
                   <div id="rejectedp2s4_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(25)%>" id="rejectedp2s4" />
                       </div>
                   <span id="rejectedp2s4_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('rejected_edit').style.display = 'none';
                        document.getElementById('rejectedp2s4_save').style.display = 'none';
                    </script>
               </td>

               <td>
                   <div id="rejectedp3s1_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(26)%>" id="rejectedp3s1" />
                   </div>
                   <span id="rejectedp3s1_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('rejected_edit').style.display = 'none';
                        document.getElementById('rejectedp3s1_save').style.display = 'none';
                    </script>
               </td>
               <td>
                   <div id="rejectedp3s2_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(27)%>" id="rejectedp3s2" />
                       </div>
                   <span id="rejectedp3s2_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('rejected_edit').style.display = 'none';
                        document.getElementById('rejectedp3s2_save').style.display = 'none';
                    </script>
               </td>
               <td>
                   <div id="rejectedp3s3_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(28)%>" id="rejectedp3s3" />
                       </div>
                   <span id="rejectedp3s3_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('rejected_edit').style.display = 'none';
                        document.getElementById('rejectedp3s3_save').style.display = 'none';
                    </script>
               </td>
               <td>
                   <div id="rejectedp3s4_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(29)%>" id="rejectedp3s4" />
                       </div>
                   <span id="rejectedp3s4_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('rejected_edit').style.display = 'none';
                        document.getElementById('rejectedp3s4_save').style.display = 'none';
                    </script>
               </td>

                <td>
                   <div id="rejectedp4s1_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(30)%>" id="rejectedp4s1" />
                   </div>
                   <span id="rejectedp4s1_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('rejected_edit').style.display = 'none';
                        document.getElementById('rejectedp4s1_save').style.display = 'none';
                    </script>
               </td>
               <td>
                   <div id="rejectedp4s2_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(31)%>" id="rejectedp4s2" />
                       </div>
                   <span id="rejectedp4s2_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('rejected_edit').style.display = 'none';
                        document.getElementById('rejectedp4s2_save').style.display = 'none';
                    </script>
               </td>
               <td>
                   <div id="rejectedp4s3_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(32)%>" id="rejectedp4s3" />
                       </div>
                   <span id="rejectedp4s3_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('rejected_edit').style.display = 'none';
                        document.getElementById('rejectedp4s3_save').style.display = 'none';
                    </script>
               </td>
               <td>
                   <div id="rejectedp4s4_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(33)%>" id="rejectedp4s4" />
                       </div>
                   <span id="rejectedp4s4_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('rejected_edit').style.display = 'none';
                        document.getElementById('rejectedp4s4_save').style.display = 'none';
                    </script>
               </td>

               <td>
                   <input type="button" value="Save" onClick="rejected_Save()" /> <input type="button" value="Cancel" onClick="rejected_Cancel();"/>
                   <input type="hidden" name="rejectedid" value="2"/>
               </td>
           </tr>
              <tr id="duplicate_readonly">
               <td><B><%=statuses.get(3)%></B></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="duplicate_Edit();"> <div id="duplicatep1s1_readonly"><%=al.get(35)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="duplicate_Edit();"> <div id="duplicatep1s2_readonly"><%=al.get(36)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="duplicate_Edit();"> <div id="duplicatep1s3_readonly"><%=al.get(37)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="duplicate_Edit();"> <div id="duplicatep1s4_readonly"><%=al.get(38)%></div></td>

               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="duplicate_Edit();"> <div id="duplicatep2s1_readonly"><%=al.get(39)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="duplicate_Edit();"> <div id="duplicatep2s2_readonly"><%=al.get(40)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="duplicate_Edit();"> <div id="duplicatep2s3_readonly"><%=al.get(41)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="duplicate_Edit();"> <div id="duplicatep2s4_readonly"><%=al.get(42)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="duplicate_Edit();"> <div id="duplicatep3s1_readonly"><%=al.get(43)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="duplicate_Edit();"> <div id="duplicatep3s2_readonly"><%=al.get(44)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="duplicate_Edit();"> <div id="duplicatep3s3_readonly"><%=al.get(45)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="duplicate_Edit();"> <div id="duplicatep3s4_readonly"><%=al.get(46)%></div></td>

               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="duplicate_Edit();"> <div id="duplicatep4s1_readonly"><%=al.get(47)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="duplicate_Edit();"> <div id="duplicatep4s2_readonly"><%=al.get(48)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="duplicate_Edit();"> <div id="duplicatep4s3_readonly"><%=al.get(49)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="duplicate_Edit();"> <div id="duplicatep4s4_readonly"><%=al.get(50)%></div></td>

           </tr>

           <tr id="duplicate_edit">
                 <td><B><%=statuses.get(3)%></B></td>
               <td>
                   <div id="duplicatep1s1_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(35)%>" id="duplicatep1s1" />
                   </div>
                   <span id="duplicatep1s1_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('duplicate_edit').style.display = 'none';
                        document.getElementById('duplicatep1s1_save').style.display = 'none';
                    </script>
               </td>
               <td>
                   <div id="duplicatep1s2_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(36)%>" id="duplicatep1s2" />
                       </div>
                   <span id="duplicatep1s2_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('duplicate_edit').style.display = 'none';
                        document.getElementById('duplicatep1s2_save').style.display = 'none';
                    </script>
               </td>
               <td>
                   <div id="duplicatep1s3_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(37)%>" id="duplicatep1s3" />
                       </div>
                   <span id="duplicatep1s3_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('duplicate_edit').style.display = 'none';
                        document.getElementById('duplicatep1s3_save').style.display = 'none';
                    </script>
               </td>
               <td>
                   <div id="duplicatep1s4_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(38)%>" id="duplicatep1s4" />
                       </div>
                   <span id="duplicatep1s4_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('duplicate_edit').style.display = 'none';
                        document.getElementById('duplicatep1s4_save').style.display = 'none';
                    </script>
               </td>


               <td>
                   <div id="duplicatep2s1_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(39)%>" id="duplicatep2s1" />
                   </div>
                   <span id="duplicatep2s1_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('duplicate_edit').style.display = 'none';
                        document.getElementById('duplicatep2s1_save').style.display = 'none';
                    </script>
               </td>
               <td>
                   <div id="duplicatep2s2_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(40)%>" id="duplicatep2s2" />
                       </div>
                   <span id="duplicatep2s2_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('duplicate_edit').style.display = 'none';
                        document.getElementById('duplicatep2s2_save').style.display = 'none';
                    </script>
               </td>
               <td>
                   <div id="duplicatep2s3_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(41)%>" id="duplicatep2s3" />
                       </div>
                   <span id="duplicatep2s3_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('duplicate_edit').style.display = 'none';
                        document.getElementById('duplicatep2s3_save').style.display = 'none';
                    </script>
               </td>
               <td>
                   <div id="duplicatep2s4_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(42)%>" id="duplicatep2s4" />
                       </div>
                   <span id="duplicatep2s4_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('duplicate_edit').style.display = 'none';
                        document.getElementById('duplicatep2s4_save').style.display = 'none';
                    </script>
               </td>

               <td>
                   <div id="duplicatep3s1_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(43)%>" id="duplicatep3s1" />
                   </div>
                   <span id="duplicatep3s1_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('duplicate_edit').style.display = 'none';
                        document.getElementById('duplicatep3s1_save').style.display = 'none';
                    </script>
               </td>
               <td>
                   <div id="duplicatep3s2_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(44)%>" id="duplicatep3s2" />
                       </div>
                   <span id="duplicatep3s2_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('duplicate_edit').style.display = 'none';
                        document.getElementById('duplicatep3s2_save').style.display = 'none';
                    </script>
               </td>
               <td>
                   <div id="duplicatep3s3_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(45)%>" id="duplicatep3s3" />
                       </div>
                   <span id="duplicatep3s3_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('duplicate_edit').style.display = 'none';
                        document.getElementById('duplicatep3s3_save').style.display = 'none';
                    </script>
               </td>
               <td>
                   <div id="duplicatep3s4_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(46)%>" id="duplicatep3s4" />
                       </div>
                   <span id="duplicatep3s4_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('duplicate_edit').style.display = 'none';
                        document.getElementById('duplicatep3s4_save').style.display = 'none';
                    </script>
               </td>

                <td>
                   <div id="duplicatep4s1_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(47)%>" id="duplicatep4s1" />
                   </div>
                   <span id="duplicatep4s1_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('duplicate_edit').style.display = 'none';
                        document.getElementById('duplicatep4s1_save').style.display = 'none';
                    </script>
               </td>
               <td>
                   <div id="duplicatep4s2_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(48)%>" id="duplicatep4s2" />
                       </div>
                   <span id="duplicatep4s2_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('duplicate_edit').style.display = 'none';
                        document.getElementById('duplicatep4s2_save').style.display = 'none';
                    </script>
               </td>
               <td>
                   <div id="duplicatep4s3_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(49)%>" id="duplicatep4s3" />
                       </div>
                   <span id="duplicatep4s3_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('duplicate_edit').style.display = 'none';
                        document.getElementById('duplicatep4s3_save').style.display = 'none';
                    </script>
               </td>
               <td>
                   <div id="duplicatep4s4_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(50)%>" id="duplicatep4s4" />
                       </div>
                   <span id="duplicatep4s4_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('duplicate_edit').style.display = 'none';
                        document.getElementById('duplicatep4s4_save').style.display = 'none';
                    </script>
               </td>

               <td>
                   <input type="button" value="Save" onClick="duplicate_Save()" /> <input type="button" value="Cancel" onClick="duplicate_Cancel();"/>
                   <input type="hidden" name="duplicateid" value="3"/>
               </td>
           </tr>
                       <tr id="investigation_readonly">
               <td><B><%=statuses.get(4)%></B></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="in_Edit();"> <div id="investigationp1s1_readonly"><%=al.get(52)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="in_Edit();"> <div id="investigationp1s2_readonly"><%=al.get(53)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="in_Edit();"> <div id="investigationp1s3_readonly"><%=al.get(54)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="in_Edit();"> <div id="investigationp1s4_readonly"><%=al.get(55)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="in_Edit();"> <div id="investigationp2s1_readonly"><%=al.get(56)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="in_Edit();"> <div id="investigationp2s2_readonly"><%=al.get(57)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="in_Edit();"> <div id="investigationp2s3_readonly"><%=al.get(58)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="in_Edit();"> <div id="investigationp2s4_readonly"><%=al.get(59)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="in_Edit();"> <div id="investigationp3s1_readonly"><%=al.get(60)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="in_Edit();"> <div id="investigationp3s2_readonly"><%=al.get(61)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="in_Edit();"> <div id="investigationp3s3_readonly"><%=al.get(62)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="in_Edit();"> <div id="investigationp3s4_readonly"><%=al.get(63)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="in_Edit();"> <div id="investigationp4s1_readonly"><%=al.get(64)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="in_Edit();"> <div id="investigationp4s2_readonly"><%=al.get(65)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="in_Edit();"> <div id="investigationp4s3_readonly"><%=al.get(66)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="in_Edit();"> <div id="investigationp4s4_readonly"><%=al.get(67)%></div></td>

           </tr>

           <tr id="investigation_edit">
                 <td><B><%=statuses.get(4)%></B></td>
               <td>
                   <div id="investigationp1s1_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(52)%>" id="investigationp1s1" />
                   </div>
                   <span id="investigationp1s1_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('investigation_edit').style.display = 'none';
                        document.getElementById('investigationp1s1_save').style.display = 'none';
                    </script>
               </td>
               <td>
                   <div id="investigationp1s2_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(53)%>" id="investigationp1s2" />
                       </div>
                   <span id="investigationp1s2_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('investigation_edit').style.display = 'none';
                        document.getElementById('investigationp1s2_save').style.display = 'none';
                    </script>
               </td>
               <td>
                   <div id="investigationp1s3_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(54)%>" id="investigationp1s3" />
                       </div>
                   <span id="investigationp1s3_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('investigation_edit').style.display = 'none';
                        document.getElementById('investigationp1s3_save').style.display = 'none';
                    </script>
               </td>
               <td>
                   <div id="investigationp1s4_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(55)%>" id="investigationp1s4" />
                       </div>
                   <span id="investigationp1s4_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('investigation_edit').style.display = 'none';
                        document.getElementById('investigationp1s4_save').style.display = 'none';
                    </script>
               </td>


               <td>
                   <div id="investigationp2s1_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(56)%>" id="investigationp2s1" />
                   </div>
                   <span id="investigationp2s1_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('investigation_edit').style.display = 'none';
                        document.getElementById('investigationp2s1_save').style.display = 'none';
                    </script>
               </td>
               <td>
                   <div id="investigationp2s2_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(57)%>" id="investigationp2s2" />
                       </div>
                   <span id="investigationp2s2_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('investigation_edit').style.display = 'none';
                        document.getElementById('investigationp2s2_save').style.display = 'none';
                    </script>
               </td>
               <td>
                   <div id="investogationp2s3_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(58)%>" id="investigationp2s3" />
                       </div>
                   <span id="investigationp2s3_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('investigation_edit').style.display = 'none';
                        document.getElementById('investigationp2s3_save').style.display = 'none';
                    </script>
               </td>
               <td>
                   <div id="investigationp2s4_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(59)%>" id="investigationp2s4" />
                       </div>
                   <span id="investigationp2s4_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('investigation_edit').style.display = 'none';
                        document.getElementById('investigationp2s4_save').style.display = 'none';
                    </script>
               </td>

               <td>
                   <div id="investigationp3s1_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(60)%>" id="investigationp3s1" />
                   </div>
                   <span id="investigationp3s1_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('investigation_edit').style.display = 'none';
                        document.getElementById('investigationp3s1_save').style.display = 'none';
                    </script>
               </td>
               <td>
                   <div id="investigationp3s2_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(61)%>" id="investigationp3s2" />
                       </div>
                   <span id="investigationp3s2_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('investigation_edit').style.display = 'none';
                        document.getElementById('investigationp3s2_save').style.display = 'none';
                    </script>
               </td>
               <td>
                   <div id="investigationp3s3_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(62)%>" id="investigationp3s3" />
                       </div>
                   <span id="investigationp3s3_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('investigation_edit').style.display = 'none';
                        document.getElementById('investigationp3s3_save').style.display = 'none';
                    </script>
               </td>
               <td>
                   <div id="investigationp3s4_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(63)%>" id="investigationp3s4" />
                       </div>
                   <span id="investigationp3s4_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('investigation_edit').style.display = 'none';
                        document.getElementById('investigationp3s4_save').style.display = 'none';
                    </script>
               </td>

                <td>
                   <div id="investigationp4s1_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(64)%>" id="investigationp4s1" />
                   </div>
                   <span id="investigationp4s1_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('investigation_edit').style.display = 'none';
                        document.getElementById('investigationp4s1_save').style.display = 'none';
                    </script>
               </td>
               <td>
                   <div id="investigationp4s2_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(65)%>" id="investigationp4s2" />
                       </div>
                   <span id="investigationp4s2_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('investigation_edit').style.display = 'none';
                        document.getElementById('investigationp4s2_save').style.display = 'none';
                    </script>
               </td>
               <td>
                   <div id="investigationp4s3_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(66)%>" id="investigationp4s3" />
                       </div>
                   <span id="investigationp4s3_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('investigation_edit').style.display = 'none';
                        document.getElementById('investigationp4s3_save').style.display = 'none';
                    </script>
               </td>
               <td>
                   <div id="investigationp4s4_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(67)%>" id="investigationp4s4" />
                       </div>
                   <span id="investigationp4s4_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('investigation_edit').style.display = 'none';
                        document.getElementById('investigationp4s4_save').style.display = 'none';
                    </script>
               </td>

               <td>
                   <input type="button" value="Save" onClick="in_Save()" /> <input type="button" value="Cancel" onClick="in_Cancel();"/>
                   <input type="hidden" name="investigationid" value="4"/>
               </td>
           </tr>
           <tr id="confirmed_readonly">
               <td><B><%=statuses.get(5)%></B></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="con_Edit();"> <div id="confirmedp1s1_readonly"><%=al.get(69)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="con_Edit();"> <div id="confirmedp1s2_readonly"><%=al.get(70)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="con_Edit();"> <div id="confirmedp1s3_readonly"><%=al.get(71)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="con_Edit();"> <div id="confirmedp1s4_readonly"><%=al.get(72)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="con_Edit();"> <div id="confirmedp2s1_readonly"><%=al.get(73)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="con_Edit();"> <div id="confirmedp2s2_readonly"><%=al.get(74)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="con_Edit();"> <div id="confirmedp2s3_readonly"><%=al.get(75)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="con_Edit();"> <div id="confirmedp2s4_readonly"><%=al.get(76)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="con_Edit();"> <div id="confirmedp3s1_readonly"><%=al.get(77)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="con_Edit();"> <div id="confirmedp3s2_readonly"><%=al.get(78)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="con_Edit();"> <div id="confirmedp3s3_readonly"><%=al.get(79)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="con_Edit();"> <div id="confirmedp3s4_readonly"><%=al.get(80)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="con_Edit();"> <div id="confirmedp4s1_readonly"><%=al.get(81)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="con_Edit();"> <div id="confirmedp4s2_readonly"><%=al.get(82)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="con_Edit();"> <div id="confirmedp4s3_readonly"><%=al.get(83)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="con_Edit();"> <div id="confirmedp4s4_readonly"><%=al.get(84)%></div></td>

           </tr>

           <tr id="confirmed_edit">
                 <td><B><%=statuses.get(5)%></B></td>
               <td>
                   <div id="confirmedp1s1_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(69)%>" id="confirmedp1s1" />
                   </div>
                   <span id="confirmedp1s1_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('confirmed_edit').style.display = 'none';
                        document.getElementById('confirmedp1s1_save').style.display = 'none';
                    </script>
               </td>
               <td>
                   <div id="confirmedp1s2_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(70)%>" id="confirmedp1s2" />
                       </div>
                   <span id="confirmedp1s2_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('confirmed_edit').style.display = 'none';
                        document.getElementById('confirmedp1s2_save').style.display = 'none';
                    </script>
               </td>
               <td>
                   <div id="confirmedp1s3_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(71)%>" id="confirmedp1s3" />
                       </div>
                   <span id="confirmedp1s3_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('confirmed_edit').style.display = 'none';
                        document.getElementById('confirmedp1s3_save').style.display = 'none';
                    </script>
               </td>
               <td>
                   <div id="confirmedp1s4_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(72)%>" id="confirmedp1s4" />
                       </div>
                   <span id="confirmedp1s4_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('confirmed_edit').style.display = 'none';
                        document.getElementById('confirmedp1s4_save').style.display = 'none';
                    </script>
               </td>


               <td>
                   <div id="confirmedp2s1_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(73)%>" id="confirmedp2s1" />
                   </div>
                   <span id="confirmedp2s1_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('confirmed_edit').style.display = 'none';
                        document.getElementById('confirmedp2s1_save').style.display = 'none';
                    </script>
               </td>
               <td>
                   <div id="confirmedp2s2_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(74)%>" id="confirmedp2s2" />
                       </div>
                   <span id="confirmedp2s2_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('confirmed_edit').style.display = 'none';
                        document.getElementById('confirmedp2s2_save').style.display = 'none';
                    </script>
               </td>
               <td>
                   <div id="confirmedp2s3_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(75)%>" id="confirmedp2s3" />
                       </div>
                   <span id="confirmedp2s3_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('confirmed_edit').style.display = 'none';
                        document.getElementById('confirmedp2s3_save').style.display = 'none';
                    </script>
               </td>
               <td>
                   <div id="confirmedp2s4_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(76)%>" id="confirmedp2s4" />
                       </div>
                   <span id="confirmedp2s4_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('confirmed_edit').style.display = 'none';
                        document.getElementById('confirmedp2s4_save').style.display = 'none';
                    </script>
               </td>

               <td>
                   <div id="confirmedp3s1_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(77)%>" id="confirmedp3s1" />
                   </div>
                   <span id="confirmedp3s1_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('confirmed_edit').style.display = 'none';
                        document.getElementById('confirmedp3s1_save').style.display = 'none';
                    </script>
               </td>
               <td>
                   <div id="confirmedp3s2_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(78)%>" id="confirmedp3s2" />
                       </div>
                   <span id="confirmedp3s2_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('confirmed_edit').style.display = 'none';
                        document.getElementById('confirmedp3s2_save').style.display = 'none';
                    </script>
               </td>
               <td>
                   <div id="confirmedp3s3_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(79)%>" id="confirmedp3s3" />
                       </div>
                   <span id="confirmedp3s3_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('confirmed_edit').style.display = 'none';
                        document.getElementById('confirmedp3s3_save').style.display = 'none';
                    </script>
               </td>
               <td>
                   <div id="confirmedp3s4_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(80)%>" id="confirmedp3s4" />
                       </div>
                   <span id="confirmedp3s4_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('confirmed_edit').style.display = 'none';
                        document.getElementById('confirmedp3s4_save').style.display = 'none';
                    </script>
               </td>

                <td>
                   <div id="confirmedp4s1_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(81)%>" id="confirmedp4s1" />
                   </div>
                   <span id="confirmedp4s1_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('confirmed_edit').style.display = 'none';
                        document.getElementById('confirmedp4s1_save').style.display = 'none';
                    </script>
               </td>
               <td>
                   <div id="confirmedp4s2_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(82)%>" id="confirmedp4s2" />
                       </div>
                   <span id="confirmedp4s2_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('confirmed_edit').style.display = 'none';
                        document.getElementById('confirmedp4s2_save').style.display = 'none';
                    </script>
               </td>
               <td>
                   <div id="confirmedp4s3_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(83)%>" id="confirmedp4s3" />
                       </div>
                   <span id="confirmedp4s3_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('confirmed_edit').style.display = 'none';
                        document.getElementById('confirmedp4s3_save').style.display = 'none';
                    </script>
               </td>
               <td>
                   <div id="confirmedp4s4_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(84)%>" id="confirmedp4s4" />
                       </div>
                   <span id="confirmedp4s4_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('confirmed_edit').style.display = 'none';
                        document.getElementById('confirmedp4s4_save').style.display = 'none';
                    </script>
               </td>

               <td>
                   <input type="button" value="Save" onClick="con_Save()" /> <input type="button" value="Cancel" onClick="con_Cancel();"/>
                   <input type="hidden" name="confirmedid" value="5"/>
               </td>
           </tr>
              <tr id="development_readonly">
               <td><B><%=statuses.get(6)%></B></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="development_Edit();"> <div id="developmentp1s1_readonly"><%=al.get(86)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="development_Edit();"> <div id="developmentp1s2_readonly"><%=al.get(87)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="development_Edit();"> <div id="developmentp1s3_readonly"><%=al.get(88)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="development_Edit();"> <div id="developmentp1s4_readonly"><%=al.get(89)%></div></td>

               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="development_Edit();"> <div id="developmentp2s1_readonly"><%=al.get(90)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="development_Edit();"> <div id="developmentp2s2_readonly"><%=al.get(91)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="development_Edit();"> <div id="developmentp2s3_readonly"><%=al.get(92)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="development_Edit();"> <div id="developmentp2s4_readonly"><%=al.get(93)%></div></td>

               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="development_Edit();"> <div id="developmentp3s1_readonly"><%=al.get(94)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="development_Edit();"> <div id="developmentp3s2_readonly"><%=al.get(95)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="development_Edit();"> <div id="developmentp3s3_readonly"><%=al.get(96)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="development_Edit();"> <div id="developmentp3s4_readonly"><%=al.get(97)%></div></td>

               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="development_Edit();"> <div id="developmentp4s1_readonly"><%=al.get(98)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="development_Edit();"> <div id="developmentp4s2_readonly"><%=al.get(99)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="development_Edit();"> <div id="developmentp4s3_readonly"><%=al.get(100)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="development_Edit();"> <div id="developmentp4s4_readonly"><%=al.get(101)%></div></td>

           </tr>

           <tr id="development_edit">
                 <td><B><%=statuses.get(6)%></B></td>
               <td>
                   <div id="developmentp1s1_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(86)%>" id="developmentp1s1" />
                   </div>
                   <span id="developmentp1s1_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('development_edit').style.display = 'none';
                        document.getElementById('developmentp1s1_save').style.display = 'none';
                    </script>
               </td>
               <td>
                   <div id="developmentp1s2_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(87)%>" id="developmentp1s2" />
                       </div>
                   <span id="developmentp1s2_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('development_edit').style.display = 'none';
                        document.getElementById('developmentp1s2_save').style.display = 'none';
                    </script>
               </td>
               <td>
                   <div id="developmentp1s3_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(88)%>" id="developmentp1s3" />
                       </div>
                   <span id="developmentp1s3_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('development_edit').style.display = 'none';
                        document.getElementById('developmentp1s3_save').style.display = 'none';
                    </script>
               </td>
               <td>
                   <div id="developmentp1s4_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(89)%>" id="developmentp1s4" />
                       </div>
                   <span id="developmentp1s4_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('development_edit').style.display = 'none';
                        document.getElementById('developmentp1s4_save').style.display = 'none';
                    </script>
               </td>


               <td>
                   <div id="developmentp2s1_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(90)%>" id="developmentp2s1" />
                   </div>
                   <span id="developmentp2s1_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('development_edit').style.display = 'none';
                        document.getElementById('developmentp2s1_save').style.display = 'none';
                    </script>
               </td>
               <td>
                   <div id="developmentp2s2_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(91)%>" id="developmentp2s2" />
                       </div>
                   <span id="developmentp2s2_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('development_edit').style.display = 'none';
                        document.getElementById('developmentp2s2_save').style.display = 'none';
                    </script>
               </td>
               <td>
                   <div id="developmentp2s3_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(92)%>" id="developmentp2s3" />
                       </div>
                   <span id="developmentp2s3_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('development_edit').style.display = 'none';
                        document.getElementById('developmentp2s3_save').style.display = 'none';
                    </script>
               </td>
               <td>
                   <div id="developmentp2s4_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(93)%>" id="developmentp2s4" />
                       </div>
                   <span id="developmentp2s4_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('development_edit').style.display = 'none';
                        document.getElementById('developmentp2s4_save').style.display = 'none';
                    </script>
               </td>

               <td>
                   <div id="developmentp3s1_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(94)%>" id="developmentp3s1" />
                   </div>
                   <span id="developmentp3s1_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('development_edit').style.display = 'none';
                        document.getElementById('developmentp3s1_save').style.display = 'none';
                    </script>
               </td>
               <td>
                   <div id="developmentp3s2_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(95)%>" id="developmentp3s2" />
                       </div>
                   <span id="developmentp3s2_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('development_edit').style.display = 'none';
                        document.getElementById('developmentp3s2_save').style.display = 'none';
                    </script>
               </td>
               <td>
                   <div id="developmentp3s3_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(96)%>" id="developmentp3s3" />
                       </div>
                   <span id="developmentp3s3_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('development_edit').style.display = 'none';
                        document.getElementById('developmentp3s3_save').style.display = 'none';
                    </script>
               </td>
               <td>
                   <div id="developmentp3s4_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(97)%>" id="developmentp3s4" />
                       </div>
                   <span id="developmentp3s4_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('development_edit').style.display = 'none';
                        document.getElementById('developmentp3s4_save').style.display = 'none';
                    </script>
               </td>

                <td>
                   <div id="developmentp4s1_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(98)%>" id="developmentp4s1" />
                   </div>
                   <span id="developmentp4s1_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('development_edit').style.display = 'none';
                        document.getElementById('developmentp4s1_save').style.display = 'none';
                    </script>
               </td>
               <td>
                   <div id="developmentp4s2_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(99)%>" id="developmentp4s2" />
                       </div>
                   <span id="developmentp4s2_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('development_edit').style.display = 'none';
                        document.getElementById('developmentp4s2_save').style.display = 'none';
                    </script>
               </td>
               <td>
                   <div id="developmentp4s3_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(100)%>" id="developmentp4s3" />
                       </div>
                   <span id="developmentp4s3_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('development_edit').style.display = 'none';
                        document.getElementById('developmentp4s3_save').style.display = 'none';
                    </script>
               </td>
               <td>
                   <div id="developmentp4s4_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(101)%>" id="developmentp4s4" />
                       </div>
                   <span id="developmentp4s4_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('development_edit').style.display = 'none';
                        document.getElementById('developmentp4s4_save').style.display = 'none';
                    </script>
               </td>

               <td>
                   <input type="button" value="Save" onClick="development_Save()" /> <input type="button" value="Cancel" onClick="development_Cancel();"/>
                   <input type="hidden" name="developmentid" value="6"/>
               </td>
           </tr>
      <tr id="workinprogress_readonly">
               <td><B><%=statuses.get(7)%></B></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="workinprogress_Edit();"> <div id="workinprogressp1s1_readonly"><%=al.get(103)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="workinprogress_Edit();"> <div id="workinprogressp1s2_readonly"><%=al.get(104)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="workinprogress_Edit();"> <div id="workinprogressp1s3_readonly"><%=al.get(105)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="workinprogress_Edit();"> <div id="workinprogressp1s4_readonly"><%=al.get(106)%></div></td>

               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="workinprogress_Edit();"> <div id="workinprogressp2s1_readonly"><%=al.get(107)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="workinprogress_Edit();"> <div id="workinprogressp2s2_readonly"><%=al.get(108)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="workinprogress_Edit();"> <div id="workinprogressp2s3_readonly"><%=al.get(109)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="workinprogress_Edit();"> <div id="workinprogressp2s4_readonly"><%=al.get(110)%></div></td>

               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="workinprogress_Edit();"> <div id="workinprogressp3s1_readonly"><%=al.get(111)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="workinprogress_Edit();"> <div id="workinprogressp3s2_readonly"><%=al.get(112)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="workinprogress_Edit();"> <div id="workinprogressp3s3_readonly"><%=al.get(113)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="workinprogress_Edit();"> <div id="workinprogressp3s4_readonly"><%=al.get(114)%></div></td>

               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="workinprogress_Edit();"> <div id="workinprogressp4s1_readonly"><%=al.get(115)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="workinprogress_Edit();"> <div id="workinprogressp4s2_readonly"><%=al.get(116)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="workinprogress_Edit();"> <div id="workinprogressp4s3_readonly"><%=al.get(117)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="workinprogress_Edit();"> <div id="workinprogressp4s4_readonly"><%=al.get(118)%></div></td>

           </tr>

           <tr id="workinprogress_edit">
                 <td><B><%=statuses.get(7)%></B></td>
               <td>
                   <div id="workinprogressp1s1_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(103)%>" id="workinprogressp1s1" />
                   </div>
                   <span id="workinprogressp1s1_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('workinprogress_edit').style.display = 'none';
                        document.getElementById('workinprogressp1s1_save').style.display = 'none';
                    </script>
               </td>
               <td>
                   <div id="workinprogressp1s2_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(104)%>" id="workinprogressp1s2" />
                       </div>
                   <span id="workinprogressp1s2_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('workinprogress_edit').style.display = 'none';
                        document.getElementById('workinprogressp1s2_save').style.display = 'none';
                    </script>
               </td>
               <td>
                   <div id="workinprogressp1s3_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(105)%>" id="workinprogressp1s3" />
                       </div>
                   <span id="workinprogressp1s3_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('workinprogress_edit').style.display = 'none';
                        document.getElementById('workinprogressp1s3_save').style.display = 'none';
                    </script>
               </td>
               <td>
                   <div id="workinprogressp1s4_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(106)%>" id="workinprogressp1s4" />
                       </div>
                   <span id="workinprogressp1s4_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('workinprogress_edit').style.display = 'none';
                        document.getElementById('workinprogressp1s4_save').style.display = 'none';
                    </script>
               </td>


               <td>
                   <div id="workinprogressp2s1_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(107)%>" id="workinprogressp2s1" />
                   </div>
                   <span id="workinprogressp2s1_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('workinprogress_edit').style.display = 'none';
                        document.getElementById('workinprogressp2s1_save').style.display = 'none';
                    </script>
               </td>
               <td>
                   <div id="workinprogressp2s2_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(108)%>" id="workinprogressp2s2" />
                       </div>
                   <span id="workinprogressp2s2_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('workinprogress_edit').style.display = 'none';
                        document.getElementById('workinprogressp2s2_save').style.display = 'none';
                    </script>
               </td>
               <td>
                   <div id="workinprogressp2s3_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(109)%>" id="workinprogressp2s3" />
                       </div>
                   <span id="workinprogressp2s3_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('workinprogress_edit').style.display = 'none';
                        document.getElementById('workinprogressp2s3_save').style.display = 'none';
                    </script>
               </td>
               <td>
                   <div id="workinprogressp2s4_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(110)%>" id="workinprogressp2s4" />
                       </div>
                   <span id="workinprogressp2s4_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('workinprogress_edit').style.display = 'none';
                        document.getElementById('workinprogressp2s4_save').style.display = 'none';
                    </script>
               </td>

               <td>
                   <div id="workinprogressp3s1_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(111)%>" id="workinprogressp3s1" />
                   </div>
                   <span id="workinprogressp3s1_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('workinprogress_edit').style.display = 'none';
                        document.getElementById('workinprogressp3s1_save').style.display = 'none';
                    </script>
               </td>
               <td>
                   <div id="workinprogressp3s2_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(112)%>" id="workinprogressp3s2" />
                       </div>
                   <span id="workinprogressp3s2_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('workinprogress_edit').style.display = 'none';
                        document.getElementById('workinprogressp3s2_save').style.display = 'none';
                    </script>
               </td>
               <td>
                   <div id="workinprogressp3s3_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(113)%>" id="workinprogressp3s3" />
                       </div>
                   <span id="workinprogressp3s3_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('workinprogress_edit').style.display = 'none';
                        document.getElementById('workinprogressp3s3_save').style.display = 'none';
                    </script>
               </td>
               <td>
                   <div id="workinprogressp3s4_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(114)%>" id="workinprogressp3s4" />
                       </div>
                   <span id="workinprogressp3s4_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('workinprogress_edit').style.display = 'none';
                        document.getElementById('workinprogressp3s4_save').style.display = 'none';
                    </script>
               </td>

                <td>
                   <div id="workinprogressp4s1_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(115)%>" id="workinprogressp4s1" />
                   </div>
                   <span id="workinprogressp4s1_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('workinprogress_edit').style.display = 'none';
                        document.getElementById('workinprogressp4s1_save').style.display = 'none';
                    </script>
               </td>
               <td>
                   <div id="workinprogressp4s2_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(116)%>" id="workinprogressp4s2" />
                       </div>
                   <span id="workinprogressp4s2_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('workinprogress_edit').style.display = 'none';
                        document.getElementById('workinprogressp4s2_save').style.display = 'none';
                    </script>
               </td>
               <td>
                   <div id="workinprogressp4s3_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(117)%>" id="workinprogressp4s3" />
                       </div>
                   <span id="workinprogressp4s3_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('workinprogress_edit').style.display = 'none';
                        document.getElementById('workinprogressp4s3_save').style.display = 'none';
                    </script>
               </td>
               <td>
                   <div id="workinprogressp4s4_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(118)%>" id="workinprogressp4s4" />
                       </div>
                   <span id="workinprogressp4s4_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('workinprogress_edit').style.display = 'none';
                        document.getElementById('workinprogressp4s4_save').style.display = 'none';
                    </script>
               </td>

               <td>
                   <input type="button" value="Save" onClick="workinprogress_Save()" /> <input type="button" value="Cancel" onClick="workinprogress_Cancel();"/>
                   <input type="hidden" name="workinprogressid" value="7"/>
               </td>
           </tr>
              <tr id="codereview_readonly">
               <td><B><%=statuses.get(8)%></B></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="codereview_Edit();"> <div id="codereviewp1s1_readonly"><%=al.get(120)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="codereview_Edit();"> <div id="codereviewp1s2_readonly"><%=al.get(121)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="codereview_Edit();"> <div id="codereviewp1s3_readonly"><%=al.get(122)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="codereview_Edit();"> <div id="codereviewp1s4_readonly"><%=al.get(123)%></div></td>

               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="codereview_Edit();"> <div id="codereviewp2s1_readonly"><%=al.get(124)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="codereview_Edit();"> <div id="codereviewp2s2_readonly"><%=al.get(125)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="codereview_Edit();"> <div id="codereviewp2s3_readonly"><%=al.get(126)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="codereview_Edit();"> <div id="codereviewp2s4_readonly"><%=al.get(127)%></div></td>

               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="codereview_Edit();"> <div id="codereviewp3s1_readonly"><%=al.get(128)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="codereview_Edit();"> <div id="codereviewp3s2_readonly"><%=al.get(129)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="codereview_Edit();"> <div id="codereviewp3s3_readonly"><%=al.get(130)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="codereview_Edit();"> <div id="codereviewp3s4_readonly"><%=al.get(131)%></div></td>

               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="codereview_Edit();"> <div id="codereviewp4s1_readonly"><%=al.get(132)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="codereview_Edit();"> <div id="codereviewp4s2_readonly"><%=al.get(133)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="codereview_Edit();"> <div id="codereviewp4s3_readonly"><%=al.get(134)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="codereview_Edit();"> <div id="codereviewp4s4_readonly"><%=al.get(135)%></div></td>

           </tr>

           <tr id="codereview_edit">
                 <td><B><%=statuses.get(8)%></B></td>
               <td>
                   <div id="codereviewp1s1_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(120)%>" id="codereviewp1s1" />
                   </div>
                   <span id="codereviewp1s1_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('codereview_edit').style.display = 'none';
                        document.getElementById('codereviewp1s1_save').style.display = 'none';
                    </script>
               </td>
               <td>
                   <div id="codereviewp1s2_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(121)%>" id="codereviewp1s2" />
                       </div>
                   <span id="codereviewp1s2_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('codereview_edit').style.display = 'none';
                        document.getElementById('codereviewp1s2_save').style.display = 'none';
                    </script>
               </td>
               <td>
                   <div id="codereviewp1s3_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(122)%>" id="codereviewp1s3" />
                       </div>
                   <span id="codereviewp1s3_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('codereview_edit').style.display = 'none';
                        document.getElementById('codereviewp1s3_save').style.display = 'none';
                    </script>
               </td>
               <td>
                   <div id="codereviewp1s4_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(123)%>" id="codereviewp1s4" />
                       </div>
                   <span id="codereviewp1s4_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('codereview_edit').style.display = 'none';
                        document.getElementById('codereviewp1s4_save').style.display = 'none';
                    </script>
               </td>


               <td>
                   <div id="codereviewp2s1_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(124)%>" id="codereviewp2s1" />
                   </div>
                   <span id="codereviewp2s1_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('codereview_edit').style.display = 'none';
                        document.getElementById('codereviewp2s1_save').style.display = 'none';
                    </script>
               </td>
               <td>
                   <div id="codereviewp2s2_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(125)%>" id="codereviewp2s2" />
                       </div>
                   <span id="codereviewp2s2_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('codereview_edit').style.display = 'none';
                        document.getElementById('codereviewp2s2_save').style.display = 'none';
                    </script>
               </td>
               <td>
                   <div id="codereviewp2s3_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(126)%>" id="codereviewp2s3" />
                       </div>
                   <span id="codereviewp2s3_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('codereview_edit').style.display = 'none';
                        document.getElementById('codereviewp2s3_save').style.display = 'none';
                    </script>
               </td>
               <td>
                   <div id="codereviewp2s4_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(127)%>" id="codereviewp2s4" />
                       </div>
                   <span id="codereviewp2s4_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('codereview_edit').style.display = 'none';
                        document.getElementById('codereviewp2s4_save').style.display = 'none';
                    </script>
               </td>

               <td>
                   <div id="codereviewp3s1_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(128)%>" id="codereviewp3s1" />
                   </div>
                   <span id="codereviewp3s1_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('codereview_edit').style.display = 'none';
                        document.getElementById('codereviewp3s1_save').style.display = 'none';
                    </script>
               </td>
               <td>
                   <div id="codereviewp3s2_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(129)%>" id="codereviewp3s2" />
                       </div>
                   <span id="codereviewp3s2_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('codereview_edit').style.display = 'none';
                        document.getElementById('codereviewp3s2_save').style.display = 'none';
                    </script>
               </td>
               <td>
                   <div id="codereviewp3s3_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(130)%>" id="codereviewp3s3" />
                       </div>
                   <span id="codereviewp3s3_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('codereview_edit').style.display = 'none';
                        document.getElementById('codereviewp3s3_save').style.display = 'none';
                    </script>
               </td>
               <td>
                   <div id="codereviewp3s4_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(131)%>" id="codereviewp3s4" />
                       </div>
                   <span id="codereviewp3s4_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('codereview_edit').style.display = 'none';
                        document.getElementById('codereviewp3s4_save').style.display = 'none';
                    </script>
               </td>

                <td>
                   <div id="codereviewp4s1_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(132)%>" id="codereviewp4s1" />
                   </div>
                   <span id="codereviewp4s1_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('codereview_edit').style.display = 'none';
                        document.getElementById('codereviewp4s1_save').style.display = 'none';
                    </script>
               </td>
               <td>
                   <div id="codereviewp4s2_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(133)%>" id="codereviewp4s2" />
                       </div>
                   <span id="codereviewp4s2_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('codereview_edit').style.display = 'none';
                        document.getElementById('codereviewp4s2_save').style.display = 'none';
                    </script>
               </td>
               <td>
                   <div id="codereviewp4s3_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(134)%>" id="codereviewp4s3" />
                       </div>
                   <span id="codereviewp4s3_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('codereview_edit').style.display = 'none';
                        document.getElementById('codereviewp4s3_save').style.display = 'none';
                    </script>
               </td>
               <td>
                   <div id="codereviewp4s4_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(135)%>" id="codereviewp4s4" />
                       </div>
                   <span id="codereviewp4s4_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('codereview_edit').style.display = 'none';
                        document.getElementById('codereviewp4s4_save').style.display = 'none';
                    </script>
               </td>

               <td>
                   <input type="button" value="Save" onClick="codereview_Save()" /> <input type="button" value="Cancel" onClick="codereview_Cancel();"/>
                   <input type="hidden" name="codereviewid" value="8"/>
               </td>
                <tr id="readytobuild_readonly">
               <td><B><%=statuses.get(9)%></B></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="readytobuild_Edit();"> <div id="readytobuildp1s1_readonly"><%=al.get(137)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="readytobuild_Edit();"> <div id="readytobuildp1s2_readonly"><%=al.get(138)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="readytobuild_Edit();"> <div id="readytobuildp1s3_readonly"><%=al.get(139)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="readytobuild_Edit();"> <div id="readytobuildp1s4_readonly"><%=al.get(140)%></div></td>

               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="readytobuild_Edit();"> <div id="readytobuildp2s1_readonly"><%=al.get(141)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="readytobuild_Edit();"> <div id="readytobuildp2s2_readonly"><%=al.get(142)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="readytobuild_Edit();"> <div id="readytobuildp2s3_readonly"><%=al.get(143)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="readytobuild_Edit();"> <div id="readytobuildp2s4_readonly"><%=al.get(144)%></div></td>

               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="readytobuild_Edit();"> <div id="readytobuildp3s1_readonly"><%=al.get(145)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="readytobuild_Edit();"> <div id="readytobuildp3s2_readonly"><%=al.get(146)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="readytobuild_Edit();"> <div id="readytobuildp3s3_readonly"><%=al.get(147)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="readytobuild_Edit();"> <div id="readytobuildp3s4_readonly"><%=al.get(148)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="readytobuild_Edit();"> <div id="readytobuildp4s1_readonly"><%=al.get(149)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="readytobuild_Edit();"> <div id="readytobuildp4s2_readonly"><%=al.get(150)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="readytobuild_Edit();"> <div id="readytobuildp4s3_readonly"><%=al.get(151)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="readytobuild_Edit();"> <div id="readytobuildp4s4_readonly"><%=al.get(152)%></div></td>

           </tr>

           <tr id="readytobuild_edit">
                 <td><B><%=statuses.get(9)%></B></td>
               <td>
                   <div id="readytobuildp1s1_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(137)%>" id="readytobuildp1s1" />
                   </div>
                   <span id="readytobuildp1s1_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('readytobuild_edit').style.display = 'none';
                        document.getElementById('readytobuildp1s1_save').style.display = 'none';
                    </script>
               </td>
               <td>
                   <div id="readytobuildp1s2_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(138)%>" id="readytobuildp1s2" />
                       </div>
                   <span id="readytobuildp1s2_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('readytobuild_edit').style.display = 'none';
                        document.getElementById('readytobuildp1s2_save').style.display = 'none';
                    </script>
               </td>
               <td>
                   <div id="readytobuildp1s3_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(139)%>" id="readytobuildp1s3" />
                       </div>
                   <span id="readytobuildp1s3_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('readytobuild_edit').style.display = 'none';
                        document.getElementById('readytobuildp1s3_save').style.display = 'none';
                    </script>
               </td>
               <td>
                   <div id="readytobuildp1s4_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(140)%>" id="readytobuildp1s4" />
                       </div>
                   <span id="readytobuildp1s4_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('readytobuild_edit').style.display = 'none';
                        document.getElementById('readytobuildp1s4_save').style.display = 'none';
                    </script>
               </td>


               <td>
                   <div id="readytobuildp2s1_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(141)%>" id="readytobuildp2s1" />
                   </div>
                   <span id="readytobuildp2s1_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('readytobuild_edit').style.display = 'none';
                        document.getElementById('readytobuildp2s1_save').style.display = 'none';
                    </script>
               </td>
               <td>
                   <div id="readytobuildp2s2_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(142)%>" id="readytobuildp2s2" />
                       </div>
                   <span id="readytobuildp2s2_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('readytobuild_edit').style.display = 'none';
                        document.getElementById('readytobuildp2s2_save').style.display = 'none';
                    </script>
               </td>
               <td>
                   <div id="readytobuildp2s3_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(143)%>" id="readytobuildp2s3" />
                       </div>
                   <span id="readytobuildp2s3_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('readytobuild_edit').style.display = 'none';
                        document.getElementById('readytobuildp2s3_save').style.display = 'none';
                    </script>
               </td>
               <td>
                   <div id="readytobuildp2s4_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(144)%>" id="readytobuildp2s4" />
                       </div>
                   <span id="readytobuildp2s4_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('readytobuild_edit').style.display = 'none';
                        document.getElementById('readytobuildp2s4_save').style.display = 'none';
                    </script>
               </td>

               <td>
                   <div id="readytobuildp3s1_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(145)%>" id="readytobuildp3s1" />
                   </div>
                   <span id="readytobuildp3s1_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('readytobuild_edit').style.display = 'none';
                        document.getElementById('readytobuildp3s1_save').style.display = 'none';
                    </script>
               </td>
               <td>
                   <div id="readytobuildp3s2_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(146)%>" id="readytobuildp3s2" />
                       </div>
                   <span id="readytobuildp3s2_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('readytobuild_edit').style.display = 'none';
                        document.getElementById('readytobuildp3s2_save').style.display = 'none';
                    </script>
               </td>
               <td>
                   <div id="readytobuildp3s3_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(147)%>" id="readytobuildp3s3" />
                       </div>
                   <span id="readytobuildp3s3_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('readytobuild_edit').style.display = 'none';
                        document.getElementById('readytobuildp3s3_save').style.display = 'none';
                    </script>
               </td>
               <td>
                   <div id="readytobuildp3s4_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(148)%>" id="readytobuildp3s4" />
                       </div>
                   <span id="readytobuildp3s4_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('readytobuild_edit').style.display = 'none';
                        document.getElementById('readytobuildp3s4_save').style.display = 'none';
                    </script>
               </td>

                <td>
                   <div id="readytobuildp4s1_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(149)%>" id="readytobuildp4s1" />
                   </div>
                   <span id="readytobuildp4s1_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('readytobuild_edit').style.display = 'none';
                        document.getElementById('readytobuildp4s1_save').style.display = 'none';
                    </script>
               </td>
               <td>
                   <div id="readytobuildp4s2_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(150)%>" id="readytobuildp4s2" />
                       </div>
                   <span id="readytobuildp4s2_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('readytobuild_edit').style.display = 'none';
                        document.getElementById('readytobuildp4s2_save').style.display = 'none';
                    </script>
               </td>
               <td>
                   <div id="readytobuildp4s3_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(151)%>" id="readytobuildp4s3" />
                       </div>
                   <span id="readytobuildp4s3_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('readytobuild_edit').style.display = 'none';
                        document.getElementById('readytobuildp4s3_save').style.display = 'none';
                    </script>
               </td>
               <td>
                   <div id="readytobuildp4s4_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(152)%>" id="readytobuildp4s4" />
                       </div>
                   <span id="readytobuildp4s4_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('readytobuild_edit').style.display = 'none';
                        document.getElementById('readytobuildp4s4_save').style.display = 'none';
                    </script>
               </td>

               <td>
                   <input type="button" value="Save" onClick="readytobuild_Save()" /> <input type="button" value="Cancel" onClick="readytobuild_Cancel();"/>
                   <input type="hidden" name="readytobuildid" value="9"/>
               </td>
           </tr>

           <tr id="qa_readonly">
               <td><B><%=statuses.get(10)%></B></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="qa_Edit();"> <div id="qap1s1_readonly"><%=al.get(154)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="qa_Edit();"> <div id="qap1s2_readonly"><%=al.get(155)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="qa_Edit();"> <div id="qap1s3_readonly"><%=al.get(156)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="qa_Edit();"> <div id="qap1s4_readonly"><%=al.get(157)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="qa_Edit();"> <div id="qap2s1_readonly"><%=al.get(158)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="qa_Edit();"> <div id="qap2s2_readonly"><%=al.get(159)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="qa_Edit();"> <div id="qap2s3_readonly"><%=al.get(160)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="qa_Edit();"> <div id="qap2s4_readonly"><%=al.get(161)%></div></td>

               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="qa_Edit();"> <div id="qap3s1_readonly"><%=al.get(162)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="qa_Edit();"> <div id="qap3s2_readonly"><%=al.get(163)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="qa_Edit();"> <div id="qap3s3_readonly"><%=al.get(164)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="qa_Edit();"> <div id="qap3s4_readonly"><%=al.get(165)%></div></td>

               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="qa_Edit();"> <div id="qap4s1_readonly"><%=al.get(166)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="qa_Edit();"> <div id="qap4s2_readonly"><%=al.get(167)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="qa_Edit();"> <div id="qap4s3_readonly"><%=al.get(168)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="qa_Edit();"> <div id="qap4s4_readonly"><%=al.get(169)%></div></td>

           </tr>

           <tr id="qa_edit">
                 <td><B><%=statuses.get(10)%></B></td>
               <td>
                   <div id="qap1s1_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(154)%>" id="qap1s1" />
                   </div>
                   <span id="qap1s1_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('qa_edit').style.display = 'none';
                        document.getElementById('qap1s1_save').style.display = 'none';
                    </script>
               </td>
               <td>
                   <div id="qap1s2_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(155)%>" id="qap1s2" />
                       </div>
                   <span id="qap1s2_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('qa_edit').style.display = 'none';
                        document.getElementById('qap1s2_save').style.display = 'none';
                    </script>
               </td>
               <td>
                   <div id="qap1s3_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(156)%>" id="qap1s3" />
                       </div>
                   <span id="qap1s3_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('qa_edit').style.display = 'none';
                        document.getElementById('qap1s3_save').style.display = 'none';
                    </script>
               </td>
               <td>
                   <div id="qap1s4_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(157)%>" id="qap1s4" />
                       </div>
                   <span id="qap1s4_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('qa_edit').style.display = 'none';
                        document.getElementById('qap1s4_save').style.display = 'none';
                    </script>
               </td>


               <td>
                   <div id="qap2s1_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(158)%>" id="qap2s1" />
                   </div>
                   <span id="qap2s1_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('qa_edit').style.display = 'none';
                        document.getElementById('qap2s1_save').style.display = 'none';
                    </script>
               </td>
               <td>
                   <div id="qap2s2_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(159)%>" id="qap2s2" />
                       </div>
                   <span id="qap2s2_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('qa_edit').style.display = 'none';
                        document.getElementById('qap2s2_save').style.display = 'none';
                    </script>
               </td>
               <td>
                   <div id="qap2s3_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(160)%>" id="qap2s3" />
                       </div>
                   <span id="qap2s3_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('qa_edit').style.display = 'none';
                        document.getElementById('qap2s3_save').style.display = 'none';
                    </script>
               </td>
               <td>
                   <div id="qap2s4_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(161)%>" id="qap2s4" />
                       </div>
                   <span id="qap2s4_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('qa_edit').style.display = 'none';
                        document.getElementById('qap2s4_save').style.display = 'none';
                    </script>
               </td>

               <td>
                   <div id="qap3s1_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(162)%>" id="qap3s1" />
                   </div>
                   <span id="qap3s1_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('qa_edit').style.display = 'none';
                        document.getElementById('qap3s1_save').style.display = 'none';
                    </script>
               </td>
               <td>
                   <div id="qap3s2_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(163)%>" id="qap3s2" />
                       </div>
                   <span id="qap3s2_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('qa_edit').style.display = 'none';
                        document.getElementById('qap3s2_save').style.display = 'none';
                    </script>
               </td>
               <td>
                   <div id="qap3s3_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(164)%>" id="qap3s3" />
                       </div>
                   <span id="qap3s3_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('qa_edit').style.display = 'none';
                        document.getElementById('qap3s3_save').style.display = 'none';
                    </script>
               </td>
               <td>
                   <div id="qap3s4_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(165)%>" id="qap3s4" />
                       </div>
                   <span id="qap3s4_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('qa_edit').style.display = 'none';
                        document.getElementById('qap3s4_save').style.display = 'none';
                    </script>
               </td>

                <td>
                   <div id="qap4s1_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(166)%>" id="qap4s1" />
                   </div>
                   <span id="qap4s1_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('qa_edit').style.display = 'none';
                        document.getElementById('qap4s1_save').style.display = 'none';
                    </script>
               </td>
               <td>
                   <div id="qap4s2_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(167)%>" id="qap4s2" />
                       </div>
                   <span id="qap4s2_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('qa_edit').style.display = 'none';
                        document.getElementById('qap4s2_save').style.display = 'none';
                    </script>
               </td>
               <td>
                   <div id="qap4s3_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(168)%>" id="qap4s3" />
                       </div>
                   <span id="qap4s3_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('qa_edit').style.display = 'none';
                        document.getElementById('qap4s3_save').style.display = 'none';
                    </script>
               </td>
               <td>
                   <div id="qap4s4_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(169)%>" id="qap4s4" />
                       </div>
                   <span id="qap4s4_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('qa_edit').style.display = 'none';
                        document.getElementById('qap4s4_save').style.display = 'none';
                    </script>
               </td>

               <td>
                   <input type="button" value="Save" onClick="qa_Save()" /> <input type="button" value="Cancel" onClick="qa_Cancel();"/>
                   <input type="hidden" name="qaid" value="10"/>
               </td>
           </tr>
              <tr id="performancetesting_readonly">
               <td><B><%=statuses.get(11)%></B></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="performancetesting_Edit();"> <div id="performancetestingp1s1_readonly"><%=al.get(171)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="performancetesting_Edit();"> <div id="performancetestingp1s2_readonly"><%=al.get(172)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="performancetesting_Edit();"> <div id="performancetestingp1s3_readonly"><%=al.get(173)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="performancetesting_Edit();"> <div id="performancetestingp1s4_readonly"><%=al.get(174)%></div></td>

               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="performancetesting_Edit();"> <div id="performancetestingp2s1_readonly"><%=al.get(175)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="performancetesting_Edit();"> <div id="performancetestingp2s2_readonly"><%=al.get(176)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="performancetesting_Edit();"> <div id="performancetestingp2s3_readonly"><%=al.get(177)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="performancetesting_Edit();"> <div id="performancetestingp2s4_readonly"><%=al.get(178)%></div></td>

               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="performancetesting_Edit();"> <div id="performancetestingp3s1_readonly"><%=al.get(179)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="performancetesting_Edit();"> <div id="performancetestingp3s2_readonly"><%=al.get(180)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="performancetesting_Edit();"> <div id="performancetestingp3s3_readonly"><%=al.get(181)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="performancetesting_Edit();"> <div id="performancetestingp3s4_readonly"><%=al.get(182)%></div></td>

               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="performancetesting_Edit();"> <div id="performancetestingp4s1_readonly"><%=al.get(183)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="performancetesting_Edit();"> <div id="performancetestingp4s2_readonly"><%=al.get(184)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="performancetesting_Edit();"> <div id="performancetestingp4s3_readonly"><%=al.get(185)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="performancetesting_Edit();"> <div id="performancetestingp4s4_readonly"><%=al.get(186)%></div></td>

           </tr>

           <tr id="performancetesting_edit">
                 <td><B><%=statuses.get(11)%></B></td>
               <td>
                   <div id="performancetestingp1s1_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(171)%>" id="performancetestingp1s1" />
                   </div>
                   <span id="performancetestingp1s1_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('performancetesting_edit').style.display = 'none';
                        document.getElementById('performancetestingp1s1_save').style.display = 'none';
                    </script>
               </td>
               <td>
                   <div id="performancetestingp1s2_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(172)%>" id="performancetestingp1s2" />
                       </div>
                   <span id="performancetestingp1s2_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('performancetesting_edit').style.display = 'none';
                        document.getElementById('performancetestingp1s2_save').style.display = 'none';
                    </script>
               </td>
               <td>
                   <div id="performancetestingp1s3_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(173)%>" id="performancetestingp1s3" />
                       </div>
                   <span id="performancetestingp1s3_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('performancetesting_edit').style.display = 'none';
                        document.getElementById('performancetestingp1s3_save').style.display = 'none';
                    </script>
               </td>
               <td>
                   <div id="performancetestingp1s4_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(174)%>" id="performancetestingp1s4" />
                       </div>
                   <span id="performancetestingp1s4_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('performancetesting_edit').style.display = 'none';
                        document.getElementById('performancetestingp1s4_save').style.display = 'none';
                    </script>
               </td>


               <td>
                   <div id="performancetestingp2s1_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(175)%>" id="performancetestingp2s1" />
                   </div>
                   <span id="performancetestingp2s1_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('performancetesting_edit').style.display = 'none';
                        document.getElementById('performancetestingp2s1_save').style.display = 'none';
                    </script>
               </td>
               <td>
                   <div id="performancetestingp2s2_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(176)%>" id="performancetestingp2s2" />
                       </div>
                   <span id="performancetestingp2s2_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('performancetesting_edit').style.display = 'none';
                        document.getElementById('performancetestingp2s2_save').style.display = 'none';
                    </script>
               </td>
               <td>
                   <div id="performancetestingp2s3_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(177)%>" id="performancetestingp2s3" />
                       </div>
                   <span id="performancetestingp2s3_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('performancetesting_edit').style.display = 'none';
                        document.getElementById('performancetestingp2s3_save').style.display = 'none';
                    </script>
               </td>
               <td>
                   <div id="performancetestingp2s4_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(178)%>" id="performancetestingp2s4" />
                       </div>
                   <span id="performancetestingp2s4_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('performancetesting_edit').style.display = 'none';
                        document.getElementById('performancetestingp2s4_save').style.display = 'none';
                    </script>
               </td>

               <td>
                   <div id="performancetestingp3s1_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(179)%>" id="performancetestingp3s1" />
                   </div>
                   <span id="performancetestingp3s1_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('performancetesting_edit').style.display = 'none';
                        document.getElementById('performancetestingp3s1_save').style.display = 'none';
                    </script>
               </td>
               <td>
                   <div id="performancetestingp3s2_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(180)%>" id="performancetestingp3s2" />
                       </div>
                   <span id="performancetestingp3s2_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('performancetesting_edit').style.display = 'none';
                        document.getElementById('performancetestingp3s2_save').style.display = 'none';
                    </script>
               </td>
               <td>
                   <div id="performancetestingp3s3_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(181)%>" id="performancetestingp3s3" />
                       </div>
                   <span id="performancetestingp3s3_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('performancetesting_edit').style.display = 'none';
                        document.getElementById('performancetestingp3s3_save').style.display = 'none';
                    </script>
               </td>
               <td>
                   <div id="performancetestingp3s4_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(182)%>" id="performancetestingp3s4" />
                       </div>
                   <span id="performancetestingp3s4_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('performancetesting_edit').style.display = 'none';
                        document.getElementById('performancetestingp3s4_save').style.display = 'none';
                    </script>
               </td>

                <td>
                   <div id="performancetestingp4s1_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(183)%>" id="performancetestingp4s1" />
                   </div>
                   <span id="performancetestingp4s1_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('performancetesting_edit').style.display = 'none';
                        document.getElementById('performancetestingp4s1_save').style.display = 'none';
                    </script>
               </td>
               <td>
                   <div id="performancetestingp4s2_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(184)%>" id="performancetestingp4s2" />
                       </div>
                   <span id="performancetestingp4s2_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('performancetesting_edit').style.display = 'none';
                        document.getElementById('performancetestingp4s2_save').style.display = 'none';
                    </script>
               </td>
               <td>
                   <div id="performancetestingp4s3_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(185)%>" id="performancetestingp4s3" />
                       </div>
                   <span id="performancetestingp4s3_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('performancetesting_edit').style.display = 'none';
                        document.getElementById('performancetestingp4s3_save').style.display = 'none';
                    </script>
               </td>
               <td>
                   <div id="performancetestingp4s4_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(186)%>" id="performancetestingp4s4" />
                       </div>
                   <span id="performancetestingp4s4_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('performancetesting_edit').style.display = 'none';
                        document.getElementById('performancetestingp4s4_save').style.display = 'none';
                    </script>
               </td>

               <td>
                   <input type="button" value="Save" onClick="performancetesting_Save()" /> <input type="button" value="Cancel" onClick="performancetesting_Cancel();"/>
                   <input type="hidden" name="performancetestingid" value="11"/>
               </td>
           </tr>
              <tr id="verified_readonly">
               <td><B><%=statuses.get(12)%></B></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="verified_Edit();"> <div id="verifiedp1s1_readonly"><%=al.get(188)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="verified_Edit();"> <div id="verifiedp1s2_readonly"><%=al.get(189)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="verified_Edit();"> <div id="verifiedp1s3_readonly"><%=al.get(190)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="verified_Edit();"> <div id="verifiedp1s4_readonly"><%=al.get(191)%></div></td>

               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="verified_Edit();"> <div id="verifiedp2s1_readonly"><%=al.get(192)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="verified_Edit();"> <div id="verifiedp2s2_readonly"><%=al.get(193)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="verified_Edit();"> <div id="verifiedp2s3_readonly"><%=al.get(194)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="verified_Edit();"> <div id="verifiedp2s4_readonly"><%=al.get(195)%></div></td>

               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="verified_Edit();"> <div id="verifiedp3s1_readonly"><%=al.get(196)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="verified_Edit();"> <div id="verifiedp3s2_readonly"><%=al.get(197)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="verified_Edit();"> <div id="verifiedp3s3_readonly"><%=al.get(198)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="verified_Edit();"> <div id="verifiedp3s4_readonly"><%=al.get(199)%></div></td>

               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="verified_Edit();"> <div id="verifiedp4s1_readonly"><%=al.get(200)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="verified_Edit();"> <div id="verifiedp4s2_readonly"><%=al.get(201)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="verified_Edit();"> <div id="verifiedp4s3_readonly"><%=al.get(202)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="verified_Edit();"> <div id="verifiedp4s4_readonly"><%=al.get(203)%></div></td>

           </tr>

           <tr id="verified_edit">
                 <td><B><%=statuses.get(12)%></B></td>
               <td>
                   <div id="verifiedp1s1_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(188)%>" id="verifiedp1s1" />
                   </div>
                   <span id="verifiedp1s1_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('verified_edit').style.display = 'none';
                        document.getElementById('verifiedp1s1_save').style.display = 'none';
                    </script>
               </td>
               <td>
                   <div id="verifiedp1s2_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(189)%>" id="verifiedp1s2" />
                       </div>
                   <span id="verifiedp1s2_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('verified_edit').style.display = 'none';
                        document.getElementById('verifiedp1s2_save').style.display = 'none';
                    </script>
               </td>
               <td>
                   <div id="verifiedp1s3_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(190)%>" id="verifiedp1s3" />
                       </div>
                   <span id="verifiedp1s3_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('verified_edit').style.display = 'none';
                        document.getElementById('verifiedp1s3_save').style.display = 'none';
                    </script>
               </td>
               <td>
                   <div id="verifiedp1s4_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(191)%>" id="verifiedp1s4" />
                       </div>
                   <span id="verifiedp1s4_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('verified_edit').style.display = 'none';
                        document.getElementById('verifiedp1s4_save').style.display = 'none';
                    </script>
               </td>


               <td>
                   <div id="verifiedp2s1_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(192)%>" id="verifiedp2s1" />
                   </div>
                   <span id="verifiedp2s1_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('verified_edit').style.display = 'none';
                        document.getElementById('verifiedp2s1_save').style.display = 'none';
                    </script>
               </td>
               <td>
                   <div id="verifiedp2s2_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(193)%>" id="verifiedp2s2" />
                       </div>
                   <span id="verifiedp2s2_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('verified_edit').style.display = 'none';
                        document.getElementById('verifiedp2s2_save').style.display = 'none';
                    </script>
               </td>
               <td>
                   <div id="verifiedp2s3_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(194)%>" id="verifiedp2s3" />
                       </div>
                   <span id="verifiedp2s3_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('verified_edit').style.display = 'none';
                        document.getElementById('verifiedp2s3_save').style.display = 'none';
                    </script>
               </td>
               <td>
                   <div id="verifiedp2s4_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(195)%>" id="verifiedp2s4" />
                       </div>
                   <span id="verifiedp2s4_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('verified_edit').style.display = 'none';
                        document.getElementById('verifiedp2s4_save').style.display = 'none';
                    </script>
               </td>

               <td>
                   <div id="verifiedp3s1_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(196)%>" id="verifiedp3s1" />
                   </div>
                   <span id="verifiedp3s1_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('verified_edit').style.display = 'none';
                        document.getElementById('verifiedp3s1_save').style.display = 'none';
                    </script>
               </td>
               <td>
                   <div id="verifiedp3s2_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(197)%>" id="verifiedp3s2" />
                       </div>
                   <span id="verifiedp3s2_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('verified_edit').style.display = 'none';
                        document.getElementById('verifiedp3s2_save').style.display = 'none';
                    </script>
               </td>
               <td>
                   <div id="verifiedp3s3_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(198)%>" id="verifiedp3s3" />
                       </div>
                   <span id="verifiedp3s3_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('verified_edit').style.display = 'none';
                        document.getElementById('verifiedp3s3_save').style.display = 'none';
                    </script>
               </td>
               <td>
                   <div id="verifiedp3s4_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(199)%>" id="verifiedp3s4" />
                       </div>
                   <span id="verifiedp3s4_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('verified_edit').style.display = 'none';
                        document.getElementById('verifiedp3s4_save').style.display = 'none';
                    </script>
               </td>

                <td>
                   <div id="verifiedp4s1_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(200)%>" id="verifiedp4s1" />
                   </div>
                   <span id="verifiedp4s1_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('verified_edit').style.display = 'none';
                        document.getElementById('verifiedp4s1_save').style.display = 'none';
                    </script>
               </td>
               <td>
                   <div id="verifiedp4s2_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(201)%>" id="verifiedp4s2" />
                       </div>
                   <span id="verifiedp4s2_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('verified_edit').style.display = 'none';
                        document.getElementById('verifiedp4s2_save').style.display = 'none';
                    </script>
               </td>
               <td>
                   <div id="verifiedp4s3_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(202)%>" id="verifiedp4s3" />
                       </div>
                   <span id="verifiedp4s3_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('verified_edit').style.display = 'none';
                        document.getElementById('verifiedp4s3_save').style.display = 'none';
                    </script>
               </td>
               <td>
                   <div id="verifiedp4s4_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(203)%>" id="verifiedp4s4" />
                       </div>
                   <span id="verifiedp4s4_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('verified_edit').style.display = 'none';
                        document.getElementById('verifiedp4s4_save').style.display = 'none';
                    </script>
               </td>

               <td>
                   <input type="button" value="Save" onClick="verified_Save()" /> <input type="button" value="Cancel" onClick="verified_Cancel();"/>
                   <input type="hidden" name="verifiedid" value="12"/>
               </td>
           </tr>
            <tr id="closed_readonly">
               <td><B><%=statuses.get(13)%></B></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="closed_Edit();"> <div id="closedp1s1_readonly"><%=al.get(205)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="closed_Edit();"> <div id="closedp1s2_readonly"><%=al.get(206)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="closed_Edit();"> <div id="closedp1s3_readonly"><%=al.get(207)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="closed_Edit();"> <div id="closedp1s4_readonly"><%=al.get(208)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="closed_Edit();"> <div id="closedp2s1_readonly"><%=al.get(209)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="closed_Edit();"> <div id="closedp2s2_readonly"><%=al.get(210)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="closed_Edit();"> <div id="closedp2s3_readonly"><%=al.get(211)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="closed_Edit();"> <div id="closedp2s4_readonly"><%=al.get(212)%></div></td>

               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="closed_Edit();"> <div id="closedp3s1_readonly"><%=al.get(213)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="closed_Edit();"> <div id="closedp3s2_readonly"><%=al.get(214)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="closed_Edit();"> <div id="closedp3s3_readonly"><%=al.get(215)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="closed_Edit();"> <div id="closedp3s4_readonly"><%=al.get(216)%></div></td>

               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="closed_Edit();"> <div id="closedp4s1_readonly"><%=al.get(217)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="closed_Edit();"> <div id="closedp4s2_readonly"><%=al.get(218)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="closed_Edit();"> <div id="closedp4s3_readonly"><%=al.get(219)%></div></td>
               <td onmouseover="flashRow(this);" onmouseout="unFlashRow(this);" onClick="closed_Edit();"> <div id="closedp4s4_readonly"><%=al.get(220)%></div></td>

           </tr>

           <tr id="closed_edit">
                 <td><B><%=statuses.get(13)%></B></td>
               <td>
                   <div id="closedp1s1_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(205)%>" id="closedp1s1" />
                   </div>
                   <span id="closedp1s1_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('closed_edit').style.display = 'none';
                        document.getElementById('closedp1s1_save').style.display = 'none';
                    </script>
               </td>
               <td>
                   <div id="closedp1s2_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(206)%>" id="closedp1s2" />
                       </div>
                   <span id="closedp1s2_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('closed_edit').style.display = 'none';
                        document.getElementById('closedp1s2_save').style.display = 'none';
                    </script>
               </td>
               <td>
                   <div id="closedp1s3_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(207)%>" id="closedp1s3" />
                       </div>
                   <span id="closedp1s3_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('closed_edit').style.display = 'none';
                        document.getElementById('closedp1s3_save').style.display = 'none';
                    </script>
               </td>
               <td>
                   <div id="closedp1s4_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(208)%>" id="closedp1s4" />
                       </div>
                   <span id="closedp1s4_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('closed_edit').style.display = 'none';
                        document.getElementById('closedp1s4_save').style.display = 'none';
                    </script>
               </td>


               <td>
                   <div id="closedp2s1_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(209)%>" id="closedp2s1" />
                   </div>
                   <span id="closedp2s1_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('closed_edit').style.display = 'none';
                        document.getElementById('closedp2s1_save').style.display = 'none';
                    </script>
               </td>
               <td>
                   <div id="closedp2s2_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(210)%>" id="closedp2s2" />
                       </div>
                   <span id="closedp2s2_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('closed_edit').style.display = 'none';
                        document.getElementById('closedp2s2_save').style.display = 'none';
                    </script>
               </td>
               <td>
                   <div id="closedp2s3_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(211)%>" id="closedp2s3" />
                       </div>
                   <span id="closedp2s3_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('closed_edit').style.display = 'none';
                        document.getElementById('closedp2s3_save').style.display = 'none';
                    </script>
               </td>
               <td>
                   <div id="closedp2s4_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(212)%>" id="closedp2s4" />
                       </div>
                   <span id="closedp2s4_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('closed_edit').style.display = 'none';
                        document.getElementById('closedp2s4_save').style.display = 'none';
                    </script>
               </td>

               <td>
                   <div id="closedp3s1_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(213)%>" id="closedp3s1" />
                   </div>
                   <span id="closedp3s1_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('closed_edit').style.display = 'none';
                        document.getElementById('closedp3s1_save').style.display = 'none';
                    </script>
               </td>
               <td>
                   <div id="closedp3s2_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(214)%>" id="closedp3s2" />
                       </div>
                   <span id="closedp3s2_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('closed_edit').style.display = 'none';
                        document.getElementById('closedp3s2_save').style.display = 'none';
                    </script>
               </td>
               <td>
                   <div id="closedp3s3_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(215)%>" id="closedp3s3" />
                       </div>
                   <span id="closedp3s3_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('closed_edit').style.display = 'none';
                        document.getElementById('closedp3s3_save').style.display = 'none';
                    </script>
               </td>
               <td>
                   <div id="closedp3s4_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(216)%>" id="closedp3s4" />
                       </div>
                   <span id="closedp3s4_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('closed_edit').style.display = 'none';
                        document.getElementById('closedp3s4_save').style.display = 'none';
                    </script>
               </td>

                <td>
                   <div id="closedp4s1_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(217)%>" id="closedp4s1" />
                   </div>
                   <span id="closedp4s1_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('closed_edit').style.display = 'none';
                        document.getElementById('closedp4s1_save').style.display = 'none';
                    </script>
               </td>
               <td>
                   <div id="closedp4s2_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(218)%>" id="closedp4s2" />
                       </div>
                   <span id="closedp4s2_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('closed_edit').style.display = 'none';
                        document.getElementById('closedp4s2_save').style.display = 'none';
                    </script>
               </td>
               <td>
                   <div id="closep4s3_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(219)%>" id="closedp4s3" />
                       </div>
                   <span id="closedp4s3_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('closed_edit').style.display = 'none';
                        document.getElementById('closedp4s3_save').style.display = 'none';
                    </script>
               </td>
               <td>
                   <div id="closedp4s4_edit">
                       <input type="text"  size="1" maxlength="4" value="<%=al.get(220)%>" id="closedp4s4" />
                       </div>
                   <span id="closedp4s4_save" class="savingAjaxWithBackground">
                                            Saving...
                                            </span>
                    <script type="text/javascript">
                        document.getElementById('closed_edit').style.display = 'none';
                        document.getElementById('closedp4s4_save').style.display = 'none';
                    </script>
               </td>

               <td>
                   <input type="button" value="Save" onClick="closed_Save()" /> <input type="button" value="Cancel" onClick="closed_Cancel();"/>
                   <input type="hidden" name="closedid" value="13"/>
               </td>
           </tr>

       </table>
    </body>
</html>

<%-- 
    Document   : ermSearch
    Created on : Feb 17, 2014, 6:12:26 PM
    Author     : E0288
--%>

<%@page import="java.util.Map"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <%
        Logger logger = Logger.getLogger("ermSearch");
        String logoutcheck = (String) session.getAttribute("Name");
        if (logoutcheck == null) {
    %>
    <jsp:forward page="../SessionExpired.jsp"></jsp:forward>
    <%    }
    %>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS
            Solution</title>

        <LINK title=STYLE href="<%= request.getContextPath()%>/eminentech support files/main_ie.css" type="text/css" rel="STYLESHEET">
        <script type="text/javascript"	src="<%= request.getContextPath()%>/eminentech support files/datetimepicker.js"></script>
        <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/checkSubmit.js"></script>
        <script src="<%=request.getContextPath()%>/javaScript/XMLHttpRequest.js" type="text/javascript"></script>

        <script type="text/javascript">
            function changeUpdatedOn() {
                var modParam = document.getElementById('updated_param').value;
                if (modParam === "Between") {

                    document.getElementById('moddate').style.display = 'none';
                    document.getElementById('modifiedrange').style.display = 'block';
                } else {
                    document.getElementById('moddate').style.display = 'block';
                    document.getElementById('modifiedrange').style.display = 'none';
                }
            }
            function val(theForm) {
                disableSubmit();
            }
            var dtCh= "/";
            var minYear=1900;
        var maxYear=2100;
        var  xmlhttp = createRequest();
            function DaysArray(n)
        {
            for (var i = 1; i <= n; i++)
            {
		this[i] = 31;
		if (i===4 || i===6 || i===9 || i===11) {this[i] = 30;}
		if (i===2) {this[i] = 29;}
            }
            return this;
       }
            function trim(str)  {
  		while (str.charAt(str.length - 1)===" ")
                    str = str.substring(0, str.length - 1);
  		while (str.charAt(0)===" ")
                    str = str.substring(1, str.length);
  		return str;
            }
            function isValidIssue(str)  {
  		var pattern = "E1234567890";
  		var i = 0;
  		do  {
    		var pos = 0;
    		for (var j=0; j<pattern.length; j++)
      			if (str.charAt(i)===pattern.charAt(j)) {
					pos = 1;
       				break;
      			}
    			i++;
  		}
  		while (pos===1 && i<str.length)
  			if (pos===0)
    		return false;
  		return true;
	}
        function daysInFebruary(year)
            {
                return (((year % 4 == 0) && ((!(year % 100 == 0)) || (year % 400 == 0))) ? 29 : 28);
            }
            function isValidDate(dtStr)
        {
            var daysInMonth = DaysArray(12);
            var pos1=dtStr.indexOf(dtCh);
            var pos2=dtStr.indexOf(dtCh,pos1+1);
            var strMonth=dtStr.substring(3,5);
            var strDay=dtStr.substring(1,3);
            var strYear=dtStr.substring(5,9);
            strYr=strYear;
            if (strDay.charAt(0)==="0" && strDay.length>1) strDay=strDay.substring(1);
            if (strMonth.charAt(0)==="0" && strMonth.length>1) strMonth=strMonth.substring(1);
            for (var i = 1; i <= 3; i++)
            {
                if (strYr.charAt(0)==="0" && strYr.length>1) strYr=strYr.substring(1);
            }
            month=parseInt(strMonth);
            day=parseInt(strDay);
            year=parseInt(strYr);
            if (strMonth.length<1 || month<1 || month>12)
            {
		alert("Please enter a valid Month in the Issue No(EDDMMYYYY001)");
		return false;
            }
            if (strDay.length<1 || day<1 || day>31 || (month===2 && day>daysInFebruary(year)) || day > daysInMonth[month])
            {
		alert("Please enter a valid Day  in the Issue No(EDDMMYYYY001)");
		return false;
            }
            if (strYear.length !== 4 || year===0 || year<minYear || year>maxYear)
            {
		alert("Please enter a valid Year in the Issue No(EDDMMYYYY001)");
		return false;
            }
            var today=new Date;
            if(parseInt(today.getFullYear()) < year)
            {
		window.alert("Enter the valid Year in the Issue No(EDDMMYYYY001) ");
		return false;
            }
            if(parseInt(today.getFullYear()) === year)
            {
     //           alert(parseInt(today.getMonth())+1+"here"+month)
	    	if(month > (parseInt(today.getMonth())+1))
                {
	    		window.alert("Enter the valid Month in the Issue No(EDDMMYYYY001) ");
			return false;
	    	}
	    	if(month === (parseInt(today.getMonth())+1))
                {
                //alert(day+"here"+parseInt(today.getDate()));
	    		if(day > parseInt(today.getDate()))
                        {
	    			window.alert("Enter the valid Day in the Issue No(EDDMMYYYY001) ");
				return false;
	    		}
	    	}
	    }
            return true;
    }
    var apIdresp;
    function checkApId(apId){
        if(xmlhttp!==null){

                xmlhttp.open("GET","/eTracker/ERM/checkApplicantId.jsp?applicantId="+encodeURIComponent(apId)+"&rand="+Math.random(1,10), false);

                xmlhttp.onreadystatechange = function(){
                        callbackapid();
                    };
                xmlhttp.send(null);
                }else{
                    alert('no ajax request');
                }
    }
    function callbackapid(){
           
            if (xmlhttp.readyState === 4)
             {
                if (xmlhttp.status === 200)
                {
                    var comp = xmlhttp.responseText;
                    
                           apIdresp=   comp;   
                }
             }
    }
            function fun(issueSearch)  {
   		/** This Loop Checks Whether There Is Any Integer Present In The Company Field */

   		if (!isValidIssue(trim(document.getElementById('apid').value)))  {
   			alert('Enter Application Id in proper format like EDDMMYYYY001');
   			document.getElementById('apid').focus();
                        return false;
  		}
  		if (!isValidDate(trim(document.getElementById('apid').value)))  {
     
   			document.getElementById('apid').focus();
                        return false;
  		}


  		if ((trim(document.getElementById('apid').value).length)<12)  {
   			alert('Size of the Application Id should be 12 characters ');
                        document.getElementById('apid').focus();
    		return false;
  		}
  		if ((trim(document.getElementById('apid').value).length)>12)  {
   			alert('Size of the Application Id should be 12 characters ');
                        document.getElementById('apid').focus();
                        return false;
  		}

		if ((document.getElementById('apid').value===null)||(document.getElementById('apid').value===""))
		{
			alert("Please Enter the Application Id");
			 document.getElementById('apid').focus();
			return false;
		}
              	if (isValidDate(document.getElementById('apid').value)===false){
                    return false;
                }
                checkApId(document.getElementById('apid').value);
                if(trim(apIdresp)==="Ok"){
                    alert(document.getElementById('apid').value+' Not exists');
                    document.getElementById('apid').value='';
                    return false;
                }
                    
                 disableIssueSubmit();
                return true;
	}
        </script>
    </head>
    <body>
        <%@ include file="../header.jsp"%>
        <jsp:useBean id="es" class="com.eminentlabs.erm.ERMSearch"></jsp:useBean>
        <%
            es.setAll(request);
            logger.info(es.getSkill());
            logger.info(es.getStatus());
        %>
        <form name="issueSearch" onsubmit="return fun(this);" action="<%= request.getContextPath()%>/ERM/viewApplicantDetails.jsp">
            <table cellpadding="0" cellspacing="0" width="100%">
                <tr border="2" bgcolor="#C3D9FF">
                    <td border="1" align="left" width="30%">
                        <font size="4" COLOR="#0000FF"><b>Search ERM Issues </b></font>

                    </td>
                    <td> <b>Enter the Applicant Id:</b><input type="text" id="apid" name="apid" maxlength="12" size="15"><input type="submit" name="searchIssue" id="searchIssue" value="Search"></td>             
                </tr>

            </table>
        </form>
        <br/>
        <br/>
        <form name="theForm" id="theForm" onsubmit="return val(this);" method="post" action="<%=request.getContextPath()%>/ERM/ermSearchResults.jsp" >
            <%if (es.getErrorMessage() == null) {%>
            <table bgColor="#E8EEF7" style="width: 100%;" id="alingeaa">
                <tr style="height: 21px;font-weight: bold;">
                    <td>Skill</td>
                    <td>Module</td>
                    <td>Status</td>
                    <td>Ref By</td>
                </tr>
                <tr style="height: 21px;">
                    <td><select name="skill" id="skill">
                            <option value="" selected="">All Information</option>
                            <%for (String skill : es.getSkillsList()) {
                                if (es.getSkill() != null) {
                                    if (es.getSkill().equals(skill)) {%>
                            <option value="<%=skill%>" selected><%=skill%></option>
                            <%} else {%>
                            <option value="<%=skill%>"><%=skill%></option>
                            <%}
                            } else {
                            %>
                            <option value="<%=skill%>"><%=skill%></option>

                            <%}
                            }%>
                        </select>
                    </td>
                    <td><select name="module" id="module">
                            <option value="" selected="">All Information</option>
                            <%for (String module : es.getModulesList()) {
                                if (es.getModule() != null) {
                                    if (es.getModule().equals(module)) {%>
                            <option value="<%=module%>" selected><%=module%></option>
                            <%} else {%>
                            <option value="<%=module%>"><%=module%></option>
                            <%}
                            } else {
                            %>
                            <option value="<%=module%>"><%=module%></option>

                            <%}
                             }%>
                        </select>
                    </td>    
                    <td> <select name="status" id="status">
                            <option value="10" selected="">All Information</option>
                            <% for (Map.Entry<Integer, String> entry : es.getStatusList().entrySet()) {
                                if (es.getStatus() != 10) {
                                    if (es.getStatus().equals(entry.getKey())) {%>
                            <option value="<%=entry.getKey()%>" selected><%=entry.getValue()%></option>
                            <%} else {%>
                            <option value="<%=entry.getKey()%>"><%=entry.getValue()%></option>
                            <%}
                            } else {
                            %>
                            <option value="<%=entry.getKey()%>"><%=entry.getValue()%></option>
                            <%}
                           }%>
                        </select>
                    </td>
                    <td>
                        <select name="refEmp" id="refEmp"> 
                            <option value="" selected="">All Information</option>
                            <%
                            for (Map.Entry<String, String> entry : es.getRefByList().entrySet()) {
                                if (es.getRefBy() != null) {
                                    if (es.getRefBy().equals(entry.getKey())) {%>
                            <option value="<%=entry.getKey()%>" selected><%=entry.getValue()%></option>
                            <%} else {%>
                            <option value="<%=entry.getKey()%>"><%=entry.getValue()%></option>
                            <%}
                            } else {
                            %>
                            <option value="<%=entry.getKey()%>"><%=entry.getValue()%></option>
                            <%}
                           }%>
                        </select>
                    </td>

                </tr>
                <tr style="height: 21px;font-weight: bold;">
                    <td>UG</td>
                    <td>UG Year</td>
                    <td>PG</td>
                    <td>PG Year</td>
                </tr>
                <tr style="height: 21px;">
                    <td><select name="ug" id="ug">
                            <option value="" selected="">All Information</option>
                            <%
                            for (String ug : es.getUgList()) {
                                if (es.getUg() != null) {
                                    if (es.getUg().equals(ug)) {%>
                            <option value="<%=ug%>" selected><%=ug%></option>
                            <%} else {%>
                            <option value="<%=ug%>"><%=ug%></option>
                            <%}
                            } else {%>
                            <option value="<%=ug%>"><%=ug%></option>   
                            <% }}
                            %>

                        </select></td>
                    <td><select name="ugYear" id="ugYear">
                            <option value="0" selected="">All Information</option>
                            <%
                            for (String uy : es.getUgyearList()) {
                            if (es.getUgYear()!= null) {
                                    if (es.getUgYear().equals(uy)) {%>
                            <option value="<%=uy%>" selected><%=uy%></option>
                            <%} else {%>
                            <option value="<%=uy%>"><%=uy%></option>
                            <%}
                            } else {%>
                            <option value="<%=uy%>"><%=uy%></option>   
                            <% }}
                            %>
                        </select></td>
                    <td><select name="pg" id="pg">
                            <option value="" selected="">All Information</option>
                            <%
                            for (String pg : es.getPgList()) {
                            if (es.getPg() != null) {
                                    if (es.getPg().equals(pg)) {%>
                            <option value="<%=pg%>" selected><%=pg%></option>
                            <%} else {%>
                            <option value="<%=pg%>"><%=pg%></option>
                            <%}
                            } else {%>
                            <option value="<%=pg%>"><%=pg%></option>   
                            <% }}
                            %>
                        </select></td>
                    <td><select name="pgYear" id="pgYear">
                            <option value="0" selected="">All Information</option>
                            <%
                             for (String py : es.getPgyearList()) {
                            if (es.getPgYear()!= null) {
                                    if (es.getPgYear().equals(py)) {%>
                            <option value="<%=py%>" selected><%=py%></option>
                            <%} else {%>
                            <option value="<%=py%>"><%=py%></option>
                            <%}
                            } else {%>
                            <option value="<%=py%>"><%=py%></option>   
                            <% }}
                            %>

                        </select></td>
                </tr>
                <tr style="height: 21px;font-weight: bold;">
                    <td>Location</td>
                    <td>Total Exp</td>
                    <td>SAP Exp</td>
                    <td>Updated By</td>
                </tr>
                <tr style="height: 21px;">
                    <td><select name="location" id="location">
                            <option value="" selected="">All Information</option>
                            <%
                            for (String loc : es.getLocationList()) {
                            if (es.getLocation()!= null) {
                                    if (es.getLocation().equals(loc)) {%>
                            <option value="<%=loc%>" selected><%=loc%></option>
                            <%} else {%>
                            <option value="<%=loc%>"><%=loc%></option>
                            <%}
                            } else {%>
                            <option value="<%=loc%>"><%=loc%></option>   
                            <% }}
                            %>
                        </select></td>
                    <td><select name="tExp" id="tExp"> 
                            <option value="0" selected="">All Information</option>
                            <%
                            for (int tExp : es.gettExpList()) {
                            if (es.gettExp()!= 0) {
                                    if (es.gettExp().equals(tExp)) {%>
                            <option value="<%=tExp%>" selected><%=tExp%></option>
                            <%} else {%>
                            <option value="<%=tExp%>"><%=tExp%></option>
                            <%}
                            } else {%>
                            <option value="<%=tExp%>"><%=tExp%></option>   
                            <% }}
                            %>
                        </select></td>
                    <td><select name="sExp" id="sExp">
                            <option value="0" selected="">All Information</option>
                            <%
                            for (int sExp : es.getsExpList()) {
                            if (es.getsExp()!= 0) {
                                    if (es.getsExp().equals(sExp)) {%>
                            <option value="<%=sExp%>" selected><%=sExp%></option>
                            <%} else {%>
                            <option value="<%=sExp%>"><%=sExp%></option>
                            <%}
                            } else {%>
                            <option value="<%=sExp%>"><%=sExp%></option>   
                            <% }}
                            %>
                        </select></td>
                    <td><select name="updatedBy" id="updatedBy">
                            <option value="0" selected="">All Information</option>
                            <%
                            for (Map.Entry<Integer, String> entry : es.getUpdatedByList().entrySet()) {
                            if (es.getUpdatedBy()!= 0) {
                                    if (es.getUpdatedBy().equals(entry.getKey())) {%>
                            <option value="<%=entry.getKey()%>" selected><%=entry.getValue()%></option>
                            <%} else {%>
                            <option value="<%=entry.getKey()%>"><%=entry.getValue()%></option>
                            <%}
                            } else {%>
                            <option value="<%=entry.getKey()%>"><%=entry.getValue()%></option>
                            <% }}
                            %>
                        </select></td>
                </tr>
                <tr style="height: 21px;font-weight: bold;">
                    <td>Assigned To</td>
                    <td>CTC</td>
                    <td>Percentage</td>
                    <td>Updated<select id="updated_param" name="updated_param" onchange="javascript:changeUpdatedOn();">
                            <%
                             for (String up : es.getDataParamList()) {
                            if (es.getUpdatedParam()!= null) {
                                    if (es.getUpdatedParam().equals(up)) {
                            
                            %>
                            
                            <option value="<%=up%>" selected><%=up%></option>
                            
                            <%} else {%>
                            <option value="<%=up%>"><%=up%></option>
                            <%}
                            } else {%>
                            <option value="<%=up%>"><%=up%></option>   
                            <% }}
                            %>
                        </select></td>                
                </tr>
                <tr style="height: 21px;">
                    <td><select name="assignedTo" id="assignedTo">
                            <option value="0" selected="">All Information</option>
                            <%
                            for (Map.Entry<Integer, String> entry : es.getAssignedToList().entrySet()) {
                            if (es.getAssignedTo()!= null) {
                                    if (es.getAssignedTo().equals(entry.getKey())) {%>
                            <option value="<%=entry.getKey()%>" selected><%=entry.getValue()%></option>
                            <%} else {%>
                            <option value="<%=entry.getKey()%>"><%=entry.getValue()%></option>
                            <%}
                            } else {%>
                            <option value="<%=entry.getKey()%>"><%=entry.getValue()%></option>
                            <% }}
                            %>
                        </select></td>
                    <td><select name="CTC" id="CTC">
                            <option value="0" selected="">All Information</option>
                            <%
                             for (int CTC : es.getCtcList()) {
                            if (es.getCtc()!= 0) {
                                    if (es.getCtc().equals(CTC)) {%>
                            <option value="<%=CTC%>" selected><%=CTC%></option>
                            <%} else {%>
                            <option value="<%=CTC%>"><%=CTC%></option>
                            <%}
                            } else {%>
                            <option value="<%=CTC%>"><%=CTC%></option>   
                            <% }}
                            %>
                        </select></td>

                    <td><select name="percentage" id="percentage">
                            <option value="0" selected="">All Information</option>
                            <%
                            for (String per : es.getPercentageList()) {
                            if (es.getPer()!= null) {
                                    if (es.getPer().equals(per)) {%>
                            <option value="<%=per%>" selected><%=per%></option>
                            <%} else {%>
                            <option value="<%=per%>"><%=per%></option>
                            <%}
                            } else {%>
                            <option value="<%=per%>"><%=per%></option>   
                            <% }}
                            %>
                        </select></td>
                    <td><span id="moddate">
                            <%if (es.getUpdatedOn()!= null) {%>
                            <input type="Text" id="modifiedon" name="modifiedon"  readonly="true" maxlength="25" value="<%=es.getUpdatedOn()%>"	size="15"/><a href="javascript:NewCal('modifiedon','ddmmyyyy')"><img src="../images/newhelp.gif" width="16" height="16" border="0" alt="Pick a date"></a>
                            <%}else{%>
                            <input type="Text" id="modifiedon" name="modifiedon"  readonly="true" maxlength="25"	size="15"/><a href="javascript:NewCal('modifiedon','ddmmyyyy')"><img src="../images/newhelp.gif" width="16" height="16" border="0" alt="Pick a date"></a>
                        <%}%>
                            </span>
                            <span id="modifiedrange" style="display:none;">
                                <%if ((es.getUpdatedFrom() != null && !"".equals(es.getUpdatedFrom())) && (es.getUpdatedTo() != null && !"".equals(es.getUpdatedTo()))) {%>
                               <!-- edit by mukesh-->
                                <div>
                                <b>From:</b>    <input type="text" id="modifiedfrom" name="modifiedfrom" readonly="true" maxlength="25"	value="<%=es.getUpdatedFrom()%>" size="8"/><a href="javascript:NewCal('modifiedfrom','ddmmyyyy')"><img src="../images/newhelp.gif" width="16" height="16" border="0" alt="Pick a date"></a>
                                </div>
                                &nbsp;&nbsp;&nbsp;
                                <div style="margin-left: 13px;">
                            <b>To:</b><input type="text" id="modifiedto" name="modifiedto" readonly="true" maxlength="25" value="<%=es.getUpdatedTo()%>" size="8"/><a href="javascript:NewCal('modifiedto','ddmmyyyy')"><img src="../images/newhelp.gif" width="16" height="16" border="0" alt="Pick a date"></a>
                                </div>
                            <%}else{%>
                            <div>
                            <b>From:</b>    <input type="text" id="modifiedfrom" name="modifiedfrom" readonly="true" maxlength="25"	size="8"/><a href="javascript:NewCal('modifiedfrom','ddmmyyyy')"><img src="../images/newhelp.gif" width="16" height="16" border="0" alt="Pick a date"></a>
                            </div>
                            &nbsp;&nbsp;&nbsp;
                            <div style="margin-left: 13px">
                            <b>To: </b> <input type="text" id="modifiedto" name="modifiedto" readonly="true" maxlength="25"	size="8"/><a href="javascript:NewCal('modifiedto','ddmmyyyy')"><img src="../images/newhelp.gif" width="16" height="16" border="0" alt="Pick a date"></a>
                            </div>
                            <!-- edit by mukesh-->
                            <%}%>
                            
</span></td>
                </tr>
                
                 <tr style="height: 21px;font-weight: bold;">
                    <td>Employer</td>
                    <td>Client</td>
                    <td>Project</td>
                    <td>Ref By</td>
                </tr>
                <tr style="height: 21px;">
                    <td><select name="employer" id="employer" style="width: 250px;">
                            <option value="" selected="">All Information</option>
                            <%for (String employer : es.getEmployerList()) {
                                if (es.getEmployer()!= null) {
                                    if (es.getEmployer().equals(employer)) {%>
                            <option value="<%=employer%>" selected><%=employer%></option>
                            <%} else {%>
                            <option value="<%=employer%>"><%=employer%></option>
                            <%}
                            } else {
                            %>
                            <option value="<%=employer%>"><%=employer%></option>

                            <%}
                            }%>
                        </select>
                    </td>
                    <td><select name="client" id="client" style="width: 250px;">
                            <option value="" selected="">All Information</option>
                            <%for (String client : es.getClientList()) {
                                if (es.getClient()!= null) {
                                    if (es.getClient().equals(client)) {%>
                            <option value="<%=client%>" selected><%=client%></option>
                            <%} else {%>
                            <option value="<%=client%>"><%=client%></option>
                            <%}
                            } else {
                            %>
                            <option value="<%=client%>"><%=client%></option>

                            <%}
                             }%>
                        </select>
                    </td>    
                  
                    <td>
                        <select name="project" id="project" style="width: 250px;"> 
                            <option value="" selected="">All Information</option>
                            <%for (String project : es.getProjectList()) {
                                if (es.getProject()!= null) {
                                    if (es.getProject().equals(project)) {%>
                            <option value="<%=project%>" selected><%=project%></option>
                            <%} else {%>
                            <option value="<%=project%>"><%=project%></option>
                            <%}
                            } else {
                            %>
                            <option value="<%=project%>"><%=project%></option>

                            <%}
                             }%>
                        </select>
                    </td>

                </tr>
                
                <tr style="text-align: center;"><td colspan="3" >
                        <%if (es.getQueryId()!= 0l) {%>
                        <input type="hidden" name="editQueryId" value="<%=es.getQueryId()%>">
               <%}%>
                <input type="submit" id="submit" value="Search"></td></tr>
            </table>
        </form>
        <%} else {%>
        <div style="text-align: center;color: red;font-weight: bold;">Error Occurred Please Try to Refresh the page / Contact Administrator</div>

        <%}%>

    </body>
    <%if (es.getUpdatedParam()!= null) {
    if(es.getUpdatedParam().equals("Between")){
    %>
<script type="text/javascript">
                                changeUpdatedOn();
                            </script>
                            <%}}%>
                            <style>
                                #alingeaa td{
                                    vertical-align: top;
                                }
                            </style>
</html>

<%-- 
    Document   : viewPTC
    Created on : Dec 4, 2009, 11:21:13 PM
    Author     : Administrator
--%>
<%@page  import="com.pack.StringUtil,java.text.SimpleDateFormat,com.eminent.tqm.TqmUtil,com.eminent.tqm.TqmPtcm,com.eminent.util.GetProjectManager,com.eminent.util.GetProjects,com.eminent.util.GetProjectMembers,java.util.*,org.apache.log4j.*"%>
<%


        session.setAttribute("forwardpage","/admin/tqm/listPTC.jsp");



	//Configuring log4j properties


	Logger logger = Logger.getLogger("List PTC");


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
        <script type="text/javascript">

                /** Java Script Function For Trimming A String To Get Only The Required String Input */

	function trim(str)  {
  		while (str.charAt(str.length - 1)==" ")
    	str = str.substring(0, str.length - 1);
  		while (str.charAt(0)==" ")
    	str = str.substring(1, str.length);
  		return str;
	}

	/** Function To Check Whether There Is Any Integer Present In The Form Input From The User */

	function isPositiveInteger(str)  {
  		var pattern = "Q1234567890"
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
	var dtCh= "/";
        var minYear=1900;
        var maxYear=2100;

        function isInteger(s){
            var i;
            for (i = 0; i < s.length; i++)
            {
                var c = s.charAt(i);
                if (((c < "0") || (c > "9"))) return false;
            }
            return true;
        }

        function stripCharsInBag(s, bag)
        {
            var i;
            var returnString = "";
            for (i = 0; i < s.length; i++)
            {
                var c = s.charAt(i);
                if (bag.indexOf(c) == -1) returnString += c;
            }
            return returnString;
        }

        function daysInFebruary (year)
        {
            return (((year % 4 == 0) && ( (!(year % 100 == 0)) || (year % 400 == 0))) ? 29 : 28 );
        }
        function DaysArray(n)
        {
            for (var i = 1; i <= n; i++)
            {
		this[i] = 31
		if (i==4 || i==6 || i==9 || i==11) {this[i] = 30}
		if (i==2) {this[i] = 29}
            }
            return this
       }

        function isDate(dtStr)
        {
            var daysInMonth = DaysArray(12)
            var pos1=dtStr.indexOf(dtCh)
            var pos2=dtStr.indexOf(dtCh,pos1+1)
            var strMonth=dtStr.substring(3,5)
            var strDay=dtStr.substring(1,3)
            var strYear=dtStr.substring(5,9)
            strYr=strYear
            if (strDay.charAt(0)=="0" && strDay.length>1) strDay=strDay.substring(1)
            if (strMonth.charAt(0)=="0" && strMonth.length>1) strMonth=strMonth.substring(1)
            for (var i = 1; i <= 3; i++)
            {
                if (strYr.charAt(0)=="0" && strYr.length>1) strYr=strYr.substring(1)
            }
            month=parseInt(strMonth)
            day=parseInt(strDay)
            year=parseInt(strYr)
            if (strMonth.length<1 || month<1 || month>12)
            {
		alert("Please enter a valid Month in the Testcase ID(QDDMMYYYY001)")
		return false
            }
            if (strDay.length<1 || day<1 || day>31 || (month==2 && day>daysInFebruary(year)) || day > daysInMonth[month])
            {
		alert("Please enter a valid Day  in the Testcase ID(QDDMMYYYY001)")
		return false
            }
            if (strYear.length != 4 || year==0 || year<minYear || year>maxYear)
            {
		alert("Please enter a valid Year in the Testcase ID(QDDMMYYYY001)")
		return false
            }
            var today=new Date;
            if(parseInt(today.getFullYear()) < year)
            {
		window.alert("Enter the valid Year in the Testcase ID(QDDMMYYYY001) ");
		return false;
            }
            if(parseInt(today.getFullYear()) == year)
            {
     //           alert(parseInt(today.getMonth())+1+"here"+month)
	    	if(month > (parseInt(today.getMonth())+1))
                {
	    		window.alert("Enter the valid Month in the Testcase ID(QDDMMYYYY001) ");
			return false;
	    	}
	    	if(month == (parseInt(today.getMonth())+1))
                {
                //alert(day+"here"+parseInt(today.getDate()));
	    		if(day > parseInt(today.getDate()))
                        {
	    			window.alert("Enter the valid Day in the Testcase ID(QDDMMYYYY001) ");
				return false;
	    		}
	    	}
	    }
            return true
    }
                            /** Function To Validate The Input Form Data */

	function fun(theForm)  {
   		/** This Loop Checks Whether There Is Any Integer Present In The Company Field */

   		if (!isPositiveInteger(trim(theForm.testcaseid.value)))  {
   			alert('Enter Testcase ID in proper format like QDDMMYYYY001');
			document.theForm.testcaseid.value="";
   			theForm.testcaseid.focus();
                        return false;
  		}

  		if (!isDate(trim(theForm.testcaseid.value)))  {
			document.theForm.testcaseid.value="";
   			theForm.testcaseid.focus();
                        return false;
  		}
  		if ((trim(theForm.testcaseid.value).length)<12)  {
   			alert('Size of the Testcase ID should be 12 characters ');
  			document.theForm.testcaseid.value="";
                        theForm.testcaseid.focus();
                        return false;
  		}
  		if ((trim(theForm.testcaseid.value).length)>12)  {
   			alert('Size of the Testcase ID should be 12 characters ');
  			document.theForm.testcaseid.value="";
                        theForm.testcaseid.focus();
                        return false;
  		}

		if ((theForm.testcaseid.value==null)||(theForm.testcaseid.value==""))
		{
			alert("Please Enter the Testcase ID")
			theForm.testcaseid.focus()
			return false
		}
		if (isDate(theForm.testcaseid.value)==false){
                    return false
                }
                disableSubmit();
                return true;

	}
        function setFocus()  {
		document.theForm.testcaseid.focus();
	}

	window.onload = setFocus;
                function call(theForm)
                {
                var x = document.getElementById("pid").value;
                        theForm.action = 'listPTC.jsp?pid='+ x;
                        theForm.submit();
                }
    </script>
        <meta http-equiv="Content-Type" content="text/html">
         <title>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS Solution</title>
        <LINK title=STYLE  href="<%= request.getContextPath() %>/eminentech support files/main_ie.css" type="text/css" rel="STYLESHEET">
       <script type="text/javascript" src="<%= request.getContextPath() %>/javaScript/checkSubmit.js"></script>
    </head>
    <body>
        <!-- edit by mukesh -->
        <%                  String pid = request.getParameter("pid");
                            //Getting User Id and Role
                             Integer role = (Integer) session.getAttribute("Role");
                            Integer uid = (Integer) session.getAttribute("userid_curr");
                            int roleValue = role.intValue();
                            int uidValue = uid.intValue();
         //Displaying all the projects for Admin role
                            HashMap<String, String> projects = null;
                                if (roleValue == 1) {
                                    projects = GetProjectManager.getProjects();
                                } else {
                                    //Displaying only assigned projects to other roles
                                    projects = GetProjectManager.getUserProjects(uidValue);
                                }

                                Collection se1 = projects.keySet();
                               
        %>
      
        <table cellpadding="0" cellspacing="0" border="0" width="100%">
	<tr border="2" bgcolor="#C3D9FF">
             <form name="theForm" onsubmit="return fun(this)"  action="<%= request.getContextPath() %>/testcaseView.jsp">
		<td align="left" width="25%"><b> Project Test Cases</b></td>
                 <td align="right" width="15%"><b>Enter the Test case id:</b></td>
		<td align="left" width="5%"><input type="text" name="testcaseid" maxlength="12"
			size="15"></td>
                <td align="left"><input type="submit" id="submit" name="submit" value="Search"></td>
		                            </form>

                     <td style="width:40%;text-align:right; height: 20px;">
                               <form name="projectForm" id="projectForm" method="post" onsubmit="return fun(this);"><b>Project : </b> 
                   <select id="pid" name="pid" size=1 onchange="javascript:call(this.form)">                 
                        <%
                         Iterator iter3 = se1.iterator();
                                int projectId = 0;
                                while (iter3.hasNext()) {

                                    String key = (String) iter3.next();
                                    String nameofproject = (String) projects.get(key);
            //      logger.info("Userid"+key);
                                    //      logger.info("Name"+nameofuser);
                                    projectId = Integer.parseInt(key);
                        if (projectId == Integer.parseInt(pid)) {

                            %>
                            <option value="<%=pid%>" selected><%=nameofproject%></option>
                            <%
                            } else {     %>
                            <option value="<%=projectId%>"><%=nameofproject%></option>
                            <% } }%>
                        </select></form>  
                </td></tr></table>
                          <!-- edit by mukesh -->
        <%
            List l  =   null;
            try{
                int adminId =   GetProjectMembers.getAdminID();
                int userId  =   (Integer)session.getAttribute("uid");
                String pId  =   request.getParameter("pid");

               if(pId!=null){
                    l =TqmUtil.listProjectTC(Integer.parseInt(pId));
                }else{
                    l   =   TqmUtil.listUserPTC(userId);
                }
                int noOfRecords =   l.size();
                %>
                <br>
<table width="100%">
      
	<tr height="10">
		<td align="left" width="80%">This list shows <b> <%=noOfRecords %></b> Project Test Cases.</td>
                <td align="right"><a href="createPTC.jsp">Create Test Case</a></td>
	</tr>
</table>
<br>
<table width="100%">
    
    <tr bgcolor="#C3D9FF" width="100%">
        <td width="12%"><b>TestCaseId</b></td>
        <td width="12%"><b>Project</b></td>
        <td width="10%"><b>Module</b></td>
        <td width="18%"><b>Functionality</b></td>
        <td width="18%"><b>Description</b></td>
        <td width="18%"><b>Expected Result</b></td>
        <%
         if(adminId==userId){
        %>
        <td width="10%"><b>Createdby</b></td>
        <%}%>
    </tr>
    <%
     int k=1;
     String created   =  null;
     for (Iterator i = l.iterator(); i.hasNext();k++ ) {
            TqmPtcm t =(TqmPtcm)i.next();
            String ptcid     =   t.getPtcid();
            String func      =   t.getFunctionality();
            String desc      =   t.getDescription();
            String reslt     =   t.getExpectedresult();
            String project   =   GetProjects.getProjectName(((Integer)t.getPid()).toString());
            String module    =   GetProjects.getModuleName(((Integer)t.getMid()).toString());

            if(adminId==userId){
                created   =   GetProjectManager.getUserName(t.getCreatedby());
            }

 //           if(ptcid=="Q12052010002"){
                logger.info("PTC IC-->"+ptcid);
                logger.info("Fuction-->"+func);
                logger.info("Desc-->"+desc);
               
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

          if(( k % 2 ) != 0)
                {
%>
	<tr bgcolor="white" height="22">
		<%
                }
                else
                {
%>

	<tr bgcolor="#E8EEF7" height="22">
		<%
                }
%>
<td><a href="viewPTC.jsp?ptcID=<%=ptcid%>"><%=ptcid%> </a>
         <%if(!TqmUtil.isPtcExist(ptcid)){%>
         <img alt="Common Test Case" title="Common Test Case" src="<%=request.getContextPath()%>/images/tick.png">
         <%}%>
   </td>
        <td><%=project%></td>
        <td><%=module%></td>
        <td title="<%=StringUtil.encodeHtmlTag(funcTitle)%>"><%=StringUtil.encodeHtmlTag(func)%></td>
        <td title="<%=StringUtil.encodeHtmlTag(descTitle)%>"><%=StringUtil.encodeHtmlTag(desc)%></td>
        <td title="<%=StringUtil.encodeHtmlTag(rsltTitle)%>"><%=StringUtil.encodeHtmlTag(reslt)%></td>
        <%
         if(adminId==userId){
        %>
        <td><%=created%></td>
        <%}%>
    </tr>



               <%
                }
                }
            catch(Exception e){
                logger.error(e.getMessage());
                }
%>
    </table>
    </body>
</html>
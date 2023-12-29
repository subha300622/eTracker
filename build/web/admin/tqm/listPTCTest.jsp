<%-- 
    Document   : listPTCTest
    Created on : 31 Aug, 2011, 9:50:18 AM
    Author     : Tamilvelan
--%>

<%@page import="com.eminent.tqm.TqmTestcaseexecutionresult"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="com.eminent.tqm.TestCasePlan"%>
<%@page import="com.eminent.util.IssueDetails"%>
<%@page  import="com.pack.StringUtil,java.text.SimpleDateFormat,com.eminent.tqm.TqmUtil,com.eminent.tqm.TqmPtcm,com.eminent.util.GetProjectManager,com.eminent.util.GetProjects,com.eminent.util.GetProjectMembers,java.util.*,org.apache.log4j.*"%>
<%


        session.setAttribute("forwardpage","/admin/tqm/listPTCTest.jsp");



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
            
        <script src="<%= request.getContextPath() %>/javaScript/jquery.js" type="text/javascript" ></script>
        <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/tooltip.js"></script>
        <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.3.2/jquery.min.js" type="text/javascript"></script>
        <script type="text/javascript">
        $(document).ready(function(){
            $("#report tr:odd").addClass("expand");
            $("#report tr:even").addClass("collapse");
            $("#testcase tr:odd").hide();
            $("#testcase tr:even").show();
            $("#halfView").hide();

            $("#halfView").click(function(){
                $("#testcase tr:odd").hide();
                $("#testcase tr:even").show();
                $("#halfView").hide();
                $("#fullView").show();
                $(this).find(".arrow").toggleClass("up");
            });
            $("#fullView").click(function(){
                $("#testcase tr:odd").show();
                $("#testcase tr:even").hide();
                $("#fullView").hide();
                $("#halfView").show();
                $(this).find(".arrow").toggleClass("up");
            });
            //$("#report").jExpand();
        });
    </script>

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
        </script>
        <meta http-equiv="Content-Type" content="text/html">
         <title>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS Solution</title>
        <LINK title=STYLE  href="<%= request.getContextPath() %>/eminentech support files/main_ie.css" type="text/css" rel="STYLESHEET">
       <script type="text/javascript" src="<%= request.getContextPath() %>/javaScript/checkSubmit.js"></script>
    </head>
    <body>
        <form name="theForm" onsubmit="return fun(this)"  action="<%= request.getContextPath() %>/testcaseView.jsp">
        <table cellpadding="0" cellspacing="0" border="0" width="100%">
	<tr border="2" bgcolor="#C3D9FF">
		<td align="left" width="25%"><b> Project Test Cases</b></td>
                <td align="right" width="15%"><b>Enter the Test case id:</b></td>
		<td align="left" width="5%"><input type="text" name="testcaseid" maxlength="12" size="15"></td>
                <td align="left"><input type="submit" id="submit" name="submit" value="Search"></td>
                <td><font size="2" face="Verdana, Arial, Helvetica, sans-serif">Export to 
                        <a  href="<%=request.getContextPath()%>/admin/tqm/myTestCaseToExcel.jsp"
                                    target="_blank">Excel</a></font></td>
                <td id="fullView" style="cursor:pointer;width: 55px;"><b>Expand</b></td>
                <td id="halfView" style="cursor:pointer;width: 55px;" align="right"><b>Collapse</b></td>
	</tr>
       
        </table>
        </form>
        <%
            int userId  =   (Integer)session.getAttribute("uid");
            String pageNo =   request.getParameter("pageId");
            int noOfTC      =   TqmUtil.countUserTestcases(userId);
            int pageone=noOfTC/15;
            int pageremain=noOfTC%15;
            
            int totalpage   =   1;
            if(pageremain>0)
            {
                    totalpage=pageone+1;
            }
            else
            {
                    totalpage=pageone;
            }
            logger.info("Total no of pages"+totalpage);
            int pageId  =1;
            if(pageNo!=null){
                pageId  = Integer.parseInt(pageNo);
            }
            int toValue     =   pageId*15;
            int fromValue   =   toValue-14;
            
            if( toValue>noOfTC){
                toValue=noOfTC;
            }
            String nextline="\n",fun_substr;
            HashMap <String,String> testCaseStatus=IssueDetails.getTestCaseStatus();
            HashMap statusMap   =   TestCasePlan.getTescaseStatus();
            
            List l  =   null;
            List<String> ptcIdList=new ArrayList<String>();
            try{
                int adminId =   GetProjectMembers.getAdminID();
                
                String pId  =   request.getParameter("pid");

               if(pId!=null){
                    l =TqmUtil.listProjectTC(Integer.parseInt(pId));
                }else{
                    l   =   TqmUtil.listUserPTCTest(userId,pageId);
                }
                int noOfRecords =   l.size();
                HashMap issueTestCaseMap=new HashMap();
                if(l!=null){
                    int a=0;
                    for (Iterator it = l.iterator(); it.hasNext();a++ ) {
                        TqmPtcm t =(TqmPtcm)it.next();
                        String ptcid     =   t.getPtcid();
                        ptcIdList.add(ptcid);
                    }
                    if(ptcIdList!=null && !ptcIdList.isEmpty()){
                        issueTestCaseMap=TestCasePlan.getAllIssueId(ptcIdList);
                    }
                }
                
                 
                %>
                <br>
<table width="100%" id="full">

	<tr height="10">
		<td align="left" width="80%">This list shows <b> <%=fromValue %> - <%=toValue%></b> of <b><%=noOfTC%></b> Project Test Cases.</td>
                <td align="right"><a href="createPTC.jsp">Create Test Case</a></td>
                
	</tr>
</table>
<br>

<table width="100%" id="testcase">
 <tr bgcolor="#C3D9FF" >
        <td width="6%"><b>TestCaseId</b></td>
        <td width="10%"><b>Project</b></td>
        <td width="10%"><b>Module</b></td>
        <td><b>Status</b></td>
        <td width="18%"><b>Functionality</b></td>
        <td width="20%"><b>Description</b></td>
        <td width="20%"><b>Expected Result</b></td>
        <%
         if(adminId==userId){
        %>
        <td width="10%"><b>Createdby</b></td>
        <%}%>
       
    </tr>
  <tr bgcolor="#C3D9FF" >
        <td width="6%"><b>TestCaseId</b></td>
        <td width="10%"><b>Project</b></td>
        <td width="10%"><b>Module</b></td>
         <td><b>Status</b></td>
        <td width="18%"><b>Functionality</b></td>
        <td width="20%"><b>Description</b></td>
        <td width="20%"><b>Expected Result</b></td>
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
 //               logger.info("PTC IC-->"+ptcid);
 //               logger.info("Fuction-->"+func);
 //               logger.info("Desc-->"+desc);

   //         }

            java.util.Date date =t.getCreatedon();
            SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yy HH:mm:ss");
            String requestedOn  =   sdf.format(date);
            String issueid="";
            if(issueTestCaseMap.get(ptcid)!=null){
                    issueid=(String)issueTestCaseMap.get(ptcid);
            }
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
//                 logger.info("Result-->"+reslt);
//                logger.info("Project-->"+project);
//                logger.info("Created-->"+created);

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
<td><a title="<%=issueid%>"  href="viewPTC.jsp?ptcID=<%=ptcid%>"><%=ptcid%> </a>
         <%if(!TqmUtil.isPtcExist(ptcid)){%>
         <img alt="Common Test Case" title="Common Test Case" src="<%=request.getContextPath()%>/images/tick.png">
         <%}%>
   </td>
        <td><%=project%></td>
        <td><%=module%></td>
        <%
         String statuses="";
         String plan="";
         
         List total     =   TestCasePlan.getResults(ptcid);
         
         Iterator iter = total.iterator();
                            while(iter.hasNext()){
                                List<TqmTestcaseexecutionresult> result       =  null;
                                Object[] obj      = (Object[]) iter.next();
                                int tceId         =  ((BigDecimal)obj[0]).intValue();
                                int tepId         =  ((BigDecimal)obj[1]).intValue();
                                String planName   =  ((String)obj[2]);
                                logger.info("Plan Name"+planName);
                                result    =   TestCasePlan.getExecutionResults(ptcid, ((Integer)tceId).toString());
                                int size       =    result.size();
                                
     for (TqmTestcaseexecutionresult te:result) {
            String status       =   (String)statusMap.get(te.getStatusid());
            statuses=statuses+status+",";
            plan=plan+planName+",";
                            }
     }
                 if(testCaseStatus.get(ptcid)!=null){
                   statuses=statuses+testCaseStatus.get(ptcid)+",";
                }else{
                    statuses=statuses+"Yet to Test"+",";
                }
        
        String pn[]= plan.split(",");
       String st[]= statuses.split(",");
       String wholeStatus="";
       for(int j=0;j<st.length;j++){
           if(plan.length()!=0){
            if(st.length-1!=j){
               wholeStatus=wholeStatus+pn[j]+"# <b>"+st[j]+"</b><br/>";
            }else{
                wholeStatus=wholeStatus+st[j];
            }
           }else{
               wholeStatus=wholeStatus+st[j];
           }
       }
       String idge=k+"tab";
   %>
        <td id="<%=idge%>" onmouseover="xstooltip_show('<%=k%>', '<%=idge%>', 220, 30);" onmouseout="xstooltip_hide('<%=k%>');">
            <%=TestCasePlan.getFinalizedStatus(statuses)%>
            <div class="issuetooltip" id="<%=k%>"><%= wholeStatus%></div>
        </td>
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
        int funclen = funcTitle.length();
        String func1 = null;
            int index=0;
            int funcCutLength=30;
            if(funclen>=funcCutLength)
            {
 //               logger.info("Start"+funcTitle);
                   func1=funcTitle.substring(index,index+funcCutLength);
                   funclen=funclen-funcCutLength;
                   while((funclen/funcCutLength)>=1)
                   {
                         func1=func1.concat(nextline);
                         index=index+funcCutLength;
                         fun_substr=funcTitle.substring(index,index+funcCutLength);
                         func1=func1.concat(fun_substr);
                         funclen=funclen-funcCutLength;
     //                    logger.info("Start Functionality"+funcTitle);
                   }
                   index=index+funcCutLength;
                   func1=func1.concat(nextline);
                   func1=func1.concat(funcTitle.substring(index));
            }
            else
            {
                    func1=funcTitle.substring(index);
  //                  logger.info("Else"+func1);
            }
  //          logger.info("test case functionality"+func1);
            index=0;
            String desc1 = null,desc_substr=null;
            int desclen = descTitle.length();
            int descCutLength =   35;
            if(desclen>=descCutLength)
            {
                   desc1=descTitle.substring(index,index+descCutLength);
                   desclen=desclen-descCutLength;
                   while((desclen/descCutLength)>=1)
                   {
                         desc1=desc1.concat(nextline);
                         index=index+descCutLength;
                         desc_substr=descTitle.substring(index,index+descCutLength);
                         desc1=desc1.concat(desc_substr);
                         desclen=desclen-descCutLength;
     //                    System.out.println("Start Description"+desc1);
                   }
                   index=index+descCutLength;
                   desc1=desc1.concat(nextline);
                   desc1=desc1.concat(descTitle.substring(index));
   //                System.out.println("Final Description"+desc1);
            }
            else
            {
                    desc1=descTitle.substring(index);
            }
            int resultCutLength =   35;
            String reslt1 = null,reslt_substr=null;
            int resltlen = rsltTitle.length();
            index=0;
            if(resltlen>=resultCutLength)
            {
                   reslt1=rsltTitle.substring(index,index+resultCutLength);
                   resltlen=resltlen-resultCutLength;
                   while((resltlen/resultCutLength)>=1)
                   {
                         reslt1=reslt1.concat(nextline);
                         index=index+resultCutLength;
                         reslt_substr=rsltTitle.substring(index,index+resultCutLength);
                         reslt1=reslt1.concat(reslt_substr);
                         resltlen=resltlen-resultCutLength;
                   }
                   index=index+resultCutLength;
                   reslt1=reslt1.concat(nextline);
                   reslt1=reslt1.concat(rsltTitle.substring(index));
            }
            else
            {
                    reslt1=rsltTitle.substring(index);
            }
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
		
<td><a title="<%=issueid%>" href="viewPTC.jsp?ptcID=<%=ptcid%>"><%=ptcid%> </a>
         <%if(!TqmUtil.isPtcExist(ptcid)){%>
         <img alt="Common Test Case" title="Common Test Case" src="<%=request.getContextPath()%>/images/tick.png">
         <%}%>
   </td>
        <td><%=project%></td>
        <td><%=module%></td>
        
        <td title="<%=wholeStatus%>">
            <%=TestCasePlan.getFinalizedStatus(statuses)%>
            
        </td>
        <td title="<%=StringUtil.encodeHtmlTag(funcTitle)%>"><%=StringUtil.encodeHtmlTag(func1)%></td>
        <td title="<%=StringUtil.encodeHtmlTag(descTitle)%>"><%=StringUtil.encodeHtmlTag(desc1)%></td>
        <td title="<%=StringUtil.encodeHtmlTag(rsltTitle)%>"><%=StringUtil.encodeHtmlTag(reslt1)%></td>
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
    <table align="right">
        <tr>
            <td>
                <%if(pageId>1){%>
                <a href="<%=request.getContextPath()%>/admin/tqm/listPTCTest.jsp?pageId=<%=1%>">First</a>
                <%}else{%>
                First
                <%}%>
            </td>
            <td>
                 <%if(pageId>1){%>
                <a href="<%=request.getContextPath()%>/admin/tqm/listPTCTest.jsp?pageId=<%=(pageId-1)%>">Previous</a>
                <%}else{%>
                Previous
                <%}%>
            </td>
            <td> <%if(pageId>0&&pageId<totalpage){%>
                <a href="<%=request.getContextPath()%>/admin/tqm/listPTCTest.jsp?pageId=<%=(pageId+1)%>">Next</a>
                <%}else{%>
                Next
                <%}%></td>
            <td>
                 <%if(pageId<totalpage){%>
                <a href="<%=request.getContextPath()%>/admin/tqm/listPTCTest.jsp?pageId=<%=totalpage%>">Last</a>
                <%}else{%>
                Last
                <%}%>
            </td>
        </tr>
    </table>
    </body>
</html>
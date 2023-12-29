<%-- 
    Document   : listTestCases
    Created on : 9 Jul, 2010, 6:52:26 PM
    Author     : Tamilvelan
--%>

<%@page import="com.eminentlabs.mom.MoMUtil"%>
<%@page  import="com.pack.StringUtil,org.apache.log4j.*,java.util.List,java.util.Iterator,com.eminent.tqm.TqmPtcm,com.eminent.tqm.TqmTestcaseexecution,com.eminent.tqm.TqmUtil,com.eminent.tqm.TestCasePlan,com.eminent.util.GetProjectMembers,com.eminent.util.GetProjects,com.eminent.util.GetProjectManager,java.text.SimpleDateFormat"%>
<%
session.setAttribute("forwardpage","/MyAssignment/listTestCases.jsp");
//Configuring log4j properties
	Logger logger = Logger.getLogger("MyAssignment - listTestCases");

	String logoutcheck=(String)session.getAttribute("Name");
	if(logoutcheck==null)
	{
		logger.fatal("=========================Session Expired======================");
		%>
<jsp:forward page="../SessionExpired.jsp"></jsp:forward>
<%
        }
%>

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
        /** Function To Set Focus On The First Name Field In The Form */

	function setFocus()  {
		document.theForm.testcaseid.focus();
	}

	window.onload = setFocus;
        </script>
        <title>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS Solution</title>
        <LINK title=STYLE  href="<%= request.getContextPath() %>/eminentech support files/main_ie.css" type="text/css" rel="STYLESHEET">
       <script type="text/javascript" src="<%= request.getContextPath() %>/javaScript/checkSubmit.js"></script>
    </head>
    <body>
       <%



%>
<form name="theForm" onsubmit="return fun(this)"  action="<%= request.getContextPath() %>/testcaseView.jsp">
<table cellpadding="0" cellspacing="0" width="100%">
	<tr bgcolor="#C3D9FF">
		<td align="left" width="25%"><b> Execution Plan Test Cases</b></td>
                <td align="right" width="15%"><b>Enter the Test case id:</b></td>
		<td align="left" width="5%"><input type="text" name="testcaseid" maxlength="12" size="15"></td>
                <td align="left"><input type="submit" id="submit" name="submit" value="Search"></td>

		
	</tr>

        </table>
</form>
        <%

            try{
                long startTime  =   System.currentTimeMillis();
                String status   =   request.getParameter("status");
                int adminId     =   GetProjectMembers.getAdminID();
                int userId      =   (Integer)session.getAttribute("uid");
  //              List ptc        =   TestCasePlan.listUserExecution(userId);
               if(request.getParameter("userId")!=null){
                   userId=MoMUtil.parseInteger(request.getParameter("userId"),userId);
               }
                String testCases[][]    =   TestCasePlan.listUserExecutionJDBC(userId);
                 int noOfRecords =   testCases.length;

                %>
                <br>
                <table cellpadding="0" cellspacing="0" width="100%">
	<tr border="2" >
		<td align="left">This list shows <b><%=noOfRecords%></b> Test Cases assigned to you</td>

	</tr>

        </table>
<br>
<%if(noOfRecords>0){%>
<table width="100%">

    <tr bgcolor="#C3D9FF" >
        <td width="7%"><b>TestCaseId</b></td>
        <td width="9%"><b>Module</b></td>
        <td width="10%"><b>TestPlan</b></td>
        <td width="18%"><b>Functionality</b></td>
        <td width="18%"><b>Description</b></td>
        <td width="18%"><b>Expected Result</b></td>
        <td width="8%"><b>Status</b></td>
        <td width="8%"><b>Createdby</b></td>
        <td width="4%"><b>DueDate</b></td>
    </tr>
    <%
    
     String created   =  null;
     TqmTestcaseexecution t     =   null;

     for ( int k=0;noOfRecords>k;k++ ) {
            String tceId     =   testCases[k][0];
            String ptcid     =   testCases[k][1];
            String project   =   testCases[k][2];
            String version   =   testCases[k][3];
            String module    =   testCases[k][4];
            String tp        =   testCases[k][5];
            String func      =   testCases[k][6];
            String desc      =   testCases[k][7];
            String reslt     =   testCases[k][8];
            created          =   testCases[k][9];
            String testcasestatus   =   testCases[k][10];
            String statusId  =   testCases[k][11];
            String dueDate   =   testCases[k][12];
            
          
            project=project+" v"+version;
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

                String color    =   "white";
          if(( k % 2 ) != 0)
                {
                    color   =   "#E8EEF7";
                }
                else
                {
                    color   =   "white";
                }
%>
<tr bgcolor="<%=color%>" height="22">
        <td><a href="<%=request.getContextPath()%>/admin/tqm/runTestcases.jsp?ptcID=<%=ptcid%>&statusId=<%=statusId%>&tceId=<%=tceId%>&assignedto=<%=userId%>"><%=ptcid%></a></td>
        <td title="Project : <%=project%>"><%=module%></td>
          <td><%=tp%></td>
        <td title="<%=StringUtil.encodeHtmlTag(funcTitle)%>"><%=StringUtil.encodeHtmlTag(func)%></td>
        <td title="<%=StringUtil.encodeHtmlTag(descTitle)%>"><%=StringUtil.encodeHtmlTag(desc)%></td>
        <td title="<%=StringUtil.encodeHtmlTag(rsltTitle)%>"><%=StringUtil.encodeHtmlTag(reslt)%></td>
        <td><%=testcasestatus%></td>
        <td><%=created%></td>
         <td><%=dueDate%></td>
    </tr>



               <%
                }
     %>
     </table>
    
     <%
     long endTime  =   System.currentTimeMillis();
     logger.info("Time taken for displaying test cases"+(endTime-startTime)/1000);
     }else{
%>
            <jsp:forward page="/MyAssignment/UpdateIssue.jsp"></jsp:forward>
<%
     }
                }
            catch(Exception e){
                logger.error(e.getMessage());
                }
%>

    

    </body>
</html>



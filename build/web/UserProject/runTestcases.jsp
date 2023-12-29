<%-- 
    Document   : runTestcases
    Created on : 8 Jul, 2010, 9:17:34 AM
    Author     : Tamilvelan
--%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<%@page  import="com.eminent.tqm.FileAttach,com.eminent.tqm.TqmTestcaseexecution,com.eminent.util.GetProjectMembers,java.util.*,java.sql.Timestamp,java.text.SimpleDateFormat,com.eminent.tqm.TestCasePlan,com.eminent.tqm.TqmTestcaseresult, com.eminent.tqm.TqmPtcm, com.eminent.util.GetProjectManager,com.eminent.util.GetProjects,java.util.*,org.apache.log4j.*"%>
<%@ include file="/header.jsp"%>
<%
        response.setHeader("Cache-Control","no-cache");
        response.setHeader("Cache-Control","no-store");
        response.setDateHeader("Expires", 0);
        response.setHeader("Pragma","no-cache");

		

		Logger logger = Logger.getLogger("Run Test case");
		
		String logoutcheck=(String)session.getAttribute("Name");
		if(logoutcheck==null)
		{
			logger.fatal("==============Session Expired===============");
		%>
<jsp:forward page="../SessionExpired.jsp"></jsp:forward>
<%
		}

%>
<html>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
       <LINK title=STYLE href="<%=request.getContextPath()%>/eminentech support files/main_ie.css" type="text/css" rel=STYLESHEET>
       <TITLE>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS Solution</TITLE>
       <script type="text/javascript" src="<%= request.getContextPath() %>/javaScript/checkSubmit.js"></script>
       <script type="text/javascript" src="<%= request.getContextPath() %>/ckeditor_4.5.9_standard/ckeditor/ckeditor.js"></script>
    <script type="text/javascript">
     function editorTextCounter(field,cntfield,maxlimit)
        {
            if (field > maxlimit)
            {

                    if (maxlimit==2000)
                        alert('Comments size is exceeding 2000 characters');
                    else
                        alert('Comments size is exceeding 2000 characters');
            }
            else
                    cntfield.value = maxlimit - field;
        }
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
  		var pattern = "E1234567890"
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
		alert("Please enter a valid Month in the Issue #(EDDMMYYYY001)")
		return false
            }
            if (strDay.length<1 || day<1 || day>31 || (month==2 && day>daysInFebruary(year)) || day > daysInMonth[month])
            {
		alert("Please enter a valid Day  in the Issue #(EDDMMYYYY001)")
		return false
            }
            if (strYear.length != 4 || year==0 || year<minYear || year>maxYear)
            {
		alert("Please enter a valid Year in the Issue #(EDDMMYYYY001)")
		return false
            }
            var today=new Date;
            if(parseInt(today.getFullYear()) < year)
            {
		window.alert("Enter the valid Year in the Issue #(EDDMMYYYY001) ");
		return false;
            }
            if(parseInt(today.getFullYear()) == year)
            {
     //           alert(parseInt(today.getMonth())+1+"here"+month)
	    	if(month > (parseInt(today.getMonth())+1))
                {
	    		window.alert("Enter the valid Month in the Issue #(EDDMMYYYY001) ");
			return false;
	    	}
	    	if(month == (parseInt(today.getMonth())+1))
                {
                //alert(day+"here"+parseInt(today.getDate()));
	    		if(day > parseInt(today.getDate()))
                        {
	    			window.alert("Enter the valid Day in the Issue #(EDDMMYYYY001) ");
				return false;
	    		}
	    	}
	    }
            return true
    }
    function createRequest(){
		var reqObj = null;
		try {
		   reqObj = new ActiveXObject("Msxml2.XMLHTTP");
		}
		catch (err) {
		   try {
			reqObj = new ActiveXObject("Microsoft.XMLHTTP");
		   }
		   catch (err2) {
				try {
				   reqObj = new XMLHttpRequest();
				}
				catch (err3) {
				  reqObj = null;
				}
	   		}
		}
		return reqObj;
	}
     function validateIssue(){
       xmlhttp = createRequest();
       var status   =   false;
        if(xmlhttp!=null){
            var issueid=document.getElementById("issueid").value;
            var pid=document.getElementById("pid").value;
            xmlhttp.open("GET","${pageContext.servletContext.contextPath}/admin/tqm/validateIssue.jsp?issueid="+issueid+"&pid="+pid+"&rand="+Math.random(1,10), false);

            xmlhttp.onreadystatechange = function(){
            if (xmlhttp.readyState == 4&&xmlhttp.status == 200)
            {
                   
                    var result = xmlhttp.responseText;
                    var last    =   result.length;
                  
                    result  =   result.substring(result.indexOf('-')+1, result.lastIndexOf('-'));
           
                if(trim(result)=='Valid Issue'){
               
                status  = true;
                }else{
                    alert(result);
                    status  = false;
                }


            }
            }
            xmlhttp.send(null);
        }
        return status;
    }
    
       function fun(theForm){
         var status = document.getElementById('status').value;
         if(status==3){
             if(document.getElementById('issueidrow')==null){
                 
             }else{

   		/** This Loop Checks Whether There Is Any Integer Present In The Company Field */
                if ((theForm.issueid.value==null)||(theForm.issueid.value==""))
		{
			alert("Please Enter the Reference Issue Number. If No Issue available Please Create an Issue")
			theForm.issueid.focus()
			return false
		}

   		if (!isPositiveInteger(trim(theForm.issueid.value)))  {
   			alert('Enter Issue # in proper format like EDDMMYYYY001');
			document.theForm.issueid.value="";
   			theForm.issueid.focus();
    		return false;
  		}

  		if (!isDate(trim(theForm.issueid.value)))  {
			document.theForm.issueid.value="";
   			theForm.issueid.focus();
    		return false;
  		}
  		if ((trim(theForm.issueid.value).length)<12)  {
   			alert('Size of the Issue # should be 12 characters ');
  			document.theForm.issueid.value="";
    		theForm.issueid.focus();
    		return false;
  		}
  		if ((trim(theForm.issueid.value).length)>12)  {
   			alert('Size of the Issue # should be 12 characters ');
  			document.theForm.issueid.value="";
    		theForm.issueid.focus();
    		return false;
  		}
	
		if (isDate(theForm.issueid.value)==false){
                    return false;
                }
                var stat    =   validateIssue();
             
                if (stat==false)  {
                  
                    theForm.issueid.focus();
                    return false;
  		}
                
             }
         }
        if (trim(CKEDITOR.instances.comments.getData()) == "")
        {
            alert ("Please Enter the Comments");
            CKEDITOR.instances.comments.focus();
            return false;
        }
        if (CKEDITOR.instances.comments.getData().length>2000)
        {
            alert (" Comments exceeds 2000 character");
            CKEDITOR.instances.comments.focus();
            return false;
        }
        monitorSubmit();
       }
       function textCounter(field,cntfield,maxlimit) {
            if (field.value.length > maxlimit)
            {
                    field.value = field.value.substring(0, maxlimit);
                    alert('Description size is exceeding 2000 characters');
            }
            else{
                    cntfield.value = maxlimit - field.value.length;
            }
       }
       function addRow(tablename) {
                        var status = document.getElementById('status').value;

      //                  alert("Table-->"+tablename);
                         var table = document.getElementById(tablename);
                            var rowCount = table.rows.length;
      //                       alert("No of Rows"+rowCount);
                             var issueIdRow  =   rowCount-2;
      //                       alert("Deletable Rows"+issueIdRow);
                           

                        if(status==3){
                           
                             var row1 = table.insertRow(rowCount-1);
                            rowCount=rowCount-1;
                            row1.id="issueidrow";
                            var cell1 =document.createElement('td');
                            cell1.setAttribute("cellpadding", 3)
                            cell1.id="issulableid";
                            var theBoldBit = document.createElement('b');
                            var lable1=document.createTextNode('Issue Id');

                            theBoldBit.appendChild(lable1);
                            cell1.appendChild(theBoldBit);
                            
                            var issueRelated   =   document.getElementById('relatedissue').value;
       //                     alert(issueRelated);

                            var cell2 = document.createElement('td');
                            cell2.align="left";
                            var issue = document.createElement("input");
                            issue.name="issueid";
                            issue.id="issueid";
                            issue.size="15";
                            if(issueRelated=='NA'){

                            }else{
                                issue.value=issueRelated;
                            }
                            issue.setAttribute("maxlength", 12);
                           




                            row1.appendChild(cell1);
                            row1.appendChild(cell2);

                            var cell3 = document.createElement('td');
                            cell3.align="left";

                            var link =document.createElement('a');
                            link.href="javascript:void(0);"
                            var text=document.createTextNode('Create New Reference Issue');
                            link.onclick=new Function("javascript:addIssue();");
                            link.appendChild(text);
                           
                            cell2.appendChild(issue);
                             cell2.appendChild(link);
   //                         cell3.appendChild(link);

     //                       row1.appendChild(cell3);


                    }else{
                        if(document.getElementById('issueidrow')==null){
     //                       alert('Issue Id is not captured');
                        }else{
                            table.deleteRow(issueIdRow);
     //                        alert('Deleting Row'+issueIdRow);
                        }
                    }
                        

		}
                function addIssue(){
                    var project = document.getElementById('project').value;
                    var module = document.getElementById('module').value;
                    var version = document.getElementById('version').value;
                    var ptcid=document.getElementById("ptcid").value;
                    window.open("<%=request.getContextPath() %>/admin/tqm/createTestIssues.jsp?project="+project+"&version="+version+"&module="+module+"&ptcid="+ptcid,"Ratting");
                }

        </script>
    </head>
    <body>
        <FORM name="theForm" onsubmit='return fun(this)' action="<%=request.getContextPath() %>/admin/tqm/updateTestCase.jsp" method="post">
            <table width="100%">
            <tr bgcolor="#C3D9FF" >
                <td width="100%"> <b>Test Case Details</b></td>
                            </tr>
        </table>
        <br>
        <br>

       <%
                long startTime  =   System.currentTimeMillis();
                String ptcID    =request.getParameter("ptcID");
                int statId    =   Integer.parseInt(request.getParameter("statusId"));
                int tceId    =   Integer.parseInt(request.getParameter("tceId"));
                String issueId    =   request.getParameter("issueid");
                String assignedto =   request.getParameter("assignedto");
               
                String relatedIssue =   TestCasePlan.getIssueID(ptcID);
                 logger.info("Related Issue"+relatedIssue);
                if(relatedIssue==null){
                    relatedIssue    =   "NA";
                }else if(TestCasePlan.isIssueClosed(relatedIssue)){
                    relatedIssue    =   "NA";
                }
                TqmTestcaseexecution ptc=TestCasePlan.viewExecutionTestcase(((Integer)tceId).toString(), ptcID);

              try{
                    if(ptc!=null){
                        String functionality    =   ptc.getPtcid().getFunctionality();
                        String ptcId            =   ptc.getPtcid().getPtcid();
                        String desc             =   ptc.getPtcid().getDescription();
                        String expected         =   ptc.getPtcid().getExpectedresult();
                        String createdBy        =   GetProjectManager.getUserName(ptc.getPtcid().getCreatedby());
                        String pId              =   ptc.getPtcid().getPid().toString();
                        String projectName      =   GetProjects.getProjectName(pId);
                        String moduleName       =   GetProjects.getModuleName(ptc.getPtcid().getMid().toString());
                        String planName         =   ptc.getTqmTestcaseexecutionplan().getPlanname();
                        String planCreated      =   GetProjectManager.getUserName(ptc.getTqmTestcaseexecutionplan().getCreatedby().getUserid());
                        String refIssueid       =   ptc.getIssuereference();
                        int planManager      =   ptc.getTqmTestcaseexecutionplan().getQualitymanager().getUserid();



                        HashMap hm =new HashMap<Integer,String>();
                        hm.put(new Integer(0), "Yet to Test");
                        hm.put(new Integer(1), "Not Applicable");
                        hm.put(new Integer(2), "Could Not Run");
                        hm.put(new Integer(3), "Failed");
                        hm.put(new Integer(4), "Passed");

                        String project  =   projectName.substring(0,projectName.indexOf(":"));
                        String version  =   projectName.substring(projectName.indexOf(":")+1,projectName.length());

        //                logger.info(project +"--"+version);

                         projectName=projectName.replace(":"," v");
                        %>
                        <table width="100%" id="testcases">
                             <tr bgcolor="#E8EEF7">
                                <td width="15%"><b>Test Plan Name</b></td><td><%=planName%></td>   <td><b>Plan Created By</b></td><td><%=planCreated%></td>
                            </tr>
                             <tr >
                                <td width="15%"><b>Project</b></td><td><%=projectName%></td>   <td><b>Module</b></td><td><%=moduleName%></td>
                            </tr>
                            <tr bgcolor="#E8EEF7">
                                <td width="15%"><b>Test Case ID</b></td><td><%=ptcId%></td>   <td><b>Created By</b></td><td><%=createdBy%></td>
                            </tr>
                            <tr >
                                <td><b>Functionality</b></td><td colspan="3"><%=functionality%></td>
                            </tr>
                            <tr bgcolor="#E8EEF7">
                                <td><b>Description</b></td><td colspan="3"><%=desc%></td>
                            </tr>
                            <tr >
                                <td><b>Expected Result</b></td><td colspan="3"><%=expected%></td>
                            </tr>
                            <tr bgcolor="#E8EEF7">
                                <td><b>Files Attached</b></td>
                                <%
                                    int size    =   FileAttach.getFileCount(tceId);
                                    if(size>0){
%>
                                <td colspan="3"><a href="viewFiles.jsp?tceId=<%=tceId%>">View Files</a></td>
                                <%}else{%>
                                  <td colspan="3">No Files</td>
                                <%}%>
                            </tr>
                             <tr>
                                <td><b>Status</b></td>
                                <td >
                                    <select name="status" id="status" onchange="javascript:addRow('testcases')">
                                    <%
                                       Collection set=hm.keySet();
                                        Iterator ite = set.iterator();
                                        int currentid=0;
                                        int ststusid=0;
                                  while (ite.hasNext()) {

                                      int key=(Integer)ite.next();
                                      String currentstatus=(String)hm.get(key);
                                      ststusid=key;
//                                      logger.info("Id"+ststusid+""+currentstatus);
				if (ststusid==statId)
   				{
					currentid=ststusid;
%>
			<option value="<%=currentid%>" selected><%=currentstatus%></option>
			<%
			}
			else
			{
					currentid=ststusid;
%>
			<option value="<%=currentid%>"><%=currentstatus%></option>
			<%
			}

		    }
                                    %>
                                    </select>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                    <%

                                    if(refIssueid!=null){

                                     %>
                                  <b>Reference Issue:</b>  <%=refIssueid%>
                                  <%
                                    }
                                        %>
                                </td>
                                		<td width="12%"><B>AssignedTo</B></td>

		<td width="24%"><div id="solution"> <select name="assignedto" size="1">
			<%


			HashMap al;
                        logger.info("CreatedBy"+createdBy);
                        al=GetProjectMembers.getTestMembers(ptc.getPtcid().getPid().toString());
			
			int assigned=0;
                    int useridassi=0;

                    LinkedHashMap lhp=GetProjectMembers.sortHashMapByValues(al,true);

             //       logger.info("Assigned to Users"+lhp);

                    Collection se=lhp.keySet();
                    Iterator iter=se.iterator();
		    while (iter.hasNext()) {

		      String key=(String)iter.next();
		      String nameofuser=(String)lhp.get(key);
		//      logger.info("Userid"+key);
		//      logger.info("Name"+nameofuser);
		      useridassi=Integer.parseInt(key);
				if (useridassi==Integer.parseInt(assignedto))
   				{
					assigned=useridassi;
%>
			<option value="<%=assigned%>" selected><%=nameofuser%></option>
			<%
			}
			else
			{
					assigned=useridassi;
%>
			<option value="<%=assigned%>"><%=nameofuser%></option>
			<%
			}

		    }

%>
		</select></div></td>
                            </tr>
                            <tr height="21" id="commentsid" bgcolor="#E8EEF7">
                            <td width="12%" align="left">
                            <b>Comments</b>
                            </td>

                            <td colspan="3" align="left"><font size="2"
                                    face="Verdana, Arial, Helvetica, sans-serif">
                                    <textarea rows="3" cols="68" name="comments" onKeyDown="textCounter(document.theForm.comments,document.theForm.remLen1,2000)"
                                    onKeyUp="textCounter(document.theForm.comments,document.theForm.remLen1,2000)"></textarea></font>
                            <input readonly type="text" name="remLen1" size="3" maxlength="4" value="2000">
                            <script type="text/javascript">
                                        CKEDITOR.replace( 'comments',{toolbar:'Basic',height:100} );
                                        var editor_data = CKEDITOR.instances.comments.getData();
                                        
                                        CKEDITOR.instances["comments"].on("instanceReady", function()
                                        {

                                                        //set keyup event
                                                        this.document.on("keyup", updateComments);
                                                         //and paste event
                                                        this.document.on("paste", updateComments);

                                        });
                                        function updateComments()
                                        {
                                                CKEDITOR.tools.setTimeout( function()
                                                            {
                                                                var desc    =   CKEDITOR.instances.comments.getData();
                                                                var leng    =   desc.length;
                                                               editorTextCounter(leng,document.theForm.remLen1,2000);

                                                            }, 0);
                                        }
                                </script>
                            <input type="hidden" name="relatedissue" id="relatedissue" value="<%=relatedIssue%>">
                            </td>

                            </tr>

                        </table>
                        <table width="100%" border="0"  cellpadding="2" align="center">
                            <tr align="center">
                                <TD>&nbsp;</TD>
                                <TD>
                                    <INPUT type=submit value=Update ID=submit>&nbsp;&nbsp;&nbsp;&nbsp;
                                    <INPUT type=reset value="Reset" ID="reset">
                                </TD>
                            </tr>
                            <tr><td><input type="hidden" name="ptcid" id="ptcid" value="<%=ptcID%>"><td><td><input type="hidden" name="tceId" value="<%=tceId%>"><td><td><input type="hidden" id="pid" name="pid" value="<%=pId%>"><input type="hidden" id="project" name="project" value="<%=project%>"><input type="hidden" id="version" name="version" value="<%=version%>"><input type="hidden" id="module" name="module" value="<%=moduleName%>"><td></tr>
                        </table>
                        <%
                            long endTime  =   System.currentTimeMillis();
                            logger.info("Time taken for loading page"+(endTime-startTime));
%>
                       <iframe src="<%=request.getContextPath()%>/admin/tqm/testExecutionComments.jsp?ptcID=<%=ptcID%>&tceId=<%= tceId %>"
	scrolling="auto" frameborder="2" height="60%" width="100%"></iframe>
        <table>
            <tr>
                <td><input type="hidden" name="planname" value="<%=planName%>"/></td>
                <td><input type="hidden" name="plancreatedby" value="<%=planCreated%>"/></td>
                <td><input type="hidden" name="project" value="<%=projectName%>"/></td>
                <td><input type="hidden" name="module" value="<%=moduleName%>"/></td>
                <td><input type="hidden" name="testcaseid" value="<%=ptcId%>"/></td>
                <td><input type="hidden" name="testcasecreatedby" value="<%=createdBy%>"/></td>
                <td><input type="hidden" name="functionality" value="<%=functionality%>"/></td>
                <td><input type="hidden" name="description" value="<%=desc%>"/></td>
                <td><input type="hidden" name="expectedresult" value="<%=expected%>"/></td>
                <td><input type="hidden" name="planmanager" value="<%=planManager%>"/></td>
                <td><input type="hidden" name="pid" value="<%=pId%>"/></td>
            </tr>
        </table>
        </FORM>
                        <%
                    }
                    else{
                         %>
            <br>
            <br>
            <br>
            <table align="center">
            <tr>
                <td width="100%"><b style="color:red">Test Case not available.</b></td>
            </tr>
            </table>
            <%
                    }
                }
                catch(Exception e){
                    logger.error(e.getMessage());
                }
        %>
    </body>
</html>

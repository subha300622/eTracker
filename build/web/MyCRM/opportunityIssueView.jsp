<%@ page language="java" contentType="text/html"
	pageEncoding="UTF-8"%>
	<%@ page import="com.eminent.util.*,org.apache.log4j.*,java.util.*,java.text.*"%>
<%

	
	Logger logger = Logger.getLogger("MyCRM Edit Opportunity");
	

	String logoutcheck=(String)session.getAttribute("Name");
	if(logoutcheck==null)
	{
		%>
<jsp:forward page="../SessionExpired.jsp"></jsp:forward>
<%

	}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>

<meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
<meta http-equiv="Content-Type" content="text/html ">
<LINK title=STYLE
	href="<%= request.getContextPath() %>/eminentech support files/main_ie.css"
	type="text/css" rel=STYLESHEET>
 <script type="text/javascript" src="<%= request.getContextPath() %>/ckeditor_4.5.9_standard/ckeditor/ckeditor.js"></script>
        <script language=javascript src="<%= request.getContextPath() %>/javaScript/checkSubmit.js"></script>
<title>eTracker&#0153; - Eminentlabs CRM,APM,ERM and PTS
Solution</title>
</head>
<script language=javascript
	src="<%= request.getContextPath() %>/eminentech support files/datetimepicker.js"></script>
<SCRIPT language=JAVASCRIPT type="text/javascript">
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

    function moveOpportunity() {
        if(document.theForm.movetoaccount.checked == true){
            if (confirm("Do you want to Move Account"))
            {
                    xmlhttp = createRequest();
                    if (!xmlhttp && typeof XMLHttpRequest!='undefined') {
                        xmlhttp = new XMLHttpRequest();
                    }
                    if(xmlhttp != null) {

                        var opportunity = theForm.opportunityname.value;
                        xmlhttp.open("GET","<%=request.getContextPath()%>/admin/customer/accountCheck.jsp?name="+opportunity+"&rand="+Math.random(1,10), true);
                        xmlhttp.onreadystatechange = userAlert;
                        xmlhttp.send(null);
                    }

            }
            else
            {
                document.theForm.movetoaccount.checked = false
            }
        }
}


function userAlert() {

        if (xmlhttp.readyState == 4) {
            if (xmlhttp.status == 200) {

            var module = xmlhttp.responseText.split(",");
            var flag = module[1];

            if(flag == 'yes'){

                alert("Selected Opportunity name is already exist in account");
                document.theForm.movetoaccount.checked = false;
                theForm.opportunityname.focus();
            }
            else{
               theForm.movetoaccount.checked = true;
            }


      	}
	}
}
 
function trim(str)  
{
        while (str.charAt(str.length - 1)==" ") 
   	str = str.substring(0, str.length - 1); 
  	while (str.charAt(0)==" ") 
    	str = str.substring(1, str.length); 
  	return str; 
} 

function isNumber(str)  
{
	var pattern = "+- 0123456789." 
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
 
	/** Function To Check Whether There Is Any Integer Present In The Form Input From The User */
	
function isPositiveInteger(str)  
{
	var pattern = "abcdefghijklmnopqrstuvwxyz,.?:;[]{}!@#$&*()-_+/ ABCDEFGHIJKLMNOPQRSTUVWXYZ-1234567890/"
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
function isDate(str)
        {
            var pattern = "0123456789-"
            var i = 0;
            do
            {
                var pos = 0;
                for (var j = 0; j < pattern.length; j++)
                    if (str.charAt(i) == pattern.charAt(j))
                    {
                        pos = 1;
                        break;
                    }
                i++;
            }
            while (pos == 1 && i < str.length)
            if (pos == 0)
                return false;
            return true;
        }
	/** Function To Validate The Input Form Data */
function fun(theForm)  
{
	
        if ((theForm.opportunityname.value)=='')  
	{
		alert('Please enter the Opportunity Name '); 
		document.theForm.opportunityname.value="";
		theForm.opportunityname.focus();  
    		return false; 
	}
	if (!isPositiveInteger(trim(theForm.opportunityname.value)))  
	{
		alert('Please enter the valid Opportunity Name '); 
		document.theForm.opportunityname.value="";
		theForm.opportunityname.focus();  
    		return false; 
	}
  	if ( document.getElementById('stage').value == '--None--' )
        {
            alert ( "Please select Stage." );
            document.getElementById('stage').focus();
			return false;
        }
	
        if ((theForm.probability.value)=='')  
	{
		alert('Please enter the Probability '); 
		document.theForm.probability.value="";
   		theForm.probability.focus(); 
                return false; 
	}
	if (!isNumber(trim(theForm.probability.value)))  
	{
		alert('Please enter the Numerical only in the Probability '); 
		document.theForm.probability.value="";
   		theForm.probability.focus(); 
                return false; 
	}
	if (!isNumber(trim(theForm.amount.value))&& (theForm.amount.value)!='')  
	{
		alert('Please enter the Numerical only in the amount '); 
		document.theForm.amount.value="";
   		theForm.amount.focus(); 
   		return false; 
	}
     if (document.getElementById('assignedto').value == '--Select One--')
        {
	        alert("Please choose a Assigned to Name");
	        document.getElementById('assignedto').focus();
	        return false;
        }
	if ((document.getElementById('closedate').value)=='NA')
	{
		alert('Please enter the Closing Date '); 
		document.theForm.closedate.value="";
		theForm.closedate.focus();  
    		return false; 
	}
    if (!isPositiveInteger(trim(document.getElementById('closedate').value)))
	{
		alert('Please enter the Closing Date '); 
		document.theForm.closedate.value="";
		theForm.closedate.focus();  
    		return false; 
	}
        if (trim(document.getElementById('meetingdate').value) === "")
            {
                alert("Please Enter the Meeting Date ");
                document.theForm.meetingdate.focus();
                return false;
            }
            if (!isDate(trim(document.getElementById('meetingdate').value)))
            {
                alert('Please enter the valid Meeting Date');
                document.theForm.meetingdate.value = "";
                theForm.duedate.focus();
                return false;
            }
            var mtr = document.getElementById('meetingdate').value;
            var first = mtr.indexOf("-");
            var last = mtr.lastIndexOf("-");
            var year = mtr.substring(last + 1, last + 5);
            var month = mtr.substring(first + 1, last);
            var date = mtr.substring(0, first);
            var mrt_date = new Date(year, month - 1, date);
            var current_year = current_date.getYear();
            var current_month = current_date.getMonth();
            var current_date = current_date.getDate();
            var today = new Date(current_year, current_month, current_date);

            if (mrt_date.getTime() < today.getTime()) {
                alert('Meeting Date cannot be less than Today');
                document.theForm.meetingdate.value = "";
                theForm.meetingdate.focus();
                return false;
            }
            if (trim(document.getElementById('meetingtime').value) === "--None--")
            {
                alert("Please select Meeting Time ");
                document.getElementById('meetingtime').focus();
                return false;
            }
	if (!isPositiveInteger(trim(theForm.nextstep.value)) && (theForm.nextstep.value)!='')  
	{
		alert('Please enter the nextstep '); 
		document.theForm.nextstep.value="";
		theForm.nextstep.focus();  
   		return false; 
	}
         if (trim(CKEDITOR.instances.comments.getData()) == "")
        {
            alert ("Please Enter the Comments");
            CKEDITOR.instances.comments.focus();
            return false;
        }
        if (CKEDITOR.instances.comments.getData().length>4000)
        {
            alert (" Comments exceeds 4000 character");
            CKEDITOR.instances.comments.focus();
    //        document.theForm.description.value == "";
            return false;
        }
	

	   monitorSubmit();
 
        /** This Loop Checks Whether There Is Any Input Data Present In The Version Info Field */
            //return true;
	}
	
	/** Function To Set Focus On The Project Name Field In The Form */
	
	function setFocus()  {
		document.theForm.closedate.focus();
	}
	window.onload = setFocus;
//-->
    

function textCounter(field,cntfield,maxlimit) 
    {
		if (field.value.length > maxlimit) 
		{
			field.value = field.value.substring(0, maxlimit);
                    alert('Comments size is exceeding 4000 characters');
		}
		else
			cntfield.value = maxlimit - field.value.length;
	}
	
	function call(theForm)
	{
       
  	}

</SCRIPT>
<body>
<jsp:include page="/header.jsp" />
<BR>
<!-- Table To Display The Formatted String "Add New User" -->
<table cellpadding="0" cellspacing="0" width="100%">
	<tr border="2" bgcolor="#c3d9ff">
		<td border="1" align="left" width="100%"><font size="4"
			COLOR="#0000FF"><b> Edit Opportunity</b></font> <FONT SIZE="3"
			COLOR="#0000FF"> </FONT></td>
	</tr>
</table>
<BR>
<FORM name=theForm onsubmit="return fun(this)"
	action="<%=request.getContextPath() %>/MyCRM/crmOpportunityUpdate.jsp"
	method=post onReset="return setFocus()"><%@ page
	import="java.sql.*,pack.eminent.encryption.*"%> <% 
int opportunityid=Integer.parseInt(request.getParameter("opportunityid"));
Connection connection = null;
Statement st=null;
ResultSet rs=null;
try  {

    //Getting admin details
        int adminUserId =   0;
        HashMap<String,String> hm=GetProjectMembers.getAdminDetail();
        if(hm!=null){
            adminUserId=Integer.parseInt(hm.get("userid"));
        }
    
	connection=MakeConnection.getConnection();
	if(connection != null)  {
		st = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
		rs = st.executeQuery("SELECT OPPORTUNITYNAME,TYPE,CLOSE_DATE,STAGE,PROBABILITY,AMOUNT,LEADSOURCE,NEXTSTEP,DESCRIPTION,OPPORTUNITY_OWNER,ASSIGNEDTO,meeting_date,meeting_time from OPPORTUNITY where OPPORTUNITYID="+opportunityid);
		if(rs!=null)
		{
			while(rs.next())
			{
				String opportunityname	=	rs.getString("OPPORTUNITYNAME");
				String owner			=	rs.getString("OPPORTUNITY_OWNER");
				String typ				=	rs.getString("TYPE");
				java.sql.Date closedate		=	rs.getDate("CLOSE_DATE");
				String stage			=	rs.getString("STAGE");
				String probability		=	rs.getString("PROBABILITY");
				String amount			=	rs.getString("AMOUNT");
                String leadsourc		=	rs.getString("LEADSOURCE");
				String nextstep			=	rs.getString("NEXTSTEP");
				String description		=	rs.getString("DESCRIPTION");
				int assi				=	rs.getInt("ASSIGNEDTO");
				String time = rs.getString("MEETING_TIME");
                                java.util.Date meetingDate = rs.getDate("MEETING_DATE");
				SimpleDateFormat dfm =  new SimpleDateFormat("d-M-yyyy");
				String dueDate = "NA";
                if(closedate != null){
                    dueDate = dfm.format(closedate);
                }
                String meeting ="NA";
                if (meetingDate != null) {
                   meeting = dfm.format(meetingDate);
               }
                logger.info("Meeting Date"+meeting);
                logger.info("Meeting Time"+time);

				String type = "NA";
                if(typ != null){
                	type =typ;
                }     
                String leadsource = "NA";
                if(leadsourc != null){
                	leadsource =leadsourc;
                }
                String NextStep = "";
                if(nextstep != null){
                	NextStep =nextstep;
                }
                String Description = "";
                if(description != null){
                	Description =description;
                }
                if (time == null) {
                    time = "--None--";
                }

		%>

<table width="100%" bgColor=#E8EEF7 border="0" align="center">
	<TBODY>
		
		<tr>
			<td width="20%"><b>Opportunity Name</b><font size="10"
				COLOR="#FF0000">*</font></td>
			<td><input type="text" name="opportunityname" maxlength="50" size=25 value="<%=opportunityname%>"><strong class="style20"></strong></td>
			<%
           String[] stageExist = { "--None--" , "Prospecting" , "Qualification" , "Needs Analysis", "Value Proposition" , 
                                  "Id. Decision makers" , "Perception Analysis", "Proposal/Price Quote" ,"Negotiation/Review" , "Perception Analysis" , "Closed Won",
                                                            "Closed Lost" };
%>
			<td width="20%"><strong>Stage</strong><font size="10"
				COLOR="#FF0000">*</font></td>
			<td align="left" width="35%"><SELECT id="stage" NAME="stage" size="1">
				<%   
                               for (int i = 0;i < stageExist.length ;i++ ){
                                        
                               
                                            if (stage.equals(stageExist[i]))
                                            {
						
%>
				<option value="<%= stage %>" selected><%= stage %></option>
				<%
                                            }
                                            else
                                            {
						
%>
				<option value="<%= stageExist[i] %>"><%= stageExist[i] %></option>
				<%
                                            }
                               }
%>
			</SELECT></td>
		</tr>
		<tr>
			
			
			<td width="20%"><strong>Probability(%)</strong></td>
			<td><input type="text" name="probability" maxlength="3" size=25 value="<%=probability%>"></td>
			<td width="20%"><strong>Amount</strong></td>
			<td><input type="text" name="amount" maxlength="11" size=25	value="<%=amount%>"><strong class="style20"></strong></td>
				
		</tr>
		<tr>
			<%
           String[] typeExist = { "--None--" , "Existing Business" , "New Business"};
%>
			<td width="20%"><strong>Type</strong></td>
			<td align="left" width="35%"><SELECT NAME="type" id="type" size="1">
				<%   
                               for (int i = 0;i < typeExist.length ;i++ ){
                                        
                               
                                            if (type.equalsIgnoreCase(typeExist[i]))
                                            {
						
%>
				<option value="<%= type %>" selected><%= type %></option>
				<%
                                            }
                                            else
                                            {
						
%>
				<option value="<%= typeExist[i] %>"><%= typeExist[i] %></option>
				<%
                                            }
                               }
%>
			</SELECT></td>
			<td width="12%"><strong>Assigned To <font size="10" COLOR="#FF0000">*</font></strong></td>
				<td width="23%"><select name="assignedto" id="assignedto" size="1">
					<option value="--Select One--" selected>--Select One--</option>
			<% 

			
			HashMap al;
			
			String pro="CRM";
			String fix="1.0";
			al=GetProjectMembers.getBDMembers(pro,fix);
			Collection set=al.keySet();
			Iterator iter = set.iterator();
			int assigned=0;
            int useridassi=0;

		    while (iter.hasNext()) {

		      String key=(String)iter.next();
		      String nameofuser=(String)al.get(key);
		      logger.info("Userid"+key);
		      logger.info("Name"+nameofuser);
		      
		      
		     // String commentedby=GetProjectMembers.getUserName(rs.getString("commentedby"));
				nameofuser=nameofuser.substring(0,nameofuser.indexOf(" ")+2);
				
		      useridassi=Integer.parseInt(key);
		      if (useridassi==assi)
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
		</select>
		</td>
		</tr>
		<tr>
			
			<td width="20%"><strong>Closing Date</strong><font size="10" COLOR="#FF0000">*</font></td>
			<td><input type="text" name="closedate" id="closedate"
				readonly="true" maxlength="10" size=12 value="<%=dueDate%>"><a
				href="javascript:NewCal('closedate','ddmmyyyy')"> <img
				src="<%=request.getContextPath() %>/images/newhelp.gif" width="16" height="16" border="0"
				alt="Pick a date"></a> </td>
			<td width="20%"><strong>opportunity Owner</strong></td>
			<td><input type="text" name="opportunityowner" maxlength="30" size=25 value="<%=GetProjectManager.getUserName(Integer.parseInt(owner))%>" readonly=true><strong class="style20"></strong></td>
		</tr>
                <tr>
                    <td width="10%">
                                <strong>Meeting<font size="10" COLOR="#FF0000">*</font></strong>
                            </td>
                            <td>
                                <input type="text" name="meetingdate" id="meetingdate" value="<%=meeting%>" maxlength="10" size="5" readonly /><a href="javascript:NewCal('meetingdate','ddmmyyyy')"> <img src="<%=request.getContextPath()%>/images/newhelp.gif" 	border="0" width="16" height="16" alt="Pick a date"></a>
                                <SELECT NAME="meetingtime" id="meetingtime" size="1">
                                     <%
                                        String[] meetingTime = {"--None--", "First Half", "Second Half"};
                                        for (int i = 0; i < meetingTime.length; i++) {
                                            if (time.equals(meetingTime[i])) {
                                    %>
                                    <option value="<%= time%>" selected><%= time%></option>
                                    <%
                                    } else {
                                    %>
                                    <option value="<%= meetingTime[i]%>"><%= meetingTime[i]%></option>
                                    <%
                                            }
                                        }
                                    %>
                                    
                                </SELECT>
                            </td>
                </tr>
		<tr bgcolor="C3D9FF">
			<td colspan=2><strong>Additional Information</strong></td>
			<td><input type="hidden" name="owner"  size=25 value="<%=owner%>"></td>
			<td><input type="hidden" name="opportunityid"
				value="<%=opportunityid %>"></td>
		</tr>
	
		<tr>
			<%
           String[] leadsourceExist = { "--None--" , "Advertisement" , "Employee Referrel", "External Referrel" , "Partner" , "Public Relataion","Seminar-Internal" , "Seminar-Partner" , "Trade Show","Web" , "Word of mouth" , "Others"};
%>
			<td width="20%"><strong>Lead Source</strong></td>
			<td align="left"><SELECT NAME="leadsource" size="1">
				<%   
                               for (int i = 0;i < leadsourceExist.length ;i++ ){
                                        
                               
                                            if (leadsource.equalsIgnoreCase(leadsourceExist[i]))
                                            {
						
%>
				<option value="<%= leadsource %>" selected><%= leadsource %></option>
				<%
                                            }
                                            else
                                            {
						
%>
				<option value="<%= leadsourceExist[i] %>"><%= leadsourceExist[i] %></option>
				<%
                                            }
                               }
%>
			</SELECT></td>
			<% 
			int pmanager =	Integer.parseInt(GetProjectManager.getManager("CRM","1.0"));
			if(stage.equalsIgnoreCase("Closed Won")&& (pmanager==assi||assi==adminUserId)){%>
			<td ><strong>Move to Account</strong></td>
			<td ><input type="checkbox" name="movetoaccount"	size=20 " value="<%=opportunityid%>" onclick="moveOpportunity()"><strong class="style20"></strong></td>
			<%} %>
		</tr>
		<tr>
			<td width="20%"><strong>Next Step</strong></td>
			<td><input type="text" name="nextstep" maxlength="30" size=25
				value="<%=NextStep%>"><strong class="style20"></strong></td>
		</tr>

		<tr bgcolor="C3D9FF">
			<td colspan=4><strong>Descriptive Information</strong></td>
		</tr>

		<tr>
			<td width="20%"><strong>Description</strong></td>
			<td colspan=3><%=Description %></td>
		</tr>

	<tr height="21">
		<td width="20%" class="textdisplay" align="left" colspan=4>
		<p class="textdisplay"><b>Comments</b></p>
		</td>
	</tr>
	<tr height="21">
		<td width="20%"></td>
		<td width="60%" align="left" colspan=3><font size="2"
			face="Verdana, Arial, Helvetica, sans-serif" > <textarea
			rows="3" cols="60" name="comments"
			onKeyDown="textCounter(document.theForm.comments,document.theForm.remLen1,4000)"
			onKeyUp="textCounter(document.theForm.comments,document.theForm.remLen1,4000)"></textarea></font>
		<input readonly type="text" name="remLen1" id="remLen1" size="3" maxlength="3" value="4000">characters left</td>
                 <script type="text/javascript">
                                CKEDITOR.replace( 'comments',{toolbar:'Basic',height:100} );
                                var editor_data = CKEDITOR.instances.comments.getData();
                                CKEDITOR.instances["comments"].on("instanceReady", function()
                                {

                                                //set keyup event
                                                this.document.on("keyup", updateExpectedResult);
                                                 //and paste event
                                                this.document.on("paste", updateExpectedResult);

                                });
                                function updateExpectedResult()
                                {
                                        CKEDITOR.tools.setTimeout( function()
                                                    {
                                                        var desc    =   CKEDITOR.instances.comments.getData();
                                                         var leng    =   desc.length;
                                                       editorTextCounter(leng,document.getElementById('remLen1'),2000);

                                                    }, 0);
                                }
                        </script>
	</tr>
</table>
<table width="100%" border="0" bgcolor="#e8eef7" cellpadding="2"
	align="center">
	<tr align="center">
		<td></td>
		<TD colspan="4" align="center"><INPUT type=submit id=submit value=Update
			name=submit>
		<INPUT type=reset value=Reset id=reset name=reset></TD>
	</tr>
</table>
<%
                   session.setAttribute("name",opportunityname);
                   session.setAttribute("category","opportunity");
                
                %> <iframe
	src="./commentHistory.jsp?opportunityId=<%= opportunityid %>"
	scrolling="auto" frameborder="2" height="45%" width="100%"></iframe> <br>
<br>
<br>


</FORM>

<%
			}
		}
	}
}catch(Exception ex)
		{
			logger.error(ex.getMessage());
		}finally
				{
                       if(rs!=null)
                        {
                                rs.close();
                        }
					if (connection!=null)
					{
						connection.close();
					}
					
		 			
				} 
%>
<BR>
</body>
</html>
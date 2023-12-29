<%-- 
    Document   : initiateAppRequest
    Created on : 7 Sep, 2011, 1:39:39 PM
    Author     : Tamilvelan
--%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="/header.jsp"%>
<%@page import="org.apache.log4j.*" %>
<%@page import="com.eminent.util.GetProjectMembers" %>
<%@page import="com.eminentlabs.appraisal.AppraisalUtil" %>
<%@page import="java.util.ArrayList,java.util.HashMap,java.util.Collection,java.util.Iterator,java.util.Calendar,java.util.GregorianCalendar" %>
<%!
    private static HashMap<Integer,String> monthSelect = new HashMap();

	    static{

	    monthSelect.put(0,"Jan");
	    monthSelect.put(1,"Feb");
	    monthSelect.put(2,"Mar");
	    monthSelect.put(3,"Apr");
	    monthSelect.put(4,"May");
	    monthSelect.put(5,"Jun");
	    monthSelect.put(6,"Jul");
	    monthSelect.put(7,"Aug");
	    monthSelect.put(8,"Sep");
	    monthSelect.put(9,"Oct");
	    monthSelect.put(10,"Nov");
	    monthSelect.put(11,"Dec");

	}
%>
<html>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">

        <TITLE>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS Solution</TITLE>
        <LINK title=STYLE href="<%= request.getContextPath() %>/eminentech support files/main_ie.css" type="text/css" rel="STYLESHEET">
        <script type="text/javascript" src="<%= request.getContextPath() %>/ckeditor_4.5.9_standard/ckeditor/ckeditor.js"></script>
        <script type="text/javascript" src="<%= request.getContextPath() %>/javaScript/checkSubmit.js"></script>
        <script type="text/javascript">
          function trim(str)  {
  		while (str.charAt(str.length - 1)===" ")
                    str = str.substring(0, str.length - 1);
  		while (str.charAt(0)===" ")
                    str = str.substring(1, str.length);
  		return str;
            }
            function validateProcess(){
                

                  if(document.getElementById('firstappraiser').value === '--Select First Appraiser--') {
                        alert('Please select First Appraiser');
                        document.getElementById('firstappraiser').focus();
                        return false;
                   }
                   if(document.getElementById('secondappraiser').value === '--Select Second Appraiser--') {
                        alert('Please select Second Appraiser');
                        document.getElementById('secondappraiser').focus();
                        return false;
                   }
                   if(document.getElementById('thirdappraiser').value === '--Select Third Appraiser--') {
                        alert('Please select Third Appraiser');
                        document.getElementById('thirdappraiser').focus();
                        return false;
                   }
                   if(document.getElementById('initiater').value === '--Select Initiater--') {
                        alert('Please select Initiater');
                        document.getElementById('initiater').focus();
                        return false;
                   }
                   if (trim(CKEDITOR.instances.comments.getData()) === "")
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
            
                disableSubmit();
            }
             function editorTextCounter(field,cntfield,maxlimit)
                {
                    if (field > maxlimit)
                    {

                            if (maxlimit===2000)
                                alert('Comments size is exceeding 2000 characters');
                            else
                                alert('Comments size is exceeding 2000 characters');
                    }
                    else
                            cntfield.value = maxlimit - field;
                }
        </script>
        <style type="text/css">
            .app tr{height:25px;margin-left: 50px;}
        </style>
    </head>
    <body>
        <table cellpadding="0" cellspacing="0" width="100%" align="center">
	<tr bgcolor="#C3D9FF">
		<td align="left" width="100%"><font size="4" COLOR="#0000FF"><b>Appraisal Form of <%=GetProjectMembers.getUserName(request.getParameter("userId"))%></b></font><FONT SIZE="3" COLOR="#0000FF"></FONT></td>
	</tr>
        </table>
        <%
        //Configuring log4j properties

		

			Logger logger = Logger.getLogger("PerformanceChart");
			


            String userId               =   request.getParameter("userId");
            HashMap initiater           =   AppraisalUtil.getIntiater();
            HashMap firstAppraiser      =   (HashMap)initiater.clone();
            HashMap secondAppraiser     =   (HashMap)initiater.clone();
            HashMap thirdAppraiser     =   (HashMap)initiater.clone();
            HashMap userDetails         =   AppraisalUtil.getUserDetails(Integer.parseInt(userId));
            HashMap accountDetails      =   AppraisalUtil.getAccounts();
            //calculating start and end date of this month
		Calendar cal = new GregorianCalendar();
                int currentYear  = cal.get(Calendar.YEAR);
                int month        = cal.get(Calendar.MONTH);
                int year         = currentYear;

                String period   =   AppraisalUtil.getLastAppraisalPeriod(Integer.parseInt(userId));
                logger.info("Start Period"+period);
                String startMonth      =   period.substring(period.indexOf("-")+1, period.lastIndexOf("-"));
                logger.info("Start Month"+startMonth);

                String stYear      =   period.substring(period.lastIndexOf("-")+1, period.length());
                logger.info("Start Year"+stYear);
%>
<form id="" action="createProcess.jsp" onsubmit="return validateProcess(this)">
        <table width="100%" align="center" bgcolor="#E8EEF7" class="app">
            <tr>
                <td><b>Name</b></td>
                <td><%=GetProjectMembers.getUserName(request.getParameter("userId"))%><input type="hidden" name="userId" id="userId" value="<%=userId%>"/></td>
            </tr>
            <tr>
                <td><b>Designation</b></td>
                <td><%=userDetails.get("designation")%><input type="hidden" name="designation" id="designation" value="<%=userDetails.get("designation")%>"/></td>
            </tr>
            <tr>
                <td><b>Employee ID</b></td>
                <td><%=userDetails.get("employeeId")%><input type="hidden" name="employeeId" id="employeeId" value="<%=userDetails.get("employeeId")%>"/></td>
            </tr>
            <tr>
                <td><b>Period</b></td>
                <td>
                     <select name="frommonth" id="frommonth">
                         <%
                            int appMonth  =   Integer.parseInt(startMonth);
                            for(int k=appMonth;k<monthSelect.size();k++){
                                    if(k==appMonth){
                                     %>
                                     <option value='<%=k%>' selected><%=monthSelect.get(k)%></option>
                                     <%
                                    }else{
                                     %>
                                     <option value='<%=k%>'><%=monthSelect.get(k)%></option>
                                     <%
                                    }

                                }
%>

                    </select>

                    <%
                        ArrayList<Integer> selectYears=new ArrayList();
                        int startYear = 2008;
                        int appYear =   Integer.parseInt(stYear);
                        while(appYear<=currentYear){
                            selectYears.add(appYear);
                            appYear++;
                        }
                    %>

                    <select name='fromyear' id='fromyear' >
                        <%
                        for(int k=0;k<selectYears.size();k++){
                                    if(appYear==selectYears.get(k)){
                                     %>
                                     <option value='<%=selectYears.get(k)%>' selected><%=selectYears.get(k)%></option>
                                     <%
                                    }else{
                                     %>
                                     <option value='<%=selectYears.get(k)%>'><%=selectYears.get(k)%></option>
                                     <%
                                    }

                                }

                       %>
                    </select>
                     <span style="width:25px;">To</span>
                     <select name="tomonth" id="tomonth">
                         <%

                            for(int k=0;k<monthSelect.size();k++){
                                    if(k==month){
                                     %>
                                     <option value='<%=k%>' selected><%=monthSelect.get(k)%></option>
                                     <%
                                    }else{
                                     %>
                                     <option value='<%=k%>'><%=monthSelect.get(k)%></option>
                                     <%
                                    }

                                }
%>

                    </select>

                    <%
                        ArrayList<Integer> listYears=new ArrayList<Integer>();
                        startYear=currentYear;
                        while(startYear<=currentYear){
                            listYears.add(startYear);
                            startYear++;
                        }
                    %>

                    <select name='toyear' id='toyear' >
                        <%
                        for(int k=0,selected=2008;k<listYears.size();k++,selected++){
                                    if(selected==year){
                                     %>
                                     <option value='<%=listYears.get(k)%>' selected><%=listYears.get(k)%></option>
                                     <%
                                    }else{
                                     %>
                                     <option value='<%=listYears.get(k)%>'><%=listYears.get(k)%></option>
                                     <%
                                    }

                                }

                       %>
                    </select>

                </td>
            </tr>
            <tr>
                <td><b>First Appraiser</b></td>
                <td>
                    <select name="firstappraiser" id="firstappraiser" size="1">
				<option value="--Select First Appraiser--" selected>--Select First Appraiser--</option>
				 <%
                                        Collection setFirstAppraiser=firstAppraiser.keySet();
			    		Iterator iterFA = setFirstAppraiser.iterator();
                                        while (iterFA.hasNext()) {
                                              int key=(Integer)iterFA.next();
                                              String nameofuser=(String)initiater.get(key);
                                 %>
                                               <option value="<%=key%>"><%=nameofuser %></option>
                                 <%
                                        }
                                %>
			</select>
                </td>
            </tr>
            <tr>
                <td><b>Second Appraiser</b></td>
                <td>
                    <select name="secondappraiser" id="secondappraiser" size="1">
				<option value="--Select Second Appraiser--" selected>--Select Second Appraiser--</option>
				 <%
                                        Collection setSecondAppraiser=secondAppraiser.keySet();
			    		Iterator iterSA = setSecondAppraiser.iterator();
                                        while (iterSA.hasNext()) {
                                              int key=(Integer)iterSA.next();
                                              String nameofuser=(String)initiater.get(key);
                                 %>
                                               <option value="<%=key%>"><%=nameofuser %></option>
                                 <%
                                        }
                                %>
			</select>
                       
                </td>
            </tr>
            
            
            <tr>
                <td><b>Third Appraiser </b></td>
                <td>
                     <select name="thirdappraiser" id="thirdappraiser" size="1">
				<option value="--Select Third Appraiser--" selected>----Select Third Appraiser----</option>
				 <%
                                        Collection setAccount=thirdAppraiser.keySet();
			    		Iterator iterAccount = setAccount.iterator();
                                        while (iterAccount.hasNext()) {
                                              int key=(Integer)iterAccount.next();
                                              String nameofuser=(String)thirdAppraiser.get(key);
                                 %>
                                               <option value="<%=key%>"><%=nameofuser %></option>
                                 <%
                                        }
                                %>
			</select>

                </td>
            </tr>
            <tr>
                <td><b>Initiated By</b></td>
                <td>
                    <select name="initiater" id="initiater" size="1">
				<option value="--Select Initiater--" selected>--Select Initiater--</option>
				 <%
                                        Collection setPM=initiater.keySet();
			    		Iterator iterPM = setPM.iterator();
                                        while (iterPM.hasNext()) {
                                              int key=(Integer)iterPM.next();
                                              String nameofuser=(String)initiater.get(key);
                                 %>
                                               <option value="<%=key%>"><%=nameofuser %></option>
                                 <%
                                        }
                                %>
			</select>
                </td>
            </tr>
            <tr>
                <td style="width:100px;"><b>Comments</b></td>
                <td style="width:700px;">
                    <textarea rows="3" cols="68" name="comments" onKeyDown="textCounter(document.theForm.comments,document.theForm.remLen1,2000)" onKeyUp="textCounter(document.theForm.comments,document.theForm.remLen1,2000)"></textarea>
                    <input readonly type="text" name="remLen1" size="3" maxlength="3"
			value="2000">
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
                </td>
            </tr>
            <tr><td><b></b></td><td></td></tr>
            <tr><td colspan="1" align="right"><input type="submit" name="Initiate" id="submit" value="Initiate"/></td></tr>
        </table>
</form>
    </body>
</html>

<%-- 
    Document   : commentTestCase
    Created on : 11 Jan, 2010, 10:12:18 AM
    Author     : TAMILVELAN
--%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<%@page  import="java.sql.Timestamp,java.text.SimpleDateFormat,com.eminent.tqm.TqmUtil,com.eminent.tqm.TqmTestcaseresult, com.eminent.tqm.TqmPtcm, com.eminent.util.GetProjectManager,com.eminent.util.GetProjects,java.util.*,org.apache.log4j.*"%>
<%@ include file="../header.jsp"%>
<%
        response.setHeader("Cache-Control","no-cache");
        response.setHeader("Cache-Control","no-store");
        response.setDateHeader("Expires", 0);
        response.setHeader("Pragma","no-cache");
		Logger logger = Logger.getLogger("Test case Comments");
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
<script type="text/javascript" language="JavaScript">
    function trim(str)  {
  		while (str.charAt(str.length - 1)==" ")
                    str = str.substring(0, str.length - 1);
  		while (str.charAt(0)==" ")
                    str = str.substring(1, str.length);
  		return str;
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
       function fun(theForm){
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
        </script>
    </head>
    <body>
        <FORM name="theForm" onsubmit='return fun(this)' action="<%=request.getContextPath() %>/MyAssignment/updateTestCase.jsp" method="post">
        <table width="100%">
            <tr bgcolor="#C3D9FF" width="100%">
                <td width="100%"> <b>Test Case Details</b></td>
                            </tr>
        </table>
        <br>
        <br>

       <%
                String ptcID    =request.getParameter("ptcID");
                int statId    =   Integer.parseInt(request.getParameter("statusid"));
                String issueId    =   request.getParameter("issueid");
                logger.info("Status"+issueId);
                TqmPtcm ptc=TqmUtil.viewPTC(ptcID);
              try{
                    if(ptc!=null){
                        String functionality    =   ptc.getFunctionality();
                        String ptcId            =   ptc.getPtcid();
                        String desc             =   ptc.getDescription();
                        String expected         =   ptc.getExpectedresult();
                        String createdBy        =   GetProjectManager.getUserName(ptc.getCreatedby());
                        String projectName      =   GetProjects.getProjectName(ptc.getPid().toString());
                        String moduleName       =   GetProjects.getModuleName(ptc.getMid().toString());

                        
                        
                        HashMap hm =new HashMap<Integer,String>();
                        hm.put(new Integer(0), "Yet to Test");
                        hm.put(new Integer(1), "Not Applicable");
                        hm.put(new Integer(2), "Not Run");
                        hm.put(new Integer(3), "Failed");
                        hm.put(new Integer(4), "Passed");

                         projectName=projectName.replace(":"," v");
                        %>
                        <table width="100%">
                             <tr bgcolor="#E8EEF7">
                                <td width="15%"><b>Project</b></td><td><%=projectName%></td>   <td><b>Module</b></td><td><%=moduleName%></td>
                            </tr>
                            <tr >
                                <td width="15%"><b>Test Case ID</b></td><td><%=ptcId%></td>   <td><b>Created By</b></td><td><%=createdBy%></td>
                            </tr>
                            <tr bgcolor="#E8EEF7">
                                <td><b>Functionality</b></td><td colspan="3"><%=functionality%></td>
                            </tr>
                            <tr >
                                <td><b>Description</b></td><td colspan="3"><%=desc%></td>
                            </tr>
                            <tr bgcolor="#E8EEF7">
                                <td><b>Expected Result</b></td><td colspan="3"><%=expected%></td>
                            </tr>
                             <tr>
                                <td><b>Status</b></td>
                                <td colspan="3">
                                    <select name="status" id="status">
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
                                    </select>
                                </td>
                            </tr>
                            <tr height="21" id="commentsid"  bgcolor="#E8EEF7">
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
                            <tr>
                                
                                <td><input type="hidden" name="createdBy" value="<%=createdBy%>"></td>
                                <td><input type="hidden" name="functionality" value="<%=functionality%>"></td>
                                <td><input type="hidden" name="description" value="<%=desc%>"></td>
                                <td><input type="hidden" name="expectedResult" value="<%=expected%>"></td>
                                <td><input type="hidden" name="ptcid" value="<%=ptcID%>"></td>
                                <td><input type="hidden" name="issueid" value="<%=issueId%>"></td></tr>
                        </table>
                       <iframe
	src="<%=request.getContextPath()%>/admin/tqm/testComments.jsp?ptcID=<%=ptcID%>&issueId=<%= issueId %>"
	scrolling="auto" frameborder="2" height="40%" width="100%"></iframe>
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

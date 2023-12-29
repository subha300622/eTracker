<%-- 
    Document   : selectIssues
    Created on : Apr 21, 2013, 9:45:14 AM
    Author     : Tamilvelan
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.ResourceBundle,java.util.Arrays,java.util.List,org.apache.log4j.Logger,java.text.SimpleDateFormat,java.util.Calendar,java.util.GregorianCalendar,java.util.Date" %>
<%@page import="com.eminent.util.GetProjectMembers,java.util.HashMap"%>
<%@page import="com.eminent.util.GetProjects"%>
<%@page import="com.eminent.util.GetProjectManager,java.util.Collection,java.util.Iterator"%>
<!DOCTYPE html>

<%
        response.setHeader("Cache-Control","no-cache");
        response.setHeader("Cache-Control","no-store");
        response.setDateHeader("Expires", 0);
        response.setHeader("Pragma","no-cache");

		Logger logger = Logger.getLogger("MOM");
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
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS Solution</title>
        <link title=STYLE href="<%=request.getContextPath()%>/eminentech support files/main_ie.css" type="text/css" rel="STYLESHEET"/>
        <script type="text/javascript" src="<%= request.getContextPath() %>/javaScript/task.js"/>
        <script type="text/javascript" src="<%= request.getContextPath() %>/javaScript/checkSubmit.js"/>
         <script type="text/javascript">
       function trim(str)  {
  		while (str.charAt(str.length - 1)==" ")
                    str = str.substring(0, str.length - 1);
  		while (str.charAt(0)==" ")
                    str = str.substring(1, str.length);
  		return str;
	}
        function callmodule() {
        xmlhttp = createRequest();
        if(xmlhttp != null) {

            var product= document.getElementById('project').value;
           
            xmlhttp.open("GET","<%= request.getContextPath() %>/admin/tqm/moduleDetails.jsp?product="+product+"&rand="+Math.random(1,10), false);
            xmlhttp.onreadystatechange = callbackmodule;
            xmlhttp.send(null);
        }
}

function callbackmodule() {

     if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {

                    var name = xmlhttp.responseText;
                    var result = xmlhttp.responseText.split(";");
                    var results = result[1].split(",");
                   
                    objLinkList 	= eval(document.getElementById("module"));
                    objLinkList.length=0;
                    for(i=0;i<results.length-1;i++) {
                       var k  =results[i];
                       var id   =   k.substring(0,k.indexOf('*'));
                       var name   =   k.substring(k.indexOf('*')+1,k.length);
                        objLinkList.length++;
                        objLinkList[i].text =name;
                        objLinkList[i].value = id;
                        
                    }

      }
}
</script>
    </head>
    <%
                int assignedto =(Integer)session.getAttribute("userid_curr");
                Calendar c=new GregorianCalendar();
                Date date   = c.getTime();
                SimpleDateFormat sdf    =   new SimpleDateFormat("dd-MMM-yyyy");
                String dateFor  =   sdf.format(date);
                ResourceBundle rb   = ResourceBundle.getBundle("Resources");
                String mods = rb.getString("mom-mods");                
                String noOfIds[]  =   mods.split(",");

                List<String> modList = Arrays.asList(noOfIds);
%>
    <body>
       <%@ include file="../header.jsp"%>
       <table cellpadding="0" cellspacing="0" width="100%">
	<tr border="2" bgcolor="#C3D9FF">
		<td border="1" align="left" width="70%">
                    <font size="4" COLOR="#0000FF"><b>Add Task for <%=dateFor%></b></font>
<!--                     <select id="taskfor" name="taskfor">
                        <option value="Planned">Planned</option>
                        <option value="Actual">Actual</option>
                    </select>-->
                </td>

	</tr>
        <tr>
            <td style="height: 25px;">
                <a style="cursor: pointer;" onclick="javascript:addIssue();">Add Issue</a> &nbsp;&nbsp;&nbsp;
                <a style="cursor: pointer;" onclick="javascript:addTask();">Add Task</a> &nbsp;&nbsp;&nbsp;
                <a href="viewTask.jsp" style="cursor: pointer;">View Task</a> &nbsp;&nbsp;&nbsp;
                
                <%
                
             if(modList.contains(((Integer)assignedto).toString())){
                 %>
                <a href="mom.jsp" style="cursor: pointer;">Send MOM</a> &nbsp;&nbsp;&nbsp;
               
             <%
             }
             %>
                 <a href="momDetails.jsp" style="cursor: pointer;">View MOM</a> &nbsp;&nbsp;&nbsp;
            </td>
        </tr>
</table>
       <br>
               <table width="100%" border="0"  bgcolor="#E8EEF7" cellspacing="2" cellpadding="2" align="center">
            <tr >
                <td></td>
                <td> <b>Project</b>

                    <select name="project" id="project" onChange="javascript:callmodule();">
                        
                        <%
                        
                                int prjSize =   0;
                                int adminId =   GetProjectMembers.getAdminID();
                                int userId  =   (Integer)session.getAttribute("uid");
                                HashMap al;
                                if(adminId==userId){
                                    al=GetProjectManager.getProjects();
                                }else{
                                     al=GetProjectManager.getUserProjects(userId);
                                }
                                prjSize =   al.size();
                                if(prjSize>1){
                                    %>
                                    <option value="--Select One--">--Select One--</option>
                                    <%
                                }
                                Collection set=al.keySet();
                                Iterator iter = set.iterator();
                                int assigned=0;
                                int useridassi=0;

                            while (iter.hasNext()) {

                              String key=(String)iter.next();
                              String project=(String)al.get(key);

                              useridassi=Integer.parseInt(key);
%>
			<option value="<%=key%>"><%=project%></option>

			<%


										    }

%>
                    </select>
                </td>
                <td><b>Module</b>
                    <select name="module" id="module">
                        <option value="--Select One--">--Select One--</option>
<%
                        logger.info("Module Id"+useridassi);
                        if(prjSize==1){
                            HashMap module  =   GetProjects.getModules(((Integer)useridassi).toString());
                             Collection setOfKeys=module.keySet();
                                Iterator iterate = setOfKeys.iterator();
                            
                            while (iterate.hasNext()) {

                              String moduleId=(String)iterate.next();
                              String moduleName=(String)module.get(moduleId);

%>
			<option value="<%=moduleId%>"><%=moduleName%></option>
<%
                	    }
                            }
%>


                    </select>
                </td>

            </tr>
        </table>
       <form action="createTask.jsp">
                                <br>
        <table width="100%" border="1" id="userissue" bgcolor="#E8EEF7" cellspacing="2" cellpadding="2" align="center">
            <tr id="id0">
                <td width='25px'>Sl. N</td>
                <td>Issue Id</td>
            </tr>
           
        </table>
        <table width="100%" border="0" id="usertask" bgcolor="#E8EEF7" cellspacing="2" cellpadding="2" align="center">
            <tr id="id0">
                <td width='25px'>Sl. N</td>
                <td>Tasks</td>
            </tr>
           
        </table>
        <table> 
         <tr>
             <td width='25px'><input type="submit" value="Submit"/></td>

            </tr>
        </table>
       </form>
    </body>
</html>


<%-- 
    Document   : createPTC
    Created on : Nov 30, 2009, 11:25:35 AM
    Author     : Administrator
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page  import="com.eminent.tqm.TestCasePlan,com.eminent.tqm.TqmTestcaseexecutionplan,com.eminent.util.GetProjectManager,com.eminent.util.GetProjectMembers,java.util.*,org.apache.log4j.*,com.eminent.util.GetProjects"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<%


        session.setAttribute("forwardpage","/admin/tqm/listPTC.jsp");



	//Configuring log4j properties
	

	Logger logger = Logger.getLogger("Create PTC");
	
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
<html>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
        <meta http-equiv="Content-Type" content="text/html">
        <title>eTracker&#153; - Eminentlabs CRM, APM, ERM and PTS Solution</title>
        <LINK title=STYLE href="<%= request.getContextPath() %>/eminentech support files/main_ie.css" type="text/css" rel=STYLESHEET>
          <script type="text/javascript"	src="<%= request.getContextPath() %>/javaScript/XMLHttpRequest.js"></script>
          <script type="text/javascript" src="<%= request.getContextPath() %>/javaScript/checkSubmit.js"></script>
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
function calltestplan() {
        xmlhttp = createRequest();
        if(xmlhttp != null) {

            var product= document.getElementById('project').value;

            xmlhttp.open("GET","<%= request.getContextPath() %>/admin/tqm/testplanDetails.jsp?product="+product+"&rand="+Math.random(1,10), false);
            xmlhttp.onreadystatechange = callbacktestplan;
            xmlhttp.send(null);
        }
}

function callbacktestplan() {

     if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {

                    var name = xmlhttp.responseText;
                    var result = xmlhttp.responseText.split(";");
                    var results = result[1].split(",");

                    objLinkList 	= eval(document.getElementById("testplan"));
                    objLinkList.length=0;
                   var noOfTestPlan     =   ((results.length*1)-1);
                   document.getElementById('addplan').checked = false;
                    if(noOfTestPlan>0){
                        document.getElementById('addplan').disabled = false;
                        for(i=0;i<noOfTestPlan;i++) {
                           var k  =results[i];
                           var id   =   k.substring(0,k.indexOf('*'));
                           var name   =   k.substring(k.indexOf('*')+1,k.length);
                            objLinkList.length++;
                            objLinkList[i].text =name;
                            objLinkList[i].value = id;

                        }
                    }else{
                            document.getElementById('addplan').disabled = true;
                    }

      }
}
    function validate(){
        if(document.getElementById('project').value=='--Select One--'){
            alert('Please Select a project to create Test Cases');
            document.getElementById('project').focus();
            return false;
        }
        if(document.getElementById('module').value=='--Select One--'){
            alert('Please Select a module to create Test Cases');
            document.getElementById('module').focus();
             return false;
        }
        if(document.getElementById('addplan').checked==1){
            if(document.getElementById('testplan').value=='--Select One--'){
                alert('Please Select a Plan to add Test Cases');
                document.getElementById('testplan').focus();
                return false;
            }
        }
        var func=document.getElementsByName("functionality");
        var desc=document.getElementsByName("description");
        var rslt=document.getElementsByName("expectedresult");
        for(var i=0;i<func.length;i++){
            if(trim(func[i].value)==''){
                alert('Please enter the Functionality');
                func[i].focus();
                return false;
            }
            var functext=func[i].value;

            if((functext.length)>1000){
                alert('Functionality length should be less than 1000');
                func[i].focus();
                return false;
            }
             if(trim(desc[i].value)==''){
                alert('Please enter the Description');
                desc[i].focus();
                return false;
            }
            var desctext=desc[i].value;

            if((desctext.length)>1000){
                alert('Description length should be less than 1000');
                desc[i].focus();
                return false;
            }
            if(trim(rslt[i].value)==''){
                alert('Please enter the Expected Result');
                rslt[i].focus();
                return false;
            }
            var rslttext=rslt[i].value;

            if((rslttext.length)>1000){
                alert('Expected Result length should be less than 1000');
                rslt[i].focus();
                return false;
            }
            
    }
      monitorSubmit();
}
function addRow() {
                        var table = document.getElementById('testcases');
                 	var rowCount = table.rows.length;
                 
 //                      alert("No of Rows"+rowCount);
                      
			var row1 = table.insertRow(rowCount-2);

                        if(rowCount==9){
                            table.deleteRow(8);
                        }

                     

                      
                        var idno=rowCount-3;;
   //                     alert("Id No"+idno);
                        rowCount=rowCount-3;
			row1.id="id"+idno;
		      


                       
                        var cell1 =document.createElement('td');
                        cell1.id="cellid"+idno;

                        var lable1=document.createTextNode(idno);

                       
                        cell1.appendChild(lable1);

			var cell2 = document.createElement('td');
                        cell2.align="center";
			var appre = document.createElement("textarea");
			appre.name="functionality";
                        appre.id="functionality";
                        appre.cols="25";
                        appre.rows="3";

			cell2.appendChild(appre);
                      
                        var cell3 = document.createElement('td');
                        cell3.align="center";
			var desc = document.createElement("textarea");
			desc.name="description";
                        desc.id="description";
                        desc.cols="25";
                        desc.rows="3";
			cell3.appendChild(desc);

			var cell4 = document.createElement('td');
                        cell4.align="left";
			var result = document.createElement("textarea");
			result.name="expectedresult";
                        result.id="expectedresult";
                        result.cols="25";
                        result.rows="3";

                        var sub = document.createElement("img");
                        sub.src="remove.gif";

                        sub.id="remove";
                        sub.alt="Remove";
                        sub.onclick=new Function("javascript:removeRow('id"+rowCount+"');");
                        

			cell4.appendChild(result);
                        cell4.appendChild(sub);

                        row1.appendChild(cell1);
                        row1.appendChild(cell2);
                        row1.appendChild(cell3);
                        row1.appendChild(cell4);

                      
                       

                    

		}
                function removeRow(rowCount) {
                    var tables = document.getElementById("testcases");
			var rows = tables.rows.length;
                        /*
                        var elements=tables.getElementsByTagName('tr');

                        var arr = new Array(elements.length);
                        for (var i = 0; i < elements.length; i++) {
                            var status = elements[i].getAttribute("id");
                            arr[i]=status;
                            alert("Tag name"+status);
                        }
                        */
 //                      document.write(arr.sort(function(a,b){return a - b}));
  //                      alert("Passed Value-->"+rowCount);
  //                        alert("Ttl no of Rows"+rows);

                          var row=rows-2;
                            if(document.getElementById('add')==null){
                                row=rows-1;
                            }
                         
    //                      alert("Manipulate Row"+row);
			try {
                            var removed='false';
                            for(var i=0;i<row;i++){
   //                             alert("Table Value-->"+tables.rows[i].id);
                                if(tables.rows[i].id==rowCount)
                                {
                                tables.deleteRow(i);
                                i--;
                                removed=true;
                                }
                                if(removed==true){
    //                                    alert("I value"+i+"Rows"+row);
                                        if(i<row-2){
                                        tables.rows[i+1].cells[0].innerHTML=i;
                                        }
                                     
                                }
                                
                                
                            }
                            var remainingRows = tables.rows.length;
                            if(remainingRows<9){
                              
                                if(document.getElementById('add')==null){

   //                             alert('Link not available');
                                var row1 = tables.insertRow(rows-2);
                                row1.id="4";
                                var cell1 =document.createElement('td');
                                var cell2 =document.createElement('td');
                                var cell3 =document.createElement('td');
                                var cell4 =document.createElement('td');
                               
                                cell1.align="right";
                                cell1.setAttribute("colspan","4");
                                var sub = document.createElement("a");
                                sub.setAttribute("href", "javascript:addRow();");
                                sub.appendChild(document.createTextNode("Add New Test Case"));

                                sub.id="add";
                                sub.alt="Add";
                                
                                cell1.appendChild(sub);

                                row1.appendChild(cell4);
                                row1.appendChild(cell3);
                                row1.appendChild(cell2);
                                row1.appendChild(cell1);
                                }else{

//                                    alert('Link available');
                                }
                            }

		
			}catch(e) {
		//		alert(e);
			}

		}
                

		
</script>
    </head>
    <jsp:include page="/header.jsp" />
    <body>
       <table cellpadding="0" cellspacing="0" width="100%">
	<tr bgcolor="#C3D9FF">
		<td align="left" width="100%"><font size="4" COLOR="#0000FF"><b>Create Project Test Case </b></font><FONT SIZE="3" COLOR="#0000FF"></FONT></td>
	</tr>
       </table>
        <br>
         <br>
         <form name="ptc" action="ptc.jsp" onsubmit="return validate()" method="post">
        <table width="100%" border="0"  bgcolor="#E8EEF7" cellspacing="2" cellpadding="2" align="center">
            <tr >
                <td></td>
                <td> <b>Project</b>

                    <select name="project" id="project" onChange="javascript:callmodule();javascript:calltestplan();">
                        
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
                <td><b><input type="checkbox" name="addplan" id="addplan" value="Yes"/>Test Plan</b>
                    <select name="testplan" id="testplan">
                        <option value="--Select One--">--Select One--</option>
<%
                        String pId  =   request.getParameter("pid");
                        List l  =null;

                        if(pId!=null){
                            l   =   TestCasePlan.listProjectPlan(pId);
                        }
                        else{
                            l   =   TestCasePlan.listUserPlan(userId);
                        }
                        for (Iterator i = l.iterator(); i.hasNext(); ) {
                            long startTime = System.currentTimeMillis();
                            TqmTestcaseexecutionplan t =(TqmTestcaseexecutionplan)i.next();
                            int pid      =   t.getPid();
                            int tepId    =   t.getTepid();
                            String name  =   t.getPlanname();
                            %>
			<option value="<%=tepId%>"><%=name%></option>
<%
                        }
 %>


                    </select>
                </td>
            </tr>
        </table>
                    <br>
                    <br>
<table width="100%" border="0" id="testcases" bgcolor="#E8EEF7" cellspacing="2" cellpadding="2" align="center">
    <tr id="projectselection"><td></td></tr>
            <tr id="header"><td><b>S No</b></td><td align="center"><b>Functionality</b></td><td align="center"><b>Description</b></td><td align="center"><b>Expected Result</b></td></tr>
            <tr id="id1"><td id="cellid1">1</td><td align="center"><textarea name="functionality" id="functionality" rows="3" cols="25"></textarea></td>
            <td align="center"><textarea name="description" id="description" rows="3" cols="25"></textarea></td>
            <td align="left"><textarea name="expectedresult" id="expectedresult" rows="3" cols="25"></textarea></td></tr>
             <tr><td colspan="4" align="right"><a id="add" href="javascript: void(0);" onclick="addRow()">Add New Test Case</a></td></tr>
             <tr><td colspan="2" align="right"></td><td align="center"><input type="submit" id="submit" value="Submit"><input type="reset" id="reset" value="Reset"/></td><td></td></tr>

        </table>
    </form>
    </body>
</html>

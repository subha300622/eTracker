<%-- 
    Document   : viewCrIdbyIssue
    Created on : Dec 12, 2013, 1:19:33 PM
    Author     : E0288
--%>

<%@page import="java.util.Iterator"%>
<%@page import="java.util.Collection"%>
<%@page import="com.eminent.util.IssueDetails"%>
<%@page import="java.util.HashMap"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,ERM and  EPTS Solution</title>
    <LINK title=STYLE href="<%= request.getContextPath()%>/eminentech support files/main_ie.css" type="text/css" rel="STYLESHEET">
    <script type="text/javascript" src="<%= request.getContextPath() %>/javaScript/checkSubmit.js"></script>
    <script src="<%=request.getContextPath()%>/javaScript/jquery.js" type="text/javascript"></script>

    <script type="text/javascript">
        $(document).ready(function() {
            
            $('.credit').hide();  
        });
        function  openEdit(){
            $('.credit').show();  
            $('.crnormal').hide();  
        }
        function  openNormal(){
            $('.credit').hide();  
            $('.crnormal').show();  
        }
        function trim(str)  {
  		while (str.charAt(str.length - 1)===" ")
                    str = str.substring(0, str.length - 1);
  		while (str.charAt(0)===" ")
                    str = str.substring(1, str.length);
  		return str;
            }
        function isPositiveInteger(str)  {
  		var pattern = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
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
        function isPositiveInteger(str)  {
  		var pattern = "1234567890";
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
        function isAlphabet(str)  {
  		var pattern = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
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
                function isAlphaNumeric(str)  {
  		var pattern = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890";
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
        function  validate(){
                var crId = document.getElementsByName('crIda');
                var desc = document.getElementsByName('crIdDescriptiona');
                for(var i=0;i<crId.length;i++){
                        if((crId[i].value==='')){
                            alert("Please enter the valid CR ID");
                            crId[i].value=''; 
                            crId[i].focus();
                            return false;
                        }
                        if( (crId[i].value.length<10)){
                            alert("CR ID must have 10 characters");
                            crId[i].value='';        
                            crId[i].focus();
                            return false;
                        }
                        
                        if(crId[i].value.length===10){
                            var charValid  =   crId[i].value.substring(0,4);
                            var numValid  =   crId[i].value.substring(4);

                            if (!isPositiveInteger(trim(numValid)))  {
                                alert('CR ID Must have positive numbers');
                                crId[i].value='';
                                crId[i].focus();
                                return false;
                            }
                            if (!isAlphaNumeric(trim(charValid)))  {
                                alert('CR ID have alpha Numeric Characters');
                                crId[i].value='';
                                crId[i].focus();
                                return false;
                            }
                            var crIdCheck = document.getElementsByName('crIda');
                            for(var r=0;r<crIdCheck.length;r++){
                                if(r!==i){
                                    if(crId[i].value===crIdCheck[r].value){
                                        alert(crId[i].value+" already exists");
                                        crIdCheck[r].value="";
                                        crIdCheck[r].focus();
                                        return false;
                                    }
                                }
                            }

                        }
                        for(var j=0;j<desc.length;j++){
                            if(i===j){
                                    if((desc[j].value==='')){
                                        alert("Please enter the CR ID Description");
                                        desc[j].value='';
                                        desc[j].focus();
                                        return false;
                                    }
                                    
                                    if((desc[j].value.length<5)){
                                        alert("Please enter the valid CR ID Description");
                                        desc[j].value='';
                                        desc[j].focus();
                                        return false;
                                    }
                        }
                    }
                }
                monitorSubmit();
        }
    </script>
    </head>
    <body>
        <%@ include file="header.jsp"%>
        <%String issueId=request.getParameter("issueId");%>
        <table cellpadding="0" cellspacing="0" width="100%">
                                <tr border="2" bgcolor="#C3D9FF">
                                    <td border="1" align="left" width="70%"><font size="4"
                                                                                  COLOR="#0000FF" style="font-weight: bold;">CR IDS  <%=issueId%></font></td>

                                </tr>
                            </table>
                            <br/>
                            <form name="theForm" id="theForm" method="post" action="updateCrId.jsp" onsubmit="return validate();"> 
        <table style="width: 100%;background-color: white;">
                <tr  style="height: 30px;font-weight: bold;background-color: #C3D9FF;">
                    <td style="width: 10%;">SI No</td>
                    <td style="width: 20%;">CR ID</td>
                    <td>CR ID Description</td>
                </tr>

        <%
                    
            String[][] crIdDetails  =   IssueDetails.getCRIDS(issueId);
            
            for (int i=0;i<crIdDetails.length;i++) {
              if(crIdDetails[i][0]!=null){
                String key=crIdDetails[i][0].trim();
              String desc=crIdDetails[i][1].trim();
              String id=crIdDetails[i][2].trim();
              
                    if ((i % 2) != 0) {
                    %>
                    <tr class="crnormal" bgcolor="#E8EEF7" height="23">
                        <%} else {
                        %>
                    <tr class="crnormal" bgcolor="white" height="23">
                        <% }
                        %>
                        <td><%=i+1%></td>
                        <td><%=key%></td>
                        <td><%=desc%></td>
                    </tr>
                <% }}
            for (int i=0;i<crIdDetails.length;i++) {
              if(crIdDetails[i][0]!=null){
                String key=crIdDetails[i][0].trim();
              String desc=crIdDetails[i][1].trim();
              String id=crIdDetails[i][2].trim();

              
                    if ((i % 2) != 0) {
                    %>
                    <tr class="credit" bgcolor="#E8EEF7" height="23">
                        <%} else {
                        %>
                    <tr class="credit" bgcolor="white" height="23">
                        <% }
                        %>
                        <td><%=i+1%></td>
                        <td><input type="text" name="crIda" maxlength="10" value="<%=key%>"></td>
                        <td><input type="text" name="crIdDescriptiona" maxlength="50" size="50" value="<%=desc%>"><input type="hidden" name="sno" value="<%=id%>"/></td>
                    </tr>
                    
                <% }}
        
        %>
        <tr class="crnormal"> <td colspan="2" style="text-align: center;"><input type="button" id="editcr"  value="Edit CR" onclick="openEdit();"></td></tr>
        <tr class="credit"><td colspan="2" style="text-align: right;"><input type="hidden" name="issueId" value="<%=issueId%>"/><input type="submit"  name="submit" id="submit"  value="Update All"><input type="button"  id="reset"  value="Cancel" onclick="openNormal();"></td></tr>
                </table>
        </form>
    </body>
</html>

<%-- 
    Document   : deleteLeaveApprover
    Created on : 1 Oct, 2019, 12:33:43 PM
    Author     : Muthu
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="rvc" class="com.eminent.leaveUtil.LeaveApproverMaintenanceController"/>
<%
   String res= rvc.deleteLeaveApprover(request);
    
    out.print(res);
%>

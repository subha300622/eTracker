<%-- 
    Document   : checkPlanName
    Created on : Jun 27, 2014, 4:29:23 PM
    Author     : E0288
--%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="cpn" class="com.eminent.tqm.CheckPlanName"></jsp:useBean>
        <%  
            cpn.setAll(request);
            if(cpn.isPlanNameExists()==true){
                out.print("Plan name Already Exists");
            }
        %>

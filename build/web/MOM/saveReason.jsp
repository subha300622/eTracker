<%-- 
    Document   : saveReason
    Created on : Aug 20, 2014, 6:42:17 PM
    Author     : RN.Khans
--%>
<%@page import="com.eminentlabs.mom.FineUtil"%>
<%@page import="com.eminentlabs.mom.Fine"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.GregorianCalendar"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%  
    String reason = request.getParameter("reason");
    int addedby = (Integer) session.getAttribute("userid_curr");
    Calendar c = new GregorianCalendar();
    Date addedon = c.getTime();
    Fine addreason = new Fine();
    addreason.setReason(reason);
    addreason.setAddedon(addedon);
    addreason.setAddedby(addedby);
    long id = 0l;
    id = FineUtil.addReason(addreason);     
    out.print(id);    
%>



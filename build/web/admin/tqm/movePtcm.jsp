<%-- 
    Document   : movePtcm
    Created on : 8 Mar, 2010, 5:05:15 PM
    Author     : ADAL
--%>

<%@page import="org.apache.log4j.Logger"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*,java.util.*,com.eminent.tqm.TqmUtil,com.eminent.tqm.TqmPtcm"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<%Logger logger = Logger.getLogger("movePtcm");
 String ptcID        = request.getParameter("ptcid");
 int userId          = (Integer)session.getAttribute("userid_curr");
 TqmPtcm ptcm        = TqmUtil.viewPTC(ptcID);
 String functionality= ptcm.getFunctionality();
 String desc         = ptcm.getDescription();
 String exp          = ptcm.getExpectedresult();
 int orginator       = ptcm.getCreatedby();
  String total = ","+"no"+",";
 try{
          TqmUtil.createCTC(ptcID, functionality, desc, exp, orginator, userId);
            total = ","+"yes"+",";
 }
 catch(Exception e){
     logger.error(e.getMessage());
 }
 out.println(total);
 





%>
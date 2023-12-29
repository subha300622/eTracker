<%-- 
    Document   : updateOrder
    Created on : 14 Dec, 2014, 10:21:49 PM
    Author     : Tamilvelan
--%>
<%@page import="java.util.Enumeration,java.util.HashMap,com.eminent.tqm.TqmUtil,org.apache.log4j.Logger" %>
<%
    Logger logger = Logger.getLogger("IssueSummarySearch");
    Enumeration en  =request.getParameterNames();
    HashMap<String,String> hm  = new HashMap();
    String param="";
    String value="";
    while(en.hasMoreElements())
        {
            Object objOri=en.nextElement();
             param=(String)objOri;
             value=request.getParameter(param);
             hm.put(param, value);
            logger.info("Ptc Id::"+param+" Order::"+value);
        }      
    TqmUtil.updateOrder(hm);
    String link=(String)session.getAttribute("forwardpage");
%>
<jsp:forward page="<%=link%>"/>
  
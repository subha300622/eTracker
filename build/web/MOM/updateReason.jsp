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
<%  String reasonId = request.getParameter("reasonId");
    String reason = request.getParameter("reason");
    String amount = request.getParameter("amount");
    int addedby = (Integer) session.getAttribute("userid_curr");
    Calendar c = new GregorianCalendar();
    Date addedon = c.getTime();
    Fine addreason = new Fine();
    addreason.setReason(reason);
    addreason.setAmount(Integer.parseInt(amount));
    addreason.setAddedon(addedon);
    addreason.setAddedby(addedby);
    long id = 0l;
    String pageName = "add";
    if (reasonId == null) {
         id = FineUtil.addReason(addreason);
         pageName = "add";
    } else {
        addreason.setId(Long.valueOf(reasonId));
         id = FineUtil.updateReason(addreason);
         pageName = "update";
    }
%>
<jsp:forward page="addReason.jsp">
    <jsp:param name="id" value="<%=id%>"/>
    <jsp:param name="pageName" value="<%=pageName%>"/>
</jsp:forward>


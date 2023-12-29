<%-- 
    Document   : addCrId
    Created on : Feb 5, 2014, 11:54:11 AM
    Author     : E0288
--%>
<%@page import="java.util.HashMap"%>
<%@page import="com.eminent.util.GetProjectManager"%>
<%@page import="org.apache.log4j.PropertyConfigurator"%>
<%@page import="org.apache.log4j.Logger"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.util.Calendar"%>
<%@page import="com.eminent.util.IssueDetails"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%

    //Configuring log4j properties
   

    Logger logger = Logger.getLogger("Modify Issue");
   
    String logoutcheck = (String) session.getAttribute("Name");
    if (logoutcheck == null) {
        logger.fatal("================Session expired===================");
%>
<jsp:forward page="../SessionExpired.jsp"></jsp:forward>
<%
    }
    int userId = (Integer) session.getAttribute("userid_curr");
    java.util.Date d = new java.util.Date();
    Calendar cal = Calendar.getInstance();
    cal.setTime(d);
    Timestamp ts = new Timestamp(new java.util.Date().getTime());
    String crId[] = request.getParameter("crId").split(",");
    String crDescription[] = request.getParameter("crDescription").split(",");
    String status = request.getParameter("crstatus");
    String issueId = request.getParameter("issueIdForCr");
    if (crId != null) {
        for (int i = 0; i < crId.length; i++) {
            IssueDetails.addCRID(issueId, crId[i], crDescription[i], ts, userId, status);
        }
    }
    String[][] crIdDetails = IssueDetails.getCRIDS(issueId);
    HashMap<Integer, String> member = com.eminent.util.GetProjectMembers.showUsers();

%>
<tr style='font-weight: bold;' id='crrow' ><td>CR ID</td><td class='crnormal' onclick='openEdit();' style='cursor: pointer;color:  #3333cc;' title='Expand All'>View CRID(<%=crIdDetails.length%>)</td><td  class='credit' colspan='2' onclick='openNormal();' title='Collapse All' style='cursor: pointer;'>CR ID Description</td><td  class='credit' >Created On</td><td  class='credit' >Status</td><td  class='credit' >Created By</td></tr>
<%
    for (int i = 0; i < crIdDetails.length; i++) {
        if (crIdDetails[i][0] != null) {
            if (!"".equals(crIdDetails[i][0])) {
                String key = crIdDetails[i][0].trim();
                String desc = crIdDetails[i][1].trim();
                String sno = crIdDetails[i][2].trim();
                String createdBy = crIdDetails[i][3].trim();
                String createdOn = crIdDetails[i][4].trim();
                String crstatus = crIdDetails[i][5].trim();

                        if (i % 2 == 0) {%>
<tr class="credit" id="del<%=sno%>" style="background-color:#FFFFFF;"  >  
    <%} else {%>
<tr class="credit" id="del<%=sno%>" style="background-color:#C3D9FE;" >
    <%}%>

    <td class="key<%=sno%>"><img  src='/eTracker/images/edit.png' onclick="editcrid('<%=sno%>', '<%=key%>', '<%=desc%>');" style="cursor: pointer;" ></img><%=key%></td>
    <td class="desc<%=sno%>" colspan="2"><%=desc%></td>
    <td ><%=createdOn%></td>
    <td ><%=crstatus%></td>
    <td >
        <%if (!createdBy.equalsIgnoreCase("Nil")) {%>
        <%=member.get(Integer.valueOf(createdBy))%>
        <%} else {%>
        Nil
        <% }%><img src="<%=request.getContextPath()%>/images/remove.gif" alt="Remove CrId" style="cursor: pointer;" onclick="javascript :deleteCrid('<%=sno%>');"/></td>
</tr>

<% }
        }
    }%>
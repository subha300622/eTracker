
<%@page import="java.util.LinkedHashMap"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="java.util.Map"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.eminent.holidays.HolidaysUtil"%>
<%@page import="com.eminent.holidays.Holidays"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.HashSet"%>
<%@page import="java.util.Set"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@page import="com.eminentlabs.mom.MoMUtil"%>
<%@page import="com.eminentlabs.mom.MoMAttendance"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<jsp:useBean id="ma" class="com.eminentlabs.mom.MoMAttendance"/>
<%ma.setAll(request);
    int roleId = (Integer) session.getAttribute("Role");
    int assignedto = (Integer) session.getAttribute("userid_curr");
    Set<String> attStatu = MoMUtil.attendancsStatus();
%>
<div class="momattendance">
    <% if (!ma.getUserAttendies().isEmpty()) {
            List<MoMAttendance> userAttendies = ma.getUserAttendies();
    %>
    <table class="mom tablesorter"  style="width: 100%;float: left;border-collapse: collapse;margin-top:10px;"  >
        <thead>
            <tr style="background-color: #C3D9FF;height: 21px;font-weight: bold; ">
                <th style="color: #000;padding-left: 16px;">User</th>
                <%for (String status : attStatu) {%>
                <th style="color: #000;padding-left: 16px;"><%=status%></th>
                <%}%>
            </tr>
        </thead>
        <tbody class="tablecontent">

            <%
                Map<BigDecimal, String> users = new LinkedHashMap<BigDecimal, String>();

                for (MoMAttendance uds : userAttendies) {
                    if (!users.containsKey(uds.getUserId())) {
                        users.put(uds.getUserId(), uds.getName());
                    }
                }
                for (Map.Entry<BigDecimal, String> entry : users.entrySet()) {

            %>
            <tr style="height: 21px;"><td style="width: 18%;"><a href='javascript:;' class='useratt' userid='<%=entry.getKey()%>' style="text-decoration: none;"> <%=entry.getValue()%></a></td>

                <%
                    for (String status : attStatu) {
                        int count = 0;
                        for (MoMAttendance uds : userAttendies) {
                            if (uds.getUserId().equals(entry.getKey())) {
                                if (status.equalsIgnoreCase(uds.getStatus())) {
                                    count = uds.getCount();
                                }
                            }
                        }%>
                        <td style="text-align: center;"><%=count%></td>
                <%}
                    }%>
            </tr>
        </tbody>
        <%}%>
    </table>
    


</div>                                 


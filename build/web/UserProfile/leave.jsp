<%-- 
    Document   : attendanceSummary
    Created on : 21 May, 2015, 1:17:05 PM
    Author     : EMINENT
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@page import="com.eminent.leaveUtil.LeaveUtil"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.eminentlabs.mom.MoMUtil"%>
<%@page import="java.util.Set"%>
<%@page import="com.eminentlabs.mom.MoMAttendance"%>
<%@page import="org.json.JSONArray"%>
<jsp:useBean id="ma" class="com.eminentlabs.mom.MoMAttendance"/>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%        List<String> duerationList = LeaveUtil.durationList();
    String fromDate = request.getParameter("fromDate");
    SimpleDateFormat sdfa = new SimpleDateFormat("yyyy-MM-dd");
    SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");

    fromDate = sdf.format(sdfa.parse(fromDate));
    int requestedby = (Integer) session.getAttribute("userid_curr");
    String[][] leaveDetail = LeaveUtil.getLeaveRequestByDateandUser(requestedby, fromDate);
    String editleaveId = "0";
    String editfrom = "";
    String editto = "";
    String edittype = "";
    String editdesc = "";
    String editDuration = "";
    if (leaveDetail !=null) {
        editleaveId = leaveDetail[0][0];
                editfrom = leaveDetail[0][1];
        editto = leaveDetail[0][2];
        edittype = leaveDetail[0][3];
        editdesc = leaveDetail[0][4];
        editDuration = leaveDetail[0][5];

    } else {
        editfrom = fromDate;
    }
%>
<LINK title=STYLE	href="<%= request.getContextPath()%>/eminentech support files/main_ie.css" type=text/css rel=STYLESHEET>
<script language=javascript src="<%= request.getContextPath()%>/eminentech support files/datetimepicker.js"></script>

<script>
    function textCounter(field, cntfield, maxlimit)
    {
        if (field.value.length > maxlimit)
        {
            field.value = field.value.substring(0, maxlimit);
            if (maxlimit === 2000)
                alert('Description size is exceeding 4000 characters');
            else
                alert('Expected Result size is exceeding 2000 characters');
        } else
            cntfield.value = maxlimit - field.value.length;
    }
</script>
<table bgcolor="E8EEF7"  style="width: 100%;">
    <tr>
        <td style="width: 14%;"><B>From</B></td>
        <td style="width: 15%;"><input type="text" id="fromdate" name="fromdate" maxlength="10" size="10"  readonly value="<%=editfrom%>"  />            <input type="hidden" name="leaveid" id="leaveid" value="<%=editleaveId%>">
</td>
        <td style="width: 2%;text-align: right;"><B>To</B></td>
        <td style="width: 20%;"><input type="text" id="todate" name="todate"  maxlength="10" size="10" readonly value="<%=editto%>" /><a id="calImg" href="javascript:NewCal('todate','ddMMyyyy')"> <img src="<%=request.getContextPath()%>/images/newhelp.gif" border="0" width="16" height="16" alt="Pick a date"></a></td>
        <td style="width: 4%;"><b>Type</b></td>
        <td style="width: 46%;">
            <select name="reason" id="reason">
                <option value="--Select One--">--Select One--</option>
                <%for (Map.Entry entry : LeaveUtil.userLeaveTypes().entrySet()) {
                  if (entry.getValue().equals(edittype)) {%>  
                <option value="<%=entry.getValue()%>" selected=""><%=entry.getValue()%></option>
                <%} else {%>
                <option value="<%=entry.getValue()%>" ><%=entry.getValue()%></option>
                <%} }%>     
            </select>
        </td>

    </tr>
    <tr>
        <td><b>Duration</b></td>
        <td><select name="duration" id="duration">
                  <%for (String duration : duerationList) {
                                    if (editDuration.equalsIgnoreCase(duration)) {%>
                        <option value="<%=duration%>" selected><%=duration%></option>
                        <%} else {%>
                        <option value="<%=duration%>"><%=duration%></option>
                        <%}
                                }%>  
                    </select></td>
    </tr>
    <tr>
        <td style="width: 14%;"><b>Reason for Leave</b></td>
        <td colspan="5">
            <font size="2"
                  face="Verdana, Arial, Helvetica, sans-serif"> <textarea
                  name="description" id="description" wrap="physical" cols="60" rows="4"
                  ><%=editdesc.trim()%></textarea></font>
        </td>
    </tr>
    <tr>
        <%if (editleaveId.equals("0")) {%>
        <td align="right" colspan="2"><input id="submit1" type="submit" value="Create" /></td>
            <%} else {%>
        <td align="right" colspan="2">
            <input id="submit1" type="submit" value="Update" /></td>
            <%}%>
    </tr>
</table>
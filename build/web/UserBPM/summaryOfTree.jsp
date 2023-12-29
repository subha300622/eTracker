<%-- 
    Document   : summaryOfTree
    Created on : Mar 6, 2014, 2:41:27 PM
    Author     : E0288
--%>

<%@page import="java.util.HashMap"%>
<%@page import="com.eminentlabs.userBPM.ViewBPM"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    String pid = request.getParameter("pid");
    HashMap hm = ViewBPM.getAll(pid);
    HashMap type    =   ViewBPM.typeCount(Integer.parseInt(pid));
    String wholeHTML = "";
    if (!hm.isEmpty()) {
        wholeHTML = "<table style='border-collapse:collapse;border:1px solid lightblue;'>"
                + "<tr bgcolor='#C3D9FF' style='font-weight:bold;text-align:center;'>"
                + "<td style='border:1px solid lightblue;'># Companies</td>"
                + "<td style='border:1px solid lightblue;'># Business Processes</td>"
                + "<td style='border:1px solid lightblue;'># Main Processes</td>"
                + "<td style='border:1px solid lightblue;'># Sub Processes</td>"
                + "<td style='border:1px solid lightblue;'># Scenarios</td>"
                + "<td style='border:1px solid lightblue;'># Variants</td>"
                + "<td style='border:1px solid lightblue;'># Business Cases</td>"
                + "<td style='border:1px solid lightblue;'># Business Steps</td>"
                + "<td style='border:1px solid lightblue;'># Test Scripts</td>"
                + "<td style='border:1px solid lightblue;'># Test Plans</td>"
                + "<td style='border:1px solid lightblue;'># Passed</td>"
                + "<td style='border:1px solid lightblue;'># Failed</td>"
                + "<td style='border:1px solid lightblue;'># Issues</td>"
                + "</tr>"
                + "<tr style='text-align:center;'>"
                + "<td style='border:1px solid lightblue;'>" + hm.get("ccount") + "</td>"
                + "<td style='border:1px solid lightblue;'>" + hm.get("bpcount") + "</td>"
                + "<td style='border:1px solid lightblue;'>" + hm.get("mpcount") + "</td>"
                + "<td style='border:1px solid lightblue;'>" + hm.get("spcount") + "</td>"
                + "<td style='border:1px solid lightblue;'>" + hm.get("sccount") + "</td>"
                + "<td style='border:1px solid lightblue;'>" + hm.get("vtcount") + "</td>"
                + "<td style='border:1px solid lightblue;'>" + hm.get("tccount") + "</td>"
                + "<td style='border:1px solid lightblue;'>" + hm.get("tscount") + "</td>"
                + "<td style='border:1px solid lightblue;'>" + hm.get("tsccount") + "</td>"
                + "<td style='border:1px solid lightblue;'>" + hm.get("tplancount") + "</td>"
                + "<td style='border:1px solid lightblue;'>" + hm.get("passedcount") + "</td>"
                + "<td style='border:1px solid lightblue;'>" + hm.get("failedcount") + "</td>"
                + "<td style='border:1px solid lightblue;'>" + hm.get("issuecount") + "</td>"
                + "</tr>"
                + "<tr style='text-align:center;'>"
                + "<td style='width:9%;border:1px solid lightblue;'><font color='#1FF507'>SAP</font> / <font color='red'>Non SAP</font></td>"
                + "<td style='border:1px solid lightblue;'><font color='#1FF507'>" + type.get("BPSAP") +"</font> / <font color='red'>"+type.get("BPNONSAP")+ "</font></td>"
                + "<td style='border:1px solid lightblue;'><font color='#1FF507'>" + type.get("MPSAP") +"</font> / <font color='red'>"+type.get("MPNONSAP")+ "</font></td>"
                + "<td style='border:1px solid lightblue;'><font color='#1FF507'>" + type.get("SPSAP") +"</font> / <font color='red'>"+type.get("SPNONSAP")+ "</font></td>"
                + "<td style='border:1px solid lightblue;'><font color='#1FF507'>" + type.get("SCSAP") +"</font> / <font color='red'>"+type.get("SCNONSAP")+ "</font></td>"
                + "<td style='border:1px solid lightblue;'><font color='#1FF507'>" + type.get("VTSAP") +"</font> / <font color='red'>"+type.get("VTNONSAP")+ "</font></td>"
                + "<td style='border:1px solid lightblue;'><font color='#1FF507'>" + type.get("TCSAP") +"</font> / <font color='red'>"+type.get("TCNONSAP")+ "</font></td>"
                + "<td style='border:1px solid lightblue;'><font color='#1FF507'>" + type.get("TSSAP") +"</font> / <font color='red'>"+type.get("TSNONSAP")+ "</font></td>"
                + "<td style='border:1px solid lightblue;'>NA</td>"
                + "<td style='border:1px solid lightblue;'>NA</td>"
                + "<td style='border:1px solid lightblue;'>NA</td>"
                + "<td style='border:1px solid lightblue;'>NA</td>"
                + "<td style='border:1px solid lightblue;'>NA</td>"
                + "</tr>"
                + "</table>";
    }
    out.print(wholeHTML);
%>


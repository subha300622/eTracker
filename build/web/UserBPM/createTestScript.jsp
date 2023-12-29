<%@page import="com.eminentlabs.userBPM.CreateBPM,com.eminentlabs.userBPM.BPMUtil"%>
<%
    String tsId             =   request.getParameter("tsId");
    String testScript       =   request.getParameter("scriptName");
    String expectedResult   =   request.getParameter("expRslt");
    String pId              =   request.getParameter("pid");
    String mod              =   BPMUtil.getModule(Integer.parseInt(tsId));
    int mid                 =   Integer.parseInt(mod.substring(0, mod.indexOf(":")));
    String functionality    =   mod.substring(mod.indexOf(":")+1,mod.length());
    int createdBy           =   (Integer)session.getAttribute("uid");
    String ptcId            =   CreateBPM.createPTC(Integer.parseInt(pId), mid, functionality, testScript, expectedResult, createdBy);
    CreateBPM.createTestScript(Integer.parseInt(tsId),testScript,expectedResult,createdBy,ptcId);
    out.println(","+ptcId+",");
%>

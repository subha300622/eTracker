<%-- 
    Document   : createResolutionDays
    Created on : 27 Oct, 2013, 7:41:21 PM
    Author     : Tamilvelan
--%>
<%@ page import="com.eminent.util.IssueDetails"%>
<%

    String p1s1 =   request.getParameter("p1s1");
    String p1s2 =   request.getParameter("p1s2");
    String p1s3 =   request.getParameter("p1s3");
    String p1s4 =   request.getParameter("p1s4");
    String p2s1 =   request.getParameter("p2s1");
    String p2s2 =   request.getParameter("p2s2");
    String p2s3 =   request.getParameter("p2s3");
    String p2s4 =   request.getParameter("p2s4");
    String p3s1 =   request.getParameter("p3s1");
    String p3s2 =   request.getParameter("p3s2");
    String p3s3 =   request.getParameter("p3s3");
    String p3s4 =   request.getParameter("p3s4");
    String p4s1 =   request.getParameter("p4s1");
    String p4s2 =   request.getParameter("p4s2");
    String p4s3 =   request.getParameter("p4s3");
    String p4s4 =   request.getParameter("p4s4");
    
    String days[][] =   new String[16][2];
    days[0][0]  =   "P1S1";
    days[0][1]  =   p1s1;
    days[1][0]  =   "P1S2";
    days[1][1]  =   p1s2;
    days[2][0]  =   "P1S3";
    days[2][1]  =   p1s3;
    days[3][0]  =   "P1S4";
    days[3][1]  =   p1s4;
    
    days[4][0]  =   "P2S1";
    days[4][1]  =   p2s1;
    days[5][0]  =   "P2S2";
    days[5][1]  =   p2s2;
    days[6][0]  =   "P2S3";
    days[6][1]  =   p2s3;
    days[7][0]  =   "P2S4";
    days[7][1]  =   p2s4;
    
    days[8][0]  =   "P3S1";
    days[8][1]  =   p3s1;
    days[9][0]  =   "P3S2";
    days[9][1]  =   p3s2;
    days[10][0]  =   "P3S3";
    days[10][1]  =   p3s3;
    days[11][0]  =   "P3S4";
    days[11][1]  =   p3s4;
    
    days[12][0]  =   "P4S1";
    days[12][1]  =   p4s1;
    days[13][0]  =   "P4S2";
    days[13][1]  =   p4s2;
    days[14][0]  =   "P4S3";
    days[14][1]  =   p4s3;
    days[15][0]  =   "P4S4";
    days[15][1]  =   p4s4;
    IssueDetails.createResolutionDays(days);
%>
<jsp:forward page="/admin/project/viewproject.jsp" />


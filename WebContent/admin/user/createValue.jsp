<%-- 
    Document   : createValue
    Created on : Feb 10, 2009, 10:21:32 AM
    Author     : Tamilvelan
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*,pack.eminent.encryption.*,org.apache.log4j.*,java.util.HashMap,com.eminent.util.GetValues"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
        <meta http-equiv="Content-Type" content="text/html">
        <title>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS Solution</title>
    </head>
    <body>
        <%
        //log4j configuration
		Logger logger = Logger.getLogger("createValue");
        String logoutcheck=(String)session.getAttribute("Name");
	if(logoutcheck==null)
	{
             logger.fatal("================Session expired===================");
		%>
<jsp:forward page="../SessionExpired.jsp"></jsp:forward>
<%

	}



    %>
        <%
        Connection connection   =   null;
        PreparedStatement statement   =  null;


        try{

            //variable for table name
            String tableName    =   request.getParameter("tablename");



            logger.info("Table Name:"+tableName);

             //Getting the statuses from the status master table
            HashMap<Integer,String> status   =GetValues.getStatus();


         // variable for p1s1

        String unconfirmedp1s1      =   request.getParameter("unconfirmedp1s1");

       

        String rejectedp1s1         =   request.getParameter("rejectedp1s1").trim();
        String duplicatep1s1        =   request.getParameter("duplicatep1s1").trim();
        String investigationp1s1    =   request.getParameter("investigationp1s1").trim();
        String confirmedp1s1        =   request.getParameter("confirmedp1s1").trim();
        String workinprogressp1s1   =   request.getParameter("workinprogressp1s1").trim();
        String developmentp1s1      =   request.getParameter("developmentp1s1").trim();
        String readytobuildp1s1     =   request.getParameter("readytobuildp1s1").trim();
        String codereviewp1s1       =   request.getParameter("codereviewp1s1").trim();
        String qap1s1               =   request.getParameter("qap1s1").trim();
        String verifiedp1s1         =   request.getParameter("verifiedp1s1").trim();
        String performancetestingp1s1    =   request.getParameter("performancetestingp1s1").trim();
        String closedp1s1           =   request.getParameter("closedp1s1").trim();

        // variable for p1s2

        String unconfirmedp1s2      =   request.getParameter("unconfirmedp1s2").trim();
        String rejectedp1s2         =   request.getParameter("rejectedp1s2").trim();
        String duplicatep1s2        =   request.getParameter("duplicatep1s2").trim();
        String investigationp1s2    =   request.getParameter("investigationp1s2").trim();
        String confirmedp1s2        =   request.getParameter("confirmedp1s2").trim();
        String workinprogressp1s2   =   request.getParameter("workinprogressp1s2").trim();
        String developmentp1s2      =   request.getParameter("developmentp1s2").trim();
        String readytobuildp1s2     =   request.getParameter("readytobuildp1s2").trim();
        String codereviewp1s2     =   request.getParameter("codereviewp1s2").trim();
        String qap1s2               =   request.getParameter("qap1s2").trim();
        String verifiedp1s2         =   request.getParameter("verifiedp1s2").trim();
        String performancetestingp1s2    =   request.getParameter("performancetestingp1s2").trim();
        String closedp1s2           =   request.getParameter("closedp1s2").trim();
       

        // variable for p1s3

        String unconfirmedp1s3      =   request.getParameter("unconfirmedp1s3").trim();
        String rejectedp1s3         =   request.getParameter("rejectedp1s3").trim();
        String duplicatep1s3        =   request.getParameter("duplicatep1s3").trim();
        String investigationp1s3    =   request.getParameter("investigationp1s3").trim();
        String confirmedp1s3        =   request.getParameter("confirmedp1s3").trim();
        String workinprogressp1s3   =   request.getParameter("workinprogressp1s3").trim();
        String developmentp1s3      =   request.getParameter("developmentp1s3").trim();
        String codereviewp1s3       =   request.getParameter("codereviewp1s3").trim();
        String readytobuildp1s3     =   request.getParameter("readytobuildp1s3").trim();
        String qap1s3               =   request.getParameter("qap1s3").trim().trim();
        String verifiedp1s3         =   request.getParameter("verifiedp1s3").trim();
        String performancetestingp1s3    =   request.getParameter("performancetestingp1s3").trim();
        String closedp1s3           =   request.getParameter("closedp1s3").trim();
       

        // variable for p1s4

         String unconfirmedp1s4     =   request.getParameter("unconfirmedp1s4").trim();
        String rejectedp1s4         =   request.getParameter("rejectedp1s4").trim();
        String duplicatep1s4        =   request.getParameter("duplicatep1s4").trim();
        String investigationp1s4    =   request.getParameter("investigationp1s4").trim();
        String confirmedp1s4        =   request.getParameter("confirmedp1s4").trim();
        String workinprogressp1s4   =   request.getParameter("workinprogressp1s4").trim();
        String developmentp1s4      =   request.getParameter("developmentp1s4").trim();
        String codereviewp1s4       =   request.getParameter("codereviewp1s4").trim();
        String readytobuildp1s4     =   request.getParameter("readytobuildp1s4").trim();
        String qap1s4               =   request.getParameter("qap1s4").trim();
        String verifiedp1s4         =   request.getParameter("verifiedp1s4").trim();
        String performancetestingp1s4    =   request.getParameter("performancetestingp1s4").trim();
        String closedp1s4           =   request.getParameter("closedp1s4").trim();
       

         // variable for p2s1

        String unconfirmedp2s1      =   request.getParameter("unconfirmedp2s1").trim();
        String rejectedp2s1         =   request.getParameter("rejectedp2s1").trim();
        String duplicatep2s1        =   request.getParameter("duplicatep2s1").trim();
        String investigationp2s1    =   request.getParameter("investigationp2s1").trim();
        String confirmedp2s1        =   request.getParameter("confirmedp2s1").trim();
        String workinprogressp2s1   =   request.getParameter("workinprogressp2s1").trim();
        String developmentp2s1      =   request.getParameter("developmentp2s1").trim();
        String codereviewp2s1       =   request.getParameter("codereviewp2s1").trim();
        String readytobuildp2s1     =   request.getParameter("readytobuildp2s1").trim();
        String qap2s1               =   request.getParameter("qap2s1").trim();
        String verifiedp2s1         =   request.getParameter("verifiedp2s1").trim();
        String performancetestingp2s1    =   request.getParameter("performancetestingp2s1").trim();
        String closedp2s1           =   request.getParameter("closedp2s1").trim();
       

        // variable for p2s2

        String unconfirmedp2s2      =   request.getParameter("unconfirmedp2s2").trim();
        String rejectedp2s2         =   request.getParameter("rejectedp2s2").trim();
        String duplicatep2s2        =   request.getParameter("duplicatep2s2").trim();
        String investigationp2s2    =   request.getParameter("investigationp2s2").trim();
        String confirmedp2s2        =   request.getParameter("confirmedp2s2").trim();
        String workinprogressp2s2   =   request.getParameter("workinprogressp2s2").trim();
        String developmentp2s2      =   request.getParameter("developmentp2s2").trim();
        String codereviewp2s2       =   request.getParameter("codereviewp2s2").trim();
        String readytobuildp2s2     =   request.getParameter("readytobuildp2s2").trim();
        String qap2s2               =   request.getParameter("qap2s2").trim();
        String verifiedp2s2         =   request.getParameter("verifiedp2s2").trim();
        String performancetestingp2s2    =   request.getParameter("performancetestingp2s2").trim();
        String closedp2s2           =   request.getParameter("closedp2s2").trim();
       

        // variable for p2s3

        String unconfirmedp2s3     =   request.getParameter("unconfirmedp2s3").trim();
        String rejectedp2s3         =   request.getParameter("rejectedp2s3").trim();
        String duplicatep2s3        =   request.getParameter("duplicatep2s3").trim();
        String investigationp2s3    =   request.getParameter("investigationp2s3").trim();
        String confirmedp2s3        =   request.getParameter("confirmedp2s3").trim();
        String workinprogressp2s3   =   request.getParameter("workinprogressp2s3").trim();
        String developmentp2s3      =   request.getParameter("developmentp2s3").trim();
        String codereviewp2s3       =   request.getParameter("codereviewp2s3").trim();
        String readytobuildp2s3     =   request.getParameter("readytobuildp2s3").trim();
        String qap2s3               =   request.getParameter("qap2s3").trim();
        String verifiedp2s3         =   request.getParameter("verifiedp2s3").trim();
        String performancetestingp2s3    =   request.getParameter("performancetestingp2s3").trim();
        String closedp2s3           =   request.getParameter("closedp2s3").trim();
       

         // variable for p2s4

        String unconfirmedp2s4      =   request.getParameter("unconfirmedp2s4").trim();
        String rejectedp2s4         =   request.getParameter("rejectedp2s4").trim();
        String duplicatep2s4        =   request.getParameter("duplicatep2s4").trim();
        String investigationp2s4    =   request.getParameter("investigationp2s4").trim();
        String confirmedp2s4        =   request.getParameter("confirmedp2s4").trim();
        String workinprogressp2s4   =   request.getParameter("workinprogressp2s4").trim();
        String developmentp2s4      =   request.getParameter("developmentp2s4").trim();
        String codereviewp2s4       =   request.getParameter("codereviewp2s4").trim();
        String readytobuildp2s4     =   request.getParameter("readytobuildp2s4").trim();
        String qap2s4               =   request.getParameter("qap2s4").trim();
        String verifiedp2s4         =   request.getParameter("verifiedp2s4").trim();
        String performancetestingp2s4    =   request.getParameter("performancetestingp2s4").trim();
        String closedp2s4           =   request.getParameter("closedp2s4").trim();
       

         // variable for p3s1

        String unconfirmedp3s1     =   request.getParameter("unconfirmedp3s1").trim();
        String rejectedp3s1        =   request.getParameter("rejectedp3s1").trim();
        String duplicatep3s1       =   request.getParameter("duplicatep3s1").trim();
        String investigationp3s1   =   request.getParameter("investigationp3s1").trim();
        String confirmedp3s1       =   request.getParameter("confirmedp3s1").trim();
        String workinprogressp3s1  =   request.getParameter("workinprogressp3s1").trim();
        String developmentp3s1     =   request.getParameter("developmentp3s1").trim();
        String codereviewp3s1      =   request.getParameter("codereviewp3s1").trim();
        String readytobuildp3s1    =   request.getParameter("readytobuildp3s1").trim();
        String qap3s1              =   request.getParameter("qap3s1").trim();
        String verifiedp3s1        =   request.getParameter("verifiedp3s1").trim();
        String performancetestingp3s1   =   request.getParameter("performancetestingp3s1").trim();
        String closedp3s1          =   request.getParameter("closedp3s1").trim();
       

           // variable for p3s2

        String unconfirmedp3s2      =   request.getParameter("unconfirmedp3s2").trim();
        String rejectedp3s2         =   request.getParameter("rejectedp3s2").trim();
        String duplicatep3s2        =   request.getParameter("duplicatep3s2").trim();
        String investigationp3s2    =   request.getParameter("investigationp3s2").trim();
        String confirmedp3s2        =   request.getParameter("confirmedp3s2").trim();
        String workinprogressp3s2   =   request.getParameter("workinprogressp3s2").trim();
        String developmentp3s2      =   request.getParameter("developmentp3s2").trim();
        String codereviewp3s2       =   request.getParameter("codereviewp3s2").trim();
        String readytobuildp3s2     =   request.getParameter("readytobuildp3s2").trim();
        String qap3s2               =   request.getParameter("qap3s2").trim();
        String verifiedp3s2         =   request.getParameter("verifiedp3s2").trim();
        String performancetestingp3s2    =   request.getParameter("performancetestingp3s2").trim();
        String closedp3s2           =   request.getParameter("closedp3s2").trim();
       

           // variable for p3s3

        String unconfirmedp3s3      =   request.getParameter("unconfirmedp3s3").trim();
        String rejectedp3s3         =   request.getParameter("rejectedp3s3").trim();
        String duplicatep3s3        =   request.getParameter("duplicatep3s3").trim();
        String investigationp3s3    =   request.getParameter("investigationp3s3").trim();
        String confirmedp3s3        =   request.getParameter("confirmedp3s3").trim();
        String workinprogressp3s3   =   request.getParameter("workinprogressp3s3").trim();
        String developmentp3s3      =   request.getParameter("developmentp3s3").trim();
        String codereviewp3s3       =   request.getParameter("codereviewp3s3").trim();
        String readytobuildp3s3     =   request.getParameter("readytobuildp3s3").trim();
        String qap3s3               =   request.getParameter("qap3s3").trim();
        String verifiedp3s3         =   request.getParameter("verifiedp3s3").trim();
        String performancetestingp3s3    =   request.getParameter("performancetestingp3s3").trim();
        String closedp3s3           =   request.getParameter("closedp3s3").trim();
       

           // variable for p3s4

        String unconfirmedp3s4      =   request.getParameter("unconfirmedp3s4").trim();
        String rejectedp3s4         =   request.getParameter("rejectedp3s4").trim();
        String duplicatep3s4        =   request.getParameter("duplicatep3s4").trim();
        String investigationp3s4    =   request.getParameter("investigationp3s4").trim();
        String confirmedp3s4        =   request.getParameter("confirmedp3s4").trim();
        String workinprogressp3s4   =   request.getParameter("workinprogressp3s4").trim();
        String developmentp3s4      =   request.getParameter("developmentp3s4").trim();
        String codereviewp3s4       =   request.getParameter("codereviewp3s4").trim();
        String readytobuildp3s4     =   request.getParameter("readytobuildp3s4").trim();
        String qap3s4               =   request.getParameter("qap3s4").trim();
        String verifiedp3s4         =   request.getParameter("verifiedp3s4").trim();
        String performancetestingp3s4    =   request.getParameter("performancetestingp3s4").trim();
        String closedp3s4           =   request.getParameter("closedp3s4").trim();
       

           // variable for p4s1

        String unconfirmedp4s1      =   request.getParameter("unconfirmedp4s1").trim();
        String rejectedp4s1         =   request.getParameter("rejectedp4s1").trim();
        String duplicatep4s1        =   request.getParameter("duplicatep4s1").trim();
        String investigationp4s1    =   request.getParameter("investigationp4s1").trim();
        String confirmedp4s1        =   request.getParameter("confirmedp4s1").trim();
        String workinprogressp4s1   =   request.getParameter("workinprogressp4s1").trim();
        String developmentp4s1      =   request.getParameter("developmentp4s1").trim();
        String codereviewp4s1       =   request.getParameter("codereviewp4s1").trim();
        String readytobuildp4s1     =   request.getParameter("readytobuildp4s1").trim();
        String qap4s1               =   request.getParameter("qap4s1").trim();
        String verifiedp4s1         =   request.getParameter("verifiedp4s1").trim();
        String performancetestingp4s1    =   request.getParameter("performancetestingp4s1").trim();
        String closedp4s1           =   request.getParameter("closedp4s1").trim();
       

        // variable for p4s2

        String unconfirmedp4s2        =   request.getParameter("unconfirmedp4s2").trim();
        String rejectedp4s2           =   request.getParameter("rejectedp4s2").trim();
        String duplicatep4s2          =   request.getParameter("duplicatep4s2").trim();
        String investigationp4s2      =   request.getParameter("investigationp4s2").trim();
        String confirmedp4s2          =   request.getParameter("confirmedp4s2").trim();
        String workinprogressp4s2     =   request.getParameter("workinprogressp4s2").trim();
        String developmentp4s2        =   request.getParameter("developmentp4s2").trim();
        String codereviewp4s2         =   request.getParameter("codereviewp4s2").trim();
        String readytobuildp4s2       =   request.getParameter("readytobuildp4s2").trim();
        String qap4s2                 =   request.getParameter("qap4s2").trim();
        String verifiedp4s2           =   request.getParameter("verifiedp4s2").trim();
        String performancetestingp4s2      =   request.getParameter("performancetestingp4s2").trim();
        String closedp4s2             =   request.getParameter("closedp4s2").trim();
       

        // variable for p4s3

        String unconfirmedp4s3      =   request.getParameter("unconfirmedp4s3").trim();
        String rejectedp4s3         =   request.getParameter("rejectedp4s3").trim();
        String duplicatep4s3        =   request.getParameter("duplicatep4s3").trim();
        String investigationp4s3    =   request.getParameter("investigationp4s3").trim();
        String confirmedp4s3        =   request.getParameter("confirmedp4s3").trim();
        String workinprogressp4s3   =   request.getParameter("workinprogressp4s3").trim();
        String developmentp4s3      =   request.getParameter("developmentp4s3").trim();
        String codereviewp4s3       =   request.getParameter("codereviewp4s3").trim();
        String readytobuildp4s3     =   request.getParameter("readytobuildp4s3").trim();
        String qap4s3               =   request.getParameter("qap4s3").trim();
        String verifiedp4s3         =   request.getParameter("verifiedp4s3").trim();
        String performancetestingp4s3    =   request.getParameter("performancetestingp4s3").trim();
        String closedp4s3           =   request.getParameter("closedp4s3").trim();
       

        // variable for p4s4

        String unconfirmedp4s4      =   request.getParameter("unconfirmedp4s4").trim();
        String rejectedp4s4         =   request.getParameter("rejectedp4s4").trim();
        String duplicatep4s4        =   request.getParameter("duplicatep4s4").trim();
        String investigationp4s4    =   request.getParameter("investigationp4s4").trim();
        String confirmedp4s4        =   request.getParameter("confirmedp4s4").trim();
        String workinprogressp4s4   =   request.getParameter("workinprogressp4s4").trim();
        String developmentp4s4      =   request.getParameter("developmentp4s4").trim();
        String codereviewp4s4       =   request.getParameter("codereviewp4s4").trim();
        String readytobuildp4s4     =   request.getParameter("readytobuildp4s4").trim();
        String qap4s4               =   request.getParameter("qap4s4").trim();
        String verifiedp4s4         =   request.getParameter("verifiedp4s4").trim();
        String performancetestingp4s4    =   request.getParameter("performancetestingp4s4").trim();
        String closedp4s4           =   request.getParameter("closedp4s4").trim();
        



        connection  =   MakeConnection.getConnection();
      
        statement   =   connection.prepareStatement("insert into "+tableName+" value(status_id,p1s1,p1s2,p1s3,p1s4,p2s1,p2s2,p2s3,p2s4,p3s1,p3s2,p3s3,p3s4,p4s1,p4s2,p4s3,p4s4) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)",ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);


        statement.setInt(1, Integer.parseInt(request.getParameter("status1")));
        statement.setInt(2, Integer.parseInt(unconfirmedp1s1));
        statement.setInt(3, Integer.parseInt(unconfirmedp1s2));
        statement.setInt(4, Integer.parseInt(unconfirmedp1s3));
        statement.setInt(5, Integer.parseInt(unconfirmedp1s4));
        statement.setInt(6, Integer.parseInt(unconfirmedp2s1));
        statement.setInt(7, Integer.parseInt(unconfirmedp2s2));
        statement.setInt(8, Integer.parseInt(unconfirmedp2s3));
        statement.setInt(9, Integer.parseInt(unconfirmedp2s4));
        statement.setInt(10, Integer.parseInt(unconfirmedp3s1));
        statement.setInt(11, Integer.parseInt(unconfirmedp3s2));
        statement.setInt(12, Integer.parseInt(unconfirmedp3s3));
        statement.setInt(13, Integer.parseInt(unconfirmedp3s4));
        statement.setInt(14, Integer.parseInt(unconfirmedp4s1));
        statement.setInt(15, Integer.parseInt(unconfirmedp4s2));
        statement.setInt(16, Integer.parseInt(unconfirmedp4s3));
        statement.setInt(17, Integer.parseInt(unconfirmedp4s4));
        statement.addBatch();
        

        statement.setInt(1, Integer.parseInt(request.getParameter("status2")));
        statement.setInt(2, Integer.parseInt(rejectedp1s1));
        statement.setInt(3, Integer.parseInt(rejectedp1s2));
        statement.setInt(4, Integer.parseInt(rejectedp1s3));
        statement.setInt(5, Integer.parseInt(rejectedp1s4));
        statement.setInt(6, Integer.parseInt(rejectedp2s1));
        statement.setInt(7, Integer.parseInt(rejectedp2s2));
        statement.setInt(8, Integer.parseInt(rejectedp2s3));
        statement.setInt(9, Integer.parseInt(rejectedp2s4));
        statement.setInt(10, Integer.parseInt(rejectedp3s1));
        statement.setInt(11, Integer.parseInt(rejectedp3s2));
        statement.setInt(12, Integer.parseInt(rejectedp3s3));
        statement.setInt(13, Integer.parseInt(rejectedp3s4));
        statement.setInt(14, Integer.parseInt(rejectedp4s1));
        statement.setInt(15, Integer.parseInt(rejectedp4s2));
        statement.setInt(16, Integer.parseInt(rejectedp4s3));
        statement.setInt(17, Integer.parseInt(rejectedp4s4));
        statement.addBatch();


        statement.setInt(1, Integer.parseInt(request.getParameter("status3")));
        statement.setInt(2, Integer.parseInt(duplicatep1s1));
        statement.setInt(3, Integer.parseInt(duplicatep1s2));
        statement.setInt(4, Integer.parseInt(duplicatep1s3));
        statement.setInt(5, Integer.parseInt(duplicatep1s4));
        statement.setInt(6, Integer.parseInt(duplicatep2s1));
        statement.setInt(7, Integer.parseInt(duplicatep2s2));
        statement.setInt(8, Integer.parseInt(duplicatep2s3));
        statement.setInt(9, Integer.parseInt(duplicatep2s4));
        statement.setInt(10, Integer.parseInt(duplicatep3s1));
        statement.setInt(11, Integer.parseInt(duplicatep3s2));
        statement.setInt(12, Integer.parseInt(duplicatep3s3));
        statement.setInt(13, Integer.parseInt(duplicatep3s4));
        statement.setInt(14, Integer.parseInt(duplicatep4s1));
        statement.setInt(15, Integer.parseInt(duplicatep4s2));
        statement.setInt(16, Integer.parseInt(duplicatep4s3));
        statement.setInt(17, Integer.parseInt(duplicatep4s4));
        statement.addBatch();





        statement.setInt(1, Integer.parseInt(request.getParameter("status4")));
        statement.setInt(2, Integer.parseInt(investigationp1s1));
        statement.setInt(3, Integer.parseInt(investigationp1s2));
        statement.setInt(4, Integer.parseInt(investigationp1s3));
        statement.setInt(5, Integer.parseInt(investigationp1s4));
        statement.setInt(6, Integer.parseInt(investigationp2s1));
        statement.setInt(7, Integer.parseInt(investigationp2s2));
        statement.setInt(8, Integer.parseInt(investigationp2s3));
        statement.setInt(9, Integer.parseInt(investigationp2s4));
        statement.setInt(10, Integer.parseInt(investigationp3s1));
        statement.setInt(11, Integer.parseInt(investigationp3s2));
        statement.setInt(12, Integer.parseInt(investigationp3s3));
        statement.setInt(13, Integer.parseInt(investigationp3s4));
        statement.setInt(14, Integer.parseInt(investigationp4s1));
        statement.setInt(15, Integer.parseInt(investigationp4s2));
        statement.setInt(16, Integer.parseInt(investigationp4s3));
        statement.setInt(17, Integer.parseInt(investigationp4s4));
        statement.addBatch();

        statement.setInt(1, Integer.parseInt(request.getParameter("status5")));
        statement.setInt(2, Integer.parseInt(confirmedp1s1));
        statement.setInt(3, Integer.parseInt(confirmedp1s2));
        statement.setInt(4, Integer.parseInt(confirmedp1s3));
        statement.setInt(5, Integer.parseInt(confirmedp1s4));
        statement.setInt(6, Integer.parseInt(confirmedp2s1));
        statement.setInt(7, Integer.parseInt(confirmedp2s2));
        statement.setInt(8, Integer.parseInt(confirmedp2s3));
        statement.setInt(9, Integer.parseInt(confirmedp2s4));
        statement.setInt(10, Integer.parseInt(confirmedp3s1));
        statement.setInt(11, Integer.parseInt(confirmedp3s2));
        statement.setInt(12, Integer.parseInt(confirmedp3s3));
        statement.setInt(13, Integer.parseInt(confirmedp3s4));
        statement.setInt(14, Integer.parseInt(confirmedp4s1));
        statement.setInt(15, Integer.parseInt(confirmedp4s2));
        statement.setInt(16, Integer.parseInt(confirmedp4s3));
        statement.setInt(17, Integer.parseInt(confirmedp4s4));
        statement.addBatch();



        statement.setInt(1, Integer.parseInt(request.getParameter("status6")));
        statement.setInt(2, Integer.parseInt(developmentp1s1));
        statement.setInt(3, Integer.parseInt(developmentp1s2));
        statement.setInt(4, Integer.parseInt(developmentp1s3));
        statement.setInt(5, Integer.parseInt(developmentp1s4));
        statement.setInt(6, Integer.parseInt(developmentp2s1));
        statement.setInt(7, Integer.parseInt(developmentp2s2));
        statement.setInt(8, Integer.parseInt(developmentp2s3));
        statement.setInt(9, Integer.parseInt(developmentp2s4));
        statement.setInt(10, Integer.parseInt(developmentp3s1));
        statement.setInt(11, Integer.parseInt(developmentp3s2));
        statement.setInt(12, Integer.parseInt(developmentp3s3));
        statement.setInt(13, Integer.parseInt(developmentp3s4));
        statement.setInt(14, Integer.parseInt(developmentp4s1));
        statement.setInt(15, Integer.parseInt(developmentp4s2));
        statement.setInt(16, Integer.parseInt(developmentp4s3));
        statement.setInt(17, Integer.parseInt(developmentp4s4));
        statement.addBatch();

        statement.setInt(1, Integer.parseInt(request.getParameter("status7")));
        statement.setInt(2, Integer.parseInt(workinprogressp1s1));
        statement.setInt(3, Integer.parseInt(workinprogressp1s2));
        statement.setInt(4, Integer.parseInt(workinprogressp1s3));
        statement.setInt(5, Integer.parseInt(workinprogressp1s4));
        statement.setInt(6, Integer.parseInt(workinprogressp2s1));
        statement.setInt(7, Integer.parseInt(workinprogressp2s2));
        statement.setInt(8, Integer.parseInt(workinprogressp2s3));
        statement.setInt(9, Integer.parseInt(workinprogressp2s4));
        statement.setInt(10, Integer.parseInt(workinprogressp3s1));
        statement.setInt(11, Integer.parseInt(workinprogressp3s2));
        statement.setInt(12, Integer.parseInt(workinprogressp3s3));
        statement.setInt(13, Integer.parseInt(workinprogressp3s4));
        statement.setInt(14, Integer.parseInt(workinprogressp4s1));
        statement.setInt(15, Integer.parseInt(workinprogressp4s2));
        statement.setInt(16, Integer.parseInt(workinprogressp4s3));
        statement.setInt(17, Integer.parseInt(workinprogressp4s4));
        statement.addBatch();



        statement.setInt(1,Integer.parseInt(request.getParameter("status8")));
        statement.setInt(2, Integer.parseInt(codereviewp1s1));
        statement.setInt(3, Integer.parseInt(codereviewp1s2));
        statement.setInt(4, Integer.parseInt(codereviewp1s3));
        statement.setInt(5, Integer.parseInt(codereviewp1s4));
        statement.setInt(6, Integer.parseInt(codereviewp2s1));
        statement.setInt(7, Integer.parseInt(codereviewp2s2));
        statement.setInt(8, Integer.parseInt(codereviewp2s3));
        statement.setInt(9, Integer.parseInt(codereviewp2s4));
        statement.setInt(10, Integer.parseInt(codereviewp3s1));
        statement.setInt(11, Integer.parseInt(codereviewp3s2));
        statement.setInt(12, Integer.parseInt(codereviewp3s3));
        statement.setInt(13, Integer.parseInt(codereviewp3s4));
        statement.setInt(14, Integer.parseInt(codereviewp4s1));
        statement.setInt(15, Integer.parseInt(codereviewp4s2));
        statement.setInt(16, Integer.parseInt(codereviewp4s3));
        statement.setInt(17, Integer.parseInt(codereviewp4s4));
        statement.addBatch();


        statement.setInt(1,Integer.parseInt(request.getParameter("status9")));
        statement.setInt(2, Integer.parseInt(readytobuildp1s1));
        statement.setInt(3, Integer.parseInt(readytobuildp1s2));
        statement.setInt(4, Integer.parseInt(readytobuildp1s3));
        statement.setInt(5, Integer.parseInt(readytobuildp1s4));
        statement.setInt(6, Integer.parseInt(readytobuildp2s1));
        statement.setInt(7, Integer.parseInt(readytobuildp2s2));
        statement.setInt(8, Integer.parseInt(readytobuildp2s3));
        statement.setInt(9, Integer.parseInt(readytobuildp2s4));
        statement.setInt(10, Integer.parseInt(readytobuildp3s1));
        statement.setInt(11, Integer.parseInt(readytobuildp3s2));
        statement.setInt(12, Integer.parseInt(readytobuildp3s3));
        statement.setInt(13, Integer.parseInt(readytobuildp3s4));
        statement.setInt(14, Integer.parseInt(readytobuildp4s1));
        statement.setInt(15, Integer.parseInt(readytobuildp4s2));
        statement.setInt(16, Integer.parseInt(readytobuildp4s3));
        statement.setInt(17, Integer.parseInt(readytobuildp4s4));
        statement.addBatch();


        
        statement.setInt(1,Integer.parseInt(request.getParameter("status10")));
        statement.setInt(2, Integer.parseInt(qap1s1));
        statement.setInt(3, Integer.parseInt(qap1s2));
        statement.setInt(4, Integer.parseInt(qap1s3));
        statement.setInt(5, Integer.parseInt(qap1s4));
        statement.setInt(6, Integer.parseInt(qap2s1));
        statement.setInt(7, Integer.parseInt(qap2s2));
        statement.setInt(8, Integer.parseInt(qap2s3));
        statement.setInt(9, Integer.parseInt(qap2s4));
        statement.setInt(10, Integer.parseInt(qap3s1));
        statement.setInt(11, Integer.parseInt(qap3s2));
        statement.setInt(12, Integer.parseInt(qap3s3));
        statement.setInt(13, Integer.parseInt(qap3s4));
        statement.setInt(14, Integer.parseInt(qap4s1));
        statement.setInt(15, Integer.parseInt(qap4s2));
        statement.setInt(16, Integer.parseInt(qap4s3));
        statement.setInt(17, Integer.parseInt(qap4s4));
        statement.addBatch();


        statement.setInt(1,Integer.parseInt(request.getParameter("status11")));
        statement.setInt(2, Integer.parseInt(performancetestingp1s1));
        statement.setInt(3, Integer.parseInt(performancetestingp1s2));
        statement.setInt(4, Integer.parseInt(performancetestingp1s3));
        statement.setInt(5, Integer.parseInt(performancetestingp1s4));
        statement.setInt(6, Integer.parseInt(performancetestingp2s1));
        statement.setInt(7, Integer.parseInt(performancetestingp2s2));
        statement.setInt(8, Integer.parseInt(performancetestingp2s3));
        statement.setInt(9, Integer.parseInt(performancetestingp2s4));
        statement.setInt(10, Integer.parseInt(performancetestingp3s1));
        statement.setInt(11, Integer.parseInt(performancetestingp3s2));
        statement.setInt(12, Integer.parseInt(performancetestingp3s3));
        statement.setInt(13, Integer.parseInt(performancetestingp3s4));
        statement.setInt(14, Integer.parseInt(performancetestingp4s1));
        statement.setInt(15, Integer.parseInt(performancetestingp4s2));
        statement.setInt(16, Integer.parseInt(performancetestingp4s3));
        statement.setInt(17, Integer.parseInt(performancetestingp4s4));
        statement.addBatch();


        statement.setInt(1,Integer.parseInt(request.getParameter("status12")));
        statement.setInt(2, Integer.parseInt(verifiedp1s1));
        statement.setInt(3, Integer.parseInt(verifiedp1s2));
        statement.setInt(4, Integer.parseInt(verifiedp1s3));
        statement.setInt(5, Integer.parseInt(verifiedp1s4));
        statement.setInt(6, Integer.parseInt(verifiedp2s1));
        statement.setInt(7, Integer.parseInt(verifiedp2s2));
        statement.setInt(8, Integer.parseInt(verifiedp2s3));
        statement.setInt(9, Integer.parseInt(verifiedp2s4));
        statement.setInt(10, Integer.parseInt(verifiedp3s1));
        statement.setInt(11, Integer.parseInt(verifiedp3s2));
        statement.setInt(12, Integer.parseInt(verifiedp3s3));
        statement.setInt(13, Integer.parseInt(verifiedp3s4));
        statement.setInt(14, Integer.parseInt(verifiedp4s1));
        statement.setInt(15, Integer.parseInt(verifiedp4s2));
        statement.setInt(16, Integer.parseInt(verifiedp4s3));
        statement.setInt(17, Integer.parseInt(verifiedp4s4));
        statement.addBatch();




       

        statement.setInt(1,Integer.parseInt(request.getParameter("status13")));
        statement.setInt(2, Integer.parseInt(closedp1s1));
        statement.setInt(3, Integer.parseInt(closedp1s2));
        statement.setInt(4, Integer.parseInt(closedp1s3));
        statement.setInt(5, Integer.parseInt(closedp1s4));
        statement.setInt(6, Integer.parseInt(closedp2s1));
        statement.setInt(7, Integer.parseInt(closedp2s2));
        statement.setInt(8, Integer.parseInt(closedp2s3));
        statement.setInt(9, Integer.parseInt(closedp2s4));
        statement.setInt(10, Integer.parseInt(closedp3s1));
        statement.setInt(11, Integer.parseInt(closedp3s2));
        statement.setInt(12, Integer.parseInt(closedp3s3));
        statement.setInt(13, Integer.parseInt(closedp3s4));
        statement.setInt(14, Integer.parseInt(closedp4s1));
        statement.setInt(15, Integer.parseInt(closedp4s2));
        statement.setInt(16, Integer.parseInt(closedp4s3));
        statement.setInt(17, Integer.parseInt(closedp4s4));
        statement.addBatch();

        

        statement.executeBatch();

        }
        catch(Exception e){
            logger.error(e.getMessage());
            }
        finally{
                    if(statement!=null){
                            statement.close();
                        }
                    if(connection!=null){
                        connection.close();
                                                                      }
            }










        %>
        <jsp:forward page="viewuser.jsp"/>
					
		
    </body>
</html>

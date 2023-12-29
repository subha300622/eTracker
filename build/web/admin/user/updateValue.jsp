<%-- 
    Document   : updateValue
    Created on : Mar 16, 2009, 4:30:55 PM
    Author     : Tamilvelan
--%>

<%@page import="org.apache.log4j.Logger"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.Connection,java.sql.ResultSet,java.sql.PreparedStatement,pack.eminent.encryption.MakeConnection,java.sql.SQLException,java.util.HashMap,com.eminent.util.GetValues"%>
<%
 
Logger logger = Logger.getLogger("updateValue");
 int point1 =   0;
 int point2 =   0;
 int point3 =   0;
 int point4 =   0;

 int point5 =   0;
 int point6 =   0;
 int point7 =   0;
 int point8 =   0;

 int point9 =   0;
 int point10=   0;
 int point11=   0;
 int point12=   0;

 int point13=   0;
 int point14=   0;
 int point15=   0;
 int point16=   0;

 Connection connection              =   null;
 ResultSet  pointsUpdateRS          =   null;
 PreparedStatement pointsUpdatePS   =   null;

  HashMap statuses =   new HashMap<String,String>();

     statuses=GetValues.getStatus();

  
 String stat=request.getParameter("stat");

//System.out.println("Stat"+stat);

 String status=(String)statuses.get(Integer.parseInt(stat));
 status=status.replaceAll(" ","");


 //System.out.println("Status"+status);
 
 try{
        connection =MakeConnection.getConnection();

 if(status.equalsIgnoreCase("confirmed")){

        if(request.getParameter("confirmedp1s1")!=null){
                point1=Integer.parseInt(request.getParameter("confirmedp1s1"));
            }
        if(request.getParameter("confirmedp1s2")!=null){
                point2=Integer.parseInt(request.getParameter("confirmedp1s2"));
            }
        if(request.getParameter("confirmedp1s3")!=null){
                point3=Integer.parseInt(request.getParameter("confirmedp1s3"));
            }
        if(request.getParameter("confirmedp1s4")!=null){
                point4=Integer.parseInt(request.getParameter("confirmedp1s4"));
            }

        if(request.getParameter("confirmedp2s1")!=null){
                point5=Integer.parseInt(request.getParameter("confirmedp2s1"));
            }
        if(request.getParameter("confirmedp2s2")!=null){
                point6=Integer.parseInt(request.getParameter("confirmedp2s2"));
            }
        if(request.getParameter("confirmedp2s3")!=null){
                point7=Integer.parseInt(request.getParameter("confirmedp2s3"));
            }
        if(request.getParameter("confirmedp2s4")!=null){
                point8=Integer.parseInt(request.getParameter("confirmedp2s4"));
            }

        if(request.getParameter("confirmedp3s1")!=null){
                point9=Integer.parseInt(request.getParameter("confirmedp3s1"));
            }
        if(request.getParameter("confirmedp3s2")!=null){
                point10=Integer.parseInt(request.getParameter("confirmedp3s2"));
            }
        if(request.getParameter("confirmedp3s3")!=null){
                point11=Integer.parseInt(request.getParameter("confirmedp3s3"));
            }
        if(request.getParameter("confirmedp3s4")!=null){
                point12=Integer.parseInt(request.getParameter("confirmedp3s4"));
            }

        if(request.getParameter("confirmedp4s1")!=null){
                point13=Integer.parseInt(request.getParameter("confirmedp4s1"));
            }
        if(request.getParameter("confirmedp4s2")!=null){
                point14=Integer.parseInt(request.getParameter("confirmedp4s2"));
            }
        if(request.getParameter("confirmedp4s3")!=null){
                point15=Integer.parseInt(request.getParameter("confirmedp4s3"));
            }
        if(request.getParameter("confirmedp4s4")!=null){
                point16=Integer.parseInt(request.getParameter("confirmedp4s4"));
            }
            if(connection!=null){
                pointsUpdatePS=connection.prepareStatement("update VALUE_NONSAP_BUG set p1s1=?,p1s2=?,p1s3=?,p1s4=?,p2s1=?,p2s2=?,p2s3=?,p2s4=?,p3s1=?,p3s2=?,p3s3=?,p3s4=?,p4s1=?,p4s2=?,p4s3=?,p4s4=? where status_id=?");
                pointsUpdatePS.setInt(1,point1);
                pointsUpdatePS.setInt(2,point2);
                pointsUpdatePS.setInt(3,point3);
                pointsUpdatePS.setInt(4,point4);
                pointsUpdatePS.setInt(5,point5);
                pointsUpdatePS.setInt(6,point6);
                pointsUpdatePS.setInt(7,point7);
                pointsUpdatePS.setInt(8,point8);
                pointsUpdatePS.setInt(9,point9);
                pointsUpdatePS.setInt(10,point10);
                pointsUpdatePS.setInt(11,point11);
                pointsUpdatePS.setInt(12,point12);
                pointsUpdatePS.setInt(13,point13);
                pointsUpdatePS.setInt(14,point14);
                pointsUpdatePS.setInt(15,point15);
                pointsUpdatePS.setInt(16,point16);
                pointsUpdatePS.setInt(17,Integer.parseInt(stat));
                int x= pointsUpdatePS.executeUpdate();
                out.println(x);

                }

     }
        if(status.equalsIgnoreCase("unconfirmed")){
         
        if(request.getParameter("unconfirmedp1s1")!=null){
                point1=Integer.parseInt(request.getParameter("unconfirmedp1s1"));
                
            }
        if(request.getParameter("unconfirmedp1s2")!=null){
                point2=Integer.parseInt(request.getParameter("unconfirmedp1s2"));
            }
        if(request.getParameter("unconfirmedp1s3")!=null){
                point3=Integer.parseInt(request.getParameter("unconfirmedp1s3"));
            }
        if(request.getParameter("unconfirmedp1s4")!=null){
                point4=Integer.parseInt(request.getParameter("unconfirmedp1s4"));
            }

        if(request.getParameter("unconfirmedp2s1")!=null){
                point5=Integer.parseInt(request.getParameter("unconfirmedp2s1"));
            }
        if(request.getParameter("unconfirmedp2s2")!=null){
                point6=Integer.parseInt(request.getParameter("unconfirmedp2s2"));
            }
        if(request.getParameter("unconfirmedp2s3")!=null){
                point7=Integer.parseInt(request.getParameter("unconfirmedp2s3"));
            }
        if(request.getParameter("unconfirmedp2s4")!=null){
                point8=Integer.parseInt(request.getParameter("unconfirmedp2s4"));
            }

        if(request.getParameter("unconfirmedp3s1")!=null){
                point9=Integer.parseInt(request.getParameter("unconfirmedp3s1"));
            }
        if(request.getParameter("unconfirmedp3s2")!=null){
                point10=Integer.parseInt(request.getParameter("unconfirmedp3s2"));
            }
        if(request.getParameter("unconfirmedp3s3")!=null){
                point11=Integer.parseInt(request.getParameter("unconfirmedp3s3"));
            }
        if(request.getParameter("unconfirmedp3s4")!=null){
                point12=Integer.parseInt(request.getParameter("unconfirmedp3s4"));
            }

        if(request.getParameter("unconfirmedp4s1")!=null){
                point13=Integer.parseInt(request.getParameter("unconfirmedp4s1"));
            }
        if(request.getParameter("unconfirmedp4s2")!=null){
                point14=Integer.parseInt(request.getParameter("unconfirmedp4s2"));
            }
        if(request.getParameter("unconfirmedp4s3")!=null){
                point15=Integer.parseInt(request.getParameter("unconfirmedp4s3"));
            }
        if(request.getParameter("unconfirmedp4s4")!=null){
                point16=Integer.parseInt(request.getParameter("unconfirmedp4s4"));
            }
            if(connection!=null){
                pointsUpdatePS=connection.prepareStatement("update VALUE_NONSAP_BUG set p1s1=?,p1s2=?,p1s3=?,p1s4=?,p2s1=?,p2s2=?,p2s3=?,p2s4=?,p3s1=?,p3s2=?,p3s3=?,p3s4=?,p4s1=?,p4s2=?,p4s3=?,p4s4=? where status_id=?");
                pointsUpdatePS.setInt(1,point1);
                pointsUpdatePS.setInt(2,point2);
                pointsUpdatePS.setInt(3,point3);
                pointsUpdatePS.setInt(4,point4);
                pointsUpdatePS.setInt(5,point5);
                pointsUpdatePS.setInt(6,point6);
                pointsUpdatePS.setInt(7,point7);
                pointsUpdatePS.setInt(8,point8);
                pointsUpdatePS.setInt(9,point9);
                pointsUpdatePS.setInt(10,point10);
                pointsUpdatePS.setInt(11,point11);
                pointsUpdatePS.setInt(12,point12);
                pointsUpdatePS.setInt(13,point13);
                pointsUpdatePS.setInt(14,point14);
                pointsUpdatePS.setInt(15,point15);
                pointsUpdatePS.setInt(16,point16);
                pointsUpdatePS.setInt(17,Integer.parseInt(stat));
               int x= pointsUpdatePS.executeUpdate();
               out.println(x);

                }

     }
    
        if(status.equalsIgnoreCase("investigation")){
        if(request.getParameter("investigationp1s1")!=null){
                point1=Integer.parseInt(request.getParameter("investigationp1s1"));
            }
        if(request.getParameter("investigationp1s2")!=null){
                point2=Integer.parseInt(request.getParameter("investigationp1s2"));
            }
        if(request.getParameter("investigationp1s3")!=null){
                point3=Integer.parseInt(request.getParameter("investigationp1s3"));
            }
        if(request.getParameter("investigationp1s4")!=null){
                point4=Integer.parseInt(request.getParameter("investigationp1s4"));
            }

        if(request.getParameter("investigationp2s1")!=null){
                point5=Integer.parseInt(request.getParameter("investigationp2s1"));
            }
        if(request.getParameter("investigationp2s2")!=null){
                point6=Integer.parseInt(request.getParameter("investigationp2s2"));
            }
        if(request.getParameter("investigationp2s3")!=null){
                point7=Integer.parseInt(request.getParameter("investigationp2s3"));
            }
        if(request.getParameter("investigationp2s4")!=null){
                point8=Integer.parseInt(request.getParameter("investigationp2s4"));
            }

        if(request.getParameter("investigationp3s1")!=null){
                point9=Integer.parseInt(request.getParameter("investigationp3s1"));
            }
        if(request.getParameter("investigationp3s2")!=null){
                point10=Integer.parseInt(request.getParameter("investigationp3s2"));
            }
        if(request.getParameter("investigationp3s3")!=null){
                point11=Integer.parseInt(request.getParameter("investigationp3s3"));
            }
        if(request.getParameter("investigationp3s4")!=null){
                point12=Integer.parseInt(request.getParameter("investigationp3s4"));
            }

        if(request.getParameter("investigationp4s1")!=null){
                point13=Integer.parseInt(request.getParameter("investigationp4s1"));
            }
        if(request.getParameter("investigationp4s2")!=null){
                point14=Integer.parseInt(request.getParameter("investigationp4s2"));
            }
        if(request.getParameter("investigationp4s3")!=null){
                point15=Integer.parseInt(request.getParameter("investigationp4s3"));
            }
        if(request.getParameter("investigationp4s4")!=null){
                point16=Integer.parseInt(request.getParameter("investigationp4s4"));
            }
            if(connection!=null){
                pointsUpdatePS=connection.prepareStatement("update VALUE_NONSAP_BUG set p1s1=?,p1s2=?,p1s3=?,p1s4=?,p2s1=?,p2s2=?,p2s3=?,p2s4=?,p3s1=?,p3s2=?,p3s3=?,p3s4=?,p4s1=?,p4s2=?,p4s3=?,p4s4=? where status_id=?");
                pointsUpdatePS.setInt(1,point1);
                pointsUpdatePS.setInt(2,point2);
                pointsUpdatePS.setInt(3,point3);
                pointsUpdatePS.setInt(4,point4);
                pointsUpdatePS.setInt(5,point5);
                pointsUpdatePS.setInt(6,point6);
                pointsUpdatePS.setInt(7,point7);
                pointsUpdatePS.setInt(8,point8);
                pointsUpdatePS.setInt(9,point9);
                pointsUpdatePS.setInt(10,point10);
                pointsUpdatePS.setInt(11,point11);
                pointsUpdatePS.setInt(12,point12);
                pointsUpdatePS.setInt(13,point13);
                pointsUpdatePS.setInt(14,point14);
                pointsUpdatePS.setInt(15,point15);
                pointsUpdatePS.setInt(16,point16);
                pointsUpdatePS.setInt(17,Integer.parseInt(stat));
                int x= pointsUpdatePS.executeUpdate();
                out.println(x);

                }

     }
     if(status.equalsIgnoreCase("duplicate")){
        if(request.getParameter("duplicatep1s1")!=null){
                point1=Integer.parseInt(request.getParameter("duplicatep1s1"));
            }
        if(request.getParameter("duplicatep1s2")!=null){
                point2=Integer.parseInt(request.getParameter("duplicatep1s2"));
            }
        if(request.getParameter("duplicatep1s3")!=null){
                point3=Integer.parseInt(request.getParameter("duplicatep1s3"));
            }
        if(request.getParameter("duplicatep1s4")!=null){
                point4=Integer.parseInt(request.getParameter("duplicatep1s4"));
            }

        if(request.getParameter("duplicatep2s1")!=null){
                point5=Integer.parseInt(request.getParameter("duplicatep2s1"));
            }
        if(request.getParameter("duplicatep2s2")!=null){
                point6=Integer.parseInt(request.getParameter("duplicatep2s2"));
            }
        if(request.getParameter("duplicatep2s3")!=null){
                point7=Integer.parseInt(request.getParameter("duplicatep2s3"));
            }
        if(request.getParameter("duplicatep2s4")!=null){
                point8=Integer.parseInt(request.getParameter("duplicatep2s4"));
            }

        if(request.getParameter("duplicatep3s1")!=null){
                point9=Integer.parseInt(request.getParameter("duplicatep3s1"));
            }
        if(request.getParameter("duplicatep3s2")!=null){
                point10=Integer.parseInt(request.getParameter("duplicatep3s2"));
            }
        if(request.getParameter("duplicatep3s3")!=null){
                point11=Integer.parseInt(request.getParameter("duplicatep3s3"));
            }
        if(request.getParameter("duplicatep3s4")!=null){
                point12=Integer.parseInt(request.getParameter("duplicatep3s4"));
            }

        if(request.getParameter("duplicatep4s1")!=null){
                point13=Integer.parseInt(request.getParameter("duplicatep4s1"));
            }
        if(request.getParameter("duplicatep4s2")!=null){
                point14=Integer.parseInt(request.getParameter("duplicatep4s2"));
            }
        if(request.getParameter("duplicatep4s3")!=null){
                point15=Integer.parseInt(request.getParameter("duplicatep4s3"));
            }
        if(request.getParameter("duplicatep4s4")!=null){
                point16=Integer.parseInt(request.getParameter("duplicatep4s4"));
            }
            if(connection!=null){
                pointsUpdatePS=connection.prepareStatement("update VALUE_NONSAP_BUG set p1s1=?,p1s2=?,p1s3=?,p1s4=?,p2s1=?,p2s2=?,p2s3=?,p2s4=?,p3s1=?,p3s2=?,p3s3=?,p3s4=?,p4s1=?,p4s2=?,p4s3=?,p4s4=? where status_id=?");
                pointsUpdatePS.setInt(1,point1);
                pointsUpdatePS.setInt(2,point2);
                pointsUpdatePS.setInt(3,point3);
                pointsUpdatePS.setInt(4,point4);
                pointsUpdatePS.setInt(5,point5);
                pointsUpdatePS.setInt(6,point6);
                pointsUpdatePS.setInt(7,point7);
                pointsUpdatePS.setInt(8,point8);
                pointsUpdatePS.setInt(9,point9);
                pointsUpdatePS.setInt(10,point10);
                pointsUpdatePS.setInt(11,point11);
                pointsUpdatePS.setInt(12,point12);
                pointsUpdatePS.setInt(13,point13);
                pointsUpdatePS.setInt(14,point14);
                pointsUpdatePS.setInt(15,point15);
                pointsUpdatePS.setInt(16,point16);
                pointsUpdatePS.setInt(17,Integer.parseInt(stat));
                int x= pointsUpdatePS.executeUpdate();
                out.println(x);
               

                }

     }
        if(status.equalsIgnoreCase("rejected")){
        if(request.getParameter("rejectedp1s1")!=null){
                point1=Integer.parseInt(request.getParameter("rejectedp1s1"));
            }
        if(request.getParameter("rejectedp1s2")!=null){
                point2=Integer.parseInt(request.getParameter("rejectedp1s2"));
            }
        if(request.getParameter("rejectedp1s3")!=null){
                point3=Integer.parseInt(request.getParameter("rejectedp1s3"));
            }
        if(request.getParameter("rejectedp1s4")!=null){
                point4=Integer.parseInt(request.getParameter("rejectedp1s4"));
            }

        if(request.getParameter("rejectedp2s1")!=null){
                point5=Integer.parseInt(request.getParameter("rejectedp2s1"));
            }
        if(request.getParameter("rejectedp2s2")!=null){
                point6=Integer.parseInt(request.getParameter("rejectedp2s2"));
            }
        if(request.getParameter("rejectedp2s3")!=null){
                point7=Integer.parseInt(request.getParameter("rejectedp2s3"));
            }
        if(request.getParameter("rejectedp2s4")!=null){
                point8=Integer.parseInt(request.getParameter("rejectedp2s4"));
            }

        if(request.getParameter("rejectedp3s1")!=null){
                point9=Integer.parseInt(request.getParameter("rejectedp3s1"));
            }
        if(request.getParameter("rejectedp3s2")!=null){
                point10=Integer.parseInt(request.getParameter("rejectedp3s2"));
            }
        if(request.getParameter("rejectedp3s3")!=null){
                point11=Integer.parseInt(request.getParameter("rejectedp3s3"));
            }
        if(request.getParameter("rejectedp3s4")!=null){
                point12=Integer.parseInt(request.getParameter("rejectedp3s4"));
            }

        if(request.getParameter("rejectedp4s1")!=null){
                point13=Integer.parseInt(request.getParameter("rejectedp4s1"));
            }
        if(request.getParameter("rejectedp4s2")!=null){
                point14=Integer.parseInt(request.getParameter("rejectedp4s2"));
            }
        if(request.getParameter("rejectedp4s3")!=null){
                point15=Integer.parseInt(request.getParameter("rejectedp4s3"));
            }
        if(request.getParameter("rejectedp4s4")!=null){
                point16=Integer.parseInt(request.getParameter("rejectedp4s4"));
            }
            if(connection!=null){
                pointsUpdatePS=connection.prepareStatement("update VALUE_NONSAP_BUG set p1s1=?,p1s2=?,p1s3=?,p1s4=?,p2s1=?,p2s2=?,p2s3=?,p2s4=?,p3s1=?,p3s2=?,p3s3=?,p3s4=?,p4s1=?,p4s2=?,p4s3=?,p4s4=? where status_id=?");
                pointsUpdatePS.setInt(1,point1);
                pointsUpdatePS.setInt(2,point2);
                pointsUpdatePS.setInt(3,point3);
                pointsUpdatePS.setInt(4,point4);
                pointsUpdatePS.setInt(5,point5);
                pointsUpdatePS.setInt(6,point6);
                pointsUpdatePS.setInt(7,point7);
                pointsUpdatePS.setInt(8,point8);
                pointsUpdatePS.setInt(9,point9);
                pointsUpdatePS.setInt(10,point10);
                pointsUpdatePS.setInt(11,point11);
                pointsUpdatePS.setInt(12,point12);
                pointsUpdatePS.setInt(13,point13);
                pointsUpdatePS.setInt(14,point14);
                pointsUpdatePS.setInt(15,point15);
                pointsUpdatePS.setInt(16,point16);
                pointsUpdatePS.setInt(17,Integer.parseInt(stat));
                int x= pointsUpdatePS.executeUpdate();
                out.println(x);

                }

     }
 if(status.equalsIgnoreCase("development")){
        if(request.getParameter("developmentp1s1")!=null){
                point1=Integer.parseInt(request.getParameter("developmentp1s1"));
            }
        if(request.getParameter("developmentp1s2")!=null){
                point2=Integer.parseInt(request.getParameter("developmentp1s2"));
            }
        if(request.getParameter("developmentp1s3")!=null){
                point3=Integer.parseInt(request.getParameter("developmentp1s3"));
            }
        if(request.getParameter("developmentp1s4")!=null){
                point4=Integer.parseInt(request.getParameter("developmentp1s4"));
            }

        if(request.getParameter("developmentp2s1")!=null){
                point5=Integer.parseInt(request.getParameter("developmentp2s1"));
            }
        if(request.getParameter("developmentp2s2")!=null){
                point6=Integer.parseInt(request.getParameter("developmentp2s2"));
            }
        if(request.getParameter("developmentp2s3")!=null){
                point7=Integer.parseInt(request.getParameter("developmentp2s3"));
            }
        if(request.getParameter("developmentp2s4")!=null){
                point8=Integer.parseInt(request.getParameter("developmentp2s4"));
            }

        if(request.getParameter("developmentp3s1")!=null){
                point9=Integer.parseInt(request.getParameter("developmentp3s1"));
            }
        if(request.getParameter("developmentp3s2")!=null){
                point10=Integer.parseInt(request.getParameter("developmentp3s2"));
            }
        if(request.getParameter("developmentp3s3")!=null){
                point11=Integer.parseInt(request.getParameter("developmentp3s3"));
            }
        if(request.getParameter("developmentp3s4")!=null){
                point12=Integer.parseInt(request.getParameter("developmentp3s4"));
            }

        if(request.getParameter("developmentp4s1")!=null){
                point13=Integer.parseInt(request.getParameter("developmentp4s1"));
            }
        if(request.getParameter("developmentp4s2")!=null){
                point14=Integer.parseInt(request.getParameter("developmentp4s2"));
            }
        if(request.getParameter("developmentp4s3")!=null){
                point15=Integer.parseInt(request.getParameter("developmentp4s3"));
            }
        if(request.getParameter("developmentp4s4")!=null){
                point16=Integer.parseInt(request.getParameter("developmentp4s4"));
            }
            if(connection!=null){
                pointsUpdatePS=connection.prepareStatement("update VALUE_NONSAP_BUG set p1s1=?,p1s2=?,p1s3=?,p1s4=?,p2s1=?,p2s2=?,p2s3=?,p2s4=?,p3s1=?,p3s2=?,p3s3=?,p3s4=?,p4s1=?,p4s2=?,p4s3=?,p4s4=? where status_id=?");
                pointsUpdatePS.setInt(1,point1);
                pointsUpdatePS.setInt(2,point2);
                pointsUpdatePS.setInt(3,point3);
                pointsUpdatePS.setInt(4,point4);
                pointsUpdatePS.setInt(5,point5);
                pointsUpdatePS.setInt(6,point6);
                pointsUpdatePS.setInt(7,point7);
                pointsUpdatePS.setInt(8,point8);
                pointsUpdatePS.setInt(9,point9);
                pointsUpdatePS.setInt(10,point10);
                pointsUpdatePS.setInt(11,point11);
                pointsUpdatePS.setInt(12,point12);
                pointsUpdatePS.setInt(13,point13);
                pointsUpdatePS.setInt(14,point14);
                pointsUpdatePS.setInt(15,point15);
                pointsUpdatePS.setInt(16,point16);
                pointsUpdatePS.setInt(17,Integer.parseInt(stat));
                int x= pointsUpdatePS.executeUpdate();
                out.println(x);

                }

     }
if(status.equalsIgnoreCase("workinprogress")){
        if(request.getParameter("workinprogressp1s1")!=null){
                point1=Integer.parseInt(request.getParameter("workinprogressp1s1"));
            }
        if(request.getParameter("workinprogressp1s2")!=null){
                point2=Integer.parseInt(request.getParameter("workinprogressp1s2"));
            }
        if(request.getParameter("workinprogressp1s3")!=null){
                point3=Integer.parseInt(request.getParameter("workinprogressp1s3"));
            }
        if(request.getParameter("workinprogressp1s4")!=null){
                point4=Integer.parseInt(request.getParameter("workinprogressp1s4"));
            }

        if(request.getParameter("workinprogressp2s1")!=null){
                point5=Integer.parseInt(request.getParameter("workinprogressp2s1"));
            }
        if(request.getParameter("workinprogressp2s2")!=null){
                point6=Integer.parseInt(request.getParameter("workinprogressp2s2"));
            }
        if(request.getParameter("workinprogressp2s3")!=null){
                point7=Integer.parseInt(request.getParameter("workinprogressp2s3"));
            }
        if(request.getParameter("workinprogressp2s4")!=null){
                point8=Integer.parseInt(request.getParameter("workinprogressp2s4"));
            }

        if(request.getParameter("workinprogressp3s1")!=null){
                point9=Integer.parseInt(request.getParameter("workinprogressp3s1"));
            }
        if(request.getParameter("workinprogressp3s2")!=null){
                point10=Integer.parseInt(request.getParameter("workinprogressp3s2"));
            }
        if(request.getParameter("workinprogressp3s3")!=null){
                point11=Integer.parseInt(request.getParameter("workinprogressp3s3"));
            }
        if(request.getParameter("workinprogressp3s4")!=null){
                point12=Integer.parseInt(request.getParameter("workinprogressp3s4"));
            }

        if(request.getParameter("workinprogressp4s1")!=null){
                point13=Integer.parseInt(request.getParameter("workinprogressp4s1"));
            }
        if(request.getParameter("workinprogressp4s2")!=null){
                point14=Integer.parseInt(request.getParameter("workinprogressp4s2"));
            }
        if(request.getParameter("workinprogressp4s3")!=null){
                point15=Integer.parseInt(request.getParameter("workinprogressp4s3"));
            }
        if(request.getParameter("workinprogressp4s4")!=null){
                point16=Integer.parseInt(request.getParameter("workinprogressp4s4"));
            }
            if(connection!=null){
                pointsUpdatePS=connection.prepareStatement("update VALUE_NONSAP_BUG set p1s1=?,p1s2=?,p1s3=?,p1s4=?,p2s1=?,p2s2=?,p2s3=?,p2s4=?,p3s1=?,p3s2=?,p3s3=?,p3s4=?,p4s1=?,p4s2=?,p4s3=?,p4s4=? where status_id=?");
                pointsUpdatePS.setInt(1,point1);
                pointsUpdatePS.setInt(2,point2);
                pointsUpdatePS.setInt(3,point3);
                pointsUpdatePS.setInt(4,point4);
                pointsUpdatePS.setInt(5,point5);
                pointsUpdatePS.setInt(6,point6);
                pointsUpdatePS.setInt(7,point7);
                pointsUpdatePS.setInt(8,point8);
                pointsUpdatePS.setInt(9,point9);
                pointsUpdatePS.setInt(10,point10);
                pointsUpdatePS.setInt(11,point11);
                pointsUpdatePS.setInt(12,point12);
                pointsUpdatePS.setInt(13,point13);
                pointsUpdatePS.setInt(14,point14);
                pointsUpdatePS.setInt(15,point15);
                pointsUpdatePS.setInt(16,point16);
                pointsUpdatePS.setInt(17,Integer.parseInt(stat));
                int x= pointsUpdatePS.executeUpdate();
                out.println(x);

                }

     }
if(status.equalsIgnoreCase("codereview")){
        if(request.getParameter("codereviewp1s1")!=null){
                point1=Integer.parseInt(request.getParameter("codereviewp1s1"));
            }
        if(request.getParameter("codereviewp1s2")!=null){
                point2=Integer.parseInt(request.getParameter("codereviewp1s2"));
            }
        if(request.getParameter("codereviewp1s3")!=null){
                point3=Integer.parseInt(request.getParameter("codereviewp1s3"));
            }
        if(request.getParameter("codereviewp1s4")!=null){
                point4=Integer.parseInt(request.getParameter("codereviewp1s4"));
            }

        if(request.getParameter("codereviewp2s1")!=null){
                point5=Integer.parseInt(request.getParameter("codereviewp2s1"));
            }
        if(request.getParameter("codereviewp2s2")!=null){
                point6=Integer.parseInt(request.getParameter("codereviewp2s2"));
            }
        if(request.getParameter("codereviewp2s3")!=null){
                point7=Integer.parseInt(request.getParameter("codereviewp2s3"));
            }
        if(request.getParameter("codereviewp2s4")!=null){
                point8=Integer.parseInt(request.getParameter("codereviewp2s4"));
            }

        if(request.getParameter("codereviewp3s1")!=null){
                point9=Integer.parseInt(request.getParameter("codereviewp3s1"));
            }
        if(request.getParameter("codereviewp3s2")!=null){
                point10=Integer.parseInt(request.getParameter("codereviewp3s2"));
            }
        if(request.getParameter("codereviewp3s3")!=null){
                point11=Integer.parseInt(request.getParameter("codereviewp3s3"));
            }
        if(request.getParameter("codereviewp3s4")!=null){
                point12=Integer.parseInt(request.getParameter("codereviewp3s4"));
            }

        if(request.getParameter("codereviewp4s1")!=null){
                point13=Integer.parseInt(request.getParameter("codereviewp4s1"));
            }
        if(request.getParameter("codereviewp4s2")!=null){
                point14=Integer.parseInt(request.getParameter("codereviewp4s2"));
            }
        if(request.getParameter("codereviewp4s3")!=null){
                point15=Integer.parseInt(request.getParameter("codereviewp4s3"));
            }
        if(request.getParameter("codereviewp4s4")!=null){
                point16=Integer.parseInt(request.getParameter("codereviewp4s4"));
            }
            if(connection!=null){
                pointsUpdatePS=connection.prepareStatement("update VALUE_NONSAP_BUG set p1s1=?,p1s2=?,p1s3=?,p1s4=?,p2s1=?,p2s2=?,p2s3=?,p2s4=?,p3s1=?,p3s2=?,p3s3=?,p3s4=?,p4s1=?,p4s2=?,p4s3=?,p4s4=? where status_id=?");
                pointsUpdatePS.setInt(1,point1);
                pointsUpdatePS.setInt(2,point2);
                pointsUpdatePS.setInt(3,point3);
                pointsUpdatePS.setInt(4,point4);
                pointsUpdatePS.setInt(5,point5);
                pointsUpdatePS.setInt(6,point6);
                pointsUpdatePS.setInt(7,point7);
                pointsUpdatePS.setInt(8,point8);
                pointsUpdatePS.setInt(9,point9);
                pointsUpdatePS.setInt(10,point10);
                pointsUpdatePS.setInt(11,point11);
                pointsUpdatePS.setInt(12,point12);
                pointsUpdatePS.setInt(13,point13);
                pointsUpdatePS.setInt(14,point14);
                pointsUpdatePS.setInt(15,point15);
                pointsUpdatePS.setInt(16,point16);
                pointsUpdatePS.setInt(17,Integer.parseInt(stat));
                int x= pointsUpdatePS.executeUpdate();
                out.println(x);

                }

     }
if(status.equalsIgnoreCase("readytobuild")){
        if(request.getParameter("readytobuildp1s1")!=null){
                point1=Integer.parseInt(request.getParameter("readytobuildp1s1"));
            }
        if(request.getParameter("readytobuildp1s2")!=null){
                point2=Integer.parseInt(request.getParameter("readytobuildp1s2"));
            }
        if(request.getParameter("readytobuildp1s3")!=null){
                point3=Integer.parseInt(request.getParameter("readytobuildp1s3"));
            }
        if(request.getParameter("readytobuildp1s4")!=null){
                point4=Integer.parseInt(request.getParameter("readytobuildp1s4"));
            }

        if(request.getParameter("readytobuildp2s1")!=null){
                point5=Integer.parseInt(request.getParameter("readytobuildp2s1"));
            }
        if(request.getParameter("readytobuildp2s2")!=null){
                point6=Integer.parseInt(request.getParameter("readytobuildp2s2"));
            }
        if(request.getParameter("readytobuildp2s3")!=null){
                point7=Integer.parseInt(request.getParameter("readytobuildp2s3"));
            }
        if(request.getParameter("readytobuildp2s4")!=null){
                point8=Integer.parseInt(request.getParameter("readytobuildp2s4"));
            }

        if(request.getParameter("readytobuildp3s1")!=null){
                point9=Integer.parseInt(request.getParameter("readytobuildp3s1"));
            }
        if(request.getParameter("readytobuildp3s2")!=null){
                point10=Integer.parseInt(request.getParameter("readytobuildp3s2"));
            }
        if(request.getParameter("readytobuildp3s3")!=null){
                point11=Integer.parseInt(request.getParameter("readytobuildp3s3"));
            }
        if(request.getParameter("readytobuildp3s4")!=null){
                point12=Integer.parseInt(request.getParameter("readytobuildp3s4"));
            }

        if(request.getParameter("readytobuildp4s1")!=null){
                point13=Integer.parseInt(request.getParameter("readytobuildp4s1"));
            }
        if(request.getParameter("readytobuildp4s2")!=null){
                point14=Integer.parseInt(request.getParameter("readytobuildp4s2"));
            }
        if(request.getParameter("readytobuildp4s3")!=null){
                point15=Integer.parseInt(request.getParameter("readytobuildp4s3"));
            }
        if(request.getParameter("readytobuildp4s4")!=null){
                point16=Integer.parseInt(request.getParameter("readytobuildp4s4"));
            }
            if(connection!=null){
                pointsUpdatePS=connection.prepareStatement("update VALUE_NONSAP_BUG set p1s1=?,p1s2=?,p1s3=?,p1s4=?,p2s1=?,p2s2=?,p2s3=?,p2s4=?,p3s1=?,p3s2=?,p3s3=?,p3s4=?,p4s1=?,p4s2=?,p4s3=?,p4s4=? where status_id=?");
                pointsUpdatePS.setInt(1,point1);
                pointsUpdatePS.setInt(2,point2);
                pointsUpdatePS.setInt(3,point3);
                pointsUpdatePS.setInt(4,point4);
                pointsUpdatePS.setInt(5,point5);
                pointsUpdatePS.setInt(6,point6);
                pointsUpdatePS.setInt(7,point7);
                pointsUpdatePS.setInt(8,point8);
                pointsUpdatePS.setInt(9,point9);
                pointsUpdatePS.setInt(10,point10);
                pointsUpdatePS.setInt(11,point11);
                pointsUpdatePS.setInt(12,point12);
                pointsUpdatePS.setInt(13,point13);
                pointsUpdatePS.setInt(14,point14);
                pointsUpdatePS.setInt(15,point15);
                pointsUpdatePS.setInt(16,point16);
                pointsUpdatePS.setInt(17,Integer.parseInt(stat));
                int x= pointsUpdatePS.executeUpdate();
                out.println(x);

                }

     }
if(status.equalsIgnoreCase("qa")){
        if(request.getParameter("qap1s1")!=null){
                point1=Integer.parseInt(request.getParameter("qap1s1"));
            }
        if(request.getParameter("qap1s2")!=null){
                point2=Integer.parseInt(request.getParameter("qap1s2"));
            }
        if(request.getParameter("qap1s3")!=null){
                point3=Integer.parseInt(request.getParameter("qap1s3"));
            }
        if(request.getParameter("qap1s4")!=null){
                point4=Integer.parseInt(request.getParameter("qap1s4"));
            }

        if(request.getParameter("qap2s1")!=null){
                point5=Integer.parseInt(request.getParameter("qap2s1"));
            }
        if(request.getParameter("qap2s2")!=null){
                point6=Integer.parseInt(request.getParameter("qap2s2"));
            }
        if(request.getParameter("qap2s3")!=null){
                point7=Integer.parseInt(request.getParameter("qap2s3"));
            }
        if(request.getParameter("qap2s4")!=null){
                point8=Integer.parseInt(request.getParameter("qap2s4"));
            }

        if(request.getParameter("qap3s1")!=null){
                point9=Integer.parseInt(request.getParameter("qap3s1"));
            }
        if(request.getParameter("qap3s2")!=null){
                point10=Integer.parseInt(request.getParameter("qap3s2"));
            }
        if(request.getParameter("qap3s3")!=null){
                point11=Integer.parseInt(request.getParameter("qap3s3"));
            }
        if(request.getParameter("qap3s4")!=null){
                point12=Integer.parseInt(request.getParameter("qap3s4"));
            }

        if(request.getParameter("qap4s1")!=null){
                point13=Integer.parseInt(request.getParameter("qap4s1"));
            }
        if(request.getParameter("qap4s2")!=null){
                point14=Integer.parseInt(request.getParameter("qap4s2"));
            }
        if(request.getParameter("qap4s3")!=null){
                point15=Integer.parseInt(request.getParameter("qap4s3"));
            }
        if(request.getParameter("qap4s4")!=null){
                point16=Integer.parseInt(request.getParameter("qap4s4"));
            }
            if(connection!=null){
                pointsUpdatePS=connection.prepareStatement("update VALUE_NONSAP_BUG set p1s1=?,p1s2=?,p1s3=?,p1s4=?,p2s1=?,p2s2=?,p2s3=?,p2s4=?,p3s1=?,p3s2=?,p3s3=?,p3s4=?,p4s1=?,p4s2=?,p4s3=?,p4s4=? where status_id=?");
                pointsUpdatePS.setInt(1,point1);
                pointsUpdatePS.setInt(2,point2);
                pointsUpdatePS.setInt(3,point3);
                pointsUpdatePS.setInt(4,point4);
                pointsUpdatePS.setInt(5,point5);
                pointsUpdatePS.setInt(6,point6);
                pointsUpdatePS.setInt(7,point7);
                pointsUpdatePS.setInt(8,point8);
                pointsUpdatePS.setInt(9,point9);
                pointsUpdatePS.setInt(10,point10);
                pointsUpdatePS.setInt(11,point11);
                pointsUpdatePS.setInt(12,point12);
                pointsUpdatePS.setInt(13,point13);
                pointsUpdatePS.setInt(14,point14);
                pointsUpdatePS.setInt(15,point15);
                pointsUpdatePS.setInt(16,point16);
                pointsUpdatePS.setInt(17,Integer.parseInt(stat));
                int x= pointsUpdatePS.executeUpdate();
                out.println(x);

                }

     }
if(status.equalsIgnoreCase("performancetesting")){
        if(request.getParameter("performancetestingp1s1")!=null){
                point1=Integer.parseInt(request.getParameter("performancetestingp1s1"));
            }
        if(request.getParameter("performancetestingp1s2")!=null){
                point2=Integer.parseInt(request.getParameter("performancetestingp1s2"));
            }
        if(request.getParameter("performancetestingp1s3")!=null){
                point3=Integer.parseInt(request.getParameter("performancetestingp1s3"));
            }
        if(request.getParameter("performancetestingp1s4")!=null){
                point4=Integer.parseInt(request.getParameter("performancetestingp1s4"));
            }

        if(request.getParameter("performancetestingp2s1")!=null){
                point5=Integer.parseInt(request.getParameter("performancetestingp2s1"));
            }
        if(request.getParameter("performancetestingp2s2")!=null){
                point6=Integer.parseInt(request.getParameter("performancetestingp2s2"));
            }
        if(request.getParameter("performancetestingp2s3")!=null){
                point7=Integer.parseInt(request.getParameter("performancetestingp2s3"));
            }
        if(request.getParameter("performancetestingp2s4")!=null){
                point8=Integer.parseInt(request.getParameter("performancetestingp2s4"));
            }

        if(request.getParameter("performancetestingp3s1")!=null){
                point9=Integer.parseInt(request.getParameter("performancetestingp3s1"));
            }
        if(request.getParameter("performancetestingp3s2")!=null){
                point10=Integer.parseInt(request.getParameter("performancetestingp3s2"));
            }
        if(request.getParameter("performancetestingp3s3")!=null){
                point11=Integer.parseInt(request.getParameter("performancetestingp3s3"));
            }
        if(request.getParameter("performancetestingp3s4")!=null){
                point12=Integer.parseInt(request.getParameter("performancetestingp3s4"));
            }

        if(request.getParameter("performancetestingp4s1")!=null){
                point13=Integer.parseInt(request.getParameter("performancetestingp4s1"));
            }
        if(request.getParameter("performancetestingp4s2")!=null){
                point14=Integer.parseInt(request.getParameter("performancetestingp4s2"));
            }
        if(request.getParameter("performancetestingp4s3")!=null){
                point15=Integer.parseInt(request.getParameter("performancetestingp4s3"));
            }
        if(request.getParameter("performancetestingp4s4")!=null){
                point16=Integer.parseInt(request.getParameter("performancetestingp4s4"));
            }
            if(connection!=null){
                pointsUpdatePS=connection.prepareStatement("update VALUE_NONSAP_BUG set p1s1=?,p1s2=?,p1s3=?,p1s4=?,p2s1=?,p2s2=?,p2s3=?,p2s4=?,p3s1=?,p3s2=?,p3s3=?,p3s4=?,p4s1=?,p4s2=?,p4s3=?,p4s4=? where status_id=?");
                pointsUpdatePS.setInt(1,point1);
                pointsUpdatePS.setInt(2,point2);
                pointsUpdatePS.setInt(3,point3);
                pointsUpdatePS.setInt(4,point4);
                pointsUpdatePS.setInt(5,point5);
                pointsUpdatePS.setInt(6,point6);
                pointsUpdatePS.setInt(7,point7);
                pointsUpdatePS.setInt(8,point8);
                pointsUpdatePS.setInt(9,point9);
                pointsUpdatePS.setInt(10,point10);
                pointsUpdatePS.setInt(11,point11);
                pointsUpdatePS.setInt(12,point12);
                pointsUpdatePS.setInt(13,point13);
                pointsUpdatePS.setInt(14,point14);
                pointsUpdatePS.setInt(15,point15);
                pointsUpdatePS.setInt(16,point16);
                pointsUpdatePS.setInt(17,Integer.parseInt(stat));
                int x= pointsUpdatePS.executeUpdate();
                out.println(x);

                }

     }
if(status.equalsIgnoreCase("verified")){
        if(request.getParameter("verifiedp1s1")!=null){
                point1=Integer.parseInt(request.getParameter("verifiedp1s1"));
            }
        if(request.getParameter("verifiedp1s2")!=null){
                point2=Integer.parseInt(request.getParameter("verifiedp1s2"));
            }
        if(request.getParameter("verifiedp1s3")!=null){
                point3=Integer.parseInt(request.getParameter("verifiedp1s3"));
            }
        if(request.getParameter("verifiedp1s4")!=null){
                point4=Integer.parseInt(request.getParameter("verifiedp1s4"));
            }

        if(request.getParameter("verifiedp2s1")!=null){
                point5=Integer.parseInt(request.getParameter("verifiedp2s1"));
            }
        if(request.getParameter("verifiedp2s2")!=null){
                point6=Integer.parseInt(request.getParameter("verifiedp2s2"));
            }
        if(request.getParameter("verifiedp2s3")!=null){
                point7=Integer.parseInt(request.getParameter("verifiedp2s3"));
            }
        if(request.getParameter("verifiedp2s4")!=null){
                point8=Integer.parseInt(request.getParameter("verifiedp2s4"));
            }

        if(request.getParameter("verifiedp3s1")!=null){
                point9=Integer.parseInt(request.getParameter("verifiedp3s1"));
            }
        if(request.getParameter("verifiedp3s2")!=null){
                point10=Integer.parseInt(request.getParameter("verifiedp3s2"));
            }
        if(request.getParameter("verifiedp3s3")!=null){
                point11=Integer.parseInt(request.getParameter("verifiedp3s3"));
            }
        if(request.getParameter("verifiedp3s4")!=null){
                point12=Integer.parseInt(request.getParameter("verifiedp3s4"));
            }

        if(request.getParameter("verifiedp4s1")!=null){
                point13=Integer.parseInt(request.getParameter("verifiedp4s1"));
            }
        if(request.getParameter("verifiedp4s2")!=null){
                point14=Integer.parseInt(request.getParameter("verifiedp4s2"));
            }
        if(request.getParameter("verifiedp4s3")!=null){
                point15=Integer.parseInt(request.getParameter("verifiedp4s3"));
            }
        if(request.getParameter("verifiedp4s4")!=null){
                point16=Integer.parseInt(request.getParameter("verifiedp4s4"));
            }
            if(connection!=null){
                pointsUpdatePS=connection.prepareStatement("update VALUE_NONSAP_BUG set p1s1=?,p1s2=?,p1s3=?,p1s4=?,p2s1=?,p2s2=?,p2s3=?,p2s4=?,p3s1=?,p3s2=?,p3s3=?,p3s4=?,p4s1=?,p4s2=?,p4s3=?,p4s4=? where status_id=?");
                pointsUpdatePS.setInt(1,point1);
                pointsUpdatePS.setInt(2,point2);
                pointsUpdatePS.setInt(3,point3);
                pointsUpdatePS.setInt(4,point4);
                pointsUpdatePS.setInt(5,point5);
                pointsUpdatePS.setInt(6,point6);
                pointsUpdatePS.setInt(7,point7);
                pointsUpdatePS.setInt(8,point8);
                pointsUpdatePS.setInt(9,point9);
                pointsUpdatePS.setInt(10,point10);
                pointsUpdatePS.setInt(11,point11);
                pointsUpdatePS.setInt(12,point12);
                pointsUpdatePS.setInt(13,point13);
                pointsUpdatePS.setInt(14,point14);
                pointsUpdatePS.setInt(15,point15);
                pointsUpdatePS.setInt(16,point16);
                pointsUpdatePS.setInt(17,Integer.parseInt(stat));
                int x= pointsUpdatePS.executeUpdate();
                out.println(x);

                }

     }
if(status.equalsIgnoreCase("closed")){
        if(request.getParameter("closedp1s1")!=null){
                point1=Integer.parseInt(request.getParameter("closedp1s1"));
            }
        if(request.getParameter("closedp1s2")!=null){
                point2=Integer.parseInt(request.getParameter("closedp1s2"));
            }
        if(request.getParameter("closedp1s3")!=null){
                point3=Integer.parseInt(request.getParameter("closedp1s3"));
            }
        if(request.getParameter("closedp1s4")!=null){
                point4=Integer.parseInt(request.getParameter("closedp1s4"));
            }

        if(request.getParameter("closedp2s1")!=null){
                point5=Integer.parseInt(request.getParameter("closedp2s1"));
            }
        if(request.getParameter("closedp2s2")!=null){
                point6=Integer.parseInt(request.getParameter("closedp2s2"));
            }
        if(request.getParameter("closedp2s3")!=null){
                point7=Integer.parseInt(request.getParameter("closedp2s3"));
            }
        if(request.getParameter("closedp2s4")!=null){
                point8=Integer.parseInt(request.getParameter("closedp2s4"));
            }

        if(request.getParameter("closedp3s1")!=null){
                point9=Integer.parseInt(request.getParameter("closedp3s1"));
            }
        if(request.getParameter("closedp3s2")!=null){
                point10=Integer.parseInt(request.getParameter("closedp3s2"));
            }
        if(request.getParameter("closedp3s3")!=null){
                point11=Integer.parseInt(request.getParameter("closedp3s3"));
            }
        if(request.getParameter("closedp3s4")!=null){
                point12=Integer.parseInt(request.getParameter("closedp3s4"));
            }

        if(request.getParameter("closedp4s1")!=null){
                point13=Integer.parseInt(request.getParameter("closedp4s1"));
            }
        if(request.getParameter("closedp4s2")!=null){
                point14=Integer.parseInt(request.getParameter("closedp4s2"));
            }
        if(request.getParameter("closedp4s3")!=null){
                point15=Integer.parseInt(request.getParameter("closedp4s3"));
            }
        if(request.getParameter("closedp4s4")!=null){
                point16=Integer.parseInt(request.getParameter("closedp4s4"));
            }
            if(connection!=null){
                pointsUpdatePS=connection.prepareStatement("update VALUE_NONSAP_BUG set p1s1=?,p1s2=?,p1s3=?,p1s4=?,p2s1=?,p2s2=?,p2s3=?,p2s4=?,p3s1=?,p3s2=?,p3s3=?,p3s4=?,p4s1=?,p4s2=?,p4s3=?,p4s4=? where status_id=?");
                pointsUpdatePS.setInt(1,point1);
                pointsUpdatePS.setInt(2,point2);
                pointsUpdatePS.setInt(3,point3);
                pointsUpdatePS.setInt(4,point4);
                pointsUpdatePS.setInt(5,point5);
                pointsUpdatePS.setInt(6,point6);
                pointsUpdatePS.setInt(7,point7);
                pointsUpdatePS.setInt(8,point8);
                pointsUpdatePS.setInt(9,point9);
                pointsUpdatePS.setInt(10,point10);
                pointsUpdatePS.setInt(11,point11);
                pointsUpdatePS.setInt(12,point12);
                pointsUpdatePS.setInt(13,point13);
                pointsUpdatePS.setInt(14,point14);
                pointsUpdatePS.setInt(15,point15);
                pointsUpdatePS.setInt(16,point16);
                pointsUpdatePS.setInt(17,Integer.parseInt(stat));
                int x= pointsUpdatePS.executeUpdate();
                out.println(x);

                }

     }


}
catch(Exception e){
        logger.error(e.getMessage());
    }
 finally{
            try{
                if(pointsUpdateRS!=null){
                    pointsUpdateRS.close();
                    }
                }
            catch(SQLException ex){
                logger.error(ex.getMessage());
                }

            try{
                if(pointsUpdatePS!=null){
                    pointsUpdatePS.close();
                    }
                }
            catch(SQLException ex){
                logger.error(ex.getMessage());
                }

            try{
                if(connection!=null){
                    connection.close();
                    }
                }
            catch(SQLException ex){
                logger.error(ex.getMessage());
                }


     }


 %>

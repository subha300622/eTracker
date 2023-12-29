<%@page import="org.apache.log4j.Logger"%>
<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@ page import="pack.eminent.encryption.*"%>
<%@ page import="java.sql.*,java.util.*"%>
<%! Connection connection;
Statement stmt1;
ArrayList<String> al;
ResultSet rs1 =null;
String pname="";
String projecttype="";
String totalprojecttype="";
int count=0;
%>
<%Logger logger = Logger.getLogger("ProjectTypeDetails");
    String cat0=request.getParameter("category");
    try
    {
           al=new ArrayList<String>();
           connection=MakeConnection.getConnection();
           stmt1 = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
           rs1=stmt1.executeQuery("SELECT distinct TYPE FROM PROJECT,PROJECT_TYPE where category='SAP Project' and PROJECT.PID=PROJECT_TYPE.PID ORDER BY TYPE ASC");
           rs1.last();
           int rowcount=rs1.getRow();
           rs1.beforeFirst();
           totalprojecttype=";";
           totalprojecttype=totalprojecttype.trim();
           if (rowcount>=2)
           {
                totalprojecttype=totalprojecttype+"--Select One--"+",";
                count++;
           }
           else if (rowcount==0)
           {
                 totalprojecttype=totalprojecttype+"--Select One--"+",";
                 count++;
           }
           else
                 totalprojecttype=";";
           while(rs1.next())
           {    
        	     projecttype=rs1.getString("TYPE");
                 totalprojecttype=totalprojecttype+projecttype.trim()+",";
                 count++;
           }
           totalprojecttype=totalprojecttype+count;
           al.add(totalprojecttype);
           String f[]=new String[al.size()+1];
           Object a[]=al.toArray();
           f[0]=(String)a[0];
           out.println(f[0]);
           count=0;
           totalprojecttype=";";
   }   
   catch(ArrayIndexOutOfBoundsException e)
   {
          logger.error(e.getMessage());
   }
   finally{
       if (rs1!=null)
           rs1.close();
       if (stmt1!=null)
           stmt1.close();
       if (connection!=null)
           connection.close();
   }
%>


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
String product="";
String totalproduct="";
int count=0;
%>
<%Logger logger = Logger.getLogger("ProductDetails");
    String cat=request.getParameter("category");
	String type=request.getParameter("projecttype");
    try
    {
           al=new ArrayList<String>();
           connection=MakeConnection.getConnection();
           stmt1 = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
           if (cat.equals("SAP Project"))
               rs1=stmt1.executeQuery("SELECT DISTINCT PNAME FROM PROJECT,PROJECT_TYPE WHERE Project.pid=project_type.pid and CATEGORY='"+cat+"' AND TYPE='"+type+"' ORDER BY PNAME ASC");
           else
	           rs1=stmt1.executeQuery("SELECT distinct PNAME FROM PROJECT where category='"+cat+"' and phase not in ('Finished','Closed','Suspended') ORDER BY PNAME ASC");
           rs1.last();
           int rowcount=rs1.getRow();
           rs1.beforeFirst();
           totalproduct=";";
           totalproduct=totalproduct.trim();
           if (rowcount>=2)
           {
                totalproduct=totalproduct+"--Select One--"+",";
                count++;
           }
           else if (rowcount==0)
           {
                 totalproduct=totalproduct+"--Select One--"+",";
                 count++;
           }
           else
           {
                 totalproduct=";";
           }
           while(rs1.next())
           {    
                 product=rs1.getString("PNAME");
                 totalproduct=totalproduct+product.trim()+",";
                 count++;
           }
           totalproduct=totalproduct+count;
           al.add(totalproduct);
           String f[]=new String[al.size()+1];
           Object a[]=al.toArray();
           f[0]=(String)a[0];
           out.println(f[0]);
           count=0;
           totalproduct=";";
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


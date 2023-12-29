<%-- 
    Document   : statusDetails
    Created on : 20 May, 2010, 5:11:59 PM
    Author     : ADAL
--%>
<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@ page import="org.apache.log4j.*,pack.eminent.encryption.*"%>
<%@ page import="java.sql.*,java.util.*,com.eminent.util.GetProjects"%>
<%! Connection connection;
Statement stmt;
ArrayList<String> al;
ResultSet rs =null;
String category =   null;
String details  =   null;
String type  =   null;
String status="";
String totalstatus="";
int count=0;
%>
<%
   Logger logger = Logger.getLogger("statusDetails");
    String prod=request.getParameter("product").trim();
    String ver=request.getParameter("version").trim();
    
   
    try
    {
        connection=MakeConnection.getConnection();

        stmt = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
       if(ver=="All Information" || ver.equalsIgnoreCase("All Information")){
//           System.out.println("Product-->"+prod);
            details    =   GetProjects.getProjectCategory(prod);
        }else{
//            System.out.println("Version-->"+ver);
            details    =   GetProjects.getProjectCategory(prod,ver);
        }
        category    =   details.substring(0, details.indexOf(":"));
        type        =   details.substring(details.indexOf(":")+1,details.length());

        if(category.equalsIgnoreCase("SAP Project") && (type.equalsIgnoreCase("Implementation") || type.equalsIgnoreCase("Updradation"))){
            rs  =   stmt.executeQuery("select status from SAP_IMPLEM_STATUS_MASTER order by status_id");
        }
        else if(category.equalsIgnoreCase("SAP Project") && type.equalsIgnoreCase("Support") ){
             rs  =   stmt.executeQuery("select status from SAP_SUPPORT_STATUS_MASTER order by status_id");
        }
        else if(category.equalsIgnoreCase("Project")||category.equalsIgnoreCase("Product")){
             rs  =   stmt.executeQuery("select status from STATUS_MASTER order by status_id");
        }else{
            rs  =   stmt.executeQuery("select status from SAP_NONSAP_STATUS_LIST order by status_id");
        }
        al=new ArrayList<String>();
        rs.last();
        int rowcount=rs.getRow();
        rs.beforeFirst();

        totalstatus=";";//rowcount+",";
        totalstatus=totalstatus.trim();
        if (rowcount>=2)
        {
            totalstatus=totalstatus+"All Information"+","+"Open Issues"+",";
            count++;
        }
        else if (rowcount==0)
        {
            totalstatus=totalstatus+"All Information"+","+"Open Issues"+",";
            count++;
        }
        else
            totalstatus=";";
        while(rs.next())
        {
            status=rs.getString("status");
            totalstatus=totalstatus+status.trim()+",";
            count++;
        }
        totalstatus=totalstatus+count;
        al.add(totalstatus);
        String f[]=new String[al.size()+1];
        Object a[]=al.toArray();
        f[0]=(String)a[0];
   //     System.out.println(f[0]);
        out.println(f[0]);
        count=0;
        totalstatus=";";
   }
   catch(ArrayIndexOutOfBoundsException e)
   {
         logger.error(e.getMessage());
   }
   finally{
        if (rs!=null)
        rs.close();
        if (stmt!=null)
        stmt.close();
        if (connection!=null)
        connection.close();
   }
%>


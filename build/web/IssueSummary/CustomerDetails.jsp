<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@ page import="org.apache.log4j.*,pack.eminent.encryption.*"%>
<%@ page import="java.sql.*,java.util.*"%>

<%
   Logger logger = Logger.getLogger("CustomerDetails");
    Connection connection = null;
    Statement stmt1 = null;
    ArrayList<String> al;
    ResultSet rs1 =null;
    String customer="";
    String totalcustomer="";
    int count=0;
    try{ 
            connection=MakeConnection.getConnection();
            String prod[]=(request.getParameter("product").split(","));
            int uid      = (Integer)session.getAttribute("userid_curr"); 
            int roleId   = (Integer)session.getAttribute("Role");
            stmt1 = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
            String prod1="";
            for(int i=0;i<prod.length;i++){
                prod1=prod1+"'"+prod[i].trim()+"',";
                
            }
            if(prod1.length()>3){
                prod1=prod1.substring(0,prod1.length()-1);
               
            }else{
                prod1="";
            }
            if(prod1.equals("'All Information'")){
                 rs1 = stmt1.executeQuery("SELECT DISTINCT CUSTOMER FROM PROJECT WHERE PNAME IN ( SELECT PNAME  FROM PROJECT P, USERPROJECT UP WHERE P.PID = UP.PID AND UP.USERID = "+uid+" ) ORDER BY UPPER(CUSTOMER) ASC");
            }else if(!prod1.equalsIgnoreCase(""))
            {
                    rs1 = stmt1.executeQuery("SELECT DISTINCT CUSTOMER FROM PROJECT WHERE PNAME in ("+ prod1+") ORDER BY UPPER(CUSTOMER) ASC");
            }
            else
            {
                if( roleId == 1) {
                      rs1 = stmt1.executeQuery("SELECT DISTINCT CUSTOMER FROM PROJECT ORDER BY UPPER(CUSTOMER) ASC");  
                } else {
                      rs1 = stmt1.executeQuery("SELECT DISTINCT CUSTOMER FROM PROJECT WHERE PNAME IN ( SELECT PNAME  FROM PROJECT P, USERPROJECT UP WHERE P.PID = UP.PID AND UP.USERID = "+uid+" ) ORDER BY UPPER(CUSTOMER) ASC");
                }
            }
            
            
            al=new ArrayList<String>();
            rs1.last();
            int rowcount=rs1.getRow();
            rs1.beforeFirst();
            totalcustomer=";";//rowcount+",";
        totalcustomer=totalcustomer.trim();
        if (rowcount>=2)
        {
            totalcustomer=totalcustomer+"All Information"+",";
            count++;
        }
        else if (rowcount==0)
        {
            totalcustomer=totalcustomer+"All Information"+",";
            count++;
        }
        else
            totalcustomer=";";
        while(rs1.next())
        {    
            customer=rs1.getString("CUSTOMER");
            totalcustomer=totalcustomer+customer.trim()+",";
            count++;
        }
        totalcustomer=totalcustomer+count;
        al.add(totalcustomer);
        String f[]=new String[al.size()+1];
        Object a[]=al.toArray();
        f[0]=(String)a[0];
       // System.out.println(f[0]);
        out.println(f[0]);
        count=0;
        totalcustomer=";";
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


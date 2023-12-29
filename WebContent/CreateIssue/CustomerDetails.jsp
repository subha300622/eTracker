<%@page import="org.apache.log4j.Logger"%>
<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@ page import="pack.eminent.encryption.*"%>
<%@ page import="java.sql.*,java.util.*"%>
<%! Connection connection;
Statement stmt1;
ArrayList<String> al;
ResultSet rs1 =null;
String customer="";
String totalcustomer="";
int count=0;
%>
<%Logger logger = Logger.getLogger("CustomerDetails");
            String prod=(request.getParameter("product")).trim();
            String cat=request.getParameter("category");
            String type=request.getParameter("projecttype");
            
            try{
                   al=new ArrayList<String>();
                   connection=MakeConnection.getConnection();
                   stmt1 = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
                   if (cat.equals("SAP Project"))
                       rs1=stmt1.executeQuery("SELECT DISTINCT CUSTOMER FROM PROJECT,PROJECT_TYPE WHERE  PROJECT.PID = PROJECT_TYPE.PID AND CATEGORY='"+cat+"' AND TYPE='"+type+"' AND PNAME='"+ prod+"' GROUP BY CUSTOMER ORDER BY UPPER(CUSTOMER)");
                   else
               	   	   rs1=stmt1.executeQuery("SELECT DISTINCT CUSTOMER FROM PROJECT WHERE CATEGORY='"+cat+"' AND PNAME='"+ prod+"' and phase not in ('Finished','Closed','Suspended') GROUP BY CUSTOMER ORDER BY UPPER(CUSTOMER)");					                	   
                   rs1.last();
                   int rowcount=rs1.getRow();
                   rs1.beforeFirst();
                    totalcustomer=";";//rowcount+",";
                    totalcustomer=totalcustomer.trim();
                    if (rowcount>=2)
                    {
                        totalcustomer=totalcustomer+"--Select One--"+",";
                        count++;
                    }
                    else if (rowcount==0)
                    {
                        totalcustomer=totalcustomer+"--Select One--"+",";
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
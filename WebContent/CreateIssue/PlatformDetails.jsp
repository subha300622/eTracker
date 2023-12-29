<%@page import="org.apache.log4j.Logger"%>
<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@ page import="pack.eminent.encryption.*"%>
<%@ page import="java.sql.*,java.util.*"%>


<%! 
    Connection connection;
    Statement stmt1;
    ArrayList<String> al;
    ResultSet rs1 =null;
    String platform="";
    String totalplatform="";
    int count=0;
%>
<%Logger logger = Logger.getLogger("PlatformDetails");
			 String cat=request.getParameter("category").trim();
             String cus=request.getParameter("customer").trim();
             String prod=request.getParameter("product").trim();
             String ver=request.getParameter("version").trim();
             String type=request.getParameter("projecttype").trim();
             try{
                   count=0;
                   al=new ArrayList<String>();
                   connection=MakeConnection.getConnection();
                   stmt1 = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
                   if (cat.equals("SAP Project"))
                       rs1=stmt1.executeQuery("SELECT DISTINCT PLATFORM FROM PROJECT,PROJECT_TYPE WHERE  PROJECT.PID = PROJECT_TYPE.PID AND CATEGORY='"+cat+"' and CUSTOMER='"+cus+"' and version='"+ver+"' AND TYPE='"+type+"' AND PNAME='"+ prod+"' GROUP BY PLATFORM ORDER BY UPPER(PLATFORM)");
                   else
                   	   rs1=stmt1.executeQuery("SELECT DISTINCT PLATFORM FROM PROJECT WHERE CATEGORY='"+cat+"' and CUSTOMER='"+cus+"' and PNAME='"+prod+"' and version='"+ver+"' and phase not in ('Finished','Closed','Suspended') GROUP BY PLATFORM ORDER BY UPPER(PLATFORM)");
                   rs1.last();
                   int rowcount=rs1.getRow();
                   rs1.beforeFirst();
                   totalplatform=";";//rowcount+",";
                    totalplatform=totalplatform.trim();
                    if (rowcount>=2)
                    {
                        totalplatform=totalplatform+"--Select One--"+",";
                        count++;
                    }
                    else if (rowcount==0)
                    {
                        totalplatform=totalplatform+"--Select One--"+",";
                        count++;
                    }
                    else
                        totalplatform=";";
                    while(rs1.next())
                    {    
                        platform=rs1.getString("PLATFORM");
                        totalplatform=totalplatform+platform.trim()+",";
                        count++;
                    }
                    totalplatform=totalplatform+count;
                    al.add(totalplatform);
                    String f[]=new String[al.size()+1];
                    Object a[]=al.toArray();
                    f[0]=(String)a[0];
                    out.println(f[0]);
                    count=0;
                    totalplatform=";";
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


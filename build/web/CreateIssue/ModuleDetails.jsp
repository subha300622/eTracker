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
    String modules="";
    String totalmodules="";
    int count=0;
%>
<%
           Logger logger = Logger.getLogger("ModuleDetails");  
             String prod=request.getParameter("product").trim();
             String ver=request.getParameter("version").trim();
             
             try{
                   al=new ArrayList<String>();
                   connection=MakeConnection.getConnection();
                   stmt1 = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
                   rs1 = stmt1.executeQuery("SELECT DISTINCT MODULES.MODULE FROM MODULES, PROJECT WHERE PNAME='"+prod+"' and version='"+ver+"' and modules.pid=project.pid and phase not in ('Finished','Closed','Suspended','End of Life') GROUP BY Modules.MODULE ORDER BY UPPER(MODULE)");
                   rs1.last();
                   int rowcount=rs1.getRow();
                   rs1.beforeFirst();
                   totalmodules=";";//rowcount+",";
                   totalmodules=totalmodules.trim();
                    if (rowcount>=2)
                   {   
                        totalmodules=totalmodules+"--Select One--"+",";
                        count++;
                    }
                    else if (rowcount==0)
                    {
                        totalmodules=totalmodules+"--Select One--"+",";
                        count++;
                    }
                    else
                        totalmodules=";";
                    while(rs1.next())
                    {    
                        modules=rs1.getString("MODULE");
                        totalmodules=totalmodules+modules.trim()+",";
                        count++;
                    }
                    totalmodules=totalmodules+count;
                    al.add(totalmodules);
                    String f[]=new String[al.size()+1];
                    Object a[]=al.toArray();
                    f[0]=(String)a[0];
                    out.println(f[0]);
                    count=0;
                    totalmodules=";";
                }
                catch(ArrayIndexOutOfBoundsException e)
                {
                        logger.error(e.getMessage());
                }
                finally
                {
                         if (rs1!=null)
                                rs1.close();
                         if (stmt1!=null)
                              stmt1.close();
                         if (connection!=null)
                               connection.close();
                }
%>


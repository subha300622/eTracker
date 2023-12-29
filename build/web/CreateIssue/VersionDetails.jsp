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
    String version="";
    String totalversion="";
    int count=0;
%>
<%Logger logger = Logger.getLogger("VersionDetails");
            
            String prod=request.getParameter("product").trim();
            Integer current_userId      = (Integer)session.getAttribute("userid_curr"); 
            int userId = 0;
            if(current_userId != null){
                userId = current_userId.intValue();
            }
            
            try{
                   al=new ArrayList<String>();
                   connection=MakeConnection.getConnection();
                   stmt1 = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
                   rs1=stmt1.executeQuery("SELECT DISTINCT VERSION FROM PROJECT P, USERPROJECT U WHERE USERID = "+ userId+" AND P.PID = U.PID AND PNAME='"+ prod+"' and status not in ('Finished','Closed','Suspended','End of Life') GROUP BY VERSION");					                	   
                   rs1.last();
                   int rowcount=rs1.getRow();
                   rs1.beforeFirst();
                   totalversion=";";//rowcount+",";
                    totalversion=totalversion.trim();
                    if (rowcount>=2)
                    {
                        count++;
                    }
                    else if (rowcount==0)
                    {
                        totalversion=totalversion+"--Select One--"+",";
                        count++;
                    }
                    else
                        totalversion=";";
                    while(rs1.next())
                    {    
                        version=rs1.getString("VERSION");
                        totalversion=totalversion+version.trim()+",";
                        count++;
                    }
                    totalversion=totalversion+count;
                    al.add(totalversion);
                    String f[]=new String[al.size()+1];
                    Object a[]=al.toArray();
                    f[0]=(String)a[0];
                    out.println(f[0]);
                    count=0;
                    totalversion=";";
                
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


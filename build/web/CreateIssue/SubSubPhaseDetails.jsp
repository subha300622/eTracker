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
    String subsubphase="";
    String totalsubsubphase="";
    int count=0;
%>
<%Logger logger = Logger.getLogger("SubSubPhaseDetails");
             String type=request.getParameter("projecttype").trim();
             String projecttypename="PROJECT_"+type.toUpperCase();
             String phase=request.getParameter("phase").trim();
             String subphase=request.getParameter("subphase").trim();
             try{
                   count=0;
                   al=new ArrayList<String>();
                   if (type.toUpperCase().equals("IMPLEMENTATION"))
                   {
                        connection=MakeConnection.getConnection();
                        stmt1 = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
                   
                       rs1 = stmt1.executeQuery("SELECT DISTINCT SUBSUBPHASE,SUBSUBPHASEINDEX FROM "+projecttypename+" WHERE PHASE='"+phase +"' and SUBPHASE='"+subphase +"' ORDER BY SUBSUBPHASEINDEX");
                        rs1.last();
                       int rowcount=rs1.getRow();
                       rs1.beforeFirst();
                       totalsubsubphase=";";//rowcount+",";
                        totalsubsubphase=totalsubsubphase.trim();
                        if (rowcount>=2)
                        {
                            totalsubsubphase=totalsubsubphase+"--Select One--"+",";
                            count++;
                        }
                        else if (rowcount==0)
                        {
                            totalsubsubphase=totalsubsubphase+"--Select One--"+",";
                            count++;
                        }
                        else
                            totalsubsubphase=";";
                        while(rs1.next())
                        {    
                            subsubphase=rs1.getString("subsubphase");
                            if(subsubphase != null){
                            totalsubsubphase=totalsubsubphase+subsubphase.trim()+",";
                            count++;
                            }
                            if(subsubphase == null){
                                totalsubsubphase=totalsubsubphase+"--Select One--"+",";
                                count++;
                            }
                        }
                        totalsubsubphase=totalsubsubphase+count;
                        al.add(totalsubsubphase);
                        String f[]=new String[al.size()+1];
                        Object a[]=al.toArray();
                        f[0]=(String)a[0];
                        out.println(f[0]);
                        count=0;
                        totalsubsubphase=";";
                        }
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


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
    String subsubsubphase="";
    String totalsubsubsubphase="";
    int count=0;
%>
<%Logger logger = Logger.getLogger("SubSubSubPhaseDetails");
             String type=request.getParameter("projecttype").trim();
             String projecttypename="PROJECT_"+type.toUpperCase();
             String phase=request.getParameter("phase").trim();
             String subphase=request.getParameter("subphase").trim();
             String subsubphase=request.getParameter("subsubphase").trim();
 //            System.out.println("subsubsubphase"+type+phase+subphase+subsubphase);
             try{
                   count=0;
                   al=new ArrayList<String>();
                   if (type.toUpperCase().equals("IMPLEMENTATION"))
                   {
                        connection=MakeConnection.getConnection();
                        stmt1 = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
                   
                       rs1 = stmt1.executeQuery("SELECT  DISTINCT SUBSUBSUBPHASE,SUBSUBSUBPHASEINDEX FROM "+projecttypename+" WHERE PHASE='"+phase +"' and SUBPHASE='"+subphase +"'  and SUBSUBPHASE='"+subsubphase +"' ORDER BY SUBSUBSUBPHASEINDEX");
                        rs1.last();
                       int rowcount=rs1.getRow();
 //                       System.out.println("Total SUBSUBSUBPHASE:"+rowcount);
                       rs1.beforeFirst();
                       totalsubsubsubphase=";";//rowcount+",";
                        totalsubsubsubphase=totalsubsubsubphase.trim();
                        if (rowcount>=2)
                        {
                            totalsubsubsubphase=totalsubsubsubphase+"--Select One--"+",";
                            count++;
                        }
                        else if (rowcount==0)
                        {
                            totalsubsubsubphase=totalsubsubsubphase+"--Select One--"+",";
                            count++;
                        }
                        else
                            totalsubsubsubphase=";";
                        while(rs1.next())
                        {    
                            subsubsubphase=rs1.getString("subsubsubphase");
                            if(subsubsubphase != null){
                            totalsubsubsubphase=totalsubsubsubphase+subsubsubphase.trim()+",";
                            count++;
                            }
                            if(subsubsubphase == null){
                                totalsubsubsubphase=totalsubsubsubphase+"--Select One--"+",";
                                count++;
                            }
                        }
                        totalsubsubsubphase=totalsubsubsubphase+count;
                        al.add(totalsubsubsubphase);
                        String f[]=new String[al.size()+1];
                        Object a[]=al.toArray();
                        f[0]=(String)a[0];
 //                       System.out.println(f[0]);
                        out.println(f[0]);
                        count=0;
                        totalsubsubsubphase=";";
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


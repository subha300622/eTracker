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
    String phase="";
    String totalphase="";
    int count=0;
%>
<%Logger logger = Logger.getLogger("PhaseDetails");
             String type=request.getParameter("projecttype").trim();
             String projecttypename="PROJECT_"+type.toUpperCase();
             try{
                   count=0;
                   al=new ArrayList<String>();
                   if (type.toUpperCase().equals("IMPLEMENTATION") ||  type.toUpperCase().equals("UPGRADATION") || type.toUpperCase().equals("SUPPORT"))
                   {
                       connection=MakeConnection.getConnection();
                       stmt1 = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);

                           rs1 = stmt1.executeQuery("SELECT DISTINCT PHASE,PHASEINDEX FROM "+projecttypename+" ORDER BY PHASEINDEX");
                       rs1.last();
                       int rowcount=rs1.getRow();
//                        System.out.println("Total PHASE:"+rowcount);
                       rs1.beforeFirst();
                       totalphase=";";//rowcount+",";
                        totalphase=totalphase.trim();
                        if (rowcount>=2)
                        {
                            totalphase=totalphase+"--Select One--"+",";
                            count++;
                        }
                        else if (rowcount==0)
                        {
                            totalphase=totalphase+"--Select One--"+",";
                            count++;
                        }
                        else
                            totalphase=";";
                        while(rs1.next())
                        {    
                            phase=rs1.getString("phase");
                            totalphase=totalphase+phase.trim()+",";
                            count++;
                        }
                        totalphase=totalphase+count;
                        al.add(totalphase);
                        String f[]=new String[al.size()+1];
                        Object a[]=al.toArray();
                        f[0]=(String)a[0];
 //                       System.out.println(f[0]);
                        out.println(f[0]);
                        count=0;
                        totalphase=";";
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


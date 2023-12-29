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
    String subphase="";
    String totalsubphase="";
    int count=0;
%>
<%Logger logger = Logger.getLogger("SubPhaseDetails");
             String type=request.getParameter("projecttype").trim();
             String projecttypename="PROJECT_"+type.toUpperCase();
             String phase=request.getParameter("phase").trim();
          //   System.out.println("subphase"+type+phase);
             try{
                   count=0;
                   al=new ArrayList<String>();
                   if (type.toUpperCase().equals("IMPLEMENTATION") ||  type.toUpperCase().equals("UPGRADATION") || type.toUpperCase().equals("SUPPORT"))
                   {
                       connection=MakeConnection.getConnection();
                  
                        stmt1 = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
                   
                       rs1 = stmt1.executeQuery("SELECT DISTINCT SUBPHASE,SUBPHASEINDEX FROM "+projecttypename+" WHERE PHASE='"+phase +"' ORDER BY SUBPHASEINDEX");
                       rs1.last();
                       int rowcount=rs1.getRow();
//                       System.out.println("Total SUBPHASE:"+rowcount);
                       rs1.beforeFirst();
                       totalsubphase=";";//rowcount+",";
                        totalsubphase=totalsubphase.trim();
                        if (rowcount>=2)
                        {
                            totalsubphase=totalsubphase+"--Select One--"+",";
                            count++;
                        }
                        else if (rowcount==0)
                        {
                            totalsubphase=totalsubphase+"--Select One--"+",";
                            count++;
                        }
                        else
                            totalsubphase=";";
                        while(rs1.next())
                        {    
                            subphase=rs1.getString("subphase");
                            if(subphase != null){
                                totalsubphase=totalsubphase+subphase.trim()+",";
                                count++;
                                    }
                                    if(subphase == null){
                                    totalsubphase=totalsubphase+"--Select One--"+",";
                                    count++;
                                    }
                        }
                        totalsubphase=totalsubphase+count;
                        al.add(totalsubphase);
                        String f[]=new String[al.size()+1];
                        Object a[]=al.toArray();
                        f[0]=(String)a[0];
  //                      System.out.println(f[0]);
                        out.println(f[0]);
                        count=0;
                        totalsubphase=";";
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


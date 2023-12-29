<%@page import="org.apache.log4j.Logger"%>
package MyAssignment;

<%-- 
    Document   : assignedToDetails
    Created on : May 25, 2009, 10:30:57 AM
    Author     : Tamilvelan
--%>

<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@ page import="pack.eminent.encryption.*"%>
<%@ page import="java.sql.*,java.util.*,com.eminent.util.GetProjectMembers"%>


<%!
    Connection connection;
    Statement stmt1;
    ArrayList<String> al;
    ResultSet rs1 =null;
    String modules="";
    String totalmodules="";
    String users        =   ";";
    String manager      =   null;
    String createdby    =   null;
    String assignedto   =   null;
    String assigned     =   null;
    String pid          =   null;
    int count=0;
%>
<%Logger logger = Logger.getLogger("assignedToDetails");

             String issueid=request.getParameter("issueid").trim();
             String status=request.getParameter("status").trim();
 //            System.out.println("Status"+status);

             try{
                   al=new ArrayList<String>();
                   connection=MakeConnection.getConnection();
                   stmt1 = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
                   rs1 = stmt1.executeQuery("select i.pid as pid,createdby,assignedto,pmanager from issue i,project p where issueid='"+issueid+"' and i.pid=p.pid");
                  
                    while(rs1.next())
                    {
                        pid         =   rs1.getString("pid");
                        manager     =   rs1.getString("pmanager");
                        createdby   =   rs1.getString("createdby");
                        assigned    =   rs1.getString("assignedto");
                    }
                   
                   if(GetProjectMembers.isUserActive(createdby)){
                       createdby=createdby;
 //                      System.out.println("Created by created");
                   }else{
                       createdby=manager;
 //                      System.out.println("Created by Manager");
                   }
                   if(GetProjectMembers.isUserActive(assigned)){
                       assigned=assigned;
                   }else{
                       assigned=manager;
                   }

                   manager      =   manager+"-"+GetProjectMembers.getUserName(manager);
                   createdby    =   createdby+"-"+GetProjectMembers.getUserName(createdby);
                   assignedto   =   assigned+"-"+GetProjectMembers.getUserName(assigned);

          
                    if(status.equalsIgnoreCase("Unconfirmed")){
                      
                        users=users+manager+",";
                    }else if(status.equalsIgnoreCase("Solution Review")){
                      
                        users=users+manager+",";
                        
                    }
                    else if(status.equalsIgnoreCase("Duplicate")){

                        users=users+createdby+",";

                    }
                   else if(status.equalsIgnoreCase("Rejected")){
                       
                       users=users+createdby+",";
                   }
                   else if(status.equalsIgnoreCase("Verified")){
                       
                       users=users+createdby+",";
  //                     System.out.println("Created by"+users);
                   }
                   else{
  //                      System.out.println("Details Page user value before"+users);
                       users=users+GetProjectMembers.getMembers(pid);
  //                      System.out.println("Details Page user value After"+users);
                   }
                   users=users+assigned+";";
                   
                    al.add(users);
                    String f[]=new String[al.size()+1];
                    Object a[]=al.toArray();
                    f[0]=(String)a[0];
 //                   System.out.println(f[0]);
                    out.println(f[0]);
                    count=0;
                    totalmodules=";";
                    users        =   ";";
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



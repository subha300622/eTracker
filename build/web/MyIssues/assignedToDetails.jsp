<%-- 
    Document   : assignedToDetails
    Created on : May 25, 2009, 10:30:57 AM
    Author     : Tamilvelan
--%>

<%@page import="org.apache.log4j.Logger"%>
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
    String pname        =   null;
    int count=0;
%>
<%Logger logger = Logger.getLogger("assignedToDetails");

             String issueid=request.getParameter("issueid").trim();
             String status=request.getParameter("status").trim();
  //           System.out.println("Status"+status);

             try{
                   al=new ArrayList<String>();
                   connection=MakeConnection.getConnection();
                   stmt1 = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
                   rs1 = stmt1.executeQuery("select i.pid as pid,createdby,assignedto,pmanager,pname from issue i,project p where issueid='"+issueid+"' and i.pid=p.pid");
                  
                    while(rs1.next())
                    {
                        pid         =   rs1.getString("pid");
                        manager     =   rs1.getString("pmanager");
                        createdby   =   rs1.getString("createdby");
                        assigned    =   rs1.getString("assignedto");
                        pname       =   rs1.getString("pname");
                    }
                   String createdbyUserid   =   createdby;
                   if(GetProjectMembers.isUserActive(createdby)){
                       createdby=createdby;
                      
                   }else{
                       createdby=manager;
                       
                   }
                   if(GetProjectMembers.isUserActive(assigned)){
                       assigned=assigned;
                   }else{
                       assigned=manager;
                   }
//                    System.out.println("Manager"+manager);
 //                   System.out.println("Created by"+createdby);
 //                   System.out.println("Assigned to"+assigned);

                   manager      =   manager+"-"+GetProjectMembers.getUserName(manager);
                   createdby    =   createdby+"-"+GetProjectMembers.getUserName(createdby);
                   assignedto   =   assigned+"-"+GetProjectMembers.getUserName(assigned);

 //                   System.out.println("Manager After"+manager);
 //                   System.out.println("Created by After"+createdby);
 //                   System.out.println("Assigned to After"+assignedto);
                   
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
                   }
                   else{
                      
                       users=users+GetProjectMembers.getMembers(pid);
                        if(pname.equalsIgnoreCase("eTracker")){

                                if(!GetProjectMembers.isAssigned(createdbyUserid,pid)&&GetProjectMembers.isUserActive(createdbyUserid)){
                                    users=users+createdby+",";
                                }
                       }
                   }
                   users=users+assigned+";";
                   
                    al.add(users);
                    String f[]=new String[al.size()+1];
                    Object a[]=al.toArray();
                    f[0]=(String)a[0];
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



 <%@page import="org.apache.log4j.Logger"%>
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
  
    ArrayList<String> al;
   
    String users        =   ";";
  
    int count=0;
%>
<%Logger logger = Logger.getLogger("assignedToDetails");

             try{
                   al=new ArrayList<String>();
                   


  
                       users=users+GetProjectMembers.getEminentMembers();
  
                   
                   users=users+";";
                   
                    al.add(users);
                    String f[]=new String[al.size()+1];
                    Object a[]=al.toArray();
                    f[0]=(String)a[0];
 //                   System.out.println(f[0]);
                    out.println(f[0]);
                    count=0;
                    
                    users        =   ";";
                }
                catch(ArrayIndexOutOfBoundsException e)
                {
                        logger.error(e.getMessage());
                }
               
%>



<%-- 
    Document   : managerDetails
    Created on : 10 Jul, 2010, 9:29:44 AM
    Author     : Tamilvelan
--%>
<%@page import="org.apache.log4j.Logger"%>
<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@ page import="pack.eminent.encryption.*"%>
<%@ page import="java.sql.*,java.util.*,com.eminent.util.GetProjectMembers"%>


<%!
    ArrayList<String> al;
    String totalmanagers="";
    int count=0;
%>
<%Logger logger = Logger.getLogger("managerDetails");

             String prodid=request.getParameter("product").trim();
 //            System.out.println("Product Id"+prodid);

             try{
                 HashMap managerList=GetProjectMembers.getProjectManagers(prodid);
                   al=new ArrayList<String>();
                   int rowcount=managerList.size();
                   totalmanagers=";";//rowcount+",";
                   totalmanagers=totalmanagers.trim();
                    if (rowcount>=2)
                   {
                        totalmanagers=totalmanagers;
                        count++;
                    }
                    else if (rowcount==0)
                    {
                        totalmanagers=totalmanagers;
                        count++;
                    }
                    else
                        totalmanagers=";";
                    Collection se=managerList.keySet();
                    Iterator iter=se.iterator();
                    while (iter.hasNext()) {

                      int managerid=(Integer)iter.next();
                      String managers=(String)managerList.get(managerid);
                       
                        managers=managerid+"*"+managers;
                        totalmanagers=totalmanagers+managers.trim()+",";
                        count++;
                    }
                    totalmanagers=totalmanagers+count;
                    al.add(totalmanagers);
                    String f[]=new String[al.size()+1];
                    Object a[]=al.toArray();
                    f[0]=(String)a[0];
 //                   System.out.println(f[0]);
                    out.println(f[0]);
                    count=0;
                    totalmanagers=";";
                }
                catch(ArrayIndexOutOfBoundsException e)
                {
                        logger.error(e.getMessage());
                }
                
%>



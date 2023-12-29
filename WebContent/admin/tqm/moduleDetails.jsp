<%-- 
    Document   : moduleDetails
    Created on : Dec 1, 2009, 7:01:16 PM
    Author     : Administrator
--%>

<%@page import="org.apache.log4j.Logger"%>
<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@ page import="pack.eminent.encryption.*"%>
<%@ page import="java.sql.*,java.util.*,com.eminent.util.GetProjects"%>

<%!
    ArrayList<String> al;
    String totalmodules="";
    int count=0;
%>
<%Logger logger = Logger.getLogger("moduleDetails");

             String prodid=request.getParameter("product").trim();
 //            System.out.println("Product Id"+prodid);

             try{
                 HashMap moduleList=GetProjects.getModules(prodid);
                   al=new ArrayList<String>();
                   int rowcount=moduleList.size();
                   totalmodules=";";//rowcount+",";
                   totalmodules=totalmodules.trim();
                    if (rowcount>=2)
                   {
                        totalmodules=totalmodules;
                        count++;
                    }
                    else if (rowcount==0)
                    {
                        totalmodules=totalmodules;
                        count++;
                    }
                    else
                        totalmodules=";";
                    Collection se=moduleList.keySet();
                    Iterator iter=se.iterator();
                    while (iter.hasNext()) {

                      String moduleid=(String)iter.next();
                      String modules=(String)moduleList.get(moduleid);

                        modules=moduleid+"*"+modules;
                        totalmodules=totalmodules+modules.trim()+",";
                        count++;
                    }
                    totalmodules=totalmodules+count;
                    al.add(totalmodules);
                    String f[]=new String[al.size()+1];
                    Object a[]=al.toArray();
                    f[0]=(String)a[0];
 //                   System.out.println(f[0]);
                    out.println(f[0]);
                    count=0;
                    totalmodules=";";
                }
                catch(ArrayIndexOutOfBoundsException e)
                {
                        logger.error(e.getMessage());
                }

%>



<%-- 
    Document   : updatedUserDetails
    Created on : 20 Apr, 2015, 1:28:57 PM
    Author     : EMINENT
--%>

<%@page import="com.eminent.issue.ApmTeam"%>
<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@ page import="org.apache.log4j.*,pack.eminent.encryption.*"%>
<%@ page import="java.sql.*,java.util.*"%>
    <jsp:useBean id="atc" class="com.eminent.issue.controller.ApmTeamController"></jsp:useBean>


<%! Connection connection;
    Statement stmt1;
    ResultSet rs1;
    ArrayList<String> al;
    String assigned="";
    String totalassigned="";

%>
<%Logger logger = Logger.getLogger("updatedUserDetails");
                                         String mail = (String) session.getAttribute("theName");
                                        String url = null;
                                        if (mail != null) {
                                            url = mail.substring(mail.indexOf("@") + 1, mail.length());
                                        } 

    try
    {
            connection=MakeConnection.getConnection();
            
            String prod[]=(request.getParameter("product").split(","));
            String prod1="";
            for(int i=0;i<prod.length;i++){
                prod1=prod1+"'"+prod[i].trim()+"',";
            }
            if(prod1.length()>3){
                prod1=prod1.substring(0,prod1.length()-1);
            }else{
                prod1="'All Information'";
            }
             /*edit by sowjanya*/
            if(prod1.equals("'All Information'")){
                
                stmt1 = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
              //     rs1 = stmt1.executeQuery("select distinct firstname,lastname,commentedby from users,issue where to_char(userid) = assignedto order by firstname");
                       rs1 = stmt1.executeQuery("select distinct firstname,lastname,commentedby from users,issue i,issuecomments ic,project where to_char(userid) = ic.commentedby and i.issueid=ic.issueid and project.pid=i.pid order by firstname");

            }else /*edit by sowjanya*/
            { 
                stmt1 = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
                rs1 = stmt1.executeQuery("select distinct firstname,lastname,commentedby from users,issue i,issuecomments ic,project where to_char(userid) = ic.commentedby and i.issueid=ic.issueid and project.pid=i.pid and project.pname in("+prod1+") order by firstname");
            }
            
            al=new ArrayList<String>();
            rs1.last();
            int rowcount=rs1.getRow();
            rs1.beforeFirst();
            totalassigned=rowcount+",";
            if (url.equals("eminentlabs.net")) {
                   totalassigned    = totalassigned+"Client Users -- Client Users,";
                   totalassigned    = totalassigned+"Internal Users -- Internal Users,";
            }
            while(rs1.next())
            {
                assigned=rs1.getString("commentedby")+"--"+rs1.getString("firstname")+" "+rs1.getString("lastname");
                totalassigned=totalassigned+assigned.trim()+",";
            }
              for (ApmTeam apmTeam : atc.findAllTeams()) {
                                               
            assigned = apmTeam.getTeamName() + "-TEAM --" + apmTeam.getTeamName();
            totalassigned = totalassigned + assigned.trim() + ",";                                    
          }
            
            al.add(totalassigned);
            String f[]=new String[al.size()+1];
            Object a[]=al.toArray();
            f[0]=(String)a[0];
         //   System.out.println(f[0]);
            out.println(f[0]);
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

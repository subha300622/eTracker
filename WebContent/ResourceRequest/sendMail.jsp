<%-- 
    Document   : sendMail
    Created on : 16 Nov, 2010, 3:59:54 PM
    Author     : Tamilvelan
--%>
<%@ page import="com.pack.*,java.util.*,org.apache.log4j.*,java.sql.*,pack.eminent.encryption.*,java.text.*,com.eminent.util.*,com.eminent.resource.*, com.pack.eminent.applicant.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<jsp:useBean id="ResourceRequest" class="com.eminent.resource.ResourceRequestBean" />

<%
    Logger logger = Logger.getLogger("sendMail.jsp");
    String requestid = request.getParameter("requestid");
    session.setAttribute("requestid", requestid);
    
    Connection connection = null, connection1 = null;
    PreparedStatement ps = null;
    ResultSet rs = null, rs1 = null;
    Statement st1 = null;
    try {
        
        String project = null;
        String team = null;
        String position = null;
        String skillset = null;
        String responsibility_p1 = null;
        String responsibility_p2 = null;
        String responsibility_p3 = null;
        String responsibility_p4 = null;
        String responsibility_p5 = null;
        String responsibility_s1 = null;
        String responsibility_s2 = null;
        String responsibility_s3 = null;
        String responsibility_s4 = null;
        String responsibility_s5 = null;
        
        String createdon = null;
        String modifiedon = null;
        
        String createdby = null;
        String assignedto = null;
        
        String duedate = null;
        String exp_years = null;
        String exp_months = null;
        
        try {
            
            SimpleDateFormat sdf = new SimpleDateFormat("d-M-yyyy");
            
            connection = MakeConnection.getConnection();
//		connection1=MakeConnection.getSAPConnection();

            if (connection != null) {
                
                rs = ResourceRequest.editRequest(connection, requestid);
                if (rs != null) {
                    rs.next();
                    
                    position = rs.getString("position");
                    skillset = rs.getString("skillset");
                    
                    exp_years = rs.getString("exp_years");
//				

                    responsibility_p1 = rs.getString("responsibility_p1");
                    responsibility_p2 = rs.getString("responsibility_p2");
                    responsibility_p3 = rs.getString("responsibility_p3");
                    responsibility_p4 = rs.getString("responsibility_p4");
                    responsibility_p5 = rs.getString("responsibility_p5");
                    
                    responsibility_s1 = rs.getString("responsibility_s1");
                    responsibility_s2 = rs.getString("responsibility_s2");
                    responsibility_s3 = rs.getString("responsibility_s3");
                    responsibility_s4 = rs.getString("responsibility_s4");
                    responsibility_s5 = rs.getString("responsibility_s5");
                    String htmlContent = "<b><font color=blue >Project Details</font></b><table width=100% >"
                            + "<tr bgcolor=#E8EEF7 ><td width = 18% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 ><b>Position</b></td>"
                            + "<td width = 32% ><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + position + "</td>"
                            + "</tr>"
                            + "</tr>";
                    
                }
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
        }
    } catch (Exception ex) {
        logger.error(ex.getMessage());
    }  finally
                        {
                            if(ps!=null)
                                   ps.close();
                            if(rs!=null)
                                        rs.close();
                                if(connection!=null)
                                        connection.close();
			
                        }
    
%>
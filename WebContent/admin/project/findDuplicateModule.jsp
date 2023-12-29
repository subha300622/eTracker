<%-- 
    Document   : findDuplicateModule
    Created on : Jan 2, 2014, 1:11:19 PM
    Author     : E0288
--%>

<%@page import="org.apache.log4j.Logger"%>
<%@page import="pack.eminent.encryption.MakeConnection"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

        <jsp:useBean id="getConnect" class="com.pack.AdminBean">
                <jsp:setProperty name="getConnect" property="*" />
        </jsp:useBean>
        <%
Connection  connection = null;
	Logger logger = Logger.getLogger("File Upload");
try  
	{
	
		Integer pids=Integer.valueOf(request.getParameter("pid"));
	
		int pid=pids.intValue();
		String mname = request.getParameter("module");
		if( mname != null) {
                    mname = mname.trim();
                }
		connection=MakeConnection.getConnection();
        boolean state = getConnect.ModuleExist(connection,mname,pid);
        out.print(state);
        }

		catch(Exception ex)  {
			logger.error(ex.getMessage());
	    }finally
				{
					if (connection!=null)
					{
						connection.close();
					}
				}

	%>
  
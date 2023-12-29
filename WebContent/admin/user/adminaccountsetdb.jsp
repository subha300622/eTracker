<%@page import="org.apache.log4j.Logger"%>
<%@ page language="java" contentType="text/html"
	pageEncoding="UTF-8"%>
<%@ page import="pack.eminent.encryption.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>

<meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
<meta http-equiv="Content-Type" content="text/html ">
<TITLE>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS
Solution</TITLE>
</head>

<body>

<!-- Start of Java Coding -->

<!-- Java Package Import Declarations -->
<%@ page import="java.sql.*"%>

<!-- Notifying JSP to use AdminBean Class in the Package Named com.pack -->

<jsp:useBean id="Admin" scope="page" class="com.pack.AdminBean">
	<jsp:setProperty name="Admin" property="*" />
</jsp:useBean>



<%! 	
		Connection  connection = null;
	%>
<%Logger logger = Logger.getLogger("adminaccountsetdb");
		//Start Of Try Block
		
		try  {
				//Declaring Connection and String Variables
				connection = MakeConnection.getConnection();
				
				String email=request.getParameter("userEmail");
		
				
				
				//connection = Admin.ConnectToDatabase();  //Get Connection from ConnectToDatabase() Method in AdminBean 
				
				//Start Of IF Block That Checks Whether the Connection Does Have any Value
				
				if(connection != null)  {
					
					//Calling UserExist() Method in AdminBean and Assigned it to a Boolean value
					
					boolean state = Admin.AdminExist(connection,email);//Checks whether the User already exists in the DB
					
					//Start Of IF Block That Checks Whether the Boolean state is True
					
					if(state == true)  {
	%>
<!-- if user exists Forward To userexist.jsp Page  -->

<jsp:forward page="/userexist.jsp" />
<%  
					}
					//End Of If(state == true)
					
					//State == False Enter Else Block and Get Input Values from Form 
					else  {
						
						Admin.CreateAdmin(connection,email);
						
						//If the user is not in DB Get Input Values from Previous page
	%>
<!-- The User Input Values are passed to the AdminBean Using Jsp Property tag -->

<jsp:getProperty name="Admin" property="firstName" />
<jsp:getProperty name="Admin" property="lastName" />
<jsp:getProperty name="Admin" property="password" />
<jsp:getProperty name="Admin" property="userEmail" />
<jsp:getProperty name="Admin" property="company" />
<jsp:getProperty name="Admin" property="secret" />
<jsp:getProperty name="Admin" property="answer" />
<jsp:getProperty name="Admin" property="phone" />
<jsp:getProperty name="Admin" property="phone1" />
<jsp:getProperty name="Admin" property="phone2" />
<jsp:getProperty name="Admin" property="mobile" />
<jsp:getProperty name="Admin" property="mobile1" />
<jsp:getProperty name="Admin" property="operator" />
<jsp:forward page="adminaccountsuccess.jsp" />
<%
					}
					//End Of Else Block
				}
				//End of Coonection Value Checking IF Block
				
			}
			//End of Try Block
			
			//Handles Any Exception Arises During the Execution
			catch(Exception e)  {
				logger.error(e.getMessage());
			}
				finally
				{
					if (connection!=null)
					{
						connection.close();
					}
				}
	%>
<!-- End of Java Coding -->

</body>

</html>
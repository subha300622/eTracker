<%@ page language="java" contentType="text/html"
	pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
<meta http-equiv="Content-Type" content="text/html ">
<LINK title=STYLE href="eminentech support files/main_ie.css"
	type=text/css rel=STYLESHEET>
</head>
<body>
<!-- Java Package Import Declarations -->

<%@ page import="java.io.*, org.apache.log4j.*"%>

<%


        //Configuring log4j properties

			

			Logger logger = Logger.getLogger("domainConfig");
			

        String domainname = request.getParameter("domainname");
		
		String mailserver = request.getParameter("mailserver");
		
		String contextRootPath = this.getServletContext().getRealPath("/");
		
		String filepath ="";
		
		try {
			File file1 = new File(contextRootPath,"/configuration");
	            
	        // Create file if it does not exist
	        boolean dir = file1.mkdir();
	        if(dir)  {
	        	//       	
	        }
	        else  {
	        	
	        }
	        String path = contextRootPath +"/configuration";
	        File file = new File(path,"/domains.xml");
	        boolean success = file.createNewFile();
	        if (success) {
	            // File did not exist and was created
	        } else {
	            // File already exists
	        }
	        filepath =  file.getPath();
	      
	    } catch (IOException e) {
	    }
		
		try {
			
			OutputStream fout= new FileOutputStream(filepath);
	        OutputStream bout= new BufferedOutputStream(fout);
	        OutputStreamWriter out1 = new OutputStreamWriter(bout, "8859_1");
	        
	      	//Unique for Whole Document
	        out1.write("<?xml version=\"1.0\" ");
	        out1.write("encoding=\"UTF-8\"?>\r\n");  
	        out1.write("<E-Tracker-Configuration>\r\n");  
	        
	        int i = 1;
	        //for loop i varies	       
	        out1.write("  <Domain index=\"" + i + "\">");
	        out1.write(domainname);
	        out1.write("  </Domain>\r\n");
	        //for loop i varies
	        out1.write("  <MailServerName index=\"" + i + "\">");
	        out1.write(mailserver);
	        out1.write("  </MailServerName>\r\n");
	        
	    	//Unique for Whole Document
	        out1.write("</E-Tracker-Configuration>\r\n"); 
	        out1.flush();  // Don't forget to flush!
	        out1.close();

	      }
	      catch (UnsupportedEncodingException e) {
            logger.error("This VM does not support the Latin-1 character set.", e);
	      }
	      catch (IOException e) {
	        logger.error(e);
	      }
	      response.sendRedirect("setup.jsp");
%>



</body>
</html>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
        <title>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS Solution</title>
        <LINK title=STYLE href="<%= request.getContextPath()%>/eminentech support files/main_ie.css" type="text/css" rel=STYLESHEET>
        <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/checkSubmit.js"></script>
        <%@ page import="org.apache.log4j.*,java.util.Enumeration"%>
        <%@ page autoFlush="true" buffer="1094kb"%>
        <%
          //Configuring log4j properties

	

          Logger logger = Logger.getLogger("fileAttach");
	
          String logoutcheck=(String)session.getAttribute("Name");
          if(logoutcheck==null)
          {
                  logger.fatal("=========================Session Expired======================");
        %>
        <jsp:forward page="../SessionExpired.jsp"></jsp:forward>
        <%
                        //response.sendRedirect(request.getContextPath()+"/SessionExpired.jsp");
                }
        
        %>
        <SCRIPT LANGUAGE="JavaScript">
parent.treeframe.location.reload();
            function validate()
            {
var extensions = new Array("docm","dotm","dotx","potm","potx","ppam","ppsm","ppsx","pptm","pptx","xlam","xlsb","xlsm","xltm","xltx","xps","xls","xlsx","xlsm","doc","docx","bmp","jpg","jpeg","gif","png","bmp","pdf","txt","mht","zip","rar","htm","ppt","pptx","tif","chm","rtf","html","pps","sql","war","uml","xps","xml","avi","idc","msg","csv");

                //*
                // Alternative way to create the array

                //var extensions = new Array();
                /*
                 extensions[0] = "xls";
                 extensions[1] = "xlsx";
                 extensions[2] = "doc";
                 extensions[3] = "docx";
                 extensions[4] = "bmp";
                 extensions[5] = "jpg";
                 extensions[6] = "jpeg";
                 extensions[7] = "gif";
                 extensions[8] = "png";
                 extensions[9] = "bmp";
                 extensions[10] = "pdf";
                 extensions[11] = "txt";
                 extensions[12] = "mht";
                 extensions[13] = "zip";
                 extensions[14] = "rar";
                 extensions[15] = "htm";
                 extensions[16] = "ppt";
                 extensions[17] = "pptx";
                 extensions[18] = "tif";
                 extensions[19] = "chm";
                 extensions[20] = "rtf";
                 extensions[21] = "html";
                 extensions[22] = "pps";
                 extensions[23] = "sql";
                 extensions[24] = "war";
                 extensions[25] = "uml";
                 extensions[26] = "xps";
                 extensions[27] = "xml";
                 extensions[28] = "avi";
                 */
                var image_file = document.form.image_file.value;

                var image_length = document.form.image_file.value.length;

                var pos = image_file.lastIndexOf('.') + 1;

                var ext = image_file.substring(pos, image_length);

                var final_ext = ext.toLowerCase();

                for (i = 0; i < extensions.length; i++)
                {
                    if (extensions[i] === final_ext)
                    {
                        document.getElementById('submit').value = 'Processing';
                        document.getElementById('submit').disabled = true;
                        document.getElementById('progressbar').style.visibility = 'visible';
                        return true;
                    }
                }

                alert("You must upload a file with one of the following extensions: " + extensions.join(', ') + ".");
                return false;
            }
            //-->

        </SCRIPT>

    </HEAD>

    <BODY>
        <%@ include file="header.jsp"%>
        <%
          String actionURL="fileUpload.jsp";
          String attach=request.getParameter("attach");
          String issueId = null;
      String myAssignmentIssueId = null;
      String myIssueId = null;
      String teamInputIssueId = null;
      String createIssueId = null;
      String resourceId = null;
      String dashboardIssueId =   null;

      myAssignmentIssueId = (String)session.getAttribute("myAssignmentIssueId");

   

      if(myAssignmentIssueId == null) {
          myIssueId = (String)session.getAttribute("myIssueId");
       
          if(myIssueId == null) {
              teamInputIssueId = (String)session.getAttribute("teamInputIssueId");

              if (teamInputIssueId == null) {
                   createIssueId = (String)session.getAttribute("createIssueId");
                   if(createIssueId == null) {
                       dashboardIssueId   =   (String)session.getAttribute("theissu");
                       if(dashboardIssueId!=null){
                           issueId = dashboardIssueId;
                           session.removeAttribute("theissu");
                       }else{
                          resourceId = (String)session.getAttribute("resourceId");
                          issueId = resourceId;
                          session.removeAttribute("resourceId");
                       }
                   }else{
                       issueId = createIssueId;
                       session.removeAttribute("createIssueId");
                    
                   }
              } else {
                  issueId = teamInputIssueId;
                  session.removeAttribute("teamInputIssueId");
                }
          } else {
              issueId = myIssueId;
              session.removeAttribute("myIssueId");
            }
        
      } else {
          issueId = myAssignmentIssueId;
          session.removeAttribute("myAssignmentIssueId");
        }

      if(issueId != null) {
          session.setAttribute("issueIdToAttach", issueId);
      }
          logger.info("Issue Id:"+issueId);
          logger.info("Upload Action:"+actionURL);
        %>
        <table cellpadding="0" cellspacing="0" width="100%">
            <tr border="2" bgColor="#C3D9FF">
                <td bgcolor="#C3D9FF" border="1" align="left" width="100%"><font
                        size="4" COLOR="#0000FF"><b>Upload File </b></font></td>
            </tr>
        </table>
        </br>
        </br>
        </br>
        <%
        if (attach.equals("yes"))
  {
        %>
        <center>
        <!--<FORM name="filesForm" action=<%=actionURL%> method="post" onSubmit='return validateUpload();' enctype="multipart/form-data">-->
            <form name="form" action=<%=actionURL%> enctype="multipart/form-data" method="post" onSubmit="return validate();">
                <table>
                    <table width="100%" align=center border="0" bgcolor="#E8EFF7">
                        <tr align="center">
                            <td><BR>
                                <FONT SIZE="4" COLOR="#33CC33"><b> Enter the Filename to
                                        upload</b></FONT><BR>
                            </td>
                        </tr>
                        <tr>
                            <td align="center"><b>Attach:</b>
                                <input type="file" id="image_file" name="image_file" /></td>
                            <!--                            <input type="file" id="file1" name="file1" onkeypress="this.blur();" onPaste="return false"/>-->
                            </td>
                        </tr>
                        <tr>
                            <td align=center><FONT SIZE="4" COLOR="#330000"><b>File
                                        type should be .txt, .doc, .gif, image files( .jpg, .bmp,...). and
                                        It's size should be less than 12MB(aprox.)</b></FONT></td>
                        </tr>
                        <tr>

                            <td align="center">
                                <input type="submit" id="submit" name="submit" value="Upload File" />

                            </td>
                        </tr>
                        <tr>
                            <td align="center"><img id="progressbar" style='visibility: hidden;' src='/eTracker/images/file-progress.gif'/></td>
                        </tr>
                    </table>
                </table>
            </FORM>
        </center>
        <%}
        else {
	
            //Removing the Issue Id if the user doesn't want to attach another file
                Enumeration names = session.getAttributeNames();
                boolean flag = false;
                while(names.hasMoreElements()) {
                    if((names.nextElement().toString()).equalsIgnoreCase("issueIdToAttach")) {
                        flag = true;
                    }
			
                        }
                issueId =   (String)session.getAttribute("issueIdToAttach");
                if(flag == true) {
                    session.removeAttribute("issueIdToAttach");
                }
                String link=(String)session.getAttribute("forwardpage");
                //Please add below line when issue id is missed this page is link to createissueup.jsp
        
        
                        //session.getAttribute("forwardpage") is null by default page is forwarding to My Assignment page 
                        if(link==null){
                            link="/MyAssignment/UpdateIssue.jsp";
                        }
                        if(!link.contains("?")){
                            link    =   link+"?issueId="+issueId;
                        }
       
                        logger.info("forward page"+link);
        %>
        <jsp:forward page="<%=link%>">
            <jsp:param name="flag" value="true"/>
        </jsp:forward>


        <%
	
        }
        %>
    </BODY>

</HTML>
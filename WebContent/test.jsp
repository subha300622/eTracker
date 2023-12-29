<%@page import="java.io.OutputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.File"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html><meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America"><TITLE>Eminentlabs? SAP Offerings :: NW based Product Development | Consulting | Implementation | Support Services | Outsourcing</TITLE>
<Meta name="keywords" content="NW based Product Development, Consulting, Implementation, Support Services, Outsourcing">
<Meta name="description" content="Eminentlabs? is the No 1 provider of integrated business, technology and process solutions on a global delivery platform.">

<style>
	.hide {
	visibility: hidden;
	position: absolute;
	
}
</style><title>Eminentlabs? Software Private Limited</title>


<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="style.css" rel="stylesheet" type="text/css">

<script language="javascript">
	function showDiv() {
		var el;
		el = eval(document.getElementById('tab1'));
		el.style.display = "block"; /* hide the div with id divcontainer */
	}
	
	function hideDiv() {
		var el;
		el = eval(document.getElementById('tab1'));
		el.style.display = "none"; /* hide the div with id divcontainer */
	}
</script>

<script language="Javascript">
function forgotPassword()
  	{
		window.open('eTracker/UserProfile/forgotpassword.jsp',null,"left=371,top=180,height=300,width=400,status=no,toolbar=no,menubar=no,location=no,titlebar=no,resizable=no,screenX=10,screenY=360");
	}
var isNS = (navigator.appName == "Netscape") ? 1 : 0;
var EnableRightClick = 0;
if(isNS) 
document.captureEvents(Event.MOUSEDOWN||Event.MOUSEUP);
function mischandler(){
  if(EnableRightClick==1){ return true; }
  else {return false; }
}
function mousehandler(e){
  if(EnableRightClick==1){ return true; }
  var myevent = (isNS) ? e : event;
  var eventbutton = (isNS) ? myevent.which : myevent.button;
  if((eventbutton==2)||(eventbutton==3)) return false;
}
function keyhandler(e) {
  var myevent = (isNS) ? e : window.event;
  if (myevent.keyCode==96)
    EnableRightClick = 1;
  return;
}
document.oncontextmenu = mischandler;
document.onkeypress = keyhandler;
document.onmousedown = mousehandler;
document.onmouseup = mousehandler;

</script>
<style type="text/css">
<!--
.style2 {font-size: 12px}
.style3 {color: #006699}
-->
</style>
<%

try{

		String pdfFileName = "pdf-test.pdf";
		String contextPath = getServletContext().getRealPath(File.separator);
		File pdfFile = new File(contextPath + pdfFileName);

		response.setContentType("application/vnd.pdf");
		response.addHeader("Content-Disposition", "attachment; filename=" + pdfFileName);
		response.setContentLength((int) pdfFile.length());

		FileInputStream fileInputStream = new FileInputStream(pdfFile);
		OutputStream responseOutputStream = response.getOutputStream();
		int bytes;
		while ((bytes = fileInputStream.read()) != -1) {
			responseOutputStream.write(bytes);
		}

	}

catch(Exception ex){
}
%>
</head><body topmargin="0" rightmargin="0" bottommargin="0" leftmargin="0" ondragstart="return false" onselectstart="return false" >

<!-- Website header -->
<table border="0" bordercolor="#993300" cellpadding="0" cellspacing="0" width="100%">
  <tbody><tr>
    <td align="center">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
  <tbody><tr bgcolor="#FFFFFF"><td>
  		<table width="100%" border="0">
  		<tr>   
			<td><table width="100%" border="0">
  			<tr>   
				<td class="Text" align="center" bgcolor="#FFFFFF" height="20" width="143"><a href="./index.htm">					<strong>Home</strong></a></td>
				<td>|</td>
				<td class="Textblack" align="center" bgcolor="#FFFFFF" height="10" width="143"><a href="./aboutus.htm"><strong>About Us</strong></a></td>
				<td>|</td>
				 <td class="Textblack" align="center" bgcolor="#FFFFFF" height="10" width="143"><a href="./news.htm"><strong>News</strong></a></td>
				 <td>|</td>
				 <td class="Textblack" align="center" bgcolor="#FFFFFF" height="10" width="143"><a href="./careers.htm"><strong>Careers</strong></a></td>
				 <td>|</td>
				 <td class="Textblack" align="center" bgcolor="#FFFFFF" height="10" width="143"><a href="./contactus.htm"><strong>Contact Us</strong></a></td>
				 <td class="Textblack" align="center" bgcolor="#FFFFFF" height="10" width="143"></td>
				 <td class="Textblack" align="center" bgcolor="#FFFFFF" height="10" width="143"></td>
				 <td class="Textblack" align="center" bgcolor="#FFFFFF" height="10" width="143"></td>
				 <td class="Textblack" align="center" bgcolor="#FFFFFF" height="10" width="143"></td>
			</tr>
			<tr><td>&nbsp;</td></tr>
			</table></td>
    		 <td align="right"><img src="eminentlabs_logo.gif" alt="Eminentlabs? Software Pvt Ltd"></td>
  		</tr>
		</table>
		</td>  	
  </tr>

<!-- Website header end -->



<!-- Website menu start -->

  <tr>
  	<td>
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
		<tbody>
		<tr><td>
		<table cellpadding="0" cellspacing="0" width="100%">
		 <tbody>
        <tr>
  	     <td>
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
		<tbody><tr>
		<td>
		<table cellpadding="0" cellspacing="0" width="100%">
	 <tbody><tr>
    <td class="Text" bgcolor="#b2d1e3" height="5" width="443"><img src="spacer.gif"></td>
    <td class="Text" bgcolor="#92e3e4" height="5" width="443"><img src="spacer.gif"></td>
    <td class="Text" bgcolor="#aad4a2" height="5" width="443"><img src="spacer.gif"></td>
    <td class="Text" bgcolor="#ffe8ab" height="5" width="443"><img src="spacer.gif"></td>
    <td class="Text" bgcolor="#f0f0f0" height="5" width="443"><img src="spacer.gif"></td>
  </tr>
  <tr><td><img src="spacer.gif"></td></tr>
  <tr>
    <td class="TextWhite" align="center" bgcolor="#1072a1" height="20" width="143"><a href="./products.htm"><strong>Products</strong></a></td>
    <td class="TextWhite" align="center" bgcolor="#00a2a5" height="10" width="143"><a href="./services.htm"><strong>Services</strong></a></td>
    <td class="TextWhite" align="center" bgcolor="#22980c" height="10" width="143"><a href="./clientsall.htm"><strong>Clients</strong></a></td>
    <td class="TextWhite" align="center" bgcolor="#f8b800" height="10" width="143"><a href="./partners.htm"><strong>Partners</strong></a></td>
    <td class="TextWhite" align="center" bgcolor="#c2c2c2" height="10" width="143"><a 
	href="./programs.htm"><strong>Programs </strong></a></td>
  </tr>
  </tbody></table>
  </td>
  </tr>
  <tr>
  	<td colspan="5" bgcolor="#f8f7d9"><img src="spacer.gif" height="5" width="1"></td>
  </tr>



  </tbody></table>
  </td>
  </tr>
<!-- Test End -->

<!-- Website menu end -->


<!-- Website left menu start -->

  <tr>
  	<td colspan="5">
		<table border="0" cellpadding="0" cellspacing="1" width="100%">
  <tbody>

  <tr>
    <td bgcolor="#ecf1f7" valign="top" width="22%">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
  <tbody>
  
    <!-- Products start -->
	<!--
   <tr>
    <td>
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
  <tbody><tr>
    <td height="20" align="center" bgcolor="#b9dbf6" class="headtext"><strong>Products</strong></td>
  </tr>
  <tr>
    <td>
		<table border="0" cellpadding="4" cellspacing="2" width="100%">
		<tbody><tr><td class="Text"><img src="spacer.gif" height="5" width="1"></td></tr>
  <tr>
	<td class="Text"><a href="./eOutsource.htm"><font color="#006699">eOutsource?</font></a></td>
  </tr>
   <tr>
	<td class="Text"><a href="./eTracker.htm"><font color="#006699">eTracker?</font></a></td>
  </tr>
  <tr><td class="Text"><img src="spacer.gif" height="5" width="1"></td></tr>
</tbody></table>
	</td>
  </tr>
</tbody></table>

	</td>
  </tr>
<!-- Products end -->

   <!-- Services start -->
  
   <tr>
    <td>
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
  <tbody><tr>
    <td class="headtext" align="center" bgcolor="#b9dbf6" height="20"><strong>SAP Services</strong></td>
  </tr>
  <tr>
    <td><table border="0" cellpadding="4" cellspacing="0" width="100%">
  <tbody>
    <tr><td class="Text"><img src="spacer.gif" height="5" width="1"></td></tr>
  <tr><td class="Text"><a href="./RS_product.htm"><font color="#006699">&nbsp;NW based Product Development </font></a></td>
  </tr>
   <tr>
    <td class="Text"><a href="./RS_CnI.htm"><font color="#006699">&nbsp;Consulting & Integration </font></a></td>
  </tr>
   <tr>
   <td class="Text"><a href="./RS_support.htm"><font color="#006699">&nbsp;Implementation & Upgrade </font></a></td>
  </tr>
   <tr>
   <td class="Text"><a href="./RS_outsourcing.htm"><font color="#006699">&nbsp;Support Services </font></a></td>
  </tr>
  <!--
  <tr>
   <td class="Text"><a href="http://www.eminentlabs.com/eTracker/admin/customer/addlead.jsp?username=sales" onclick="window.open(this.href,'child','height='+screen.height+',width='+screen.width+',fullscreen,resizable=yes'); return false"><font color="#006699"><strong>&nbsp;Explore Eminent Services</strong></font></a></td>
  </tr>
  -->
    <tr><td class="Text"><img src="spacer.gif" height="5" width="1"></td></tr>
</tbody></table>
</td>
  </tr>
</tbody></table>

	</td>
  </tr>
   <!-- Services end -->


  
  <!-- client start -->
  <tr>
    <td>
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
  <tbody><tr>
    <td height="20" align="center" bgcolor="#b9dbf6" class="headtext"><strong>Clients</strong></td>
  </tr>
   <!--
   <tr>
    <td align="center"><img src="spacer.gif" height="20" width="1"></td>
  </tr>
  -->
  <tr>
    <td align="center"><img src="customers.gif" border="0" alt="Eminentlabs? Customers"></td>
  </tr>
  <!--
   <tr>
    <td align="center"><img src="spacer.gif" height="25" width="1"></td>
  </tr>
  -->
</tbody></table>

	</td>
  </tr>

  <!-- clients end -->

    <!-- Testimonials start -->
  <tr><td><img src="images/spacer.gif" height="10" width="1"></td></tr>
  <tr>
    <td>
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
  <tbody><tr>
    <td class="Text" align="center" bgcolor="#b9dbf6" height="20"><strong>Testimonials</strong></td>
  </tr>
    <tr><td class="Text"><img src="images/spacer.gif" height="5" width="1"></td></tr>
  <tr>
    <td>
		<table border="0" cellpadding="2" cellspacing="0" width="100%">
		<tbody>
		<tr>
    <td class="Text"><marquee  scrollamount="2" 
direction="up" loop="true"  > 
<p align="justify"><strong><font color="#006699">The Depot Sales Project Delivered,</font></strong>
  in phases 1) Depot Sales Import 2) Stock Transfer from Plant to Depot 3) Stock Transfer from Depot to Depot 4) Stock Transfer from Depot to Plant 5) Domestic Purchase to Depot and 6) Tailored Solution for Profitability Analysis is functioning well to the satisfaction of our colleagues. The Project execution methodology and the efforts put by your team in understanding the custom requirements of each plant and the meticulous testing processes has left with an ever lasting impression on Eminentlabs?. </strong>
    <DIV align=right><EM><font color="#006699">- Director, GM-IT, Sr.Manager Finance, Continental Automotive</font></EM></DIV></p>
<p align="justify"><strong><font color="#006699">The Results of SAP delivery,</font></strong>
  for our asset retirement and re-upload project in phases was found to be good. All the five phases have been well executed. We appreciate the expertise on the subject matter and team members efforts for their timely & continuos support provided.</strong>
  
  <DIV align=right><EM><font color="#006699">- Manager Finance, Continental Automotive</font></EM></DIV></p>

<p align="justify"><strong><font color="#006699">The delivery by your Company,</font></strong>
  for updation of Purchase Order Condition & MIRO transaction in the existing SAP system at our organisation is functioning well in Logistics department,  resulting in reduction of the cycle time from 60 ? 90 minutes to just     2 - 3 minutes time. We appreciate your team members for the efforts and timely support in this regard.</strong>
  
  <DIV align=right><EM><font color="#006699">- DGM-IT, Continental Automotive</font></EM></DIV></p>
    <p align="justify"><strong><font color="#006699">I am very happy,</font></strong>
 to inform you that SAP resources provided by your organization is exceptionally good in technical as well as soft skills.</strong><DIV align=right><EM><font color="#006699">- HR Manager, Capgemini Consulting</font></EM></DIV></p>
  <tr><td><img src="images/spacer.gif" height="10" width="1"></td></tr>
</tbody></table>
	</td>
  </tr>
</tbody></table>

	</td>
  </tr>  
    <!-- Testimonials end -->

  


</tbody></table>

	</td>


<!-- Website left menu end -->	
	
<!-- Website Body Start -->
    <td bgcolor="#f7f7f7" valign="top" width="56%">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
  <tbody><tr>
    <td class="solidcell">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
  <tbody><tr>
    <td height="20" align="center" bgcolor="#b9dbf6" class="headtext"><strong>Eminentlabs? Software Private Limited</strong></td>
  </tr>
  <tr>
    <td>
		<table border="0" cellpadding="1" cellspacing="1" width="100%">
		<tbody><tr><td><img src="spacer.gif" height="20" width="1"></td></tr>
  <tr>
  <td class="Text"><p align="justify"><strong><font color="#006699">Eminentlabs? Referral Program,</font></strong></p>
<!-- <td class="Text"><p align="justify"><strong><font color="#006699"> -->
                <ul>
                    <li>Referral only through Employees who has completed 3 months in Eminentlabs?</li>
                    <li>Alumni?s also need to Refer via the present employees</li>

                    <li>Joining date of Employees is on 1st Monday of the month</li>
                    <li>For Candidate referral fee please refer to Eminentlabs? notice board</li></ul>

</strong></p></td></tr>

  <tr>
  
<!-- <td class="Text"><p align="justify"><strong><font color="#006699"> -->
               
                   


<!--     <td class="Text" align="center" width="15%"><img src="partners.gif"></td>
    <td class="Text"><p align="justify"><strong><font color="#006699">Eminentlabs? Referral Program,</font></strong>
 Eminent and Intel ties up for next generation software evolution. Intel's Sales, Technical artitect and business development are working betterment and promotions of Eminent - eTracker? and eGovernance product lines.</strong></p></td></tr> -->
  
<!--   <tr><td class="baseline" colspan="2"><img src="spacer.gif" height="10" width="1"></td></tr> -->
   
  <tr><td colspan="2"><img src="spacer.gif" height="10" width="1"></td></tr>
  <tr><td><img src="spacer.gif" height="20" width="1"></td></tr>
</tbody></table>


	</td>
  </tr>
</tbody></table>

	</td>
  </tr> 
  
   
  
  
   <tr>
    <td class="solidcell">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
  <tbody><tr>
    <td class="headtext" colspan="2" align="center" bgcolor="#d5d6d8" height="20"><strong>Eminent features:</strong></td>
  </tr>
   <tr>
    <td><img src="spacer.gif" height="10" width="1"></td>
  </tr>
  <tr>
  	<td class="Text" align="center"><table border="0" cellpadding="3" cellspacing="0" width="95%">
  <tbody><tr><td class="Text" width="10%"><img src="iconteacher.gif"></td>
  <td class="Text">100 % SAP Focused</td>
  </tr>
	<tr><td class="Text"><img src="iconparent.gif"></td>
	<td class="Text"> Deep proven expertise in ERP solutions and Application Integration</td>
	</tr>
	<tr><td class="Text"><img src="iconschool.gif"></td>
	<td class="Text">Experts from the core ERP product development and sound understanding of core SAP offerings</td>
	</tr>
	<tr><td class="Text"><img src="iconstudent.gif"></td><td class="Text"> Proven expertise in high quality global delivery and distributed development</td>
  </tr>
   <tr>
    <td>&nbsp;</td>
  </tr>
    <tr>
    <td>&nbsp;</td>
  </tr>

</tbody></table>
</td>
  </tr>
   <tr>
    <td><img src="spacer.gif" height="20" width="1"> </td>
  </tr>
</tbody></table>

	</td>
  </tr>

</tbody></table>
	</td>

<!-- Website Body end -->	

<!-- Right menu start -->
	
    <td bgcolor="#ecf1f7" valign="top" width="22%">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
  <tbody>
  <!-- Login start -->
  <tr>
    <td>
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
		
  <tbody><tr>
    <td align = "center" class="Text" bgcolor="#b9dbf6" height="20"><strong>eTracker? </strong></td>
  </tr>
  <tr>
    <td>
		<table border="0" cellpadding="2" cellspacing="0" width="100%">
		<FORM METHOD=POST ACTION="http://www.eminentlabs.com/eTracker/loginvalidat.jsp"  name="form1" onReset=" return setFocus()" >
		<TR>
	                	<TD colSpan=2>&nbsp;</TD>
		</TR>
    	          	<TR>
                		<TD class="Text">Email ID</TD>
		                <TD><INPUT class="textbox" name=username size=25 type="text" maxlength="100" ></TD>
					</TR>
	                <TR>
		                <TD class="Text">Password</TD>
        		        <TD><INPUT class="textbox" name=password size=25 type=password maxlength="16" ></TD>
        		   	</TR>
	              		<tr>
			 		     <TD>&nbsp;</TD>
	                     <TD ><INPUT name=Register  type=submit class="Text" value="Sign in" align="middle"></TD>
	                     
	              	</TR>
					<TR>
						<TD class="Text"><font color=#0033FF><a	href="http://www.eminentlabs.com/eTracker/UserManagement/register.jsp"><u>New User?</u></a></TD>
						<TD ALIGN="right" class="Text"><font color=#0033FF><a href="javascript:forgotPassword()"><U>Forgot Password?</U></a></font></TD>
				   </TR>
					</form>
		</table>

	</td>
  </tr>
  
   <tr><td align="center"><img src="spacer.gif" height="20" width="1"></td></tr>  
</tbody></table>

	</td>
  </tr>

<!-- Login end -->

  <!-- Partners start --> 
   <tr>
    <td>
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
  <tbody><tr>
    <td class="headtext" align="center" bgcolor="#b9dbf6" height="20"><strong>Partners</a></strong></td>
  </tr>
   <tr>
    <td align="center"><img src="spacer.gif" height="20" width="1"></td>
  </tr>
  <tr>
    <td align="center"><img src="partners.gif" border="0" alt="Eminentlabs? Partners"></td>
  </tr>
   <tr><td align="center"><img src="spacer.gif" height="20" width="1"></td></tr>
</tbody></table>

	</td>
  </tr>
<!-- Partners end -->

    <!-- Programs  start -->

   <tr>
    <td>
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
  <tbody>
  <!--
  <tr>
    <td class="headtext" align="center" bgcolor="#b9dbf6" height="20"><strong>Programs</strong></td>
  </tr>
  <tr>
    <td><img src="spacer.gif" height="10" width="1"></td>
  </tr>

    <tr>
	<td class="Text"><a href="http://www.eminentlabs.com/eTracker/admin/customer/addcontact.jsp?username=guest" onclick="window.open(this.href,'child','height='+screen.height+',width='+screen.width+',fullscreen,resizable=yes,scrollbars=yes'); return false"><font color="#006699">Become an Eminent Partner</font></a></td>
  </tr>
  -->
    <tr>
      <td class="Text">&nbsp;</td>
    </tr>
</tbody></table>

	</td>
  </tr>
<!-- Programs End --> 

    <!-- Careers  start -->
<!--
   <tr>
    <td>
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
  <tbody><tr>
    <td class="headtext" align="center" bgcolor="#b9dbf6" height="20"><strong>Careers</strong></td>
  </tr>
  <tr>
    <td><img src="spacer.gif" height="10" width="1"></td>
  </tr>
  <tr>
   <td class="Text"><a href="http://www.eminentlabs.com/eOutsource/index.jsp" onclick="window.open(this.href,'child','height='+screen.height+',width='+screen.width+',fullscreen,resizable=yes,scrollbars=yes'); return false"><font color="#006699">New Applicant Register Here</font></a></td>
  </tr>

    <tr>
      <td class="Text">&nbsp;</td>
    </tr>
</tbody></table>

	</td>
  </tr>
  -->
<!-- Careers End --> 
  
    <!-- Contact us start -->
  <tr><td><img src="spacer.gif" height="10" width="1"></td></tr>
  <tr>
    <td>
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
  <tbody><tr>
    <td class="Text" align="center" bgcolor="#b9dbf6" height="20"><strong>Contact us</strong></td>
  </tr>
    <tr><td class="Text"><img src="spacer.gif" height="5" width="1"></td></tr>
  <tr>
    <td>
		<table border="0" cellpadding="2" cellspacing="0" width="100%">
		<tbody><tr><td><span class="style2"><img src="spacer.gif" height="10" width="1"><strong>Eminentlabs? Software Pvt Ltd </strong></span></td>
		</tr>
  	<tr>
		<td class="Text"> Tel :+ 91 80 2572 9392 <br>
Mob:+ 91 98864 38038 <br>
VoIP:+1 407 792 3920 <br>
E-mail: <a href="mailto:sales@eminentlabs.net"><font color="#006699">sales@eminentlabs.net</font></a><br>
URL: <a href="http://www.eminentlabs.net/" target="_blank"><font color="#006699">www.eminentlabs.net</font></a></td>
	</tr>
  <tr><td><img src="spacer.gif" height="10" width="1"></td></tr>
</tbody></table>

	</td>
  </tr>
</tbody></table>

	</td>
  </tr> 
      <!-- Contact us end -->  

</tbody></table>

	</td>
  </tr>
</tbody></table>

	</td>
  </tr>
<!-- Footer Start -->

  <tr>
  	<td>
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
		<tbody>
  <tr>
  	  <td class="Text" align="center" bgcolor="#d5d6d8" height="20">&nbsp;KPI Tracker?, ERPDS?, EWE?, eTracker?, eOutsource?, Rightshore? are registered trademarks of Eminentlabs? Software Private Limited </td>
  </tr>
<!-- Footer End -->

</tbody></table>

	</td>
  </tr>
</tbody></table>

</body></html>
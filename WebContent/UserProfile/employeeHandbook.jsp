<%-- 
    Document   : employeeHandbook
    Created on : Jun 13, 2009, 9:26:56 AM
    Author     : Tamilvelan
--%>
<%@ page import="org.apache.log4j.*"%>

<%
	//Configuring log4j properties

		Logger logger = Logger.getLogger("Handbook");
	
	String logoutcheck=(String)session.getAttribute("Name");
	if(logoutcheck==null)
	{
		%>
<jsp:forward page="../SessionExpired.jsp"></jsp:forward>
<%
	}
%>
<%@ include file="../header.jsp"%> <br>
<HTML>
<meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
    <LINK title=STYLE	href="<%= request.getContextPath() %>/eminentech support files/main_ie.css" type=text/css rel=STYLESHEET>
<TABLE BORDER="0" BORDERCOLOR="#336699" CELLPADDING="0" CELLSPACING="0" WIDTH="100%" align ="Center" align="justify">
<TR>
<TD>
</TD></TR>

<TR>
<TD>
<TABLE BORDER="0" BORDERCOLOR="#336699" CELLPADDING="0" CELLSPACING="0" WIDTH="100%" align ="Center" align="justify">
<title> Employee Handbook </title></TD></TR>

</HEAD>

<BODY><B>
<CENTER>
<H2>Eminentlabs&#153; Employee Handbook</H2></CENTER></B><TR><TD><br>


<P align=justify><b><FONT face="Times New Roman" color=#0000ff
size=3>Welcome to Eminentlabs&#153; Software Private Limited!!!</font></b><br> We are excited to have you as part of our team. You were hired because we believe you can contribute to the success of our business, and share our commitment to achieving our goals as stated in our mission statement.<br>
<P align=justify>Eminentlabs&#153; is committed to quality and unparalleled customer service in all aspects of our business. As part of the team, we hope you will discover that the pursuit of excellence is a rewarding aspect of your career here.<br><br>
This employee handbook contains the key policies, goals, benefits, and expectations of Eminentlabs&#153;, and other information you will need.<br><br>

<b><FONT face="Times New Roman" color=#0000ff
size=3>Eminentlabs&#153; Software Pvt Ltd Vision and Mission Statement </font></b>

<P align=justify><B><FONT face="Times New Roman" color=#0000ff
size=3>Vision</FONT></B>: Our Vision is to provide value based on shore - offshore solutions to improve customer's bottom-line uptp 36% and thereby increase clients Shareholder value <br>


<P align=justify><B><FONT face="Times New Roman" color=#0000ff
size=3>Mission</FONT></B>At Eminentlabs&#153;, we create <b>Substantial value</b> for our customer's by incubating and growing, successful, world class Global Delivery Centers that deliver high quality, high impact implementation and services  <br>

<P align=justify>The success of Eminentlabs&#153; Software Pvt Ltd is determined by our success in operating as a unified team. We have to earn the trust and respect of our customers every day in order that the customer makes the decision to choose our services. We sell service and service is provided by people. There are no magic formulas.

<P align=justify>Our success is built by creative, productive employees who are encouraged to make suggestions while thinking "outside the box." Your job, every job, is essential to fulfilling our mission everyday to the people who trust and respect us. The primary goal of Eminentlabs&#153;, and yours, as one of its employees, is to live our mission statement and continue to serve the  industry . We achieve this through dedicated hard work and commitment from every employee. It is the desire of Eminentlabs&#153; to have every employee succeed in their job, and be part of achieving our goals

<P align=justify>You should use this handbook as a ready reference as you pursue your career with Eminentlabs&#153; Software Pvt Ltd. Additionally, the handbook assures good management and fair treatment of all employees. At Eminentlabs&#153;, we want to recognize the contributions of all employees.

<P align=justify> Welcome aboard! I look forward to working with you.

<P align=justify> Sincerely,
<P align=justify> Gopalakrishnan T. <br><br>

<P align=justify><B><FONT face="Times New Roman" color=#0000ff
size=3>History</FONT></B>


<P align=justify> <b>Eminentlabs&#153; Software Private Limited </b> started in August 2005 with a simple statement that we will truly understand our clients and serve them and win their TRUST. Guidance from my ex managers -  Ashish Vikram(Ex-MD IBM Rational) and Karanjit Singh (Director i2) and confidence from appreciations of project stake holders at  - 3COM USA, Bell Helicopters USA, Cementhai Thailand, Polimeri Italy, Nanya Tech Taiwan, Tesco UK, Target USA, Gillette USA, HP-Calcomp  China Eminentlabs&#153; was born with a humble vision and mission focusing on the simple statement above. We wanted to leave our clients an impression which they have not tasted before and win their trust. As a policy we would groom and motivate employees from the grassroot and have one centralized infrastructure product to govern for a transparent world-class Eminentlabs&#153;.  And for this cause decided to dedicate my life time for building our Eminentlabs&#153; world-class without no second thoughts or backup plans. And we have identified you to join us in making it a truly world-class faster !!!.


<P align=justify> Eminentlabs&#153; employees, partners in our success, make our mission statement come alive in the way they work with every client. Our clients have responded tremendously. Their support has enabled Eminentlabs&#153; to extend our operation nationwide. With the entire staff of Eminentlabs&#153; participating in making our vision of distinctive quality and unparalleled client service real, we are headed for even greater success. <br><br>


<P align=justify><B><FONT face="Times New Roman" color=#0000ff
size=3>Testimonials by clients</FONT></B>

 <p align="justify"><strong><font color="#006699">The Results of SAP delivery,</font></strong>
  for our asset retirement and re-upload project in phases was found to be good. All the five phases have been well executed. We appreciate the expertise on the subject matter and team members efforts for their timely & continuos support provided.</strong>

  <DIV align=right><EM><font color="#006699">- Manager Finance, Continental Automotive</font></EM></DIV></p>

<p align="justify"><strong><font color="#006699">The delivery by your Company,</font></strong>
  for updation of Purchase Order Condition & MIRO transaction in the existing SAP system at our organisation is functioning well in Logistics department,  resulting in reduction of the cycle time from 60 - 90 minutes to just     2 - 3 minutes time. We appreciate your team members for the efforts and timely support in this regard.</strong>

  <DIV align=right><EM><font color="#006699">- DGM-IT, Continental Automotive</font></EM></DIV></p>
    <p align="justify"><strong><font color="#006699">I am very happy,</font></strong>
 to inform you that SAP resources provided by your organization is exceptionally good in technical as well as soft skills.</strong><DIV align=right><EM><font color="#006699">- HR Manager, Capgemini Consulting</font></EM></DIV></p>

<P align=justify><B><FONT face="Times New Roman" color=#0000ff
size=3>Goals, Values and Beliefs</FONT></B>

<P align=justify> Our goal at Eminentlabs&#153; is simple -- extraordinary Client service as we meet our Client's needs in the software service industry. We accomplish this by providing best service to them that frees them up to address the core goals of their business.


<P align=justify>Our goals are accomplished by the commitment of every employee.

<P align=justify>Our values and beliefs require that we:<br>


<UL type=circle>
<LI>Treat each employee with respect and listen to their input on how to continually improve our service goals.
<LI>Treat each employee fairly. Eminentlabs&#153; does not tolerate discrimination of any kind and encourages all supervisors to involve employees in problem solving creativity
<LI>When problems arise, the facts are analyzed to determine ways to avoid similar problems in the future.
<LI>Provide the most effective and efficient corrective action in resolving customer issues to ensure our customers' satisfaction
<LI>Have an open door policy which encourages interaction, discussions and the exchange of ideas to improve the work environment, and increase our productivity.
<LI>Make "Do It Right The First Time" our commitment as a team.

</UL>
<BR>
<P align=justify><b><FONT face="Times New Roman" color=#0000ff
size=3>General Policies</font></b><br>

<UL type=circle>
<LI><b>Personal Information</b>
</UL>

<P align=justify>It is important that the personnel records of Eminentlabs&#153; be accurate at all times. In order to avoid issues or compromising your benefit eligibility. Eminentlabs&#153; requests employees to promptly notify the appropriate personnel representative of any change in Name, Home address, Telephone number, Marital status, Number of dependents, or any other pertinent information which may change.<br>


<UL type=circle>
<LI><b>Attendance</b>
</LI></UL>

<P align=justify>Eminentlabs&#153; views attendance as an important facet of your job performance review. All unapproved absences will be noted in the employee's personnel file. Excessive absences, including for Sick Leave, will result in disciplinary action.<br>


<UL type=circle>
<LI><b>Use of Company Property</b></LI></UL>


<P align=justify>Eminentlabs&#153; will provide you with the necessary equipment to do your job. None of this equipment should be used for personal use, nor removed from the physical confines of Eminentlabs&#153; - unless it is approved and your job specifically requires use of company equipment outside the physical facility of Eminentlabs&#153;.<br>

<P align=justify>Computer equipment, including laptops, may not be used for personal use - this includes word processing and computing functions. It is forbidden to install any other programs to a company computer without the written permission of your supervisor. These forbidden programs include, but are not limited to, unlicensed software, pirated music, and pornography. The copying of programs installed on the company computers is not allowed unless you are specifically directed to do so in writing by your supervisor.<br>

<P align=justify>The telephone lines at Eminentlabs&#153; must remain open for business calls to service our customers. Employees are requested to discourage any personal calls - incoming and outgoing - with the exception of emergency calls. No long distance calls which are not business-related are to be made on company phones.<br>



<UL type=circle>
<LI><b>Confidentiality</b></LI></UL>


<P align=justify>Eminentlabs&#153; requires all employees to sign a confidentiality agreement as a condition of employment, due to the possibility of being privy to information which is confidential and/or intended for the company use only. All employees are required to maintain such information in strict confidence. This policy benefits you, as an employee, by protecting the interests of Eminentlabs&#153; in the safeguard of confidential, unique and valuable information that is part of our competitive advantage in the marketplace.<br>

<P align=justify>Should an occasion arise in which you are unsure of your obligations under this policy, it is your responsibility to consult with your supervisor. Failure to comply with this policy could result in disciplinary action, up to and including termination.<br>

<UL type=circle>
<LI><b>Dress Code</b></LI></UL>


<P align=justify>As an employee of Eminentlabs&#153;, we expect you to present a clean and professional appearance when you represent us, whether that is in, or outside of, the office. Management, sales personnel and those employees who come in contact with our public, are expected to dress in accepted corporate tradition.<br>

<P align=justify>It is just as essential that you act in a professional manner and extend the highest courtesy to co-workers, visitors, customers, vendors and clients. A cheerful and positive attitude is essential to our commitment to extraordinary customer service and impeccable quality.<br>


<UL type=circle>
<LI><b>Performance Reviews</b></LI></UL>

<P align=justify>Eminentlabs&#153; will measure your job performance on - Point Rating system called "Value system" Where points will be allocated to you based on your work completion.<br>
<P align=justify>Performance reviews are normally conducted every six (6) months from the date of hire. All performance reviews are based on "Value System". Wage increases will be based upon this review, as well as past performance improvement, dependability, attitude, cooperation, disciplinary actions, and adherence to all employment policies. <br><br>



<P align=justify><b><FONT face="Times New Roman" color=#0000ff
size=3>Additional Policies</font></b><br>


<UL type=circle>
<LI>Wearing an ID card is a must during the employee's presence in the office premises
<LI>Seeking permission with the Project manager and after approval intimating the same to HR - a must
<LI>Customer focus is the key - client's remarks and issues feedback ratings are the key for performance approval
<LI>Releiving Notice period - 3 months
<LI>Vacations, Company-offs are subjected to the client, account manager, project manager and the HR manager

</UL>

<BR>

<P align=justify><B><FONT face="Times New Roman" color=#0000ff
size=3>Compensation and Benefits:</FONT></B>

    <UL type=circle>
<LI><b>Timsheet</b></LI>
<UL>
<LI>Timesheet will be generated automatically at 8PM on every last day of the month

<LI>Employees need to submit their Timesheet highlighting their learnings and accomplishments for that month.

<LI>Timesheet would be approved for payroll processing within 5th of every month with three remainders
<LI>Without an approved Timesheet payroll cannot be processed 
</UL>
</UL>

<UL type=circle>
<LI><b>Payroll</b></LI>
<UL>
<LI>Currently 10th of every calendar month

<LI>Offcycle payments for pending salaries

<LI>Offcycle payments for reimbursements
</UL>
</UL>


<UL type=circle>
<LI><b>Work Hours and Reporting</b></LI></UL>

<P align=justify>The employees working at the client side should follow the Client work schedule. In Eminentlabs work timings is 8.30 am to 5.30pm, 1 hr lunch Break, 15mins +15mins Tea time. <br>


<UL type=circle>
<LI><b>Holidays</b></LI></UL>

<P align=justify>Eminentlabs&#153; recognizes the following holidays: New Year, Pongal, Republic Day, Good Friday, May Day, Independence Day, Ganesh Chaturthi, Gandhi Jayanthi, Ayudha Pooja, Diwali, Kannada Rajoyatsava, and Christmas and two floating holidays<br>


<P align=justify><BR><B><FONT face="Times New Roman" color=#0000ff
size=3>Leave Policy Statement & Objective:
</FONT> </b> <BR></P></TD></TR><TR><TD>

<P align=justify><BR> This Policy encourages its employees to take break from work as this provides for a healthy and efficient staff. The leave policy sets out the various types of leaves that an employee is eligible for and outlines the procedure for taking leave.  <BR></P></TD></TR><TR><TD>


<P align=justify><br><B><FONT face="Times New Roman" color=#0000ff
size=3>Leave Year & Applicability:
</FONT> </b></P></TD></TR><TR><TD>


<UL type=disc>
  <LI>Leave year is from 1st April 2009 - 31st March 2010
  <LI>The different types of leaves covered under this policy are:

  <UL type=circle>
    <LI>Privilege Leave <BR>
    <LI>Casual Leave <BR>
    <LI>Sick Leave <BR>
    <LI>Maternity Leave	 <BR>
    <LI>Paternity Leave <BR>
    <LI>Funeral or Bereavement Leave
</TD></TR><TR><TD>
<UL type=disc>
  <LI>The policy is applicable for all - Permanent employees
  <LI>Employees who are on Probation are not covered under this policy.
  <li>All leaves should be applied on "Standard Leave Form" available on eTracker.
  <li>No Encashment or carry forward of the leave facility available.</li>
  </UL>
<P align=justify><B><FONT face="Times New Roman" color=#0000ff
size=3>Privilege Leave/ Earned Leave
</FONT> </b>

<UL type=disc>
  <LI>Entitlement

  <UL type=circle>
    <LI>12 days privilege leave is allowed to each employee <BR>
    <LI>For every 20 days of the month - 1 day is statutory<BR>
    <LI>Employees joining the organization after July 01, may not be able to avail PL (since PL is normally not allowed during the first six months as per policy).<BR>
    <LI>If leave is taken for 4 days or more it would be treated as long leave and any holidays during the leave would also be taken as leave.  <BR>
    <LI>All the employees are required to submit a leave plan to their respective Project Manager stating when he/she intends to take paid leave<BR>
    <LI>All leave will be sanctioned by Project manager and sent to the HR department for records. Paid leave cannot be encashed </ul></li></ul></li>


<P align=justify><B><FONT face="Times New Roman" color=#0000ff
size=3>Casual Leave:
</FONT> </b> <BR></P></TD></TR><TR><TD>

<UL type=disc><br>
  <LI>Entitlement

  <UL type=circle>
    <LI>An employee is eligible for a maximum of 7 days casual leave in a calendar year. <BR>
    <LI>Half Day CL can be taken as needed<BR>
    <LI>If an employee avails more than 7 days casual leave during the calendar year. Excess leave will be deducted as PL or if PL is not available they will be unpaid leave.<BR>
    <LI>All leaves should be applied for in advance unless circumstances are such that it is not possible to do so. In such cases a telephone call or an email to the concerned reporting authority or his/her absence to the concerned department, as intimation should serve the purpose.</ul></li></ul></li>


<P align=justify><B><FONT face="Times New Roman" color=#0000ff
size=3>Sick Leave:
</FONT> </b> <BR></P></TD></TR><TR><TD>

<UL type=disc><br>
  <LI>Entitlement

  <UL type=circle>
    <LI>An employee is eligible for a maximum of 5 days sick leave in a calendar year. <BR>
    <LI>Half Day SL can be taken as needed<BR>
    <LI>If an employee avails more than 5 days of sick leave during the calendar year. Excess leave will be deducted as PL or if PL is not available they will be unpaid leave.</ul></li> </ul></li></ul></li>


<P align=justify><B><FONT face="Times New Roman" color=#0000ff
size=3>Maternity Leave:
</FONT> </b> <BR></P></TD></TR><TR><TD>

<UL type=disc><br>
  <LI>Entitlement

  <UL type=circle>
    <LI>An employee would be granted 3 months of paid leave for the first child  <BR>
    <LI>An employee would be granted 1 month paid leave for the Second child <BR>
    <LI>And no paid leave for the third child </ul></li> </ul></li></ul></li>


<P align=justify><B><FONT face="Times New Roman" color=#0000ff
size=3>Paternity Leave:
</FONT> </b> <BR></P></TD></TR><TR><TD>

<UL type=disc><br>
  <LI>Entitlement

  <UL type=circle>
    <LI>An employee would be granted 4 days of paid leave for the first child  <BR>
    <LI>An employee would be granted 2 days paid leave for the Second child <BR>
    <LI>And no paid leave for the third child </ul></li> </ul></li></ul></li></ul></li>

<P align=justify><B><FONT face="Times New Roman" color=#0000ff
size=3>Funeral or Bereavement leave:
</FONT> </b> <BR></P></TD></TR><TR><TD>

<UL type=disc><br>
  <LI>Entitlement

  <UL type=circle>
    <LI>Up to 2 days for immediate family Member.</ul></li> </ul></li></ul></li>


<P align=justify><B><FONT face="Times New Roman" color=#0000ff
size=3>Special considerations
</FONT> </b> <BR></P></TD></TR><TR><TD>

<UL type=disc><br>
  <LI>Employees who work on Saturday/Sunday  can accumulate their leave and are eligible to avail it when ever they require , But their respective project managers have to authenticate the employee's work on Saturday /Sunday and send a mail to HR
  <li>If the Employee has to work for the entire Night, he/ she is eligible to take next day off.
  <li>An employee who has completed tenure of 4 continuous year's service in Eminentlabs would be granted a vacation of 20 days (Saturdays, Sundays and holidays are also considered).
  <li>An employee who has completed tenure of 8 continuous year's service in Eminentlabs would be granted a vacation of 40 days (Saturdays, Sundays and holidays are also considered).

</UL>

</FONT></B><BR></P></TD></TR>

</BODY>
</HTML>



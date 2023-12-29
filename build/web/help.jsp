


<%-- 
    Document   : help
    Created on : Mar 19, 2009, 7:54:20 PM
    Author     : Tamilvelan
--%>
<%@page import="org.apache.log4j.*"%>
<%
	
	Logger logger = Logger.getLogger("Help");
	String logoutcheck=(String)session.getAttribute("Name");
	if(logoutcheck==null)
	{
		 logger.fatal("==============Session Expired===============");
%>
<jsp:forward page="SessionExpired.jsp"></jsp:forward>
<%
	}

    int roleId  = (Integer)session.getAttribute("Role");
%>
<%@ include	file="header.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<%if(roleId==2){
%>
<HTML>
<meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
      <LINK title=STYLE
	href="<%= request.getContextPath() %>/eminentech support files/main_ie.css"
	type="text/css" rel="STYLESHEET">

<TR>
<TD>
</TD>
</TR>
<BR>
       <td align="center">

<B>
<CENTER>
<H2>eTracker&#0153; User Login End user Documentation</H2></CENTER></B>
</td>
<TR>
<TD>
<TABLE BORDER="0" BORDERCOLOR="#336699" CELLPADDING="0" CELLSPACING="0" WIDTH="100%" align ="Center" align="justify">
<title> eTracker&#153; User Login End user Documentation </title></TD></TR>

</HEAD>

<BODY>
    <tr>
 
</tr
  
<P align=justify><BR>Hi eTracker&#153; user !!!  </P></TD></TR><TR><TD>
<P align=justify><B><FONT face="Times New Roman" color=#0000ff
size=3>Login</FONT></B> - You can login into eTracker&#153; anytime from <FONT
face="Times New Roman" color=#0000ff size=3>www.eminentlabs.net</FONT> or <FONT
face="Times New Roman" color=#0000ff
size=3>www.eminentlabs.net/index.htm</FONT>. You can bookmark <FONT
face="Times New Roman" color=#0000ff size=3>https://www.eminentlabs.net/eTracker/

</FONT>in your iPhone or Blackberry for WML page access.
<BR></P></TD></TR><TR><TD>
<P align=justify><BR><B><FONT face="Times New Roman" color=#0000ff
size=3>About</FONT></B> - You can know the version information and owner
information here. eTracker&#153; is registered trademarks of Eminentlabs&#153; Software
Pvt Ltd. <BR></P></TD></TR><TR><TD>
<P align=justify><BR><B><FONT face="Times New Roman" color=#0000ff
size=3>Profile</FONT></B> - Your profile information can be found here. It is
recommended to change your password in a timely manner for security reasons. Do
check out with your reporting manager for any change in Team or Project
assigned. Hope you enjoy our "Current Month Value". For security reasons we have
mandated the password when you want to edit your profile. Kindly update your
mobile number if there is any change to receive issue updates.
<BR></P></TD></TR><TR><TD>
<P align=justify><BR><B><FONT face="Times New Roman" color=#0000ff
size=3>Logout</FONT></B> - You would successfully be logged out when you click
on this link <BR></P></TD></TR><TR><TD>
<P align=justify><BR><B><FONT face="Times New Roman" color=#0000ff size=3>Forgot
Password </FONT></B>- You can reset your password by providing your email id and
secret question answer. For security reasons we do not provide the old password
retrieval process here. <BR></P></TD></TR><TR><TD>

<P align=justify><BR><B><FONT face="Times New Roman" color=#0000ff
size=3>Project Dashboard </FONT></B>- Use this link to check out all the
projects in the rich graphical charts. You can click on the interactive chart
and drill down to all the project related issues. The project dashboard would
help you visualize all the severity and priority tasks and invites your input
for the project success. You can select all the projects you are assigned using
the "Project" dropdown menu. The phase of the project would be changed as the
project manager changes it during build, deploy or run phases. Note that the
active not yet completed issues in the project alone would be represented in the
chart. The completion percentage is based on the Closed to Total issues in that
particular project. <BR></P></TD></TR><TR><TD>
<P align=justify><BR><B><FONT face="Times New Roman" color=#0000ff
size=3>My dashboard </FONT></B>- By default in the select an employee your
name would be set and the issues assigned to you would be displayed in the rich
graphical chart above. You can click on the interactive chart and drill down to
all the issues. The clear distinctive colored priority based chart would help
you in planning and accomplishing your tasks. For better value generation and
showcasing your superior performance your dashboard management would be the key.
As best practices valuable comments to project team member through their
dashboard would be a winning point for the overall project.
<BR></P></TD></TR><TR><TD>
<P align=justify><BR><B><FONT face="Times New Roman" color=#0000ff size=3>My
Issues </FONT></B>- This link helps in managing all the issues you have created
and tracking it based on Status, DueDate, AssignedTo and Age. Do check the mouse
over functionality on Issue No, Subject, Due Date to see the Type of Issue,
Description, LastModifiedOn respectively. Basically all the information needed
about the issue can be viewed for better tracking of your issues. You can click
on the issue number to add your comments and attach files if any. As best
practices review your my issues at periodic intervals so that the issue assigned
person gets your direct inputs. <BR></P></TD></TR><TR><TD>
<P align=justify><BR><B><FONT face="Times New Roman" color=#0000ff size=3>My
Assignments </FONT></B>-  User is specially designed to handle both APM Issues and CRM issues, when you click on my assignments your APM issues are displayed along with that if you have been assigned with any CRM Issues It will show the number of CRM issues you have been assigned to, when you click on the CRM issue Tab, it will display your lead issue, contact issue, opportunity issue and account issue if you have any.   <BR></P></TD></TR><TR><TD>


<UL type=disc>
  <LI><B><FONT face="Times New Roman" color=#0000ff size=3>a)Contact issues</FONT></B> -
  This link displays Contact name, Company, phone mobile, Email, Rating, Due date, Age. Click on the contact name it will take you to edit contact page where you can edit the contact details enter you comments and click on the update button. <br>
  <UL type=circle>
</LI></UL></LI></UL>
<UL type=disc>
  <LI><B><FONT face="Times New Roman" color=#0000ff size=3>a) Lead Issues </FONT></B> -
  This link displays Lead name, Company, phone, Lead status, Email, Rating, Due date, Age. Click on the Lead name it will take you to edit Lead page where you can edit the Lead details enter you comments and click on the update button.<BR>

  <UL type=circle>
</LI></UL></LI></UL>
<UL type=disc>
  <LI><B><FONT face="Times New Roman" color=#0000ff size=3>a) Oppurtunity Issues </FONT></B> -
   This link displays Opportunity Name, Assigned to, Deal Value, Closed Date, Stage. Click on the Opportunity name it will take you to edit opportunity page where you can edit the Opportunity details enter you comments and click on the update button.<BR>

  <UL type=circle>
</LI></UL></LI></UL>
<UL type=disc>
  <LI><B><FONT face="Times New Roman" color=#0000ff size=3>a) Account Issues  </FONT></B> -
  This link displays Account Name, Billing, Phone, Type, Value, Due Date, and Age. Click on the Account name it will take you to edit Account page where you can edit the Account details enter you comments and click on the update button.<BR>
  <UL type=circle>
</LI></UL></LI></UL>
<P align=justify><BR><B><FONT face="Times New Roman" color=#0000ff size=3>Create
Issue </FONT></B>- As Issue is the lowest unit of work which can be assigned to
a person for execution. By selecting the project, found version, module and due
date an issue can be created with default severity and priority based on the
following type:
<UL type=disc><BR>
  <LI><B><FONT face="Times New Roman" color=#0000ff size=3>a) Bug</FONT></B> -
  The following is mandatory to raise an issue of type Bug<BR><BR>

  <UL type=circle>
    <LI><B><FONT face="Times New Roman" color=#0000ff size=3>1. Subject
    </FONT></B>- Provide brief summary of the issue so that one can understand
    about this issue from his my assignment<BR><BR>
    <LI><B><FONT face="Times New Roman" color=#0000ff size=3>2. Description
    </FONT></B>- Provide maximum information related to your issue so that
    anyone can easily understand it. Give examples to narrate what you want to
    convey in terms of complex issues.<BR><BR>
    <LI><B><FONT face="Times New Roman" color=#0000ff size=3>3. Root Cause
    </FONT></B>- If you know the reason for the problem caused do narrate it
    here<BR><BR>
    <LI><B><FONT face="Times New Roman" color=#0000ff size=3>4. Expected Result
    </FONT></B>- The final outcome of the issue filed can be narrated
    here.<BR></LI></UL></LI></UL>

<UL type=disc><BR>
  <LI><B><FONT face="Times New Roman" color=#0000ff size=3>b)
  Enhancement</FONT></B> - The following is mandatory to raise an issue of
  type<BR><BR>
  <UL type=circle>
    <LI><B><FONT face="Times New Roman" color=#0000ff size=3>1. Subject
    </FONT></B>- Provide brief summary of the enhancement so that one can
    understand about this issue from his my assignment<BR><BR>
    <LI><B><FONT face="Times New Roman" color=#0000ff size=3>2. Existing
    Functionality </FONT></B>- Provide maximum information about this existing
    functionality highlighting the drawbacks so that anyone can easily
    understand why it has to be enhanced. Give examples to narrate what you want
    to convey in terms of complex issues.<BR><BR>
    <LI><B><FONT face="Times New Roman" color=#0000ff size=3>3. Proposed
    </FONT></B>- Provide maximum information of the new functionality or
    business processes proposed. Illustration with suitable example would convey
    your point better.<BR><BR>

    <LI><B><FONT face="Times New Roman" color=#0000ff size=3>4. Benefits
    </FONT></B>- Narrate the advantages so that it is readily approved for
    development.<BR></LI></UL></LI></UL>
<UL type=disc><BR>
  <LI><B><FONT face="Times New Roman" color=#0000ff size=3>c) New Task
  </FONT></B>- The following is mandatory to raise an issue of type <BR><BR>
  <UL type=circle>
    <LI><B><FONT face="Times New Roman" color=#0000ff size=3>1. Subject
    </FONT></B>- Provide brief summary of the enhancement so that one can
    understand about this issue from his my assignment<BR><BR>
    <LI><B><FONT face="Times New Roman" color=#0000ff size=3>2. Description
    </FONT></B>- Provide maximum information related to your issue so that
    anyone can easily understand it. Give examples to narrate what you want to
    convey in terms of complex issues.<BR><BR>

    <LI><B><FONT face="Times New Roman" color=#0000ff size=3>3. Benefits
    </FONT></B>- Narrate the advantages so that it is readily approved for
    development. <BR><BR>
    <LI><B><FONT face="Times New Roman" color=#0000ff size=3>4. References
    </FONT></B>- Provide the reference material or relevant document for better
    understanding on this new task issue.<BR></LI></UL></LI></UL><BR>
<P></P></TD></TR><TR><TD>
<P align=justify><B><FONT face="Times New Roman" color=#0000ff size=3>My Searches
</FONT></B>- Use this link to search out the relevant issues by
selecting the appropriate fields. You can save your search query using the "Save
Search" button </P></TD></TR><TR><TD>
<P align=justify><BR><B><FONT face="Times New Roman" color=#0000ff size=3>My
Views </FONT></B>-  All the saved views in My Searches can be seen
here. You can run this view at one click using "RunView" option instead of
choosing the search parameters using the My Searches. At any point in time you
can Edit using "EditView" and Resave this view. When provided with a new name
during update view a new view would be saved un-altering the existing view,
same as "Save As" functionality. As the owner of this view you can delete by
using the "DeleteView" option. <BR></P></TD></TR><TR><TD>
<P align=justify><BR><B><FONT face="Times New Roman" color=#0000ff size=3>My
Contacts </FONT></B>- You can manage all your professional contacts here.

<BR></P></TD></TR><TR><TD>
<P align=justify><BR><B><FONT face="Times New Roman" color=#0000ff size=3 style="font-weight: bold;">Status Flow for Sap Project : </FONT></B>
<BR></P></TD></TR><TR><TD>
        <P align=right><BR><B><FONT face="Times New Roman" color=#0000ff size=3 style="font-weight: bold;"><ul type="disc"><li>SAP Implementation</li></UL></FONT></B>
<BR></P></TD></TR>
<TR><td><img src="images/eTracker_SAP_ImplementationWorkflow1.jpg">
<BR></P></TD></TR><TR><TD>
        <P align=right><BR><B><FONT face="Times New Roman" color=#0000ff size=3 style="font-weight: bold;"><ul type="disc"><li>SAP Support</li></UL></FONT></B>
<BR></P></TD></TR><TR><TD>
 <img src="images/eTracker_SAPSupport_WorkFlow_1.jpg"></td></tr>

 <BR></P></TD></TR><TR><TD>
<P align=justify><BR><B><FONT face="Times New Roman" color=#0000ff size=3 style="font-weight: bold;">Status Flow for Non-Sap Project : </FONT></B>
<BR></P></TD></TR><TR ><TD ><img src="images/eTracker_NonSAP_Workflow1.jpg"></td></tr>
<TR><TD><BR><B>* Patent Pending</B><BR></TD></TR></TABLE>

</BODY>
</HTML>



<%}else{%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<!-- saved from url=(0111)https://www.eminentlabs.net/eTracker/Etracker_AttachedFiles/E20082008002_APM%20login%20user%20documentation.html -->
<HTML><meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America"><TITLE>eTracker&#0153; APM Login User Documentation</TITLE>
<LINK title=STYLE href="eminentech support files/main_ie.css" type="text/css" rel=STYLESHEET>
<META http-equiv=Content-Type content="text/htmlcharset=windows-1252">
<META content="MSHTML 6.00.2900.2096" name=GENERATOR></HEAD>
<BODY><B>
<CENTER>
<H2>eTracker&#0153; APM Login User Documentation</H2></CENTER></B>
<TABLE borderColor=#336699 cellSpacing=0 cellPadding=0 width="100%" align=justify
border=0 >
  <TBODY ALIGN="JUSTIFY">
  <TR>
    <TD><BR>Hi eTracker&#0153; Admin !!! <BR></TD></TR>
    <TR><TD>
<P align=justify><BR><B><FONT face="Times New Roman" color=#0000ff
size=3>Customer relationship Management </FONT></B> helps to manage complete details of your contacts. CRM is Very Important because this link allows you to lay the foundation to generate revenue.  <BR></P></TD></TR><TR><TD>
<P align=justify><BR><B><FONT face="Times New Roman" color=#0000ff
size=3>Contacts</FONT></B> - Use this link to check out all the contacts in the rich graphical charts. You can click on the interactive chart and drill down to all on a particular contact Information. This dashboard would help you visualize the Rating of the contact in term of HOT, WARM and COLD.
<BR></P></TD></TR><TR><TD>
<P align=justify><BR><B><FONT face="Times New Roman"
size=3></FONT></B> Hot - A good Contact which can be a potential client
on this link <BR></P></TD></TR><TR><TD>

<P align=justify><BR><B><FONT face="Times New Roman"
size=3></FONT></B>Warm - A potential Contact which can be considered
on this link <BR></P></TD></TR><TR><TD>

<P align=justify><BR><B><FONT face="Times New Roman"
size=3></FONT></B> Cold - A contact which cannot be materialized immediately.
on this link <BR></P></TD></TR><TR><TD>

<P align=justify><BR><B><FONT face="Times New Roman"
size=3></FONT></B>Contacts has Add Contact, Approve Contact, Denied Contact, Disable Contact
on this link <BR></P></TD></TR><TR><TD>

<BR><UL type=disc>
  <LI><B><FONT face="Times New Roman" color=#0000ff size=3>a) Add Contact</FONT></B> -
  - Here you can Add Contacts updating the fields Title, First name , last name phone number, Email , Assigned to,  Mobile, Company , Reports to , Rating, Accounts , Due date, Interested in( eTracker , ERPDS, eOutsource) , Address Information , Additional Information Like Fax , Home Phone ,Other phone, Department, Assistant, Assistant Phone, Birth Date, And a descriptive information about your views <br>
  <UL type=circle>
</LI></UL></LI></UL>
<UL type=disc>
  <LI><B><FONT face="Times New Roman" color=#0000ff size=3>a) View Contacts </FONT></B> -
  - You can click any part of this chart and find a List of contact person?s name, Account, Phone, E Mail, owner of the contact, Due Date, Assigned to and Age<BR>

  <UL type=circle>
</LI></UL></LI></UL>
<UL type=disc>
  <LI><B><FONT face="Times New Roman" color=#0000ff size=3>a) Approve contacts  </FONT></B> -
   - Shows the list of Contacts which need to be approved by Admin.<BR>

  <UL type=circle>
</LI></UL></LI></UL>
<UL type=disc>
  <LI><B><FONT face="Times New Roman" color=#0000ff size=3>a) Deny contacts  </FONT></B> -
  - Shows the list of Contacts which have been denied. Contacts are denied if they are Irrelevant<BR>
  <UL type=circle>
</LI></UL></LI></UL>

<UL type=disc>
  <LI><B><FONT face="Times New Roman" color=#0000ff size=3>a) Disable contacts  </FONT></B> -
  - Shows the list of Contacts which have been disabled. Can be revived at latter point in time <BR>

  <UL type=circle>
</LI></UL></LI></UL>


<P align=justify><BR><B><FONT face="Times New Roman" color=#0000ff
size=3>Leads</FONT></B> - Use this link to check out all the Leads in the rich graphical charts. You can click on the interactive chart and drill down to all on a particular Lead Information. This dashboard would help you visualize the Status of the Lead in terms of OPEN, CONTACTED, QUALIFIED and UNQALIFIED. This further drills down to HOT, WARM and COLD.
<BR></P></TD></TR><TR><TD>


<P align=justify><BR><B><FONT face="Times New Roman"
size=3></FONT></B>Open - This Chart shows you the leads which have been entered but not contacted
on this link <BR></P></TD></TR><TR><TD>

<P align=justify><BR><B><FONT face="Times New Roman"
size=3></FONT></B>Contacted - This Chart shows you the leads which have been contacted
on this link <BR></P></TD></TR><TR><TD>

<P align=justify><BR><B><FONT face="Times New Roman"
size=3></FONT></B>Qualified - This graph will drill u down to lead which can be Prospective clients
on this link <BR></P></TD></TR><TR><TD>


<P align=justify><BR><B><FONT face="Times New Roman"
size=3></FONT></B>Unqualified - This graph will take you through contacts which are irrelevant for current situation
on this link <BR></P></TD></TR><TR><TD>


<P align=justify><BR><B><FONT face="Times New Roman"
size=3></FONT></B>Hot - A good Contact which can be a potential client
on this link <BR></P></TD></TR><TR><TD>


<P align=justify><BR><B><FONT face="Times New Roman"
size=3></FONT></B>Warm - A potential Contact which can be considered
on this link <BR></P></TD></TR><TR><TD>


<P align=justify><BR><B><FONT face="Times New Roman"
size=3></FONT></B>Cold - A contact which cannot be materialized immediately.
on this link <BR></P></TD></TR><TR><TD>


<BR><UL type=disc>
  <LI><B><FONT face="Times New Roman" color=#0000ff size=3>a) View Lead </FONT></B> -
  - You can click any part of this chart and find a List of Lead name, Company, Phone, E Mail, Lead Status, Due Date, Assigned to and Age <BR>

  <UL type=circle>
</LI></UL></LI></UL>


<UL type=disc>
  <LI><B><FONT face="Times New Roman" color=#0000ff size=3>a) Approve Lead </FONT></B> -
  - Shows the list of Lead which need to be approved by Admin <BR>

  <UL type=circle>
</LI></UL></LI></UL>


<UL type=disc>
  <LI><B><FONT face="Times New Roman" color=#0000ff size=3>a) Deny Lead </FONT></B> -
  - Shows the list of Lead which have been denied. Lead are denied if they are Irrelevant <BR>

  <UL type=circle>
</LI></UL></LI></UL>


<UL type=disc>
  <LI><B><FONT face="Times New Roman" color=#0000ff size=3>a) Disable Lead </FONT></B> -
   - Shows the list of Lead which have been disabled. Can be revived at latter point in time <BR>

  <UL type=circle>
</LI></UL></LI></UL>


<P align=justify><BR><B><FONT face="Times New Roman" color=#0000ff
size=3>Opportunity</FONT></B> - When u click on this link you?ll find a list of companies, assigned to, deal value, closed date and stage. When you click on the company you will find company name ,Stage Probability% of the company becoming the client , Amount ,  type (whether its is the existing business or new business), Assigned to ,due date, opportunity owner, Lead source , next step , and then description. There are different stages which the company has to pass through to become an Account , The stages are Prospecting , Qualification , need analysis , Value proposition , decision maker , Perception analysis, Proposal/Price quote , Negotiation/review, Closed won , Closed lost . After Passing through these various stages the company becomes an Account (Client). After this you can move the opportunity to Account by click on the Account button.
<BR></P></TD></TR><TR><TD>



<P align=justify><BR><B><FONT face="Times New Roman" color=#0000ff
size=3>Accounts</FONT></B> - - When u click on this link you?ll find a list of clients , billing state, phone, type, deal value , account value, assigned to, due date, age. When you click on the client you?ll find Account name, Parent account, phone , Fax, website , assigned to , due date, account owner, Account Amount , additional information like Address, revenue of the company, description and the comments.
<BR></P></TD></TR>
  <TR ALIGN="JUSTIFY">
    <TD><BR>Advanced Project Management Login helps to manage projects within
      budget and deliver with utmost quality having total control on the project
      resources. It is wise for us to manage a project better after we have won
      through mammoth CRM stages. <BR></TD></TR>
  <TR ALIGN="JUSTIFY">
    <TD ALIGN="JUSTIFY"><BR><B><FONT face="Times New Roman" color=#0000ff
      size=3>Projects</FONT></B> - This link, displays the various projects that
      the company is executing at one shoot. By looking at the Project Name,
      Manager, Customer, Start Date, End Date, Status, Percentage of work
      completion, Modules and Team the decision makers including program
      managers can easily determine the health of the projects under the
      enterprise umbrella. You can click on the Project and view the detailed
      project status through Project Dashboard which provides the work break
      down structure for cost planning. Since the project is integrated with
      individual resources the capacity planning &amp; leveling, cost management
      and even risk management due to resources can be handled well. As it is
      integrated with eOutsource the overloaded resources intimates for advanced
      workforce planning which triggers a request to the resource planning and
      hiring module. Thus the simple to use and seamless integrated system
      provides a intuitive way to analyze your fixed and project overheads and
      thus helps management for revenue planning. You can click on the Project
      and view the detailed project status through Project Dashboard <BR></TD></TR>
  <TR>
    <TD><BR><B><FONT face="Times New Roman" color=#0000ff size=3>Create
      Issue</FONT></B> - As Issue is the lowest unit of work which can be
      assigned to a person for execution. You can create issue by selecting the
      Project, Module, type (Bug, Enhancement or NewTask) you decide on the
      Severity and priority of the project which will help to solve the issue
      accordingly, and then you give the Subject, Description, Root Cause and
      Expected result of the issue, for better understanding. The best practices
      is to provide maximum inputs and information capture at the first time to
      avoid cyclic flow of issues.</TD></TR>
  <TR>
    <TD><BR><B><FONT face="Times New Roman" color=#0000ff size=3>My
      Issues</FONT></B> - This link helps in managing all the issues that has
      been created and tracking it based on Status, DueDate, AssignedTo and Age.
      Do check the mouse over functionality on Issue No, Subject, Due Date to
      see the Type of Issue, Description, LastModifiedOn respectively. Basically
      all the information needed about the issue can be viewed for better
      tracking of the issues. You can click on the issue number to add your
      comments and attach files if any. <BR></TD></TR>
  <TR>
    <TD><BR><B><FONT face="Times New Roman" color=#0000ff size=3>My
      Assignments</FONT></B> - This link displays all the issues assigned based
      on DueDate, LastModifiedOn, Type, Priority, Severity and Age order. As
      best practices have the tasks you can work in the near future with
      verbiage comments to capture your mind at your deepest thoughts. Assign
      the issue to the concerned person in investigation status if you require
      more inputs to accomplish it. eTracker&#0153; recommends that a separate
      documentation is not needed if we maintain the verbiage comments during
      the flow of the issue in various status.<BR></TD></TR>
  <TR>
    <TD><BR><B><FONT face="Times New Roman" color=#0000ff size=3>My Searches
      </FONT></B> - This link facilitates the user to search the relevant
      issues he wants to.<BR></TD></TR>
  <TR>
    <TD><BR><B><FONT face="Times New Roman" color=#0000ff size=3>My
      Views</FONT></B> - All the saved views during My Searches can be
      seen here. You can run this view at one click using "RunView" option
      instead of choosing the search parameters using the My Searches. At any
      point in time you can Edit using "EditView" and Resave this view. When
      provided with a new name during update view a new view would be saved
      un-altering the existing view, same as "Save As" functionality. As the
      owner of this view you can delete by using the "DeleteView"
    option.<BR></TD></TR>
   <TR><TD>
<P align=justify><BR><B><FONT face="Times New Roman" color=#0000ff
                              size=3>Enterprise Resource Management</FONT></B> - Facilitates complete strategic planning and financial control of your resources like systems, software, people or projects.  <BR></P></TD></TR><TR><TD>
  </td></tr>
   
   <tr><td>
<BR><UL type=disc>
  <LI><B><FONT face="Times New Roman" color=#0000ff size=3>a) Resources</FONT></B> -
  This link will show the working status of the computers and servers in the company <br>
  <UL type=circle>
</LI></UL></LI></UL>
<UL type=disc>
  <LI><B><FONT face="Times New Roman" color=#0000ff size=3>b) User </FONT></B> 
  <UL type=circle>
    <LI><B><FONT face="Times New Roman" color=#0000ff size=3>1. Add User
    </FONT></B>- Enter relevant information in the blocks or spaces that has been provided<BR><BR>
    <LI><B><FONT face="Times New Roman" color=#0000ff size=3>2.View all Users  </FONT></B>- Provide maximum information about this existing
    Shows the list of user's added.<BR><BR>
    <LI><B><FONT face="Times New Roman" color=#0000ff size=3>3. Approve User 
    </FONT></B>- Shows the list of user's which need to be approved by Admin.<BR><BR>

    <LI><B><FONT face="Times New Roman" color=#0000ff size=3>4. Denied User 
    </FONT></B>- Shows the list of user's which have been denied. Users are denied if they are Irrelevant.<BR><BR>
    
    <LI><B><FONT face="Times New Roman" color=#0000ff size=3>5. Disable User  
    </FONT></B>- Shows the list of user's which have been disabled.<BR></LI></UL></LI>
    </LI></UL></LI></UL>

  
<UL type=disc>
  <LI><B><FONT face="Times New Roman" color=#0000ff size=3>c) Eminent Profiles </FONT></B> -
   This link will show you the resumes which have been filtered from my applicants.<BR>

  <UL type=circle>
</LI></UL></LI></UL>
<UL type=disc>
  <LI><B><FONT face="Times New Roman" color=#0000ff size=3>d) Applicants  </FONT></B> -
  - Shows the resumes posted on the Eminentlabs website<BR>
  <UL type=circle>
</LI></UL></LI></UL>

<UL type=disc>
  <LI><B><FONT face="Times New Roman" color=#0000ff size=3>e) Disable contacts  </FONT></B> -
  - Shows the list of Contacts which have been disabled. Can be revived at latter point in time <BR>

  <UL type=circle>
</LI></UL></LI></UL>
   <TR>
    <TD><BR><B>* Patent Pending</B><BR></TD></TR></TBODY></TABLE></BODY></HTML>
<%}%>
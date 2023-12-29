<%-- 
    Document   : newFeatures
    Created on : Nov 7, 2008, 1:49:54 PM
    Author     : Balaguru Ramasamy
--%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<%
    //Configuring log4j properties
    Logger logger = Logger.getLogger("ViewUser");
    String logoutcheck = (String) session.getAttribute("Name");
    if (logoutcheck == null) {
        logger.fatal("================Session expired===================");
%>
<jsp:forward page="/SessionExpired.jsp"></jsp:forward>
<%
    }
%>
<html>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
    <meta http-equiv="Content-Type" content="text/html">
    <LINK title=STYLE
          href="<%= request.getContextPath()%>/eminentech support files/main_ie.css"
          type="text/css" rel="STYLESHEET">
    <title>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS Solution</title>
</head>
<body>
    <%@ include file="/header.jsp"%> <br>


    <BR><BR>
    <table cellpadding="0" cellspacing="0" width="100%">
        <tr bgcolor="#C3D9FF">
            <td align="left" width="100%"><font size="4" COLOR="#0000FF"><b>Features </b></font><FONT SIZE="3" COLOR="#0000FF"></FONT></td>
        </tr>
    </table>
    <BR>
    <%
        int role = (Integer) session.getAttribute("Role");

        if (role == 1) {

    %>
    <h3><font color="blue">eTracker&#0153; 3.0_25 Sprint  To Be Released on 13 Dec 2023</font></h3>
    <UL>
        <font size="5">
            <li>E10042017008 - Sub issue linking to the main issue</li>
            <li>E24102023007 - Day wise E-Invoice report </li>
        </font>
    </UL>
      <h3><font color="#04B404">eTracker&#0153; 3.0_24 Sprint Released on 22 Nov 2023</font></h3>
    <UL>
        <font size="5">
            <li>E28092023014 - Need asset link for our User IDs</li>
            <li>E28092023001 - Feedback comment adding mandatory for all rating </li>
            <li>Enabled demo links</li>
        </font>
    </UL>
    <h3><font>eTracker&#0153; 3.0_23 Sprint Released on 28 Oct 2023</font></h3>
    <UL>
        <font size="5">
            <li>E26092023004 - Locking the order sequence in My assignment</li>
            <li>E23082021001 - Sequence option for planned issues</li>
        </font></UL>
    <h3><font>eTracker&#0153; 3.0_22 Sprint Released on 2 Jan 2015</font></h3>
    <UL>
        <font size="5">
            <li>E15122014009 - Remove view Team and enable Team members under modules itself</li>
            <li>E11122014015 - The test script should be editable till business process is frozen</li>
            <li>E08122014008 - hot link between tree and issues</li>
        </font>
    </UL>
    <h3><font>eTracker&#0153; 3.0_21 Sprint Released on 29 Dec 2014</font></h3>
    <UL>
        <font size="5">
            <li>E15122014010 - Project + Module + Resource Planning Map</li>
            <li>E05122014005 - WRM day in the add project screen</li>
        </font>
    </UL>

    <h3><font >eTracker&#0153; 3.0_20 Sprint Released on 17 Dec 2014</font></h3>
    <UL>
        <font size="5">
            <li>E29112014001 - Test Script Sequencing in Test Plan</li>
            <li>E24112014006 - WRM Maintenance for Active Project</li>
        </font>
    </UL>
    <h3><font>eTracker&#0153; 3.0_19 Sprint  Released on 8 Dec 2014</font></h3>
    <UL>
        <font size="5">
            <li>E03122014015 - Need all options under add variant in edit variant also</li>
            <li>E03122014016 - Need to be able to attach a file to the test script level along with expected result</li>
        </font>
    </UL>
    <h3><font>eTracker&#0153; 3.0_18 Sprint  Released on 15 Oct 2014</font></h3>
    <UL>
        <font size="5">
            <li>E10062014013 - CRM My searches</li>

        </font>
    </UL>
    <h3><font >eTracker&#0153; 3.0_17 Sprint  Released on 13 Oct 2014</font></h3>
    <UL>
        <font size="5">
            <li>E10102014006 - Introduced BTC Review Status</li>
            <li>E09042014004 - Introduced Configuration Review status</li>
            <li>E11092014008 - WRM committed issue list in Email</li>
            <li>E01092014005 - Introduced Fine Amount Management </li>

        </font>
    </UL>

    <h3><font >eTracker&#0153; 3.0_16 Sprint Released on 28 Jun 2014</font></h3>
    <UL>
        <font size="5">
            <li>E23052014001 - Centralised Team Maintenance.</li>
            <li>E26062014004 - Summation of all project closed issues in PM's Rank link</li>
            <li>E02062014007 - Need email update when ever WRM is created and update</li>
        </font>
    </UL>
    <h3><font >eTracker&#0153; 3.0_15 Sprint Released on 24 Jun 2014</font></h3>
    <UL>
        <font size="5">
            <li>E02062014003 - Need Module Wise, Day Wise and Age Wise for Open, Created, Worked and Closed issues.</li>

        </font>
    </UL>
    <h3><font >eTracker&#0153; 3.0_13 Sprint Released on 30 May 2014</font></h3>
    <UL>
        <font size="5">
            <li>E19052014018 - Project Dashboard >> View Issues Closed issues need to be represented with current week closed issue.</li>
        </font>
    </UL>    
    <h3><font >eTracker&#0153; 3.0_10 Sprint Released on 21 May 2014</font></h3>
    <UL>
        <font size="5">
            <li>E15052014018 - Admin >> ERM >> Users should be sorted based on the Closed issues
        </font>
    </UL>
    <h3> <font>eTracker&#0153; 2.9.5_64 Sprint To be Released on <font color="blue">17 Dec 10</font></h3>

    <UL>
        <font size="5">
            <li>E28122007017 Finalize the UI for Students registration
            <li>E05122009006 Remove the Bug Filing program from programs section - not needed
            <li>E16052008013 Login with Admin adn user has security issue
            <li>E24122008002 Finding out the root cause for getting exception while retrieving connection from connection pool

        </font>
    </UL>

    <h3><font>eTracker&#0153; 2.9.5_63 Sprint To be Released on <font color="blue">10 Dec 10</font></h3>
    <UL>
        <font size="5">
            <li>E02042009002 The values shown for APM issues at present is not correct
            <li>E19032009024 Originator alone can reopen an issue from closed status
            <li>E19032009013 Non SAP issue flow from *Closed
            <li>E18022009009 Options for user to select the status update to Mobile
            <li>E04082008010 sorting of leads..
        </font>
    </UL>
    <h3><font>eTracker&#0153; 2.9.5_62 Sprint To be Released on <font color="blue">03 Dec 10</font></h3>
    <UL>
        <font size="5">
            <li>E05122009005 Programs need to say about SRM - students relationship management and the attract students
            <li>E15102009001 Date of Leave Request
            <li>E29092009001 My timesheet shown in hours is Buggy
            <li>E04082009004 Leave intimaton and alternative arrangement for the absentees.
            <li>E04082009003 Need attendance details in the profile page
        </font>
    </UL>
    <h3><font>eTracker&#0153; 2.9.5_61 Sprint To be Released on <font color="blue">26 Nov 10</font></h3>
    <UL>
        <font size="5">
            <li>E11122009004 Adding Sequnence for comment id in issuecomments table and Updating it in every issueupdate page
            <li>E10122009003 Adding commentid field in issuecomments table and create a primary key for ISSUECOMMENTS Table
            <li>E10122009002 Removing unwanted table "ISSUESTATUS" from DB and add issuestatus field in "ISSUE" Table
        </font>
    </UL>
    <h3><font>eTracker&#0153; 2.9.5_60 Sprint To be Released on <font color="blue">19 Nov 10</font></h3>
    <UL>
        <font size="5">
            <li>E05052010006 Lost Customer issue No:-E05052010003
            <li>E31122009002 Etracker unconfirmed issue not visible from the chart
            <li>E29122009001 Exclude range during searches.
        </font>
    </UL>
    <h3><font>eTracker&#0153; 2.9.5_59 Sprint To be Released on <font color="blue">12  Nov 10</font></h3>
    <UL>
        <font size="5">
            <li>E16122008005 These are the exceptions on the production server found from 5 Dec t o16 Dec 2008
            <li>E16072010002 Trial version with limited functionality login
            <li>E29082008002 S2P2 - Age in admin and user for the same issue is different ?
            <li>E04122009003 Issue not accounted to my time sheet
        </font>
    </UL>
    <h3><font>eTracker&#0153; 2.9.5_58 Sprint To be Released on <font color="blue">05 Nov 10</font></h3>
    <UL>
        <font size="5">
            <li>E19062010004 Enable the same functionality of Enter the Issue Number in the My Searches
            <li>E03062010001 Adding relevant icons in Menu Items
            <li>E05032009005 Project need to be validated for Version and End Date

        </font>
    </UL>

    <h3><font>eTracker&#0153; 2.9.5_57 Sprint To be Released on <font color="blue">29 Oct 10</font></h3>
    <UL>
        <font size="5">
            <li>E11072010001 Module is not getting selected in mysearches
            <li>E04082009002 leave request allows to enter the leave before the due date only
            <li>E29052010001 @ 2010-05-28T19:03:23.440+0530 >> java.sql.SQLException: Error in allocating a connection.
                <
        </font>
    </UL>
    <h3><font>eTracker&#0153; 2.9.5_56 Sprint To be Released on <font color="blue">22 Oct 10</font></h3>
    <UL>
        <font size="5">
            <li>E21052010001 Need bulk issue and test cases creation facility in eTracker™
            <li>E15042010005 Resource Request email format and information gap fillup
            <li>E17072010002 Redirection page of MyDashboard need to be same as that of Project Dashboard
            <li>E10072010010 My Resource Requistion link for user logins
        </font>
    </UL>
    <h3><font>eTracker&#0153; 2.9.5_55 Sprint To be Released on <font color="blue">15 Oct 10</font></h3>
    <UL>
        <font size="5">

            <li>E24112008001 Need Search Help....
            <li>E30072010011 Resource Request through eTracker System
            <li>E02072010001 In Valid Email Received
        </font>
    </UL>
    <h3><font>eTracker&#0153; 2.9.5_54 Sprint To be Released on <font color="blue">08 Oct 10</font></h3>
    <UL>
        <font size="5">
            <li>E01062010004 Reg - New functionality
            <li>E16062010005 Restriction of User Name in Assigned To & Created by Field
            <li>E09032009006 Create Isssue numbers for CRM issues
        </font>
    </UL>

    <h3><font>eTracker&#0153; 2.9.5_53 Sprint To be Released on <font color="blue">01 Oct 10</font></h3>
    <UL>
        <font size="5">

            <li>E15122008006 information loss when oppurtunity is moved into account
            <li>E25032009011 CRM summary required
            <li>E18072010002 Assign Modules same like team members selections
        </font>
    </UL>
    <h3><font>eTracker&#0153; 2.9.5_52 Sprint To be Released on <font color="blue">24 Sep 10</font></h3>
    <UL>
        <font size="5">
            <li>E06072010007 My Searches need have Phases search criteria if the proejct selected is SAP project
            <li>E17112009003 Bug in Issue status
            <li>E11072010002 When all timesheet are cleared - zero timesheet list need not be shown

        </font>
    </UL>
    <h3><font>eTracker&#0153; 2.9.5_51 Sprint To be Released on <font color="blue">17 Sep 10</font></h3>
    <UL>
        <font size="5">
            <li>E26052010009 How to check the ERM candidates from eTracker™ ?
            <li>E18062010002 Enhanced options to comment box
            <li>E19062010006 All submit, search and update button when clicked need to be in non-edit processing state
            <li>E01062008004 Search Field: Search criteria should allow search by Applicant ID
            <li>E10072010007 Review Document status
        </font>
    </UL>
    <h3><font>eTracker&#0153; 2.9.5_50 Sprint To be Released on <font color="blue">10 Sep 10</font></h3>
    <UL>
        <font size="5">
            <li>E14032010001 Along wiht APM timesheet the CRM + TQM should also be coming in
            <li>E10072010002 Primary and Secondary responsibility edit and view
            <li>E24052010010 The paper usage need ot be minimized when we print our issues
            <li>E30072010010 Tracking all active users in eTracker?
        </font>
    </UL>
    <h3><font>eTracker&#0153; 2.9.5_49 Sprint To be Released on <font color="blue">03 Sep 10</font></h3>
    <UL>
        <font size="5">
            <li>E01112009001 My Performance chart view for Weekly & Monthly
            <li>E26072010007 Regarding BPS ID for test case scenario execution
            <li>E20062010001 Adding pie chart for closed issue with legends of ratings
            <li>E12032010001 Regarding Server Encountered error in connection
        </font>
    </UL>

    <h3><font>eTracker&#0153; 2.9.5_48 Sprint To be Released on <font color="blue">27 Aug 10</font></h3>
    <UL>
        <font size="5">
            <li>E25032009005 java.lang.NumberFormatException from users >> add contacts when CRM project version not equal to 1.0
            <li>E06082009001 Need status flow chart for the both SAP and Non-SAP projects in help option.
            <li>E18082009004 Capture of CRID during the transportation processs

            <li>E10072010005 Re-Run of a Test Planned and generating the test execution result
        </font>
    </UL>

    <h3><font color="blue">eTracker&#0153; 2.9.5_47 Sprint To be Released on 20 Aug 10</font></h3>
    <UL>
        <font size="5">

            <li>E09032010003 Functionality to move a Common Test case to Project Test case
            <li>E21062010002 Test case execution comments not send to the user or worked person
            <li>E30072010017 My Assignment with all "0" assigned issues
            <li>E31052010001 My Test Cases
            <li>E09032010007 Displaying Tesing Comments in every Product Test cases
            <li>E08082010001 Sequence Number in Create Test Plan > Add Test Cases
            <li>E14082010001 testcases can be added even after closing or aborting the test plan
            <li>E05082010008 Test Case ID Search in Test Case View

        </font>
    </UL>
    <h3><font color="#04B404">eTracker&#0153; 2.9.5_46 Sprint Released on 14 Aug 10</font></h3>
    <UL>
        <font size="5">

            <li>E21072010001 - Attachment of document to test case
            <li>E30072010002 - Performance enhancement in TER Lising
            <li>E14072010004 - Edit an existing test plan and Add Test Cases functionality does not work fine
            <li>E30072010005 - Validating Issue Id Entered when test case fails
            <li>E28072010002 - Restricting status flow in the edit TEP
            <li>E14072010001 - User >> assigned test cases for execution need to have Due Date and Assigned To information
            <li>E13082010001 - Link to be enabled from MyTest Cases to Test Plans
            <li>E06082010004 - Clicking of View Test Plan 
            <li>E10082010001 - Email alert for Test Execution Results
            <li>E09082010007 - View Test Plans in Test Result dashboard page
            <li>E05062008002 - TQM for goverenance of Project or Product Quality



        </font>
    </UL>
    <h3><font >eTracker&#0153; 2.9.5_45 Sprint Released on 31 Jul 10</font></h3>
    <UL>
        <font size="5">
            <li>E29092009007 Product Test case Management Module in TQM
            <li>E10122009005 Attendance validation error in Timesheet Attendance Approval
            <li>E11122009003 Email messaging of denied and disabled users.
            <li>E18062010005 "Assigned To" should not be defautled to originals.
            <li>E23062010001 How null rating is possible
            <li>E03072010001 ERROR Modify Issue for Admin - Exception:java.lang.NullPointerException
            <li>E08072010001 Creating a pie chart to show test case execution status for Test Case Execution Plan
            <li>E10072010013 Test Execution Result Dashboard
            <li>E14072010002 via the project dashboard, I could by pass the BTC stage
            <li>E14072010008 "Select Dashboard of" in mydashboard
            <li>E15072010001 Eminentlabs™ APM Performance Chart
            <li>E18072010001 Planned eTracker™ 2.9.5_45 Sprint To be Released on xx Jul 2010 (30% would be backlog coverage)
            <li>E19072010001 Test case is not updated
            <li>E19072010017 Module Name displayed with module id My Test Cases
            <li>E19072010018 Cannot update the status of the TEP
            <li>E22072010002 When an user is assigned to CRM Project Add Contact should be that of Admin
            <li>E26072010003 In admin TQM > when we click on PTCM link - a pie chart with project names should appear
            <li>E04032010001 Moving Product Test cases to common test cases
            <li>E10072010003 Need Actual Start Date and Actual End End
            <li>E14072010003 For the failed test cases in TER - exesting issue rereference or a new issue need to be created
            <li>E17072010001 For TCE and TER planning the module name should be displayed in all the list views
            <li>E26072010001 TEP Created Line graph >> result set need to have correct header names
            <li>E26072010004 In Print this issue > the test cases covered also should be present
            <li>E26072010005 The passed and Not Applicable test cases executed in the test plan need not be sent to My Assignment
            <li>E16072010001 In user login > My Test Cases > Create Project Test Case for one project it should be by default
            <li>E30072010005 Validating Issue Id Entered when test case fails
            <li>E30072010007 For failed test cases the Create New Reference Issue need to have the Test cases id in the root caus

        </font>
    </UL>

    <h3><font >eTracker&#0153; 2.9.5_44 Sprint Released on 18 Jul 2010</font></h3>

    <UL>
        <font size="5">

            <li>Added Module in all Issue list pages </li>
            <li>Added issue reference in Failed Test Cases </li>
        </font>
    </UL>
    <h3><font >eTracker&#0153; 2.9.5_43 Sprint Released on 10 Jul 2010</font></h3>

    <UL>
        <font size="5">
            <li>Added TQM Test Case Execution Plan in TER</li>
            <li>Added TQM Test Case Execution with Test case addition to the Plan</li>
            <li>Added TQM Test Case Execution in MyAssignment</li>
        </font>
    </UL>
    <h3><font>eTracker&#0153; 2.9.5_42 Sprint Released on 02 Jul 2010</font></h3>

    <UL>
        <font size="5">
            <li>Added CR ID and CreatedOn in My Searches </li>

        </font>
    </UL>
    <h3><font>eTracker&#0153; 2.9.5_41 Sprint Released on 27 Jun 2010</font></h3>

    <UL>
        <font size="5">
            <li>Added CR ID and Description for SAP Projects </li>
            <li>Added Project Performance chart for all Individual Projects </li>

        </font>
    </UL>

    <h3><font>eTracker&#0153; 2.9.5_40 Sprint Released on 20 Jun 2010</font></h3>

    <UL>
        <font size="5">
            <li>Added Test Coverage chart for Project </li>
            <li>Added Logo and footer in Print Issue page </li>
            <li>Added Rating for Closed Issues </li>
            <li>Added email for Denied and Disable Users </li>
            <li>Added Open Issues graph in APM Performance Chart</li>

        </font>
    </UL>
    <h3><font>eTracker&#0153; 2.9.5_39 Sprint Released on 04 Jun 2010</font></h3>

    <UL>
        <font size="5">

            <li>Added weekly project status email </li>
            <li>Added My Test Cases in User login</li>

        </font>
    </UL>
    <h3><font >eTracker&#0153; 2.9.5_38 Sprint Released on 28 May 2010</font></h3>

    <UL>
        <font size="5">

            <li>Added new status called User Error </li>
            <li>Added restriction in My Dashboard to show mutually inclusive project issues</li>

        </font>
    </UL>
    <h3><font  >eTracker&#0153; 2.9.5_37 Sprint Released on 25 May 2010</font></h3>

    <UL>
        <font size="5">

            <li>Added email alerts for Executive Sponsorer, Project Stakeholder,Project Coordinator, Account Manager and Delivery Manager in Project. </li>
            <li>Issue status in My Searches is fine tuned to show the status according to the selection of Projects and SAP Projects</li>
            <li>Added Enabling and Disabling of mail alerts for Executive Sponsorer, Project Stakeholder,Project Coordinator, Account Manager and Delivery Manager</li>

        </font>
    </UL>
    <h3><font>eTracker&#0153; 2.9.5_36 Sprint  Released on 14 May 2010</font></h3>

    <UL>
        <font size="5">

            <li>Conti weekly update mail refactored. </li>
            <li>Added Executive Sponsorer, Project Stakeholder,Project Coordinator, Account Manager and Delivery Manager in Project. </li>

        </font>
    </UL>
    <h3><font>eTracker&#0153; 2.9.5_35 Sprint Released on 24 Mar 2010</font></h3>

    <UL>
        <font size="5">

            <li>Added auto reassignment of issue to Project Manager if due date exceeds </li>
            <li>Fixed the bug in Timesheet info </li>

        </font>
    </UL>
    <h3><font>eTracker&#0153; 2.9.5_34 Sprint Released on 16 Mar 2010</font></h3>

    <UL>
        <font size="5">

            <li>Added TQM status QA-BTC(Build Test Cases) and QA-TCE(Test Case Execution) </li>
            <li>Incorporated Test Case Addition in My Assignment</li>
            <li>Incorporated Test Case Execution in My Assignment</li>
            <li>Restricted status flow if no Test case added in QA-BTC status</li>
            <li>Restricted status flow if all Test cases are not passed in QA-TCE status</li>
            <li>Added Charts for CRM and TQM Modules</li>
        </font>
    </UL>
    <h3><font >eTracker&#0153; 2.9.5_33 Sprint Released on 26 Nov 2009</font></h3>

    <UL>
        <font size="5">
            <li>Captured Issue Status when files are attached</li>
            <li>Configured mail flow for Timesheet Approval</li>

        </font>
    </UL>
    <h3><font>eTracker&#0153; 2.9.5_32 Sprint  Released on 21 Nov 2009</font></h3>

    <UL>
        <font size="5">

            <li>Added Cyclic flow of Timesheet to capture adequate information if it is not provided</li>
            <li>Added Tool Tip for MyPerformance lik to view no of issue in TimeSheet</li>

        </font>
    </UL>
    <h3><font >eTracker&#0153; 2.9.5_31 Sprint Released on 06 Nov 2009</font></h3>

    <UL>
        <font size="5">
            <li>Added attendance in MyPerformance Chart</li>
            <li>Approval summary page at the click of Approval % in MyPerformance</li>
            <li>Added Open Issues search in My Searches</li>

        </font>
    </UL>
    <h3><font>eTracker&#0153; 2.9.5_30 Sprint Released on 01 Nov 2009</font></h3>

    <UL>
        <font size="5">
            <li>Create issue restriction if issue in verified status is not updated</li>
            <li>Workflow of TimeSheet approval, Attendance capture and Accounts narration</li>
            <li>Enabled MyPerformance Chart for Individual's performance review process </li>

        </font>
    </UL>
    <h3><font color="">eTracker&#0153; 2.9.5_29 Sprint Released on 29 Jul 2009</font></h3>

    <UL>
        <font size="5">
            <li>Leave Approval Functionality - Phase II.</li>
            <li>Added Assigned To,Requested On, Updated on and Updated By details in mail.</li>
        </font>
    </UL>
    <h3><font >eTracker&#0153; 2.9.5_28 Sprint Released on 22 Jul 2009</font></h3>

    <UL>
        <font size="5">
            <li>Changed the Alignment,color and size in Leave Approval Mail</li>
            <li>Added restriction to Project Dashboard.</li>
        </font>
    </UL>

    <h3><font >eTracker&#0153; 2.9.5_27 Sprint Released on 10 Jul 2009</font></h3>

    <UL>
        <font size="5">
            <li>Incorporating Employee Handbook and Eminent Holiday Calendar in Profile.</li>
            <li>Leave Approval Functionality - Phase I.</li>
        </font>
    </UL>
    <h3><font >eTracker&#0153; 2.9.5_26 Sprint Released on 10 Jun 2009</font></h3>

    <UL>
        <font>
            <li>Scheduled a Mail for Project Manger to know about their team members daily worked issues.</li>
            <li>Scheduled a Mail for Customer Users and Project members to get an update on their project status on weekly basis.</li>
        </font>
    </UL>
    <h3><font >eTracker&#0153; 2.9.5_25 Sprint Released on 03 Jun 2009</font></h3>

    <UL>
        <font>
            <li>Added seperate link for Lost Opportunities </li>
            <li>Project Manager will be selected automatically if Assignedto person is disabled </li>
        </font>
    </UL>
    <h3><font >eTracker&#0153; 2.9.5_24 Sprint Released on 26 May 2009</font></h3>

    <UL>
        <font >
            <li>Assigned To will be selected automatically when status is Solution Review, Rejected, Duplicate and Verified </li>
            <li># of Issues, # of Contacts, # of Views is displayed on the left menu </li>
            <li>Right Click is disabled </li>
        </font>
    </UL>

    <h3><font >eTracker&#0153; 2.9.5_23 Sprint Released on 21 May 2009</font></h3>

    <UL>
        <font>
            <li>Mail Structure Modified</li>
            <li>Mail will be sent to PM,Orginator and Assigned person when an issue is updated</li>
        </font>
    </UL>
    <h3><font>eTracker&#0153; 2.9.5_22 Sprint Released on 15 May 2009</font></h3>

    <UL>
        <font size="5">
            <li>Mail Sender Name Added Instead of Admin</li>
            <li>New Features Header Modified</li>
        </font>
    </UL>
    <h3><font>eTracker&#0153; 2.9.5_21 Sprint Released on 30 April 2009</font></h3>
    <UL>
        <font >
            <li>Added Quartz for Mail Sceduling</li>
            <li>Scheduled a Mail for Every day Work Accomplishment</li>
            <li>Scheduled a Mail for Due Date Exceeded and Due Date about to exceed</li>
            <li>Scheduled a Mail for Verified Status Issues</li>
            <li>Scheduled a Job to make the values of every user to zero at the start of the month</li>
        </font>
    </UL>
    <h3><font >eTracker&#0153;2.9.5_20 Sprint Released on 23 April 2009</font></h3>

    <UL>
        <font>
            <li>Added Search Option in CRM Opportunity and Account</li>


        </font>
    </UL>

    <h3><font >eTracker&#0153; 2.9.5_19 Sprint Released on 08 April 2009</font></h3>

    <UL>
        <font >
            <li>Added New Status Flow for SAP Projects</li>


        </font>
    </UL>
    <UL>                 
        <li>
            From Unconfirmed the next status can be *Confirmed *Investigation *Duplicate *Rejected
        </li>
        <li>
            From Rejected the next status can be  *Investigation *Closed
        </li>
        <li>
            From Duplicate the next status can be *Reopen *Investigation *Closed
        </li>
        <li>
            From Investigation the next status can be *Confirmed  *Duplicate *Rejected
        </li>
        <li>
            From Confirmed the next status can be *Detail Design
        </li>
        <li>
            From Detail Design the next status can be *Customizing Request *Workbench Request
        </li>
        <li>
            From Customizing Request the next status can be *Workbench Request *Solution Review
        </li>
        <li>
            From Workbench Request the next status can be *Solution Review
        </li>
        <li>
            From Solution Review the next status can be *Workbench Request *Solution Review *Transport to TS
        </li>
        <li>
            From Transport to TS the next status can be *QA
        </li>
        <li>
            From QA the next status can be *Investigation *Customizing Request *Workbench Request *Transport to TS *Verified
        </li>
        <li>
            From Transport to TS the next status can be *Verified
        </li>
        <li>
            From Verified the next status can be *Investigation *Closed
        </li>
        <li>
            From Closed the next status can be *Investigation
        </li>

        <br></br>

        For SAP Support Projects, instead of Detail Design, Replicating in DS would be the status
        <li>
            From Unconfirmed the next status can be *Confirmed *Investigation *Duplicate *Rejected
        </li>
        <li>
            From Rejected the next status can be  *Investigation *Closed
        </li>
        <li>
            From Duplicate the next status can be *Reopen *Investigation *Closed
        </li>
        <li>
            From Investigation the next status can be *Confirmed  *Duplicate *Rejected
        </li>
        <li>
            From Confirmed the next status can be *Replicating in DS
        </li>
        <li>
            From Replicating in DS the next status can be *Customizing Request *Workbench Request
        </li>
        <li>
            From Customizing Request the next status can be *Workbench Request *Solution Review
        </li>
        <li>
            From Workbench Request the next status can be *Solution Review
        </li>
        <li>
            From Solution Review the next status can be *Workbench Request *Solution Review *Transport to TS
        </li>
        <li>
            From Transport to TS the next status can be *QA
        </li>
        <li>
            From QA the next status can be *Investigation *Customizing Request *Workbench Request *Transport to TS *Verified
        </li>
        <li>
            From Transport to TS the next status can be *Verified
        </li>
        <li>
            From Verified the next status can be *Investigation *Closed
        </li>
        <li>
            From Closed the next status can be *Investigation
        </li>
    </UL>

    <h3><font >eTracker&#0153; 2.9.5_18 Sprint Released on 01 April 2009</font></h3>

    <UL>
        <font>
            <li>My Searches & My Views has been revamped </li>


        </font>
    </UL>

    <h3><font>eTracker&#0153; 2.9.5_17 Sprint Released on 25 Mar 2009</font></h3>

    <UL>
        <font >
            <li>eTracker&#0153; APM Login User Documentation </li>


        </font>
    </UL>

    <h3><font >eTracker&#0153; 2.9.5_16 Sprint Released on 18 Mar 2009</font></h3>

    <UL>
        <font >
            <li>Value definition page added for Value System</li>


        </font>
    </UL>

    <h3><font >eTracker&#0153; 2.9.5_13 Sprint Released on 11 Mar 2009</font></h3>

    <UL>

        <li>Comment history order changed</li>
        <li>Comment history header alignment changed</li>
        <li>Opportunity updation and movement bugs fixed</li>
        <li>Lead Updation bug fixed</li>


    </UL>

    <h3><font >eTracker&#0153; 2.9.5_12 Sprint Released on 13 Jan 2009</font></h3>

    <UL>
        <font >
            <li>Comment history linked for CRM Issues</li>
            <li>Mail format modified while approving the users</li>
            <li>Added deal value and assignedto in the CRM Opportunity</li>
            <li>Added deal value,assignedto and account value in CRM Account</li>
            <li>Added Resource Requisition Functionality</li>
        </font>
    </UL>
    <%                    } else {

    %>
    <h3><font color="blue">eTracker&#0153; 3.0_25 Sprint  To Be Released on 13 Dec 2023</font></h3>
    <UL>
        <font size="5">
            <li>E10042017008 - Sub issue linking to the main issue</li>
            <li>E24102023007 - Day wise E-Invoice report </li>
        </font>
    </UL>
    <h3><font color="#04B404">eTracker&#0153; 3.0_24 Sprint Released on 22 Nov 2023</font></h3>
    <UL>
        <font size="5">
            <li>E28092023014 - Need asset link for our User IDs</li>
            <li>E28092023001 - Feedback comment adding mandatory for all rating</li>
            <li>Enabled demo links</li>
        </font>
    </UL>
    <h3><font>eTracker&#0153; 3.0_23 Sprint Released on 28 Oct 2023</font></h3>
    <UL>
        <font size="5">
            <li>E26092023004 - Locking the order sequence in My assignment</li>
            <li>E23082021001 - Sequence option for planned issues</li>
        </font></UL>
    <h3><font>eTracker&#0153; 3.0_22 Sprint Released on 2 Jan 2015</font></h3>
    <UL>
        <font size="5">
            <li>E15122014009 - Remove view Team and enable Team members under modules itself</li>
            <li>E11122014015 - The test script should be editable till business process is frozen</li>
            <li>E08122014008 - hot link between tree and issues</li>
        </font>
    </UL>
    <h3><font>eTracker&#0153; 3.0_21 Sprint Released on 29 Dec 2014</font></h3>
    <UL>
        <font size="5">
            <li>E15122014010 - Project + Module + Resource Planning Map</li>
            <li>E05122014005 - WRM day in the add project screen</li>
        </font>
    </UL>


    <h3><font>eTracker&#0153; 3.0_20 Sprint Released on 17 Dec 2014</font></h3>
    <UL>
        <font size="5">
            <li>E29112014001 - Test Script Sequencing in Test Plan</li>
            <li>E24112014006 - WRM Maintenance for Active Project</li>
        </font>
    </UL>
    <h3><font >eTracker&#0153; 3.0_19 Sprint  Released on 8 Dec 2014</font></h3>
    <UL>
        <font size="5">
            <li>E03122014015 - Need all options under add variant in edit variant also</li>
            <li>E03122014016 - Need to be able to attach a file to the test script level along with expected result</li>
        </font>
    </UL>
    <h3><font>eTracker&#0153; 3.0_18 Sprint  Released on 15 Oct 2014</font></h3>
    <UL>
        <font size="5">
            <li>E10062014013 - CRM My searches</li>

        </font>
    </UL>
    <h3><font >eTracker&#0153; 3.0_17 Sprint  Released on 13 Oct 2014</font></h3>
    <UL>
        <font size="5">
            <li>E10102014006 - Introduced BTC Review Status</li>
            <li>E09042014004 - Introduced Configuration Review status</li>
            <li>E11092014008 - WRM committed issue list in Email</li>
            <li>E01092014005 - Introduced Fine Amount Management </li>

        </font>
    </UL>
    <h3><font >eTracker&#0153; 3.0_17 Sprint  Released on 02 Jul 2014</font></h3>
    <UL>
        <font size="5">
            <li>E12062014004 - WRM Planned issue should be highlighted in the Project dashboard View Issue.</li>
        </font>
    </UL>
    <h3><font >eTracker&#0153; 3.0_16 Sprint Released on 28 Jun 2014</font></h3>
    <UL>
        <font size="5">
            <li>E23052014001 - Centralised Team Maintenance.</li>
            <li>E26062014004 - Summation of all project closed issues in PM's Rank link</li>
            <li>E02062014007 - Need email update when ever WRM is created and update</li>
        </font>
    </UL>


    <h3><font >eTracker&#0153; 3.0_14 Sprint Released on 12 Jun 2014</font></h3>
    <UL>
        <font size="5">
            <li>E03052014005 - Separate the worked issue and coordinated issue during the submission of the timesheet.</li>
            <li>E29052014015 - My issue and My assignment should show assigned by person over tooltip of created by or assigned to.</li>
            <li>E14052014008 - The select all option should be restricted to Functionality level in view test plan screen.</li>
            <li>E14052014007 - Require 'Applicable to All' option for assigning the name who executing the script in the Test Plan.</li>
            <li>E15052014009 - Showing Non SAP process in red in tree, if type is available.</li>
            <li>E11062014010 - Need option to change the due date for DM.</li>

        </font>
    </UL>
    <h3><font >eTracker&#0153; 3.0_13 Sprint Released on 30 May 2014</font></h3>
    <UL>
        <font size="5">
            <li>E19052014018 - Project Dashboard >> View Issues Closed issues need to be represented with current week closed issue.</li>
            <li>E09052014002 - Easy Identification of issues in the serach options.</li>
            <li>E15052014003 - No of issue closure for a week project wise</li>
        </font>
    </UL>
    <h3><font >eTracker&#0153; 3.0_12 Sprint Released on 23 May 2014</font></h3>
    <UL>
        <font size="5">

            <li>E10022014008 - Search Options.</li>
            <li>E15052014010 - Capturing SAP and Non SAP type for upload.</li>
        </font>
    </UL>
    <h3><font >eTracker&#0153; 3.0_11 Sprint Released on 22 May 2014</font></h3>
    <UL>
        <font size="5">

            <li>E11012014001 - My performance link - Major bug</li>
            <li>E21052014001 -  In View Test Plans drop down option for CREATED BY field should available.</li>                                   
        </font>
    </UL>
    <h3><font >eTracker&#0153; 3.0_10 Sprint Released on 21 May 2014</font></h3>
    <UL>
        <font size="5">

            <li>E03052014004 - Report to list all delivery team members in descending orders of the closed issues</li>
            <li>E24012014003 - Recruiters need to know the status of their candidates.</li>
            <li>E02042014006 - Need popup to instruct and re-direct to Process Tree Map.</li>
        </font>
    </UL>
    <h3><font >eTracker&#0153; 3.0_09 Sprint Released on 19 May 2014</font></h3>
    <UL>
        <font size="5">

            <li>E14052014009 - Provision for PM & DM to Plan issues for Next Day</li>

        </font>
    </UL>
    <h3><font >eTracker&#0153; 3.0_08 Sprint Released on 14 May 2014</font></h3>
    <UL>
        <font size="5">
            <li>E17042014003 - The old weekly review meetings should be in display mode only</li>
            <li>E23042014002 - Daily planned issue should be highlighter in MyAssignment</li>
            <li>E30042014004 - Need 'Absent' status for leave in admin</li>
            <li>E28042014003 - View Test Plans should be in the Descending order of Completion %</li>
            <li>E13052014007 - View Issues under project dashboard need to be enahanced</li>
            <li>Enabled Test Plan Export to Excel</li>
        </font>
    </UL>
    <h3><font >eTracker&#0153; 3.0_07 Sprint  Released on 29 Apr 2014</font></h3>

    <UL>
        <font size="5">

            <li>E29042014001 - Order of Team Members in Daily Project Update Mail</li>
            <li>E28032014005 - Feedback Comment</li>
            <li>E22042014002 - Capturing Type of the Process in Tree</li>
            <li>E23042014004 - Along with Finshed project the Aborted project also need to be removed from search lists</li>
        </font>
    </UL>


    <h3><font >eTracker&#0153; 3.0_06 Sprint Released on 22 Apr 2014</font></h3>
    <UL>
        <font size="5">

            <li>Enabled Upload testscripts from TestMapTreeView</li>
            <li>Enabled Tree test case passed and failed count should reflect testplan test case details too</li>
            <li>Enabled popup to instruct and re-direct to Process Tree Map from create issue</li>
            <li>Enabled Capturing Type of the Process in Tree while updating Process from Business Process to Test Step and SAP-Non SAP count display - Phase I</li>
        </font>
    </UL>
    <h3><font>eTracker&#0153; 3.0_05 Sprint Released on 16 Apr 2014</font></h3>
    <UL>
        <font size="5">

            <li>MoM - To Enable Weekly Review Meeting with Customers</li>
            <li>MoM - To Enable MoM FeedBack about Chair Persons</li>
            <li>MoM - To Enable Moderator should be able to remove the already planned issue</li>
        </font>
    </UL>
    <h3><font>eTracker&#0153; 2.9.5_55 Sprint Released on 16 Sep 2011</font></h3>

    <UL>
        <font size="5">

            <li>APM - To Enable Search For CRM, BPM, TQM and ERM Phase I</li>
            <li>ERM - To Enable Applicants Registration - Phase II </li>

        </font>
    </UL>
    <h3><font>eTracker&#0153; 2.9.5_54 Sprint Released on 09 Sep 2011</font></h3>

    <UL>
        <font size="5">

            <li>APM - TO Enable Summary Table for CRM, BPM, APM, TQM and ERM </li>
            <li>ERM - To Enable Applicants Registration - Phase I</li>
            <li>ERM - To Enable Performance Evaluation Process - Phase II </li>

        </font>
    </UL>
    <h3><font>eTracker&#0153; 2.9.5_53 Sprint Released on 02 Sep 2011</font></h3>

    <UL>
        <font size="5">
            
            <li>APM - To Enable Rich Text Editor for User Inputs </li>
            <li>ERM - To Enable Performance Evaluation Process - Phase I </li>
        </font>
    </UL>
    <h3><font>eTracker&#0153; 2.9.5_52 Sprint Released on 26 Aug 2011</font></h3>

    <UL>
        <font size="5">

            <li>APM - Added User Last Login Detail </li>
            <li>APM - Enabled Rich Text Editor for Create Issue</li>
            <li>APM - Added User Restriction for Projects in My Searches  </li>
        </font>
    </UL>
    <h3><font >eTracker&#0153; 2.9.5_51 Sprint Released on 19 Aug 2011</font></h3>

    <UL>
        <font size="5">

            <li>ERM - Enabled Resource Request Resume Attachment Functionality  </li>
            <li>ERM - Enabled Print Resource Request Feature  </li>
        </font>
    </UL>
    <h3><font>eTracker&#0153; 2.9.5_50 Sprint Released on 30 Oct 2010</font></h3>

    <UL>
        <font size="5">

            <li>Added Text editor for comments box </li>

        </font>
    </UL>
    <h3><font >eTracker&#0153; 2.9.5_49 Sprint Released on 17 Nov 2010</font></h3>

    <UL>
        <font size="5">

            <li>Added Resource Requisition view page </li>
            <li>Added Timesheet remainder mail </li>
        </font>
    </UL>
    <h3><font >eTracker&#0153; 2.9.5_48 Sprint Released on 30 Sep 2010</font></h3>

    <UL>
        <font size="5">

            <li>Added new status Documentation and Review </li>
            <li>Added new status Training,Evaluation </li>
            <li>Added Project Status in Edit Project </li>

        </font>
    </UL>
    <h3><font >eTracker&#0153; 2.9.5_47 Sprint Released on 25 Sep 2010</font></h3>

    <UL>
        <font size="5">

            <li>Added Phase wise start date and end date for SAP Projects </li>
            <li>Revamped Timesheet with CRM, APM, TQM, ERM and LAM details </li>


        </font>
    </UL>
    <h3><font >eTracker&#0153; 2.9.5_46 Sprint Released on 14 Aug 2010</font></h3>

    <UL>
        <font size="5">

            <li>Attachment of document to test case </li>
            <li>Link to be enabled from MyTest Cases to add testcases to Test Plans </li>
            <li>Email alert for Test Execution Results</li>

        </font>
    </UL>
    <h3><font >eTracker&#0153; 2.9.5_45 Sprint To be Released on 05 Aug 2010</font></h3>

    <UL>
        <font size="5">

            <li>Added Pie chart in PTCM </li>
            <li>Added Actual Start Date and End Date in Test Plan </li>
        </font>
    </UL>
    <h3><font>eTracker&#0153; 2.9.5_44 Sprint Released on 18 Jul 2010</font></h3>

    <UL>
        <font size="5">

            <li>Added Module in all Issue list pages </li>
            <li>Added issue reference in Failed Test Cases </li>
        </font>
    </UL>
    <h3><font >eTracker&#0153; 2.9.5_43 Sprint Released on 10 Jul 2010</font></h3>

    <UL>
        <font size="5">
            <li>Added TQM Test Case Execution Plan in TER</li>
            <li>Added TQM Test Case Execution with Test case addition to the Plan</li>
            <li>Added TQM Test Case Execution in MyAssignment</li>
        </font>
    </UL>
    <h3><font >eTracker&#0153; 2.9.5_42 Sprint Released on 02 Jul 2010</font></h3>

    <UL>
        <font size="5">
            <li>Added CR ID and Created On in MySearches </li>

        </font>
    </UL>
    <h3><font >eTracker&#0153; 2.9.5_41 Sprint Released on 27 Jun 2010</font></h3>

    <UL>
        <font size="5">
            <li>Added CR ID and Description for SAP Projects </li>
            <li>Added Project Performance chart for all Individual Projects </li>

        </font>
    </UL>
    <h3><font >eTracker&#0153; 2.9.5_40 Sprint Released on 20 Jun 2010</font></h3>

    <UL>
        <font size="5">
            <li>Added Test Coverage chart for Project </li>
            <li>Added Logo and footer in Print Issue page </li>
            <li>Added Rating for Closed Issues </li>
            <li>Added email for Denied and Disable Users </li>
            <li>Added Open Issues graph in APM Performance Chart</li>

        </font>
    </UL>
    <h3><font >eTracker&#0153; 2.9.5_39 Sprint Released on 04 Jun 2010</font></h3>

    <UL>
        <font size="5">

            <li>Added weekly project status email </li>
            <li>Added My Test Cases in User login</li>

        </font>
    </UL>
    <h3><font>eTracker&#0153; 2.9.5_38 Sprint Released on 28 May 2010</font></h3>

    <UL>
        <font size="5">

            <li>Added new status called User Error </li>
            <li>Added restriction in My Dashboard to show mutually inclusive project issues</li>

        </font>
    </UL>
    <h3><font  >eTracker&#0153; 2.9.5_37 Sprint Released on 25 May 2010</font></h3>


    <UL>
        <font size="5">

            <li>Added email alerts for Executive Sponsorer, Project Stakeholder,Project Coordinator, Account Manager and Delivery Manager in Project. </li>
            <li>Issue status in My Searches is fine tuned to show the status according to the selection of Projects and SAP Projects</li>
            <li>Added Enabling and Disabling of mail alerts for Executive Sponsorer, Project Stakeholder,Project Coordinator, Account Manager and Delivery Manager</li>

        </font>
    </UL>
    <h3><font>eTracker&#0153; 2.9.5_35 Sprint Released on 24 Mar 2010</font></h3>

    <UL>
        <font size="5">

            <li>Added auto reassignment of issue to Project Manager if due date exceeds </li>
            <li>Fixed the bug in Timesheet info </li>

        </font>
    </UL>
    <h3><font>eTracker&#0153; 2.9.5_34 Sprint Released on 16 Mar 2010</font></h3>

    <UL>
        <font size="5">
            <li>Added TQM status QA-BTC(Build Test Cases) and QA-TCE(Test Case Execution) </li>
            <li>Incorporated Test Case Addition in My Assignment</li>
            <li>Incorporated Test Case Execution in My Assignment</li>
        </font>
    </UL>
    <h3><font>eTracker&#0153; 2.9.5_33 Sprint Released on 26 Nov 2009</font></h3>

    <UL>
        <font size="5">
            <li>Captured Issue Status when files are attached</li>
            <li>Configured mail flow for Timesheet Approval</li>

        </font>
    </UL>
</UL>
<h3><font >eTracker&#0153; 2.9.5_32 Sprint Released on 21 Nov 2009</font></h3>

<UL>
    <font size="5">

        <li>Added Cyclic flow of Timesheet to capture adequate information if it is not provided</li>
        <li>Added Tool Tip for MyPerformance lik to view no of issue in TimeSheet</li>

    </font>
</UL>
<h3><font>eTracker&#0153; 2.9.5_31 Sprint Released on 06 Nov 2009</font></h3>

<UL>
    <font size="5">
        <li>Added attendance in MyPerformance Chart</li>
        <li>Approval summary page at the click of Approval % in MyPerformance</li>
        <li>Added Open Issues search in My Searches</li>

    </font>
</UL>
<h3><font>eTracker&#0153; 2.9.5_30 Sprint Released on 01 Nov 2009</font></h3>

<UL>
    <font size="5">
        <li>Create issue restriction if issue in verified status is not updated</li>
        <li>Workflow of TimeSheet approval, Attendance capture and Accounts narration</li>
        <li>Enabled MyPerformance Chart for Individual's performance review process </li>

    </font>
</UL>
<h3><font >eTracker&#0153; 2.9.5_29 Sprint Released on 29 Jul 2009</font></h3>

<UL>
    <font size="5">
        <li>Leave Approval Functionality - Phase II.</li>
        <li>Added Assigned To,Requested On, Updated on and Updated By details in mail.</li>
    </font>
</UL>
<h3><font >eTracker&#0153; 2.9.5_28 Sprint Released on 22 Jul 2009</font></h3>

<UL>
    <font size="5">
        <li>Changed the Alignment,color and size in Leave Approval Mail</li>
        <li>Added restriction to Project Dashboard.</li>
    </font>
</UL>
<h3><font  >eTracker&#0153; 2.9.5_27 Sprint Released on 10 Jul 2009</font></h3>

<UL>
    <font size="5">
        <li>Incorporating Employee Handbook and Eminent Holiday Calendar in Profile.</li>
        <li>Leave Approval Functionality - Phase I.</li>
    </font>
</UL>
<h3><font>eTracker&#0153; 2.9.5_26 Sprint Released on 10 Jun 2009</font></h3>

<UL>
    <font>
        <li>Scheduled a Mail for Project Manger to know about their team members daily worked issues.</li>
        <li>Scheduled a Mail for Customer Users and Project members to get an update on their project status on weekly basis.</li>
    </font>
</UL>
<h3><font>eTracker&#0153; 2.9.5_25 Sprint Released on 03 Jun 2009</font></h3>

<UL>
    <font >
        <li>Project Manager will be selected automatically if Assignedto person is disabled </li>
    </font>
</UL>
<h3><font >eTracker&#0153; 2.9.5_24 Sprint Released on 26 May 2009</font></h3>

<UL>
    <font >
        <li>Assigned To will be selected automatically when status is Solution Review, Rejected, Duplicate and Verified </li>
        <li># of Issues, # of Contacts, # of Views is displayed on the left menu </li>
        <li>Right Click is disabled </li>
    </font>
</UL>
<h3><font>eTracker&#0153; 2.9.5_23 Sprint Released on 21 May 2009</font></h3>

<UL>
    <font>
        <li>Mail Structure Modified</li>
        <li>Mail will be sent to PM,Orginator and Assigned person when an issue is updated</li>
    </font>
</UL>
<h3><font >eTracker&#0153; 2.9.5_22 Sprint Released on 15 May 2009</font></h3>

<UL>
    <font >
        <li>Mail Sender Name Added Instead of Admin</li>
        <li>New Features Header Modified</li>
    </font>
</UL>
<h3><font>eTracker&#0153; 2.9.5_21 Sprint Released on 30 April 2009</font></h3>
<UL>
    <font >
        <li>Added Quartz for Mail Sceduling</li>
        <li>Scheduled a Mail for Every day Work Accomplishment</li>
        <li>Scheduled a Mail for Due Date Exceeded and Due Date about to exceed</li>
        <li>Scheduled a Mail for Verified Status Issues</li>
        <li>Scheduled a Job to make the values of every user to zero at the start of the month</li>
    </font>
</UL>
<h3><font >eTracker&#0153; 2.9.5_20 Sprint Released on 23 April 2009</font></h3>

<UL>
    <font >
        <li>Added Search Option in CRM Opportunity and Account</li>


    </font>
</UL>

<h3><font >eTracker&#0153; 2.9.5_19 Sprint Released on 08 April 2009</font></h3>

<UL>
    <font >
        <li>Added New Status Flow for SAP Projects</li>

        <p>
        <li>
            From Unconfirmed the next status can be *Confirmed *Investigation *Duplicate *Rejected
        </li>
        <li>
            From Rejected the next status can be  *Investigation *Closed
        </li>
        <li>
            From Duplicate the next status can be *Reopen *Investigation *Closed
        </li>
        <li>
            From Investigation the next status can be *Confirmed  *Duplicate *Rejected
        </li>
        <li>
            From Confirmed the next status can be *Detail Design
        </li>
        <li>
            From Detail Design the next status can be *Customizing Request *Workbench Request
        </li>
        <li>
            From Customizing Request the next status can be *Workbench Request *Solution Review
        </li>
        <li>
            From Workbench Request the next status can be *Solution Review
        </li>
        <li>
            From Solution Review the next status can be *Workbench Request *Solution Review *Transport to TS
        </li>
        <li>
            From Transport to TS the next status can be *QA
        </li>
        <li>
            From QA the next status can be *Investigation *Customizing Request *Workbench Request *Transport to TS *Verified
        </li>
        <li>
            From Transport to TS the next status can be *Verified
        </li>
        <li>
            From Verified the next status can be *Investigation *Closed
        </li>
        <li>
            From Closed the next status can be *Investigation
        </li>

        <br></br>

        For SAP Support Projects, instead of Detail Design, Replicating in DS would be the status
        <li>
            From Unconfirmed the next status can be *Confirmed *Investigation *Duplicate *Rejected
        </li>
        <li>
            From Rejected the next status can be  *Investigation *Closed
        </li>
        <li>
            From Duplicate the next status can be *Reopen *Investigation *Closed
        </li>
        <li>
            From Investigation the next status can be *Confirmed  *Duplicate *Rejected
        </li>
        <li>
            From Confirmed the next status can be *Replicating in DS
        </li>
        <li>
            From Replicating in DS the next status can be *Customizing Request *Workbench Request
        </li>
        <li>
            From Customizing Request the next status can be *Workbench Request *Solution Review
        </li>
        <li>
            From Workbench Request the next status can be *Solution Review
        </li>
        <li>
            From Solution Review the next status can be *Workbench Request *Solution Review *Transport to TS
        </li>
        <li>
            From Transport to TS the next status can be *QA
        </li>
        <li>
            From QA the next status can be *Investigation *Customizing Request *Workbench Request *Transport to TS *Verified
        </li>
        <li>
            From Transport to TS the next status can be *Verified
        </li>
        <li>
            From Verified the next status can be *Investigation *Closed
        </li>
        <li>
            From Closed the next status can be *Investigation
        </li>
        </p>
    </font>
</UL>

<h3><font >eTracker&#0153; 2.9.5_18 Sprint Released on 01 April 2009</font></h3>

<UL>
    <font>
        <li>My Searches & My Views has been revamped </li>


    </font>
</UL>

<h3><font>eTracker&#0153; 2.9.5_17 Sprint Released on 25 Mar 2009</font></h3>

<UL>
    <font>
        <li>eTracker&#0153; APM Login User Documentation  </li>
        <li>Status flow for Non SAP Projects  </li>
        <li>Captured history of severity and priority in Comment History </li>


    </font>
</UL>




<h3><font >eTracker&#0153; 2.9.5_16 Sprint Released on 18 Mar 2009</font></h3>

<UL>
    <font>
        <li>Added Customer satisfaction level option when an issue is closed</li>



    </font>
</UL>

<h3><font >eTracker&#0153; 2.9.5_15 Sprint Released on 11 Mar 2009</font></h3>

<UL>

    <li>Added Code Review status in the issue transition </li>
    <li>Displaying fix versions for SAP Projects only if the type of matching projects are same</li>



</UL>

<h3><font >eTracker&#0153; 2.9.5_12 Sprint Released on 13 Jan 2009</font></h3>
<ul>
    <li>Originator of the issue can close it from My Assignment in verified status</li>
    <li>Click on New Features link to explore the Enhancements, New features and Bug fixing introduced in the current sprint release </li>

</ul>
<%                            }
%>




</body>
</html>

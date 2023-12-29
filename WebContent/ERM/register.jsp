-<%-- 
    Document   : index
    Created on : Apr 4, 2012, 8:49:43 AM
    Author     : Tamilvelan
--%>
<%@page import="com.eminent.issue.ApmTeam"%>
<%@ include file="../noScript.jsp" %>
<%
    String ua = request.getHeader("User-Agent");
    boolean isFirefox = (ua != null && ua.indexOf("Firefox/") != -1);
    boolean isMSIE = (ua != null && ua.indexOf("MSIE") != -1);
    response.setHeader("Vary", "User-Agent");
    if (!isMSIE) {
%>
<%--<jsp:forward page="BrowserWarning.jsp"/>--%>
<%
    }
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@page import="java.util.Calendar,java.util.Date" %>
<html>
    <head>

        <LINK title=STYLE href="<%= request.getContextPath()%>/eminentech support files/main_ie.css" type="text/css" rel=STYLESHEET>
        <meta http-equiv="Content-Type" content="text/html">
        <title>Eminentlabs&trade; - Enterprise Resource Management</title>
        <script src="<%=request.getContextPath()%>/javaScript/jquery-latest.min_1.js" type="text/javascript"></script>
        <script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script> 
        <script src="https://code.jquery.com/jquery-1.9.1.js"></script>
        <script src="https://code.jquery.com/jquery-migrate-1.2.1.js"></script>

        <script type="text/javascript" src="<%= request.getContextPath()%>/eminentech support files/datepicker.js"></script>
        <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/checkSubmit.js"></script>
        <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/candidate.js?test=05012021"></script>
        <link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/redmond/jquery-ui.css">
        <style type="text/css">
            tr.apjblock td[colspan="7"] {
                padding-bottom:20px;  
            }
            input {text-transform: uppercase;}

            input[type="text"],select{
                height: 25px;
                border: solid 1px #AFCBFD;
                outline: 0;
                font: normal 13px/100% Verdana, Tahoma, sans-serif;
                background: #FFFFFF left top repeat-x;
                transition: 500ms all ease;
                box-shadow: rgba(0, 0, 0, 0.1) 0 0 8px;
                -moz-box-shadow: rgba(0, 0, 0, 0.1) 0 0 10px;
                -webkit-box-shadow: rgba(121, 138, 196, 0.1) 0 0 10px;
            }
            input[type="text"]:focus,select:focus{
                border: solid 1px #CCC;
                -moz-box-shadow: 0px 0px 2px 1px #C3D9FF;
                -webkit-box-shadow: 0px 0px 2px 1px #C3D9FF;
                -ms-box-shadow: 0px 0px 2px 1px #C3D9FF;
                box-shadow: 0px 0px 5px 1px #C3D9FF;
                border-radius: 10px;
            }
            textarea{
                border: solid 1px #AFCBFD;
                outline: 0;
                font: normal 13px/100% Verdana, Tahoma, sans-serif;
                background: #FFFFFF left top repeat-x;
                background: -webkit-gradient(linear, left top, left 25, from(#FFFFFF), color-stop(4%, #FFFDFD), to(#FFFFFF));
                transition: 500ms all ease;
                box-shadow: rgba(0, 0, 0, 0.1) 0 0 8px;
                -moz-box-shadow: rgba(0, 0, 0, 0.1) 0 0 10px;
                -webkit-box-shadow: rgba(121, 138, 196, 0.1) 0 0 10px;
            }
            textarea:focus{
                border: solid 1px #CCC;
                -moz-box-shadow: 0px 0px 2px 1px #C3D9FF;
                -webkit-box-shadow: 0px 0px 2px 1px #C3D9FF;
                -ms-box-shadow: 0px 0px 2px 1px #C3D9FF;
                box-shadow: 0px 0px 5px 1px #C3D9FF;
                border-radius: 10px;
            }
            .register-area{
                padding: 10px;
                border: 1px solid #CCCCCC;
                -moz-box-shadow: 0px 0px 2px 1px #C3D9FF;
                -webkit-box-shadow: 0px 0px 2px 1px #C3D9FF;
                -ms-box-shadow: 0px 0px 2px 1px #C3D9FF;
                box-shadow: 0px 0px 5px 1px #C3D9FF;
                border-radius: 10px;
            }
            .reg-heading{
                height: 30px;
                background-color: #F1F6FF;
            }
            input#submit,input#reset {
                background-color: #00A400;
                color: #FFF;
                font-weight: 600;
                padding: 10px;
                margin: 12px auto;
                border-radius: 10px;
                border: 1px solid #FFF;
                box-shadow: 1px 15px 15px 2px #D3D0D3;
                width: 101px;
            }
            input#submit:hover,input#reset:hover{
                border: 2px solid #CCC;
                cursor: pointer;

            }
            .error12{
                color: red;
                font-size: 12px;
            }
        </style>
    </head>
    <body>
        <jsp:useBean id="atc" class="com.eminent.issue.controller.ApmTeamController"></jsp:useBean>
        <jsp:useBean id="rc" class="com.eminentlabs.erm.ResumeController"></jsp:useBean>

            <FORM name="theForm" id="theForm" ONSUBMIT="return fun(this)" action="<%=request.getContextPath()%>/ERM/newAddCandidate.jsp"  onReset="return fsetFocus()" method="post" enctype="multipart/form-data">
            <table width="90%" align="center" >
                <tr>
                    <td align="right"><img src="../eminentech support files/Eminentlabs_logo.gif" alt="Eminentlabs Software Pvt Ltd"></td>
                </tr>
            </table>
            <table width="90%" align="center" class="register-area">

                <tr bgcolor="C3D9FF" style="height:25px;">
                    <td  align="center" width="90%" colspan="8"><b><font color="#006699"> <strong style="font-size: 12px;">Eminentlabs&trade; New Applicant Registration Form</strong></font></b></td>
                </tr>
                <tr  class="reg-heading"><td width="10%" colspan="8" ><div style="float:left;width: 60%;"><font size="4" color="#006699"><strong>CITIZEN CHARTER </strong></font><a href="#" title="Citizen's Charter is a document which represents a systematic effort to focus on the commitment of the Organisation towards its Citizens in respects of Standard of Services, Information, Choice and Consultation, Non-discrimination and Accessibility, Grievance Redress, Courtesy and Value for Money." ><font color="#662EE5"> [Help] </font></a></div>
                        <div id="errApj" style="float: right;text-align: right"></div>
                    </td>

                </tr>
                <tr style="height:40px;">
                    <td colspan="2" style="font-weight: 600;">Have you read the book "Governance for Growth in India" by APJ Abdul Kalam?<font size="10" color="#FF0000">**</font></td>
                    <td> <input type="radio" name="apj"  value="1" >Yes <input type="radio" name="apj" id="noApj"  value="0"> No</td><td colspan="3"><span id="errApj"></span></td>
                </tr>
                <tr class="apjblock">
                    <td colspan="5">1. How clean, safe, free drinking water can be provided to everyone in India in the next 5 - 10 years? Write your ideas & thoughts in detail [The answer has to be minimum of 200 chars]<font size="10" color="#FF0000">**</font></td>
                </tr >
                <tr class="apjblock"> <td colspan="4"><textarea name="water" id="water" wrap="physical" cols="100" rows="5" size="400" maxlength="400" class="textcounter"></textarea></td>
                    <td><input readonly type="text" class="watercounter" size="3" maxlength="4" value="400"></td>
                </tr>
                <tr class="apjblock">
                    <td colspan="5">2. Have you filed any RTI so far? If so please share details. [The answer has to be minimum of 200 chars]<font size="10" color="#FF0000">**</font></td>
                </tr>
                <tr class="apjblock"> <td colspan="4"><textarea name="rti" id="rti" wrap="physical" cols="100" rows="5" maxlength="400" class="textcounter"></textarea></td>
                    <td><input readonly type="text" class="rticounter" size="3" maxlength="4" value="400"></td>
                <tr class="apjblock">
                    <td colspan="5">3. How RTE have changed the children educational status in your native(Place of birth)? Please share details. [The answer has to be minimum of 200 chars]<font size="10" color="#FF0000">**</font></td>
                </tr>
                <tr class="apjblock"><td colspan="4"><textarea name="rte" id="rte" wrap="physical" cols="100" rows="5" maxlength="400" class="textcounter"></textarea></td>
                    <td><input readonly type="text" class="rtecounter" size="3" maxlength="4" value="400"></td>
                </tr>
                <tr class="apjblock">
                    <td colspan="5">4. How many of your family, relatives, friends smoke tobacco products or drink alcohol? What steps have you taken so far to help them overcome their habits? [The answer has to be minimum of 200 chars]<font size="10" color="#FF0000">**</font></td>
                </tr>
                <tr class="apjblock"> <td colspan="4"><textarea name="habits" id="habits" wrap="physical" cols="100" rows="5" maxlength="400" class="textcounter"></textarea></td>
                    <td><input readonly type="text" class="habitscounter" size="3" maxlength="4" value="400"></td>
                </tr>
                <tr class="apjblock">
                    <td colspan="5">5. What % of your salary and/or time you are planning to dedicate in your work life to the above social causes?<font size="10" color="#FF0000">**</font></td>
                </tr>
                <tr class="apjblock"><td colspan="4"><textarea name="social" id="social" wrap="physical" cols="100" rows="5" maxlength="400" class="textcounter"></textarea></td>
                    <td><input readonly type="text" class="socialcounter" size="3" maxlength="4" value="400"></td>
                </tr>
                <tr class="reg-heading"><td width="10%" colspan="8" ><div style="float: left;width: 70%;"><font size="4" color="#006699"><strong>USER INFORMATION</strong></font></div><div id="userDetails" style="float:right;text-align: right"></div></td></tr>
                <tr>
                    <td  width="13%"><strong>First Name<font size="10" COLOR="#FF0000">**</font></strong></td>
                    <td><input type="text" name="firstname" id="firstname" maxlength="25" size=18></td>
                    <td   width="13%"><strong>&nbsp;Last Name (Initials expanded)<font size="10" COLOR="#FF0000">**</font></strong></td>
                    <td><input type="text" name="lastname" id="lastname" maxlength="25" size=18></td>
                    <td  width="10%"><strong>Phone </strong></td>
                    <td><input type="text" name="phone" id="phone" maxlength="13" size=10></td>
                    <td  width="10%"><strong>&nbsp;Mobile<font size="10" COLOR="#FF0000">**</font></strong></td>
                    <td><input type="text" name="mobile" id="mobile" maxlength="10" size=8></td>
                </tr>
                <tr>
                    <td width="13%"><strong>Email<font size="10" COLOR="#FF0000">**</font></strong></td>
                    <td><input type="text" name="email"  id="email" maxlength="30" size=18><span class="style13"></span></td><td></td><td></td>
                    <td width="10%"><strong>Current Location <font size="10" COLOR="#FF0000">**</font></strong></td>
                    <td><input type="text" name="location" id="location" maxlength="30" size=10></td>
                    <td width="10%"><strong>&nbsp;Ref ID<font size="10" COLOR="#FF0000">**</font></strong></td>
                    <td><input type="text" id="refempid" name="refempid" maxlength="7" style="text-transform: uppercase;" size=8 onChange="javascript:callproduct();"><strong class="style20" ></strong></td>
                </tr>
                <tr>
                    <td width="18%"><strong>Resume Upload<font size="10" COLOR="#FF0000">**</font></strong></td>
                    <td width="18%"><input type="file" name="Resume" id="Resume" size="80" onchange="javascript:checkFile()"  /> 
                        <div style="color: red;">Upload only doc,docx,pdf file & max size is 12MB</div>
                    </td><td></td>

                </tr>
                <tr>
                    <td width="18%"><strong>Photo Upload<font size="10" COLOR="#FF0000">**</font></strong></td>
                    <td>  <input type='file' name="userPhoto" id="userPhoto" size="80" onchange="readURL(this);" />
                        <div style="color: red;">*Upload only gif,png,jpg,jpeg file & max size is 1MB</div>
                        <img id="previewimage" src="#" style="visibility: hidden"/>

                </tr>

                <tr class="reg-heading">
                    <td width="10%" colspan="8"><div style="float:left;width: 70%"><font size="4" color="#006699"><strong>EDUCATIONAL QUALIFICATION</strong></font></div><div id="userCourse" style="text-align: right"></div></td></tr>
                <tr>
                    <td ><strong>UG Course Name <font size="10" COLOR="#FF0000">**</font></strong></td>
                    <td colspan="2"><input type="text" name="ugcourse" id="ugcourse" maxlength="20" size=25></td>
                    <td ><strong>PG Course Name</strong></td>
                    <td colspan="2"><input type="text" name="pgcourse" id="pgcourse" maxlength="20" size=25></td>
                </tr>
                <tr>
                    <td><strong>Branch <font size="10" COLOR="#FF0000">**</font></strong></td>
                    <td colspan="2"><input type="text" name="ugbranch" id="ugbranch" maxlength="40" size=25></td>
                    <td><strong>Branch </strong></td>
                    <td colspan="2"><input type="text" name="pgbranch" id="pgbranch" maxlength="40" size=25></td>
                </tr>
                <tr>
                    <td><strong>Institute Name(in Full form)<font size="10" COLOR="#FF0000">**</font></strong></td>
                    <td colspan="2"><input type="text" name="uginstitute" id="uginstitute" maxlength="40" size=25></td>
                    <td><strong>Institute Name(in Full form)</strong></td>
                    <td colspan="2"><input type="text" name="pginstitute" id="pginstitute" maxlength="40" size=25></td>
                </tr>
                <%
                    //Calculating current year
                    Date date = new Date();
                    Calendar c = Calendar.getInstance();
                    c.setTime(date);
                    int year = c.get(c.YEAR);
                %>
                <tr>
                    <td width="13%"><strong>Graduation Year <font size="10" COLOR="#FF0000">**</font></strong></td>
                    <td colspan="2"><select name="uggraduationyear" id="uggraduationyear" size="1">
                            <option value="0" selected>Select</option>
                            <%
                                for (int i = (year - 1978); i > 0; i--) {
                            %>
                            <option value="<%= year%>"><%= year%></option>
                            <%
                                    year = year - 1;
                                }
                            %>
                        </select>
                    </td>

                    <td><strong>Graduation Year </strong></td>
                    <%
                        year = c.get(c.YEAR);
                    %>
                    <td colspan="2"><select name="pggraduationyear" id="pggraduationyear" size="1">
                            <option value="0" SELECTED>Select</option>
                            <%
                                for (int i = (year - 1978); i > 0; i--) {
                            %>
                            <option value="<%= year%>"><%= year%></option>
                            <%
                                    year = year - 1;
                                }
                            %>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td width="13%"><strong>UG Percentage <font size="10" COLOR="#FF0000">**</font></strong></td>
                    <td colspan="2"><input type="text" name="ugpercentage" id="ugpercentage" maxlength="5" size=6><strong class="style20">%</strong></td>

                    <td><strong>PG Percentage </strong></td>
                    <td colspan="2"><input type="text" name="pgpercentage" id="pgpercentage" maxlength="5" size=6><strong class="style20">%</strong></td>
                </tr>
                <tr style="height:20px;background: white;">

                </tr>
                <tr class="reg-heading"><td colspan="8"><div style="float: left;width: 70%;"<font size="4" color="#006699"><strong>SKILLS AND EXPERIENCE</strong></font></div><div id="candidateSkill"></div></td></tr>

                <tr>
                    <td><strong>SAP Experience</strong></td>
                    <td colspan="2"><input type="text" name="sapyears" id="sapyears" value="0"  maxlength="2" size=2>Yrs
                        <input type="text" name="sapmonths" id="sapmonths" value="0"  maxlength="2" size=2>Months</td>
                    <td><strong>Core Competence <font size="10" COLOR="#FF0000">**</font></strong></td>
                    <td colspan="2"><SELECT name="corecompetence" id="corecompetence" size="1">
                            <option value="XX" selected>--None--</option>
                            <% for (String core : rc.getCoreCompetence()) {%>
                            <option><%=core%></option>
                            <%}%>
                        </SELECT></td>
                </tr>
                <tr>
                    <td><strong>Total Experience </strong></td>
                    <td colspan="2">

                        <input type="text" name="totalyears" id="totalyears" value="0" maxlength="2" size=2>Yrs
                        <input type="text" name="totalmonths" id="totalmonths" value="0"maxlength="2" size=2>Months</td>
                    <td><strong>Area of Expertise<font size="10" COLOR="#FF0000">**</font></strong></td>
                    <td colspan="2"><SELECT name="areaofexpertise" id="areaofexpertise" size="1">
                            <option value="XX" selected>--None--</option>
                            <% for (ApmTeam apmTeam : atc.findAllTeams()) {%>
                            <option value="<%=apmTeam.getTeamName()%>"><%=apmTeam.getTeamName()%></option>
                            <%}%>
                        </SELECT></td>
                </tr>
                <tr>
                    <td ><strong>Programming Language </strong></td>
                    <td colspan="8">

                        <input type="checkbox" name="proglanguages" id="proglanguages" value="C">C

                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" id="proglanguages" name="proglanguages" value="C++">C++
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;<input type="checkbox" name="proglanguages" id="proglanguages" value="J2EE">J2EE
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" id="proglanguages" name="proglanguages" value="JAVA">JAVA
                        &nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" name="proglanguages" id="proglanguages" value="MS.NET">MS.NET
                        &nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" name="proglanguages" id="proglanguages" value="Python">Python
                        &nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" name="proglanguages" id="proglanguages" value="ABAP">ABAP
                        &nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" name="proglanguages" id="proglanguages" value="OOABAP">OOABAP
                        &nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" name="proglanguages" id="proglanguages" value="WEBDYNPRO">WEBDYNPRO
                    </td>
                </tr>
                <tr>
                    <td><strong>ERP Packages </strong></td>
                    <td colspan="8">
                        <input type="checkbox" name="erppackages" id="erppackages"  value="BAAN">BAAN
                        &nbsp;<input type="checkbox" name="erppackages" id="erppackages"  value="I2">I2
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" id="erppackages" name="erppackages"  value="SAP" >SAP
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" name="erppackages" id="erppackages"  value="MS AXAPTA">MS AXAPTA
                        &nbsp;<input type="checkbox" name="erppackages" id="erppackages"  value="ORACLE">ORACLE
                        <input type="checkbox" name="erppackages" id="erppackages"  value="MANUGSTICS">MANUGSTICS
                    </td>
                </tr>
                <tr>
                    <td ><strong>Operating System </strong></td>
                    <td colspan="7">
                        <input type="checkbox" name="operatingsystem" id="operatingsystem"  value="AIX">AIX
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" name="operatingsystem" id="operatingsystem"  value="HP-UX">HP-UX
                        &nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" name="operatingsystem" id="operatingsystem"  value="LINUX">LINUX
                        &nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" name="operatingsystem" id="operatingsystem"  value="MACNITOSH">MACNITOSH
                        &nbsp;<input type="checkbox" name="operatingsystem" id="operatingsystem"  value="UNIX">UNIX
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" name="operatingsystem" id="operatingsystem"  value="WINDOWS" checked>WINDOWS
                    </td>
                </tr>
                <tr>
                    <td ><strong>Database </strong></td>
                    <td colspan="7">
                        <input type="checkbox" name="database" id="database"  value="DB2">DB2
                        &nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" name="database" id="database"  value="MAX DB">MAX DB
                        &nbsp;<input type="checkbox" name="database" id="database"  value="MY SQL">MY SQL
                        &nbsp;<input type="checkbox" name="database" id="database"  value="ORACLE">ORACLE
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" name="database" id="database"  value="SQL SERVER">SQL SERVER
                    </td>
                </tr>
                <tr>
                    <td><strong>Other Tools/Languages/Certifications </strong></td>
                    <td colspan="7"><input type="text" name="tools" id="tools" maxlength="70" size="63" value="MS Office"> </td>
                </tr>
                <tr style="height:20px;background: white;">

                </tr>
                <tr class="reg-heading employerHis" style="display: none;"><td colspan="8"><div style="float: left;width: 60%"><font size="4" color="#006699"><strong>PREVIOUS EXPERIENCE</strong></font></div><div id="candidatePrevExp"></div></td></tr>
                <tr class="employerHis" style="display: none;">
                    <td><strong>Current Employer <font size="10" COLOR="#FF0000">**</font> </strong></td>
                    <td colspan="1"><input type="text" name="previousemployer1" id="previousemployer1" maxlength="100" size=20 onblur="document.getElementById('moreEmployerLink').style.display = 'block';"></td>
                    <td ><strong>CTC <font size="10" COLOR="#FF0000">**</font></strong></td>
                    <td colspan="1"><input type="text" name="ctc1" id="ctc1" maxlength="7" size=7>  <div style="">Lakhs per annum in INR</div></td>
                    <td ><strong>Joining Date <font size="10" COLOR="#FF0000">**</font></strong></td>
                    <td><input type="text" name="joiningdate1" id="joiningdate1" maxlength="10" size="8" readonly/><a href="javascript:NewCal('joiningdate1','ddmmyyyy')">
                            <img src="../images/newhelp.gif" border="0" width="16" height="16" alt="Pick a date"></a></td>
                </tr>
                <tr class="employerHis" style="display: none;">
                    <td><strong>Designation <font size="10" COLOR="#FF0000">**</font></strong></td>
                    <td><input type="text" name="designation1" id="designation1" maxlength="50" size=20></td>
                    <td ><strong>Role <font size="10" COLOR="#FF0000">**</font></strong></td>
                    <td><input type="text" name="role1" id="role1" maxlength="100" size=10></td>
                    <td ><strong>Relieving Date <font size="10" COLOR="#FF0000">**</font></strong></td>

                    <td><input type="text" name="relievingdate1" id="relievingdate1" maxlength="10" size="8" readonly/><a href="javascript:NewCal('relievingdate1','ddmmyyyy')">
                            <img src="../images/newhelp.gif"  border="0"  width="16" height="16" alt="Pick a date"></a>
                    </td>
                </tr>
                <tr class="employerHis" style="display: none;">
                    <td><strong>Job Profile </strong></td>
                    <td colspan="7"><textarea name="jobprofile1" id="jobprofile1" wrap="physical" cols="92" rows="2" ></textarea>
                    </td>
                </tr>
                <tr class="employerHis" style="display: none;">
                    <td colspan="8">
                        <div id="moreEmployer"></div>
                        <div id="moreEmployerLink" style="display:none;"><a href="javascript:addEmployerInput();">Add Employer</a></div>
                    </td>
                </tr>
                <tr style="height:20px;background: white;">

                </tr>
                <tr class="reg-heading"><td colspan="8"><div style="float: left;width: 60%"><font size="4" color="#006699"><strong>DESIRED JOB</strong></font></div><div id="desiredJob"></div></td></tr>
                <tr>
                    <td width="13%"><strong>Job Type<font size="10" COLOR="#FF0000">**</font></strong></td>
                    <td>
                        <input type="radio" name="jobtype" id="jobtype" value="C">Contract&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <input type="radio" name="jobtype" id="jobtype" value="P">Permanent&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    </td>
                    <td><strong>Position</strong></td>
                    <td><input type="text" name="position" id="position" maxlength="25" size="16"/></td>
                    <td><strong>Preferred Location<font size="10" COLOR="#FF0000">**</font></strong></td>
                    <td><input type="text" name="desiredlocation" id="desiredlocation" maxlength="30" size="20"/></td>
                </tr>
                <tr>
                    <td width="13%"><strong>Notice Period</strong></td>
                    <td>&nbsp;&nbsp;<input type="text" name=noticeperiod id=noticeperiod maxlength="3" size="10"/>Days</td>
                    <td><strong>Expected CTC<font size="10" COLOR="#FF0000">**</font></strong></td>
                    <td><input type="text" name=ectc id=ectc maxlength="5" size="5"/> <div style="">Lakhs per annum in INR</div></td>
                <tr>
                <tr style="height:20px;background: white;">

                </tr>
                <tr class="reg-heading"><td colspan="8"><div style="float:left;width: 70%; "><font size="4" color="#006699"><strong>REFERENCE</strong></font></div><div id="candidateReffrance"></div></td></tr>
                <tr>
                    <td><strong>Reference Name</strong></td>
                    <td><input type="text" name="referencename" id="referencename" maxlength="25" size="16"/></td>
                    <td><strong>Organization</strong></td>
                    <td><input type="text" name="organization"  id="organization" maxlength="100" size="16"/></td>
                    <td><strong>Employee Id</strong></td>
                    <td><input type="text" name="refemployeeid" id="refemployeeid" maxlength="5" size="16"/></td>
                </tr>

                <tr>

                    <td><strong>Designation</strong></td>
                    <td><input type="text" name="referencedesignation" id="referencedesignation" maxlength="50" size="16"/></td>
                    <td><strong>Country Code</strong></td>
                    <td><input type="text" name="refcountrycode" id="refcountrycode" maxlength="5" size="16"/></td>
                    <td><strong>STD Code</strong></td>
                    <td><input type="text" name="refstdcode" id="refstdcode" maxlength="5" size="16"/></td>
                </tr>

                <tr>
                    <td><strong>Phone #</strong></td>
                    <td><input type="text" name="refphone" id="refphone" maxlength="13" size="16"/></td>
                    <td><strong>Mobile #</strong></td>
                    <td><input type="text" name="refmobileno" id="refmobileno" maxlength="10" size="16"/></td>
                    <td><strong>eMail</strong></td>
                    <td><input type="text" name="refmailid" id="refmailid" maxlength="30" size="16"/></td>
                </tr>
                <tr style="height:20px;background: white;">

                </tr>
                <tr class="reg-heading"><td colspan="8"><div style="float: left;width: 70%;"><font size="4" color="#006699"><strong>PERSONAL DETAILS</strong></font></div><div id="candidatePerDetail"></div></td></tr>
                <tr>
                    <td><strong>Date of Birth<font size="10" COLOR="#FF0000">**</font></strong></td>
                    <td colspan="1"><input type="text" name="dateofbirth" id="dateofbirth" maxlength="10" size="16" readonly/><a href="javascript:NewCal('dateofbirth','ddmmyyyy')">
                            <img src="../images/newhelp.gif" width="16" height="16" border="0" alt="Pick a date"></a> </td>
                    <td ><strong>Gender</strong></td>
                    <td><select NAME="gender" id="gender" size="1">
                            <option value="X" selected>--Select One--</option>
                            <option value="M" >Male</option>
                            <option value="F">Female</option>
                            <option value="E">Other</option>
                        </select>
                    </td>
                    <td ><strong>Marital Status</strong></td>
                    <td><select NAME="maritalstatus" id="maritalstatus" size="1">
                            <option value="X" selected>--Select One--</option>
                            <option value="S" >Single</option>
                            <option value="M">Married</option>
                        </select>
                    </td>

                </tr>
                <tr>
                    <td><strong>DL #</strong></td>
                    <td><input type="text" name="dlno" maxlength="10" size="14"/></td>
                    <td><strong>Voter ID #</strong></td>
                    <td> <input type="text" name="voteridno" maxlength="10" size="16"/></td>
                    <td><strong>PAN Card #</strong></td>
                    <td><input type="text" name="pancardno" maxlength="10" size="14"/></td>
                    <td><strong>Passport #</strong></td>
                    <td><input type="text" name="passportno" maxlength="8" size="12"/></td>
                </tr>
                <tr>
                    <td><strong>Aadhaar #<font size="10" COLOR="#FF0000">**</font></strong></td>
                    <td> <input type="text" name="aadhaar" maxlength="12" size="16"/></td>
                
                    <td><strong>Mailing Address</strong></td>
                    <td colspan="3"><textarea name="mailingaddress" wrap="physical" cols="34" rows="2"></textarea></td>
                   </tr>
                <tr>
                    <td ><b>City</b></td>
                    <td><input type="text" name="city" maxlength="20" size="14"/></td>
                    <td><b>Pincode</b></td>
                    <td><input type="text" name="pincode" maxlength="6" size="12"/></td>

                </tr>
 <tr style="height:20px;background: white;">

                </tr>
                <tr class="reg-heading"><td colspan="8"><div style="float: left;width: 70%"><font size="4" color="#006699"><strong>PROFESSIONAL SUMMARY</strong></font></div><div id="candidateproject"></div></td></tr>
                <tr>
                    <td colspan="8"><textarea name="summarydetails" wrap="physical" cols="90" rows="5"></textarea></td>
                </tr>
                <tr style="height:20px;background: white;">

                </tr>
                <tr class="reg-heading"><td colspan="8"><font size="4" color="#006699"><strong id="projectDesc">PROJECT DETAILS: Final Year Project</strong></font></td></tr>
                <tr>
                    <td><strong>Project Name<font size="10" COLOR="#FF0000">**</font></strong></td>
                    <td><input type="text" name="projectname1" maxlength="80" size="16" onblur="document.getElementById('moreUploadsLink').style.display = 'block';" /></td>
                    <td><strong>Duration<font size="10" COLOR="#FF0000">**</font></strong></td>
                    <td><input type="text" name="duration1" maxlength="10" size="6"/>Months</td>
                    <td><strong>Team Size<font size="10" COLOR="#FF0000">**</font></strong></td>
                    <td><input type="text" name="teamsize1" maxlength="3" size="6"/></td>
                </tr>
                <tr>
                    <td><strong>Client<font size="10" COLOR="#FF0000">**</font></strong></td>
                    <td><input type="text" name="client1" maxlength="80" size="16"/></td>
                    <td><strong>Environment<font size="10" COLOR="#FF0000">**</font></strong></td>
                    <td colspan=3><input type="text" name="environment1" maxlength="80" size="30"/></td>
                </tr>

                <tr><td width="10%" colspan="2"><strong>PROJECT DESCRIPTION<font size="10" COLOR="#FF0000">**</font></strong></td></tr>

                <tr>
                    <td colspan=8>
                        <textarea name="description1" wrap="physical" cols="90" rows="5"></textarea>
                    </td>
                </tr>
                <tr><td width="10%" colspan=8><strong>ROLES & RESPONSIBILITIES<font size="10" COLOR="#FF0000">**</font></strong><input type="hidden" name="noofproject" value=1 size="30"/></td></tr>
                <tr>
                    <td colspan=6>
                        <textarea  name="roles1" cols="90" rows="5" id="roles" ></textarea>
                        <div id="moreUploads"></div>
                        <div id="moreUploadsLink" style="display:none;"><a href="javascript:addTableInput();">Add Project</a></div>
                    </td>
                </tr>
                <tr style="height:20px;background: white;">
                </tr>
                <tr>
                    <TD align=center colspan="8"><font size="4" color="#006699"><strong>By clicking Submit, I hereby declare that the details furnished above are true and correct to the best of my knowledge</strong></font></TD>
                </tr>
                <tr>
                    <TD align=center colspan="8"><INPUT  type="submit" id="submit" value="Submit" name="submit"  >
                        <INPUT  type="reset" id="reset" value=" Reset "></TD>
                </tr>
                <tr style="height: 50px;"></tr>
            </table>
        </FORM>

        <script type="text/javascript">
            $('.textcounter').bind('copy paste cut', function (e) {
                e.preventDefault(); //disable cut,copy,paste
            })
            $('.textcounter').keypress(function (e) {
                var regex = new RegExp("^[a-zA-Z0-9%,. ]+$");
                var str = String.fromCharCode(!e.charCode ? e.which : e.charCode);
                if (regex.test(str)) {
                    return true;
                }

                e.preventDefault();
                return false;
            });
            $(document).on('keypress onchange keyup keydown', '.textcounter', function (e) {
                var maxLength = 400;
                var vala = $(this);
                var val = $(this).val();
                val = $.trim(val);
                var texter = $(this).attr("name") + "counter";
                if (val.length > maxLength) {
                    vala.val(val.substring(0, maxLength));
                } else {
                    $("." + texter).val(400 - val.length);
                }
            });

            $(document).on('change', '#email', function (e) {
                var email = $('#email').val();
                var validemail = isEmailValid(email);
                if (validemail) {
                    $.ajax({
                        url: '<%=request.getContextPath()%>/ERM/alreadyExistEmail.jsp',
                        data: {email: email, random: Math.random(1, 10)},
                        async: false,
                        type: 'GET',
                        success: function (responseText, statusTxt, xhr) {
                            if (statusTxt === "success") {
                                var result = $.trim(responseText);
                                if (result == "true") {
                                    $('.erroruser').remove();
                                    $("<span class='error12 erroruser'>email id is already exits</span>").insertAfter("#userDetails");
                                    $('#email').val('');
                                    $('#email').focus();
                                } else {
                                    $('.erroruser').remove();
                                }

                            }
                        }
                    });
                } else {
                    $('.erroruser').remove();
                    $("<span class='error12 erroruser'>Invalid E-mail Address! Please re-enter.</span>").insertAfter("#userDetails");
                }
            });



            function isEmailValid(email)
            {
                if (!(/^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/.test(email)))
                {
                    return false;
                } else {
                    return true;
                }

            }

            function checkFile()
            {
                $('.errorResume').remove();
                var fi = document.getElementById('Resume');

                var ext = $('#Resume').val().split('.').pop().toLowerCase();
                if ($.inArray(ext, ['doc', 'docx', 'pdf']) == -1) {
                    $("<span class='error12 errorResume'>Upload only doc,docx,pdf format file</span>").insertAfter("#Resume");
                    document.getElementById("Resume").value = "";
                    theForm.Resume.focus();
                    return false;
                } else {
                    $('.errorResume').remove();
                    $(this).css({"border-color": ""});
                }
                var fsize;
                if ($.browser.msie) {
                    if ($.browser.version <= 9) {
                        fsize = document.getElementById('Resume').size;

                    }
                } else {
                    fsize = fi.files.item(0).size; // THE SIZE OF THE FILE.
                }
                if (fsize > 12582912) {
                    $("<span class='error12 erroruser'>Maximum 12 MB Size allowed</span>").insertAfter("#Resume");
                    document.getElementById("Resume").value = "";
                    document.theForm.Resume.focus();
                    return false;
                } else {

                    $('.erroruser').remove();
                    $('#Resume').css({"border-color": ""});

                    return true;
                }
            }
            function checkpic(input)
            {
                $('.errorPhoto').remove();
                var fi = document.getElementById('userPhoto');
                var ext = $('#userPhoto').val().split('.').pop().toLowerCase();
                if ($.inArray(ext, ['jpeg', 'jpg', 'png', 'gif']) == -1) {
                    $("<span class='error12 errorPhoto'>Upload only gif,png,jpg,jpeg format file</span>").insertAfter("#userPhoto");
                    document.theForm.userPhoto.focus();
                    document.getElementById("userPhoto").value = "";
                    return false;
                } else {
                    $('.errorPhoto').remove();
                }
                var fsize;
                if ($.browser.msie) {
                    if ($.browser.version <= 9) {
                        fsize = document.getElementById('userPhoto').size;
                        //  alert("bytes are" + fsize);
                    }
                } else {
                    fsize = fi.files.item(0).size;
                }
                if (fsize > 1048576) {
                    $("<span class='error12 erroruser'>Maximum 1 MB Size allowed</span>").insertAfter("#userPhoto");
                    document.getElementById("userPhoto").value = "";
                    theForm.userPhoto.focus();
                    return false;
                } else {
                    $('.erroruser').remove();

                    $("#userPhoto").css({"border-color": ""});
                    return true;
                }
            }

            function readURL(input) {
                var flag = checkpic();
                if (flag == true) {
                    if ($.browser.msie) {
                        if ($.browser.version <= 9) {
                        }
                    } else {
                        var img = document.getElementById('previewimage');
                        img.style.visibility = 'visible';
                        if (input.files && input.files[0]) {
                            var reader = new FileReader();
                            reader.onload = function (e) {
                                $('#previewimage')
                                        .attr('src', e.target.result)
                                        .width(125)
                                        .height(125);
                            };
                            reader.readAsDataURL(input.files[0]);
                        }
                    }
                }
            }
            $(document).on('change', '#totalyears,#totalmonths', function (e) {
                var totalyears = parseInt($('#totalyears').val());
                var totalmonths = parseInt($('#totalmonths').val());
                var totalEx = (totalyears * 12) + totalmonths;
                if (totalEx > 0) {
                    $('#projectDesc').html("PROJECT DETAILS: Current Project");
                    $('.employerHis').show();
                } else {
                    $('#projectDesc').html("PROJECT DETAILS: Final Year Project");
                    $('.employerHis').hide();
                }
            });
        </script>
    </body>
</html>

<%-- 
    Document   : viewAplicantDetails
    Created on : Feb 28, 2014, 12:06:42 PM
    Author     : E0288
--%>

<%@page import="org.apache.log4j.PropertyConfigurator"%>
<%@page import="org.apache.log4j.Logger"%>
<%@page import="java.util.Map"%>
<%@page import="com.eminentlabs.erm.ERMUtil"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
    <%

        Logger logger = Logger.getLogger("viewAplicantDetails");

        String logoutcheck = (String) session.getAttribute("Name");
        if (logoutcheck == null) {
            logger.fatal("================Session expired===================");
    %>
    <jsp:forward page="../SessionExpired.jsp"></jsp:forward>
    <%
        }
    %>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <TITLE>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS
        Solution</TITLE>
    <LINK title=STYLE
          href="<%= request.getContextPath()%>/eminentech support files/main_ie.css"
          type="text/css" rel=STYLESHEET>
    <script type="text/javascript" src="<%= request.getContextPath()%>/ckeditor_4.5.9_standard/ckeditor/ckeditor.js"></script>
    <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/checkSubmit.js"></script>
    <script src="<%=request.getContextPath()%>/javaScript/XMLHttpRequest.js" type="text/javascript"></script>
    <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/ERMFileAttach.js?test=070220181628"></script>          
    <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/checkSubmit.js"></script>


    <script type="text/javascript">
        function trim(str) {
            while (str.charAt(str.length - 1) === " ")
                str = str.substring(0, str.length - 1);
            while (str.charAt(0) === " ")
                str = str.substring(1, str.length);
            return str;
        }
        function editorTextCounter(field, cntfield, maxlimit)
        {
            if (field > maxlimit)
            {

                if (maxlimit === 2000)
                    alert('Comments size is exceeding 2000 characters');
                else
                    alert('Comments size is exceeding 2000 characters');
            }
            else
                cntfield.value = maxlimit - field;
        }
        function fun()
        {
            if (trim(CKEDITOR.instances.comments.getData()) === "")
            {
                alert("Please Enter the Comments");
                CKEDITOR.instances.comments.focus();
                return false;
            }
            if (CKEDITOR.instances.comments.getData().length > 2000)
            {
                alert(" Comments exceeds 2000 character");
                CKEDITOR.instances.comments.focus();
                //        document.theForm.description.value == "";
                return false;
            }
            disableSubmit();
        }
    </script>
</head>
<body>
    <%@ include file="/header.jsp"%>
    <jsp:useBean id="av" class="com.eminentlabs.erm.ApplicantView"></jsp:useBean>
    <%
        av.viewApplicant(request);
    %>
    
    <table cellpadding="0" cellspacing="0" width="100%">
        <tr border="2" bgcolor="#C3D9FF">
            <td align="left""><font size="4" COLOR="#0000FF"><b>
                    Applicant Details </b></font><FONT SIZE="3" COLOR="#0000FF"> </FONT></td>
             <td align="right"><font size="4" COLOR="#0000FF"><b>
                     <a href="<%= request.getContextPath()%>/ERM/viewApplicant.jsp?apid=<%=av.getApplicantId()%>" target="_blank">Print this applicant</a> </b></font><FONT SIZE="3" COLOR="#0000FF"> </FONT></td>

        </tr>
    </table>
    <br>
    
    <table align="center" width="100%" bgcolor="C3D9FF">
        <tr>
            <td><font size="4" COLOR="#0000FF"><b>Applicant Id</b> <b><%= av.getApplicantId()%></b></font></td>
        </tr>
    </table>
    <table width="100%" bgcolor="E8EEF7">
        <tr height="21">
            <td align="left" width="100%"><b><font color="#0000FF">CITIZEN CHARTER</font></b></td>
        </tr>
    </table>
    <table width="100%" bgcolor="E8EEF7">
        <tr height="21">
            <td width="40%"><B>Have you read the book "Governance for Growth in India" by APJ Abdul Kalam?</B></td><td colspan="2"><%=av.getApj()%></td>
        </tr>
        <tr height="21">
            <td width="40%"><B>1. How clean, safe, free drinking water can be provided to everyone in India by 2020? Write in detail. </B></td>
        </tr>
        <tr>
            <td colspan="2"><%= av.getWater()%></td>
        </tr>
        <tr>
            <td width="40%"><B>2. Have you filed any RTI so far ? If so please share details. </B></td>
        </tr>
        <tr>
            <td colspan="2"><%=av.getRti()%></td>
        </tr>
        <tr>
            <td width="40%"><B>3. How RTE have changed the children educational status in your native or place of birth ? </B></td>
        </tr>
        <tr>
            <td colspan="2"><%= av.getRte()%></td>
        </tr>

        <tr height="21">
            <td width="40%"><B>4. How many of your family, relatives, friends smoke tobacco products or drink alcohol ? What steps have you taken so far to help them overcome their habits? </B></td>
        </tr>
        <tr>
            <td colspan="2"><%= av.getHabits()%></td>
        </tr>
        <tr>
            <td width="40%"><B>5. What % of your salary you are planning to dedicate in your work life to the above social cause ? </B></td>
        </tr>
        <tr>
            <td colspan="2"><%= av.getSocial()%></td>
        </tr>
    </table>
    <table width="100%" bgcolor="E8EEF7">
        <tr height="21">
            <td align="left" width="100%"><b><font color="#0000FF">User
                    Information </font></b></td>
        </tr>
    </table>
    <table width="100%" bgcolor="E8EEF7">
        <tr height="21">
            <td width="10%"><B>Name </B></td>

            <td width="20%" id="imagePopup" name="imagePopup" onclick="showImage('<%=request.getContextPath()%>/Etracker_AttachedFiles/userPhotos/<%=av.getPhotoFile()%>', '<%=av.getName()%>', '<%=av.getApplicantId()%>');">
                <%=av.getName()%></td>		


            <td width="15%"><B>Phone </B></td>
            <td width="20%"><%=av.getPhone()%></td>
            <td width="15%"><B>Mobile </B></td>
            <td width="30%"><%= av.getMobile()%></td>
        </tr>

        <tr height="21">
            <td width="10%"><B>Mail </B></td>

            <td width="20%"><%= av.getMail()%></td>
            <td width="15%"><B>Current Location </B></td>
            <td width="20%"><%= av.getLocation()%></td>
            <td width="15%"><B>Referred By </B></td>
            <td width="30%"><%=av.getRefBy()%></td>
        </tr>
        <tr height="21">
            <td width="10%"><b>Files Attached<img  id="fileUpload" title="Upload Document" src="/eTracker/images/attachment.png" style="height: 20px;width:  20px;cursor: pointer;vertical-align: middle; " onclick="showFileAttach()"></img> </b></td>
                    <%if (av.getFileCount() > 0) {%>

            <td id="filesIssue"> <A	onclick="viewFileAttachForApplicant('<%=av.getApplicantId()%>');" href="#"
                                    >ViewFiles(<%=av.getFileCount()%>)</A></td>

            <%
            } else {
            %>
            <td id="filesIssue" ><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000">No Files</font></td>
                <%
                    }
                %>
           
        </tr>
    </table>
    <table width="100%" bgcolor="E8EEF7">
        <tr height="21">
            <td align="left" width="100%"><B><font color="#0000FF">Educational
                    Details </font></B></td>
        </tr>
    </table>
    <table width="100%" bgcolor="E8EEF7">
        <tr height="21">
            <td width="10%"><B>UG Degree </B></td>
            <td width="20%"><%= av.getUg()%></td>
            <td width="15%"><B>UG Branch </B></td>
            <td width="20%"><%= av.getUgBranch()%></td>
            <td width="15%"><B>UG Institute</B></td>
            <td width="30%"><%= av.getUgInstitue()%></td>
        </tr>
        <tr height="21">
            <td width="10%"><B>UG Year </B></td>
            <td width="20%"><%= av.getUgYear()%></td>
            <td width="15%"><B>UG Percentage </B></td>
            <td width="20%"><%= av.getUgPer()%></td>
        </tr>
        <%if (av.getPg() != "") {%>
        <tr height="21">
            <td width="10%"><B>PG Degree </B></td>
            <td width="20%"><%= av.getPg()%></td>
            <td width="15%"><B>PG Branch </B></td>
            <td width="20%"><%= av.getPgBranch()%></td>
            <td width="15%"><B>PG Institute</B></td>
            <td width="30%"><%= av.getPgInstitue()%></td>
        </tr>

        <tr height="21">
            <td width="10%"><B>PG Year </B></td>
            <td width="20%"><%= av.getPgYear()%></td>
            <td width="15%"><B>PG Percentage </B></td>
            <td width="20%"><%= av.getPgPer()%></td>
        </tr>
        <%}%>
    </table>
    <table width="100%" bgcolor="E8EEF7">
        <tr height="21">
            <td align="left" width="100%"><B><font color="#0000FF">Skills
                    and Experience</font></B></td>
        </tr>
    </table>
    <table width="100%" bgcolor="E8EEF7">
        <tr height="21">
            <td width="10%"><B>SAP Exp </B></td>
            <td width="20%"><%=av.getSapExp()%></td>
            <td width="15%"><B>Functional Area </B></td>

            <td width="20%"><%= av.getFunctionalArea()%></td>
            <td width="15%"><B>Total Experience </B></td>

            <td width="30%"><%=av.getTotalExp()%>
            </td>
        </tr>

        <tr height="21">
            <td width="10%"><B>Expertise </B></td>
            <td width="20%"><%= av.getExpertise()%></td>
            <td width="15%"><B>Languages </B></td>

            <td width="20%"><font
                    face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= av.getLanguages()%></font></td>

            <td width="15%"><B>ERP Packages </B></td>
            <td width="30%"><font
                    face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= av.getErpPackages()%></font></td>

        </tr>
        <tr height="21">

            <td width="10%"><B>OS </B></td>

            <td width="20%"><font
                    face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= av.getOs()%></font></td>


            <td width="15%"><B>Database </B></td>

            <td width="20%"><font
                    face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= av.getDataBase()%></font></td>

            <td width="15%"><B>Tools & Utilities </B></td>

            <td width="30%"><font
                    face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= av.getToolsAndUtil()%></font></td>

    </table>
    <table width="100%" bgcolor="E8EEF7">
        <tr height="21">
            <td align="left" width="100%"><B><font color="#0000FF">Previous
                    Experience</font></B></td>
        </tr>
    </table>
    <table width="100%" bgcolor="E8EEF7">
        <tr height="21">

            <td width="10%"><B>Prev Employer </B></td>

            <td width="20%"><%= av.getPrevEmployer()%></td>
            <td width="10%"><B>Prev Designation </B></td>
            <td width="20%"><%= av.getPrevDesignation()%></td>
            <td width="15%"><B>Prev CTC </B></td>
            <td width="20%"><%= av.getPrevCtc()%> &nbsp; LPA in INR</td>
        </tr>
        <tr height="21">
            <td width="10%"><B>Prev. Join Date </B></td>
            <td width="20%"><%= av.getPrevJoinDate()%></td>
            <td width="15%"><B>Prev Relieving Date </B></td>
            <td width="20%"><%= av.getPrevRelDate()%></td>
            <td width="15%"><B>Prev Role </B></td>
            <td width="20%"><%= av.getPrevRole()%></td>

        </tr>

        <tr height="21">
            <td width="10%"><B>Job Profile </B></td>
            <td width="30%" colspan="5"><%= av.getJobProfile()%></td>
        </tr>
    </table>
    <table width="100%" bgcolor="E8EEF7">
        <tr height="21">
            <td align="left" width="100%"><B><font color="#0000FF">Desired
                    Job</font></B></td>
        </tr>
    </table>
    <table width="100%" bgcolor="E8EEF7">
        <tr height="21">
            <td width="10%"><B>Job Type </B></td>

            <td width="20%"><%= av.getJobType()%></td>
            <td width="15%"><B>Desired Position</B></td>
            <td width="20%"><%= av.getDesiredPosition()%></td>
            <td width="15%"><B>Desired Location </B></td>
            <td width="30%"><%= av.getDesiredLocation()%></td>
        </tr>

    </table>

    <form action="updateApplicant.jsp" method="post" onSubmit='return fun(this)'>
        <table width="100%" border="0" id="testcasesavailable" bgcolor="#E8EEF7" cellspacing="2" cellpadding="2" align="center">
            <tr>
                <td>
                    <input type="hidden" name="name" value="<%=av.getName()%>">
                    <input type="hidden" name="location" value="<%=av.getLocation()%>">
                    <input type="hidden" name="grd" value="<%=av.getUg()%>">
                    <input type="hidden" name="gradyear" value="<%=av.getUgYear()%>">
                    <input type="hidden" name="percentage" value="<%=av.getUgPer()%>">
                    <input type="hidden" name="areaofexpertise" value="<%=av.getAreaOfExpertise()%>">
                    <input type="hidden" name="sapyears" value="<%=av.getSapExpyr()%>">
                    <input type="hidden" name="sapmonths" value="<%=av.getSapExpMo()%>">
                    <input type="hidden" name="totalyears" value="<%=av.getTotExpyr()%>">
                    <input type="hidden" name="totalmonths" value="<%=av.getTotExpMo()%>">



                </td>
            </tr>
            <tr style="height:30px;">
                <td width="10%"><B>Fake?</B></td>
            <td  width="20%"> 
                <input type="radio" name="isfake"  value="1" <%if (av.getIsFake() == 1) {%> checked<%}%>>Yes</input> <input type="radio" name="isfake" id="isfake"  value="0" <%if (av.getIsFake() == 0) {%> checked<%}%>> No</input>
            </td>
            <td width="15%" style="text-align: left"><b>Status</b></td>
                <td width="20%" >
                    <select id="statusid" name="statusid">

                        <option value="10" selected="">All Information</option>

                        <% for (Map.Entry<Integer, String> entry : av.getStatuses().entrySet()) {
                                if (av.getStatus() != 10) {
                                    if (av.getStatus().equals(entry.getKey())) {%>
                        <option value="<%=entry.getKey()%>" selected><%=entry.getValue()%></option>
                        <%} else {%>
                        <option value="<%=entry.getKey()%>"><%=entry.getValue()%></option>
                        <%}
                        } else {
                        %>
                        <option value="<%=entry.getKey()%>"><%=entry.getValue()%></option>
                        <%}
                            }%>

                    </select>
                </td>               
                <td width="15%" style="text-align: left"><b>Assigned To</b></td>

                <td  align="left">
                    <select id="assignedto" name="assignedto">
                        <%
                            for (Map.Entry<Integer, String> entry : av.getEminentUsers().entrySet()) {
                                if (av.getAssignedTo() != 0) {
                                    if (av.getAssignedTo().equals(entry.getKey())) {%>
                        <option value="<%=entry.getKey()%>" selected><%=entry.getValue()%></option>
                        <%} else {%>
                        <option value="<%=entry.getKey()%>"><%=entry.getValue()%></option>
                        <%}
                        } else {%>
                        <option value="<%=entry.getKey()%>"><%=entry.getValue()%></option>
                        <% }
                            }
                        %>
                    </select>

                </td>

            </tr>            
            <tr>
                <td width="10%" align="left">
                    <b>Comments</b>
                </td>


                <td style="width:700px;" colspan="3">
                    <textarea
                        rows="3" cols="68" name="comments" id="comments" maxlength="2000"
                        onKeyDown="textCounter(document.getElementById('comments'), document.getElementById('remLen1'), 2000)"
                        onKeyUp="textCounter(document.getElementById('comments'), document.getElementById('remLen1'), 2000)"></textarea>

                    <script type="text/javascript">
                        CKEDITOR.replace('comments', {toolbar: 'Basic', height: 100});
                        var editor_data = CKEDITOR.instances.comments.getData();
                        CKEDITOR.instances["comments"].on("instanceReady", function ()
                        {

                            //set keyup event
                            this.document.on("keyup", updateExpectedResult);
                            //and paste event
                            this.document.on("paste", updateExpectedResult);

                        });
                        function updateExpectedResult()
                        {
                            CKEDITOR.tools.setTimeout(function ()
                            {
                                var desc = CKEDITOR.instances.comments.getData();
                                var leng = desc.length;
                                editorTextCounter(leng, document.getElementById('remLen1'), 2000);

                            }, 0);
                        }
                    </script>
                </td><td>
                    <input readonly type="text" name="remLen1" id="remLen1" size="3" maxlength="4" value="2000">
                </td>
            </tr>
            <tr>
                <td colspan="6" align="center"><input type="submit" id="submit" value="Update"><input type="hidden" name="applicantId" id="applicantId" value="<%=av.getApplicantId()%>"></td>
            </tr>
        </table>
    </form>
    <div id="overlay"></div>
    <div id="imagePopups" class="popup" >
        <div class="popupHeading"  id="nameofEmp" style="font-weight: bold" style="font-size: 18" align="center" ><b>Name</b></div>
        <div>
            <table id="imagetable">
                <tr>
                    <td>
                        <img  name="userImage" id='userImage' alt="Image not found" src="#" style="visibility: hidden" width="250px" height="250px" onerror="this.src='<%=request.getContextPath()%>/images/avator1.png';"/>
                    </td>
                </tr>
                <tr>
                    <td colspan="3" align="right">
                        <button class="custom-popup-close" onclick="javascript:closePopup();" type="button">close</button>
                    </td>
                </tr>
            </table>
        </div>
    </div>

    <iframe src="${pageContext.request.contextPath}/admin/candidate/screeningComments.jsp?appId=<%=av.getApplicantId()%>" scrolling="auto" frameborder="2" height="20%" width="100%"></iframe>


    <div class="refissuepopupa chartarea" style="display: none;">
        <img src="<%=request.getContextPath()%>/images/file-progress.gif" style="margin:5% 20% auto;"/>
        <div>

        </div>
    </div>
    <div id="MDAVpopup" class="popup">
        <h3 class="popupHeading">View Attached Files</h3>
        <div>
            <div class="clear"></div>
            <div class="tableshow">
                <div id="IssuePopupFiles">

                </div>
                <button class="custom-popup-close" onclick="closeIssuePopup();" type="button">close</button>

            </div>
        </div>
    </div>
    <div id="MDApopup" class="popup" style="height: 200px;">
        <form id="file-mod-form" name="file-mod-form" enctype="multipart/form-data"  method="POST" action="<%=request.getContextPath()%>/ERMFileAttachCandidateIE.jsp" onsubmit="return validate(this);">
            <h3 class="popupHeadinga">Upload document for <%=av.getApplicantId()%></h3>
            <div style="color:red;display: none;" id="mdaterrormsg"></div>
            <div style="margin-bottom: 10px;">
                <table >
                    <tr>
                        <td><label style="margin-left: 0px;">Choose File(s) to upload</label></td>
                        <td >
                            <label for="pswd"><input type="file" id="file-mod-select" name="photos[]" multiple/></label> 
                        </td>
                    </tr>
                    <tr style="height:40px;">
                        <td>
                            <%
                                String requestURL = request.getServletPath() + "?" + request.getQueryString();
                            %>
                            <input type="hidden" name="applicantId" id='applicantId' value="<%=av.getApplicantId()%>"/>
                            <input type="hidden" name="url" id='url' value="<%=requestURL%>"/>
                            <input type="submit" id="upload" value="Upload"/>
                            <input type="button" id="mod-upload-button" value="Upload Document" onclick="javascript:uploadFileAttach();"/>
                            <input type="button" id="mod-upload-cancel"value="Cancel" onclick="javascript:cloFileAttach();"/>
                        </td>
                        <td></td>
                    </tr>
                    <tr>
                        <td align="center"><img id="progressbar" style='display: none;' src='/eTracker/images/file-progress.gif'/></td>
                    </tr>
                </table>
            </div>
        </form>
        <div id="msgForIE">
            <p style="color: red;">This page will refresh after uploading file.So Please type the comments or changes after uploading.For better performance use other browsers.. </p>
        </div>
    </div>
</body>
<script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script> 
<script src="https://code.jquery.com/jquery-1.9.0.js"></script>
<script type="text/javascript">
                                $('#imagePopup').hover(function () {
                                    $(this).css("color", "blue");
                                });

                                $('#imagePopup').mouseout(function () {
                                    $(this).css("color", "");
                                });
                                function showImage(src, name, applicantId) {
                                    // console.log("src name is:" + src);
                                    $('#overlay').fadeIn('fast', 'swing');
                                    $("#imagePopups").width(254).height(266);
                                    document.getElementById('nameofEmp').innerHTML = applicantId + ":" + name;
                                    $('#imagePopups').fadeIn('fast', 'swing');
                                    var img = document.getElementById('userImage');
                                    img.style.visibility = 'visible';
                                    document.getElementById('userImage').src = src;
                                }
                                function closePopup() {
                                    $('#overlay').fadeOut('fast', 'swing');
                                    $('#imagePopups').fadeOut('fast', 'swing');

                                }

                                $(document).ready(function () {
                                    var message = $('#message').val();

                                    var ua = window.navigator.userAgent;

                                    var msie = ua.indexOf('MSIE ');
                                    var trident = ua.indexOf('Trident/');
                                    var edge = ua.indexOf('Edge/');

                                    if (msie > 0 || trident > 0 || edge > 0) {
                                        $('#mod-upload-button').hide();
                                        if (message === null || message === 'null') {

                                        } else {
                                            alert(message);
                                        }
                                    } else {
                                        $('#upload').hide();
                                        $('#msgForIE').hide();
                                    }
                                });

                                function validate() {
                                    if (document.getElementById("file-mod-select").value == '') {
                                        document.getElementById('mdaterrormsg').style.display = 'block';
                                        document.getElementById('mdaterrormsg').innerHTML = "Please select the file";
                                        return false;
                                    } else {
                                        var count = 1, abort = true;
                                        var allowed_extensions = new Array("docm", "dotm", "dotx", "potm", "potx", "ppam", "ppsm", "ppsx", "pptm", "pptx", "xlam", "xlsb", "xlsm", "xltm", "xltx", "xps", "xls", "xlsx", "xlsm", "doc", "docx", "bmp", "jpg", "jpeg", "gif", "png", "bmp", "pdf", "txt", "mht", "zip", "rar", "htm", "ppt", "pptx", "tif", "chm", "rtf", "html", "pps", "sql", "war", "uml", "xps", "xml", "avi", "idc", "msg", "csv");
                                        var ua = window.navigator.userAgent;
                                        var msie = ua.indexOf('MSIE ');
                                        var trident = ua.indexOf('Trident/');
                                        var edge = ua.indexOf('Edge/');
                                        if (msie > 0 || trident > 0 || edge > 0) {
                                            var fileName = document.getElementById('file-mod-select').value;
                                            var file_extension = fileName.split('.').pop(); // split function will split the filename by dot(.), and pop function will pop the last element from the array which will give you the extension as well. If there will be no extension then it will return the filename.                              
                                            for (var i = 0; i <= allowed_extensions.length; i++)
                                            {
                                                if (allowed_extensions[i] == file_extension)
                                                {
                                                    count = 0;
                                                }
                                            }
                                            if (count == 0) {
                                                $('#progressbar').fadeIn('slow');
                                                document.getElementById('upload').value = "Processing";
                                                document.getElementById('upload').disabled = true;
                                                document.getElementById('mod-upload-cancel').value = "Processing";
                                                document.getElementById('mod-upload-cancel').disabled = true;
                                            } else {
                                                return false;
                                            }
                                        }

                                    }
                                }
                                $('#file-mod-select').bind('change', function () {
                                    $('#progressbar').fadeIn('slow');
                                    var fileModSelect = document.getElementById('file-mod-select');
                                    document.getElementById('mdaterrormsg').innerHTML = "";
                                    var files = fileModSelect.files;
                                    var count = 1, abort = true;
                                    var allowed_extensions = new Array("docm", "dotm", "dotx", "potm", "potx", "ppam", "ppsm", "ppsx", "pptm", "pptx", "xlam", "xlsb", "xlsm", "xltm", "xltx", "xps", "xls", "xlsx", "xlsm", "doc", "docx", "bmp", "jpg", "jpeg", "gif", "png", "bmp", "pdf", "txt", "mht", "zip", "rar", "htm", "ppt", "pptx", "tif", "chm", "rtf", "html", "pps", "sql", "war", "uml", "xps", "xml", "avi", "idc", "msg", "csv");
                                    var ua = window.navigator.userAgent;
                                    var msie = ua.indexOf('MSIE ');
                                    var trident = ua.indexOf('Trident/');
                                    var edge = ua.indexOf('Edge/');
                                    if (msie > 0 || trident > 0 || edge > 0) {
                                        var fileName = document.getElementById('file-mod-select').value;
                                        var file_extension = fileName.split('.').pop(); // split function will split the filename by dot(.), and pop function will pop the last element from the array which will give you the extension as well. If there will be no extension then it will return the filename.                              
                                        for (var i = 0; i <= allowed_extensions.length; i++)
                                        {
                                            if (allowed_extensions[i] == file_extension)
                                            {
                                                count = 0;
                                            }
                                        }
                                    } else {
                                        for (var i = 0; i < files.length && abort; i++)
                                        {
                                            var fileName = files[i].name;
                                            var file_extension = fileName.split('.').pop().toLowerCase();
                                            for (var j = 0; j < allowed_extensions.length; j++)
                                            {
                                                if (allowed_extensions[j] == file_extension)
                                                {
                                                    abort = true
                                                    count = 0;
                                                    break;
                                                } else {
                                                    count = 1;
                                                    abort = false;
                                                }
                                            }
                                        }

                                    }
                                    if (count == 0) {
                                    } else {
                                        document.getElementById('file-mod-select').value = '';
                                        document.getElementById('mdaterrormsg').style.display = 'block';
                                        document.getElementById('mdaterrormsg').innerHTML = "You must upload a file with one of the following extensions: " + allowed_extensions.join(', ') + ".'";
                                    }
                                    $('#progressbar').fadeOut('slow');
                                });

</script>
</html>

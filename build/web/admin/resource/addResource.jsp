<%@page import="com.eminent.resource.ResourceUtil"%>
<%@ page language="java" contentType="text/html"
         pageEncoding="UTF-8"%>
<%@ page
    import="com.eminent.util.*,java.util.List,java.util.Iterator,java.util.*"%>
    <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
    <%@page import="java.util.List,org.apache.log4j.*"%>
    <%
        response.setHeader("Cache-Control", "no-cache");
        response.setHeader("Cache-Control", "no-store");
        response.setDateHeader("Expires", 0);
        response.setHeader("Pragma", "no-cache");
        //Configuring log4j properties
        Logger logger = Logger.getLogger("Add Resources");

        String logoutcheck = (String) session.getAttribute("Name");
        if (logoutcheck == null) {
            logger.fatal("================Session expired===================");
    %>
    <jsp:forward page="../SessionExpired.jsp"></jsp:forward>
    <%
        }

    %>
    <html>
        <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
            <meta http-equiv="Content-Type" content="text/html ">
            <title>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS
                Solution</title>
            <LINK title=STYLE
                  href="<%= request.getContextPath()%>/eminentech support files/main_ie.css"
                  type=text/css rel=STYLESHEET>
            <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/checkSubmit.js"></script>
            <script src="<%=request.getContextPath()%>/javaScript/jquery.js" type="text/javascript"></script>
            <script src="<%=request.getContextPath()%>/javaScript/XMLHttpRequest.js" type="text/javascript"></script>
            <script language="JavaScript">

<!--

                /** Java Script Function For Trimming A String To Get Only The Required String Input */

                function trim(str) {
                    while (str.charAt(str.length - 1) == " ")
                        str = str.substring(0, str.length - 1);
                    while (str.charAt(0) == " ")
                        str = str.substring(1, str.length);
                    return str;
                }

                /** Function To Check Whether There Is Any Integer Present In The Form Input From The User */

                function isAlphaNumeric(str) {
                    var pattern = "abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890."
                    var i = 0;
                    do {
                        var pos = 0;
                        for (var j = 0; j < pattern.length; j++)
                            if (str.charAt(i) == pattern.charAt(j)) {
                                pos = 1;
                                break;
                            }
                        i++;
                    }
                    while (pos == 1 && i < str.length)
                    if (pos == 0)
                        return false;
                    return true;
                }
                function isIP(str) {
                    var pattern = "1234567890."
                    var i = 0;
                    do {
                        var pos = 0;
                        for (var j = 0; j < pattern.length; j++)
                            if (str.charAt(i) == pattern.charAt(j)) {
                                pos = 1;
                                break;
                            }
                        i++;
                    }
                    while (pos == 1 && i < str.length)
                    if (pos == 0)
                        return false;
                    return true;
                }
                function isMAC(str) {
                    var pattern = "abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890.-:";
                  
                    var i = 0;
                    do {
                        var pos = 0;
                        for (var j = 0; j < pattern.length; j++)
                          
                        if (str.charAt(i) === pattern.charAt(j)) {
                           
                            pos = 1;
                            break;
                        }
                        i++;
                    }
                    while (pos === 1 && i < str.length)
                   
                    if (pos === 0)
                        return false;
                    return true;
                }

                function fun(theForm) {

                    /** This Loop Checks Whether There Is Any Input Data Present In The First Name Info Field */

                    if ((theForm.ip.value) == '') {
                        alert('Please enter the MAC Adress ');
                        document.theForm.ip.value = "";
                        theForm.ip.focus();
                        return false;
                    }
                    if (isMAC(trim(theForm.ip.value)) == '') {
                        alert('Please enter the valid MAC Adress ');
                        document.theForm.ip.value = "";
                        theForm.ip.focus();
                        return false;
                    }
                    if ((theForm.machinename.value) == '') {
                        alert('Please enter the Machine Name ');
                        document.theForm.machinename.value = "";
                        theForm.machinename.focus();
                        return false;
                    }
                    if (isAlphaNumeric(trim(theForm.machinename.value)) == '') {
                        alert('Please enter the valid Machine Name ');
                        document.theForm.machinename.value = "";
                        theForm.machinename.focus();
                        return false;
                    }
                    if (document.theForm.user.value == "--Select One--")
                    {
                        alert("Please select the User");
                        document.theForm.user.focus();
                        return false;
                    }
                    if ((theForm.cpu.value) == '') {
                        alert('Please enter the CPU Details ');
                        document.theForm.cpu.value = "";
                        theForm.cpu.focus();
                        return false;
                    }
                    if (isAlphaNumeric(trim(theForm.cpu.value)) == '') {
                        alert('Please enter the valid CPU Details ');
                        document.theForm.cpu.value = "";
                        theForm.cpu.focus();
                        return false;
                    }
                    if ((theForm.ram.value) == '') {
                        alert('Please enter the RAM Details ');
                        document.theForm.ram.value = "";
                        theForm.ram.focus();
                        return false;
                    }
                    if (isIP(trim(theForm.ram.value)) == '') {
                        alert('Please enter the valid RAM Details ');
                        document.theForm.ram.value = "";
                        theForm.ram.focus();
                        return false;
                    }
                    if ((theForm.harddisk.value) == '') {
                        alert('Please enter the Hard Disk Details ');
                        document.theForm.harddisk.value = "";
                        theForm.harddisk.focus();
                        return false;
                    }
                    if (isIP(trim(theForm.harddisk.value)) == '') {
                        alert('Please enter the valid Hard Disk Details ');
                        document.theForm.harddisk.value = "";
                        theForm.harddisk.focus();
                        return false;
                    }
                    if ((theForm.motherboard.value) == '') {
                        alert('Please enter the Mother Board Details ');
                        document.theForm.motherboard.value = "";
                        theForm.motherboard.focus();
                        return false;
                    }
                    if (isAlphaNumeric(trim(theForm.motherboard.value)) == '') {
                        alert('Please enter the valid Mother Board Details ');
                        document.theForm.motherboard.value = "";
                        theForm.motherboard.focus();
                        return false;
                    }
                    if (document.theForm.os.value == "--Select One--")
                    {
                        alert("Please select the Operating System");
                        document.theForm.os.focus();
                        return false;
                    }
                    if ((theForm.uniqueno.value) == '') {
                        alert('Please enter the Unique Asset No ');
                        document.theForm.uniqueno.value = "";
                        theForm.uniqueno.focus();
                        return false;
                    }
                    if (isAlphaNumeric(trim(theForm.uniqueno.value)) == '') {
                        alert('Please enter the valid Unique Asset No ');
                        document.theForm.uniqueno.value = "";
                        theForm.uniqueno.focus();
                        return false;
                    }
                    if ((theForm.value.value) == '') {
                        alert('Please enter the System Value ');
                        document.theForm.value.value = "";
                        theForm.value.focus();
                        return false;
                    }
                    if (isIP(trim(theForm.value.value)) == '') {
                        alert('Please enter the valid System Value ');
                        document.theForm.value.value = "";
                        theForm.value.focus();
                        return false;
                    }
                    if (document.getElementById("status").value == '') {

                        alert('Please select the status ');
                        document.getElementById("status").value = "";
                        document.getElementById("status").focus();
                        return false;
                    }

                    if ((theForm.ip.value) !== '') {
                        var responses;
                        var ip = theForm.ip.value;
                     
                        xmlhttp = createRequest();
                        if (xmlhttp !== null) {
                            xmlhttp.open("GET", "/eTracker/admin/resource/retrieveAllMACS.jsp?ip=" + trim(ip)+"&text=newResource"+"&action=retrieve" + "&rand=" + Math.random(1, 10), false);
                            xmlhttp.onreadystatechange = function() {
                                if (xmlhttp.readyState === 4)
                                {
                                    if (xmlhttp.status === 200)
                                    {
                                        var response = xmlhttp.responseText;
                                        responses = response.replace(/^\+|\s*/g, '');

                                    }
                                }
                            };
                            xmlhttp.send(null);
                        } else {
                            alert('no ajax request');
                        }
                        if (responses == "false") {
                            alert('This MAC Address Already Exists');
                            document.theForm.ip.value = "";
                            theForm.ip.focus();
                            return false;
                        }
                    }
                    monitorSubmit();
                    return true;
                }
                /** Function To Set Focus On The First Name Field In The Form */

                function setFocus()
                {
                    document.theForm.ip.focus();
                }


                window.onload = setFocus;
                //-->

            </SCRIPT>
            <style type="text/css">
                input[type=text],select{
                    width:200px;
                    height:25px;
                }
            </style>
        </head>
        <body>

            <%@ include file="/header.jsp"%>

            <table width="100%" bgcolor="#C3D9FF">
                <tr>

                    <td border="1" align="left"><font size="4" COLOR="#0000FF"><b>Add
                                New Resource</b> </font></td>
                </tr>
            </table>
            <br />
            <br />
            <FORM name=theForm onsubmit="return fun(this)"
                  action="<%=request.getContextPath()%>/admin/resource/newResource.jsp"
                  method=post onReset="return setFocus()">
                <table width="100%" bgcolor="#E8EEF7">
                    <tr style="height:28px;">
                        <td style="width: 200px;"><strong>MAC Address</strong></td>
                        <td><input type="text" name="ip"></td>
                    </tr>
                    <tr>
                        <td><strong>Machine Name</strong></td>
                        <td><input type="text" name="machinename"></td>
                    </tr>
                    <tr>
                        <td><strong>User</strong></td>
                        <td><Select name="user" size="1">
                                <option value="--Select One--" selected>--Select One--</option>
                                <%
                                    HashMap<Integer, String> al;
                                    al = GetProjectMembers.getEminentUsers();
                                    Collection set = al.keySet();
                                    Iterator iter = set.iterator();

                                    int userid = 0;

                                    while (iter.hasNext()) {

                                        int key = ((Integer) iter.next()).intValue();
                                        String nameofuser = (String) al.get(key);
                                        userid = key;


                                %>

                                <option value="<%=userid%>"><%=nameofuser%></option>
                                <%
                                    }
                                %>

                            </Select></td>
                    </tr>
                    <tr>
                        <td><strong>CPU Details</strong></td>
                        <td><input type="text" name="cpu"></td>
                    </tr>
                    <tr>
                        <td><strong>RAM Details</strong></td>
                        <td><input type="text" name="ram">in MB</td>
                    </tr>
                    <tr>
                        <td><strong>Hard Disk</strong></td>
                        <td><input type="text" name="harddisk">in GB</td>
                    </tr>
                    <tr>
                        <td><strong>Mother Board</strong></td>
                        <td><input type="text" name="motherboard"></td>
                    </tr>
                    <tr>
                        <td><strong>Operating System</strong></td>
                        <td><Select name="os" size="1">
                                <option value="--Select One--" selected>--Select One--</option>
                                <%for (String resource : ResourceUtil.osList()) {%>

                                <option value="<%=resource%>"><%=resource%></option>
                                <%}%>

                            </select>
                        <td>

                    </tr>
                    <tr>
                        <td><strong>Unique Asset No</strong></td>
                        <td><input type="text" name="uniqueno"></td>
                    </tr>
                    <tr>
                        <td><strong>Value(in INR)</strong></td>
                        <td><input type="text" name="value"></td>
                    </tr>
                    <tr>
                        <td><b>Status</b></td>
                        <td>
                            <Select name="status" id="status" size="1" >
                                <option value="--Select One--" disabled>--Select One--</option>
                                <%for (String staus : ResourceUtil.statusList()) {%>

                                <option value="<%=staus%>"><%=staus%></option>
                                <%}%>

                            </select>
                        </td>
                    </tr>

                    <tr>
                        <td align="right"><input type="submit" name="status" id="submit"
                                                 value="Create"></td>
                        <td><input type="reset" name="status" id="reset" value="Reset"></td>
                    </tr>
                </table>
            </FORM>
        </body>
    </html>
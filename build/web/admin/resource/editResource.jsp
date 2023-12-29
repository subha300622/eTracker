<%@page import="com.eminent.resource.ResourceUtil"%>
<%@ page language="java" contentType="text/html"
         pageEncoding="UTF-8"%>

<%@ page
    import="java.sql.*,java.util.*,pack.eminent.encryption.*,com.pack.*,org.apache.log4j.*,java.util.Calendar,com.eminent.util.*"%>
    <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
    <html>
        <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
            <meta http-equiv="Content-Type" content="text/html ">
            <title>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS
                Solution</title>
            <LINK title=STYLE
                  href="<%= request.getContextPath()%>/eminentech support files/main_ie.css"
                  type=text/css rel=STYLESHEET>
            <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/checkSubmit.js"></script>
            <style type="text/css">
                input[type=text],select{
                    width:200px;
                    height:25px;
                }
            </style>
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
                        var machinename=theForm.machinename.value;
                        xmlhttp = createRequest();
                        if (xmlhttp !== null) {
                            xmlhttp.open("GET", "/eTracker/admin/resource/retrieveAllMACS.jsp?ip=" + trim(ip)+"&text=updateResource"+"&machinename="+machinename+"&action=retrieve" + "&rand=" + Math.random(1, 10), false);
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
                            alert('This MAC Address Already Exists ');
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
        </head>
        <body>
            <%

                //			response.setHeader("Cache-Control","no-cache");
                //			response.setHeader("Cache-Control","no-store");
                //			response.setDateHeader("Expires", 0);
                //		 	response.setHeader("Pragma","no-cache");
                //Configuring log4j properties
                Logger logger = Logger.getLogger("Edit Resources");

                String logoutcheck = (String) session.getAttribute("Name");
                if (logoutcheck == null) {
                    logger.fatal("================Session expired===================");
            %>
            <jsp:forward page="../SessionExpired.jsp"></jsp:forward>
            <%
                }

            %>
            <%@ include file="/header.jsp"%>
            <%    String assetid = request.getParameter("assetid");
                logger.info("Unique Asset No" + assetid);
                Connection connection = null;
                PreparedStatement pt = null;
                ResultSet rs = null;
                String ip = null, machinename = null, user = null, cpu = null, ram = null, harddisk = null, motherboard = null, os = null, uniqueno = null, value = null, status = null;
                try {
                    connection = MakeConnection.getConnection();
                    pt = connection.prepareStatement("select  * from resources where unique_asset_no=?", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                    pt.setString(1, assetid);
                    rs = pt.executeQuery();
                    if (rs != null) {
                        rs.next();
                        ip = rs.getString("ipaddress");
                        machinename = rs.getString("machinename");
                        user = rs.getString("assigneduser");
                        cpu = rs.getString("cpudetails");
                        ram = rs.getString("ramdetails");
                        harddisk = rs.getString("harddisk");
                        motherboard = rs.getString("motherboard");
                        os = rs.getString("os");
                        uniqueno = rs.getString("unique_asset_no");
                        value = rs.getString("value");
                        status = rs.getString("status");

                    }

                } catch (Exception e) {
                    logger.error(e.getMessage());
                } finally {
                    if (connection != null) {
                        connection.close();
                    }
                    if (rs != null) {
                        rs.close();
                    }
                    if (pt != null) {
                        pt.close();
                    }
                }

            %>
            <table width="100%" bgcolor="#C3D9FF">
                <tr>

                    <td border="1" align="left"><font size="4" COLOR="#0000FF"><b>Edit
                                Resource</b> </font></td>
                </tr>
            </table>
            <br />
            <br />
            <FORM name="theForm" id="theForm" onsubmit="return fun(this)"
                  action="<%=request.getContextPath()%>/admin/resource/updateResource.jsp"
                  method=post onReset="return setFocus()">
                <table width="100%" bgcolor="#E8EEF7">
                    <tr>
                        <td style="width: 200px;"><strong>MAC Address</strong></td>
                        <td><input type="text" name="ip" value="<%=ip%>" maxlength="20"></td>
                    </tr>
                    <tr>
                        <td><strong>Machine Name</strong></td>
                        <td><input type="text" name="machinename"
                                   value="<%=machinename%>"></td>
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

                                        if ((Integer.parseInt(user)) == userid) {
                                %>
                                <option value="<%=userid%>" selected><%=nameofuser%></option>
                                <%

                                } else {
                                %>
                                <option value="<%=userid%>"><%=nameofuser%></option>
                                <%
                                        }

                                    }

                                %>

                            </Select></td>
                    </tr>
                    <tr>
                        <td><strong>CPU Details</strong></td>
                        <td><input type="text" name="cpu" value="<%=cpu%>"></td>
                    </tr>
                    <tr>
                        <td><strong>RAM Details</strong></td>
                        <td><input type="text" name="ram" value="<%=ram%>">in MB</td>
                    </tr>
                    <tr>
                        <td><strong>Hard Disk</strong></td>
                        <td><input type="text" name="harddisk" value="<%=harddisk%>">in
                            GB</td>
                    </tr>
                    <tr>
                        <td><strong>Mother Board</strong></td>
                        <td><input type="text" name="motherboard"
                                   value="<%=motherboard%>"></td>
                    </tr>
                    <tr>
                        <td><strong>Operating System</strong></td>
                        <td><Select name="os" size="1">

                                <%
                                    for (String resource : ResourceUtil.osList()) {%>
                                <option value="<%=resource%>" 
                                        <% if (resource.equalsIgnoreCase(os)) {%>
                                        selected
                                        <%}%>
                                        ><%=resource%></option>


                                <%                            }

                                %>
                        </td>
                    </tr>
                    <tr>
                        <td><strong>Unique Asset No</strong></td>
                        <td><input type="text" name="uniqueno" value="<%=uniqueno%>"></td>
                    </tr>
                    <tr>
                        <td><strong>Value(in INR)</strong></td>
                        <td><input type="text" name="value" value="<%=value%>" /></td>
                    </tr>
                    <tr>
                        <td><strong>Status</strong></td><td><Select name="status" id="status" size="1">
                                <option value="" >--Select One--</option>
                                <%for (String statusa : ResourceUtil.statusList()) {%>

                                <option value="<%=statusa%>"
                                        <% if (statusa.equalsIgnoreCase(status)) {%>
                                        selected
                                        <%}%>
                                        ><%=statusa%></option>
                                <%}%>

                            </select>
                        </td>
                    </tr>

                    <tr>
                        <td align="right"><input type="submit" name="status" id="submit"
                                                 value="Update"></td>
                        <td><input type="reset" name="status" id="reset" value="Reset"></td>
                    </tr>
                </table>
            </FORM>
        </body>
    </html>
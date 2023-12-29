<%-- 
    Document   : ServiceOrder
    Created on : Jun 18, 2014, 8:49:18 PM
    Author     : RN.Khans
--%>

<%@page import="org.apache.log4j.PropertyConfigurator"%>
<%@page import="org.apache.log4j.Logger"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    //Configuring log4j properties
 
    
    Logger logger = Logger.getLogger("ServiceOrder");
   
    String logoutcheck = (String) session.getAttribute("Name");
    if (logoutcheck == null) {
        logger.fatal("=========================Session Expired======================");
%>
<jsp:forward page="../SessionExpired.jsp"></jsp:forward>
<%
        //response.sendRedirect(request.getContextPath()+"/SessionExpired.jsp");
    }

%>
<!DOCTYPE html>
<html>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <TITLE>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS Solution</TITLE>
     <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/mini.js"></script>
        
        <script type="text/javascript">
            $(document).ready(function() {
                $(".tabs-menu a").click(function(event) {
                    event.preventDefault();
                    $(this).parent().addClass("current");
                    $(this).parent().siblings().removeClass("current");
                    var tab = $(this).attr("href");
                    $(".tab-content").not(tab).css("display", "none");
                    $(tab).fadeIn();
                });
            });
        </script>

        <style type="text/css">
            *{margin:0; padding:0;}
            body{ font:normal 16px/18px Arial, Helvetica, sans-serif;}
            #wrapper{ width:880px; margin:20px auto; border:1px solid #000; background:url(./images/bg.jpg)repeat-x;} 
            .header{ margin:20px 0 0 46px;}
            .title{ font-size:30px; font-weight:bold;}
            .content{ margin:20px;}
            .part-1{border:1px solid #000; border-radius:20px;-webkit-border-radius:20px; -moz-border-radius:20px; padding:25px; margin:20px 0;}

            .tab-wrapper{ margin:0 auto 20px;}
            .tab-post{border:1px solid #000; border-radius:20px;-webkit-border-radius:20px; -moz-border-radius:20px; padding:25px; margin:0; height:270px;}
            .footer{ border-top:1px solid #000; background:url(./images/bg.jpg)repeat-x; padding:40px 20px; font-size:15px; text-align:center; }
            input[type="text"]{border:1px solid #8b8d96; background:#dee5ff; font:normal 16px/18px Arial, Helvetica, sans-serif; padding:5px;}
            select{border:1px solid #8b8d96; background:#dee5ff; font:normal 16px/18px Arial, Helvetica, sans-serif; padding:5px ;}
            select:focus, input[type="text"]:focus{background:#fff; outline:none;}
            .data-table{margin:42px auto; border:1px solid #000;}
            .data-table td{ border:1px solid #000; }
            table, table td{border-collapse:collapse;}
            input[type="submit"]{border:1px solid #000; cursor:pointer; border-radius:5px;-webkit-border-radius:5px; -moz-border-radius:5px; padding:10px 15px; color:#000; background:#d4d0c8;}
            .tabs-menu {
                height: 30px;
                float: none;
                clear: both; list-style:none;margin-left: 22px; margin-bottom:1px;
            }

            .tabs-menu li {
                height: 30px;
                line-height: 30px;
                float: left;
                margin-right: 10px;
                background-color: #D4D0C8;
                border-top: 1px solid #000;
                border-right: 1px solid #000;
                border-left: 1px solid #000;
            }

            .tabs-menu li.current {
                position: relative;
                background-color: #fff;
                border-bottom: 1px solid #fff;
                z-index: 5;
            }

            .tabs-menu li a {
                padding: 10px;
                text-transform: uppercase;
                color: #000;
                text-decoration: none; 
            }

            .tabs-menu .current a {
                color: #2e7da3;
            }
            .tab-content {
                display: none;
            }

            #tab-1 {
                display: block;   
            }
        </style>


    </head>
    <body>
        
        <div id="wrapper">
            <!--=======Header part start here=========-->
            <div class="header">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td width="14%"><img src="./images/logo.jpg" alt=""></td>
                        <td width="64%" align="center" class="title">Service Order Creation Form</td>
                        <td width="22%">Address :<br />
                            Plot no : C-30<br />
                            Block G, Opp SIDBI,<br />
                            Bandra Kurla Complex,<br />
                            Bandra (E),<br />
                            Mumbai 400051.</td>
                    </tr>
                </table>
            </div>
            <!--=======Main content part start here=========-->
            <div class="content">
                <form action="CreateServiceServlet" method="post" name="service">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td align="left" valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                                    <tr>
                                        <td width="50%"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                <tr>
                                                    <td width="24%" height="45" align="left" valign="middle">Form ID</td>
                                                    <td width="76%" height="45" align="left" valign="middle"><input type="text" name="textfield" class="textfield" /></td>
                                                </tr>
                                                <tr>
                                                    <td height="45" align="left" valign="middle">Created By</td>
                                                    <td height="45" align="left" valign="middle"><input type="text" name="textfield2" class="textfield" /></td>
                                                </tr>
                                            </table></td>
                                        <td width="50%"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                <tr>
                                                    <td width="51%" height="45" align="right" valign="middle">Date</td>
                                                    <td width="49%" height="45" align="right" valign="middle"><input type="text" name="textfield3" class="textfield" /></td>
                                                </tr>
                                                <tr>
                                                    <td height="45" align="right" valign="middle">Time</td>
                                                    <td height="45" align="right" valign="middle"><input type="text" name="textfield4" class="textfield" /></td>
                                                </tr>
                                            </table></td>
                                    </tr>
                                </table></td>
                        </tr>
                        <tr>
                            <td align="left" valign="top">
                                <div class="part-1">
                                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                        <tr>
                                            <td width="31%" height="50">Nature of Complaint Short Text :</td>
                                            <td width="69%" height="50">
                                                <select name="complaint" class="select" style="width:350px;">
                                                    <option>--select--</option>
                                                    <option value="Required Trolley Wheel For Service Yard">Required Trolley Wheel For Service Yard</option>
                                                    <option value="Required Paint For Mall Open parking">Required Paint For Mall Open parking</option>
                                                    <option>Required Rectification Of Sewage Drain L</option>
                                                    <option>S/F Pint room back side 2 pl light is no</option>
                                                    <option>Required Dosing pump For Clivet Chiller</option>
                                                    <option>Required Gas Charging For Water Cooler</option>
                                                    <option>Sliding Door Dismentling & Re Fixing</option>
                                                    <option>Clivet Chiller wall Dismentling & debris</option>
                                                </select></td>
                                        </tr>
                                        <tr>
                                            <td height="50">Functional Location :</td>
                                            <td height="50"><select name="location" class="select" style="width:350px;">
                                                    <option>--select--</option>
                                                    <option value="YB50000/00000001">1100/MUM-MALD/M003</option>
                                                    <option value="YB50000/00000001">1100/MUM-MALD/M003/OP00</option>
                                                    <option value="YB50000/00000001">1100/MUM-MALD/M003/FL02/FM00</option>
                                                    <option value="YB50000/00000001">1100/MUM-MALD/M003/FL02/RB17</option>
                                                    <option value="YB50000/00000001">1100/MUM-MALD/M003/TR00/CP00</option>
                                                    <option value="YB50000/00000001">1100/MUM-MALD/M003/FL02/WR00</option>
                                                    <option value="YB50000/00000001">1100/MUM-MALD/M003/GF00</option>
                                                    <option value="YB50000/00000001">1100/MUM-MALD/M003/TR00/CP00</option>
                                                </select></td>
                                        </tr>
                                        <tr>
                                            <td height="50">Equipment :</td>
                                            <td height="50"><select name="equipment" class="select" style="width:350px;">
                                                    <option>--select--</option>
                                                    <option value="10000059">GF-COMMON AREA FIRE EXIT SIGNAGES</option>
                                                    <option value="10000059">BM-SERVICE YARD SUMP PUMP PANEL</option>
                                                    <option value="10000059">SF-S/F L/W SPLIT AC 2 TR</option>
                                                    <option value="10000059">SF-S/F G/W SPLIT AC 2 TR</option>
                                                    <option value="10000059">FF-G/W SPLIT AC 2 TR</option>
                                                    <option value="10000059">FF-L/W SPLIT AC 2 TR</option>
                                                    <option value="10000059">GF-G/W SPLIT AC 2 TR</option>
                                                    <option value="10000059">GF-L/W SPLIT AC 2 TR</option>
                                                </select></td>



                                        </tr>
                                        <tr>
                                            <td height="50">Reported By :</td>
                                            <td height="50"><select name="reported" class="select" style="width:250px;">
                                                    <option>--select--</option>
                                                    <option value="Backyaraj">Backyaraj</option>
                                                    <option value="Saravanakumar">Saravanakumar</option>
                                                    <option value="Giridharan">Giridharan</option>
                                                    <option value="Mahesh">Mahesh</option>
                                                </select></td>
                                        </tr>
                                        <tr>
                                            <td height="50">Nature of Complaint</td>
                                            <td height="50"><select name="natureComplaint" class="select" style="width:250px;">
                                                    <option>--select--</option>
                                                    <option value="Electrical">Electrical</option>
                                                    <option value="Plumbing">Plumbing</option>
                                                    <option value="Carpentry">Carpentry</option>
                                                    <option value="Civil">Civil</option>
                                                    <option value="Security and Safety">Security and Safety</option>
                                                    <option value="HVAC">HVAC</option>
                                                </select></td>
                                        </tr>
                                    </table>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" valign="top">
                                <div class="tab-wrapper">
                                    <div class="tab">
                                        <ul class="tabs-menu">
                                            <li class="current"><a href="#tab-1">Tab 1</a></li>
                                            <li><a href="#tab-2">Tab 2</a></li>
                                            <li><a href="#tab-3">Tab 3</a></li>
                                            <li><a href="#tab-4">Tab 4</a></li>
                                        </ul>
                                    </div>
                                    <div class="tab-post">
                                        <div id="tab-1" class="tab-content">
                                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                <tr>
                                                    <td width="12%" height="45" align="left" valign="middle">Field - 1</td>
                                                    <td width="31%" height="45" align="left" valign="middle"><input type="text" name="textfield5" class="textfield" /></td>
                                                    <td width="12%" height="45">&nbsp;</td>
                                                    <td width="12%" height="45" align="left" valign="middle">Field - 7</td>
                                                    <td width="33%" height="45" align="left" valign="middle"><input type="text" name="textfield5" class="textfield" /></td>
                                                </tr>
                                                <tr>
                                                    <td height="45" align="left" valign="middle">Field - 2</td>
                                                    <td height="45" align="left" valign="middle"><input type="text" name="textfield6" class="textfield" /></td>
                                                    <td height="45">&nbsp;</td>
                                                    <td height="45" align="left" valign="middle">Field - 8</td>
                                                    <td height="45" align="left" valign="middle"><input type="text" name="textfield6" class="textfield" /></td>
                                                </tr>
                                                <tr>
                                                    <td height="45" align="left" valign="middle">Field - 3</td>
                                                    <td height="45" align="left" valign="middle"><input type="text" name="textfield7" class="textfield" /></td>
                                                    <td height="45">&nbsp;</td>
                                                    <td height="45" align="left" valign="middle">Field - 9</td>
                                                    <td height="45" align="left" valign="middle"><input type="text" name="textfield7" class="textfield" /></td>
                                                </tr>
                                                <tr>
                                                    <td height="45" align="left" valign="middle">Field - 4</td>
                                                    <td height="45" align="left" valign="middle"><input type="text" name="textfield8" class="textfield" /></td>
                                                    <td height="45">&nbsp;</td>
                                                    <td height="45" align="left" valign="middle">Field - 10</td>
                                                    <td height="45" align="left" valign="middle"><input type="text" name="textfield8" class="textfield" /></td>
                                                </tr>
                                                <tr>
                                                    <td height="45" align="left" valign="middle">Field - 5</td>
                                                    <td height="45" align="left" valign="middle"><input type="text" name="textfield9" class="textfield" /></td>
                                                    <td height="45">&nbsp;</td>
                                                    <td height="45" align="left" valign="middle">Field - 11</td>
                                                    <td height="45" align="left" valign="middle"><input type="text" name="textfield9" class="textfield" /></td>
                                                </tr>
                                                <tr>
                                                    <td height="45" align="left" valign="middle">Field - 6</td>
                                                    <td height="45" align="left" valign="middle"><input type="text" name="textfield10" class="textfield" /></td>
                                                    <td height="45">&nbsp;</td>
                                                    <td height="45" align="left" valign="middle">Field - 12</td>
                                                    <td height="45" align="left" valign="middle"><input type="text" name="textfield10" class="textfield" /></td>
                                                </tr>
                                            </table>

                                        </div>
                                        <div id="tab-2" class="tab-content">
                                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                <tr>
                                                    <td width="12%" height="55" align="left" valign="middle">Field - 1</td>
                                                    <td width="31%" height="55" align="left" valign="middle"><input type="text" name="textfield5" class="textfield" /></td>
                                                    <td width="12%" height="55">&nbsp;</td>
                                                    <td width="12%" height="55" align="left" valign="middle">Field - 6</td>
                                                    <td width="33%" height="55" align="left" valign="middle"><input type="text" name="textfield5" class="textfield" /></td>
                                                </tr>
                                                <tr>
                                                    <td height="55" align="left" valign="middle">Field - 2</td>
                                                    <td height="55" align="left" valign="middle"><input type="text" name="textfield6" class="textfield" /></td>
                                                    <td height="55">&nbsp;</td>
                                                    <td height="55" align="left" valign="middle">Field -7</td>
                                                    <td height="55" align="left" valign="middle"><input type="text" name="textfield6" class="textfield" /></td>
                                                </tr>
                                                <tr>
                                                    <td height="55" align="left" valign="middle">Field - 3</td>
                                                    <td height="55" align="left" valign="middle"><input type="text" name="textfield7" class="textfield" /></td>
                                                    <td height="55">&nbsp;</td>
                                                    <td height="55" align="left" valign="middle">Field - 8</td>
                                                    <td height="55" align="left" valign="middle"><input type="text" name="textfield7" class="textfield" /></td>
                                                </tr>
                                                <tr>
                                                    <td height="55" align="left" valign="middle">Field - 4</td>
                                                    <td height="55" align="left" valign="middle"><input type="text" name="textfield8" class="textfield" /></td>
                                                    <td height="55">&nbsp;</td>
                                                    <td height="55" align="left" valign="middle">Field - 9</td>
                                                    <td height="55" align="left" valign="middle"><input type="text" name="textfield8" class="textfield" /></td>
                                                </tr>
                                                <tr>
                                                    <td height="55" align="left" valign="middle">Field - 5</td>
                                                    <td height="55" align="left" valign="middle"><input type="text" name="textfield9" class="textfield" /></td>
                                                    <td height="55">&nbsp;</td>
                                                    <td height="55" align="left" valign="middle">Field - 10</td>
                                                    <td height="55" align="left" valign="middle"><input type="text" name="textfield9" class="textfield" /></td>
                                                </tr>
                                            </table>
                                        </div>
                                        <div id="tab-3" class="tab-content">
                                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                <tr>
                                                    <td width="12%" height="65" align="left" valign="middle">Field - 1</td>
                                                    <td width="31%" height="65" align="left" valign="middle"><input type="text" name="textfield5" class="textfield" /></td>
                                                    <td width="12%" height="65">&nbsp;</td>
                                                    <td width="12%" height="65" align="left" valign="middle">Field - 7</td>
                                                    <td width="33%" height="65" align="left" valign="middle"><input type="text" name="textfield5" class="textfield" /></td>
                                                </tr>
                                                <tr>
                                                    <td height="65" align="left" valign="middle">Field - 2</td>
                                                    <td height="65" align="left" valign="middle"><input type="text" name="textfield6" class="textfield" /></td>
                                                    <td height="65">&nbsp;</td>
                                                    <td height="65" align="left" valign="middle">Field - 8</td>
                                                    <td height="65" align="left" valign="middle"><input type="text" name="textfield6" class="textfield" /></td>
                                                </tr>
                                                <tr>
                                                    <td height="65" align="left" valign="middle">Field - 3</td>
                                                    <td height="65" align="left" valign="middle"><input type="text" name="textfield7" class="textfield" /></td>
                                                    <td height="65">&nbsp;</td>
                                                    <td height="65" align="left" valign="middle">Field - 9</td>
                                                    <td height="65" align="left" valign="middle"><input type="text" name="textfield7" class="textfield" /></td>
                                                </tr>
                                                <tr>
                                                    <td height="65" align="left" valign="middle">&nbsp;</td>
                                                    <td height="65" align="left" valign="middle"><input type="submit" name="button" id="button" value="Get Poup" /></td>
                                                    <td height="65">&nbsp;</td>
                                                    <td height="65" align="left" valign="middle">&nbsp;</td>
                                                    <td height="65" align="left" valign="middle">&nbsp;</td>
                                                </tr>
                                            </table>
                                        </div>
                                        <div id="tab-4" class="tab-content">

                                            <table class="data-table" width="80%" border="0" align="center" cellpadding="0" cellspacing="0" >
                                                <tr>
                                                    <td height="40" align="center" valign="middle">Column 1</td>
                                                    <td height="40" align="center" valign="middle">Column 2</td>
                                                    <td height="40" align="center" valign="middle">Column 3</td>
                                                    <td height="40" align="center" valign="middle">Column 4</td>
                                                    <td height="40" align="center" valign="middle">Column 5</td>
                                                </tr>
                                                <tr>
                                                    <td height="40" align="center" valign="middle" bgcolor="#CCCCCC">Text 1 1</td>
                                                    <td height="40" align="center" valign="middle" bgcolor="#CCCCCC">Text 1 2</td>
                                                    <td height="40" align="center" valign="middle" bgcolor="#CCCCCC">Text 1 3</td>
                                                    <td height="40" align="center" valign="middle" bgcolor="#CCCCCC">Text 1 4</td>
                                                    <td height="40" align="center" valign="middle" bgcolor="#CCCCCC">Text 1 5</td>
                                                </tr>
                                                <tr>
                                                    <td height="40" align="center" valign="middle">Text 2 1</td>
                                                    <td height="40" align="center" valign="middle">Text 2 2</td>
                                                    <td height="40" align="center" valign="middle">Text 2 3</td>
                                                    <td height="40" align="center" valign="middle">Text 2 4</td>
                                                    <td height="40" align="center" valign="middle">Text 2 5</td>
                                                </tr>
                                                <tr>
                                                    <td height="40" align="center" valign="middle" bgcolor="#CCCCCC">Text 3 1</td>
                                                    <td height="40" align="center" valign="middle" bgcolor="#CCCCCC">Text 3 2</td>
                                                    <td height="40" align="center" valign="middle" bgcolor="#CCCCCC">Text 3 3</td>
                                                    <td height="40" align="center" valign="middle" bgcolor="#CCCCCC">Text 3 4</td>
                                                    <td height="40" align="center" valign="middle" bgcolor="#CCCCCC">Text 3 5</td>
                                                </tr>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td height="60" align="center" valign="top">
                                <input name="Create Order" type="submit" value="Create Order" />
                            </td>
                        </tr>
                    </table>
                </form>
            </div>
            <!--=======Footer part start here=========-->
            <div class="footer">
                Note : Service Order Creation Form replicates the IW31 Transaction of SAP. User can Create a Service order using this Form.
            </div>
        </div>
    </body>
</html>

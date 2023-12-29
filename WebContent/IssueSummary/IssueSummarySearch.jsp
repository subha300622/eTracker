<%@page import="java.math.BigDecimal"%>
<%@page import="com.eminent.issue.ApmComponentIssues"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Arrays"%>
<%@ page autoFlush="true" buffer="1094kb"%> 
<html>
    <%
        Logger logger = Logger.getLogger("IssueSummarySearch");

        String logoutcheck = (String) session.getAttribute("Name");
        if (logoutcheck == null) {
    %>
    <jsp:forward page="../SessionExpired.jsp"></jsp:forward>
    <%
        }
    %>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
    <meta name="GENERATOR" content="Microsoft FrontPage 4.0">
    <meta name="ProgId" content="FrontPage.Editor.Document">
    <meta http-equiv="Content-Language" content="en-us">
    <title>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS
        Solution</title>
    <LINK title=STYLE
          href="<%= request.getContextPath()%>/eminentech support files/main_ie.css"
          type=text/css rel=STYLESHEET>
    <style fprolloverstyle>
        A:hover {
            color: #FF0000;
            font-weight: bold
        }
    </style>
</head>
<body bgcolor="#FFFFFF">
    <%@ page import="java.sql.*"%>
    <%@ page import="java.text.*"%>
    <%@ page import="java.sql.Date,pack.eminent.encryption.*,org.apache.log4j.Logger"%>
    <%@ page language="java"%>
<BODY>
    <%@ include file="../header.jsp"%>
    <jsp:useBean id="atc" class="com.eminent.issue.controller.ApmComponentIssueController"/>
    <div align="center">
        <center><br>
            <table cellpadding="0" cellspacing="0" width="100%">
                <tr border="2" bgcolor="#F5F5F5">
                    <td bgcolor="#F5F5F5" border="1" align="left" width="75%"><font
                            size="4" COLOR="#0000FF"><b> Issue Summary </b></font> <FONT SIZE="3"
                            COLOR="#0000FF"></FONT></td>
                </tr>
            </table>
            <%
                int userId = (Integer) session.getAttribute("userid_curr");
                int roleId = (Integer) session.getAttribute("Role");
                SimpleDateFormat sdfInput = new SimpleDateFormat("dd-MM-yyyy");
                SimpleDateFormat sdfOutput = new SimpleDateFormat("dd-MMM-yy");

                String duedateOption = request.getParameter("duedate_param");
                String createdOption = request.getParameter("created_param");
                String modifiedOption = request.getParameter("updated_param");
                logger.info("duedateOption" + duedateOption);
                String query1 = "";
                String custome[] = request.getParameterValues("S2");
                String customer = "";
                boolean customerflag = true;
                for (int i = 0; i < custome.length; i++) {
                    if (!customer.equalsIgnoreCase("All Information")) {
                        if (!custome[i].equalsIgnoreCase("All Information")) {
                            if (customerflag == true) {
                                customer = customer + "'" + custome[i].toUpperCase() + "'";
                                customerflag = false;
                            } else {
                                customer = customer + " OR upper(customer) ='" + custome[i].toUpperCase() + "'";
                            }
                        } else {
                            customer = "All Information";
                        }
                    }
                }
                boolean productflag = true;
                String produc[] = request.getParameterValues("S1");
                String product = "";
                if (produc == null) {
                } else {
                    for (int i = 0; i < produc.length; i++) {
                        if (!product.equalsIgnoreCase("All Information")) {
                            if (!produc[i].equalsIgnoreCase("All Information")) {
                                if (productflag == true) {
                                    product = product + "'" + produc[i].toUpperCase() + "'";
                                    productflag = false;
                                } else {
                                    product = product + " OR upper(pname) ='" + produc[i].toUpperCase() + "'";
                                }
                            } else {
                                product = "All Information";
                            }
                        }
                    }
                }
                boolean versionflag = true;
                String versio[] = request.getParameterValues("S3");
                String version = "";
                if (versio == null) {
                } else {
                    for (int i = 0; i < versio.length; i++) {
                        if (!version.equalsIgnoreCase("All Information")) {
                            if (!versio[i].equalsIgnoreCase("All Information")) {
                                if (versionflag == true) {
                                    version = version + "'" + versio[i].toUpperCase() + "'";
                                    versionflag = false;
                                } else {
                                    version = version + " OR upper(found_version) =" + versio[i].toUpperCase() + "'";
                                }
                            } else {
                                version = "All Information";
                            }
                        }
                    }
                }
                boolean fixversionflag = true;
                String fixversio[] = request.getParameterValues("S4");
                String fixversion = "";
                if (fixversio == null) {
                } else {
                    for (int i = 0; i < fixversio.length; i++) {
                        if (!fixversion.equalsIgnoreCase("All Information")) {
                            if (!fixversio[i].equalsIgnoreCase("All Information")) {
                                if (fixversionflag == true) {
                                    fixversion = fixversion + "'" + fixversio[i].toUpperCase() + "'";
                                    fixversionflag = false;
                                } else {
                                    fixversion = fixversion + " OR upper(version) ='" + fixversio[i].toUpperCase() + "'";
                                }
                            } else {
                                fixversion = "All Information";
                            }
                        }
                    }
                }
                boolean platformflag = true;
                String platfor[] = request.getParameterValues("S5");
                String platform = "";
                if (platfor == null) {
                } else {
                    for (int i = 0; i < platfor.length; i++) {
                        if (!platform.equalsIgnoreCase("All Information")) {
                            if (!platfor[i].equalsIgnoreCase("All Information")) {
                                if (platformflag == true) {
                                    platform = platform + "'" + platfor[i].toUpperCase() + "'";
                                    platformflag = false;
                                } else {
                                    platform = platform + " OR upper(platform) ='" + platfor[i].toUpperCase() + "',";
                                }
                            } else {
                                platform = "All Information";
                            }
                        }
                    }
                }
                boolean moduleflag = true;
                String modul[] = request.getParameterValues("S6");
                String module = "";
                if (modul == null) {
                } else {
                    for (int i = 0; i < modul.length; i++) {
                        if (!module.equalsIgnoreCase("All Information")) {
                            if (!modul[i].equalsIgnoreCase("All Information")) {
                                if (moduleflag == true) {
                                    module = module + "'" + modul[i].toUpperCase() + "'";
                                    moduleflag = false;
                                } else {
                                    module = module + " OR upper(m.module) ='" + modul[i].toUpperCase() + "'";
                                }
                            } else {
                                module = "All Information";
                            }
                        }
                    }
                }
                boolean severityflag = true;
                String severit[] = request.getParameterValues("S7");
                String severity = "";
                if (severit == null) {
                } else {
                    for (int i = 0; i < severit.length; i++) {
                        if (!severity.equalsIgnoreCase("All Information")) {
                            if (!severit[i].equalsIgnoreCase("All Information")) {
                                if (severityflag == true) {
                                    severity = severity + "'" + severit[i].toUpperCase() + "'";
                                    severityflag = false;
                                } else {
                                    severity = severity + " OR upper(severity) ='" + severit[i].toUpperCase() + "'";
                                }

                            } else {
                                severity = "All Information";
                            }
                        }
                    }
                }
                boolean priorityflag = true;
                String priorit[] = request.getParameterValues("S8");
                String priority = "";
                if (priorit == null) {
                } else {
                    for (int i = 0; i < priorit.length; i++) {
                        if (!priority.equalsIgnoreCase("All Information")) {
                            if (!priorit[i].equalsIgnoreCase("All Information")) {
                                if (priorityflag == true) {
                                    priority = priority + "'" + priorit[i].toUpperCase() + "'";
                                    priorityflag = false;
                                } else {
                                    priority = priority + " OR upper(priority) ='" + priorit[i].toUpperCase() + "'";
                                }
                            } else {
                                priority = "All Information";
                            }
                        }
                    }
                }
                if (priority.contains(",")) {
                    priority = priority.substring(0, priority.length() - 1);
                }
                boolean componentselectorflag = true;
                String[] componentSeletions = request.getParameterValues("componentSelector");
                String allSelection = "";
                if (componentSeletions == null) {
                } else {
                    for (int i = 0; i < componentSeletions.length; i++) {
                        if (!allSelection.equalsIgnoreCase("All Information")) {
                            if (!componentSeletions[i].equalsIgnoreCase("All Information")) {
                                if (componentselectorflag == true) {
                                    int componentId = Integer.parseInt(componentSeletions[i]);
                                    allSelection = allSelection + "" + componentId;
                                    componentselectorflag = false;
                                } else {
                                    int componentId = Integer.parseInt(componentSeletions[i]);
                                    allSelection = allSelection + " " + "OR ci.component_id=" + componentId;
                                }
                            } else {
                                allSelection = "All Information";
                            }
                        }
                    }
                }
                if (allSelection.contains(",")) {
                    allSelection = allSelection.substring(0, allSelection.length() - 1);
                }
                boolean ratingflag = true;
                String ratings[] = request.getParameterValues("rating");
                String rating = "";
                if (ratings == null) {
                } else {
                    for (int i = 0; i < ratings.length; i++) {
                        if (!rating.equalsIgnoreCase("All Information")) {
                            if (!ratings[i].equalsIgnoreCase("All Information")) {
                                if (ratingflag == true) {
                                    rating = rating + "'" + ratings[i].toUpperCase() + "'";
                                    ratingflag = false;
                                } else {
                                    rating = rating + " OR upper(rating) ='" + ratings[i].toUpperCase() + "'";
                                }
                            } else {
                                rating = "All Information";
                            }
                        }
                    }
                }
                if (rating.contains(",")) {
                    rating = rating.substring(0, rating.length() - 1);
                }
                boolean issuestatusesflag = true;
                String[] issuestatuses = request.getParameterValues("S10");
                List<String> issuestatusList = new ArrayList<String>();
                String allstatus = "";
                if (issuestatuses != null) {
                    issuestatusList = Arrays.asList(issuestatuses);
                }

                logger.info("issuestatusList.size():" + issuestatusList.size());
                boolean assignedtoflag = true;
                String assignedt[] = request.getParameterValues("S12");
                String assignedto = "";
                List<String> assignedtoList = new ArrayList<String>();
                if (assignedt == null) {
                } else {
                    for (int i = 0; i < assignedt.length; i++) {
                        if (!assignedto.equalsIgnoreCase("All Information")) {
                            if (!assignedt[i].equalsIgnoreCase("All Information")) {
                                if (assignedtoflag == true) {
                                    assignedto = assignedto + "'" + assignedt[i].trim().toUpperCase() + "'";
                                    assignedtoflag = false;
                                } else {
                                    assignedto = assignedto + " OR upper(assignedto) ='" + assignedt[i].trim().toUpperCase() + "'";
                                }
                                assignedtoList.add(assignedt[i].trim().toUpperCase());

                            } else {
                                assignedto = "All Information";
                            }
                        }
                    }
                }
                boolean createdbyflag = true;
                String createdb[] = request.getParameterValues("S11");
                String createdby = "";
                if (createdb == null) {
                } else {
                    for (int i = 0; i < createdb.length; i++) {
                        if (!createdby.equalsIgnoreCase("All Information")) {
                            if (!createdb[i].equalsIgnoreCase("All Information")) {
                                if (createdbyflag == true) {
                                    createdby = createdby + "'" + createdb[i].toUpperCase() + "'";
                                    createdbyflag = false;
                                } else {
                                    createdby = createdby + " OR upper(createdby) ='" + createdb[i].toUpperCase() + "'";
                                }
                            } else {
                                createdby = "All Information";
                            }
                        }
                    }
                }
                boolean typeflag = true;
                String typ[] = request.getParameterValues("S9");
                String type = "";
                if (typ == null) {
                } else {
                    for (int i = 0; i < typ.length; i++) {
                        if (!type.equalsIgnoreCase("All Information")) {
                            if (!typ[i].equalsIgnoreCase("All Information")) {
                                if (typeflag == true) {
                                    type = type + "'" + typ[i].toUpperCase() + "'";
                                    typeflag = false;
                                } else {
                                    type = type + " OR upper(type) ='" + typ[i].toUpperCase() + "'";
                                }
                            } else {
                                type = "All Information";
                            }
                        }
                    }
                }
                String date = request.getParameter("date").toUpperCase();
                String modifiedon = request.getParameter("modifiedon").toUpperCase();
                String crid = request.getParameter("crid").toUpperCase();
                String duedate = request.getParameter("duedate").toUpperCase();
                String subject = request.getParameter("subject").toUpperCase();
                String wrmSelector = request.getParameter("wrmSelector");
                boolean updatedbyflag = true;
                String updatedb[] = request.getParameterValues("S13");
                String updatedby = "";
                List<String> updatedbyList = new ArrayList<String>();
                if (updatedb == null) {
                } else {
                    for (int i = 0; i < updatedb.length; i++) {
                        if (!updatedby.equalsIgnoreCase("All Information")) {
                            if (!updatedb[i].equalsIgnoreCase("All Information")) {
                                if (updatedbyflag == true) {
                                    updatedby = updatedby + "'" + updatedb[i].toUpperCase() + "'";
                                    updatedbyflag = false;
                                } else {
                                    updatedby = updatedby + " OR upper(commentedby) ='" + updatedb[i].toUpperCase() + "'";
                                }
                                updatedbyList.add(updatedb[i].trim().toUpperCase());
                            } else {
                                updatedby = "All Information";
                            }
                        }

                    }
                }
                String duedatefrom = request.getParameter("duedatefrom");
                String duedateto = request.getParameter("duedateto");
                String createdfrom = request.getParameter("createdfrom");
                String createdto = request.getParameter("createdto");
                String updatedfrom = request.getParameter("modifiedfrom");
                String updatedto = request.getParameter("modifiedto");
                logger.info("Due date before" + duedate);
                if (duedateOption.equalsIgnoreCase("Today")) {
                    duedate = "(SELECT TO_CHAR(SYSDATE, 'DD-Mon-YY') FROM DUAL)";
                }
                if (createdOption.equalsIgnoreCase("Today")) {
                    date = "SELECT TO_CHAR(SYSDATE, 'DD-Mon-YY') FROM DUAL";
                }
                if (modifiedOption.equalsIgnoreCase("Today")) {
                    modifiedon = "SELECT TO_CHAR(SYSDATE, 'DD-Mon-YY') FROM DUAL";
                }
                if (duedateOption.equalsIgnoreCase("Between") && !(duedatefrom.equalsIgnoreCase("All Information")) && !(duedatefrom.equals(null)) && !(duedatefrom.equals("")) && !(duedateto.equalsIgnoreCase("All Information")) && !(duedateto.equals(null)) && !(duedateto.equals(""))) {
                    duedate = duedatefrom;
                }

                if (createdOption.equalsIgnoreCase("Between") && !(createdfrom.equalsIgnoreCase("All Information")) && !(createdfrom.equals(null)) && !(createdfrom.equals("")) && !(createdto.equalsIgnoreCase("All Information")) && !(createdto.equals(null)) && !(createdto.equals(""))) {
                    date = createdfrom;
                }

                if (modifiedOption.equalsIgnoreCase("Between") && !(updatedfrom.equalsIgnoreCase("All Information")) && !(updatedfrom.equals(null)) && !(updatedfrom.equals("")) && !(updatedto.equalsIgnoreCase("All Information")) && !(updatedto.equals(null)) && !(updatedto.equals(""))) {
                    modifiedon = updatedfrom;
                }
                String extendedQueryc = "";
                String extendedQueryd = "";

                if (!allSelection.contains("All Information") && !(allSelection == null) && !"".equals(allSelection)) {
                    extendedQueryc = ", APM_COMPONENT_ISSUES ci";
                    extendedQueryd = " and ci.issue_id = i.issueid";
                }
                query1 = "select distinct i.issueid, pname as project,module, subject, i.description, priority, severity, type, createdon, due_date, modifiedon,createdby,assignedto,s.status,rating,feedback  from issue i,issuestatus s, project p, modules m" + extendedQueryc;
                String querycheck = "";
                int count = 0;
                if (!(customer.equalsIgnoreCase("All Information")) && !(customer.equals(null)) && !(customer.equals(""))) {
                    querycheck = querycheck + " and (upper(customer) = " + customer.trim() + ")";
                    count++;
                }
                if (!(product.equalsIgnoreCase("All Information")) && !(product.equals(null)) && !(product.equals(""))) {
                    querycheck = querycheck + " and (upper(pname) = " + product.trim() + ")";
                    count++;
                }
                if (!(version.equalsIgnoreCase("All Information")) && !(version.equals(null)) && !(version.equals(""))) {
                    querycheck = querycheck + " and (upper(found_version) = " + version.trim() + ")";
                    count++;
                }
                if (!(fixversion.equalsIgnoreCase("All Information")) && !(fixversion.equals(null)) && !(fixversion.equals(""))) {
                    querycheck = querycheck + " and (upper(version) = " + fixversion.trim() + ")";
                    count++;
                }
                if (!(platform.equalsIgnoreCase("All Information")) && !(platform.equals(null)) && !(platform.equals(""))) {
                    querycheck = querycheck + " and (upper(platform) = " + platform.trim() + ")";
                    count++;
                }
                if (!(module.equalsIgnoreCase("All Information")) && !(module.equals(null)) && !(module.equals(""))) {
                    querycheck = querycheck + " and (upper(m.module) = " + module.trim() + ") and module_id = moduleid";
                    count++;
                }
                if (!(severity.equalsIgnoreCase("All Information")) && !(severity.equals(null)) && !(severity.equals(""))) {
                    querycheck = querycheck + " and (upper(severity) = " + severity.trim() + ")";
                    count++;
                }
                if (!(priority.equalsIgnoreCase("All Information")) && !(priority.equals(null)) && !(priority.equals(""))) {
                    querycheck = querycheck + " and (upper(priority) = " + priority.trim() + ")";
                    count++;
                }
                if (!allSelection.contains("All Information") && !(allSelection == null) && !"".equals(allSelection)) {
                    querycheck = querycheck + " and (ci.COMPONENT_ID = " + allSelection.trim() + ")";
                    count++;
                }
                if (!(rating.equalsIgnoreCase("All Information")) && !(rating.equals(null)) && !(rating.equals(""))) {
                    querycheck = querycheck + " and (upper(rating) = " + rating.trim() + ")";
                    count++;
                }
                if (!(issuestatusList.contains("All Information")) && !(issuestatuses == null) && !(issuestatusList.contains(""))) {
                    if (!(issuestatusList.contains("Open Issues"))) {
                        for (String stat : issuestatusList) {
                            if (issuestatusesflag == true) {
                                allstatus = allstatus + "'" + stat.toUpperCase() + "'";
                                issuestatusesflag = false;
                            } else {
                                allstatus = allstatus + " OR upper(s.status) ='" + stat.toUpperCase() + "'";
                            }
                        }
                        querycheck = querycheck + " and (upper(s.status) = " + allstatus + ")";
                    } else {
                        querycheck = querycheck + " and upper(s.status)!='CLOSED'";
                    }
                    count++;
                }
                boolean newproductflag = true;
                String newProduct = "";
                for (int i = 0; i < produc.length; i++) {
                    if (!newProduct.equalsIgnoreCase("All Information")) {
                        if (!produc[i].equalsIgnoreCase("All Information")) {
                            if (newproductflag == true) {
                                newProduct = newProduct + "'" + produc[i].toUpperCase() + "'";
                                newproductflag = false;
                            } else {
                                newProduct = newProduct + " OR upper(pp.pname) ='" + produc[i].toUpperCase() + "'";
                            }
                        } else {
                            newProduct = "All Information";
                        }
                    }
                }
                boolean newversionflag = true;
                String newversion = "";
                for (int i = 0; i < versio.length; i++) {
                    if (!newversion.equalsIgnoreCase("All Information")) {
                        if (!versio[i].equalsIgnoreCase("All Information")) {
                            if (newversionflag == true) {
                                newversion = newversion + "'" + versio[i].toUpperCase() + "'";
                                newversionflag = false;
                            } else {
                                newversion = newversion + " OR upper(pp.version) =" + versio[i].toUpperCase() + "'";
                            }
                        } else {
                            newversion = "All Information";
                        }
                    }
                }
                if (!(assignedto.equalsIgnoreCase("All Information")) && !(assignedto.equals(null)) && !(assignedto.equals(""))) {
                    logger.info("assignedto" + assignedto);

                    assignedto = assignedto.trim();
                    if (assignedtoList.contains("CLIENT USERS")) {

                        logger.info("assignedtoList" + assignedtoList);
                        if (version.equalsIgnoreCase("All Information")) {

                            querycheck = querycheck + " and upper(assignedto) in (select up.userid from userproject up, users us  where up.pid in (select pid from project pp where upper(pp.pname) = " + newProduct + " ) and us.userid=up.userid and us.EMAIL not like '%eminentlabs.net')";
                            count++;
                        } else {

                            querycheck = querycheck + " and upper(assignedto) in (select up.userid from userproject up, users us  where up.pid in(select pid from project pp where upper(pp.pname) = " + newProduct + " and pp.VERSION = " + newversion + ") and us.userid=up.userid and us.EMAIL not like '%eminentlabs.net')";
                            count++;
                        }

                    } else if (assignedtoList.contains("INTERNAL USERS")) {
                        if (version.equalsIgnoreCase("All Information")) {
                            querycheck = querycheck + " and upper(assignedto) in (select up.userid from userproject up, users us  where up.pid in (select pid from project pp where upper(pp.pname) = " + newProduct + " ) and us.userid=up.userid and us.EMAIL like '%eminentlabs.net')";
                            count++;
                        } else {

                            querycheck = querycheck + " and upper(assignedto) in (select up.userid from userproject up, users us  where up.pid in(select pid from project pp where (upper(pp.pname) = " + newProduct + ") and (pp.VERSION = " + newversion + ")) and us.userid=up.userid and us.EMAIL like '%eminentlabs.net')";
                            count++;
                        }

                    } else if (assignedto.contains("-TEAM")) {
                        querycheck = querycheck + " and (upper(assignedto) in (select userid from users where upper(to_char(team))  =" + assignedto.split("-")[0] + "' and roleid>0))";
                        count++;
                    } else {
                        querycheck = querycheck + " and (upper(assignedto) = " + assignedto.trim() + ")";
                        count++;
                    }
                }
                String updateFilterQuery = "";
                updatedby = updatedby.trim();
                if (!(updatedby.equalsIgnoreCase("All Information")) && !(updatedby.equals(null)) && !(updatedby.equals(""))) {
                    if (updatedbyList.contains("CLIENT USERS")) {

                        if (version.equalsIgnoreCase("All Information")) {

                            updateFilterQuery = "  upper(to_char(commentedby)) in (select up.userid from userproject up, users us  where up.pid in (select pid from project pp where upper(pp.pname) = " + newProduct + " ) and us.userid=up.userid and us.EMAIL not like '%eminentlabs.net')";
                        } else {

                            updateFilterQuery = "  upper(to_char(commentedby)) in (select up.userid from userproject up, users us  where up.pid in(select pid from project pp where upper(pp.pname) = " + newProduct + " and pp.VERSION = " + newversion + ") and us.userid=up.userid and us.EMAIL not like '%eminentlabs.net')";
                        }

                    } else if (updatedbyList.contains("INTERNAL USERS")) {
                        if (version.equalsIgnoreCase("All Information")) {
                            updateFilterQuery = "  upper(to_char(commentedby)) in (select up.userid from userproject up, users us  where up.pid in (select pid from project pp where upper(pp.pname) = " + newProduct + " ) and us.userid=up.userid and us.EMAIL like '%eminentlabs.net')";
                        } else {
                            updateFilterQuery = "  upper(to_char(commentedby)) in (select up.userid from userproject up, users us  where up.pid in(select pid from project pp where (upper(pp.pname) = " + newProduct + ") and (pp.VERSION = " + newversion + ")) and us.userid=up.userid and us.EMAIL like '%eminentlabs.net')";
                        }

                    } else if (updatedby.contains("-TEAM")) {
                        updateFilterQuery = "  (upper(to_char(commentedby)) in (select userid from users where upper(to_char(team))  =" + updatedby.split("-")[0] + "' and roleid>0))";
                    } else {
                        updateFilterQuery = "  (upper(to_char(commentedby)) = " + updatedby.trim() + ")";
                    }
                }
                if (!(createdby.equalsIgnoreCase("All Information")) && !(createdby.equals(null)) && !(createdby.equals(""))) {
                    querycheck = querycheck + " and (upper(createdby) =  " + createdby.trim() + ")";
                    count++;
                }
                if (!(type.equalsIgnoreCase("All Information")) && !(type.equals(null)) && !(type.equals(""))) {
                    querycheck = querycheck + " and (upper(type) = " + type.trim() + ")";
                    count++;
                }
                if (!(crid.equalsIgnoreCase("All Information")) && !(crid.equals(null)) && !(crid.equals(""))) {
                    querycheck = querycheck + " and upper(crid)= '" + crid.trim() + "' and i.issueid =c.issueid";
                    query1 = "select distinct i.issueid, pname as project,module, subject, i.description, priority, severity, type, createdon, due_date, modifiedon,createdby,assignedto,s.status,rating,feedback  from issue i,issuestatus s, project p, modules m,apm_sap_crid c" + extendedQueryc;
                    count++;
                }
                if (!(date.equalsIgnoreCase("All Information")) && !(date.equals(null)) && !(date.equals(""))) {
                    String dat, month, year;
                    if (!createdOption.equalsIgnoreCase("Today")) {
                        dat = date.substring(0, date.indexOf("-"));
                        month = date.substring(date.indexOf("-") + 1, date.lastIndexOf("-"));
                        year = date.substring(date.lastIndexOf("-") + 3, (date.lastIndexOf("-") + 5));
                        java.util.Date data = sdfInput.parse(date);
                        date = sdfOutput.format(data);
                    }
                    if (createdOption.equalsIgnoreCase("After")) {
                        querycheck = querycheck + " and  (to_date(to_char(createdon, 'DD-Mon-YYYY'),'DD-Mon-YY')>'" + date + "')";
                    } else if (createdOption.equalsIgnoreCase("Before")) {
                        querycheck = querycheck + " and  (to_date(to_char(createdon, 'DD-Mon-YYYY'),'DD-Mon-YY')<'" + date + "')";
                    } else if (createdOption.equalsIgnoreCase("Between")) {
                        createdfrom = sdfOutput.format(sdfInput.parse(createdfrom));
                        createdto = sdfOutput.format(sdfInput.parse(createdto));
                        querycheck = querycheck + " and  (to_date(to_char(createdon, 'DD-Mon-YYYY'),'DD-Mon-YY') between '" + createdfrom + "' and '" + createdto + "')";
                    } else if (createdOption.equalsIgnoreCase("Today")) {
                        querycheck = querycheck + " and  (to_char(createdon, 'DD-Mon-YY')=(SELECT TO_CHAR(SYSDATE, 'DD-Mon-YY') FROM DUAL))";
                    } else {
                        querycheck = querycheck + " and  (to_char(createdon, 'DD-Mon-YY')='" + date + "')";
                    }

                    count++;
                }

                if (!(duedate.equalsIgnoreCase("All Information")) && !(duedate.equals(null)) && !(duedate.equals(""))) {
                    String dat, month, year;
                    if (!duedateOption.equalsIgnoreCase("Today")) {
                        dat = duedate.substring(0, duedate.indexOf("-"));
                        month = duedate.substring(duedate.indexOf("-") + 1, duedate.lastIndexOf("-"));
                        year = duedate.substring(duedate.lastIndexOf("-") + 3, (duedate.lastIndexOf("-") + 5));
                        java.util.Date data = sdfInput.parse(duedate);
                        duedate = sdfOutput.format(data);
                    }
                    if (duedateOption.equalsIgnoreCase("After")) {
                        querycheck = querycheck + " and  (to_date(to_char(due_date, 'DD-Mon-YYYY'),'DD-Mon-YY')>'" + duedate + "')";
                    } else if (duedateOption.equalsIgnoreCase("Before")) {
                        querycheck = querycheck + " and  (to_date(to_char(due_date, 'DD-Mon-YYYY'),'DD-Mon-YY')<'" + duedate + "')";
                    } else if (duedateOption.equalsIgnoreCase("Between")) {

                        duedatefrom = sdfOutput.format(sdfInput.parse(duedatefrom));
                        duedateto = sdfOutput.format(sdfInput.parse(duedateto));
                        querycheck = querycheck + " and  (to_date(to_char(due_date, 'DD-Mon-YYYY'),'DD-Mon-YY') between '" + duedatefrom + "' and '" + duedateto + "')";
                    } else if (duedateOption.equalsIgnoreCase("Today")) {
                        logger.info("In Due date today");
                        querycheck = querycheck + " and  (to_char(due_date, 'DD-Mon-YY')=(SELECT TO_CHAR(SYSDATE, 'DD-Mon-YY') FROM DUAL))";
                    } else {
                        querycheck = querycheck + " and  (to_char(due_date, 'DD-Mon-YY')='" + duedate + "')";
                    }
                    count++;
                }
                if (!(updatedby.equalsIgnoreCase("All Information")) && !(updatedby.equals(null)) && !(updatedby.equals(""))) {

                    if (!(modifiedon.equalsIgnoreCase("All Information")) && !(modifiedon.equals(null)) && !(modifiedon.equals(""))) {
                        //  querycheck=querycheck+" and i.issueid in (select distinct c.issueid from issuecomments c where commentedby='"+updatedby+"' and  (to_char(comment_date, 'DD-Mon-YY'))='"+modifiedon+"')";
//System.out.println(updateFilterQuery);
                        String dat, month, year;
                        if (!modifiedOption.equalsIgnoreCase("Today")) {
                            dat = modifiedon.substring(0, modifiedon.indexOf("-"));
                            month = modifiedon.substring(modifiedon.indexOf("-") + 1, modifiedon.lastIndexOf("-"));
                            year = modifiedon.substring(modifiedon.lastIndexOf("-") + 3, (modifiedon.lastIndexOf("-") + 5));
                            java.util.Date data = sdfInput.parse(modifiedon);
                            modifiedon = sdfOutput.format(data);
                        }
                        if (modifiedOption.equalsIgnoreCase("After")) {
                            querycheck = querycheck + " and i.issueid in (select distinct c.issueid from issuecomments c where ( " + updateFilterQuery + ") and  (to_Date(to_char(comment_date, 'DD-Mon-YYYY'),'DD-Mon-YY'))>to_Date('" + modifiedon + "','DD-Mon-YY'))";
                        } else if (modifiedOption.equalsIgnoreCase("Before")) {
                            querycheck = querycheck + " and i.issueid in (select distinct c.issueid from issuecomments c where ( " + updateFilterQuery + ") and  (to_Date(to_char(comment_date, 'DD-Mon-YYYY'),'DD-Mon-YY'))<to_Date('" + modifiedon + "','DD-Mon-YY'))";
                        } else if (modifiedOption.equalsIgnoreCase("Between")) {
                            updatedfrom = sdfOutput.format(sdfInput.parse(updatedfrom));
                            updatedto = sdfOutput.format(sdfInput.parse(updatedto));
                            querycheck = querycheck + " and i.issueid in (select distinct c.issueid from issuecomments c where (" + updateFilterQuery + ") and  (to_Date(to_char(comment_date, 'DD-Mon-YYYY'),'DD-Mon-YY')) between to_Date('" + updatedfrom + "','DD-Mon-YY') and to_Date('" + updatedto + "','DD-Mon-YY'))";
                        } else if (modifiedOption.equalsIgnoreCase("Today")) {
                            querycheck = querycheck + " and  i.issueid in (select distinct c.issueid from issuecomments c where ( " + updateFilterQuery + ") and to_Date(to_char(comment_date, 'DD-Mon-YYYY'),'DD-Mon-YY')=to_Date(TO_CHAR(SYSDATE, 'DD-Mon-YYYY'),'DD-Mon-YY'))";
                        } else {
                            querycheck = querycheck + " and  i.issueid in (select distinct c.issueid from issuecomments c where ( " + updateFilterQuery + ") and (to_Date(to_char(comment_date, 'DD-Mon-YYYY'),'DD-Mon-YY'))=to_Date('" + modifiedon + "','DD-Mon-YY'))";
                        }
                    } else {
                        querycheck = querycheck + " and  i.issueid in (select distinct c.issueid from issuecomments c where ( " + updateFilterQuery + "))";
                    }
                    count++;
                } else {
                    if (!(modifiedon.equalsIgnoreCase("All Information")) && !(modifiedon.equals(null)) && !(modifiedon.equals(""))) {
                        String dat, month, year;
                        if (!modifiedOption.equalsIgnoreCase("Today")) {
                            dat = modifiedon.substring(0, modifiedon.indexOf("-"));
                            month = modifiedon.substring(modifiedon.indexOf("-") + 1, modifiedon.lastIndexOf("-"));
                            year = modifiedon.substring(modifiedon.lastIndexOf("-") + 3, (modifiedon.lastIndexOf("-") + 5));
                            java.util.Date data = sdfInput.parse(modifiedon);
                            modifiedon = sdfOutput.format(data);
                        }

                        if (modifiedOption.equalsIgnoreCase("After")) {
                            querycheck = querycheck + " and  (to_date(to_char(modifiedon, 'DD-Mon-YYYY'),'DD-Mon-YY')>'" + modifiedon + "')";
                        } else if (modifiedOption.equalsIgnoreCase("Before")) {
                            querycheck = querycheck + " and  (to_date(to_char(modifiedon, 'DD-Mon-YYYY'),'DD-Mon-YY')<'" + modifiedon + "')";
                        } else if (modifiedOption.equalsIgnoreCase("Between")) {
                            updatedfrom = sdfOutput.format(sdfInput.parse(updatedfrom));
                            updatedto = sdfOutput.format(sdfInput.parse(updatedto));
                            querycheck = querycheck + " and  (to_date(to_char(modifiedon, 'DD-Mon-YYYY'),'DD-Mon-YY') between '" + updatedfrom + "' and '" + updatedto + "')";
                        } else if (modifiedOption.equalsIgnoreCase("Today")) {
                            querycheck = querycheck + " and  (to_char(modifiedon, 'DD-Mon-YY')=(SELECT TO_CHAR(SYSDATE, 'DD-Mon-YY') FROM DUAL))";
                        } else {
                            querycheck = querycheck + " and  (to_char(modifiedon, 'DD-Mon-YY')='" + modifiedon + "')";
                        }
                        count++;
                    }
                }
                if (!(subject.equalsIgnoreCase("All Information")) && !(subject.equals(null)) && !(crid.equals(""))) {
                    querycheck = querycheck + " and (upper(i.subject) like '%" + subject.trim() + "%' or upper(i.description) like '%" + subject.trim() + "%' or upper(i.rootcause) like '%" + subject.trim() + "%' or upper(i.expected_result) like '%" + subject.trim() + "%')";
                    count++;
                }
                querycheck = querycheck + extendedQueryd;
                if (wrmSelector.equals("2")) {
                    querycheck = querycheck + " and i.issueid not in(select issueid from WRM_ISSUES)";
                } else if (wrmSelector.equals("4")) {
                    querycheck = querycheck + " and i.ESCALATION='yes' ";
                    count++;
                } else if (wrmSelector.equals("5")) {
                    querycheck = querycheck + " and i.issueid in(select issue_id from agreed_issues where status=0 and issue_type='Agreed' and project_id in (select p.pid from project p, userproject up where p.pid = up.pid and userid = " + userId + ") )";
                    count++;

                } else if (wrmSelector.equals("6")) {
                    querycheck = querycheck + " and i.issueid not in(select issue_id from agreed_issues where status=0 and issue_type='Agreed' and project_id in (select p.pid from project p, userproject up where p.pid = up.pid and userid = " + userId + ") )";
                    count++;

                } else {
                    if (!wrmSelector.equals("") && !wrmSelector.equals("1") && !wrmSelector.equals("3")) {
                        querycheck = querycheck + " and i.issueid in(select issue_id from agreed_issues where status=0 and issue_type='" + wrmSelector + "'  and project_id in (select p.pid from project p, userproject up where p.pid = up.pid and userid = " + userId + ") )";
                        count++;
                    }
                }

                if ((roleId != 1) && (count == 0)) {
                    query1 = query1 + " where i.issueid = s.issueid   and i.pid = p.pid and m.moduleid=i.module_id  and p.pid in (select p.pid from project p, userproject up where p.pid = up.pid and userid = " + userId + ") order by due_date asc, modifiedon asc, type asc, priority asc, severity asc, createdon asc";
                } else if ((roleId != 1) && (count != 0)) {

                    query1 = query1 + " where i.issueid = s.issueid  and i.pid = p.pid and m.moduleid=i.module_id  and p.pid in (select p.pid from project p, userproject up where p.pid = up.pid and userid = " + userId + ") " + querycheck + " order by due_date asc, modifiedon asc, type asc, priority asc, severity asc, createdon asc";

                } else {
                    query1 = query1 + " where i.issueid = s.issueid  and i.pid = p.pid and m.moduleid=i.module_id   " + querycheck + " order by due_date asc, modifiedon asc, type asc, priority asc, severity asc, createdon asc";
                }
                if (wrmSelector.equals("1")) {
                    query1 = "select i.issueid, i.project ,i.module, i.subject, i.description, i.priority, i.severity, i.type, i.createdon, i.due_date, i.modifiedon,i.createdby,i.assignedto,i.status,i.rating,i.feedback from (select issueid as wrmissue from  WRM_Issues) w, (" + query1 + ")i where  w.wrmissue =i.issueid order by due_date asc, modifiedon asc, type asc, priority asc, severity asc, createdon asc";
                } else if (wrmSelector.equals("3")) {
                    query1 = "select i.issueid, i.project ,i.module, i.subject, i.description, i.priority, i.severity, i.type, i.createdon, i.due_date, i.modifiedon,i.createdby,i.assignedto,i.status,i.rating,i.feedback from (select * from ((select Distinct(SUBSTR(task,0,12)) as issue from mom_user_task where type='Issue' and tasktime='Planned' and to_char(momdate,'dd-Mon-yyyy') = to_char(SYSDATE,'dd-Mon-yyyy')) INTERSECT (select distinct(ISSUEID) from PROJECT_PLANNED_ISSUE where to_char(PLANNEDON,'dd-MON-yy') = to_char(SYSDATE,'dd-MON-yy') and STATUS='Active'))) pi, (" + query1 + ")i where   pi.ISSUE =i.issueid order by module,due_date asc, modifiedon asc, type asc, priority asc, severity asc, createdon asc";
                }
                String issueHisory = request.getParameter("issueHistory");
                String issueRating = request.getParameter("issueRating");
                session.setAttribute("IssueSummaryQuery", query1);
                session.setAttribute("issueHistory", issueHisory);
                session.setAttribute("issueRating", issueRating);
            %> <jsp:forward page="IssueSummaryView.jsp" />
            </body>
            </html>
<%@ page buffer="50kb"%>
<%@ page import="org.apache.log4j.*,pack.eminent.encryption.*"%>
<!doctype html public "-//W3C//DTD HTML 4.0 Transitional//EN">
<%

    Logger logger = Logger.getLogger("MyQueryEdit");

    String logoutcheck = (String) session.getAttribute("Name");
    if (logoutcheck == null) {
        logger.fatal("=========================Session Expired======================");
%>
<jsp:forward page="../SessionExpired.jsp"></jsp:forward>
<%
    }
%>
<html>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
    <title>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS
        Solution</title>
    <meta name="Generator" content="EditPlus">
    <meta name="Author" content="">
    <meta name="Keywords" content="">
    <meta name="Description" content="">
    <META content=0 http-equiv=Expires>
    <META content=no-cache http-equiv=Pragma>
    <META content=no-cache http-equiv=Cache-Control>
    <LINK title=STYLE href="<%= request.getContextPath()%>/eminentech support files/main_ie.css" type="text/css" rel=STYLESHEET>
</head>

<body bgcolor="#FFFFFF">
    <FORM name="theForm" METHOD="POST" ACTION="MyQuerySave.jsp">
        <%@ page import="java.sql.*,java.util.*"%>
        <%@ include file="../header.jsp"%>
        <%!
            Connection connection;

            ResultSet rs9;
            Statement stmt9;
        %> <%
            String COLUMN_ARRAY = "COLUMN_ARRAY";
            String VALUE_ARRAY = "VALUE_ARRAY";
            HashMap<String, ArrayList> separatedTokensHashMap = new HashMap<String, ArrayList>();
            String query_string = "";
            String query_name = "";
            String description = "";
            String customers = "All Information";
            String products = "All Information";
            String versions = "All Information";
            String modules = "All Information";
            String platforms = "All Information";
            String severitys = "All Information";
            String prioritys = "All Information";
            String createdbys = "All Information";
            String assignedtos = "All Information";
            String types = "All Information";
            String statuss = "All Information";
            String createdons = "All Information";
            String modifiedons = "All Information";
            String fixversions = "All Information";
            String crids = "All Information";
            String duedates = "All Information";
            String qryToSplit = "";
            String updatedbys = "All Information";
            String wrmSearch = "All Information";
            String subject = "All Information";
            String component = "All Information";
            String rating = "All Information";
            String issueRating = "no";
            try {
                ArrayList<String> nameList = new ArrayList<String>();
                ArrayList<String> valueList = new ArrayList<String>();
                int query_id = Integer.parseInt(request.getParameter("query_id"));
                connection = MakeConnection.getConnection();

                stmt9 = connection.createStatement();
                rs9 = stmt9.executeQuery("select NAME,QUERY_STRING,DESCRIPTION,ISSUERATING from MYQUERY where query_id =" + query_id);
                if (rs9 != null) {
                    rs9.next();
                    query_string = rs9.getString("query_string").trim();
                    query_name = rs9.getString("name").trim();
                    description = rs9.getString("description").trim();
                    if (rs9.getString("ISSUERATING") != null) {
                        issueRating = rs9.getString("ISSUERATING");
                    }
                    session.setAttribute("query_name", query_name);
                    session.setAttribute("description", description);
                    session.setAttribute("query_id", query_id);
                    qryToSplit = query_string;//.toUpperCase();
                    String strWhere = "where";
                    int whereIndex = qryToSplit.indexOf(strWhere);
                    int indexToScan = whereIndex + strWhere.length() + 1;
                    qryToSplit = qryToSplit.substring(indexToScan);
                    String tokenArray[] = qryToSplit.split("and");
                    String tokenToSeparate = "=";
                    String tokenToSeparate1 = "like";
                    String tokenToSeparate2 = ">";
                    String tokenToSeparate3 = "between";
                    String tokenToSeparate4 = "<";

                    String token = "";
                    int j = 0;

                    for (j = 0; j < tokenArray.length; j++) {
                        token = tokenArray[j];
                        if (token.contains(tokenToSeparate)) {
                            nameList.add(j, token.split(tokenToSeparate)[0].trim());
                            valueList.add(j, token.split(tokenToSeparate)[1].trim());
                        } else if (token.contains(tokenToSeparate1)) {
                            nameList.add(j, token.split(tokenToSeparate1)[0].trim());
                            valueList.add(j, token.split(tokenToSeparate1)[1].trim());

                        } else if (token.contains(tokenToSeparate2)) {
                            nameList.add(j, token.split(tokenToSeparate2)[0].trim());
                            valueList.add(j, "After" + token.split(tokenToSeparate2)[1].trim());

                        } else if (token.contains(tokenToSeparate4)) {
                            nameList.add(j, token.split(tokenToSeparate4)[0].trim());
                            valueList.add(j, "Before" + token.split(tokenToSeparate4)[1].trim());

                        } else {
                            if (query_string.contains(tokenToSeparate3)) {
                                nameList.add(j, token.split(tokenToSeparate3)[0].trim());
                                valueList.add(j, query_string.split(tokenToSeparate3)[1].trim());
                            }
                        }
                    }
                    //            token=tokenArray[j];
                    //          nameList.add(j,token.split(tokenToSeparate1)[0].trim());
                    //        valueList.add(j,token.split(tokenToSeparate1)[1].trim());

                    if (nameList.size() > 0) {
                        separatedTokensHashMap.put(COLUMN_ARRAY, nameList);
                    }
                    if (valueList.size() > 0) {
                        separatedTokensHashMap.put(VALUE_ARRAY, valueList);
                    }
                    String s = "";
                    //    String checks="select * from issue, issuestatus  where issue.issueid=issuestatus.issueid";

                    for (int i = 0; i < tokenArray.length; i++) {
                        if (nameList.get(i).contains("(upper(customer)")) {
                            s = valueList.get(i).toString();

                            customers = s.replaceAll("[^a-zA-Z-]", "").toLowerCase().trim();
                        }
                        if (nameList.get(i).contains("upper(pname)")) {
                            s = valueList.get(i).toString();
                            products = s.replaceAll("[^a-zA-Z-]", "").trim();
                        }
                        if (nameList.get(i).contains("upper(found_version)")) {
                            s = valueList.get(i).toString();
                            versions = s.replaceAll("[^0-9.]", "").trim();
                        }
                        if (nameList.get(i).contains("upper(version)")) {
                            s = valueList.get(i).toString();
                            fixversions = s.replaceAll("[^0-9.]", "").trim();
                        }
                        if (nameList.get(i).contains("upper(platform)")) {
                            s = valueList.get(i).toString();
                            platforms = s.replaceAll("[^a-zA-Z-]", "").toLowerCase().trim();
                        }
                        if (nameList.get(i).contains("upper(m.module)")) {
                            s = valueList.get(i).toString();
                            modules = s.replaceAll("[^a-zA-Z-]", "").trim();
                        }
                        if (nameList.get(i).contains("upper(severity)")) {
                            s = valueList.get(i).toString();
                            severitys = s.replaceAll("[^a-zA-Z0-9- ]", "").trim();
                        }
                        if (nameList.get(i).contains("upper(rating)")) {
                            s = valueList.get(i).toString();
                            if (s.contains(") order by due_date asc, modifiedon asc, type asc, priority asc, severity asc, createdon asc")) {
                                s = s.replace(") order by due_date asc, modifiedon asc, type asc, priority asc, severity asc, createdon asc", "");
                            }
                            rating = s.replaceAll("[^a-zA-Z ]", "").trim();
                        }
                        if (nameList.get(i).contains("upper(priority)")) {
                            s = valueList.get(i).toString();
                            prioritys = s.replaceAll("[^a-zA-Z0-9-]", "").trim();
                        }
                        if (nameList.get(i).equals("(upper(s.status)")) {
                            s = valueList.get(i).toString();
                            statuss = s.replaceAll("[^a-zA-Z-]", "").toLowerCase().trim();
                        }
                        if (nameList.get(i).equals("upper(s.status)!")) {
                            statuss = "Open Issues";
                        }
                        if (nameList.get(i).contains("upper(assignedto)")) {
                            s = valueList.get(i).toString();
                            assignedtos = s.replaceAll("[^0-9]", "").trim();
                        }
                        if (nameList.get(i).contains("(upper(assignedto) in (select userid from users where upper(to_char(team))")) {
                            s = valueList.get(i).replace(")) order by due_date asc, modifiedon asc, type asc, priority asc, severity asc, createdon asc", "");
                            assignedtos = s.replaceAll("[^A-Z]", "").trim();
                        }
                        if (nameList.get(i).contains("upper(createdby)")) {
                            s = valueList.get(i).toString();
                            createdbys = s.replaceAll("[^0-9]", "").trim();
                        }
                        if (nameList.get(i).contains("upper(type)")) {
                            s = valueList.get(i).toString();
                            types = s.replaceAll("[^a-zA-Z-]", "").trim();
                        }
                        if (nameList.get(i).contains("(to_char(createdon, 'DD-Mon-YY')")) {
                            s = valueList.get(i).toString();
                            if (s.contains("SYSDATE")) {
                                createdons = "Today";
                            } else {
                                createdons = s.substring(1, 10);
                            }
                        }
                        if (nameList.get(i).contains("(to_date(to_char(createdon, 'DD-Mon-YYYY'),'DD-Mon-YY')")) {
                            s = valueList.get(i).toString();
                            s = s.replaceAll("[^a-zA-Z0-9-]", "");
                            if (s.contains("After")) {
                                createdons = s.substring(0, 14);
                            } else if (s.contains("Before")) {
                                createdons = s.substring(0, 14);
                            } else {
                                createdons = "Bt" + s.substring(0, 21);
                            }
                        }
                        if (nameList.get(i).contains("(to_char(modifiedon, 'DD-Mon-YY')") || nameList.get(i).contains("(to_Date(to_char(modifiedon, 'DD-Mon-YYYY'),'DD-Mon-YY'))")) {
                            s = valueList.get(i).toString();
                            if (s.contains("SYSDATE")) {
                                modifiedons = "Today";
                            } else {
                                modifiedons = s.substring(1, 10);
                            }
                        }
                        if (nameList.get(i).contains("(to_date(to_char(modifiedon, 'DD-Mon-YYYY'),'DD-Mon-YY')") || nameList.get(i).contains("(to_Date(to_char(comment_date, 'DD-Mon-YYYY'),'DD-Mon-YY'))")) {
                            s = valueList.get(i).toString();
                            s = s.replaceAll("[^a-zA-Z0-9-]", "");
                            s = s.replace("toDate", "");
                            if (s.contains("After")) {
                                modifiedons = s.substring(0, 14);

                            } else if (s.contains("Before")) {
                                modifiedons = s.substring(0, 14);
                            } else if (s.contains("and")) {
                                s = s.replace("DD-Mon-YY", "");
                                modifiedons = "Bt" + s.substring(0, 21);
                            } else {
                                modifiedons = s.substring(0, 10);
                            }
                        }
                        if (nameList.get(i).contains("(to_char(modifiedon, 'DD-Mon-YY')") || nameList.get(i).contains("(to_Date(to_char(modifiedon, 'DD-Mon-YYYY'),'DD-Mon-YY'))")) {
                            s = valueList.get(i).toString();
                            s = s.replaceAll("[^a-zA-Z0-9-]", "");
                            s = s.replace("toDate", "");

                            if (s.contains("After")) {
                                modifiedons = s.substring(0, 14);

                            } else if (s.contains("Before")) {
                                modifiedons = s.substring(0, 14);
                            } else if (s.contains("and")) {
                                s = s.replace("DD-Mon-YY", "");
                                modifiedons = "Bt" + s.substring(0, 21);
                            } else {
                                modifiedons = s.substring(0, 10);
                            }
                        }
                        if (nameList.get(i).contains("upper(crid)")) {
                            s = valueList.get(i).toString();
                            crids = s.replaceAll("[^a-zA-Z0-9-]", "").trim();
                        }
                        if (nameList.get(i).contains("(to_char(due_date, 'DD-Mon-YY')")) {
                            s = valueList.get(i).toString();
                            if (s.contains("SYSDATE")) {
                                duedates = "Today";
                            } else {
                                duedates = s.substring(1, 10);
                            }
                        }
                        if (nameList.get(i).contains("(to_date(to_char(due_date, 'DD-Mon-YYYY'),'DD-Mon-YY')")) {
                            s = valueList.get(i).toString();
                            s = s.replaceAll("[^a-zA-Z0-9-]", "");
                            if (s.contains("After")) {
                                duedates = s.substring(0, 14);
                            } else if (s.contains("Before")) {
                                duedates = s.substring(0, 14);
                            } else {
                                duedates = "Bt" + s.substring(0, 21);
                            }
                        }

                        if (nameList.get(i).contains("i.issueid in (select distinct c.issueid from issuecomments c where (commentedby") || nameList.get(i).equalsIgnoreCase("i.issueid in (select distinct c.issueid from issuecomments c where (   (upper(to_char(commentedby))")) {
                            s = valueList.get(i).toString();
                            updatedbys = s.replaceAll("[^0-9]", "").toLowerCase().trim();
                        }
                        if (nameList.get(i).contains("i.issueid in (select distinct c.issueid from issuecomments c where (  (upper(to_char(commentedby)) in (select userid from users where upper(to_char(team))") || nameList.get(i).equalsIgnoreCase("i.issueid in (select distinct c.issueid from issuecomments c where (   (upper(to_char(commentedby)) in (select userid from users where upper(to_char(team))") || nameList.get(i).contains("i.issueid in (select distinct c.issueid from issuecomments c where (   (upper(to_char(commentedby)) in (select userid from users where upper(to_char(team))")) {
                            s = valueList.get(i).replace(")) order by due_date asc, modifiedon asc, type asc, priority asc, severity asc, createdon asc", "");
                            updatedbys = s.replaceAll("[^A-Z]", "").trim();

                        }
                        if (nameList.get(i).equals("i.issueid not in(select issueid from WRM_ISSUES)")) {
                            wrmSearch = "2";
                        }
                        if (nameList.get(i).equals("to_char(momdate,'dd-Mon-yyyy')")) {
                            wrmSearch = "3";
                        }
                        if (nameList.get(i).equals("i.ESCALATION")) {
                            wrmSearch = "4";
                        }
                        if (nameList.get(i).equals("issue_type")) {
                            s = valueList.get(i).toString();
                            wrmSearch = s.replaceAll("[^a-zA-Z0-9-]", "").toLowerCase().trim();
                            if (s.equals("agreed")) {
                                wrmSearch = "5";
                            }
                        }

                        if (nameList.get(i).equals("i.issueid not in(select issue_id from agreed_issues where status")) {
                            wrmSearch = "6";
                        }

                        if (nameList.get(i).equals("(upper(i.subject)")) {
                            s = valueList.get(i).toString();
                            subject = s.substring(s.indexOf("%") + 1, s.lastIndexOf("%"));
                        }
                        if (nameList.get(i).equals("(ci.COMPONENT_ID")) {
                            s = valueList.get(i).toString();
                            component = s.replaceAll("[^0-9]", "").trim();
                        }

                    }
                    if (query_string.contains("w.wrmissue =i.issueid")) {
                        wrmSearch = "1";
                    }

                    nameList.clear();
                    valueList.clear();
                    for (int i = 0; i < nameList.size(); i++) {
                        nameList.remove(i);
                        valueList.remove(i);
                    }
                }

                if (rs9 != null) {
                    rs9.close();
                }
                if (stmt9 != null) {
                    stmt9.close();
                }
                String all = "All Information";
            } catch (Exception e) {
                e.printStackTrace();
                logger.error(e.getMessage());
            } finally {
                if (connection != null) {
                    connection.close();
                }
            }

        %> <jsp:forward page="../IssueSummary/IssueSummary.jsp">
            <jsp:param name="product" value="<%=products%>" />
            <jsp:param name="customer" value="<%=customers%>" />
            <jsp:param name="version" value="<%=versions%>" />
            <jsp:param name="fixversion" value="<%=fixversions%>" />
            <jsp:param name="platform" value="<%=platforms%>" />
            <jsp:param name="module" value="<%=modules%>" />
            <jsp:param name="priority" value="<%=prioritys%>" />
            <jsp:param name="severity" value="<%=severitys%>" />
            <jsp:param name="issuestatus" value="<%=statuss%>" />
            <jsp:param name="type" value="<%=types%>" />
            <jsp:param name="assignedto" value="<%=assignedtos%>" />
            <jsp:param name="createdby" value="<%=createdbys%>" />
            <jsp:param name="updatedby" value="<%=updatedbys%>" />
            <jsp:param name="date" value="<%=createdons%>" />
            <jsp:param name="modifiedon" value="<%=modifiedons%>" />
            <jsp:param name="crid" value="<%=crids%>" />
            <jsp:param name="duedate" value="<%=duedates%>" />
            <jsp:param name="oldSearch" value="oldsearch" />
            <jsp:param name="flag" value="true" />
            <jsp:param name="wrmSearch" value="<%=wrmSearch%>" />
            <jsp:param name="subject" value="<%=subject%>" />
            <jsp:param name="component" value="<%=component%>" />
            <jsp:param name="rating" value="<%=rating%>" />
            <jsp:param name="issueRating" value="<%=issueRating%>" />

        </jsp:forward></FORM>
</body>
</html>
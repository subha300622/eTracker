<%-- 
    Document   : getWrmIssues
    Created on : Aug 14, 2014, 4:12:23 PM
    Author     : E0288
--%>

<%@page import="com.eminentlabs.mom.TeamWiseMom"%>
<%@page import="com.eminent.issue.formbean.IssueFormBean"%>
<%@page import="com.eminent.issue.formbean.PlannedIssueReport"%>
<%@page import="com.eminentlabs.mom.ApmWrmPlan"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="com.eminentlabs.mom.MoMUtil"%>
<%@page import="com.eminentlabs.mom.MomForClient"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="twm" class="com.eminentlabs.mom.TeamWiseMom"></jsp:useBean>

<%
    String momClientId = request.getParameter("momClientId");
    int mClientId = MoMUtil.parseInteger(momClientId, 0);
    List<ApmWrmPlan> wrmPlanList = new ArrayList();
    String res = "";
    if (mClientId != 0) {
        MomForClient mfc = twm.findByMomClientId(mClientId);
        wrmPlanList = twm.findByWRMDayAndPId(mfc.getPid(), mfc.getHeldOn());
        List<String> issueList = new ArrayList();

        for (ApmWrmPlan apmWrmPlan : wrmPlanList) {
            if (apmWrmPlan.getStatus().equalsIgnoreCase("Active")) {
                issueList.add(apmWrmPlan.getIssueid().trim());
            }
        }
        PlannedIssueReport pir = new PlannedIssueReport();

        if (issueList.size() > 0) {
            List<IssueFormBean> wrmplanIssueDetails = pir.getIssuesDetail(issueList);
            List<IssueFormBean> additionalClosedIssueDetails = new ArrayList();
            List<IssueFormBean> additionalClosedIssueDetailsa = new ArrayList();
            TeamWiseMom t = new TeamWiseMom();
            int wrmid = t.findMaxWRMDay(mfc.getPid());
            if (wrmid == mClientId) {
                additionalClosedIssueDetailsa = t.additionalClosed(mfc.getPid().toString(), wrmid);
                List<String> issuesClosed = new ArrayList<String>();
                for (IssueFormBean isfb : wrmplanIssueDetails) {
                    if (isfb.getRating() != null) {
                        issuesClosed.add(isfb.getIssueId());
                    }
                }
                for (IssueFormBean isfb : additionalClosedIssueDetailsa) {
                    if (!issuesClosed.contains(isfb.getIssueId())) {
                        additionalClosedIssueDetails.add(isfb);
                    }
                }
            }
            if (wrmplanIssueDetails.size() > 0) {
                res = "<td colspan='16'><font color='blue'>Issues Reviewed and Committed for Next Week</font></td></tr>"
                        + "<tr> <td colspan='16'><table style='width: 100%;' id='wrmAdditionalTable'" + mClientId + " class='tablesorter'><thead><tr>"
                        + "<TH class='header' width='12%'><font><b>Issue No</b></font></TH>"
                        + "<TH class='header' width='7%'><font><b>Module</b></font></TH>"
                        + "<TH class='header' width='28%'><font><b>Subject</b></font></TH>"
                        + "<th class='header'><font><b>Review Comments</b></font></th></tr></thead>";

                int k = 0;
                String rating = "", color = "";
                for (IssueFormBean isfb : wrmplanIssueDetails) {
                    k++;
                    if ((k % 2) == 0) {

                        res = res + "<tr bgcolor='#E8EEF7' height='23'>";
                    } else {

                        res = res + "<tr bgcolor='white' height='23'>";
                    }
                    rating = isfb.getRating();
                    color = "";
                    if (rating != null) {
                        if (rating.equalsIgnoreCase("Excellent")) {
                            color = "#336600";

                        } else if (rating.equalsIgnoreCase("Good")) {
                            color = "#33CC66";

                        } else if (rating.equalsIgnoreCase("Average")) {
                            color = "#CC9900";

                        } else if (rating.equalsIgnoreCase("Need Improvement")) {
                            color = "#CC0000";

                        }
                    }

                    res = res + "<td width='11%' title='" + isfb.getType() + "' bgcolor='" + color + "'><a target='_blank' href='" + request.getContextPath() + "/viewIssueDetails.jsp?issueid=" + isfb.getIssueId() + "'>" + isfb.getIssueId() + "</a></td>"
                            + "<td width='7%' title='" + isfb.getmName() + "'>" + isfb.getRedMName() + "</td>"
                            + "<td width='29%' id=" + isfb.getIssueId() + "tab" + "'" + " onmouseover=\"xstooltip_show('" + isfb.getIssueId() + "', '" + isfb.getIssueId() + "tab', '289', '49');\"  onmouseout=\"xstooltip_hide('" + isfb.getIssueId() + "');\" ><div class='issuetooltip' id=" + "'" + isfb.getIssueId() + "'" + ">" + isfb.getDescription() + "</div>" + isfb.getSubject() + "</td><td>";

                    String comments = null;
                    for (ApmWrmPlan awp : wrmPlanList) {
                        if (awp.getIssueid().equalsIgnoreCase(isfb.getIssueId())) {
                            comments = awp.getComments();
                        }
                    }
                    if (comments == null) {
                        comments = "";
                    }

                    res = res + comments + "</td></tr>";
                }

            }
            if (additionalClosedIssueDetails.size() > 0) {
                res = res + "<tr  id='test'><td colspan='16'><font color='blue' style='font-weight: bold;'>Additional Issues Closed</font></td></tr>"
                        + "<tr id='test1'><td colspan='16'><table style='width: 100%;' id='wrmPlanTable' class='tablesorter'><thead>  <tr>"
                        + "<TH class='header' width='12%'><font><b>Issue No</b></font></TH>"
                        + " <TH class='header' width='17%'><font><b>Module</b></font></TH>"
                        + "<TH class='header' width='68%'><font><b>Subject</b></font></TH> </tr></thead>";

                int p = 0;
                for (IssueFormBean isfb : additionalClosedIssueDetails) {
                    p++;
                    if ((p % 2) == 0) {
                        res = res + "<tr bgcolor='#E8EEF7' height='23'>";
                    } else {
                        res = res + "<tr bgcolor='white' height='23'>";
                    }
                    res = res + "<td width='11%' title='" + isfb.getType() + "' bgcolor='" + isfb.getRatingColor() + "'><a href='" + request.getContextPath() + "/viewIssueDetails.jsp?issueid=" + isfb.getIssueId() + "' target='_blank'>" + isfb.getIssueId() + "</a></td>"
                            + "<td width='7%' title='" + isfb.getmName() + "'>" + isfb.getRedMName() + "</td>"
                            + "<td width='29%' id='" + isfb.getIssueId() + "tab' onmouseover=\"xstooltip_show('" + isfb.getIssueId() + "', '" + isfb.getIssueId() + "tab', '289', '49');\"  onmouseout=\"xstooltip_hide('" + isfb.getIssueId() + "');\" ><div class='issuetooltip' id=" + "'" + isfb.getIssueId() + "'" + ">" + isfb.getDescription() + "</div>" + isfb.getSubject() + "</td></tr>";

                }
            }
            res = res + "</table></td></tr>";

        }
    }
    out.print(res);
%>
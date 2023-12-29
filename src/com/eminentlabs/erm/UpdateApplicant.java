/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminentlabs.erm;

import com.eminent.util.GetProjectMembers;
import com.eminent.util.SendMail;
import dashboard.CurrentDay;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.apache.log4j.Logger;

/**
 *
 * @author E0288
 */
public class UpdateApplicant {

    static Logger logger = Logger.getLogger("UpdateApplicant");

    public String updateApplicant(HttpServletRequest request) {
        String comments = request.getParameter("comments");
        HttpSession session = request.getSession();
        String applicantId = request.getParameter("applicantId");
        String statusId = request.getParameter("statusid");
        String assTo = request.getParameter("assignedto");
        int userId = (Integer) session.getAttribute("uid");
                String isFake =   request.getParameter("isfake");
        System.out.println("isFake : "+isFake);
        ERMUtil.addERMComments(comments, userId, Integer.parseInt(statusId), userId, applicantId, Integer.parseInt(assTo),Integer.parseInt(isFake));
        String name = request.getParameter("name");
        String location = request.getParameter("location");
        String grad = request.getParameter("grd");
        String grdYear = request.getParameter("gradyear");
        String percentage = request.getParameter("percentage");
        String areaofexpertise = request.getParameter("areaofexpertise");
        String sapyears = request.getParameter("sapyears");
        String sapmonths = request.getParameter("sapmonths");
        String totalyears = request.getParameter("totalyears");
        String totalmonths = request.getParameter("totalmonths");

        Map hm = ERMUtil.ermApplicantStatus();

        ArrayList<String> dateAndTime = CurrentDay.getDateTime();

        // Sending Mail to Gopal and Tamil
        String adminMail = "<table>"
                + "<tr>"
                + "<td colspan=4><b><font color=blue >Candidate Details</font></b></td>"
                + "</tr>"
                + "<tr bgcolor=#E8EEF7>"
                + "<td>Name</td><td>" + name + "</td>"
                + "<td>Location</td><td>" + location + "</td>"
                + "</tr>"
                + "<tr>"
                + "<td>Qualification</td><td>" + grad + "</td>"
                + "<td>Graduation Year</td><td>" + grdYear + "</td>"
                + "</tr>"
                + "<tr bgcolor=#E8EEF7>"
                + "<td>Percentage</td><td>" + percentage + "</td>"
                + "<td>Module</td><td>" + areaofexpertise + "</td>"
                + "</tr>"
                + "<tr  >"
                + "<td>SAP Experience</td><td>" + sapyears + "Y " + sapmonths + "M</td>"
                + "<td>Overall Experience</td><td>" + totalyears + "Y " + totalmonths + "M</td>"
                + "</tr>"
                + "<tr  bgcolor=#E8EEF7>"
                + "<td>Update By</td><td>" + GetProjectMembers.getUserName(((Integer) userId).toString()) + "</td>"
                + "<td>Assigned To</td><td>" + GetProjectMembers.getUserName(assTo) + "</td>"
                + "</tr>"
                + "<tr  >"
                + "<td>Status</td><td>" + hm.get(Integer.parseInt(statusId)) + "</td>"
                + "<td>Updated On</td><td>" + dateAndTime.get(0) + " " + dateAndTime.get(1) + "</td>"
                + "</tr>"
                + "<tr bgcolor=#E8EEF7 >"
                + "<td>Comments</td>"
                + "<td colspan=3>" + comments + "</td>"
                + "</tr>"
                + "</table>";
        String endLine = "</table><br>Thanks,";
        String signature = "<br>eTracker&trade;<br>";
        String emi = "<br><b><a href=http://www.eminentlabs.com/>SAP GST Accelerator from Eminentlabs&trade; </a>&nbsp;-&nbsp;Readiness for GST and Audit ready of GST Reports!</b></br><br>ERPDS&trade;, EWE&trade;, eTracker&trade;, eOutsource&trade;, Rightshore&trade;, KPITracker&trade; are registered trademarks of Eminentlabs&trade; Software Private Limited<br>";
        String lineBreak = "<br>";

        String htmlTableEnd = "<br>For further details log on to <a href=http://www.eminentlabs.com/eTracker/login.jsp target=_new>eTracker&trade;</a>";
        adminMail = adminMail + endLine + signature + htmlTableEnd + lineBreak + emi;
        String senderName = (String) session.getAttribute("fName") + " " + (String) session.getAttribute("lName");
        String content = "eTracker ERM " + hm.get(Integer.parseInt(statusId)) + ": " + applicantId;
        try {
            SendMail.ERMUpdation(senderName, adminMail, content, GetProjectMembers.getMail(assTo), GetProjectMembers.getMail(((Integer) userId).toString()));

        } catch (Exception e) {
            logger.error(e.getMessage());
        }

        return "";
    }
}

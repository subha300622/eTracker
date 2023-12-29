/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminentlabs.erm;

import com.eminent.customer.ContactUtil;
import com.eminent.util.UserIssueCount;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

/**
 *
 * @author E0288
 */
public class ErmMenu {
    
    private int myassignmentCount;
    
    private int myIssueCount;
    
    private int myViewsCount;
    
    private int myContactsCount;
    
    private String forwardPage;

    public int getMyassignmentCount() {
        return myassignmentCount;
    }

    public void setMyassignmentCount(int myassignmentCount) {
        this.myassignmentCount = myassignmentCount;
    }

    public int getMyIssueCount() {
        return myIssueCount;
    }

    public void setMyIssueCount(int myIssueCount) {
        this.myIssueCount = myIssueCount;
    }

    public String getForwardPage() {
        return forwardPage;
    }

    public void setForwardPage(String forwardPage) {
        this.forwardPage = forwardPage;
    }
    
     public static   ErmMenu getErmMenu(HttpServletRequest request){
         HttpSession session=request.getSession();
         Integer userId = (Integer)session.getAttribute("userid_curr");
         String user    = userId.toString();
         String email=(String)session.getAttribute("Name");
         Map<Integer,String> appcantStatuses=ERMUtil.ermApplicantStatus();
          ErmMenu ermMenu=new ErmMenu();
          int count=0;
          String applicantStatus="";
          int uId=Integer.valueOf(userId);
          ermMenu.setMyIssueCount(UserIssueCount.getOwnCount(user));
          ermMenu.setMyassignmentCount(ERMUtil.getAssignedApplicantCount(uId));
          ermMenu.setMyViewsCount(ERMUtil.getMyViews(request).size());
          ermMenu.setMyContactsCount(ContactUtil.getContactCount(user));
          Map<Integer,Integer> assignedToByStatus=ERMUtil.getAssignedApplicantByStaus(uId);
          for(Map.Entry<Integer,Integer> entry:assignedToByStatus.entrySet()){
             
             if(count<entry.getValue()){
                 count=entry.getValue();
                 applicantStatus=appcantStatuses.get(entry.getKey());
             }
          }
          if("".equals(applicantStatus)){
              applicantStatus=appcantStatuses.get(0);
          }
          ermMenu.setForwardPage("/eTracker/erm/assignedApplicants.jsp?applicantStatus="+applicantStatus);
          return ermMenu;
      }

    public int getMyViewsCount() {
        return myViewsCount;
    }

    public void setMyViewsCount(int myViewsCount) {
        this.myViewsCount = myViewsCount;
    }

    public int getMyContactsCount() {
        return myContactsCount;
    }

    public void setMyContactsCount(int myContactsCount) {
        this.myContactsCount = myContactsCount;
    }
    
    
}

<%-- 
    Document   : reviewMeeting
    Created on : Apr 28, 2014, 1:55:21 PM
    Author     : E0288
--%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.eminentlabs.mom.MomClientAttendies"%>
<%@page import="com.eminent.util.GetProjectMembers"%>
<%@page import="com.eminent.timesheet.Users"%>
<%@page import="java.util.List"%>
<%@page import="com.eminentlabs.mom.MomForClient"%>
<%@page import="com.eminentlabs.mom.MoMUtil"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<jsp:useBean id="twm" class="com.eminentlabs.mom.TeamWiseMom"></jsp:useBean>
<%String momClientId = request.getParameter("momClientId");
    HashMap<Integer, String> member = GetProjectMembers.showUsers();
    Integer userid_curr = (Integer) session.getAttribute("userid_curr");
    SimpleDateFormat sdfs = new SimpleDateFormat("dd-MM-yyyy");
    int mClientId = MoMUtil.parseInteger(momClientId, 0);
    if (mClientId != 0) {
        boolean displayMode = false;
        MomForClient mfc = twm.findByMomClientId(mClientId);
        String name = "";
        String nameid = "";
        List<Integer> momClientIds = new ArrayList();
        momClientIds = twm.getClientIds(mfc.getPid());
        String allClientIds = "";

        int index = -1;
        int j = -1;
        for (Integer momForClientId : momClientIds) {
            j++;
            if (momForClientId == mClientId) {
                index = j;
            }
            allClientIds = allClientIds + "" + momForClientId + ",";
        }
        int previd = 0;
        int nextid = 0;
        int k = -1;
        if (index >= 0) {
            for (Integer momForClientId : momClientIds) {
                k++;
                if (index > 0) {
                    if (k == index - 1) {
                        previd = momForClientId;
                    }

                }
                if (index < (momClientIds.size() - 1)) {
                    if (k == index + 1) {
                        nextid = momForClientId;
                    }
                }
            }
        }

        for (MomClientAttendies mca : mfc.getMomClientAttendiesList()) {

            name = name + member.get(mca.getAttendie()) + ",";
            nameid = nameid + mca.getAttendie() + ":" + member.get(mca.getAttendie()) + ",";
        }

        if (userid_curr.intValue() == mfc.getCreatedBy()) {
            Date maxHeldOn = twm.getMaxHeldOn(mfc.getPid());
            if (maxHeldOn != null) {
                if (maxHeldOn.compareTo(mfc.getHeldOn()) > 0) {
                } else if (maxHeldOn.compareTo(mfc.getHeldOn()) == 0) {
                    displayMode = true;
                } else {
                    displayMode = true;

                }
            }
        }
        String rating = null, feedback = null;
        if (mfc.getRating() == null) {
            rating = "Good";
        } else {
            rating = mfc.getRating();
        }
        if (mfc.getFeedback() == null) {
            feedback = "";
        } else {
            feedback = mfc.getFeedback();
        }
        if (displayMode == false) {

            if (mfc.getResponsiblePerson() != null && mfc.getResponsiblePerson() != 0) {
                String rname = mfc.getResponsiblePerson() + ":" + member.get(mfc.getResponsiblePerson());
                out.print("false;;;" + previd + ";;;" + nextid + ";;;" + mfc.getMomClientId() + ";;;" + sdfs.format(mfc.getHeldOn()) + ";;;" + mfc.getHeldAt() + ":" + twm.getHeldAt().get(mfc.getHeldAt()) + ";;;" + mfc.getPid() + ";;;" + mfc.getStartTime() + ";;;" + mfc.getEndTime() + ";;;" + name + ";;;" + mfc.getDiscussion()+ ";;;" + rating + ";;;" + feedback+ ";;;" + allClientIds+";;;" + mfc.getEscalation() + ";;;" + rname );
            } else {
                out.print("false;;;" + previd + ";;;" + nextid + ";;;" + mfc.getMomClientId() + ";;;" + sdfs.format(mfc.getHeldOn()) + ";;;" + mfc.getHeldAt() + ":" + twm.getHeldAt().get(mfc.getHeldAt()) + ";;;" + mfc.getPid() + ";;;" + mfc.getStartTime() + ";;;" + mfc.getEndTime() + ";;;" + name + ";;;" + mfc.getDiscussion() + ";;;" + rating + ";;;" + feedback+ ";;;" + allClientIds );
            }
        } else {
            if (mfc.getResponsiblePerson() != null && mfc.getResponsiblePerson() != 0) {
                String rname = mfc.getResponsiblePerson() + ":" + member.get(mfc.getResponsiblePerson());
                out.print("true;;;" + previd + ";;;" + nextid + ";;;" + mfc.getMomClientId() + ";;;" + sdfs.format(mfc.getHeldOn()) + ";;;" + mfc.getHeldAt() + ":" + twm.getHeldAt().get(mfc.getHeldAt()) + ";;;" + mfc.getPid() + ";;;" + mfc.getStartTime() + ";;;" + mfc.getEndTime() + ";;;" + nameid + ";;;" + mfc.getDiscussion() + ";;;" + rating + ";;;" + feedback + ";;;"  + allClientIds+";;;"+ mfc.getEscalation() + ";;;" + rname );
            } else {
                out.print("true;;;" + previd + ";;;" + nextid + ";;;" + mfc.getMomClientId() + ";;;" + sdfs.format(mfc.getHeldOn()) + ";;;" + mfc.getHeldAt() + ":" + twm.getHeldAt().get(mfc.getHeldAt()) + ";;;" + mfc.getPid() + ";;;" + mfc.getStartTime() + ";;;" + mfc.getEndTime() + ";;;" + nameid + ";;;" + mfc.getDiscussion() + ";;;" + rating + ";;;" + feedback+ ";;;" + allClientIds );
            }
        }
    }
%>


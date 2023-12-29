/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminentlabs.mom;

import com.eminent.issue.ApmTeam;
import com.eminent.issue.controller.ApmTeamController;
import com.eminent.util.GetProjectMembers;
import com.eminentlabs.mom.controller.MomMaintananceController;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Collection;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashSet;
import java.util.Hashtable;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.ResourceBundle;
import javax.servlet.http.HttpServletRequest;
import org.apache.log4j.Logger;
import java.util.Set;
import javax.servlet.http.HttpSession;
import pack.eminent.encryption.MakeConnection;

/**
 *
 * @author RN.Khans
 */
public class BestTeamNPM {

    static Logger logger = null;

    static {
        logger = Logger.getLogger("Best Team and Pm Report");
    }
    private int branch=0;
    Connection connection = null;
    Statement statement = null;
    ResultSet resultset = null;
    private String year;
    List<String> years = new ArrayList<String>();
    List<BestPMTeamBean> bestTeamList = new ArrayList<BestPMTeamBean>();
    List<BestPMTeamBean> bestPMList = new ArrayList<BestPMTeamBean>();
    List<Map.Entry<String, Integer>> pmCountResult = new ArrayList<Map.Entry<String, Integer>>();
    List<Map.Entry<String, Integer>> teamCountResult = new ArrayList<Map.Entry<String, Integer>>();
    List<String> allTeam = new ArrayList<String>();
    List<String> allActivePM = new ArrayList<String>();
    List<String> allTeamFromCount = new ArrayList<String>();
    List<String> allActivePMFromCount = new ArrayList<String>();

    ResourceBundle rb = ResourceBundle.getBundle("Resources");
    String mods = rb.getString("mom-mods");
    String noOfIds[] = mods.split(",");
    List<String> modList = Arrays.asList(noOfIds);
    MomMaintananceController mmc = new MomMaintananceController();
    List totUsers = new ArrayList();

    public void setAll(HttpServletRequest request) throws Exception {
      //  mmc.setSendMomAll(null);
        HttpSession session = request.getSession();

        String branchId = request.getParameter("branch");
        if (branchId != null) {
            if ("".equals(branchId)) {
                branchId = null;
            } else {
                branch = MoMUtil.parseInteger(branchId, 0);
            }
        } else {
            branch = (Integer) session.getAttribute("branch");
        }
        Map<String, List<Integer>> teamWise = GetProjectMembers.getEminentUsersByTeam(branch);

        Calendar cal = Calendar.getInstance();
        year = String.valueOf(cal.get(Calendar.YEAR));
        years.add(String.valueOf(cal.get(Calendar.YEAR) - 1));
        years.add(year);
        
        if (request.getParameter("year") != null) {
            year = request.getParameter("year");
        }
        logger.info(" Year : " + year);
        bestPMList = MoMUtil.getBestPM(year,branch);
        bestTeamList = MoMUtil.getBestTeam(year,branch);
        //    allTeam = MoMUtil.gettAllTeam();
        allActivePM = MoMUtil.getActiveProjectPM(branch);
        totUsers = new ArrayList(mmc.getTotalUsers());

        Collection set = teamWise.keySet();
        Iterator ite = set.iterator();
        while (ite.hasNext()) {
            int k = 0;
            String key = (String) ite.next();
            List<Integer> users = (List<Integer>) teamWise.get(key);
            Object[] toUsers = users.toArray();
            for (int j = 0; j < toUsers.length; j++) {
                String tuid = toUsers[j].toString();
                if (totUsers.contains(tuid)) {
                    k = 1;
                }
            }
            if (k == 1) {
                allTeam.add(key);
            }
        }
        Map<String, Integer> team = new LinkedHashMap<String, Integer>();
        for (BestPMTeamBean bp : bestTeamList) {
            if (team.containsKey(bp.getTeam())) {
                int count = team.get(bp.getTeam());
                count = count + 1;
                team.put(bp.getTeam(), count);
            } else {
                team.put(bp.getTeam(), 1);
                allTeamFromCount.add(bp.getTeam());
            }
        }

        Map<String, Integer> pm = new LinkedHashMap<String, Integer>();
        for (BestPMTeamBean bp : bestPMList) {
            if (pm.containsKey(bp.getpManager())) {
                int counta = pm.get(bp.getpManager());
                counta = counta + 1;
                pm.put(bp.getpManager(), counta);
            } else {
                pm.put(bp.getpManager(), 1);
                allActivePMFromCount.add(bp.getpManager());
            }
        }

        teamCountResult = new ArrayList(team.entrySet());
        Collections.sort(teamCountResult, new Comparator<Map.Entry<String, Integer>>() {
            public int compare(Map.Entry<String, Integer> o1, Map.Entry<String, Integer> o2) {
                return o2.getValue() - o1.getValue();
            }
        });

        pmCountResult = new ArrayList(pm.entrySet());
        Collections.sort(pmCountResult, new Comparator<Map.Entry<String, Integer>>() {
            public int compare(Map.Entry<String, Integer> o1, Map.Entry<String, Integer> o2) {
                return o2.getValue() - o1.getValue();
            }
        });

//          Map<String, Integer> teamWiseCount = new LinkedHashMap<String, Integer>();
//        Collection set = team.keySet();
//        Iterator ite = set.iterator();
//
//        while (ite.hasNext()) {
//            String key = (String) ite.next();
//            Set<String> teamCount = new HashSet<String>();
//            for (BestPMTeamBean bp : bestTeamList) {
//                teamCount.add(bp.getTeam());
//            }
//            System.out.println("Team : " + key + "\t Size : " + teamCount.size());
//            teamWiseCount.put(key, teamCount.size());
//        }
//         List<BestPMTeamBean> countTeamList = new ArrayList<BestPMTeamBean>();
//        for (BestPMTeamBean bean : bestTeam) {
//           
//            BestPMTeamBean countBean = new BestPMTeamBean();
//            countBean.setStartDate(bean.getStartDate());
//            countBean.setEndDate(bean.getEndDate());
//            countBean.setTeam(bean.getTeam());
//            countTeamList.add(countBean);
//            countTeam.put(bean.getTeam(), countTeamList);
//        }
//        for (Map.Entry<String, List<BestPMTeamBean>> entry : countTeam.entrySet()) {
//            logger.info("Team : " + entry.getKey() + "\t  Size : " + entry.getValue().size());
//        }
    }

    public String getYear() {
        return year;
    }

    public void setYear(String year) {
        this.year = year;
    }

    public List<BestPMTeamBean> getBestTeamList() {
        return bestTeamList;
    }

    public void setBestTeamList(List<BestPMTeamBean> bestTeamList) {
        this.bestTeamList = bestTeamList;
    }

    public List<BestPMTeamBean> getBestPMList() {
        return bestPMList;
    }

    public void setBestPM(List<BestPMTeamBean> bestPMList) {
        this.bestPMList = bestPMList;
    }

    public List<String> getModList() {
        return modList;
    }

    public void setModList(List<String> modList) {
        this.modList = modList;
    }

    public List<String> getYears() {
        return years;
    }

    public void setYears(List<String> years) {
        this.years = years;
    }

    public List<Map.Entry<String, Integer>> getPmCountResult() {
        return pmCountResult;
    }

    public void setPmCountResult(List<Map.Entry<String, Integer>> pmCountResult) {
        this.pmCountResult = pmCountResult;
    }

    public List<Map.Entry<String, Integer>> getTeamCountResult() {
        return teamCountResult;
    }

    public void setTeamCountResult(List<Map.Entry<String, Integer>> teamCountResult) {
        this.teamCountResult = teamCountResult;
    }

    public List<String> getAllTeam() {
        return allTeam;
    }

    public void setAllTeam(List<String> allTeam) {
        this.allTeam = allTeam;
    }

    public List<String> getAllActivePM() {
        return allActivePM;
    }

    public void setAllActivePM(List<String> allActivePM) {
        this.allActivePM = allActivePM;
    }

    public List<String> getAllTeamFromCount() {
        return allTeamFromCount;
    }

    public void setAllTeamFromCount(List<String> allTeamFromCount) {
        this.allTeamFromCount = allTeamFromCount;
    }

    public List<String> getAllActivePMFromCount() {
        return allActivePMFromCount;
    }

    public void setAllActivePMFromCount(List<String> allActivePMFromCount) {
        this.allActivePMFromCount = allActivePMFromCount;
    }

    public int getBranch() {
        return branch;
    }

    public void setBranch(int branch) {
        this.branch = branch;
    }

}

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.tags;

import com.eminent.tag.dao.TagDAO;
import com.eminent.tag.dao.TagDAOImpl;
import com.eminent.tag.dao.TagIssueDAO;
import com.eminent.tag.dao.TagIssueDAOImpl;
import com.eminent.tags.bean.TagsUsersEntity;
import com.eminent.tags.bean.dao.TagsUserDAO;
import com.eminent.tags.bean.dao.TagsUserDAOImpl;
import com.eminentlabs.mom.MoMUtil;
import dashboard.CountIssue;
import dashboard.dao.MydashboardDAO;
import dashboard.dao.MydashboardDAOImpl;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.apache.log4j.Logger;

/**
 *
 * @author EMINENT
 */
public class TagController extends HttpServlet {

    static Logger logger = null;

    static {
        logger = Logger.getLogger("TagController");
    }
    private String totalTags = "";
    List<Tags> tagList = new ArrayList<>();
    TagDAO tagDAO = new TagDAOImpl();
    String result = "flase";
    TagIssueDAO tagIssueDAO = new TagIssueDAOImpl();
    Map<Long, Integer> countissueTagMap = new HashMap<Long, Integer>();
    MydashboardDAO mydeshboardDAO = new MydashboardDAOImpl();
    HashMap<Integer, String> userMap = new HashMap<Integer, String>();
    HashMap<Integer, String> allDeshBoradUser = new HashMap<Integer, String>();
    TagsUserDAO tagsUserDAO = new TagsUserDAOImpl();

    public void doAction(HttpServletRequest request) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String action = request.getParameter("action");
        if (action == null) {
            action = "";
        }
        if (action.equalsIgnoreCase("create")) {
            String tagname = request.getParameter("tag").trim();
            Integer curruserId = (Integer) session.getAttribute("userid_curr");
            Integer tagType = MoMUtil.parseInteger(request.getParameter("tagType"), 0);
            String usersId = request.getParameter("userid");
            if (tagname == null || tagname.equalsIgnoreCase("")) {
            } else {
                String user[] = usersId.split(",");
                Tags uniqueTagCurr = tagDAO.findTagEntity(tagname, curruserId);
                if (uniqueTagCurr == null || uniqueTagCurr.getTagId() == 0) {
                    Tags tags = new Tags(0l, tagname, tagType, curruserId);
                    tagDAO.saveAddTags(tags);

                    Tags listTag = tagDAO.findTagEntity(tagname, curruserId);
                    System.out.println(listTag);
                    if (listTag == null || listTag.getTagId() == 0l) {
                    } else {
                        List<TagsUsersEntity> taguserlist = new ArrayList<TagsUsersEntity>();

                        if (tagType == 1) {
                            for (String userIds : user) {
                                TagsUsersEntity tagsUsersEntity = new TagsUsersEntity(0l, MoMUtil.parseInteger(userIds, 0), listTag);
                                taguserlist.add(tagsUsersEntity);
                            }
                        } else {
                            TagsUsersEntity tagsUsersEntity = new TagsUsersEntity(0l, curruserId, listTag);

                            taguserlist.add(tagsUsersEntity);
                        }
                        tagsUserDAO.saveTagUser(taguserlist);

                    }
                    result = "true";
                }
            }

        }
    }

    public String getUniqueTag(HttpServletRequest request) {
        HttpSession session = request.getSession();
        Integer tagType = MoMUtil.parseInteger(request.getParameter("tagType"), 0);
        Integer userId = (Integer) session.getAttribute("userid_curr");
        String tagname = request.getParameter("tag");
        String res = tagDAO.findByTagName(tagname);

        if (res.equalsIgnoreCase("false")) {
            if (tagType == 0) {
                res = tagDAO.findUniqueTagByUser(tagname, userId);
            } else {
                res = "falseChangeType";
            }
        }
        System.out.println(res + " dkffsbh jhfvf");
        return res;
    }

    public void getAllTagsByUser(HttpServletRequest request) {
        Integer userId = (Integer) request.getSession().getAttribute("userid_curr");
        int role = (Integer) request.getSession().getAttribute("Role");
        userMap = mydeshboardDAO.getUser();
        countissueTagMap = tagIssueDAO.getCountIssueforTag();
        List<String> al = null;
        if (role == 1) {
            al = CountIssue.getAllUsers();
        } else {
            al = CountIssue.getSpecificUsers(userId.toString());
        }

        for (int i = 0; i < al.size(); i += 2) {
            int uId = MoMUtil.parseInteger(al.get(i), 0);
            if (userMap.get(uId) != null) {
                allDeshBoradUser.put(uId, userMap.get(uId));
            }
        }
        tagList = tagDAO.findTagsByUserId(userId);

    }

    public void getTagsByUser(HttpServletRequest request) {
        Integer userId = (Integer) request.getSession().getAttribute("userid_curr");
        tagList = tagDAO.findTagsByUserId(userId);
    }

    public String deleteTag(HttpServletRequest request) {
        Long tagId = MoMUtil.parseLong(request.getParameter("tagId"), 0l);
        String res = "false";
        if (tagId > 0l) {
            List<String> list = tagIssueDAO.findAllIssuesByTagId(tagId);

            if (list == null || list.isEmpty()) {
                List<TagsUsersEntity> listTagUser = tagsUserDAO.findByTagId(tagId);
                if (listTagUser == null || listTagUser.isEmpty()) {
                    res = tagDAO.deleteTagByTagId(tagId);
                } else {
                    String userFlag = tagsUserDAO.deleteUserByTag(tagId);
                    if (userFlag.equalsIgnoreCase("true")) {
                        res = tagDAO.deleteTagByTagId(tagId);
                    }
                }
            } else {
                String flag = tagIssueDAO.deleteTagIssueByTagId(tagId);
                if (flag.equalsIgnoreCase("true")) {
                    String userFlag = tagsUserDAO.deleteUserByTag(tagId);
                    if (userFlag.equalsIgnoreCase("true")) {
                        res = tagDAO.deleteTagByTagId(tagId);
                    }
                }

            }
        }
        return res;
    }

    public List<Tags> findtagsByUserId(Integer userId) {
        tagList = tagDAO.findTagsByUserId(userId);
        return tagList;
    }

    public List<Tags> getTagList() {
        return tagList;
    }

    public void setTagList(List<Tags> tagList) {
        this.tagList = tagList;
    }

    public String getTotalTags() {
        return totalTags;
    }

    public void setTotalTags(String totalTags) {
        this.totalTags = totalTags;
    }

    public String getResult() {
        return result;
    }

    public void setResult(String result) {
        this.result = result;
    }

    public Map<Long, Integer> getCountissueTagMap() {
        return countissueTagMap;
    }

    public void setCountissueTagMap(Map<Long, Integer> countissueTagMap) {
        this.countissueTagMap = countissueTagMap;
    }

    public HashMap<Integer, String> getUserMap() {
        return userMap;
    }

    public void setUserMap(HashMap<Integer, String> userMap) {
        this.userMap = userMap;
    }

    public HashMap<Integer, String> getAllDeshBoradUser() {
        return allDeshBoradUser;
    }

    public void setAllDeshBoradUser(HashMap<Integer, String> allDeshBoradUser) {
        this.allDeshBoradUser = allDeshBoradUser;
    }

}

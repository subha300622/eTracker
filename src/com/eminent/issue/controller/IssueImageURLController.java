/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.issue.controller;

import com.eminent.issue.IssueImageUrl;
import com.eminent.issue.URLMapper;
import com.eminent.issue.dao.IssueDAO;
import com.eminent.issue.dao.IssueDAOImpl;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.net.MalformedURLException;
import java.net.URL;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;

/**
 *
 * @author Muthu
 */
public class IssueImageURLController {

    List<IssueImageUrl> issueImageUrls = new ArrayList<IssueImageUrl>();

    public void extractImageURL(HttpServletRequest request) {
        IssueDAO issueDAO = new IssueDAOImpl();
        String sync = request.getParameter("sync");
        SimpleDateFormat sdf = new SimpleDateFormat("ddMMyyyyHHmmss");
        String date = null, new_local_url = "", old_local_url = "";

        try {
            if (sync != null) {
                if (sync.equalsIgnoreCase("true")) {
                    List<IssueImageUrl> imageUrls = issueDAO.getIssueImagecommentswithRowid();
                    int count = 0, status = 0;
                    if (!imageUrls.isEmpty()) {
                        for (IssueImageUrl iiu : imageUrls) {
                            List<String> urls = URLMapper.extractUrls(iiu.getOrginialUrl());
                            count = 0;
                            for (String url : urls) {
                                status = 0;
                                if (url.contains("googleusercontent")) {
                                    if (issueDAO.getImageURLCountByURL(url, iiu.getIssueRowId()) == 0) {
                                        date = sdf.format(new Date());
                                        count++;
                                        if (checkGoogleURL(url)) {
                                            status = 0;
                                        } else {
                                            status = 1;
                                        }
                                        String result = URLMapper.saveImage(url, count + "." + iiu.getIssueId() + "_" + iiu.getIssueRowId().replaceAll("[^a-zA-Z0-9]", "") + "_" + date, iiu.getIssueId(), iiu.getIssueRowId(), status, 0l);
                                        if (result.equalsIgnoreCase("success")) {
                                            issueDAO.updateLocalURLinComments(url, "\\eTracker\\Etracker_AttachedFiles\\images\\" + count + "." + iiu.getIssueId() + "_" + iiu.getIssueRowId().replaceAll("[^a-zA-Z0-9]", "") + "_" + date + ".jpg", iiu.getIssueRowId());
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
            if (request.getMethod().equalsIgnoreCase("post")) {
                List<IssueImageUrl> iius = null;
                String[] checkedids = request.getParameterValues("checkedIds");
                List<Long> urlIds = new ArrayList<Long>();
                for (int i = 0; i < checkedids.length; i++) {
                    urlIds.add(Long.parseLong(checkedids[i]));
                }

                if (!urlIds.isEmpty()) {
                    int status = 1;
                    iius = issueDAO.getImageURLByIds(urlIds);
                    for (IssueImageUrl iiu : iius) {
                        status = 1;
                        new_local_url = "";
                        old_local_url = "";
                        if (checkGoogleURL(iiu.getOrginialUrl())) {
                            status = 0;
                        } else {
                            status = 1;
                        }
                        date = sdf.format(new Date());
                        if ( iiu.getLocalUrl().contains("images")) {
                            old_local_url = 
                                    iiu.getLocalUrl().split("\\.")[0].replace("\\eTracker\\Etracker_AttachedFiles\\images\\", "") + "." + iiu.getIssueId() + "_" + iiu.getIssueRowId().replaceAll("[^a-zA-Z0-9]", "") + "_" + date;
                        } else {
                            old_local_url = iiu.getLocalUrl().split("\\.")[0].replace("\\eTracker\\Etracker_AttachedFiles\\", "") + "." + iiu.getIssueId() + "_" + iiu.getIssueRowId().replaceAll("[^a-zA-Z0-9]", "") + "_" + date;
                        }
                        String result = URLMapper.saveImage(iiu.getOrginialUrl(), old_local_url, iiu.getIssueId(), iiu.getIssueRowId(), status, iiu.getImageId());
                        if (result.equalsIgnoreCase("success")) {
                            new_local_url = "\\eTracker\\Etracker_AttachedFiles\\images\\" + old_local_url + ".jpg";
                            issueDAO.updateLocalURLinComments(iiu.getLocalUrl(), new_local_url, iiu.getIssueRowId());
                        }
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        issueImageUrls = issueDAO.getAllImageURLs();

    }

    public List<IssueImageUrl> getIssueImageUrls() {
        return issueImageUrls;
    }

    public void setIssueImageUrls(List<IssueImageUrl> issueImageUrls) {
        this.issueImageUrls = issueImageUrls;
    }

    public static boolean checkGoogleURL(String url) {
        try {
            BufferedImage image = ImageIO.read(new URL(url));
            if (image != null) {
                return true;
            } else {
                return false;
            }
        } catch (MalformedURLException e) {
            return false;
        } catch (IOException e) {
            return false;
        }

    }
}

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminentlabs.crm.controller;

import com.eminentlabs.crm.dao.MailCampaignDAO;
import com.eminentlabs.crm.dao.MailCampaignDAOImpl;
import com.eminentlabs.crm.dto.MailCampaignDetails;
import com.eminentlabs.crm.persistence.MailCampaign;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author EMINENT
 */
public class MailCampaignController {

    MailCampaignDAO mailCampaignDAO = new MailCampaignDAOImpl();

    public int CountOfMailBydate(String date) throws Exception {

        int count = 0;
        count = mailCampaignDAO.getMailCountByDate(com.pack.ChangeFormat.changeDateFormat(date));
        return count;
    }

    public List<MailCampaignDetails> allDetails(int contactId, String type) {
        String email = mailCampaignDAO.findUserIdByMail(contactId, type);
        List<MailCampaignDetails> mailCampaign = new ArrayList<MailCampaignDetails>();
        mailCampaign = mailCampaignDAO.findDetailsByMail(email);
        return mailCampaign;
    }

}

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminentlabs.crm.dao;

import com.eminentlabs.crm.dto.MailCampaignDetails;
import com.eminentlabs.crm.persistence.MailCampaign;
import java.util.Date;
import java.util.List;

/**
 *
 * @author EMINENT
 */
public interface MailCampaignDAO {

    public int getMailCountByDate(String date);

    public String findUserIdByMail(int contactId,String type);

    public List<MailCampaignDetails> findDetailsByMail(String email);
}

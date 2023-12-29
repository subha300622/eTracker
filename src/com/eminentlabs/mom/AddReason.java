/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.eminentlabs.mom;

import com.eminent.util.GetProjectMembers;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.ResourceBundle;
import org.apache.log4j.Logger;

/**
 *
 * @author RN.Khans
 */
public class AddReason {
      static Logger logger = null;

    static {
        logger = Logger.getLogger("AddReason");
    }

    ResourceBundle rb = ResourceBundle.getBundle("Resources");
    String mods = rb.getString("mom-mods");
    String noOfIds[] = mods.split(",");
    List<String> modList = Arrays.asList(noOfIds);
    List<Fine> reasonList = FineUtil.getFineAmount();
    HashMap<Integer, String> member = GetProjectMembers.getEminentUsers();


    public List<String> getModList() {
        return modList;
    }

    public void setModList(List<String> modList) {
        this.modList = modList;
    }

    public List<Fine> getReasonList() {
        return reasonList;
    }

    public void setReasonList(List<Fine> reasonList) {
        this.reasonList = reasonList;
    }

    public HashMap<Integer, String> getMember() {
        return member;
    }

    public void setMember(HashMap<Integer, String> member) {
        this.member = member;
    }
    
                   
}

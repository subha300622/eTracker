/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminentlabs.crm;

import com.eminent.util.GetProjectMembers;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import org.apache.log4j.Logger;

/**
 *
 * @author RN.Khans
 */
public class CRMSearch {

    static Logger logger = null;

    static {
        logger = Logger.getLogger("CRMSEARCH");
    }

    String pro = "CRM";
    String fix = "1.0";
    HashMap<String, String> al = GetProjectMembers.getBDMembers(pro, fix);
    List<ContactBean> list = CRMUtil.getStateCityCompany("contact");
    private List<String> dateList = CRMUtil.getDateTypes();
    private List<String> companyList = new ArrayList<String>();
    private List<String> stateList = new ArrayList<String>();
    private List<String> cityList = new ArrayList<String>();
    private List<String> crmType = CRMUtil.getCrmType();
    private List<String> ratingType = CRMUtil.getRatings();
    private List<String> interestedType = CRMUtil.getInterstedIn();

    public void getAll(HttpServletRequest request) {
        for (ContactBean bean : list) {
            if (!companyList.contains(bean.getCompany())) {
                companyList.add(bean.getCompany());
            }
        }

        for (ContactBean state : list) {
            if (!stateList.contains(state.getState())) {
                stateList.add(state.getState());
            }
        }

        for (ContactBean city : list) {
            if (!cityList.contains(city.getCity())) {
                cityList.add(city.getCity());
            }
        }
    }

    public HashMap<String, String> getAl() {
        return al;
    }

    public void setAl(HashMap<String, String> al) {
        this.al = al;
    }

    public List<ContactBean> getList() {
        return list;
    }

    public void setList(List<ContactBean> list) {
        this.list = list;
    }

    public List<String> getCrmType() {
        return crmType;
    }

    public void setCrmType(List<String> crmType) {
        this.crmType = crmType;
    }

    public List<String> getCompanyList() {
        return companyList;
    }

    public void setCompanyList(List<String> companyList) {
        this.companyList = companyList;
    }

    public List<String> getStateList() {
        return stateList;
    }

    public void setStateList(List<String> stateList) {
        this.stateList = stateList;
    }

    public List<String> getCityList() {
        return cityList;
    }

    public void setCityList(List<String> cityList) {
        this.cityList = cityList;
    }

    public List<String> getDateList() {
        return dateList;
    }

    public void setDateList(List<String> dateList) {
        this.dateList = dateList;
    }

    public List<String> getRatingType() {
        return ratingType;
    }

    public void setRatingType(List<String> ratingType) {
        this.ratingType = ratingType;
    }

    public List<String> getInterestedType() {
        return interestedType;
    }

    public void setInterestedType(List<String> interestedType) {
        this.interestedType = interestedType;
    }

}

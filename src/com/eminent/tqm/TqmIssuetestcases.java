package com.eminent.tqm;
import java.util.HashSet;
import java.util.Set;
// Generated Dec 8, 2009 2:55:55 PM by Hibernate Tools 3.2.1.GA

public class TqmIssuetestcases  implements java.io.Serializable {


     private long id;
     private TqmPtcm tqmPtcm;
     private TqmTestcasestatus tqmTestcasestatus;
     private String issueid;
    

    public TqmIssuetestcases() {
    }

	
    public TqmIssuetestcases(long id) {
        this.id = id;
    }
    public TqmIssuetestcases(long id, TqmPtcm tqmPtcm, String issueid) {
       this.id = id;
       this.tqmPtcm = tqmPtcm;
       this.issueid = issueid;
    }
   
    public long getId() {
        return this.id;
    }
    
    public void setId(long id) {
        this.id = id;
    }
    public TqmPtcm getTqmPtcm() {
        return this.tqmPtcm;
    }
    
    public void setTqmPtcm(TqmPtcm tqmPtcm) {
        this.tqmPtcm = tqmPtcm;
    }
    public String getIssueid() {
        return this.issueid;
    }
    
    public void setIssueid(String issueid) {
        this.issueid = issueid;
    }
     public TqmTestcasestatus getTqmtestcasestatus() {
        return this.tqmTestcasestatus;
    }

    public void setTqmtestcasestatus(TqmTestcasestatus TqmTestcasestatus) {
        this.tqmTestcasestatus = TqmTestcasestatus;
    }
    

}



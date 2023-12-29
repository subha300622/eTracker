package com.eminent.tqm;
import java.util.Date;
import java.sql.Timestamp;

public class TqmPtcfileattach  implements java.io.Serializable {


     private int ptcfileid;
     private String ptcid;
     private String filename;
     private Timestamp attacheddate;
     private int owner;
     private String ptcstatus;
     private int tceid;

    public TqmPtcfileattach() {
    }

	
    public TqmPtcfileattach(int ptcfileid) {
        this.ptcfileid = ptcfileid;
    }
    public TqmPtcfileattach(int ptcfileid, String ptcid, String filename, Timestamp attacheddate, int owner, String ptcstatus, int tceid) {
       this.ptcfileid = ptcfileid;
       this.ptcid = ptcid;
       this.filename = filename;
       this.attacheddate = attacheddate;
       this.owner = owner;
       this.ptcstatus = ptcstatus;
       this.tceid = tceid;
    }
   
    public int getPtcfileid() {
        return this.ptcfileid;
    }
    
    public void setPtcfileid(int ptcfileid) {
        this.ptcfileid = ptcfileid;
    }
    public String getPtcid() {
        return this.ptcid;
    }
    
    public void setPtcid(String ptcid) {
        this.ptcid = ptcid;
    }
    public String getFilename() {
        return this.filename;
    }
    
    public void setFilename(String filename) {
        this.filename = filename;
    }
    public Date getAttacheddate() {
        return this.attacheddate;
    }
    
    public void setAttacheddate(Timestamp attacheddate) {
        this.attacheddate = attacheddate;
    }
    public int getOwner() {
        return this.owner;
    }
    
    public void setOwner(int owner) {
        this.owner = owner;
    }
    public String getPtcstatus() {
        return this.ptcstatus;
    }
    
    public void setPtcstatus(String ptcstatus) {
        this.ptcstatus = ptcstatus;
    }
    public int getTceid() {
        return this.tceid;
    }
    
    public void setTceid(int tceid) {
        this.tceid = tceid;
    }




}



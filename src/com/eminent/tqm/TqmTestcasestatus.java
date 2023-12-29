/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.eminent.tqm;
import java.util.HashSet;
import java.util.Set;

/**
 *
 * @author Administrator
 */
public class TqmTestcasestatus  implements java.io.Serializable{
    private int statusid;
    private String status;


    public TqmTestcasestatus(){
        
    }
    public TqmTestcasestatus(int statusid){

    }
    public TqmTestcasestatus(int statusid, String status){
        this.statusid=statusid;
        this.status=status;

    }
    public int getStatusid(){
        return this.statusid;
    }
    public void setStatusid(int statusid){
        this.statusid=statusid;
    }
    public String getStatus(){
        return this.status;
    }
    public void setStatus(String status){
        this.status=status;
    }
    
  
}

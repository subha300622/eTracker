/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.eminent.tqm;

/**
 *
 * @author Tamilvelan
 */
public class TqmModuleplan implements java.io.Serializable{
    private int mid;
    private TqmTestcaseexecutionplan tepid;
    private int mpid;

    public TqmModuleplan(){

    }
    public TqmModuleplan(int mpid,TqmTestcaseexecutionplan tepid,int mid){
        this.mpid               =   mpid;
        this.tepid              =   tepid;
        this.mid                =   mid;

    }
    public void setMpid(int mpid){
        this.mpid=mpid;
    }
    public int getMpid(){
        return mpid;
    }
    public void setTepid(TqmTestcaseexecutionplan tepid){
        this.tepid=tepid;
    }
    public TqmTestcaseexecutionplan getTepid(){
        return tepid;
    }
    public void setMid(int mid){
        this.mid=mid;
    }
    public int getMid(){
        return mid;
    }


}

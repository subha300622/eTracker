/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.eminentlabs.mom;

import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author EMINENT
 */
public class JsonFull {
    List<JsonOb> list = new ArrayList<JsonOb>();
    private int unintimated;

    public List<JsonOb> getList() {
        return list;
    }

    public void setList(List<JsonOb> list) {
        this.list = list;
    }

    public int getUnintimated() {
        return unintimated;
    }

    public void setUnintimated(int unintimated) {
        this.unintimated = unintimated;
    }
    
}

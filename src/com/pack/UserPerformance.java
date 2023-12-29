/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.pack;

import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Muthu
 */
public class UserPerformance {

    List<Integer> currentMonthTop = new ArrayList<Integer>();
    List<Integer> threeMonthsTop = new ArrayList<Integer>();
    List<Integer> currentMonthLeast = new ArrayList<Integer>();
    List<Integer> threeMonthsLeast = new ArrayList<Integer>();
    List<Integer> maxCount = new ArrayList<Integer>();
    List<Integer> minCount = new ArrayList<Integer>();

    public List<Integer> getCurrentMonthTop() {
        return currentMonthTop;
    }

    public void setCurrentMonthTop(List<Integer> currentMonthTop) {
        this.currentMonthTop = currentMonthTop;
    }

    public List<Integer> getThreeMonthsTop() {
        return threeMonthsTop;
    }

    public void setThreeMonthsTop(List<Integer> threeMonthsTop) {
        this.threeMonthsTop = threeMonthsTop;
    }

    public List<Integer> getCurrentMonthLeast() {
        return currentMonthLeast;
    }

    public void setCurrentMonthLeast(List<Integer> currentMonthLeast) {
        this.currentMonthLeast = currentMonthLeast;
    }

    public List<Integer> getThreeMonthsLeast() {
        return threeMonthsLeast;
    }

    public void setThreeMonthsLeast(List<Integer> threeMonthsLeast) {
        this.threeMonthsLeast = threeMonthsLeast;
    }

    public List<Integer> getMaxCount() {
        return maxCount;
    }

    public void setMaxCount(List<Integer> maxCount) {
        this.maxCount = maxCount;
    }

    public List<Integer> getMinCount() {
        return minCount;
    }

    public void setMinCount(List<Integer> minCount) {
        this.minCount = minCount;
    }
    

}

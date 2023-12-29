/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.issue;

/**
 *
 * @author E0288
 */
public enum PlanStatus {

    ACTIVE("Active"), INACTIVE("InActive");
    private String status;

    public static PlanStatus getACTIVE() {
        return ACTIVE;
    }

    public static PlanStatus getINACTIVE() {
        return INACTIVE;
    }

    private PlanStatus(String s) {
        status = s;
    }

    public String getStatus() {
        return status;
    }
}

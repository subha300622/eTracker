/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminentlabs.mom;

/**
 *
 * @author E0288
 */
public enum PerformanceType {
    WINNER("Winner") ,COMPETITOR("Competitor"),NOPARTICIPATION("NoParticipation") ;
    
    private String performanceType;
 
	private PerformanceType(String s) {
		performanceType = s;
	}
 
	public String getStatusCode() {
		return performanceType;
	}
}

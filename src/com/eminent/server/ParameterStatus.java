/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.server;

/**
 *
 * @author vanithaalliraj
 */
public class ParameterStatus {
    
   private int matrixParamId;
   private int systemId;
   private int parameterId;
   private String paramStatus;

    public int getMatrixParamId() {
        return matrixParamId;
    }

    public void setMatrixParamId(int matrixParamId) {
        this.matrixParamId = matrixParamId;
    }

    public int getSystemId() {
        return systemId;
    }

    public void setSystemId(int systemId) {
        this.systemId = systemId;
    }

    public int getParameterId() {
        return parameterId;
    }

    public void setParameterId(int parameterId) {
        this.parameterId = parameterId;
    }

    public String getParamStatus() {
        return paramStatus;
    }

    public void setParamStatus(String paramStatus) {
        this.paramStatus = paramStatus;
    }
   
    
}

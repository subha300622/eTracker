package com.eminent.issue.dao;

import com.eminent.issue.ApmTrFormat;
import java.util.List;

public interface ApmTrFormatDAO {

    public void addTrFormat(ApmTrFormat apmTrFormat);
    public List<ApmTrFormat> findAlltrFormats();
   public List<ApmTrFormat> findAllTrFormatsByPid(long pid);
    public void delete(ApmTrFormat apmTrFormat);
     public void update(ApmTrFormat apmTrFormat);

  
}

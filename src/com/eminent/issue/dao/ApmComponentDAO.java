package com.eminent.issue.dao;

import com.eminent.issue.ApmComponent;
import java.math.BigDecimal;
import java.util.List;

public interface ApmComponentDAO {

    public void addComponent(ApmComponent apmComponent);

    public List<ApmComponent> findAllComponents(BigDecimal componentId);
    
    public List<ApmComponent> findAllComponentNames();

    public void update(ApmComponent apmComponent);

    public void delete(ApmComponent apmComponent);

    public ApmComponent findByComponentId(BigDecimal componentId);

}

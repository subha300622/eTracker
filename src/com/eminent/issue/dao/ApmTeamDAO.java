package com.eminent.issue.dao;

import com.eminent.issue.ApmTeam;
import java.util.List;

public interface ApmTeamDAO {

    public void addTeam(ApmTeam apmTeam);

    public List<ApmTeam> findAllTeams(ApmTeam apmTeam);

    public void update(ApmTeam apmTeam);

    public void delete(ApmTeam apmTeam);

    public ApmTeam findByTeamId(long teamId);

}

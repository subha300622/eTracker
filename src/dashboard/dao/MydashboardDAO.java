/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dashboard.dao;

import com.eminent.issue.formbean.IssueFormBean;
import java.util.HashMap;
import java.util.List;

/**
 *
 * @author admin
 */
public interface MydashboardDAO {

    public HashMap<Integer, String> getUser();

    public List<IssueFormBean> QueryForUser(String userId, String currentUser, String status, String priority);

    public List<IssueFormBean> getAllIssueMyDashBorad(String userId, Integer currentUser);
}

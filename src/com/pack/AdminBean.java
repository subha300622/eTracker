package com.pack;

import com.eminent.timesheet.specifiedAllUsers;
import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import oracle.jdbc.driver.OracleTypes;
import org.apache.log4j.Logger;
import pack.eminent.encryption.Encryption;
import pack.eminent.encryption.MakeConnection;

public class AdminBean {

    static Logger logger = Logger.getLogger("AdminBean");

    Encryption encryption;
    private String firstName = "";
    private String lastName = "";
    private String password = "";
    private String company = "";
    private String secret = "";
    private String answer = "";
    private String userEmail = "";
    private String phone = "";
    private String mobile = "";
    private String phone1 = "";
    private String mobile1 = "";
    private String phone2 = "";
    private String operator = "";

    private String pname = "";
    private String mname = "";
    private String attach = "";
    private String platform = "";
    private String platforms = "";
    private String versionInfo = "";
    private String projectManager = "";
    private String customer = "";
    private String startdate = "";
    private String enddate = "";
    private String totalhours = "";
    private String phase = null;
    private String comments = null;
    private String status = null;
    //Edit by sowjanya
    private String domain_name = null;
    //Edit end by sowjanya
    //changed for category
    private String category = "";

    // changed for managers
    private int sponsorer = 0;
    private int stakeholder = 0;
    private int coordinator = 0;
    private int dmanager = 0;
    private int amanager = 0;

    Connection connection;
    String uname = "";
    String ucustomer = "";
    String uplatform = "";
    String uplatforms = "";
    String uversion = "";
    String umanager = "";
    String umname = "";
    String ustatus = "";
    //String customer = "";

    String returnValues[] = new String[5];
    String returnValuesView[] = new String[5];

    /* (non-Javadoc)
     * @see com.pack.EtrackerBean#getFirstName()
     */
    public AdminBean() {

    }

    public String getFirstName() {
        return firstName;
    }

    /* (non-Javadoc)
     * @see com.pack.EtrackerBean#setFirstName(java.lang.String)
     */

    public void setFirstName(String firstName) {
        if (firstName != null) {
            this.firstName = firstName;
        }
    }

    /* (non-Javadoc)
     * @see com.pack.EtrackerBean#getLastName()
     */
    public String getLastName() {
        return lastName;
    }

    /* (non-Javadoc)
     * @see com.pack.EtrackerBean#setLastName(java.lang.String)
     */

    public void setLastName(String lastName) {
        if (lastName != null) {
            this.lastName = lastName;
        }
    }

    /* (non-Javadoc)
     * @see com.pack.EtrackerBean#getPassword()
     */
    public String getPassword() {
        return password;
    }

    /* (non-Javadoc)
     * @see com.pack.EtrackerBean#setPassword(java.lang.String)
     */

    public void setPassword(String password) {
        if (password != null) {
            this.password = password;
        }
    }

    /* (non-Javadoc)
     * @see com.pack.EtrackerBean#getUserEmail()
     */
    public String getUserEmail() {
        return userEmail;
    }

    /* (non-Javadoc)
     * @see com.pack.EtrackerBean#setUserEmail(java.lang.String)
     */

    public void setUserEmail(String userEmail) {
        if (userEmail != null) {
            this.userEmail = userEmail;
        }
    }

    /* (non-Javadoc)
     * @see com.pack.EtrackerBean#getCompany()
     */
    public String getCompany() {
        return company;
    }

    /* (non-Javadoc)
     * @see com.pack.EtrackerBean#setCompany(java.lang.String)
     */

    public void setCompany(String company) {
        if (company != null) {
            this.company = company;
        }
    }

    public String getSecret() {
        return secret;
    }

    /* (non-Javadoc)
     * @see com.pack.EtrackerBean#setCompany(java.lang.String)
     */

    public void setSecret(String secret) {
        if (secret != null) {
            this.secret = secret;
        }
    }

    public String getAnswer() {
        return answer;
    }

    /* (non-Javadoc)
     * @see com.pack.EtrackerBean#setCompany(java.lang.String)
     */

    public void setAnswer(String answer) {
        if (answer != null) {
            this.answer = answer;
        }
    }

    /* (non-Javadoc)
     * @see com.pack.EtrackerBean#getPhone()
     */
    public String getPhone() {
        return phone;
    }

    /* (non-Javadoc)
     * @see com.pack.EtrackerBean#setPhone(java.lang.String)
     */

    public void setPhone(String phone) {
        if (phone != null) {
            this.phone = phone;
        }
    }

    public String getPhone1() {
        return phone1;
    }

    /* (non-Javadoc)
     * @see com.pack.EtrackerBean#setPhone(java.lang.String)
     */

    public void setPhone1(String phone1) {
        if (phone1 != null) {
            this.phone1 = phone1;
        }
    }

    public String getPhone2() {
        return phone2;
    }

    /* (non-Javadoc)
     * @see com.pack.EtrackerBean#setPhone(java.lang.String)
     */

    public void setPhone2(String phone2) {
        if (phone2 != null) {
            this.phone2 = phone2;
        }
    }

    /* (non-Javadoc)
     * @see com.pack.EtrackerBean#getMobile()
     */

    public String getMobile() {
        return mobile;
    }

    /* (non-Javadoc)
     * @see com.pack.EtrackerBean#setMobile(java.lang.String)
     */

    public void setMobile(String mobile) {
        if (mobile != null) {
            this.mobile = mobile;
        }
    }

    public String getMobile1() {
        return mobile1;
    }

    /* (non-Javadoc)
     * @see com.pack.EtrackerBean#setMobile(java.lang.String)
     */

    public void setMobile1(String mobile1) {
        if (mobile1 != null) {
            this.mobile1 = mobile1;
        }
    }

    public String getPname() {
        return pname;
    }

    public void setPname(String pname) {
        if (pname != null) {
            this.pname = pname;
        }
    }

    public String getVersionInfo() {
        return versionInfo;
    }

    public void setVersionInfo(String versionInfo) {
        if (versionInfo != null) {
            this.versionInfo = versionInfo;
        }
    }

    public String getPlatform() {
        return platform;
    }

    public void setPlatform(String platform) {
        if (platform != null) {
            this.platform = platform;
        }
    }

    public String getPlatforms() {
        return platforms;
    }

    public void setPlatforms(String platforms) {
        if (platforms != null) {
            this.platforms = platforms;
        }
    }

    public String getProjectManager() {
        return projectManager;
    }

    public void setProjectManager(String projectManager) {
        if (projectManager != null) {
            this.projectManager = projectManager;
        }
    }

    public int getExecutiveSponsorer() {
        return sponsorer;
    }

    public void setExecutiveSponsorer(int sponsorer) {
        this.sponsorer = sponsorer;
    }

    public int getProjectStakeholder() {
        return stakeholder;
    }

    public void setProjectStakeholder(int stakeholder) {
        this.stakeholder = stakeholder;
    }

    public int getProjectCoordinator() {
        return coordinator;
    }

    public void setProjectCoordinator(int coordinator) {
        this.coordinator = coordinator;
    }

    public int getAccountManager() {
        return amanager;
    }

    public void setAccountManager(int amanager) {
        this.amanager = amanager;
    }

    public int getDeliveryManager() {
        return dmanager;
    }

    public void setDeliveryManager(int dmanager) {
        this.dmanager = dmanager;
    }

    public String getCustomer() {
        return customer;
    }

    public void setCustomer(String customer) {
        if (customer != null) {
            this.customer = customer;
        }
    }

    public String getComments() {
        return comments;
    }

    public void setComments(String comments) {
        if (comments != null) {
            this.comments = comments;
        }
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        if (status != null) {
            this.status = status;
        }
    }
//Edit By sowjanya

    public String getDomain_name() {
        return domain_name;
    }

    public void setDomain_name(String domain_name) {
        this.domain_name = domain_name;
    }
//Edit End by sowjanya

    public String getStartdate() {
        return startdate;
    }

    public void setStartdate(String startdate) {// throws Exception  {
        try {
            if (startdate != null) {
                this.startdate = ChangeFormat.getDateFormat(startdate);
            }
        } catch (Exception e) {
            logger.error("setStartdate(String)", e);
        }
        //   System.out.println("start date"+this.startdate);
    }

    public String getEnddate() {
        return enddate;
    }

    public void setEnddate(String enddate) {// throws Exception {
        try {
            if (enddate != null) {
                this.enddate = ChangeFormat.getDateFormat(enddate);
            }
        } catch (Exception e) {
            logger.error("setEnddate(String)", e);
        }

        //System.out.println("End Date"+this.enddate);
    }

    public String getTotalhours() {
        return totalhours;
    }

    public void setTotalhours(String totalhours) {
        if (totalhours != null) {
            this.totalhours = totalhours.trim();
        }
    }

    //changed for category
    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        if (category != null) {
            this.category = category;
        }
    }

    public String getPhase() {
        return phase;
    }

    public void setPhase(String phase) {
        if (phase != null) {
            this.phase = phase;
        }
    }

    public String getMname() {
        return mname;
    }

    public void setMname(String mname) {
        if (mname != null) {
            this.mname = mname;
        }
    }

    public String getAttach() {
        return attach;
    }

    public void setAttach(String attach) {
        if (attach != null) {
            this.attach = attach;
        }
    }

    public String getOperator() {
        return operator;
    }

    public void setOperator(String operator) {
        if (operator != null) {
            this.operator = operator;
        }
    }

    /* (non-Javadoc)
     * @see com.pack.EtrackerBean#ConnectToDatabase()
     */
 /* (non-Javadoc)
     * @see com.pack.EtrackerBean#UserExist(java.lang.String)
     */
    public boolean AdminExist(Connection connection, String email) throws SQLException {

        Statement adminExistst = null;
        ResultSet adminExistrs = null;

        try {
            adminExistst = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            adminExistrs = adminExistst.executeQuery("select email from users where roleid=1");
            if (adminExistrs != null) {
                if (adminExistrs.next()) {
                    adminExistrs.first();
                    do {
                        if (adminExistrs.getString("email").equals(email)) {
                            logger.debug("Admin Exists with the name" + adminExistrs.getString("email"));
                            return true;
                        }
                    } while (adminExistrs.next());
                }
            } else {
                logger.debug("ResultSet is Null in Admin Exists()");
            }
        } catch (Exception ex) {
            logger.error("SQL Exception in AdminExist()" + ex.getMessage());
        } finally {
            if (adminExistrs != null) {
                adminExistrs.close();
            }
            if (adminExistst != null) {
                adminExistst.close();
            }
            logger.debug("Closing JDBC resources in AdminExist()");
        }
        return false;

    }

    public boolean UserExist(Connection connection, String email) throws SQLException {
        Statement userExistst = null;
        ResultSet userExistrs = null;

        try {
            userExistst = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            userExistrs = userExistst.executeQuery("select email from users");
            if (userExistrs != null) {
                if (userExistrs.next()) {
                    userExistrs.first();
                    do {
                        if (userExistrs.getString("email").equals(email)) {
                            logger.debug("User Exists with the name");
                            return true;
                        }
                    } while (userExistrs.next());
                } else {
                    logger.debug("ResultSet is Null in UserExists()");
                }
            }

        } catch (SQLException ex) {
            logger.error("SQL Exception in AdminExist()" + ex.getMessage());
        } finally {
            if (userExistrs != null) {
                userExistrs.close();
            }
            if (userExistst != null) {
                userExistst.close();
            }
            logger.debug("Closing JDBC resources in UserExist()");
        }
        return false;

    }

    /* (non-Javadoc)
     * @see com.pack.EtrackerBean#CreateAdmin(java.lang.String)
     */

    public void CreateAdmin(Connection connection, String email) throws Exception {
        Statement createAdminst = null, adminRolest = null;
        ResultSet createAdminrs = null, adminRolers = null;
        PreparedStatement createAdminps = null;
        String team = null;

        int roleAdmin = 0;
        try {
            createAdminst = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            createAdminrs = createAdminst.executeQuery("select userid_seq.nextval from dual");
            int nextValue = 0;
            if (createAdminrs != null) {
                createAdminrs.next();
                nextValue = createAdminrs.getInt("nextval");
                createAdminrs.close();
                createAdminst.close();
                logger.debug("Closing JDBC Resources in Sequence Generation");
            }

            adminRolest = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            adminRolers = adminRolest.executeQuery("select roleid from role where role='etracker-admin'");

            if (adminRolers != null) {
                if (adminRolers.next()) {
                    roleAdmin = adminRolers.getInt("roleid");
                }
            }

            encryption = new Encryption();
            phone = "+" + phone + "-" + phone1 + "-" + phone2;
            mobile = "+" + mobile + "-" + mobile1;
            team = "ADMIN";
            createAdminps = connection.prepareStatement("insert into users(userid,firstname,lastname,password,email,company,secret,answer,phone,mobile,roleid,team,mobileoperator) values(?,?,?,?,?,?,?,?,?,?,?,?,?)");
            createAdminps.setInt(1, nextValue);
            createAdminps.setString(2, StringUtil.fixSqlFieldValue(firstName));
            createAdminps.setString(3, StringUtil.fixSqlFieldValue(lastName));
            createAdminps.setString(4, StringUtil.fixSqlFieldValue(Encryption.encrypt(password)));
            createAdminps.setString(5, StringUtil.fixSqlFieldValue(email));
            createAdminps.setString(6, StringUtil.fixSqlFieldValue(company));
            createAdminps.setString(7, StringUtil.fixSqlFieldValue(secret));
            createAdminps.setString(8, StringUtil.fixSqlFieldValue(answer));
            createAdminps.setString(9, phone);
            createAdminps.setString(10, mobile);
            createAdminps.setInt(11, roleAdmin);
            createAdminps.setString(12, team);
            createAdminps.setString(13, operator);
            createAdminps.executeUpdate();
        } catch (SQLException ex) {
            logger.error("SQLException while registering new admin" + ex.getMessage());
        } finally {
            if (adminRolers != null) {
                adminRolers.close();
            }
            if (createAdminps != null) {
                createAdminps.close();
            }
            if (adminRolest != null) {
                adminRolest.close();
            }
        }
    }

    public boolean ProjectExist(Connection connection, String dname, String version, String platform, String manager, String totalhours, String customer, String startdate, String enddate, String phase) throws SQLException {

        String unamep = "";
        String uversionp = "";
        String uplatformp = "";
        String umanagerp = "";
        String ucustomerp = "";

        Statement projectExistst = null;
        ResultSet projectExistrs = null;

        try {
            projectExistst = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            projectExistrs = projectExistst.executeQuery("select pname,version,platform,pmanager,customer from project");

            if (projectExistrs != null) {
                if (projectExistrs.next()) {
                    projectExistrs.first();
                    do {
                        unamep = projectExistrs.getString("pname");
                        uversionp = projectExistrs.getString("version");
                        uplatformp = projectExistrs.getString("platform");
                        umanagerp = projectExistrs.getString("pmanager");
                        ucustomerp = projectExistrs.getString("customer");

                        if (!(unamep.toUpperCase().equals(dname.toUpperCase())) || !(uversionp.toUpperCase().equals(version.toUpperCase())) || !(uplatformp.toUpperCase().equals(platform.toUpperCase())) || !(umanagerp.toUpperCase().equals(manager.toUpperCase())) || !(ucustomerp.toUpperCase().equals(customer.toUpperCase()))) {
                            return false;
                        } else {
                            return true;
                        }

                    } while (projectExistrs.next());
                }
            }

        } catch (SQLException ex) {
            logger.error("Exception in Project Exist Method:" + ex.getMessage());
        } finally {
            if (projectExistrs != null) {
                projectExistrs.close();
            }
            if (projectExistst != null) {
                projectExistst.close();
            }
        }
        return false;

    }

    public boolean ModuleExist(Connection connection, String mname, int pid) throws SQLException {

        Statement ModuleExistStatement = null;
        ResultSet ModuleExistResultSet = null;

        String unamem = "";
        String moduleFromUser = mname.trim();
        moduleFromUser = moduleFromUser.replaceAll("\\s", "");
        try {
            ModuleExistStatement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            ModuleExistResultSet = ModuleExistStatement.executeQuery("select module from modules where pid=" + pid);
            if (ModuleExistResultSet != null) {
                if (ModuleExistResultSet.next()) {
                    ModuleExistResultSet.first();

                    do {
                        unamem = ModuleExistResultSet.getString("module").trim();
                        if ((unamem.toUpperCase().equals(moduleFromUser.toUpperCase()))) {
                            return true;
                        }
                    } while (ModuleExistResultSet.next());
                }
            }

        } catch (SQLException ex) {
            logger.error("Exception in Module Exist Method:" + ex.getMessage());
        } finally {
            if (ModuleExistResultSet != null) {
                ModuleExistResultSet.close();
            }
            if (ModuleExistStatement != null) {
                ModuleExistStatement.close();
            }
        }
        return false;

    }

    public int CreateNewProject(Connection connection, String dname) throws SQLException {

        Statement createProjectst = null;
        ResultSet createProjectrs = null;
        PreparedStatement createProjectps = null;
        int x = 0;
        try {
            createProjectst = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            createProjectrs = createProjectst.executeQuery("select pid_seq.nextval from dual");
            if (createProjectrs != null) {
                if (createProjectrs.next()) {
                    int nextValue = createProjectrs.getInt("nextval");

                    if (!platform.equals("Others")) {
                        createProjectps = connection.prepareStatement("insert into project(pid,pname,version,platform,pmanager,customer,startdate,enddate,category,totalhours,phase,sponsorer,stakeholder,coordinator,amanager,dmanager,DELIVERABLES,status,project_domain) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
                        createProjectps.setInt(1, nextValue);
                        createProjectps.setString(2, StringUtil.fixSqlFieldValue(pname));
                        createProjectps.setString(3, StringUtil.fixSqlFieldValue(versionInfo));
                        createProjectps.setString(4, StringUtil.fixSqlFieldValue(platform));
                        createProjectps.setString(5, StringUtil.fixSqlFieldValue(projectManager));
                        createProjectps.setString(6, StringUtil.fixSqlFieldValue(customer));
                        createProjectps.setDate(7, java.sql.Date.valueOf(startdate));
                        createProjectps.setDate(8, java.sql.Date.valueOf(enddate));
                        createProjectps.setString(9, StringUtil.fixSqlFieldValue(category));
                        createProjectps.setString(10, totalhours);
                        createProjectps.setString(11, StringUtil.fixSqlFieldValue(phase));
                        createProjectps.setInt(12, sponsorer);
                        createProjectps.setInt(13, stakeholder);
                        createProjectps.setInt(14, coordinator);
                        createProjectps.setInt(15, amanager);
                        createProjectps.setInt(16, dmanager);
                        createProjectps.setString(17, comments);
                        createProjectps.setString(18, status);
                        createProjectps.setString(19, domain_name);
                        createProjectps.executeUpdate();

                    } else {
                        createProjectps = connection.prepareStatement("insert into project(pid,pname,version,platform,pmanager,customer,startdate,enddate,category,totalhours,phase,status,project_domain) values(?,?,?,?,?,?,?,?,?,?,?,?,?)");
                        createProjectps.setInt(1, nextValue);
                        createProjectps.setString(2, StringUtil.fixSqlFieldValue(pname));
                        createProjectps.setString(3, StringUtil.fixSqlFieldValue(versionInfo));
                        createProjectps.setString(4, StringUtil.fixSqlFieldValue(platforms));
                        createProjectps.setString(5, StringUtil.fixSqlFieldValue(projectManager));
                        createProjectps.setString(6, StringUtil.fixSqlFieldValue(customer));
                        //         System.out.println("Customer2"+customer);
                        //         System.out.println("startdate2"+startdate);
                        //         System.out.println("enddate2"+enddate);
                        createProjectps.setDate(7, java.sql.Date.valueOf(startdate));

                        createProjectps.setDate(8, java.sql.Date.valueOf(enddate));
                        createProjectps.setString(9, StringUtil.fixSqlFieldValue(category));
                        createProjectps.setString(10, totalhours);
                        createProjectps.setString(11, StringUtil.fixSqlFieldValue(phase));
                        //Edit By sowjanya
                        createProjectps.setString(12, status);
                        createProjectps.setString(13, domain_name);
                        //Edit end By sowjanya
                        createProjectps.executeUpdate();
                    }
                    x = nextValue;
                }
            }
        } catch (SQLException ex) {
            logger.error("Exception While Creating new project:" + ex.getMessage());
        } finally {
            if (createProjectrs != null) {
                createProjectrs.close();
            }
            if (createProjectst != null) {
                createProjectst.close();
            }
            if (createProjectps != null) {
                createProjectps.close();
            }
        }
        return x;
    }

    public void CreateNewModule(Connection connection, String mname, int pid) throws SQLException {
        Statement createModulest = null;
        ResultSet createModulers = null;
        PreparedStatement createModuleps = null;

        try {
            createModulest = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            createModulers = createModulest.executeQuery("select moduleid_seq.nextval from dual");
            if (createModulers != null) {
                if (createModulers.next()) {
                    int nextValue = createModulers.getInt("nextval");
                    createModuleps = connection.prepareStatement("insert into modules(moduleid,module,pid) values(?,?,?)");
                    createModuleps.setInt(1, nextValue);
                    createModuleps.setString(2, StringUtil.fixSqlFieldValue(mname));
                    createModuleps.setInt(3, pid);
                    createModuleps.executeUpdate();

                }
            }
        } catch (SQLException ex) {
            logger.error("Exception while creating modules:" + ex.getMessage());
        } finally {
            if (createModulers != null) {
                createModulers.close();
            }
            if (createModulest != null) {
                createModulest.close();
            }
            if (createModuleps != null) {
                createModuleps.close();
            }
        }
    }

    /* (non-Javadoc)
     * @see com.pack.EtrackerBean#CreateUser(java.lang.String)
     */
    Statement st = null;
    ResultSet rs = null;
    PreparedStatement ps = null;

    public ResultSet ViewUser(Connection connection, int x) throws SQLException {

        try {
            callProccedure(connection);
            st = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            // rs = st.executeQuery("SELECT FIRSTNAME,LASTNAME,USERID,COMPANY,EMAIL,MOBILE,PHONE,TEAM,VALUE,LASTLOGGEDON,CLOSEDISSUECOUNT(USERID) as closedCount,substr(emp_id,0,1) as empid from users where roleid>1 order by empid asc,closedCount desc,value desc");
            String sql = "SELECT DISTINCT USERID, FIRSTNAME,LASTNAME,COMPANY,EMAIL,MOBILE,PHONE,TEAM,VALUE,LASTLOGGEDON,(select count(issueid) from closedissue where COMMENTER='userid' and COMMENTERTO='userid') as closedCount,substr(emp_id,0,1) as empid from users where roleid>1  order by empid,closedCount desc,value desc ";
            rs = st.executeQuery(sql);

        } catch (SQLException ex) {
            logger.error("Exception in ViewUser Method:" + ex.getMessage());
        }
        return rs;
    }

    public void callProccedure(Connection con) {
        Statement stmt = null;
        try {
            stmt = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            String sql = "{call isuueCloseded}";
            stmt.execute(sql);
        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                stmt.close();
            } catch (Exception e) {
                logger.error(e.getMessage());
            }
        }
    }

    public ResultSet ViewNewUser(Connection connection, int x) throws SQLException {

        try {
            st = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            rs = st.executeQuery("SELECT FIRSTNAME,LASTNAME,USERID,COMPANY,EMAIL,MOBILE,PHONE,TEAM,VALUE,LASTLOGGEDON from users where roleid=" + x + " order by USERID DESC ");

        } catch (SQLException ex) {
            logger.error("Exception in ViewUser Method:" + ex.getMessage());
        }
        return rs;
    }

    public void close() throws SQLException {
        if (rs != null) {
            rs.close();
        }
        if (st != null) {
            st.close();
        }
        logger.debug("Closing JDBC resources in close()");
    }

    /* (non-Javadoc)
     * @see com.pack.EtrackerBean#ViewProject()
     */

    public ResultSet ViewProject(Connection connection) throws SQLException {
        try {
            st = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            rs = st.executeQuery("SELECT pid,pname,pmanager,version,platform,customer,to_char(startdate,'dd-Mon-yy') as startingdate,to_char(enddate,'dd-Mon-yy') as endingdate,totalhours,status,length(status) as letterCount,phase from project order by letterCount desc,enddate asc,startdate,pname asc");

        } catch (SQLException ex) {
            logger.error("Error in ViewProject():" + ex.getMessage());
        }

        return rs;
    }

    public ResultSet ViewModule(Connection connection, int pid) throws SQLException {
        try {
            st = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            rs = st.executeQuery("SELECT moduleid,module,modules.pid,pname,customerowner,internalowner,(select count(*) from issue i,issuestatus s where module_id=moduleid and i.issueid=s.issueid and status!='Closed') as issuecount from modules, project where modules.pid=project.pid and modules.pid=" + pid + " order by upper(module) asc");
        } catch (SQLException ex) {
            logger.error("Error in ViewModule():" + ex.getMessage());
        }

        return rs;
    }

    /* (non-Javadoc)
     * @see com.pack.EtrackerBean#EditProject(java.lang.String)
     */

    public ResultSet EditProject(Connection connection, int pid) throws SQLException {
        try {
            st = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            //Edit By sowjnaya
            rs = st.executeQuery("SELECT pname,pmanager,amanager,dmanager,sponsorer,coordinator,stakeholder,version,platform,customer,category,startdate,enddate,totalhours,phase,status,deliverables,wrm_day,starttimeh,starttimem,endtimeh,endtimem,project_domain from project where pid=" + pid + " order by pid");
            //Edit End by sowjanya
        } catch (Exception ex) {
            logger.error("Error in EditProject");
        }

        return rs;
    }

    public ResultSet EditModule(Connection connection, int mid) throws SQLException {
        try {
            st = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            rs = st.executeQuery("SELECT moduleid,module,m.pid,customerowner,internalowner,p.CATEGORY from modules m , project p where moduleid=" + mid + " and m.pid=p.pid order by moduleid");
        } catch (Exception ex) {
            logger.error("Error in EditModule:" + ex.getLocalizedMessage());
        }

        return rs;
    }

    /* (non-Javadoc)
     * @see com.pack.EtrackerBean#ProjectUpdate(java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.String)
     */
    public ResultSet EditUser(Connection connection, String userEmail) throws SQLException {

        try {
            st = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            rs = st.executeQuery("SELECT USERID,FIRSTNAME,LASTNAME,COMPANY,EMAIL,PASSWORD,MOBILE,PHONE,MOBILEOPERATOR,TEAM,LASTLOGGEDON,EMP_ID from users where email='" + StringUtil.fixSqlFieldValue(userEmail) + "' ");
        } catch (SQLException ex) {
            logger.error("Error in EditUser()" + ex.getMessage());
        }

        return rs;
    }

    public ResultSet profile(Connection connection, int userid_curri) throws SQLException {

        try {
            st = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            rs = st.executeQuery("SELECT FIRSTNAME,LASTNAME,COMPANY,EMAIL,phone,mobile,TEAM,LASTLOGGEDON,EMP_ID FROM USERS WHERE userid=" + userid_curri);
        } catch (SQLException ex) {
            logger.error("Error in profile" + ex.getMessage());
        }
        return rs;
    }
//Edit By sowjanya

    public void ProjectUpdate(Connection connection, int pid, String pname, String pmanager, String amanager, String dmanager, String sponsorer, String stakeholder, String coordinator, String version, String platform, String customer, String startdate, String enddate, String totalhours, String phase, String category, String projecttype, String status, String wrmDay, String startH, String startM, String endH, String endM, String project_domain) throws SQLException {
        //Edit End by sowjanya
        String tempenddate = "";
        String tempstartdate = "";
        PreparedStatement projectUpdateps = null;
        PreparedStatement ps1 = null;
        try {
            tempstartdate = ChangeFormat.getDateFormat(startdate);
            tempenddate = ChangeFormat.getDateFormat(enddate);
        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            if (ps1 != null) {
                ps1.close();
            }
        }
        try {
            if (startH == null) {
                startH = "0";
            }
            if (startM == null) {
                startM = "0";
            }
            if (endH == null) {
                endH = "0";
            }
            if (endM == null) {
                endM = "0";
            }
            if (phase == null) {
                phase = projecttype;
            }

            projectUpdateps = connection.prepareStatement("update project set pname=?,pmanager=?,amanager=?,dmanager=?,sponsorer=?,stakeholder=?,coordinator=?,version=?,platform=?,customer=?,startdate=?,enddate=?,totalhours=?, phase=?, category=?, status=?,wrm_day=?,starttimeh=?,starttimem=?,endtimeh=?,endtimem=?,project_domain=? where pid=?", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            projectUpdateps.setString(1, StringUtil.fixSqlFieldValue(pname));
            projectUpdateps.setString(2, StringUtil.fixSqlFieldValue(pmanager));
            projectUpdateps.setString(3, StringUtil.fixSqlFieldValue(amanager));
            projectUpdateps.setString(4, StringUtil.fixSqlFieldValue(dmanager));
            projectUpdateps.setString(5, StringUtil.fixSqlFieldValue(sponsorer));
            projectUpdateps.setString(6, StringUtil.fixSqlFieldValue(stakeholder));
            projectUpdateps.setString(7, StringUtil.fixSqlFieldValue(coordinator));
            projectUpdateps.setString(8, StringUtil.fixSqlFieldValue(version));
            projectUpdateps.setString(9, StringUtil.fixSqlFieldValue(platform));
            projectUpdateps.setString(10, StringUtil.fixSqlFieldValue(customer));
            projectUpdateps.setDate(11, java.sql.Date.valueOf(tempstartdate));
            projectUpdateps.setDate(12, java.sql.Date.valueOf(tempenddate));
            projectUpdateps.setString(13, totalhours);
            projectUpdateps.setString(14, StringUtil.fixSqlFieldValue(phase));
            projectUpdateps.setString(15, StringUtil.fixSqlFieldValue(category));
            projectUpdateps.setString(16, StringUtil.fixSqlFieldValue(status));
            projectUpdateps.setInt(17, Integer.parseInt(wrmDay));
            projectUpdateps.setInt(18, Integer.parseInt(startH));
            projectUpdateps.setInt(19, Integer.parseInt(startM));
            projectUpdateps.setInt(20, Integer.parseInt(endH));
            projectUpdateps.setInt(21, Integer.parseInt(endM));
            //Edit By sowjanya
            projectUpdateps.setString(22, StringUtil.fixSqlFieldValue(project_domain));
            projectUpdateps.setInt(23, pid);
            //Edit End by sowjanya
            int x = projectUpdateps.executeUpdate();
            logger.info(x + ":Project Details has been updated");

        } catch (SQLException ex) {
            logger.error("SQLException while updating project:" + ex.getMessage());
        } finally {
            if (projectUpdateps != null) {
                projectUpdateps.close();
            }
        }

    }

    public void ModuleUpdate(Connection connection, int mid, String module, int customerOwner, int internalOwner, int pid) throws SQLException {

        PreparedStatement moduleUpdateps = null;
        try {
            moduleUpdateps = connection.prepareStatement("update modules set module=? ,customerOwner=?,internalOwner=? where pid=? and moduleid=?");
            moduleUpdateps.setString(1, StringUtil.fixSqlFieldValue(module));
            moduleUpdateps.setInt(4, pid);
            moduleUpdateps.setInt(5, mid);
            moduleUpdateps.setInt(2, customerOwner);
            moduleUpdateps.setInt(3, internalOwner);
            int x = moduleUpdateps.executeUpdate();
            logger.debug(x + ":Project Details has been updated");

        } catch (SQLException ex) {
            logger.error("Error in ModuleUpdate():" + ex.getMessage());
        } finally {
            if (moduleUpdateps != null) {
                moduleUpdateps.close();
            }
        }

    }

    public ResultSet EditUserEmail(Connection connection, String email1) throws SQLException {
        try {
            st = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            rs = st.executeQuery("SELECT FIRSTNAME,LASTNAME,COMPANY,EMAIL,PASSWORD,MOBILE,PHONE,SECRET,ANSWER,MOBILEOPERATOR from users where email='" + StringUtil.fixSqlFieldValue(email1) + "' ");

        } catch (SQLException ex) {
            logger.error("Error in EditUserEmail():" + ex.getMessage());
        }

        return rs;
    }

    public void UserUpdate(Connection connection, String fname, String lname, String company, String email1, String mobile, String mobile1, String phone, String phone1, String phone2, String mail1, String team, String empId, int branch, int newBranch, int userId, int loggedUser, int roleId) throws Exception {
        PreparedStatement userUpdateps = null, branchUpdate;
        try {
            phone = "+" + phone + "-" + phone1 + "-" + phone2;
            mobile = "+" + mobile + "-" + mobile1;
            userUpdateps = connection.prepareStatement("update users SET firstname=?,lastname=?,company=?,email=?,mobile=?,phone=?,team=?,emp_id=?,BRANCH_ID=?,ROLEID=? where email=?");
            userUpdateps.setString(1, StringUtil.fixSqlFieldValue(fname));
            userUpdateps.setString(2, StringUtil.fixSqlFieldValue(lname));
            userUpdateps.setString(3, StringUtil.fixSqlFieldValue(company));
            userUpdateps.setString(4, StringUtil.fixSqlFieldValue(email1));
            userUpdateps.setString(5, mobile);
            userUpdateps.setString(6, phone);
            userUpdateps.setString(7, team);
            userUpdateps.setString(8, empId);
            userUpdateps.setInt(9, newBranch);
            userUpdateps.setInt(10, roleId);
            userUpdateps.setString(11, StringUtil.fixSqlFieldValue(mail1));

            int x = userUpdateps.executeUpdate();
            if (branch != newBranch) {
                branchUpdate = connection.prepareStatement("insert into USER_BRANCH_HISTORY(USERID,OLD_BRANCH_ID,NEW_BRANCH_ID,CHANGEDON,CHANGEDBY) values(?,?,?,?,?)", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                branchUpdate.setInt(1, userId);
                branchUpdate.setInt(2, branch);
                branchUpdate.setInt(3, newBranch);
                branchUpdate.setTimestamp(4, new java.sql.Timestamp(new Date().getTime()));
                branchUpdate.setInt(5, loggedUser);
                branchUpdate.executeUpdate();
            }
            logger.debug(x + ":User Details has been updated");
        } catch (SQLException ex) {
            ex.printStackTrace();
            logger.error("UserUpdate(Connection, String, String, String, String, String, String, String, String, String, String, String) - SQL Connection Exception " + ex.getMessage());
        } finally {
            if (userUpdateps != null) {
                userUpdateps.close();
            }
        }

    }
//Edit By sowjanya

    public void doAction(HttpServletRequest request) throws ServletException, IOException, SQLException, Exception {
        String action = request.getParameter("action");

        if (action == null) {
            action = "";
        }
        if (action.equalsIgnoreCase("create")) {
            //dosomething
        } else if (action.equalsIgnoreCase("update")) {
            String pid = request.getParameter("pid");
            String domainVlaues = request.getParameter("domains");

            Connection connection = null;
            PreparedStatement pst = null;

            try {

                connection = MakeConnection.getConnection();

                pst = connection.prepareStatement("update project set project_domain=? where pid=?");
                pst.setString(1, domainVlaues);
                pst.setInt(2, (Integer.parseInt(pid)));
                int x = pst.executeUpdate();

                logger.debug(x + ":projetc_domain Details has been updated");

            } catch (SQLException ex) {
                logger.error("Error in EditProject123" + ex);
            } finally {
                if (pst != null) {
                    pst.close();
                }
                if (connection != null) {
                    connection.close();
                }
            }
        } else if (action.equalsIgnoreCase("retrieve")) {
            String values = "";
            String pid = request.getParameter("pid");
            try {
                connection = MakeConnection.getConnection();
                st = connection.createStatement();

                rs = st.executeQuery("SELECT project_domain from project where pid=" + pid);
                while (rs.next()) {
                    values = rs.getString(1);

                }
                int j = 0;
                if (values != null) {
                    String value[] = values.split(",");

                    for (int i = 0; i < value.length; i++) {
                        j++;
                        if (j % 2 == 0) {
                            domain_name = domain_name + "<tr style=\"height:21px;\" bgcolor=\"#E8EEF7\" id='domainId" + value[i] + "'><td name='domainValue" + value[i] + "' id='domainValue" + value[i] + "' value='" + value[i] + "'>" + value[i] + "</td><td><span class=\"btnEdit\" onclick=\"editDomain('" + value[i] + "');\" style=\"color: blue;cursor: pointer; \">Edit</span> || <span class=\"btnDelete\" onclick=\"deleteDomain('" + value[i] + "');\" style=\"color: blue;cursor: pointer;\">Delete</span> </td></tr>";
                        } else {
                            domain_name = domain_name + "<tr style=\"height:21px;\" id='domainId" + value[i] + "'><td name='domainValue" + value[i] + "' id='domainValue" + value[i] + "' value='" + value[i] + "'>" + value[i] + "</td><td><span class=\"btnEdit\" onclick=\"editDomain('" + value[i] + "');\" style=\"color: blue;cursor: pointer; \">Edit</span> || <span class=\"btnDelete\" onclick=\"deleteDomain('" + value[i] + "');\" style=\"color: blue;cursor: pointer;\">Delete</span></td> </tr>";
                        }
                    }
                } else {
                    domain_name = "No Domains";
                }
            } catch (Exception ex) {
                logger.error("Error in EditProject123" + ex);
            } finally {
                if (rs != null) {
                    rs.close();
                }
                if (st != null) {
                    st.close();
                }
                if (connection != null) {
                    connection.close();
                }

            }
        } else if (action.equalsIgnoreCase("retrieveByPid")) {

            String values = "";
            String pid = request.getParameter("pid");
            try {
                connection = MakeConnection.getConnection();
                st = connection.createStatement();

                rs = st.executeQuery("SELECT project_domain from project where pid=" + pid);
                while (rs.next()) {
                    values = rs.getString(1);

                }
                domain_name = values;

            } catch (Exception ex) {
                logger.error("Error in EditProject123" + ex);
            } finally {
                if (rs != null) {
                    rs.close();
                }
                if (st != null) {
                    st.close();
                }
                if (connection != null) {
                    connection.close();
                }

            }

        }
    }

    //Edit End by sowjanya   
    public Map<Integer, Integer> getWorkedIssueCountByUserwise(String startDate, String endDate) {
        Map<Integer, Integer> workedIssuesCount = new HashMap<Integer, Integer>();
        try {
            connection = MakeConnection.getConnection();
            st = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            rs = st.executeQuery("select commentedby, count(distinct issuecomments.issueid) from issuecomments,issue where issue.issueid=issuecomments.issueid and comment_date between '" + startDate + "' and '" + endDate + "' and commentedby=commentedto group by commentedby");
            while (rs.next()) {
                workedIssuesCount.put(rs.getInt(1), rs.getInt(2));
            }
        } catch (Exception e) {
            logger.error(e.getMessage());

        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException ex) {

                }
            }
            if (st != null) {
                try {
                    st.close();
                } catch (SQLException ex) {

                }
            }
            if (connection != null) {
                try {
                    connection.close();
                } catch (SQLException ex) {
                }
            }
        }
        return workedIssuesCount;
    }

    public Map<Integer, Integer> getActiveIssueCountByUserwise() {
        Map<Integer, Integer> activeIssuesCount = new HashMap<Integer, Integer>();
        try {
            connection = MakeConnection.getConnection();
            st = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            rs = st.executeQuery("select assignedto,count(issue.issueid) from issue, issuestatus  where issue.issueid=issuestatus.issueid  and issuestatus.status!='Closed' group by assignedto");
            while (rs.next()) {
                activeIssuesCount.put(rs.getInt(1), rs.getInt(2));
            }
        } catch (Exception e) {
            logger.error(e.getMessage());

        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException ex) {

                }
            }
            if (st != null) {
                try {
                    st.close();
                } catch (SQLException ex) {

                }
            }
            if (connection != null) {
                try {
                    connection.close();
                } catch (SQLException ex) {
                }
            }

        }
        return activeIssuesCount;
    }

    public Map<Integer, Float> getEstimatedValue() {
        Map<Integer, Float> estimateValue = new HashMap<Integer, Float>();
        try {
            connection = MakeConnection.getConnection();
            st = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            rs = st.executeQuery("select assignedto,sum(estimated_time) as value from issue i, issuestatus s where s.issueid=i.issueid and status!='Closed' and estimated_time is not null group by assignedto");
            while (rs.next()) {
                estimateValue.put(rs.getInt("assignedto"), rs.getFloat("value"));
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (st != null) {
                    st.close();
                }

            } catch (Exception e) {
                logger.error(e.getMessage());
            }
            try {

                if (rs != null) {
                    rs.close();
                }

            } catch (Exception e) {
                logger.error(e.getMessage());
            }
            try {
                if (connection != null && !connection.isClosed()) {
                    connection.close();
                }
            } catch (SQLException s) {
                logger.error(s);
            }
        }
        return estimateValue;
    }

    public Map<Integer, String> getProjectInvolvedByUser() {
        Map<Integer, String> projectsUser = new HashMap<Integer, String>();
        try {
            connection = MakeConnection.getConnection();
            st = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            rs = st.executeQuery("SELECT USERID,rtrim (xmlagg (xmlelement (e, PNAME|| ',')).extract ('//text()'), ',') projects FROM PROJECT P, USERPROJECT U where  P.PID = U.PID AND STATUS != 'Finished' group by userid ORDER BY userid");
            while (rs.next()) {
                projectsUser.put(rs.getInt("USERID"), rs.getString("projects"));
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (st != null) {
                    st.close();
                }

            } catch (Exception e) {
                logger.error(e.getMessage());
            }
            try {

                if (rs != null) {
                    rs.close();
                }

            } catch (Exception e) {
                logger.error(e.getMessage());
            }
            try {
                if (connection != null && !connection.isClosed()) {
                    connection.close();
                }
            } catch (SQLException s) {
                logger.error(s);
            }
        }
        return projectsUser;
    }

    public UserPerformance getUserPerformance() {
        logger.info("starting time for user performance:" + new Date());
        UserPerformance up = new UserPerformance();
        List<Integer> topPerformance = new ArrayList<Integer>();
        List<Integer> lowPerformance = new ArrayList<Integer>();
        int cnt = 1;
        try {
            connection = MakeConnection.getConnection();
            st = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            String sql = "{call USER_PERFORMANCE}";
            st.execute(sql);

            rs = st.executeQuery("select * from TOP_PERFORMER where to_char(monYear,'Mon-YYYY')= to_char(SYSDATE,'Mon-YYYY') and CLOSEDCOUNT>0 and rownum=1");
            while (rs.next()) {
                up.currentMonthTop.add(rs.getInt("userid"));
            }
            rs = st.executeQuery("select userid,monYear from TOP_PERFORMER,(select monYear as p,max(CLOSEDCOUNT) as counta from TOP_PERFORMER where closedcount>0 group by monYear order by monYear) where p=monYear and counta=CLOSEDCOUNT order by monYear");
            while (rs.next()) {
                topPerformance.add(rs.getInt("userid"));
            }
            Integer[] topers = topPerformance.toArray(new Integer[topPerformance.size()]);
            for (int i = 1; i < topers.length; i++) {
                if (Objects.equals(topers[i], topers[i - 1])) {
                    cnt++;
                    if (cnt == 3) {
                        up.threeMonthsTop.add(topers[i]);
                    }
                } else {
                    cnt = 1;
                }
            }
            rs = st.executeQuery("select sum(CLOSEDCOUNT) as counts,userid from TOP_PERFORMER group by userid order by counts desc");
            int max = 0;
            int min = 0;
            while (rs.next()) {
                if (rs.isFirst()) {
                    max = rs.getInt("counts");
                }
                if (rs.isLast()) {
                    min = rs.getInt("counts");
                }
                if (max == rs.getInt("counts")) {
                    up.maxCount.add(rs.getInt("userid"));
                }
            }
            rs.beforeFirst();
            while (rs.next()) {
                if (min == rs.getInt("counts")) {
                    up.minCount.add(rs.getInt("userid"));
                }
            }
//            if (up.currentMonthTop.isEmpty()) {
//            } else {
            rs = st.executeQuery("select userid,monYear,CLOSEDCOUNT from TOP_PERFORMER,(select monYear as p,min(CLOSEDCOUNT) as counta from TOP_PERFORMER where to_char(monYear,'Mon-YYYY')= to_char(SYSDATE,'Mon-YYYY') group by monYear ) where p=monYear and counta=CLOSEDCOUNT");
            while (rs.next()) {
                up.currentMonthLeast.add(rs.getInt("userid"));
            }
//            }
            rs = st.executeQuery("select userid,monYear,CLOSEDCOUNT from TOP_PERFORMER,(select monYear as p,min(CLOSEDCOUNT) as counta from TOP_PERFORMER group by monYear order by monYear) where p=monYear and counta=CLOSEDCOUNT order by userid,monYear");
            while (rs.next()) {
                lowPerformance.add(rs.getInt("userid"));
            }
            Integer[] lower = lowPerformance.toArray(new Integer[lowPerformance.size()]);
            for (int i = 1; i < lower.length; i++) {
                if (Objects.equals(lower[i], lower[i - 1])) {
                    cnt++;
                    if (cnt == 3) {
                        up.threeMonthsLeast.add(lower[i]);
                    }
                } else {
                    cnt = 1;
                }
            }

            logger.info("end time for user performance:" + new Date());
        } catch (Exception e) {
            e.printStackTrace();
            logger.error(e.getMessage());
        } finally {
            try {
                if (st != null) {
                    st.close();
                }
            } catch (Exception e) {
                logger.error(e.getMessage());
            }
            try {
                if (rs != null) {
                    rs.close();
                }
            } catch (Exception e) {
                logger.error(e.getMessage());
            }
            try {
                if (connection != null && !connection.isClosed()) {
                    connection.close();
                }
            } catch (SQLException s) {
                logger.error(s);
            }
        }
        return up;
    }

    public List<specifiedAllUsers> getAllSpecificUsers() throws Exception {
        List<specifiedAllUsers> usersList = new ArrayList<specifiedAllUsers>();
        Connection connection = null;
        CallableStatement callableStatement = null;
        ResultSet rs = null;
        try {
            connection = MakeConnection.getConnection();
            String sql = "{call PROC_getAllSpecificTeamUsers(?)}";
            callableStatement = connection.prepareCall(sql);
            callableStatement.registerOutParameter(1, OracleTypes.CURSOR);
            callableStatement.executeUpdate();
            rs = (ResultSet) callableStatement.getObject(1);
            while (rs.next()) {
                specifiedAllUsers u = new specifiedAllUsers();

                u.setUserid(Integer.parseInt(rs.getString(1)));
                u.setTitle(rs.getString(2));
                u.setName(rs.getString(3));
                u.setCompany(rs.getString(4));
                u.setPhone(rs.getString(5));
                u.setEmail(rs.getString(6));
                u.setMobile(rs.getString(7));
                if (Integer.parseInt(rs.getString(8)) == 0) {
                    u.setRoleName("Yet To Approve");
                } else if (Integer.parseInt(rs.getString(8)) == 2) {
                    u.setRoleName("Approved");
                } else if (Integer.parseInt(rs.getString(8)) == -1) {
                    u.setRoleName("Denied");
                } else if (Integer.parseInt(rs.getString(8)) == -2) {
                    u.setRoleName("Disabled");
                }

                u.setTeam(rs.getString(9));
                usersList.add(u);
            }

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (callableStatement != null) {
                    callableStatement.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (Exception e) {
                logger.error(e.getMessage());
            }
        }

        return usersList;
    }

}

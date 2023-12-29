package com.pack;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.Date;
import org.apache.log4j.Logger;

import pack.eminent.encryption.Encryption;

import com.eminent.util.UpdateUserProject;

public class RegisterBean {

    static Logger logger = Logger.getLogger("RegisterBean");
    Encryption encryption = new Encryption();
    Statement statement1, statement2;
    ResultSet resultset1, resultSet2;
    PreparedStatement preparedStatement3;
    int flag;
    String uname = "";

    private String firstName = "";
    private String lastName = "";
    private String password = "";
    private String company = "";
    private String userEmail = "";
    private String secret = "";
    private String answer = "";
    private String phone = "";
    private String mobile = "";
    private String phone1 = "";
    private String mobile1 = "";
    private String phone2 = "";
    private String operator = "";
    private String team = "";
    private String project = null;
    private Timestamp registeredon;

    public String getProject() {
        return project;
    }

    public void setProject(String project) {
        this.project = project;
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
     * @see com.pack.EtrackerBean#setPassword(java.lang.String)
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
     * @see com.pack.EtrackerBean#setPassword(java.lang.String)
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

    public String getOperator() {
        return operator;
    }
    /* (non-Javadoc)
     * @see com.pack.EtrackerBean#setMobile(java.lang.String)
     */

    public void setOperator(String operator) {
        if (operator != null) {
            this.operator = operator;
        }
    }

    public String getTeam() {
        return team;
    }
    /* (non-Javadoc)
     * @see com.pack.EtrackerBean#setMobile(java.lang.String)
     */

    public void setTeam(String team) {
        if (team != null) {
            this.team = team;
        }
    }

    public Date getRegisteredon() {
        return this.registeredon;
    }

    public void setApprovedon(Timestamp registeredon) {
        this.registeredon = registeredon;
    }

    @Override
    public String toString() {
        return "RegisterBean{" + "flag=" + flag + ", uname=" + uname + ", firstName=" + firstName + ", lastName=" + lastName + ", password=" + password + ", company=" + company + ", userEmail=" + userEmail + ", secret=" + secret + ", answer=" + answer + ", phone=" + phone + ", mobile=" + mobile + ", phone1=" + phone1 + ", mobile1=" + mobile1 + ", phone2=" + phone2 + ", operator=" + operator + ", team=" + team + ", project=" + project + ", registeredon=" + registeredon + '}';
    }

    public boolean UserExist(Connection connection, String UserEmail) throws SQLException {
        statement1 = connection.createStatement();
        resultset1 = statement1.executeQuery("select email from users");
        if (resultset1 != null) {
            while (resultset1.next()) {
                uname = resultset1.getString("email");
                logger.info("DB User" + uname);
                if (uname.equals(UserEmail)) {
                    return true;
                }
            }
        }
        return false;
    }

    public void CreateUser(Connection connection, String email) throws Exception {

        int roleUser = 0;
        int value = 0;
        Timestamp date = new Timestamp(new java.util.Date().getTime());
        statement1 = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
        resultset1 = statement1.executeQuery("select userid_seq.nextval from dual");
        if (resultset1 != null) {
            while (resultset1.next()) {
                String st2 = resultset1.getString("nextval");
                int st1 = Integer.parseInt(st2);
                statement2 = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                resultSet2 = statement2.executeQuery("select roleid from role where role='Unconfirmed'");

                if (resultSet2 != null) {
                    while (resultSet2.next()) {
                        roleUser = resultSet2.getInt("roleid");
                    }
                }
                phone = "+" + phone + "-" + phone1 + "-" + phone2;
                mobile = "+" + mobile + "-" + mobile1;

                preparedStatement3 = connection.prepareStatement("insert into users(userid,firstname,lastname,password,email,company,secret,answer,phone,mobile,roleid,mobileoperator,team,value,registeredon) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
                preparedStatement3.setInt(1, st1);
                preparedStatement3.setString(2, firstName);
                preparedStatement3.setString(3, lastName);
                preparedStatement3.setString(4, Encryption.encrypt(password));
                preparedStatement3.setString(5, email);
                preparedStatement3.setString(6, company);
                preparedStatement3.setString(7, secret);
                preparedStatement3.setString(8, answer);

                preparedStatement3.setString(9, phone);
                preparedStatement3.setString(10, mobile);
                preparedStatement3.setInt(11, roleUser);
                preparedStatement3.setString(12, operator);
                preparedStatement3.setString(13, team);
                preparedStatement3.setInt(14, value);
                preparedStatement3.setTimestamp(15, date);
                preparedStatement3.executeUpdate();

            }
        }

    }

    public void createUser(Connection connection, String email) throws Exception {

        int roleUser = 0;
        int value = 0;
        Timestamp date = new Timestamp(new java.util.Date().getTime());
        statement1 = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
        resultset1 = statement1.executeQuery("select userid_seq.nextval from dual");
        if (resultset1 != null) {
            while (resultset1.next()) {
                String st2 = resultset1.getString("nextval");
                int st1 = Integer.parseInt(st2);
                statement2 = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                resultSet2 = statement2.executeQuery("select roleid from role where role='Unconfirmed'");

                if (resultSet2 != null) {
                    while (resultSet2.next()) {
                        roleUser = resultSet2.getInt("roleid");
                    }
                }
                phone = "+" + phone + "-" + phone1 + "-" + phone2;
                mobile = "+" + mobile + "-" + mobile1;

                preparedStatement3 = connection.prepareStatement("insert into users(userid,firstname,lastname,password,email,company,secret,answer,phone,mobile,roleid,mobileoperator,team,value,registeredon) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
                preparedStatement3.setInt(1, st1);
                preparedStatement3.setString(2, firstName);
                preparedStatement3.setString(3, lastName);
                preparedStatement3.setString(4, Encryption.encrypt(password));
                preparedStatement3.setString(5, email);
                preparedStatement3.setString(6, company);
                preparedStatement3.setString(7, secret);
                preparedStatement3.setString(8, answer);

                preparedStatement3.setString(9, phone);
                preparedStatement3.setString(10, mobile);
                preparedStatement3.setInt(11, roleUser);
                preparedStatement3.setString(12, operator);
                preparedStatement3.setString(13, team);
                preparedStatement3.setInt(14, value);
                preparedStatement3.setTimestamp(15, date);
                preparedStatement3.executeUpdate();

                //updating project assigned
                UpdateUserProject.UpdateUsers(project, st2);

            }
        }

    }

    public void createUser(Connection connection, RegisterBean registerBean) throws Exception {

        int roleUser = 0;
        int value = 0;
        Timestamp date = new Timestamp(new java.util.Date().getTime());
        statement1 = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
        resultset1 = statement1.executeQuery("select userid_seq.nextval from dual");
        if (resultset1 != null) {
            while (resultset1.next()) {
                String st2 = resultset1.getString("nextval");
                int st1 = Integer.parseInt(st2);
                statement2 = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                resultSet2 = statement2.executeQuery("select roleid from role where role='Unconfirmed'");

                if (resultSet2 != null) {
                    while (resultSet2.next()) {
                        roleUser = resultSet2.getInt("roleid");
                    }
                }
                phone = "+" + registerBean.getPhone() + "-" + registerBean.getPhone1() + "-" + registerBean.getPhone2();
                mobile = "+" + registerBean.getMobile() + "-" + registerBean.getMobile1();

                preparedStatement3 = connection.prepareStatement("insert into users(userid,firstname,lastname,password,email,company,secret,answer,phone,mobile,roleid,mobileoperator,team,value,registeredon) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
                preparedStatement3.setInt(1, st1);
                preparedStatement3.setString(2, registerBean.getFirstName());
                preparedStatement3.setString(3, registerBean.getLastName());
                preparedStatement3.setString(4, Encryption.encrypt(registerBean.getPassword()));
                preparedStatement3.setString(5, registerBean.getUserEmail());
                preparedStatement3.setString(6, registerBean.getCompany());
                preparedStatement3.setString(7, registerBean.getSecret());
                preparedStatement3.setString(8, registerBean.getAnswer());

                preparedStatement3.setString(9, phone);
                preparedStatement3.setString(10, mobile);
                preparedStatement3.setInt(11, roleUser);
                preparedStatement3.setString(12, registerBean.getOperator());
                preparedStatement3.setString(13, team);
                preparedStatement3.setInt(14, value);
                preparedStatement3.setTimestamp(15, date);
                preparedStatement3.executeUpdate();

                //updating project assigned
                UpdateUserProject.UpdateUsers(project, st2);

            }
        }

    }

}

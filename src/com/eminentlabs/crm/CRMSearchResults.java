/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminentlabs.crm;

import com.eminentlabs.erm.ERMSearchResults;
import com.pack.CRMIssueBean;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.concurrent.TimeUnit;
import java.util.logging.Level;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.apache.log4j.Logger;
import pack.eminent.encryption.MakeConnection;

/**
 *
 * @author RN.Khans
 */
public class CRMSearchResults {

    static Logger logger = null;

    static {
        logger = Logger.getLogger("CRMSearchResults");
    }

    private String query = "";
    private String crmType = "";
    private String encodedQuery = "";

    public String setQuery(HttpServletRequest request) throws ParseException {
        crmType = request.getParameter("crmType");
        String company = request.getParameter("company");
        String state = request.getParameter("state");
        String city = request.getParameter("city");
        HttpSession session = request.getSession();
        String createdby = request.getParameter("createdby");
        String createdon = request.getParameter("createdon"); // selection
        String created = request.getParameter("created");
        String createdFrom = request.getParameter("createdFrom");
        String createdTo = request.getParameter("createdTo");

        String modifiedby = request.getParameter("modifiedby");
        String modifiedon = request.getParameter("modifiedon"); // selection
        String modified = request.getParameter("modified");
        String modifiedFrom = request.getParameter("modifiedFrom");
        String modifiedTo = request.getParameter("modifiedTo");

        String assignedTo = request.getParameter("assignedTo");
        String duedate = request.getParameter("duedate");
        String duedateon = request.getParameter("duedateon");  // selection
        String duedateFrom = request.getParameter("duedateFrom");
        String duedateTo = request.getParameter("duedateTo");

        String rating = request.getParameter("rating");
        String product = request.getParameter("product");
        String erp = request.getParameter("erp");
        String vendor = request.getParameter("vendor");
        String area = request.getParameter("area");
        String industry = request.getParameter("industry");
        String department = request.getParameter("department");
        String contactType = request.getParameter("contactType");

        SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy");
        SimpleDateFormat sdfInput = new SimpleDateFormat("dd-MM-yyyy");

        if (crmType.equalsIgnoreCase("contact")) {
            query = "select distinct(a.CONTACTID) as id,a.firstname||' '||a.lastname as name,a.title as title,c.firstname||' '||c.lastname as ownerName,	d.firstname||' '||d.lastname as assignedtoName,a.ACCOUNTNAME as accountName,	a.phone as phone,a.email as email,	a.DUEDATE as duedate,	a.createdon as createdon,industry,contact_type from CONTACT a left join CONTACT_COMMENTS b on a.contactid = b.contactid ,users c,users d where c.userid = a.CONTACT_OWNER and d.userid = a.assignedto and a.roleid=2";
        } else if (crmType.equalsIgnoreCase("lead")) {
            query = "select distinct(a.LEADID) as id,a.firstname||' '||a.lastname as name,a.title as title,c.firstname||' '||c.lastname as ownerName,d.firstname||' '||d.lastname as assignedtoName ,a.phone as phone,a.email as email,a.DUEDATE as duedate,	a.createdon as createdon,a.rating as rating,a.LEADSTATUS as status,a.modifiedon as modifiedon,a.company as company,lead_type from lead a left join LEAD_COMMENTS b on a.leadid = b.leadid ,users c,users d where c.userid = a.LEAD_OWNER and d.userid = a.assignedto and a.roleid=2";
        } else if (crmType.equalsIgnoreCase("opportunity")) {
            query = "SELECT distinct(a.OPPORTUNITYID) as id ,a.OPPORTUNITYNAME as name, c.firstname||' '||c.lastname as assignedtoName , a.CLOSE_DATE as duedate,a.STAGE as status,a.PROBABILITY as prob,a.MODIFIEDON as modifiedon from opportunity a left join OPPORTUNITY_COMMENTS b on a.OPPORTUNITYID=b.OPPORTUNITYID,users c,LEAD l where a.LEAD_REFERENCE=l.leadid and c.userid = a.assignedto and a.roleid=2 ";
        } else if (crmType.equalsIgnoreCase("account")) {
            if ((product != null && !"".equals(product)) || (rating != null && !"".equals(rating))) {
                query = "SELECT distinct(a.ACCOUNTID) as id,a.ACCOUNTNAME as name,a.billingstate as state,a.type as status, c.firstname||' '||c.lastname as assignedtoName, a.OPPORTUNITY_REFERENCE as reference, a.phone as phone, a.duedate as duedate, a.ACCOUNT_AMOUNT as amount,a.CREATEDON as createdon,a.MODIFIEDON as modifiedon  from ACCOUNT a left join ACCOUNT_COMMENTS b on a.ACCOUNTID=b.ACCOUNTID,users c,lead l,opportunity o where c.userid = a.assignedto and a.roleid=2 and a.OPPORTUNITY_REFERENCE =o.OPPORTUNITYid and o.LEAD_REFERENCE = l.leadid ";
            } else {
                query = "SELECT distinct(a.ACCOUNTID) as id ,a.ACCOUNTNAME as name,a.billingstate as state,a.type as status, c.firstname||' '||c.lastname as assignedtoName, a.OPPORTUNITY_REFERENCE as reference, a.phone as phone, a.duedate as duedate, a.ACCOUNT_AMOUNT as amount,a.CREATEDON as createdon,a.MODIFIEDON as modifiedon from ACCOUNT a left join ACCOUNT_COMMENTS b on a.ACCOUNTID=b.ACCOUNTID,users c,OPPORTUNITY o,LEAD l where c.userid = a.assignedto and a.roleid=2";
            }
        }

        /**
         * Contact search filter
         */
        if (crmType.equalsIgnoreCase("contact")) {
            if (company != null && !"".equals(company)) {
                query = query + " and a.company like '%" + company + "%'";
            }
            if (state != null && !"".equals(state)) {
                query = query + " and a.MAILINGSTATE = '" + state + "'";
            }

            if (city != null && !"".equals(city)) {
                query = query + " and a.MAILINGCITY = '" + city + "'";
            }

            if (createdby != null && !"".equals(createdby)) {
                query = query + " and a.CONTACT_OWNER = '" + createdby + "'";
            }

            if (modifiedby != null && !"".equals(modifiedby)) {
                query = query + " and b.COMMENTEDBY = '" + modifiedby + "'";
            }
            if (assignedTo != null && !"".equals(assignedTo)) {
                query = query + " and a.ASSIGNEDTO = '" + assignedTo + "'";
            }

            if (rating != null && !"".equals(rating)) {
                query = query + " and a.rating = '" + rating + "'";
            }
            if (erp != null && !"".equals(erp)) {
                query = query + " and a.erp = '" + erp + "'";
            }
            if (vendor != null && !"".equals(vendor)) {
                query = query + " and a.vendor like '%" + vendor + "%'";
            }
            if (industry != null && !"".equals(industry)) {
                query = query + " and industry =" + industry + "";
            }

            if (product != null && !"".equals(product)) {
                query = query + " and a.INTERESTED = '" + product + "'";
            }

            if (area != null && !"".equals(area)) {
                query = query + " and a.MAILINGAREA = '" + area + "'";
            }

            if (department != null && !"".equals(department)) {
                query = query + " and department ='" + department + "'";
            }
            if (contactType != null && !"".equals(contactType)) {
                query = query + " and contact_type ='" + contactType + "'";
            }
            /**
             * Lead search filter
             */
        } else if (crmType.equalsIgnoreCase("lead")) {
            if (company != null && !"".equals(company)) {
                query = query + " and a.company like '%" + company + "%'";
            }
            if (state != null && !"".equals(state)) {
                query = query + " and a.state = '" + state + "'";
            }

            if (city != null && !"".equals(city)) {
                query = query + " and a.city = '" + city + "'";
            }

            if (createdby != null && !"".equals(createdby)) {
                query = query + " and a.LEAD_OWNER = '" + createdby + "'";
            }

            if (modifiedby != null && !"".equals(modifiedby)) {
                query = query + " and b.COMMENTEDBY = '" + modifiedby + "'";
            }
            if (assignedTo != null && !"".equals(assignedTo)) {
                query = query + " and a.ASSIGNEDTO = '" + assignedTo + "'";
            }

            if (rating != null && !"".equals(rating)) {
                query = query + " and a.rating = '" + rating + "'";
            }

            if (product != null && !"".equals(product)) {
                query = query + " and a.INTERESTED = '" + product + "'";
            }
            if (erp != null && !"".equals(erp)) {
                query = query + " and a.erp = '" + erp + "'";
            }
            if (vendor != null && !"".equals(vendor)) {
                query = query + " and a.vendor like '%" + vendor + "%'";
            }
            if (area != null && !"".equals(area)) {
                query = query + " and a.area = '" + area + "'";
            }
            if (contactType != null && !"".equals(contactType)) {
                query = query + " and lead_type ='" + contactType + "'";
            }
            if (industry != null && !"".equals(industry)) {
                query = query + " and industry =" + industry + "";
            }

            /*
             *       opportunity
             */
        } else if (crmType.equalsIgnoreCase("opportunity")) {
            if (company != null && !"".equals(company)) {
                query = query + " and a.OPPORTUNITYNAME like '%" + company + "%'";
            }
            if (state != null && !"".equals(state)) {
                query = query + " and l.state = '" + state + "'";
            }

            if (city != null && !"".equals(city)) {
                query = query + " and l.city = '" + city + "'";
            }

            if (createdby != null && !"".equals(createdby)) {
                query = query + " and a.OPPORTUNITY_OWNER = '" + createdby + "'";
            }

            if (modifiedby != null && !"".equals(modifiedby)) {
                query = query + " and b.COMMENTEDBY = '" + modifiedby + "'";
            }
            if (assignedTo != null && !"".equals(assignedTo)) {
                query = query + " and a.ASSIGNEDTO = '" + assignedTo + "'";
            }

            if (rating != null && !"".equals(rating)) {
                query = query + " and l.rating = '" + rating + "'";
            }

            if (product != null && !"".equals(product)) {
                query = query + " and l.INTERESTED = '" + product + "'";
            }

            if (area != null && !"".equals(area)) {
                query = query + " and l.area = '" + area + "'";
            }
            /*
             Account
             */
        } else if (crmType.equalsIgnoreCase("account")) {
            if (company != null && !"".equals(company)) {
                query = query + " and a.ACCOUNTNAME like '%" + company + "%'";
            }
            if (state != null && !"".equals(state)) {
                query = query + " and a.BILLINGSTATE = '" + state + "'";
            }

            if (city != null && !"".equals(city)) {
                query = query + " and a.BILLINGCITY = '" + city + "'";
            }

            if (createdby != null && !"".equals(createdby)) {
                query = query + " and a.ACCOUNT_OWNER = '" + createdby + "'";
            }

            if (modifiedby != null && !"".equals(modifiedby)) {
                query = query + " and b.COMMENTEDBY = '" + modifiedby + "'";
            }
            if (assignedTo != null && !"".equals(assignedTo)) {
                query = query + " and a.ASSIGNEDTO = '" + assignedTo + "'";
            }

            if (rating != null && !"".equals(rating)) {
                query = query + " and l.rating = '" + rating + "'";
            }

            if (product != null && !"".equals(product)) {
                query = query + " and l.INTERESTED = '" + product + "'";
            }
        }

        if (createdon != null && !"".equals(createdon)) {
            if (createdon.equalsIgnoreCase("Between")) {
                if ((createdFrom != null && !"".equals(createdFrom)) && (createdTo != null && !"".equals(createdTo))) {
                    createdFrom = sdf.format(sdfInput.parse(createdFrom));
                    createdTo = sdf.format(sdfInput.parse(createdTo));
                    query = query + " and  (to_date(to_char(a.createdon, 'DD-Mon-YYYY'),'DD-Mon-YYYY') between '" + createdFrom + "' and '" + createdTo + "')";
                }
            } else if (createdon.equalsIgnoreCase("After")) {
                if (created != null && !"".equals(created)) {
                    created = sdf.format(sdfInput.parse(created));
                    query = query + " And (to_date(to_char(a.createdon, 'DD-Mon-YYYY'),'DD-Mon-YYYY') >  '" + created + "')";
                }
            } else if (createdon.equalsIgnoreCase("Before")) {
                if (created != null && !"".equals(created)) {
                    created = sdf.format(sdfInput.parse(created));
                    query = query + " And (to_date(to_char(a.createdon, 'DD-Mon-YYYY'),'DD-Mon-YYYY') <  '" + created + "')";
                }
            } else if (createdon.equalsIgnoreCase("on")) {
                if (created != null && !"".equals(created)) {
                    created = sdf.format(sdfInput.parse(created));
                    query = query + " And (to_date(to_char(a.createdon, 'DD-Mon-YYYY'),'DD-Mon-YYYY') =  '" + created + "')";
                }
            } else if (createdon.equalsIgnoreCase("today")) {
                query = query + " And (to_char(a.createdon, 'DD-Mon-YYYY')=(SELECT TO_CHAR(SYSDATE, 'DD-Mon-YYYY') FROM DUAL))";
            }
        }
        if (!crmType.equalsIgnoreCase("opportunity")) {
            if (duedateon != null && !"".equals(duedateon)) {
                if (duedateon.equalsIgnoreCase("Between")) {
                    if ((duedateFrom != null && !"".equals(duedateFrom)) && (duedateTo != null && !"".equals(duedateTo))) {
                        duedateFrom = sdf.format(sdfInput.parse(duedateFrom));
                        duedateTo = sdf.format(sdfInput.parse(duedateTo));
                        query = query + " and  (to_date(to_char(a.DUEDATE, 'DD-Mon-YYYY'),'DD-Mon-YYYY') between '" + duedateFrom + "' and '" + duedateTo + "')";
                    }
                } else if (duedateon.equalsIgnoreCase("After")) {
                    if (duedate != null && !"".equals(duedate)) {
                        duedate = sdf.format(sdfInput.parse(duedate));
                        query = query + " And (to_date(to_char(a.DUEDATE, 'DD-Mon-YYYY'),'DD-Mon-YYYY') >  '" + duedate + "')";
                    }
                } else if (duedateon.equalsIgnoreCase("Before")) {
                    if (duedate != null && !"".equals(duedate)) {
                        duedate = sdf.format(sdfInput.parse(duedate));
                        query = query + " And (to_date(to_char(a.DUEDATE, 'DD-Mon-YYYY'),'DD-Mon-YYYY') <  '" + duedate + "')";
                    }
                } else if (duedateon.equalsIgnoreCase("on")) {
                    if (duedate != null && !"".equals(duedate)) {
                        duedate = sdf.format(sdfInput.parse(duedate));
                        query = query + " And (to_date(to_char(a.DUEDATE, 'DD-Mon-YYYY'),'DD-Mon-YYYY') =  '" + duedate + "')";
                    }
                } else if (duedateon.equalsIgnoreCase("today")) {
                    query = query + " And (to_char(a.DUEDATE, 'DD-Mon-YYYY')=(SELECT TO_CHAR(SYSDATE, 'DD-Mon-YYYY') FROM DUAL))";
                }
            }
        } else {
            if (duedateon != null && !"".equals(duedateon)) {
                if (duedateon.equalsIgnoreCase("Between")) {
                    if ((duedateFrom != null && !"".equals(duedateFrom)) && (duedateTo != null && !"".equals(duedateTo))) {
                        duedateFrom = sdf.format(sdfInput.parse(duedateFrom));
                        duedateTo = sdf.format(sdfInput.parse(duedateTo));
                        query = query + " and  (to_date(to_char(a.CLOSE_DATE, 'DD-Mon-YYYY'),'DD-Mon-YYYY') between '" + duedateFrom + "' and '" + duedateTo + "')";
                    }
                } else if (duedateon.equalsIgnoreCase("After")) {
                    if (duedate != null && !"".equals(duedate)) {
                        duedate = sdf.format(sdfInput.parse(duedate));
                        query = query + " And (to_date(to_char(a.CLOSE_DATE, 'DD-Mon-YYYY'),'DD-Mon-YYYY') >  '" + duedate + "')";
                    }
                } else if (duedateon.equalsIgnoreCase("Before")) {
                    if (duedate != null && !"".equals(duedate)) {
                        duedate = sdf.format(sdfInput.parse(duedate));
                        query = query + " And (to_date(to_char(a.CLOSE_DATE, 'DD-Mon-YYYY'),'DD-Mon-YYYY') <  '" + duedate + "')";
                    }
                } else if (duedateon.equalsIgnoreCase("on")) {
                    if (duedate != null && !"".equals(duedate)) {
                        duedate = sdf.format(sdfInput.parse(duedate));
                        query = query + " And (to_date(to_char(a.CLOSE_DATE, 'DD-Mon-YYYY'),'DD-Mon-YYYY') =  '" + duedate + "')";
                    }
                } else if (duedateon.equalsIgnoreCase("today")) {
                    query = query + " And (to_char(a.CLOSE_DATE, 'DD-Mon-YYYY')=(SELECT TO_CHAR(SYSDATE, 'DD-Mon-YYYY') FROM DUAL))";
                }
            }
        }

        if (modifiedon != null && !"".equals(modifiedon)) {
            if (modifiedon.equalsIgnoreCase("Between")) {
                if ((modifiedFrom != null && !"".equals(modifiedFrom)) && (modifiedTo != null && !"".equals(modifiedTo))) {
                    modifiedFrom = sdf.format(sdfInput.parse(modifiedFrom));
                    modifiedTo = sdf.format(sdfInput.parse(modifiedTo));
                    query = query + " and  (to_date(to_char(b.COMMENT_DATE, 'DD-Mon-YYYY'),'DD-Mon-YYYY') between '" + modifiedFrom + "' and '" + modifiedTo + "')";
                }
            } else if (modifiedon.equalsIgnoreCase("After")) {
                if (modified != null && !"".equals(modified)) {
                    modified = sdf.format(sdfInput.parse(modified));
                    query = query + " And (to_date(to_char(b.COMMENT_DATE, 'DD-Mon-YYYY'),'DD-Mon-YYYY') >  '" + modified + "')";
                }
            } else if (modifiedon.equalsIgnoreCase("Before")) {
                if (modified != null && !"".equals(modified)) {
                    modified = sdf.format(sdfInput.parse(modified));
                    query = query + " And (to_date(to_char(b.COMMENT_DATE, 'DD-Mon-YYYY'),'DD-Mon-YYYY') <  '" + modified + "')";
                }
            } else if (modifiedon.equalsIgnoreCase("on")) {
                if (modified != null && !"".equals(modified)) {
                    modified = sdf.format(sdfInput.parse(modified));
                    query = query + " And (to_date(to_char(b.COMMENT_DATE, 'DD-Mon-YYYY'),'DD-Mon-YYYY') =  '" + modified + "')";
                }
            } else if (modifiedon.equalsIgnoreCase("today")) {
                query = query + " And (to_char(b.COMMENT_DATE, 'DD-Mon-YYYY')=(SELECT TO_CHAR(SYSDATE, 'DD-Mon-YYYY') FROM DUAL))";
            }
        }
        try {
            encodedQuery = URLEncoder.encode(query, "UTF-8");
            session.setAttribute("crmSearchQuery", query);
            session.setAttribute("crmType", crmType);
        } catch (UnsupportedEncodingException ex) {
            java.util.logging.Logger.getLogger(CRMSearchResults.class.getName()).log(Level.SEVERE, "URL encode done wrong", ex);
        }
        System.out.println("query : " + query);
        return query;
    }

    public List<CRMSearchBean> getSearchQuery(String query, String crmType) {
        List<CRMSearchBean> list = new ArrayList<CRMSearchBean>();
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        CRMIssueBean issue = new CRMIssueBean();
        try {
            SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yy");
            Date date = new Date();
            Date createdon;
            date = sdf.parse(sdf.format(date));
            connection = MakeConnection.getConnection();
            logger.info(" Query :" + query);
            statement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            resultset = statement.executeQuery(query);
            while (resultset.next()) {
                CRMSearchBean bean = new CRMSearchBean();
                bean.setId(resultset.getString("id"));

                if (crmType.equalsIgnoreCase("contact")) {
                    bean.setContactType(resultset.getString("contact_type"));
                    bean.setAccountName(resultset.getString("accountName"));
                    bean.setName(resultset.getString("name"));
                    bean.setTitle(resultset.getString("title"));
                    bean.setPhone(resultset.getString("phone"));
                    bean.setEmail(resultset.getString("email"));
                    bean.setOwnerName(resultset.getString("ownerName"));
                    bean.setDuedate(resultset.getDate("duedate") == null ? "" : sdf.format(resultset.getDate("duedate")));
                    bean.setAssingedTo(resultset.getString("assignedtoName"));
                    createdon = sdf.parse(sdf.format(resultset.getDate("createdon")));
                    long diff = date.getTime() - createdon.getTime();
                    String days = String.valueOf(TimeUnit.DAYS.convert(diff, TimeUnit.MILLISECONDS) + 1);
                    bean.setAge(days);
                    list.add(bean);
                } else if (crmType.equalsIgnoreCase("lead")) {
                    bean.setContactType(resultset.getString("lead_type"));
                    bean.setCompany(resultset.getString("COMPANY"));
                    bean.setModifiedon(sdf.format(resultset.getDate("MODIFIEDON")));
                    bean.setRating(resultset.getString("RATING"));
                    bean.setStatus(resultset.getString("STATUS"));
                    bean.setName(resultset.getString("name"));
                    bean.setTitle(resultset.getString("title"));
                    bean.setPhone(resultset.getString("phone"));
                    bean.setEmail(resultset.getString("email"));
                    bean.setOwnerName(resultset.getString("ownerName"));
                    bean.setDuedate(resultset.getDate("duedate") == null ? "" : sdf.format(resultset.getDate("duedate")));
                    bean.setAssingedTo(resultset.getString("assignedtoName"));
                    createdon = sdf.parse(sdf.format(resultset.getDate("createdon")));
                    long diff = date.getTime() - createdon.getTime();
                    String days = String.valueOf(TimeUnit.DAYS.convert(diff, TimeUnit.MILLISECONDS) + 1);
                    bean.setAge(days);
                    list.add(bean);
                } else if (crmType.equalsIgnoreCase("opportunity")) {
                    bean.setName(resultset.getString("name"));
                    bean.setAssingedTo(resultset.getString("assignedtoName"));
                    bean.setProbability(resultset.getString("prob"));
                    bean.setDuedate(resultset.getDate("duedate") == null ? "" : sdf.format(resultset.getDate("duedate")));
                    bean.setModifiedon(sdf.format(resultset.getDate("MODIFIEDON")));
                    bean.setStatus(resultset.getString("STATUS"));
                    list.add(bean);
                } else if (crmType.equalsIgnoreCase("account")) {
                    bean.setName(resultset.getString("name"));
                    bean.setAssingedTo(resultset.getString("assignedtoName"));
                    bean.setAmount(resultset.getString("AMOUNT"));       // 
                    bean.setDuedate(sdf.format(resultset.getDate("duedate")));
                    bean.setModifiedon(sdf.format(resultset.getDate("MODIFIEDON")));
                    bean.setStatus(resultset.getString("STATUS"));
                    bean.setPhone(resultset.getString("phone"));
                    bean.setState(resultset.getString("STATE"));
                    createdon = sdf.parse(sdf.format(resultset.getDate("createdon")));
                    long diff = date.getTime() - createdon.getTime();
                    String days = String.valueOf(TimeUnit.DAYS.convert(diff, TimeUnit.MILLISECONDS) + 1);
                    bean.setAge(days);
                    if (resultset.getString("REFERENCE") == null) {
                        bean.setDealValue("NA");
                    } else {
                        bean.setDealValue(issue.getOpportunityValue(connection, Integer.parseInt(resultset.getString("REFERENCE"))));
                    }
                    list.add(bean);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("getSearchQuery" + e.getMessage());
        } finally {
            try {
                if (resultset != null) {
                    resultset.close();
                }
                if (statement != null) {
                    statement.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (Exception ex) {
                logger.error("getSearchQuery" + ex.getMessage());
            }
        }
        return list;
    }

    public String getQuery() {
        return query;
    }

    public void setQuery(String query) {
        this.query = query;
    }

    public String getCrmType() {
        return crmType;
    }

    public void setCrmType(String crmType) {
        this.crmType = crmType;
    }

    public String getEncodedQuery() {
        return encodedQuery;
    }

    public void setEncodedQuery(String encodedQuery) {
        this.encodedQuery = encodedQuery;
    }

}

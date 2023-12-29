/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminentlabs.userBPM;

import com.eminent.bpm.*;
import org.apache.log4j.Logger;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import com.eminent.hibernate.HibernateUtil;
import com.eminent.tqm.TqmPtcm;
import com.eminent.tqm.TqmUtil;
import static com.eminentlabs.userBPM.ViewBPM.logger;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import pack.eminent.encryption.MakeConnection;

/**
 *
 * @author Tamilvelan
 */
public class UpdateBPM {

    public static Logger logger = Logger.getLogger("UpdateBPM");

    public static void updateCompany(int cId, String cName) {
        SessionFactory sessionFactory = null;
        Session session = null;
        try {
            sessionFactory = HibernateUtil.getSessionFactory();
            session = sessionFactory.openSession();
            session.beginTransaction();
            BpmCompany comp = (BpmCompany) session.load(BpmCompany.class, new Integer(cId));
            comp.setCompanyName(cName);
            session.saveOrUpdate(comp);
            session.getTransaction().commit();
            logger.info("Company Updated");

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (session != null) {
                    session.close();
                }
            } catch (Exception e) {
                logger.error(e.getMessage());
            }
        }

    }

    public static void deleteCompany(int cId) {
        SessionFactory sessionFactory = null;
        Session session = null;
        try {
            sessionFactory = HibernateUtil.getSessionFactory();
            session = sessionFactory.openSession();
            session.beginTransaction();
            BpmCompany comp = (BpmCompany) session.load(BpmCompany.class, new Integer(cId));
            session.delete(comp);
            session.getTransaction().commit();
            logger.info("Company deleted");

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (session != null) {
                    session.close();
                }
            } catch (Exception e) {
                logger.error(e.getMessage());
            }
        }

    }

    public static void updateBP(int bpId, String bpName, String bpType) {
        SessionFactory sessionFactory = null;
        Session session = null;
        try {
            sessionFactory = HibernateUtil.getSessionFactory();
            session = sessionFactory.openSession();
            session.beginTransaction();
            BpmBp bp = (BpmBp) session.load(BpmBp.class, new Integer(bpId));
            bp.setBpName(bpName);
            bp.setBpType(bpType);
            session.saveOrUpdate(bp);
            session.getTransaction().commit();
            logger.info("Bp Updated" + bpId);

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (session != null) {
                    session.close();
                }
            } catch (Exception e) {
                logger.error(e.getMessage());
            }
        }

    }

    public static void deleteBP(int bpId) {
        SessionFactory sessionFactory = null;
        Session session = null;
        try {
            sessionFactory = HibernateUtil.getSessionFactory();
            session = sessionFactory.openSession();
            session.beginTransaction();
            BpmBp bp = (BpmBp) session.load(BpmBp.class, new Integer(bpId));
            session.delete(bp);
            session.getTransaction().commit();
            logger.info("Bp Deleted");

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (session != null) {
                    session.close();
                }
            } catch (Exception e) {
                logger.error(e.getMessage());
            }
        }

    }

    public static void updateMP(int mpId, String mpName, String mpType) {
        SessionFactory sessionFactory = null;
        Session session = null;
        try {
            sessionFactory = HibernateUtil.getSessionFactory();
            session = sessionFactory.openSession();
            session.beginTransaction();
            BpmMainProcess mp = (BpmMainProcess) session.load(BpmMainProcess.class, new Integer(mpId));
            mp.setMainProcess(mpName);
            mp.setMpType(mpType);
            session.saveOrUpdate(mp);
            session.getTransaction().commit();
            logger.info("MP Updated" + mpId);

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (session != null) {
                    session.close();
                }
            } catch (Exception e) {
                logger.error(e.getMessage());
            }
        }

    }

    public static void deleteMP(int mpId) {
        SessionFactory sessionFactory = null;
        Session session = null;
        try {
            sessionFactory = HibernateUtil.getSessionFactory();
            session = sessionFactory.openSession();
            session.beginTransaction();
            BpmMainProcess mp = (BpmMainProcess) session.load(BpmMainProcess.class, new Integer(mpId));

            session.delete(mp);
            session.getTransaction().commit();
            logger.info("MP deleted");

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (session != null) {
                    session.close();
                }
            } catch (Exception e) {
                logger.error(e.getMessage());
            }
        }

    }

    public static void updateSP(int spId, String spName, String spType) {
        SessionFactory sessionFactory = null;
        Session session = null;
        try {
            sessionFactory = HibernateUtil.getSessionFactory();
            session = sessionFactory.openSession();
            session.beginTransaction();
            BpmSubProcess sp = (BpmSubProcess) session.load(BpmSubProcess.class, new Integer(spId));
            sp.setSubProcess(spName);
            sp.setSpType(spType);
            session.saveOrUpdate(sp);
            session.getTransaction().commit();
            logger.info("SP Updated" + spId);

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (session != null) {
                    session.close();
                }
            } catch (Exception e) {
                logger.error(e.getMessage());
            }
        }

    }

    public static void deleteSP(int spId) {
        SessionFactory sessionFactory = null;
        Session session = null;
        try {
            sessionFactory = HibernateUtil.getSessionFactory();
            session = sessionFactory.openSession();
            session.beginTransaction();
            BpmSubProcess sp = (BpmSubProcess) session.load(BpmSubProcess.class, new Integer(spId));
            session.delete(sp);
            session.getTransaction().commit();
            logger.info("SP Updated");

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (session != null) {
                    session.close();
                }
            } catch (Exception e) {
                logger.error(e.getMessage());
            }
        }

    }

    public static void updateSC(int scId, String scName, String scType) {
        SessionFactory sessionFactory = null;
        Session session = null;
        try {
            sessionFactory = HibernateUtil.getSessionFactory();
            session = sessionFactory.openSession();
            session.beginTransaction();
            BpmScenario sc = (BpmScenario) session.load(BpmScenario.class, new Integer(scId));
            sc.setScenario(scName);
            sc.setScType(scType);
            session.saveOrUpdate(sc);
            session.getTransaction().commit();
            logger.info("SC Updated" + scId);

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (session != null) {
                    session.close();
                }
            } catch (Exception e) {
                logger.error(e.getMessage());
            }
        }

    }

    public static void deleteSC(int scId) {
        SessionFactory sessionFactory = null;
        Session session = null;
        try {
            sessionFactory = HibernateUtil.getSessionFactory();
            session = sessionFactory.openSession();
            session.beginTransaction();
            BpmScenario sc = (BpmScenario) session.load(BpmScenario.class, new Integer(scId));

            session.delete(sc);
            session.getTransaction().commit();
            logger.info("SC Updated");

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (session != null) {
                    session.close();
                }
            } catch (Exception e) {
                logger.error(e.getMessage());
            }
        }

    }

    public static void updateVT(int vtId, String vtName, String vtType, String leadModule, String impactedModule, String type, String classification, String priority) {
        SessionFactory sessionFactory = null;
        Session session = null;
        try {
            sessionFactory = HibernateUtil.getSessionFactory();
            session = sessionFactory.openSession();
            session.beginTransaction();
            BpmVariant vt = (BpmVariant) session.load(BpmVariant.class, new Integer(vtId));
            vt.setVariant(vtName);
            vt.setLeadModule(Integer.parseInt(leadModule));
            vt.setImpactedModule(Integer.parseInt(impactedModule));
            vt.setType(type);
            vt.setClassification(classification);
            vt.setPriority(priority);
            vt.setVtType(vtType);
            session.saveOrUpdate(vt);
            session.getTransaction().commit();
            logger.info("VT Updated" + vtId);

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (session != null) {
                    session.close();
                }
            } catch (Exception e) {
                logger.error(e.getMessage());
            }
        }

    }

    public static void deleteVT(int vtId) {
        SessionFactory sessionFactory = null;
        Session session = null;
        try {
            sessionFactory = HibernateUtil.getSessionFactory();
            session = sessionFactory.openSession();
            session.beginTransaction();
            BpmVariant vt = (BpmVariant) session.load(BpmVariant.class, new Integer(vtId));
            session.delete(vt);
            session.getTransaction().commit();
            logger.info("VT Deleted");

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (session != null) {
                    session.close();
                }
            } catch (Exception e) {
                logger.error(e.getMessage());
            }
        }

    }

    public static void updateTC(int tcId, String tcName, String tcType) {
        SessionFactory sessionFactory = null;
        Session session = null;
        updateTestCase(tcId, tcName);
        try {
            sessionFactory = HibernateUtil.getSessionFactory();
            session = sessionFactory.openSession();
            session.beginTransaction();
            BpmTestcase tc = (BpmTestcase) session.load(BpmTestcase.class, new Integer(tcId));
            tc.setTestcase(tcName);
            tc.setTcType(tcType);
            session.saveOrUpdate(tc);
            session.getTransaction().commit();
            logger.info("TC Updated");

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (session != null) {
                    session.close();
                }
            } catch (Exception e) {
                logger.error(e.getMessage());
            }
        }

    }

    public static void updateTestCase(int tcId, String functionality) {
        PreparedStatement ps = null;
        Connection connection = null;
        ResultSet resultset = null;
        List<String> ptcIdList = new ArrayList<String>();

        try {

            connection = MakeConnection.getConnection();
            ps = connection.prepareStatement("update TQM_PTCM set functionality=? where ptcid in (select PTCID from BPM_TESTSCRIPT where TESTSTEP_ID in(select TESTSTEP_ID from BPM_TESTSTEP WHERE TESTCASE_ID=" + tcId + "))", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            ps.setString(1, functionality);
            ps.executeUpdate();
        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (resultset != null) {
                    resultset.close();
                }

                if (ps != null) {
                    ps.close();
                }
                if (connection != null) {
                    connection.close();
                }

            } catch (Exception e) {
                logger.error(e.getMessage());
            }
        }

    }

    public static void deleteTC(int tcId) {
        SessionFactory sessionFactory = null;
        Session session = null;
        try {
            sessionFactory = HibernateUtil.getSessionFactory();
            session = sessionFactory.openSession();
            session.beginTransaction();
            BpmTestcase tc = (BpmTestcase) session.load(BpmTestcase.class, new Integer(tcId));
            session.delete(tc);
            session.getTransaction().commit();
            logger.info("TC deleted");

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (session != null) {
                    session.close();
                }
            } catch (Exception e) {
                logger.error(e.getMessage());
            }
        }

    }

    public static void updateTS(int tsId, String tsName, String tsType) {
        SessionFactory sessionFactory = null;
        Session session = null;
        try {
            sessionFactory = HibernateUtil.getSessionFactory();
            session = sessionFactory.openSession();
            session.beginTransaction();
            BpmTeststep ts = (BpmTeststep) session.load(BpmTeststep.class, new Integer(tsId));
            ts.setTeststep(tsName);
            ts.setTsType(tsType);
            session.saveOrUpdate(ts);
            session.getTransaction().commit();
            logger.info("TS Updated");

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (session != null) {
                    session.close();
                }
            } catch (Exception e) {
                logger.error(e.getMessage());
            }
        }

    }

    public static void deleteTS(int tsId) {
        SessionFactory sessionFactory = null;
        Session session = null;
        try {
            sessionFactory = HibernateUtil.getSessionFactory();
            session = sessionFactory.openSession();
            session.beginTransaction();
            BpmTeststep ts = (BpmTeststep) session.load(BpmTeststep.class, new Integer(tsId));
            session.delete(ts);
            session.getTransaction().commit();
            logger.info("TS Deleted");

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (session != null) {
                    session.close();
                }
            } catch (Exception e) {
                logger.error(e.getMessage());
            }
        }

    }

    public static void deleteTSC(int tscId) {
        SessionFactory sessionFactory = null;
        Session session = null;
        try {
            sessionFactory = HibernateUtil.getSessionFactory();
            session = sessionFactory.openSession();
            session.beginTransaction();
            BpmTestscript ts = (BpmTestscript) session.load(BpmTestscript.class, new Integer(tscId));
            session.delete(ts);
            session.getTransaction().commit();
            logger.info("TSC Deleted");

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (session != null) {
                    session.close();
                }
            } catch (Exception e) {
                logger.error(e.getMessage());
            }
        }

    }

    public static void updateTSC(int tscId, String tscName, String tscResult) {
        SessionFactory sessionFactory = null;
        Session session = null;
        try {
            logger.info("tscId : " + tscId);
            logger.info("tscName : " + tscName);
            logger.info("tscResult : " + tscResult);

            sessionFactory = HibernateUtil.getSessionFactory();
            session = sessionFactory.openSession();
            session.beginTransaction();
            BpmTestscript tsc = (BpmTestscript) session.load(BpmTestscript.class, new Integer(tscId));
            tsc.setTestScript(tscName);
            tsc.setExpectedResult(tscResult);
            session.saveOrUpdate(tsc);
            session.getTransaction().commit();
            logger.info("TS Updated");

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (session != null) {
                    session.close();
                }
            } catch (Exception e) {
                logger.error(e.getMessage());
            }
        }

    }

    public static void updatePTC(String ptcId, String tscName, String tscResult) {
        Connection connection = null;
        PreparedStatement ps = null;
        try {
            connection=MakeConnection.getConnection();
            ps = connection.prepareStatement("update TQM_PTCM set description=?, expectedresult=? where ptcid=?", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            ps.setString(1, tscName);
            ps.setString(2,tscResult);
            ps.setString(3,ptcId);
            ps.executeUpdate();

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (ps != null) {
                    ps.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (Exception e) {
                logger.error(e.getMessage());
            }
        }

    }
}

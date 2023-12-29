package pack.eminent.encryption;

import com.pack.MyAuthenticator;
import java.sql.Connection;
import java.sql.DriverManager;
import java.util.Properties;
import javax.ejb.Asynchronous;
import javax.mail.Authenticator;
import javax.mail.Session;
import javax.mail.Store;
import javax.mail.internet.MimeMessage;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;
import org.apache.log4j.Logger;

public class MakeConnection {

    static Logger logger = Logger.getLogger("MakeConnection");

    public static Connection getConnection() throws Exception {
        Connection connection = null;
        Context context = new InitialContext();
        DataSource ds = (DataSource) context.lookup("jdbc/_eTracker");
        connection = ds.getConnection();
        return connection;
    }

    public static Connection getOutsourceConnection() throws Exception {
        Connection connection = null;
        Context context = new InitialContext();
        DataSource ds = (DataSource) context.lookup("eminentoutsource");
        connection = ds.getConnection();
        return connection;
    }

    public static Connection getSAPConnection() throws Exception {
        Connection connection = null;
        Class.forName("com.sap.dbtech.jdbc.DriverSapDB");
        connection = DriverManager.getConnection("jdbc:sapdb://192.168.1.215/nsp", "sapnsp", "emi1");
        return connection;
    }

    public static MimeMessage getMailConnection() {
        MimeMessage mimeMessage = null;
        try {
            Properties prop = System.getProperties();
            prop.put("mail.smtp.host", "smtp.gmail.com");
            prop.put("mail.smtp.auth", "true");
            prop.put("mail.smtp.port", 587);
            prop.put("mail.debug", "false");
            prop.put("mail.smtp.starttls.enable", "true");
            Authenticator auth = new MyAuthenticator();
            Session ses1 = Session.getInstance(prop, auth);
            mimeMessage = new MimeMessage(ses1);
        } catch (Exception e) {
            logger.error("getMailConnection() " + e.getMessage());
        }
        return mimeMessage;
    }

    @Asynchronous
    public static MimeMessage getMailConnections() throws Exception {
        Context context = new InitialContext();
        Session session = (Session) context.lookup("mail/eminent");
        MimeMessage mimeMessage = new MimeMessage(session);

        return mimeMessage;
    }

    @Asynchronous
    public static Store getMailReadConnections() throws Exception {
        Context context = new InitialContext();
        Session session = (Session) context.lookup("mail/eminent");
        Store store = session.getStore("imaps");
        if (session.getProperty("mail.from") == null || session.getProperty("mail.from.password") == null) {
        } else {
            store.connect("imap.gmail.com", session.getProperty("mail.from"), session.getProperty("mail.from.password"));
        }
        return store;
    }

    @Asynchronous
    public static MimeMessage getSalesMailConnections() throws Exception {
        Context context = new InitialContext();
        Session session = (Session) context.lookup("mail/sales");
        MimeMessage mimeMessage = new MimeMessage(session);
        return mimeMessage;
    }

    @Asynchronous
    public static MimeMessage getInfoMailConnections() throws Exception {
        Context context = new InitialContext();
        Session session = (Session) context.lookup("mail/info");
        MimeMessage mimeMessage = new MimeMessage(session);
        return mimeMessage;
    }

    @Asynchronous
    public static MimeMessage getSupportMailConnections() throws Exception {
        Context context = new InitialContext();
        Session session = (Session) context.lookup("mail/support");
        MimeMessage mimeMessage = new MimeMessage(session);
        return mimeMessage;
    }

    @Asynchronous
    public static MimeMessage getGSTMailConnections() throws Exception {
        Context context = new InitialContext();
        Session session = (Session) context.lookup("mail/gst");
        MimeMessage mimeMessage = new MimeMessage(session);
        return mimeMessage;
    }

    public static Connection getESPLASPConnection() throws Exception {
        Connection connection = null;
        Context context = new InitialContext();
        DataSource ds = (DataSource) context.lookup("jdbc/_esplasp");
        connection = ds.getConnection();
        return connection;
    }

}

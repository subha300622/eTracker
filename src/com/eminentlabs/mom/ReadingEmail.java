package com.eminentlabs.mom;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 *
 * @author EMINENT
 */
import com.eminent.issue.formbean.IssueFormBean;
import java.io.BufferedOutputStream;
import java.io.DataOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.*;
import javax.mail.*;
import org.apache.log4j.Logger;
import pack.eminent.encryption.MakeConnection;

public class ReadingEmail {

    static Logger logger = null;

    static {
        logger = Logger.getLogger("ReadingEmail");
    }

    public static List<IssueFormBean> read(Date readingDate) throws MessagingException {
        Folder inbox = null;
        Store store = null;
        List<IssueFormBean> issueList = new ArrayList<IssueFormBean>();
        try {
//            Calendar cal = null;
//            cal = Calendar.getInstance();
            DateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
           //   cal.add(Calendar.DATE, -1);
            Date minDateTime = readingDate;   //get previous date
            Date minDate = sdf.parse(sdf.format(minDateTime));

            store = MakeConnection.getMailReadConnections();
            inbox = store.getFolder("INBOX");
            inbox.open(Folder.READ_ONLY);
            Message msgs[] = inbox.getMessages();
            for (int j = msgs.length - 1; j >= 0; j--) {
                IssueFormBean ifb = new IssueFormBean();
                Message msg = msgs[j];
                Object content = msg.getContent();
                String from = msg.getFrom()[0].toString();
                Date mailDateTime = msg.getSentDate();
                Date mailDate = sdf.parse(sdf.format(mailDateTime));
                if (mailDate.compareTo(minDate) == 0) {
                    ifb.setSubject(msg.getSubject());
                    if (content instanceof String) {
                      //  ifb.setDescription(content.toString());
                    } else if (content instanceof Multipart) {
                        Multipart mp = (Multipart) content;
                        int count = mp.getCount();
                        for (int i = 0; i < count; i++) {
                            writePart(mp.getBodyPart(i), ifb);
                        }
                   }
                    issueList.add(ifb);
                } else if (mailDate.compareTo(minDate) > 0) {
                } else {
                    break;
                }
            }
            
        } catch (Exception mex) {
            mex.printStackTrace();
        } finally {
            if (inbox == null) {

            } else {
                inbox.close(false);
            }
            if (store == null) {

            } else {
                store.close();
            }
        }
        return issueList;
    }

    public static void writePart(Part p, IssueFormBean ifb) throws Exception {
        if (p instanceof Message) //Call methos writeEnvelope
        {
            writeEnvelope((Message) p);
        }

        //check if the content is plain text
        if (p.isMimeType("text/plain")) {
            ifb.setDescription(p.getContent().toString());
        } //check if the content has attachment
        else if (p.isMimeType("multipart/*")) {
            Multipart mp = (Multipart) p.getContent();
            int count = mp.getCount();
            for (int i = 0; i < count; i++) {
                writePart(mp.getBodyPart(i), ifb);
            }
        } else if (p.isMimeType("message/rfc822")) {
            writePart((Part) p.getContent(), ifb);
        } //check if the content is an inline image
        else if (p.isMimeType("image/jpeg")) {
           Object o = p.getContent();

            InputStream x = (InputStream) o;
            // Construct the required byte array
            int i = 0;
            byte[] bArray = new byte[x.available()];

            while ((i = (int) ((InputStream) x).available()) > 0) {
                int result = (int) (((InputStream) x).read(bArray));
                if (result == -1) {
                    break;
                }
            }
            FileOutputStream f2 = new FileOutputStream("/tmp/image.jpg");
            f2.write(bArray);
        } else if (p.getContentType().contains("image/")) {
            File f = new File("image" + new Date().getTime() + ".jpg");
            DataOutputStream output = new DataOutputStream(
                    new BufferedOutputStream(new FileOutputStream(f)));
            com.sun.mail.util.BASE64DecoderStream test
                    = (com.sun.mail.util.BASE64DecoderStream) p
                    .getContent();
            byte[] buffer = new byte[1024];
            int bytesRead;
            while ((bytesRead = test.read(buffer)) != -1) {
                output.write(buffer, 0, bytesRead);
            } //check if the content is a nested message
        } else {
            Object o = p.getContent();
            if (o instanceof String) {
            } else if (o instanceof InputStream) {
                InputStream is = (InputStream) o;
                is = (InputStream) o;
                int c;
                while ((c = is.read()) != -1) {
                }
            } else {
            }
        }

    }

    public static boolean writeEnvelope(Message m) throws Exception {
        boolean flag = false;
        Address[] a;

        // FROM
        if ((a = m.getFrom()) != null) {
            for (int j = 0; j < a.length; j++) {
            }
        }

        // TO
        if ((a = m.getRecipients(Message.RecipientType.TO)) != null) {
            for (int j = 0; j < a.length; j++) {
                if (a[j].toString().equalsIgnoreCase("eminentleavemanagement@gmail.com")) {
                    flag = true;
                    break;
                }
            }
        }

       
        return flag;
    }
}

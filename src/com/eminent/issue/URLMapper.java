/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.issue;

import com.eminent.issue.IssueImageUrl;
import static com.eminent.issue.controller.IssueImageURLController.checkGoogleURL;
import com.eminentlabs.dao.DAOConstants;
import com.eminentlabs.dao.ModelDAO;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URL;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import javax.imageio.ImageIO;

/**
 *
 * @author Tamilvelan
 */
public class URLMapper {

    public static List<String> extractUrls(String text) {
        List<String> containedUrls = new ArrayList<String>();
        String urlRegex = "((https?|ftp|gopher|telnet|file):((//)|(\\\\))+[\\w\\d:#@%/;$()~_?\\+-=\\\\\\.&]*)";
        Pattern pattern = Pattern.compile(urlRegex, Pattern.CASE_INSENSITIVE);
        Matcher urlMatcher = pattern.matcher(text);

        while (urlMatcher.find()) {
            containedUrls.add(text.substring(urlMatcher.start(0),
                    urlMatcher.end(0)));
        }

        return containedUrls;
    }

    public static String saveImage(String imageUrl, String imageName, String issueId, String rowid, int googleURLStatus, long imageId) {
        InputStream is = null;
        OutputStream os = null;
        String result = "success";
        try {
            IssueImageUrl iiu = new IssueImageUrl();
            URL url = new URL(imageUrl);
            String destName = "D:\\Resources\\Etracker_AttachedFiles\\images\\" + imageName + ".jpg";
            if (googleURLStatus == 0) {
                is = url.openStream();
                os = new FileOutputStream(destName);
                byte[] b = new byte[2048];
                int length;
                while ((length = is.read(b)) != -1) {
                    os.write(b, 0, length);
                }
                File f = new File(destName);
                if (f.exists()) {
                    iiu.setLocalUrlStatus(0);
                } else {
                    iiu.setLocalUrlStatus(1);
                }
            } else {
                iiu.setLocalUrlStatus(1);

            }
            if (0l <= imageId) {
                iiu.setImageId(imageId);
            }

            iiu.setGoogleUrlStatus(googleURLStatus);
            iiu.setIssueId(issueId);
            iiu.setIssueRowId(rowid);
            iiu.setOrginialUrl(imageUrl);
            iiu.setLocalUrl("\\eTracker\\Etracker_AttachedFiles\\images\\" + imageName + ".jpg");
            iiu.setAddedOn(new Date());
            ModelDAO.saveOrUpdate(DAOConstants.Entity_ISSUE_IMAGE_URL, iiu);

        } catch (Exception ioe) {
            ioe.printStackTrace();
            result = "faliure";
        } finally {
            try {
                if (is != null) {
                    is.close();
                }
                if (os != null) {
                    os.close();

                }
            } catch (IOException ex) {
                Logger.getLogger(URLMapper.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return result;
    }

    public static void main(String[] args) {
        List<String> extractedUrls = extractUrls("Hi&nbsp;<span style=\"padding-bottom:0px!important;background-image:url(&quot;&quot;)\">Saravanan</span>,<br />\n"
                + " <br />\n"
                + " On overview of Ledger Code: 2310051 (Axis Bank A/c No. 2561) for the month of April-2014, it is found that transaction &nbsp;Doc. No. 10004227 dated 29.04.2014 is not reflecting in T-Code&nbsp;<span style=\"padding-bottom:0px!important;background-image:url(&quot;&quot;)\">ZBANK</span>.<br />\n"
                + " <br />\n"
                + " <span style=\"padding-bottom:0px!important;background-image:url(&quot;&quot;)\">Please</span> find the attachment &nbsp;for your reference, request to clarify on the same.<img src=\"https://ci6.googleusercontent.com/proxy/RnNZfQn2o2xpggJQqefCOervMbPIci5mujDPJnvl43kv6Rtxjyh5gHN_JKVzeU-aaGz3pePFgxfoAAtZJZNx8mveVTc-11j98EfuAJVcumUenA=s0-d-e1-ft#https://ssl.gstatic.com/ui/v1/icons/mail/images/cleardot.gif\" />\n"
                + " <div class=\"yj6qo ajU\">\n"
                + " 	<div aria-label=\"Show trimmed content\" class=\"ajR\" data-tooltip=\"Show trimmed content\" id=\":16u\" role=\"button\" tabindex=\"0\">\n"
                + " 		<img class=\"ajT\" src=\"https://ssl.gstatic.com/ui/v1/icons/mail/images/cleardot.gif\" /></div>\n"
                + " </div>\n"
                + "https://lh3.googleusercontent.com/hSWJVdxCA00_AqWk0GHt4_tb9q_VXpR4rjWdOkFJbOJjgVbQexQPf8ifEm8RaCjpyLU0QlJppdxvjO8gdPowcrPNM_G3Iq1WNDhS4OWn7pUNvAHfhgn84KnWKEsR1OWBxRj4W01ed <br />\n"
                + " ");
        try {
//            
//              try{
            File f = new File("D:\\Resources\\Etracker_AttachedFiles\\2.E01082018002_AAAN3NAABAAAQF1AAH_15032019115523.jpg");
            System.out.println(f.exists());
//
//    }catch(Exception ex){
//    }
            int count = 1, status = 0;
            for (String url1 : extractedUrls) {
                System.out.println(url1);
                if (url1.contains("googleusercontent.com")) {
                    if (checkGoogleURL(url1)) {
                        status = 0;
                    } else {
                        status = 1;
                    }
                    System.out.println("status : " + status);
                    // saveImage(url1, count + ".AAAENJAABAAAMz8AAJ", "E02062014004","",status);
                    count++;
                }
            }

//    }catch(Exception ex){
//    }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}

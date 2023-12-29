package com.pack;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

public class MyAuthenticator extends Authenticator {

    PasswordAuthentication l = new PasswordAuthentication("eminentleavemanagement@gmail.com", "eminent@2016");

    @Override
    protected PasswordAuthentication getPasswordAuthentication() {
        return l;
    }

}

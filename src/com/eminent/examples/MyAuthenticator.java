package com.eminent.examples;


import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

public class MyAuthenticator extends Authenticator{
	PasswordAuthentication l=new PasswordAuthentication("admin@eminentlabs.com","eminent123");
	@Override
	protected PasswordAuthentication getPasswordAuthentication(){
		return l;
	}

}

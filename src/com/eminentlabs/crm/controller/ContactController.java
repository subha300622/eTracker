/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminentlabs.crm.controller;

import com.eminent.customer.ContactRegistration;
import com.eminentlabs.crm.dao.ContactDAO;
import com.eminentlabs.crm.dao.ContactDAOImpl;
import com.eminentlabs.crm.dto.Contact;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;
import pack.eminent.encryption.MakeConnection;

public class ContactController {

    ContactDAO cr = new ContactDAOImpl();
    String existed = "";

    public String addToDBContacts(Contact c) throws Exception {

        boolean status = false;
        status = cr.checkOut(c.getEmail());
        if (status == false) {
            cr.saveContact(c);
        } else {
            existed = c.getEmail();
        }
        return existed;
    }

}

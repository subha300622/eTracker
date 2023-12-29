/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminentlabs.crm.dao;

import com.eminentlabs.crm.dto.Contact;
/**
 *
 * @author Muthu
 */
public interface ContactDAO {

    public void saveContact(Contact contact);

    public boolean checkOut(String email);

}

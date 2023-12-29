/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.eminent.examples;

import org.apache.commons.codec.binary.Base64;
import org.apache.commons.codec.language.RefinedSoundex;

/**
 *
 * @author Tamilvelan
 */
public class Encryption {
    public static void main(String[] args)throws Exception{
        String input    = "tamilvelan@gmail.com";
        RefinedSoundex rs = new RefinedSoundex();

        String encrypted = rs.encode(input);

         byte[] convert = input.getBytes();

        Base64 b64 = new Base64();
        byte[] cv = b64.encode(convert);

        int append =  0;
        for (byte element : cv) {

             append = append + element;

         }
        encrypted = encrypted + append;

    }

}

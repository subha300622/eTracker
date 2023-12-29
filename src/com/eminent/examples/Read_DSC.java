package com.eminent.examples;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
import java.io.File;
import java.io.FileInputStream;
import java.security.KeyFactory;
import java.security.KeyStore;
import java.security.PublicKey;
import java.security.Signature;
import java.security.cert.CertificateFactory;
import java.security.cert.X509Certificate;
import java.security.spec.X509EncodedKeySpec;
import java.util.Arrays;
import java.util.Collection;
import java.util.Iterator;

public class Read_DSC {

    public static void main(String[] args) {
        String signdata = null;
        try {
            File file = new File("E:\\DSc_Export.cer");
            FileInputStream fis = new FileInputStream(file);
            CertificateFactory cf = CertificateFactory.getInstance("X.509");
            Collection c = cf.generateCertificates(fis);
            Iterator i = c.iterator();
            byte[] publicKeyEncoded = null;
            byte[] digitalSignature = null;

            while (i.hasNext()) {
                X509Certificate cert509 = (X509Certificate) i.next();
                publicKeyEncoded = cert509.getPublicKey().getEncoded();
                digitalSignature = cert509.getSignature();
                System.out.println("KEY AL: " + cert509.getPublicKey().getAlgorithm());
                System.out.println("IssuerDN: " + cert509.getIssuerDN());
                System.out.println("NotAfter: " + cert509.getNotAfter());
                System.out.println("SerialNumber: " + cert509.getSerialNumber());
                System.out.println("SigAlgName: " + cert509.getSigAlgName());
                System.out.println("getSigAlgOID: " + cert509.getSigAlgOID());
                System.out.println("IssuerUniqueID: " + Arrays.toString(cert509.getIssuerUniqueID()));
                System.out.println("Signature: " + Arrays.toString(cert509.getSignature()));
                System.out.println("SubjectDN: " + cert509.getSubjectDN());
                signdata = Arrays.toString(cert509.getSignature()).replace("[", "").replace("]", "");
                System.out.println("signdata: " + signdata);

            }
            X509EncodedKeySpec publicKeySpec = new X509EncodedKeySpec(publicKeyEncoded);
            KeyFactory keyFactory = KeyFactory.getInstance("RSA");

            PublicKey publicKey = keyFactory.generatePublic(publicKeySpec);
            Signature signature = Signature.getInstance("SHA256withRSA");
            signature.initVerify(publicKey);


            boolean verified = signature.verify(digitalSignature);
            if (verified) {
                System.out.println("Data verified.");
            } else {
                System.out.println("Cannot verify data.");
            }
            
            FileInputStream pkcs12Stream = new FileInputStream ("keystore.pfx");
KeyStore store = KeyStore.getInstance("PKCS12");
store.load(pkcs12Stream, "store_pwd".toCharArray());
pkcs12Stream.close();
            
// Create signing information


        } catch (Exception e) {
            e.printStackTrace();
            System.out.println(e.toString());
        }
    }

}

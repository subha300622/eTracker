/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.eminent.examples;

/**
 *
 * @author Tamilvelan
 */
public class FileEncoding {
    public static void main(String[] args){
        String fileName="Receipt, Accounting, .... Issues of .materials -stores!~$^()=+];.doc";
        int indexlast   =   fileName.lastIndexOf(".");
         int length = fileName.length();
        StringBuffer encodedTag = new StringBuffer(2 * length);
        for(int i = 0; i < length; i++)
        {
            char c = fileName.charAt(i);

             if(c == ' ')
            {
                encodedTag.append("_");
                continue;
            }
             if(c == '.')
            {
                if(i!=fileName.lastIndexOf(".")){
                    encodedTag.append("_");
                    continue;
                }
            }
             if(c == '—')
            {
                encodedTag.append("_");
                continue;
            }
            if(c == '#')
            {
                encodedTag.append("_");
                continue;
            }
            if(c == '%')
            {
                encodedTag.append("_");
                continue;
            }
            if(c == '&')
            {
                encodedTag.append("_");
                continue;
            }
              if(c == ';')
            {
                encodedTag.append("_");
                continue;
            }
             if(c == '-')
            {
                encodedTag.append("_");
                continue;
            }
            if(c == '"')
            {
                encodedTag.append("&quot;");
                continue;
            }
             else {
		encodedTag.append(c);
	     }
        }

    }

}

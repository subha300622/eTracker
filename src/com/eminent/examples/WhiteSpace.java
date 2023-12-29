/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.eminent.examples;

/**
 *
 * @author Tamilvelan
 */
public class WhiteSpace {
    public static void main(String[] args){
        String mod      =   "10097:tamilvelan is bad boy";
        String len      = "12345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678";
        int mid                 =   Integer.parseInt(mod.substring(0, mod.indexOf(":")));
        String functionality    =   mod.substring(mod.indexOf(":")+1,mod.length());
        String desc="There is no test cases covered  avilable for issue in Print Preview page. It should be added";
        String desc1 = null,desc_substr=null,nextline="\n";
            int desclen = desc.length();
            int index=0;
            if(desclen>=30)
            {
                   desc1=desc.substring(index,index+30);
                   desclen=desclen-30;
                   while((desclen/30)>=1)
                   {
                         desc1=desc1.concat(nextline);
                         index=index+30;
                         desc_substr=desc.substring(index,index+30);
                         desc1=desc1.concat(desc_substr);
                         desclen=desclen-30;
                   }
                   index=index+30;
                   desc1=desc1.concat(nextline);
                   desc1=desc1.concat(desc.substring(index));
            }
            else
            {
                    desc1=desc.substring(index);
            }
            String name="Tamilvelan Tamilvelan";
    }

}

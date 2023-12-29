/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.eminent.examples;

/**
 *
 * @author Tamilvelan
 */
import java.io.*;

public class  HexadecimalToDecimal{
  public static void main(String[] args) throws IOException{
 //   BufferedReader bf = new BufferedReader(new InputStreamReader(System.in));
   // String str= bf.readLine();
//    String color[]={"#F0F8FF", "#FAEBD7", "#00FFFF", "#7FFFD4", "#F0FFFF"," #F5F5DC","#FFE4C4","#000000","#FFEBCD","#0000FF","#8A2BE2","#A52A2A","#DEB887","#5F9EA0","#7FFF00","#D2691E","#FF7F50","#6495ED ","# FFF8DC ","# DC143C "," #00FFFF ","# 00008B "," #008B8B "," #B8860B ", "#A9A9A9 ", "#006400 ", "#BDB76B ", "#8B008B ", "#556B2F ", "#FF8C00 ", "#9932CC ", "#8B0000 ", "#E9967A ", "#8FBC8F ", "#483D8B ","# 2F4F4F ", "#00CED1 ", "#9400D3 ", "#FF1493 ","# 00BFFF ", "#696969 ", "#1E90FF ", "#B22222 ", "#FFFAF0 ", "#228B22 ", "#FF00FF ", "#DCDCDC ", "#F8F8FF "," #FFD700 "," #DAA520 "," #808080 ", "#008000 ", "#ADFF2F ", "#F0FFF0 ", "#FF69B4 ", "#CD5C5C ", "#4B0082 ", "#FFFFF0 ", "#F0E68C "," #E6E6FA ", "#FFF0F5 ", "#7CFC00 "," #FFFACD ","# ADD8E6 ", "#F08080 ", "#E0FFFF","#FAFAD2"};
    String color[]={"F0F8FF", "FAEBD7", "00FFFF", "7FFFD4", "F0FFFF","F5F5DC","FFE4C4","000000","FFEBCD","0000FF","8A2BE2","A52A2A","DEB887","5F9EA0","7FFF00","D2691E","FF7F50","6495ED ","FFF8DC ","DC143C ","00FFFF ","00008B ","008B8B ","B8860B ", "A9A9A9 ", "006400 ", "BDB76B ", "8B008B ", "556B2F ", "FF8C00 ", "9932CC ", "8B0000 ", "E9967A ", "8FBC8F ", "483D8B ","2F4F4F ", "00CED1 ", "9400D3 ", "FF1493 ","00BFFF ", "696969 ", "1E90FF ", "B22222 ", "FFFAF0 ", "228B22 ", "FF00FF", "DCDCDC ", "F8F8FF ","FFD700","DAA520 ","808080 ", "008000 ", "ADFF2F ", "F0FFF0 ", "FF69B4 ", "CD5C5C ", "4B0082 ", "FFFFF0 ", "F0E68C ","E6E6FA ", "FFF0F5 ", "7CFC00 ","FFFACD ","ADD8E6 ", "F08080 ", "E0FFFF","FAFAD2"};
    for(String s:color){
        int i= Integer.parseInt(s.trim(),16);
    }
     //System.out.println("Hex:="+ Integer.toHexString(i));
    }
}

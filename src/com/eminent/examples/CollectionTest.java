/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.eminent.examples;
import java.util.*;

public class CollectionTest {
  public static void main(String [] args) {
    int size;
    // Create a collection
    HashSet <String>collection = new HashSet <String>();
    String str1 = "Yellow", str2 = "White", str3 = "Green", str4 = "Blue", str5="White";
    Iterator iterator;
    //Adding data in the collection
    collection.add(str1);
    collection.add(str2);
    collection.add(str3);
    collection.add(str4);
    collection.add(str5);
    System.out.print("Collection data: ");
    //Create a iterator
    iterator = collection.iterator();
    while (iterator.hasNext()){
      System.out.print(iterator.next() + " ");
    }
    // Get size of a collection
    size = collection.size();
    if (collection.isEmpty()){
    }
    else{
    }
    // Remove specific data
    collection.remove(str2);
    iterator = collection.iterator();
    while (iterator.hasNext()){
      System.out.print(iterator.next() + " ");
    }
    size = collection.size();
    //Collection empty
    collection.clear();
    size = collection.size();
    if (collection.isEmpty()){
    }
    else{
    }
  }
}

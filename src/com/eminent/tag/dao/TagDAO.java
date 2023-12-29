/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.tag.dao;

import com.eminent.tags.Tags;
import java.util.List;

/**
 *
 * @author EMINENT
 */
public interface TagDAO {

   public void addTags(Tags tags);
   public Tags saveAddTags(Tags tags);
    public List<Tags> findAllTags();

    public String findByTagName(String tname);
   
    public String findUniqueTagByUser(String tname, Integer userid);

     public String deleteTagByTagId(Long tagId);

    public List<Tags> findTagsByUserId(Integer userId);
    
    public Tags findTagEntity(String tname, Integer userid);
}

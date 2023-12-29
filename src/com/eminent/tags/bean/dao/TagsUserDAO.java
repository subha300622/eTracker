/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.tags.bean.dao;

import com.eminent.tags.bean.TagsUsersEntity;
import java.util.List;

/**
 *
 * @author admin
 */
public interface TagsUserDAO {

    public void saveTagUser(List<TagsUsersEntity> listTagUser);

    public String deleteUserByTag(Long tagId);


    public List<TagsUsersEntity> findByTagId(Long TagId);
}

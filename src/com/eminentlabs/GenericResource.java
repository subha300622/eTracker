/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminentlabs;

import com.eminentlabs.mom.MoMUtil;
import javax.ws.rs.Path;
import javax.ws.rs.GET;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;

/**
 * REST Web Service
 *
 * @author EMINENT
 */
@Path("addCR")
public class GenericResource {

    /**
     * Retrieves representation of an instance of
     * com.eminentlabs.GenericResource
     *
     * @return an instance of java.lang.String
     */
    @GET
    @Produces("application/xml")
    public String getXml(@QueryParam("crid") String crid, @QueryParam("desc") String desc, @QueryParam("userId") String userId) {
        long user = MoMUtil.parseLong(userId, 0l);

        TRUtil.createTR(crid, desc, user);
        return "<string>" + crid + ", " + desc + "</string>";

    }

    /**
     * PUT method for updating or creating an instance of GenericResource
     *
     * @param content representation for the resource
     * @return an HTTP response with content of the updated or created resource.
     */
}

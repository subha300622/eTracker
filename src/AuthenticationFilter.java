/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.apache.log4j.MDC;

/**
 *
 * @author EMINENT
 */
public class AuthenticationFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response,
            FilterChain chain) throws IOException, ServletException {

        try {
            /*
             * This code puts the value "userName" to the Mapped Diagnostic
             * context. Since MDc is a static class, we can directly access it
             * with out creating a new object from it. Here, instead of hard
             * coding the user name, the value can be retrieved from a HTTP
             * Request object.
             */
            HttpServletRequest req = (HttpServletRequest) request;
            HttpSession session = req.getSession(false);
            if (session==null || session.getAttribute("userid_curr") == null) {
                MDC.put("errorFacedBy", "Without login");
            } else {
                Integer headeruserId = (Integer) session.getAttribute("userid_curr");
                String email = (String) session.getAttribute("theName");
                String fName = (String) session.getAttribute("fName");
                String lName = (String) session.getAttribute("lName");
                String errorFacedBy = headeruserId + ", " + fName + ", " + lName + ", " + email;
                MDC.put("errorFacedBy", errorFacedBy);

            }

            chain.doFilter(request, response);

        } finally {
            MDC.remove("errorFacedBy");
        }

    }

    @Override
    public void init(FilterConfig fc) throws ServletException {
    }

    @Override
    public void destroy() {
    }

}


import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.log4j.Logger;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author EMINENT
 */
public class Log4jMdcDemo extends HttpServlet {

    private static Logger logger = Logger.getLogger(Log4jMdcDemo.class);

    public Log4jMdcDemo() {
    }

    protected void doGet(HttpServletRequest request,
            HttpServletResponse response) throws ServletException, IOException {
        doService(request, response);
    }

    protected void doPost(HttpServletRequest request,
            HttpServletResponse response) throws ServletException, IOException {
        doService(request, response);
    }

    protected void doService(HttpServletRequest request,
            HttpServletResponse response) throws ServletException, IOException {

        logger.info("This is  demo for the Log4j MDC concept");
        logger.info("From Veerasundar.com/blog");
       
    }
}

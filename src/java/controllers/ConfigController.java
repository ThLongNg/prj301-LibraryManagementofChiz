/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controllers;

import dao.SystemConfigDAO;
import dto.ConfigSystem;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;

/**
 *
 * @author user
 */
public class ConfigController extends HttpServlet {
   
   
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setCharacterEncoding("utf-8");
        PrintWriter out=response.getWriter();        
        SystemConfigDAO d=new SystemConfigDAO();
        ArrayList<ConfigSystem> list=d.getAll();
        if(list!=null & !list.isEmpty()){
            out.print("<table>");
            out.print("<tr>");
            out.print("<th>ID</th>");
            out.print("<th>CONFIG KEY</th>");
            out.print("<th>CONFIG VALUE</th>");
            out.print("<th>DESCRIPTION</th>");
            out.print("</tr>");
            for (ConfigSystem configSystem : list) {
                out.print("<form>");
                out.print("<tr>");
                out.print("<td>"+ configSystem.getId() +"</td>");
                out.print("<td>"+ configSystem.getKey() +"</td>");
                out.print("<td>"+ configSystem.getValue() +"</td>");
                out.print("<td>"+ configSystem.getDescription() +"</td>");
                out.print("<td><input type='submit' value='edit' />");
                out.print("</tr>");
                out.print("</form>");
            }            
            out.print("</table>");
        }
        else{
            out.print("<p>no data</p>");
            out.print("<a href='AdminDashboard.html'>admin home</a>");
        }
    } 

  
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
       
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}

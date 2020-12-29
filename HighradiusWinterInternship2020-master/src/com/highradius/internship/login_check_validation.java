package com.highradius.internship;

import java.io.IOException;
import java.io.*;  
import javax.servlet.*;  
import javax.servlet.http.*;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
 





@WebServlet("/login_check_validation")
public class login_check_validation extends HttpServlet {
	
	public login_check_validation() {
		super();
	}

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
    	String un = request.getParameter("username");
        String pw = request.getParameter("password");



        try {
            Class.forName("com.mysql.jdbc.Driver");

            Connection c = DriverManager.getConnection("jdbc:mysql://localhost:3306/winter_internship", "root", "root"); 

            PreparedStatement ps = c.prepareStatement("select * from user_details where username=? and password=?");
            
            ps.setString(1, un);
            ps.setString(2, pw);

            ResultSet rs = ps.executeQuery();
            String ms="Invalid UserName or Password";
            while (rs.next()) {
            	 HttpSession session=request.getSession(); 
            	   String st="ok";
            	   session.setAttribute("status",st);
            	   session.setAttribute("user_name",un);
            	   
            	String level_user=rs.getString(4);
                        	session.setAttribute("level_user",level_user);
            		response.sendRedirect("dashboard.jsp");
                return;
            }                                                                       
            HttpSession session=request.getSession(); 
			session.setAttribute("msg",ms);
            response.sendRedirect("index.jsp");
            return;
           
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
    }

}
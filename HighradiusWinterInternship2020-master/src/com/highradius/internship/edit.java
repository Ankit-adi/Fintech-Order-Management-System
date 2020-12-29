package com.highradius.internship;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/edit")
public class edit extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String ordid=request.getParameter("ordid");
   		String ordamt=request.getParameter("ordamt");
   		String note=request.getParameter("note");
   		String aprvby=request.getParameter("aprvby");
   		String aprv=request.getParameter("aprv");
   		PrintWriter out = response.getWriter();
   		
   		
   		try {
   			Class.forName("com.mysql.jdbc.Driver");

            Connection c= DriverManager.getConnection("jdbc:mysql://localhost:3306/winter_internship", "root", "root"); 

            String query = "update order_details set Order_Amount='"+ordamt+"',Notes='"+note+"',Approval_Status='"+aprv+"',Approved_By='"+aprvby+"'where Order_ID="+ordid;
        	PreparedStatement ps = c.prepareStatement(query);
        	int affectedRows = ps.executeUpdate();
    		out.println(affectedRows);
    		if(affectedRows>0)
    			out.print("Records Updated");
    		}catch (ClassNotFoundException | SQLException e) {
            	out.print("OrderId Already Exists");
 	
            	e.printStackTrace();
            }
   		}
	}

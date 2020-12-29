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

@WebServlet("/add")
public class add extends HttpServlet {
   	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
   		String ordid=request.getParameter("ordid");
   		String orddat=request.getParameter("orddat");
   		String cstnam=request.getParameter("cstnam");
   		String cstnum=request.getParameter("cstnum");
   		String ordamt=request.getParameter("ordamt");
   		String note=request.getParameter("note");
   		String aprv=request.getParameter("aprv");
   		String aprvby=request.getParameter("aprvby");

   		int amt=Integer.parseInt(ordamt); 
   		int id=Integer.parseInt(ordid);  
   		int cnum=Integer.parseInt(cstnum); 
   	 PrintWriter out = response.getWriter();
   		
   		try {
            Class.forName("com.mysql.jdbc.Driver");

            Connection c= DriverManager.getConnection("jdbc:mysql://localhost:3306/winter_internship", "root", "root"); 

            String query = "INSERT INTO order_details(Order_ID,Customer_Name,Customer_ID,Order_Amount,Approval_Status,Approved_By,Notes,Order_Date) "
            		+ "VALUES(?, ? , ? , ?, ? , ? , ? , ? )";
              		PreparedStatement ps = c.prepareStatement(query);
    
            		ps.setInt(1,id);
            		ps.setString(2, cstnam);
            		ps.setInt(3,cnum);
            		ps.setInt(4,amt);
            		ps.setString(5, aprv);
            		ps.setString(6, aprvby);
            		ps.setString(7, note);
            		ps.setString(8, orddat);
            		int affectedRows = ps.executeUpdate();
            		out.println(affectedRows);
            		if(affectedRows>0)
            			out.print("Records Updated");
    
            } catch (ClassNotFoundException | SQLException e) {
            	out.print("OrderId Already Exists");
 	
            	e.printStackTrace();
            }



}
}


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

/**
 * Servlet implementation class reject
 */
@WebServlet("/reject")
public class reject extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public reject() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String ordid=request.getParameter("ordid");
    	String aprv=request.getParameter("aprv");
   		String aprvby=request.getParameter("aprvby");
   		int id=Integer.parseInt(ordid);
   	 PrintWriter out = response.getWriter();
   		try {
            Class.forName("com.mysql.jdbc.Driver");

            Connection c= DriverManager.getConnection("jdbc:mysql://localhost:3306/winter_internship", "root", "root"); 
            String query="update order_details set Approval_Status='"+aprv+"' , Approved_By='"+aprvby+"' where Order_ID="+ordid;
            PreparedStatement ps = c.prepareStatement(query);
			 int affectedRows= ps.executeUpdate();
			 System.out.println(affectedRows);
			 if(affectedRows>0)
		            out.print("Record Updated");
   		}catch (ClassNotFoundException | SQLException e) {
			        	e.printStackTrace();
			        }
			    
    	}
}



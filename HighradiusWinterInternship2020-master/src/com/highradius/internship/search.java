package com.highradius.internship;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


@WebServlet("/search")
public class search extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String ord=request.getParameter("ord");
		 PrintWriter out = response.getWriter();
		 HttpSession session=request.getSession(); 
		String level_user=(String)session.getAttribute("level_user");
		try {
            Class.forName("com.mysql.jdbc.Driver");

            Connection c= DriverManager.getConnection("jdbc:mysql://localhost:3306/winter_internship", "root", "root");
            String query="";
        	if(level_user.equals("Level 1")) {
   		  	query=" select * from order_details where  CAST(Order_ID as CHAR)LIKE '%"+ord+"%'";}
        	else if(level_user.equals("Level 2")) {
        		query=" select * from order_details where Order_Amount BETWEEN 10001 AND 50000 and CAST(Order_ID as CHAR)LIKE '%"+ord+"%'";
        	}
        	else {
        		query=" select * from order_details where Order_Amount >50000 and CAST(Order_ID as CHAR)LIKE '%"+ord+"%'";
        	}
			PreparedStatement ps= c.prepareStatement(query);
			ResultSet rs = ps.executeQuery();
			out.print("<table id='myTable1' class='w3-table w3-striped' style='width:95%;margin:auto;' ><tr style='background-color: white;border-bottom: 3px solid orange;font-family: century gothic;color: Black;font-size: 12px;'><th>Select</th><th>Order Id</th><th>Customer Name</th><th>Customer Id</th><th>Order Amount</th><th>Approval Status</th><th>Approved By</th><th>Notes</th><th>Order Date</th></tr>");
			while(rs.next())
			 out.print("<tr style='font-family: century gothic;font-size: 13px;' ><td><label class='container'><input type='checkbox' autocomplete='off' class='checksearch' onClick='check_search(this)'><span class='checkmark'></span></label></td><td>"+rs.getString(1)+ "</td><td>"+rs.getString(2)+"</td><td>"+rs.getInt(3)+"</td><td>"+rs.getInt(4)+"</td> <td>"+rs.getString(5)+"</td> <td>"+rs.getString(6)+"</td><td>"+rs.getString(7)+"</td><td>"+rs.getString(8)+"</td></tr>");
			 out.print("</table>");
		}catch (ClassNotFoundException | SQLException e) {
        	e.printStackTrace();
        }
   		 
   	 }
}

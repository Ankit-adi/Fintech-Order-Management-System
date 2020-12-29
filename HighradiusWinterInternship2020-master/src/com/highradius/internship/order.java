package com.highradius.internship;

public class order{
	private int Order_Id;
	private String Customer_Name;
	private int Customer_Id;
	private int Order_Amount;
	private String Approval_Status;
	private String Approved_By;
	private String Notes;
	private String Order_Date;
	
	public int getOrder_Id(){
		return Order_Id;
		}
	public void setOrder_Id	(int Order_Id){
		this.Order_Id=Order_Id;
	}
	public String getCustomer_Name(){
		return Customer_Name;
		}
	public void setCustomer_Name(String Customer_Name){
		this.Customer_Name=Customer_Name;
	}
	public int getCustomer_Id(){
		return Customer_Id;
		}
	public void setCustomer_Id(int Customer_Id){
		this.Customer_Id=Customer_Id;
	}
	public int getOrder_Amount(){
		return Order_Amount;
		}
	public void setOrder_Amount(int Order_Amount){
		this.Order_Amount=Order_Amount;
	}
	public String getApproval_Status(){
		return Approval_Status;
		}
	public void setApproval_Status(String Approval_Status){
		this.Approval_Status=Approval_Status;
	}
	public String getApproved_By(){
		return Approved_By;
		}
	public void setApproved_By(String Approved_By){
		this.Approved_By=Approved_By;
	}
	public String getNotes(){
		return Notes;
		}
	public void setNotes(String Notes){
		this.Notes=Notes;
	}
	public String getOrder_Date(){
		return Order_Date;
		}
	public void setOrder_Date(String Order_Date){
		this.Order_Date=Order_Date;
	}
}	

	
	

	
	
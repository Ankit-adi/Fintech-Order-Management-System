<%@page import="java.sql.*"%>
<%@page import= "java.util.ArrayList" %>
<%@page import= "java.util.List" %>
<%@page import="com.highradius.internship.order" %>
<%
    String status=(String)session.getAttribute("status");
    String user_name=(String)session.getAttribute("user_name");
    String level_user=(String)session.getAttribute("level_user");
     if(session.getAttribute("status")==null ||session.getAttribute("user_name")==null || session.getAttribute("level_user")==null)
    	 response.sendRedirect("index.jsp");
%>
<! DOCTYPE HTML>
<html>
<head> 
<title> DashBoard</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="css/stylings.css">
<link rel="stylesheet" type="text/css" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<script>
	var msg1=localStorage.getItem("msg1");
	if(msg1.localeCompare("Not Ok")==0){
		document.location="index.jsp";
	}
</script>	
	
</head>
<body>
    <%
	Class.forName("com.mysql.jdbc.Driver");
   	Connection c = DriverManager.getConnection("jdbc:mysql://localhost:3306/winter_internship", "root", "root");
   	int noOfRecords=0;
   	String spageid;
   	int pageid=1;
 	int currentpage=1;
   	spageid=request.getParameter("page");
   	if(spageid!=null)
   		pageid=Integer.parseInt(spageid);
   	currentpage=pageid;
   	
   	if(pageid!=1)
   	{
   		pageid=pageid-1;
   		pageid=pageid*10+1;
   	}
   	String query=null;
   	if(level_user.equals("Level 1")){
	 query ="select SQL_CALC_FOUND_ROWS * from order_details limit "+ (pageid-1) +" ,  10";}
   	else if (level_user.equals("Level 2")){
   		query ="select SQL_CALC_FOUND_ROWS * from order_details WHERE Order_Amount BETWEEN 10001 AND 50000 limit "+ (pageid-1) +" ,  10 ";
   	}
   	else{
   		query ="select SQL_CALC_FOUND_ROWS * from order_details WHERE Order_Amount >50000 limit "+ (pageid-1) +" ,  10 ";
   	}
                 
                List<order> list =new ArrayList<order>();
                 order ord=null;
                 try {
                	 
                	Statement ps1= c.createStatement();
                	
                 
                	ResultSet rs1 = ps1.executeQuery(query); 
                	while(rs1.next()) {
                		ord=new order();
						ord.setOrder_Id(rs1.getInt("Order_Id"));
						ord.setCustomer_Name(rs1.getString("Customer_Name"));
						ord.setCustomer_Id(rs1.getInt("Customer_Id"));
						ord.setOrder_Amount(rs1.getInt("Order_Amount"));
						ord.setApproval_Status(rs1.getString("Approval_Status"));
						ord.setApproved_By(rs1.getString("Approved_By"));
						ord.setNotes(rs1.getString("Notes"));
						ord.setOrder_Date(rs1.getString("Order_Date"));
						list.add(ord);
                	
                		}
                	
                	
                	
                	rs1=ps1.executeQuery("SELECT FOUND_ROWS()");
                	
                   if(rs1.next())
                	   noOfRecords=rs1.getInt(1);
                  
                 }catch(SQLException e) {
                	 e.printStackTrace();
                	 }
          	int noOfPages=(int)Math.ceil(noOfRecords*1.0/10);
            	 

%>
<div id="myModal" class="modal">

  <!-- Modal content -->
  <div class="modal-content" id="d1">
   <h3 style="font-color:grey;border-bottom:2px solid grey;"><span style="background-color:white;border-bottom:2px solid orange;margin-left:2%;">ADD ORDER</span> <span class="close" style="background-color:white"><a href="dashboard.jsp">&times;</a></span>
    </h3>
   <label style="font-size:1.5vw;font-family: century gothic;color:grey; letter-spacing: 2px;">&nbsp;&nbsp;&nbsp;&nbsp;Order Id&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label><input class="input" width=30% type="number" placeholder="order id" id="ordid" name="ordid" ></input><br><br>
   <label style="font-size:1.5vw;font-family: century gothic;color:grey; letter-spacing: 2px;">&nbsp;&nbsp;&nbsp;&nbsp;Order Date&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label><input class="input" type="datetime-local" width=30% placeholder="dd-mm-yy hh:mm:ss" id="orddat" name="orddat"></input><br><br>
   <label style="font-size:1.5vw;font-family: century gothic;color:grey; letter-spacing: 2px;">&nbsp;&nbsp;&nbsp;Customer Name&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label><input class="input" type="text" width=30% placeholder="customer name" id="cstnam" name="cstnam"></input><br><br>
   <label style="font-size:1.5vw;font-family: century gothic;color:grey; letter-spacing: 2px;">&nbsp;&nbsp;&nbsp;&nbsp;Customer No&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label><input  class="input" type="number" width=30% placeholder="customer number" id="cstnum" name="cstnum"></input><br><br>
   <label style="font-size:1.5vw;font-family: century gothic;color:grey; letter-spacing: 2px;">&nbsp;&nbsp;&nbsp;&nbsp;Order Amount&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label><input  class="input" type="number" width=30%  placeholder="order amount" id="ordamt" name="ordamt"></input><br><br>
   <label style="font-size:1.5vw;font-family: century gothic;color:grey; letter-spacing: 2px;">&nbsp;&nbsp;&nbsp;&nbsp;Notes&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label><input  class="input" width=30% type="text" placeholder="notes" id="note" name="note"></input><br><br>
   <h3 id="msg" style="text-align:center;color:red;"></h3>
   <button id="btn" onClick="add()">ADD</button>
   
  </div>
    <div class="modal-content"  style="height:55%"id="d2">
   <h3 style="font-color:grey;border-bottom:2px solid grey;"><span style="background-color:white;border-bottom:2px solid orange;margin-left:2%;">EDIT ORDER</span> <span class="close" style="background-color:white"><a href="dashboard.jsp?page=<%=currentpage%>">&times;</a></span>
    </h3>
  
   <label style="font-size:1.5vw;font-family: century gothic;color:grey; letter-spacing: 2px;">&nbsp;&nbsp;&nbsp;&nbsp;Order Id&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label><input type="number" width=30% class="input"  placeholder="order id" id="ord_id" name="ordid" disabled></input><br><br>
   <label style="font-size:1.5vw;font-family: century gothic;color:grey; letter-spacing: 2px;">&nbsp;&nbsp;&nbsp;&nbsp;Order Amount&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label><input type="number" width=30% class="input" oninput="change()" placeholder="order amount" id="ord_amt" name="ordamt"></input><br><br>
   <label style="font-size:1.5vw;font-family: century gothic;color:grey; letter-spacing: 2px;">&nbsp;&nbsp;&nbsp;&nbsp;Note&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label><input type="text" width=30% class="input" placeholder="Note" id="no_te" name="note"></input><br><br>
 <label style="font-size:1.5vw;font-family: century gothic;color:grey; letter-spacing: 2px;">&nbsp;&nbsp;&nbsp;&nbsp;Approved By&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label><input type="text" width=30% class="input"  placeholder="approved by" id="aprv_by" name="aprvby" disabled></input><br><br>
   <h5 id="msg" style="text-align:center;color:red;"></h5>
   <button id="btn" onClick="edit()">SUBMIT</button>
   
  </div>
   

</div>
<div style="position: relative; padding-left:20px;" class="header">
	<img alt="logo" height="8%" src="images\hrc-logo.svg">
	<img alt="logo" height="8%" style="margin-left:20%;"src="images\abc-logo.png">
</div>
  <div style="width:95%;border:4px solid #aaaaaa;margin:auto;margin-top:3%">
  <button class="button "  onClick="showDialog()"> ADD </button>  <button  class="button " id="btn2" > EDIT </button>
   <button class="button "> APPROVE </button> <button  class="button "  > REJECT </button>
	<input type="number" name="" placeholder="Search"  id="myInput" onkeyup="search()" title="Type in a name" style="background-color:#99ccff;font-size:1.3vw;display:inline-block;margin-right:5%;width:15%;float:right;">
	<div id="tab2" style="height:400px;overflow:auto; display:none;"></div>
	<div id="tab" style="height:400px;overflow:auto;">
	  <table id="myTable" class="w3-table w3-striped" style="width:95%;margin:auto;" >
    <tr style="background-color: white;border-bottom: 3px solid orange;font-family: century gothic;color: Black;font-size: 13px;">
    <th>Select</th>
    <th>Order Id</th>
      <th>Customer Name</th>
      <th>Customer Id</th>
	    <th>Order Amount</th>
      <th>Approval Status</th>
      <th>Approved By</th>
      <th>Notes</th>
      <th>Order Date</th>
    </tr>
       

<% 
	int k=0;
	 for(order or:list){
		 k++;
		 String id="id"+k;
	 out.print("<tr style='font-family: century gothic;font-size: 13px;'><td><label class='container'><input type='checkbox' autocomplete='off' id="+id+" onClick='check(this)'><span class='checkmark'></span></label></td><td>"+or.getOrder_Id()+ "</td><td>"+or.getCustomer_Name()+"</td><td>"+or.getCustomer_Id()+"</td><td>"+or.getOrder_Amount()+"</td> <td>"+or.getApproval_Status()+"</td> <td>"+or.getApproved_By()+"</td><td>"+or.getNotes()+"</td><td>"+or.getOrder_Date()+"</td></tr>");
	 }
%>
</table>
</div>
<script>
var level_user='<%=level_user %>';
if(level_user.localeCompare("Level 1")==0){
		
		 document.getElementsByClassName("button")[0].style.display= "inline-block";
	     document.getElementsByClassName("button")[1].style.display="inline-block";}
	else{
		
		document.getElementsByClassName("button")[2].style.display="inline-block";
		document.getElementsByClassName("button")[3].style.display="inline-block";
		
	}     

</script>
 

<%
     String prev="dashboard.jsp?page="+(currentpage-1);
	 String next="dashboard.jsp?page="+(currentpage+1);
	 
	 String first="dashboard.jsp?page=1";
	 String last="dashboard.jsp?page="+noOfPages;
	 out.print("<div id='div1' style='margin:auto;margin-top:1%;margin-bottom:1%;width:95%;'><a class='previous' href="+first+">&nbsp;&laquo;&nbsp;</a>");
	 	 
     if(currentpage!=1&&currentpage!=noOfPages)
     {
    	 out.print("<a class='previous' href="+prev+">&nbsp;&#8249;&nbsp;</a>	&nbsp;	&nbsp;");
    	 out.print("Page	&nbsp;	<span>&nbsp;"+currentpage+"&nbsp;</span>	&nbsp;	of	&nbsp;	"+noOfPages );
    	 out.print("&nbsp;	<a class='next' href="+next+">&nbsp;&#8250&nbsp;</a>");
     }
     else if(currentpage==noOfPages)
     {
    	 out.print("<a class='previous' href="+prev+">&nbsp;&#8249;&nbsp;</a>	&nbsp;	&nbsp;"); 
    	 out.print("Page	&nbsp;	<span>&nbsp;"+currentpage+"&nbsp;</span>&nbsp;	of	&nbsp;"+noOfPages );
    	 out.print("&nbsp;	<a class='next' class='next'>&nbsp;&#8250&nbsp;&nbsp;</a>");
     } 
     else if(currentpage==1)
     {
    	 out.print("<a class='previous'>&nbsp;&#8249;&nbsp;</a>	&nbsp;	&nbsp;	");
    	 out.print("Page	&nbsp;	<span>&nbsp;"+currentpage+"&nbsp;</span> &nbsp;	of	&nbsp;"+noOfPages );
    	 out.print("&nbsp;	<a class='next' href="+next+" >&nbsp;&#8250&nbsp;</a>");
    	 
     }
     out.print("<a class='next' href="+last+">&nbsp;&raquo;&nbsp;</a>");
     int start=(currentpage-1)*10+1;
         int end=start+9;
         if(currentpage==noOfPages)
        	 end = noOfRecords;
         
         out.print("<h5 style='display:inline;margin-left:48%font-family: century gothic;'><span style='font-size:1.5vw;float:right;background-color:white;'>Customers &nbsp;"+start+" &nbsp;- &nbsp;"+end +" &nbsp; of &nbsp; "+noOfRecords+" &nbsp; &nbsp;</span></h5></div>");   
 %>
 </div>
<script>
var currentpage='<%=currentpage %>';
var user_name='<%=user_name %>';
var level_user='<%=level_user %>'; 
var ordid;
var orddat;
var cstnam;
var cstnum;
var ordamt;
var note;
var aprv;
var aprvby;
var flag=0;
var x=document.getElementById("btn2");
var nrow = '<%=k%>';
var row = parseInt(nrow);


	  function add(){
		  var ordid=document.getElementById("ordid").value;
		  var orddat=document.getElementById("orddat").value;
		  var cstnam=document.getElementById("cstnam").value;
		  var cstnum=document.getElementById("cstnum").value;
		  var ordamt=document.getElementById("ordamt").value;
		  var note=document.getElementById("note").value;
		  var aprv="";
		  var aprvby="";
		  
		 
		 
		  
	     if(ordid.length==0||orddat.length==0||cstnam.length==0||cstnum.length==0||note.length==0){
	    	 document.getElementById("msg").innerHTML = "Values Can't be Empty";
	    	 return;}
	     else
	    	 document.getElementById("msg").innerHTML = "";
	     if(parseInt(ordamt)<=10000){
	    	
	    	 aprv="Approved";
	    	 aprvby=user_name;
	    		}
	     else{
	    	 aprv="Awaiting Approval";
	    	 aprvby="";
	    		 
	     }
	     
	     var xmlhttp = new XMLHttpRequest();
	     xmlhttp.onreadystatechange = function(){
	       if (this.readyState == 4 && this.status == 200) {
	         document.getElementById("msg").innerHTML = this.responseText;
	       }
	     };
	     xmlhttp.open("GET","add?ordid="+ordid+"&orddat="+orddat+"&cstnam="+cstnam+"&cstnum="+cstnum+"&ordamt="+ordamt+"&aprv="+aprv+"&aprvby="+aprvby+"&note="+note,true);
	     xmlhttp.send();
	    	     	 
}
	  
	  function approve(){
			if(aprv.localeCompare("Approved")==0)
				{
				    window.alert("Order is Already Approved");
				    return;
				}
			else if(aprv.localeCompare("Rejected")==0){
				
				 window.alert("Order is Already Rejected");
				    return;
			}
			else{
				
				  if(((parseInt(ordamt)>=10000)&&(parseInt(ordamt)<=50000))&&(level_user.localeCompare("Level 2")==0)){
				    	
				    	aprv="Approved";
				    	aprvby=user_name;
				    }
				    else if((parseInt(ordamt)>50000)&&(level_user.localeCompare("Level 3")==0)){
				    	aprv="Approved";
				    	aprvby=user_name;
				    	
				    }
				    else{
				    	    window.alert("Order Out Of Range");
				    	    return;
				    }
				
				
			}
			 var xmlhttp = new XMLHttpRequest();
		     xmlhttp.onreadystatechange = function() {
		       if (this.readyState == 4 && this.status == 200) {
		    	   window.alert(this.responseText);
		    	   document.location="dashboard.jsp?level_user="+level_user+"&page="+currentpage;
		       }
		     };
		     xmlhttp.open("GET","approve?ordid="+ordid+"&aprv="+aprv+"&aprvby="+aprvby,true);
		     xmlhttp.send();
		 }
function reject(){
			if(aprv.localeCompare("Approved")==0)
				{
				    window.alert("Order is Already Approved");
				    return;
				}
			else if(aprv.localeCompare("Rejected")==0){
				
				 window.alert("Order is Already Rejected");
				    return;
			}
			else{
				
				    if(((parseInt(ordamt)>=10000)&&(parseInt(ordamt)<=50000))&&(level_user.localeCompare("Level 2")==0)){
				    	
				    	aprv="Rejected";
				    	aprvby=user_name;
				    }
				    else if((parseInt(ordamt)>50000)&&(level_user.localeCompare("Level 3")==0)){
				    	aprv="Rejected";
				    	aprvby=user_name;
				    	
				    }
				    else{
				    	    window.alert("Order Out Of Range");
				    	    return;
				    }
				
				
			}
			 var xmlhttp = new XMLHttpRequest();
		     xmlhttp.onreadystatechange = function() {
		       if (this.readyState == 4 && this.status == 200) {
		          window.alert(this.responseText);
		          document.location="dashboard.jsp?level_user="+level_user+"&page="+currentpage;
		       }
		     };
		     xmlhttp.open("GET","reject?ordid="+ordid+"&aprv="+aprv+"&aprvby="+aprvby,true);
		     xmlhttp.send();
		
		}
		
function edit(){
	
	
	  var ordid=document.getElementById("ord_id").value;
	  var ord=document.getElementById("ord_amt").value;
	  var no=document.getElementById("no_te").value;
	  var aprvby=document.getElementById("aprv_by").value;
	  var aprv="";
	  if(ord.localeCompare(ordamt)==0 && no.localeCompare(note)==0){
		  window.alert("No changes");
		  return;
	  }
	  if(ord.length==0)
		{
		  window.alert("Amount can't be empty");
		  return;
		}
	
	  if(no.length==0)
		  no="";
	  if(parseInt(ord)<=10000){
		  aprv="Approved";
		  aprvby="David_Lee";
	  }
	  else{
		  aprv="Awaiting Approval";
		  aprvby="";
	  }
	  
	   
	  var xmlhttp = new XMLHttpRequest();
	     xmlhttp.onreadystatechange = function() {
	       if (this.readyState == 4 && this.status == 200) {
	    	   window.alert(this.responseText);
	       }
	     };
	     xmlhttp.open("GET","edit?ordid="+ordid+"&ordamt="+ord+"&aprv="+aprv+"&aprvby="+aprvby+"&note="+no,true);
	     xmlhttp.send();
	}
	
function search() {
	   var input=document.getElementById("myInput").value;
		flag=0; 
		  x.removeEventListener("click", showDialog2);
		  document.getElementsByClassName("button")[2].removeEventListener("click",approve);
		  document.getElementsByClassName("button")[3].removeEventListener("click",reject);
		  for(var i=1;i<=row;i++){
			   var ids="id"+i;
			   document.getElementById(ids).checked=false;
		   }
	    
	  
	   if(input.length==0)
		   {
		   document.getElementById("tab").style.display = "block";
		   document.getElementById("tab2").style.display = "none";
		   document.getElementById("div1").style.display = "block";		    
		   }
	   
	   else{
		  
		   document.getElementById("tab").style.display = "none";
		   document.getElementById("tab2").style.display = "block";
		   document.getElementById("div1").style.display = "none";
		   
		   
		   var xmlhttp = new XMLHttpRequest();
		     xmlhttp.onreadystatechange = function() {
		       if (this.readyState == 4 && this.status == 200) {
		    	   document.getElementById("tab2").innerHTML=this.responseText;
		       }
		     };
		     xmlhttp.open("GET","search?ord="+input,true);
		     xmlhttp.send();
		   
		   
	   }
	
	}
	
function check_search(id){
	row=document.getElementsByClassName("checksearch").length;
	for(var i=0;i<row;i++){
		if(i%2==0){
		   document.getElementsByClassName("checksearch")[i].parentNode.parentNode.parentNode.style.backgroundColor="white";}
		else
		   document.getElementsByClassName("checksearch")[i].parentNode.parentNode.parentNode.style.backgroundColor="#99ccff";
	   }
	
	  if(id.checked==false){
	    	flag=0; 
		  x.removeEventListener("click", showDialog2);
		  document.getElementsByClassName("button")[2].removeEventListener("click",approve);
		  document.getElementsByClassName("button")[3].removeEventListener("click",reject);
	      return;
	      
		  }
	
	   for(var i=0;i<row;i++){
		   document.getElementsByClassName("checksearch")[i].checked=false;
		   
	   }
	   id.checked=true;
	   
	   var n= id.parentNode;
	   n=n.parentNode;
	   n=n.parentNode;
	   n.style.backgroundColor="orange";
	   
	   ordid=n.cells[1].innerHTML;
	   aprv=n.cells[5].innerHTML;
	   ordamt=n.cells[4].innerHTML;
	   aprvby=n.cells[6].innerHTML;
	   note=n.cells[7].innerHTML;
	   
	 
	   document.getElementById("ord_id").value=ordid;
	   document.getElementById("ord_amt").value=ordamt;
	   document.getElementById("no_te").value=note;
	   document.getElementById("aprv_by").value=aprvby;
	   
	   if(flag==0){
		   flag=1;
	     x.addEventListener("click", showDialog2);
	     document.getElementsByClassName("button")[2].addEventListener("click",approve);
		  document.getElementsByClassName("button")[3].addEventListener("click",reject);
	     }
}
 function check(id){
	  	for(var i=1;i<=row;i++){
	  		var ids="id"+i;
	  		var s=((document.getElementById(ids).parentNode).parentNode).parentNode;
	  		if(i%2==0){
	  			s.style.backgroundColor="#99ccff";
	  		}
	  		else
	  			s.style.backgroundColor="white";
	  	}
		 
	     if(id.checked==false){
	    	flag=0; 
		  x.removeEventListener("click", showDialog2);
		  document.getElementsByClassName("button")[2].removeEventListener("click",approve);
		  document.getElementsByClassName("button")[3].removeEventListener("click",reject);
	      return;
	      
		  }
	     
	   for(var i=1;i<=row;i++){
		   var ids="id"+i;
		   document.getElementById(ids).checked=false;
	   }
	   id.checked=true;
	   
	   var n= id.parentNode;
	   n=n.parentNode;
	   n=n.parentNode;
	  n.style.backgroundColor="orange";
	   
	   ordid=n.cells[1].innerHTML;
	   aprv=n.cells[5].innerHTML;
	   ordamt=n.cells[4].innerHTML;
	   aprvby=n.cells[6].innerHTML;
	   note=n.cells[7].innerHTML;
	   
	   document.getElementById("ord_id").value=ordid;
	   document.getElementById("ord_amt").value=ordamt;
	   document.getElementById("no_te").value=n.cells[7].innerHTML;
	   document.getElementById("aprv_by").value=aprvby;
	   
	   if(flag==0){
		   flag=1;
	     x.addEventListener("click", showDialog2);
	     document.getElementsByClassName("button")[2].addEventListener("click",approve);
		  document.getElementsByClassName("button")[3].addEventListener("click",reject);
	     }
	  
}   
  
  function change(){
		
		 var amt=document.getElementById("ord_amt").value;
		 if(amt.length==0){
			 document.getElementById("aprv_by").value="";
			 return;}
		 if(parseInt(amt)<10000)
			 document.getElementById("aprv_by").value=user_name;
		 else if((parseInt(amt)>=10000)&&(parseInt(amt)<=50000))
			 document.getElementById("aprv_by").value="Laura Smith";
		 else
			 document.getElementById("aprv_by").value="Matthew Vance";
		}
  
  var modal = document.getElementById("myModal");
  var span = document.getElementsByClassName("close")[0];

  function showDialog(){
  	modal.style.display = "block";
  	document.getElementById("d1").style.display="block";
  	 document.getElementById("d2").style.display="none";
  	 }
  
  function showDialog2(){
  	modal.style.display = "block";
  	document.getElementById("d1").style.display="none";
  	 document.getElementById("d2").style.display="block";
  	}
  
   window.onclick = function(event) {
    if (event.target == modal) {
      modal.style.display = "none";
    }
  }
  </script>
</body>
</html>
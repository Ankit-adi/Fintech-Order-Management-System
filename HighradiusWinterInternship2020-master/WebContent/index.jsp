<! DOCTYPE HTML>
<html>
<head>
<title> LOGIN </title>
 <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
<style> 
input[type=text]{
  width: 95%;
  padding: 12px 20px;
   max-width:350px;
   background-color: rgb(111, 157, 168);
  
  border: none;
  border-bottom: 2px solid rgba(255, 115, 0, 0.589);
}

input[type=password] {
  width: 95%;
  padding: 12px 20px;
   max-width:350px;
  background-color: rgb(111,157,168);
 
  border: none;
  border-bottom: 2px solid rgba(255, 115, 0, 0.589);
}

input[type=text]:focus {
  background-color: rgb(34, 197, 238);
}
input[type=password]:focus {
  background-color: rgb(34, 197, 238);
}
input[type=submit] {
  width: 35%;
  margin-left:50%;
  border:none;
  color:white;
  background-color:rgb(114, 117, 114);
  font-size:2vw;
}
.sub:hover{
color:black;
background-color:rgb(238, 150, 34);
border:none;
}

#fix{
 position: fixed;
  left: 0.5%;
  margin-top:30%;
width:40%;
background-color:green;
color: white;
 text-align:right;
 border:none;
 padding:.5%;
 font-size:2vw;
}

</style>
</head>
<body  style="background-image: url('images/hrc_back.png');background-size:100%;background-repeat: no-repeat;">
<div style="position: relative; padding-left:20px;" class="header">
	<img alt="logo" width="20%" height="8%" src="images\hrc-logo.svg">
</div>

<%   
 String msg=(String)session.getAttribute("msg");     
%>
 <p id="fix"> 
 ORDER MANAGEMENT APPLICATION
</p>
<div  style="margin-top:20%;max-width:30%;margin-left:60%;margin-bottom:5%" >
<form style="margin:auto;" method="post" action="login_check_validation">
  <div class="card-heading1" style="background-repeat: no-repeat;background-attachment: fixed"></div>
  <div class="card-body">
      <h2 class="title3">Sign In</h2>
      <span style="font-size:12px"></span>
      <h4 class="title2">UserName</h4>
      <div class="input-group">
              <input class="input--style-3" type="text" placeholder="UserName" name="username">
          </div>
          <h4 class="title1">Password</h4>
          <div class="input-group">
              <input class="input--style-3" type="password" placeholder="Enter Password" name="password">
          </div>
      
          <input  class="sub" type="submit" onClick="createSession()" style="color:white;margin-top:4%" value="Sign In">
            <h5  style="letter-spacing: 2px;color:red;text-align:center;margin-right:15%" > 
 
 <%   
   if(msg!=null)
	 out.print(msg);
   session.removeAttribute("msg"); 
%>  
                </h5>
          
</form>
</div>

</body>
<script>
localStorage.setItem("msg1","Not Ok");
function createSession(){
	localStorage.setItem("msg1","Ok");
}
</script>

</html>
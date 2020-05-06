<%@ page language="java" contentType="text/html; charset=ISO-8859-1"  pageEncoding="ISO-8859-1"%>
<%@ page import="model.Appointment"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

	<title>Appointment</title>

	<link rel="stylesheet" href="Views/bootstrap.min.css"> 
	<script src="Components/jquery-3.2.1.min.js"></script> 
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
	
	
	<script>
			$(document).ready(function() {
				$("#alertSuccess").hide();
				$("#alertError").hide();
			});
		
			// SAVE ============================================
			$(document).on("click", "#btnSave", function(event) {
		
				// Clear status mesages---------------------
				$("#alertSuccess").text("");
				$("#alertSuccess").hide();
				$("#alertError").text("");
				$("#alertError").hide();
		
				// Form validation-------------------
				var status = validateAppointmentForm();
		
				// If not valid
		
				if (status != true) {
					$("#alertError").text(status);
					$("#alertError").show();
					return;
				}
		
				// If valid
				var type = ($("#hidapp_no1Save").val() == "") ? "POST" : "PUT";
		
				$.ajax({
					url : "AppointmentAPI",
					type : type,
					data : $("#formAppointment").serialize(),
					dataType : "text",
					complete : function(response, status) {
						onAppointmentSaveComplete(response.responseText, status);
					}
				});
		
			});
		
			function onAppointmentSaveComplete(response, status) {
		
				if (status == "success") {
		
					var resultSet = JSON.parse(response);
					
					console.log(resultSet.status.trim());
		
					if (resultSet.status.trim() == "success") {
						$("#alertSuccess").text("Successfully saved.");
						$("#alertSuccess").show();
		
						$("#divAppointmentGrid").html(resultSet.data);
					} else if (resultSet.status.trim() == "error") {
						$("#alertError").text(resultSet.data);
						$("#alertError").show();
					}
				} else if (status == "error") {
					$("#alertError").text("Error while saving.");
					$("#alertError").show();
				} else {
					$("#alertError").text("Unknown error while saving..");
					$("#alertError").show();
				}
		
				$("#hidapp_no1Save").val("");
				$("#formApoointment")[0].reset();
			}
			
			 // UPDATE==========================================
				$(document).on("click",".btnUpdate",function(event) 
				{
				    $("#app_no1").val($(this).closest("tr").find('td:eq(0)').text());     
				    $("#date_time").val($(this).closest("tr").find('td:eq(1)').text());     
				    $("#Hos_no").val($(this).closest("tr").find('td:eq(2)').text());     
				    $("#Doc_no").val($(this).closest("tr").find('td:eq(3)').text()); 
				}); 
				
			// Remove==========================================
			$(document).on("click", ".btnRemove", function(event) {
				$.ajax({
					url : "AppointmentAPI",  
					type : "DELETE",
					data : "app_no1=" + $(this).data("app_no1"),
					dataType : "text",
					complete : function(response, status) {
						onAppointmentDeleteComplete(response.responseText, status);
					}
				});
			});
		
			function onAppointmentDeleteComplete(response, status) {
				if (status == "success") {
					var resultSet = JSON.parse(response);
		
					if (resultSet.status.trim() == "success") {
						$("#alertSuccess").text("Successfully deleted.");
						$("#alertSuccess").show();
		
						$("#divAppointmentGrid").html(resultSet.data);
					} else if (resultSet.status.trim() == "error") {
						$("#alertError").text(resultSet.data);
						$("#alertError").show();
					}
				} else if (status == "error") {
					$("#alertError").text("Error while deleting.");
					$("#alertError").show();
				} else {
					$("#alertError").text("Unknown error while deleting..");
					$("#alertError").show();
				}
			}
			// CLIENT-MODEL============================================
			function validateAppointmentForm() {
		
				// APPOINTMENT NUMBER-------------------------------
				if ($("#app_no1").val().trim() == "") {
					return "Insert Appointment Number.";
				}
				// APPOINTMENT DATE AND TIME-----------------------------
				if ($("#date_time").val().trim() == "") {
					return "Insert  Appointment Date and Time.";
				}
		
				// HOSPITAL NAME-------------------------------
				if ($("#Hos_no").val().trim() == "") {
					return "Insert Hospital Name.";
		
				}
				// DOCTOR NAME-------------------------------
				if ($("#Doc_no").val().trim() == "") {
					return "Insert Doctor Name.";
		
				}
		
				return true;
			}
			 
	</script>	

</head>
<body>

 <div class="container"> 
 
    <div class="row">    
  		<div class="col-8"> 
 
    		<h1 class="m-3">Appointment Management</h1> 
 
    		<form id="formAppointment" name="formAppointment" method="post" action="index.jsp">  
    			  
    			<div class='col-md-10'>
               		<div class="form-group">
                  		<label class="control-label">Appointment Number</label>
                     	<input type='text' class="form-control" id="app_no1" name="app_no1" />
               		</div>
            	</div>
    			<br> 
    			
            	<div class='col-md-10'>
               		<div class="form-group">
                  		<label class="control-label">Appintment Date and Time (YYY-MM-DD HH:MM:SS)</label>
                     	<input type='text' class="form-control" id="date_time" name="date_time" />
                     </div>	
            	</div>
    			<br> 
            	<div class='col-md-10'>
               		<div class="form-group">
                  		<label class="control-label">Hospital Name</label>
                     	<input type='text' class="form-control" id="Hos_no" name="Hos_no" />
               		</div>
            	</div>
    			<br> 
    			<div class='col-md-10'>
               		<div class="form-group">
                  		<label class="control-label">Doctor Name</label>
                     	<input type='text' class="form-control" id="Doc_no" name="Doc_no" />
               		</div>
            	</div>
    			
    			<br> 
    			 <div class='col-md-10'>
               		<div class="form-group">
                  		<input id="btnSave" name="btnSave" type="button" value="Save" class="btn btn-success">
               		</div>
            	</div> 
    			
    				<input type="hidden" id="hidapp_no1Save" name="hidapp_no1Save" value=""> 
    				
    		</form> 
 
 			 <div class='col-md-10'>
               		<div class="form-group">
                  		<div id="alertSuccess" class="alert alert-success">
 						</div>
               		</div>
            </div> 
            
            <div class='col-md-10'>
               		<div class="form-group">
                  		<div id="alertError" class="alert alert-danger">
 						</div>
               		</div>
            </div> 

 			<div class='col-md-12'>
               		<div class="form-group">
                  		<div id="divAppointmentGrid"> 
				 			<%
				 				Appointment itemObj = new Appointment();
				 				out.print(itemObj.read());
				 			%>
 						</div>
               		</div>
            </div> 
 			
 
    	</div> 
    	  
     </div> 
    
 </div>
           
</body>
</html>
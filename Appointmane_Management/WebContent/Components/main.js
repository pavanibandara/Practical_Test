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
	var type = ($("#hidhosIDSave").val() == "") ? "POST" : "PUT";

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

		if (resultSet.status.trim() == "success") {
			$("#alertSuccess").text("Successfully saved.");
			$("#alertSuccess").show();

			$("#divHospitalGrid").html(resultSet.data);
		} else if (resultSet.status.trim() == "error") {
			$("#alertError").text(resultSet.data);
			$("#alertError").show();
		}
	} else if (status == "error") {
		$("#alertError").text("Error while saving.");
		$("#alertError").show();
	}

	else {
		$("#alertError").text("Unknown error while saving..");
		$("#alertError").show();
	}

	$("#hidapp_noSave").val("");
	$("#formApoointment")[0].reset();
}

// UPDATE==========================================
$(document).on(
		"click",
		".btnUpdate",
		function(event) {
			$("#hidapp_noSave").val(
			$(this).closest("tr").find('#hidapp_noUpdate').val());
			$("#date_time").val($(this).closest("tr").find('td:eq(0)').text());
			$("#Hos_no").val($(this).closest("tr").find('td:eq(1)').text());
			$("#Doc_no").val($(this).closest("tr").find('td:eq(2)').text());

		});

// Remove==========================================
$(document).on("click", ".btnRemove", function(event) {
	$.ajax({
		url : "AppointmentAPI",
		type : "DELETE",
		data : "app_no=" + $(this).data("app_no"),
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

			$("#divHospitalGrid").html(resultSet.data);
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

	// CODE-------------------------------
	if ($("#app_no").val().trim() == "") {
		return "Insert Appointment Number.";
	}
	// NAME-----------------------------
	if ($("#datetimepicker1").val().trim() == "") {
		return "Insert  Appointment Time.";
	}

	// PRICE-------------------------------
	if ($("#Hos_no").val().trim() == "") {
		return "Insert Hospital Name.";

	}
	// PRICE-------------------------------
	if ($("#Doc_no").val().trim() == "") {
		return "Insert Doctor Name.";

	}

	return true;
}

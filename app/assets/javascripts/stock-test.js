$(document).ready(function() {

		
 $("#dialog-form").dialog({
        autoOpen: false,
        height: 250,
        width: 200,
        modal: true,
        resizable:false
    });
    $(".add").click(function(e){
        e.preventDefault();
		var sym = $(this).attr("name");
        $("#dialog-form").dialog( "open" ).focus();
		$("#script_symbol").val(sym);

    });
    $('#dialog-form').focus();

function sendDataToServer() {
var symb = $("#script_symbol").val();
var b_s = $("#buy_sale input[type='radio']:checked").val();;
var quan = $("#quantity").val();
var price = $("#user_price").val();
    var data = {
script_symbol: symb,	
buyorsale: b_s,
quantity: quan,
user_price: price,
commit: "Submit"
    }
    $.ajax({
type: "POST",
url: "/sessions/add_to_portfolio",
data: data,
dataType: "script",
success: function(){
    alert('success');
  },
  error: function(data,status,e){
    alert(e);
  }
    });
}
$("#add_to_db").click(function(e){
        e.preventDefault();
        sendDataToServer(); 
    });

	});
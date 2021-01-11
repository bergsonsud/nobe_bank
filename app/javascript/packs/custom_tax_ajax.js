function toggleAlert(value){
  var warning = document.getElementById("warning");
  if (value == 0) {
      warning.style.display = "none";
  } else{
      warning.style.display = "block";
      warning.textContent = 'Essa operação tem um custo! Será retirado de sua conta R$ ' + (parseFloat(value)).toFixed(2).toString();      
  };
};

$(document).ready(function(){
  $('#value').keyup(function() {
    var tax = document.getElementById('tax');
    var value = document.getElementById('value').value.replace(',', "");

    $.ajax({
      type:"GET",
      url:"/transactions/get_tax",
      dataType:"json",
      data: {value: value, type_transaction: <%=params[:type_transaction]%>},
      success:function(result){
        tax.value = parseFloat(result).toFixed(2);
        toggleAlert(result);
      }
    });
  });
});
$(function () {
  $('#value').keyup(function () {
    var value = parseFloat(this.value.replace(',', ""));
    var tax_calc = document.getElementById('tax_calc');
    var extra = document.getElementById('extra');
    var tax = document.getElementById('tax');
    var warning = document.getElementById("warning");
    var var_extra = 10;

    if (value == 0) {
      tax.value = 0;
      extra.value = 0;
      warning.style.display = "none";

    } else if (value > 0 && value < 1000) {
      tax.value = parseFloat(tax_calc.value).toFixed(2);
      extra.value = 0;
      warning.style.display = "block";
      warning.textContent = 'Essa operação tem um custo! Será retirado de sua conta R$ ' + (
        parseFloat(value) + parseFloat(tax_calc.value)
      ).toFixed(2).toString();

    } else {
      tax.value = (parseFloat(tax_calc.value) + 10).toFixed(2);
      extra.value = var_extra;
      warning.style.display = "block";
      warning.textContent = 'Essa operação tem um custo!';
      warning.textContent = 'Essa operação tem um custo! Será retirado de sua conta R$ ' + (
        parseFloat(value) + parseFloat(tax_calc.value) + parseFloat(var_extra)
      ).toFixed(2).toString();

    };

  });
});

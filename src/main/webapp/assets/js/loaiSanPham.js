const rangeInput1 = document.getElementById("customRange1");
const rangeInput2 = document.getElementById("customRange2");
const minInput = document.getElementById("typeNumber");
const maxInput = document.getElementById("typeNumber1");

rangeInput1.addEventListener("input", function() {
  minInput.value = rangeInput1.value;
});

rangeInput2.addEventListener("input", function() {
  maxInput.value = rangeInput2.value;
});

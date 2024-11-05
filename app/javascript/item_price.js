window.addEventListener('turbo:load', () => {
  console.log("OK");
});
const priceInput = document.getElementById("item-price");
priceInput.addEventListener("input", () => {
  const inputValue = priceInput.value;
  console.log(inputValue);
})
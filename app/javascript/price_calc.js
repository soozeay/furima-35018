if (document.URL.match( /items/ )) {
  window.addEventListener('load',() => {
    const priceInput = document.getElementById("item-price")
    priceInput.addEventListener('input', () =>{
      const inputValue = priceInput.value;
      const addTaxDom = document.getElementById("add-tax-price");
      const addSaleProfit = document.getElementById("profit");
      addTaxDom.innerHTML = inputValue * 0.1;
      addSaleProfit.innerHTML = inputValue - inputValue * 0.1;
    })
  });
}
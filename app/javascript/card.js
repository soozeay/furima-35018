const pay = () => {
  Payjp.setPublicKey(process.env.PAYJP_PUBLIC_KEY);
  const form = document.getElementById("charge-form");
  form.addEventListener("submit", (e) => {
    e.preventDefault();

  const card = {
    number: formData.get("order[card-number]"),
    cvc: formData.get("order[card-cvc]"),
    exp_month: formData.get("order[card-exp-month]"),
    exp_year: `20${formData.get("order[card-exp-year]")}`,
  };

  Payjp.createToken(card, (status, response) => {
    if (status == 200){
      const token = response.id;
      const renderDom = document.getElementById("charge-form");
      const tokenObj = `<input value=${token} name='token' type="hidden">`;
      renderDom.insertAdjacentHTML("beforeend", tokenObj);
    }
      document.getElementById("order_number").removeAttribute("name");
      document.getElementById("order_cvc").removeAttribute("name");
      document.getElementById("order_exp_month").removeAttribute("name");
      document.getElementById("order_exp_year").removeAttribute("name");

      document.getElementById("charge-form").submit()
    });
  });
};
window.addEventListener("load", pay);
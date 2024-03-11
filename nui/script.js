$(document).ready(function () {
  $(".container").hide();

  window.addEventListener("message", (event) => {
    switch (event.data.action) {
      case "show":
        $(".container").fadeIn(300);
        break;
      case "hide":
        $(".container").fadeOut(3);
        break;
      default:
        console.log("Keinen Fall für action gefunden.");
        break;
    }
  });

  window.addEventListener(
    "keydown",
    (event) => {
      /* console.log("Key is " + event.key); */
      if (event.key === "Escape") {
        axios.post(`https://${GetParentResourceName()}/hideMoneywashUI`), {};
        return;
      }
    },
    false
  );
});

document.addEventListener(
  "DOMContentLoaded",
  () => {
    // Funktion für den Button
    document.getElementById("btn-moneywash").addEventListener("click", () => {
      /* let dirtyMoney = $("#inpt-blackmoney").val();
    console.log(dirdirtyMoney); */
      axios.post(`https://${GetParentResourceName()}/washMoney`, {
        dirtymoney: document.getElementById("inpt-blackmoney").value,
      });

      document.getElementById("inpt-blackmoney").value = "";
    });
  },
  false
);

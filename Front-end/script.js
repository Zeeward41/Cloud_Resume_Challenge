"use strict";

//"
const site_url = "https://zeeward41.com";
const api_url = "https://yyubti05ob.execute-api.eu-west-3.amazonaws.com/dev/lambda-to-dynamo-zeeward41";

function get_visiteurs(api_url, site_url) {
  fetch(api_url, {
    method: "GET" // ou la méthode appropriée
    // // Autres options de requête si nécessaires
  })
    .then((response) => {
      // Log de la réponse HTTP complète
      //console.log("Réponse HTTP complète :", response);
      return response.json();
    })
    .then((data) => {
      // Log du contenu JSON de la réponse
     // console.log("Contenu JSON de la réponse :", data);

      document.querySelector(".n_visitors").textContent = data["n_visiteurs"];
    })
    .catch((error) => {
      // Log des erreurs s'il y en a
      console.error("Erreur lors de la requête fetch :", error);
    });
}

function update_visiteurs(api_url, site_url) {
  // Vérifier l'état de la session ou du cookie
  if (!sessionStorage.getItem("apiActivated")) {
    // Activer l'API via une requête  Fetch
    fetch(api_url, {
      method: "POST"
    })
      .then((response) => response.json())
      .then((data) => {
        //console.log("API activée avec succès", data);

        document.querySelector(".n_visitors").textContent = data["n_visiteurs"] + " visiteurs";

        // Mettre à jour la session ou le cookie pour indiquer l'activation
        sessionStorage.setItem("apiActivated", "true");
      })
      .catch((error) => {
        console.error("Erreur lors de l'activation de l'API", error);
      });
  } else {
    console.log("L'API est déjà activée pour ce visiteur");
  }
}

function toggleMenu() {
  const menu = document.querySelector(".menu-links");
  const icon = document.querySelector(".hamburger-icon");
  menu.classList.toggle("open");
  icon.classList.toggle("open");
}


get_visiteurs(api_url, site_url);
update_visiteurs(api_url, site_url);

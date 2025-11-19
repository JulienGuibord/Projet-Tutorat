document.addEventListener("DOMContentLoaded", () => {
  const tutorSelect = document.getElementById("tutor");

  fetch("get_tuteur.php")
    .then((response) => response.json())
    .then((tuteurs) => {
      tuteurs.forEach((t) => {
        const option = document.createElement("option");
        option.value = t.id_tuteur;
        option.textContent = `${t.prenom} ${t.nom}`;
        tutorSelect.appendChild(option);
      });
    });
});

<form action="ajouter_disponibilite.php" 
method="POST" 
style="max-width:600px; margin:auto; padding:20px; border:1px solid #ccc; border-radius:10px;">

    <h2>Créer une disponibilité</h2>

    <label for="id_tuteur">Tuteur :</label>
    <select name="id_tuteur" id="id_tuteur" required>
        <option value="">-- Sélectionner un tuteur --</option>
        <?php
        try {
            $conn = new PDO("mysql:host=localhost;dbname=tutorat_db;charset=utf8mb4", "root", "");
            $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
            $tuteurs = $conn->query("SELECT id_tuteur, nom, prenom FROM tuteurs ORDER BY nom");

            while ($t = $tuteurs->fetch()) {
                echo "<option value='{$t['id_tuteur']}'>{$t['nom']} {$t['prenom']}</option>";
            }
        } catch (PDOException $e) {
            echo "<option disabled>Erreur de chargement</option>";
        }
        ?>
    </select>
    <br><br>

    <label for="id_cours">Cours :</label>
    <select name="id_cours" id="id_cours" required>
        <option value="">-- Sélectionner un cours --</option>
        <?php
        try {
            $cours = $conn->query("SELECT id_cours, code_cours, nom_cours FROM cours ORDER BY code_cours");

            while ($c = $cours->fetch()) {
                echo "<option value='{$c['id_cours']}'>{$c['code_cours']} - {$c['nom_cours']}</option>";
            }
        } catch (PDOException $e) {
            echo "<option disabled>Erreur de chargement</option>";
        }
        ?>
    </select>
    <br><br>

    <label for="date_dispo">Date :</label>
    <input type="date" name="date_dispo" id="date_dispo" required>
    <br><br>

    <label for="heure_debut">Heure de début :</label>
    <input type="time" name="heure_debut" id="heure_debut" required>
    <br><br>

    <label for="heure_fin">Heure de fin :</label>
    <input type="time" name="heure_fin" id="heure_fin" required>
    <br><br>

    

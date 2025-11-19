<?php
$pdo = new PDO("mysql:host=localhost;dbname=tutorat_db;charset=utf8mb4", "root", "");

$stmt = $pdo->query("SELECT id_tuteur, nom, prenom FROM tuteurs");

$tuteurs = $stmt->fetchAll(PDO::FETCH_ASSOC);
echo json_encode($tuteurs);
?>

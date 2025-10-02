<?php
echo "<h1>Bienvenue les men in black</h1>";

// Connexion à la DB (test)
try {
    $pdo = new PDO('mysql:host=db;dbname=webapp', 'user', 'password');
    echo "<p>Connexion DB réussie !</p>";
} catch (PDOException $e) {
    echo "<p>Erreur DB : " . $e->getMessage() . "</p>";
}
?>

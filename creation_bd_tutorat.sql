-- Création de la base de données
-- ====================================================================
CREATE DATABASE IF NOT EXISTS tutorat_db CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;

-- Sélectionner la base de données pour créer les tables
USE tutorat_db;

-- Création de la table TUTEURS
-- ====================================================================
-- Table contenant les informations sur les enseignants qui offrent du tutorat

CREATE TABLE tuteurs (
    id_tuteur INT PRIMARY KEY AUTO_INCREMENT,
    nom VARCHAR(100) NOT NULL,
    prenom VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    specialite VARCHAR(200),
    telephone VARCHAR(20),
    date_inscription TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Étape 3 : Création de la table ETUDIANTS
-- ====================================================================
-- Table contenant les informations des étudiants

CREATE TABLE etudiants (
    id_etudiant INT PRIMARY KEY AUTO_INCREMENT,
    nom VARCHAR(100) NOT NULL,
    prenom VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    programme VARCHAR(100),
    numero_etudiant VARCHAR(20) UNIQUE,
    date_inscription TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Création de la table COURS
-- ====================================================================
-- Cette table répertorie tous les cours disponibles pour le tutorat

CREATE TABLE cours (
    id_cours INT PRIMARY KEY AUTO_INCREMENT,
    code_cours VARCHAR(20) UNIQUE NOT NULL,
    nom_cours VARCHAR(200) NOT NULL,
    description TEXT,
    niveau VARCHAR(50),
    credits INT DEFAULT 3
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ====================================================================
-- Étape 5 : Création de la table RENDEZ_VOUS
-- ====================================================================
-- Table centrale qui enregistre tous les rendez-vous de tutorat

CREATE TABLE rendez_vous (
    id_rdv INT PRIMARY KEY AUTO_INCREMENT,
    id_etudiant INT NOT NULL,
    id_tuteur INT NOT NULL,
    id_cours INT NOT NULL,
    date_rdv DATE NOT NULL,
    heure_debut TIME NOT NULL,
    heure_fin TIME NOT NULL,
    statut ENUM('reserve', 'annule', 'termine') DEFAULT 'reserve',
    commentaire TEXT,
    date_creation TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    date_modification TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    -- Définition des clés étrangères pour maintenir l'intégrité référentielle
    FOREIGN KEY (id_etudiant) REFERENCES etudiants(id_etudiant) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_tuteur) REFERENCES tuteurs(id_tuteur) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_cours) REFERENCES cours(id_cours) ON DELETE CASCADE ON UPDATE CASCADE,
    
    -- Index pour améliorer les performances des recherches
    INDEX idx_date_rdv (date_rdv),
    INDEX idx_etudiant (id_etudiant),
    INDEX idx_tuteur (id_tuteur),
    INDEX idx_cours (id_cours)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Création de la table DISPONIBILITÉS
-- ====================================================================
-- Table contenant les informations sur les disponibilités du tuteur
CREATE TABLE disponibilites (
    id_dispo INT AUTO_INCREMENT PRIMARY KEY,
    id_tuteur INT NOT NULL,
    id_cours INT NOT NULL,
    date_dispo DATE NOT NULL,
    heure_debut TIME NOT NULL,
    heure_fin TIME NOT NULL,
    date_creation TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    date_modification TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    -- Clés étrangères
    FOREIGN KEY (id_tuteur) REFERENCES tuteurs(id_tuteur) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_cours) REFERENCES cours(id_cours) ON DELETE CASCADE ON UPDATE CASCADE,

    -- Index pour améliorer les performances des recherches
    INDEX idx_tuteur (id_tuteur),
    INDEX idx_cours (id_cours),
    INDEX idx_date_dispo (date_dispo)

) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- ====================================================================
-- Étape 6 : Insertion des TUTEURS (données d'exemple)
-- ====================================================================

INSERT INTO tuteurs (nom, prenom, email, specialite, telephone) VALUES
('Tremblay', 'Marie', 'marie.tremblay@college.ca', 'Mathématiques et Statistiques', '514-555-0101'),
('Gagnon', 'Pierre', 'pierre.gagnon@college.ca', 'Français et Littérature', '514-555-0102'),
('Bouchard', 'Sophie', 'sophie.bouchard@college.ca', 'Sciences (Biologie, Chimie)', '514-555-0103'),
('Pelletier', 'Jean', 'jean.pelletier@college.ca', 'Informatique et Programmation', '514-555-0104'),
('Leblanc', 'Isabelle', 'isabelle.leblanc@college.ca', 'Histoire et Géographie', '514-555-0105'),
('Côté', 'Marc', 'marc.cote@college.ca', 'Physique et Mathématiques', '514-555-0106');

-- ====================================================================
-- Étape 7 : Insertion des ÉTUDIANTS (données d'exemple)
-- ====================================================================

INSERT INTO etudiants (nom, prenom, email, programme, numero_etudiant) VALUES
('Lavoie', 'Jean', 'jean.lavoie@etudiant.ca', 'Sciences naturelles', 'ETU2024001'),
('Roy', 'Émilie', 'emilie.roy@etudiant.ca', 'Sciences humaines', 'ETU2024002'),
('Martin', 'Alexandre', 'alex.martin@etudiant.ca', 'Informatique', 'ETU2024003'),
('Dubois', 'Camille', 'camille.dubois@etudiant.ca', 'Lettres et Arts', 'ETU2024004'),
('Fortin', 'Thomas', 'thomas.fortin@etudiant.ca', 'Sciences de la santé', 'ETU2024005');

-- ====================================================================
-- Étape 8 : Insertion des COURS (données d'exemple)
-- ====================================================================

INSERT INTO cours (code_cours, nom_cours, description, niveau, credits) VALUES
('MAT101', 'Algèbre I', 'Introduction aux concepts algébriques de base : équations, polynômes, systèmes d\'équations', 'Collégial 1', 3),
('MAT201', 'Calcul différentiel', 'Étude des limites, dérivées et applications', 'Collégial 2', 3),
('FRA202', 'Littérature québécoise', 'Étude des auteurs québécois contemporains et classiques', 'Collégial 2', 3),
('FRA101', 'Français écrit', 'Amélioration des compétences en rédaction et grammaire', 'Collégial 1', 3),
('BIO105', 'Biologie générale', 'Principes fondamentaux de la biologie : cellule, génétique, évolution', 'Collégial 1', 4),
('CHI101', 'Chimie générale', 'Introduction à la chimie : atomes, molécules, réactions chimiques', 'Collégial 1', 4),
('INF110', 'Introduction à la programmation', 'Bases de la programmation avec Python', 'Collégial 1', 3),
('INF220', 'Structures de données', 'Listes, piles, files, arbres et algorithmes', 'Collégial 2', 3),
('HIS101', 'Histoire du Québec', 'De la Nouvelle-France à nos jours', 'Collégial 1', 3),
('PHY201', 'Mécanique', 'Cinématique, dynamique et lois de Newton', 'Collégial 2', 4),
('STA105', 'Statistiques descriptives', 'Analyse de données, probabilités de base', 'Collégial 1', 3);

-- ====================================================================
-- Étape 9 : Insertion de RENDEZ-VOUS (données d'exemple)
-- ====================================================================

-- Rendez-vous pour l'étudiant Jean Lavoie (id=1)
INSERT INTO rendez_vous (id_etudiant, id_tuteur, id_cours, date_rdv, heure_debut, heure_fin, statut, commentaire) VALUES
(1, 1, 1, '2025-11-10', '09:00:00', '10:00:00', 'reserve', 'Besoin d\'aide avec les équations du second degré'),
(1, 3, 5, '2025-11-12', '14:00:00', '15:30:00', 'reserve', 'Révision pour l\'examen sur la génétique'),
(1, 6, 10, '2025-11-15', '10:30:00', '12:00:00', 'reserve', 'Exercices sur les forces et l\'énergie cinétique');

-- Rendez-vous pour l'étudiante Émilie Roy (id=2)
INSERT INTO rendez_vous (id_etudiant, id_tuteur, id_cours, date_rdv, heure_debut, heure_fin, statut, commentaire) VALUES
(2, 2, 3, '2025-11-11', '13:00:00', '14:30:00', 'reserve', 'Analyse du roman "Bonheur d\'occasion"'),
(2, 5, 9, '2025-11-13', '15:00:00', '16:00:00', 'reserve', 'Préparation pour l\'examen sur la Révolution tranquille');

-- Rendez-vous pour l'étudiant Alexandre Martin (id=3)
INSERT INTO rendez_vous (id_etudiant, id_tuteur, id_cours, date_rdv, heure_debut, heure_fin, statut, commentaire) VALUES
(3, 4, 7, '2025-11-09', '11:00:00', '12:30:00', 'termine', 'Introduction aux boucles et fonctions en Python'),
(3, 4, 8, '2025-11-14', '09:30:00', '11:00:00', 'reserve', 'Aide pour le projet sur les arbres binaires');

-- Rendez-vous pour l'étudiante Camille Dubois (id=4)
INSERT INTO rendez_vous (id_etudiant, id_tuteur, id_cours, date_rdv, heure_debut, heure_fin, statut, commentaire) VALUES
(4, 2, 4, '2025-11-10', '14:00:00', '15:00:00', 'reserve', 'Correction de dissertation argumentative'),
(4, 2, 3, '2025-11-16', '10:00:00', '11:30:00', 'reserve', 'Discussion sur les thèmes de la poésie québécoise');

-- Rendez-vous pour l'étudiant Thomas Fortin (id=5)
INSERT INTO rendez_vous (id_etudiant, id_tuteur, id_cours, date_rdv, heure_debut, heure_fin, statut, commentaire) VALUES
(5, 3, 5, '2025-11-11', '08:30:00', '10:00:00', 'reserve', 'Révision complète du chapitre sur la photosynthèse'),
(5, 3, 6, '2025-11-14', '13:00:00', '14:30:00', 'reserve', 'Préparation laboratoire sur les réactions acido-basiques'),
(5, 1, 11, '2025-11-17', '11:00:00', '12:00:00', 'reserve', 'Exercices sur les distributions de probabilité');

-- ====================================================================
-- Étape 10 : Insertion de DISPONIBILITÉS (données d'exemple)
-- ====================================================================
INSERT INTO disponibilites (id_tuteur, id_cours, date_dispo, heure_debut, heure_fin) VALUES
-- Tuteur 1 : Marie Tremblay (Mathématiques)
(1, 1, '2025-11-18', '09:00:00', '11:00:00'),
(1, 11, '2025-11-19', '13:00:00', '15:00:00'),

-- Tuteur 2 : Pierre Gagnon (Français)
(2, 4, '2025-11-18', '10:00:00', '12:00:00'),
(2, 3, '2025-11-20', '14:00:00', '16:00:00'),

-- Tuteur 3 : Sophie Bouchard (Biologie / Chimie)
(3, 5, '2025-11-21', '09:30:00', '11:00:00'),
(3, 6, '2025-11-22', '13:30:00', '15:30:00'),

-- Tuteur 4 : Jean Pelletier (Informatique)
(4, 7, '2025-11-18', '08:00:00', '10:00:00'),
(4, 8, '2025-11-23', '10:30:00', '12:30:00'),

-- Tuteur 5 : Isabelle Leblanc (Histoire)
(5, 9, '2025-11-19', '11:00:00', '13:00:00'),

-- Tuteur 6 : Marc Côté (Physique / Math)
(6, 10, '2025-11-20', '09:00:00', '11:00:00'),
(6, 1,  '2025-11-21', '14:00:00', '16:00:00');

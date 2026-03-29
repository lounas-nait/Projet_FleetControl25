
-- DATABASE : FleetControl (PostgreSQL)


-- TABLE : Categorie

CREATE TABLE Categorie (
    id_categorie SERIAL PRIMARY KEY,
    nom VARCHAR(50) NOT NULL
);


-- TABLE : Site

CREATE TABLE Site (
    id_site SERIAL PRIMARY KEY,
    nom VARCHAR(50) NOT NULL,
    adresse VARCHAR(100)
);


-- TABLE : Vehicule

CREATE TABLE Vehicule (
    id_vehicule SERIAL PRIMARY KEY,
    immatriculation VARCHAR(20) UNIQUE NOT NULL,
    date_achat DATE NOT NULL,
    kilometrage INT DEFAULT 0,
    statut VARCHAR(20) DEFAULT 'actif',
    id_categorie INT NOT NULL,
    id_site INT NOT NULL,
    FOREIGN KEY (id_categorie) REFERENCES Categorie(id_categorie)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (id_site) REFERENCES Site(id_site)
        ON UPDATE CASCADE ON DELETE RESTRICT
);


-- TABLE : Conducteur

CREATE TABLE Conducteur (
    id_conducteur SERIAL PRIMARY KEY,
    nom VARCHAR(50) NOT NULL,
    prenom VARCHAR(50) NOT NULL,
    permis VARCHAR(20)
);


-- TABLE : AffectationConducteurVehicule

CREATE TABLE AffectationConducteurVehicule (
    id_affect SERIAL PRIMARY KEY,
    date_debut DATE NOT NULL,
    date_fin DATE,
    id_vehicule INT NOT NULL,
    id_conducteur INT NOT NULL,
    FOREIGN KEY (id_vehicule) REFERENCES Vehicule(id_vehicule)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (id_conducteur) REFERENCES Conducteur(id_conducteur)
        ON UPDATE CASCADE ON DELETE CASCADE
);


-- TABLE : Mission

CREATE TABLE Mission (
    id_mission SERIAL PRIMARY KEY,
    type_mission VARCHAR(50),
    description VARCHAR(255)
);


-- TABLE : Trajet

CREATE TABLE Trajet (
    id_trajet SERIAL PRIMARY KEY,
    date_heure_depart TIMESTAMP,
    date_heure_arrivee TIMESTAMP,
    cout FLOAT DEFAULT 0,
    id_vehicule INT NOT NULL,
    id_conducteur INT NOT NULL,
    id_mission INT NOT NULL,
    FOREIGN KEY (id_vehicule) REFERENCES Vehicule(id_vehicule)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (id_conducteur) REFERENCES Conducteur(id_conducteur)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (id_mission) REFERENCES Mission(id_mission)
        ON UPDATE CASCADE ON DELETE RESTRICT
);


-- TABLE : Incident

CREATE TABLE Incident (
    id_incident SERIAL PRIMARY KEY,
    date_incident DATE NOT NULL,
    description VARCHAR(255),
    cause VARCHAR(255),
    impact_financier FLOAT,
    id_vehicule INT NOT NULL,
    cause VARCHAR(255),
    impact_financier FLOAT,
    FOREIGN KEY (id_vehicule) REFERENCES Vehicule(id_vehicule)
        ON UPDATE CASCADE ON DELETE CASCADE
);


-- TABLE : Technicien

CREATE TABLE Technicien (
    id_technicien SERIAL PRIMARY KEY,
    nom VARCHAR(50),
    interne BOOLEAN DEFAULT TRUE
);


-- TABLE : Fournisseur

CREATE TABLE Fournisseur (
    id_fournisseur SERIAL PRIMARY KEY,
    nom VARCHAR(50),
    adresse VARCHAR(100)
);


-- TABLE : Intervention

CREATE TABLE Intervention (
    id_intervention SERIAL PRIMARY KEY,
    date_intervention DATE,
    type_intervention VARCHAR(50),
    cout FLOAT DEFAULT 0,
    id_incident INT NOT NULL,
    id_vehicule INT NOT NULL,
    id_technicien INT NOT NULL,
    id_fournisseur INT,
    FOREIGN KEY (id_incident) REFERENCES Incident(id_incident)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (id_vehicule) REFERENCES Vehicule(id_vehicule)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (id_technicien) REFERENCES Technicien(id_technicien)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (id_fournisseur) REFERENCES Fournisseur(id_fournisseur)
        ON UPDATE CASCADE ON DELETE SET NULL
);


-- TABLE : Piece

CREATE TABLE Piece (
    id_piece SERIAL PRIMARY KEY,
    nom VARCHAR(50),
    quantite_stock INT DEFAULT 0
);


-- TABLE : UtilisationPiece

CREATE TABLE UtilisationPiece (
    id_utilisation SERIAL PRIMARY KEY,
    quantite INT NOT NULL CHECK (quantite > 0),
    id_intervention INT NOT NULL,
    id_piece INT NOT NULL,
    FOREIGN KEY (id_intervention) REFERENCES Intervention(id_intervention)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (id_piece) REFERENCES Piece(id_piece)
        ON UPDATE CASCADE ON DELETE RESTRICT
);


-- TABLE : Assurance

CREATE TABLE Assurance (
    id_assurance SERIAL PRIMARY KEY,
    date_debut DATE,
    date_fin DATE,
    assureur VARCHAR(50),
    id_vehicule INT NOT NULL,
    FOREIGN KEY (id_vehicule) REFERENCES Vehicule(id_vehicule)
        ON UPDATE CASCADE ON DELETE CASCADE
);


-- TABLE : ControleTechnique

CREATE TABLE ControleTechnique (
    id_ct SERIAL PRIMARY KEY,
    date_ct DATE,
    resultat VARCHAR(50),
    id_vehicule INT NOT NULL,
    FOREIGN KEY (id_vehicule) REFERENCES Vehicule(id_vehicule)
        ON UPDATE CASCADE ON DELETE CASCADE
);


-- TABLE : Contrat

CREATE TABLE Contrat (
    id_contrat SERIAL PRIMARY KEY,
    type_contrat VARCHAR(50),
    date_debut DATE,
    date_fin DATE,
    id_vehicule INT NOT NULL,
    FOREIGN KEY (id_vehicule) REFERENCES Vehicule(id_vehicule)
        ON UPDATE CASCADE ON DELETE CASCADE
);

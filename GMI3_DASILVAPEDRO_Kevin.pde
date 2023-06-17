///////////////////////////////////////////////////////
// La descente = 
// https://www.codingame.com/training/easy/the-descent
///////////////////////////////////////////////////////
// 
// DM rattrapage - La descente
// "UED 131 - Programmation impérative" 2022-2023
// NOM         : DA SILVA PEDRO
// Prénom      : Kévin
// N° étudiant : 20221810
//
///////////////////////////////////////////////////////

int[] immeubles = {3, 7, 9, 10, 2, 4, 6, 1, 8, 5};
int vitesseHorizontale = 5; // vitesse de la soucoupe
int timer = 0;      // initialisation de la variable timer
int x = -100;    // position en X de la soucoupe
int y = 170;      // position en Y de la soucoupe
int cible = -1;      // initialisation de la variable cible
boolean immeubleRestant; // initialisation d'une variable pour savoir si il reste des immeubles

//===================================================
// l'initialisation
//===================================================
void setup() {
  size(800, 700);
}

//===================================================
// la boucle de rendu
//===================================================
void draw() {        // appel de fonction
  background(50);
  dessineJeu();
  timer += 1;                    // incrémentation de la variable timer
  detruitImmeuble(immeubles);
  if (immeubleRestant==false){    // si il reste pas d'immmeuble
    construitImmeubles(immeubles);   // appel de la fonction pour construire les immeubles
  }
}

//===================================================
// le dessin de tous les éléments graphiques
//===================================================
void dessineJeu() {          // appel de fonctions
  dessineVille(immeubles);
  dessineSoucoupe(x, y);
  dessineLaser(y);
  deplaceSoucoupe(vitesseHorizontale);
}

//===================================================
// le dessin des immeubles
// buildings : le tableau des immeubles
//===================================================
void dessineVille(int[] buildings) {
  //lune
  noStroke();   // pas de contour
  fill(#FFFF00);      // couleur de la lune
  ellipse(620, 280, 220, 220);  // ellipse principale
  fill(255,255,255);       // couleur des "cratéres
  noStroke();
  ellipse(600, 230, 60, 60);    // 2eme ellipse pour les cratères 
  fill(255,255,255);
  noStroke();
  ellipse(660, 200, 40, 40);      // 3eme ellipse pour les cratères
  fill(255,255,255);
  noStroke();
  ellipse(620, 280, 30, 30);      // 4eme ellipse pour les cratères
  // dessin des immeubles
  for (int i = 0; i < buildings.length; i++) { // savoir combien d'immeuble et leur taille
    int hauteur = buildings[i] * 50; // Calcul de la hauteur en pixels
    // Calcul des coordonnées du coin supérieur gauche de l'immeuble
    int x = 325 + i * 50 - 23 ; // placement en X de tous les immeubles
    int y = height - hauteur;  // placement en Y de tous les immeubles
    // Dessin des immeubles de couleur noire
    fill(0);
    rect(x, y, 46, hauteur);
    // ajouts des fenêtres clignotantes
    for (int fenetreX = x + 10; fenetreX < x + 46 - 10; fenetreX += 20) {   // positionne les fenetres en X
      for (int fenetreY = y + 10; fenetreY < y + hauteur; fenetreY += 20) {   // positionne les fenetres en Y
        if (random(10) < 1) { // Probabilité de 1 sur 10 d'afficher la fenêtre
          fill(255, 255, 0); // Couleur de la fenêtre
          rect(fenetreX, fenetreY, 10, 10); // tailles et position des fenetres
        }
      }
    }
  }
}

//===================================================
// le dessin de la soucoupe
// x, y : l'abscisse et l'ordonnée de la soucoupe
//===================================================
void dessineSoucoupe(int x, int y) {
  PImage img = loadImage("soucoupe.png");  // importe l'image de la soucoupe
  image(img, x, y);  // pour positionner la soucoupe
}

//===================================================
// le dessin du tir
// y : l'ordonnée du milieu de l'immeuble visé
//===================================================
//===================================================
// le dessin du tir
// y : l'ordonnée du milieu de l'immeuble visé
//===================================================
void dessineLaser(int y) {
  immeubleRestant = false;
  for (int i = 0; i < immeubles.length; i++) {  // pour savoir si il reste des immeubles dans le tableau
    if (immeubles[i] > 0) {  
      immeubleRestant = true;  // on met a jour la variable
      break;  
    }
  } 
  if (x >= 10 && x <= 60) {
    for (int i = 0; i < immeubles.length; i++) {
      int hauteur = immeubles[i] * 50; // calcul de la hauteur de l'immeuble en pixels
      int immeubleX = 325 + i * 50; // coordonnée x de l'immeuble
      int immeubleY = height - hauteur; // coordonnée y du haut de l'immeuble
      if (immeubles[i] > 0) { // vérifie si l'immeuble est encore présent
        stroke(255, 0, 0); // couleur rouge
        strokeWeight(5); // épaisseur de 5 pixels
        line(x, y, immeubleX, immeubleY + hauteur/2); // laser jusqu'au milieu de l'immeuble
      }
    }
  }
}

//===================================================
// le déplacement de la soucoupe
// vit : la vitesse de déplacement
//===================================================
void deplaceSoucoupe(int vit) {
  x += vit;  // mise a jour de la position de la soucoupe
  if (x > width) {  // si on sort de la fenetre graphique en X
    x = -100;  // reaparait a en -100 en X a chaque descente
    y += 50; // descend de 50 pixels en Y
  }
  else if (x >= width/2 && y >= height - 100) {  // si la soucoupe se trouve au milieu est a moins de 100 pixels en Y
    vitesseHorizontale=0;  // vitesse mise a 0
    PFont fonte = createFont("joystix.ttf", 20); // importation de la police
    textFont(fonte);  // police du texte
    fill(255);  // couleur du texte
    textAlign(CENTER, CENTER);  // alignement du texte
    text("Hello World!", width / 2, height - 100);  // position du texte
  }
}
//===================================================
// la destruction d'un immeuble
// buildings : le tableau des immeubles
//===================================================
//void construitImmeubles(int[] buildings) {
//}

//===================================================
// la destruction d'un immeuble
// buildings : le tableau des immeubles
//===================================================
void detruitImmeuble(int[] buildings) {
  if (vitesseHorizontale == 0) {  // si la vitesse horizontale est égale à zéro
    return;  // quitte la fonction 
  }
  if (x >= 60 && cible == -1 && timer % 10 == 0) { // si la soucoupe est a 60pixels, cible est de -1, timer est un multiple de 10 
    cible = plusGrandImmeuble(buildings); // sélectionne l'indice de l'immeuble le plus haut comme cible
  }

  if (cible != -1 && timer % 10 == 0) {  // si la valeur de la cible est differente de -1 et que timer est un multiple de 10
    buildings[cible]--; // décrémente la hauteur de l'immeuble ciblé
    if (buildings[cible] <= 0) {
      cible = -1; // abandonne la cible en la repassant à -1
    }
  }
}


//===================================================
// renvoie l'indice du plus grand immeuble
// buildings : le tableau des immeubles
//===================================================
int plusGrandImmeuble(int[] buildings) {
  int indiceMax = 0;   // on initialise a 0
  int hauteurMax = buildings[0];  // si la hauteur la plus grande est egal au 1er elt du tableau
  for (int i = 1; i < buildings.length; i++) {  // parcours le tableau
    if (buildings[i] > hauteurMax) { // si l'elt du tableau est plus grande que la hauteur la plus grande
      hauteurMax = buildings[i];  // met a jour la valeur de la variable hauteurMax
      indiceMax = i;  // met a jour la valeur de la variable indiceMax
    }
  }
  return indiceMax; // retourne l'indice max
}

//===================================================
// réinitialise le tableau des hauteurs à 0
// buildings : le tableau des immeubles
//===================================================
void initHauteurs(int[] buildings) {
  for (int i = 0; i < buildings.length; i++) {   // parcours le tableau
    buildings[i] = 0;  // on l'initialise a 0
  }
}

//===================================================
// Trouve l'indice d'un immeuble de hauteur 0
// buildings : le tableau des immeubles
//===================================================
int emplacementLibre(int[] buildings) {
  int emplacement = (int) random(buildings.length); // tire aléatoirement un indice dans le tableau
  while (buildings[emplacement] != 0) { // tant que la valeur à l'emplacement n'est pas nulle
    emplacement = (emplacement + 1) % buildings.length; // passe à l'indice suivant 
  }
  return emplacement; // renvoie l'indice pour lequel la valeur est nulle
}

//===================================================
// Réinitialise aléatoirement les hauteurs des immeubles
// buildings : le tableau des immeubles
//===================================================
void construitImmeubles(int[] buildings) {
  initHauteurs(buildings); // réinitialise les hauteurs des immeubles à 0
  for (int i = 0; i < buildings.length; i++) {
    int hauteurMax = i + 1; // la taille de l'immeuble correspond à sa position dans la boucle
    int emplacement = emplacementLibre(buildings); // cherche un emplacement libre
    buildings[emplacement] = hauteurMax; // affecte la hauteur à l'emplacement trouvé
  }
}

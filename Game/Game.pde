boolean gameStarted = false;
Car car1, car2;
Ball ball;
int score1, score2; 
PImage background;
PFont font;

void setup() {
  size(1600, 1000);
  font = createFont("Arial Bold", 24);
  background = loadImage("background.jpg");
  car1 = new Car(color(0, 0, 255), width/4, 10, 1); // player 1
  car2 = new Car(color(255, 140, 0), width* 3/4, 10, 2); // player 2
  ball = new Ball(width/2, 10);
}

void draw() {
  if (!gameStarted) {
    image(background, 0, 0, width, height); 
    displayOpeningScreen();
  }
  else {
    background(255);
    //createField();
    //update();
  }
}

void mousePressed() {
  if (!gameStarted && mouseX > width/2 - 300 && mouseX < width/2 + 300 && mouseY > height/2 - 150 && mouseY < height/2 + 150) { // check if start button has been pressed 
    startGame();
  }
}

void displayOpeningScreen() {
  textFont(font);
  textAlign(CENTER, CENTER + 100);
  textSize(70);
  fill(0); // black
  text("ON THE KEYS", width/2, height/4 + 50);
  
  // create button
  fill(173, 216, 130);
  rectMode(CENTER);
  rect(width/2, height/2, 300, 150, 10);
  
  fill(0);
  textSize(80);
  text("PLAY!", width/2, height/2 + 20);
}

void startGame() {
  gameStarted = true;
  // more to add i thinl
}

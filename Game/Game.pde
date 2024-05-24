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
    drawField();
    //update();
  }
}

void mousePressed() {
  // checks if play button is pressed
  if (mouseX > width/2 - 200 && mouseX < width/2 + 200 && mouseY > height/2 - 100 && mouseY < height/2 - 50) { 
      startGame();
    }
    // checks if credits is pressed
    else if (mouseX > width/2 - 200 && mouseX < width/2 + 200 && mouseY > height/2 - 25 && mouseY < height/2 + 25) { 
      // credits();
    }
    // check if settings is pressed
    else if (mouseX > width/2 - 200 && mouseX < width/2 + 200 && mouseY > height/2 + 50 && mouseY < height/2 + 100) { 
      // settings();
    }
    // check if exit is pressded
    else if (mouseX > width/2 - 200 && mouseX < width/2 + 200 && mouseY > height/2 + 125 && mouseY < height/2 + 175) { 
      exit(); // quit
    }
}

void displayOpeningScreen() {
  textFont(font);
  textAlign(CENTER, CENTER + 100);
  textSize(70);
  fill(0); // black
  text("ON THE KEYS", width/2, height/4 + 50);
  
  // play button
  fill(150); // Gray color
  rectMode(CENTER);
  rect(width/2, height/2 - 75, 400, 60, 10);
  fill(255);
  textSize(40);
  text("PLAY", width/2, height/2 - 70);
  
  // credits button
  fill(150); // Gray color
  rectMode(CENTER);
  rect(width/2, height/2, 400, 60, 10);
  fill(255);
  textSize(40);
  text("CREDITS", width/2, height/2 + 5);
  
  // settings button
  fill(150); // Gray color
  rectMode(CENTER);
  rect(width/2, height/2 + 75, 400, 60, 10);
  fill(255);
  textSize(40);
  text("SETTINGS", width/2, height/2 + 80);
  
  // exit button
  fill(150); // Gray color
  rectMode(CENTER);
  rect(width/2, height/2 + 150, 400, 60, 10);
  fill(255);
  textSize(40);
  text("EXIT", width/2, height/2 + 155);
}

void drawField() {
}

void startGame() {
  gameStarted = true;
}

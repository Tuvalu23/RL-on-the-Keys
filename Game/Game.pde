boolean gameStarted = false;
boolean credits = false;
Car car1, car2;
Ball ball;
int score1, score2; 
PImage background, car1Image, car2Image, gameField;
PFont font;
PVector gravity;
boolean[] keys = new boolean[256];

void setup() {
  size(1600, 900, P3D); // made it 3d for now maybe we could do this
  font = createFont("Arial Bold", 24);
  background = loadImage("background.jpg");
  car1Image = loadImage("orangecar.png"); 
  car2Image = loadImage("bluecar.png"); 
  gameField = loadImage("rlfield.jpg");
  car1 = new Car(car1Image, width/4, height - 20, 1); // player 1
  car2 = new Car(car2Image, width* 3/4, height - 20, 2); // player 2
  ball = new Ball(width/2, height - 200);
  
  gravity = new PVector(0, 5); //gravity. we should prob do it here bc both ball + car experience gravity
}

void draw() {
  if (!gameStarted && !credits) {
    image(background, 0, 0, width, height); 
    displayOpeningScreen();
  }
  else if (credits){
    credits();
  }
  else {
    background(255);
    drawField();
    update();
  }
}

void mousePressed() {
  // checks if play button is pressed
  if (mouseX > width/2 - 200 && mouseX < width/2 + 200 && mouseY > height/2 - 100 && mouseY < height/2 - 50) { 
      startGame();
    }
    // checks if credits is pressed
    else if (mouseX > width/2 - 200 && mouseX < width/2 + 200 && mouseY > height/2 - 25 && mouseY < height/2 + 25) { 
      credits();
    }
    // check if settings is pressed
    else if (mouseX > width/2 - 200 && mouseX < width/2 + 200 && mouseY > height/2 + 50 && mouseY < height/2 + 100) { 
      // settings();
    }
    // check if exit is pressded
    else if (mouseX > width/2 - 200 && mouseX < width/2 + 200 && mouseY > height/2 + 125 && mouseY < height/2 + 175) { 
      exit(); // quit
    }
    else if (credits && mouseX > width/2 - 150 && mouseX < width/2 + 150 && mouseY > height/2 - 100 && mouseY < height/2 - 100) {
      credits = false;
      //need to fix this method because coordinates do not work for button
    }
}

void keyPressed() {
  if (keyCode < keys.length) {
    keys[keyCode] = true;
  }
}

void keyReleased() {
  if (keyCode < keys.length) {
    keys[keyCode] = false;
  }
}

void credits(){
  credits = true;
  background(0);
  textFont(font);
  textAlign(CENTER, CENTER);
  fill(255);
  textSize(50);
  text("CREDITS", width/2, height/4);
  textSize(30);
  text("Ben Rudinkski", width/2, height/2 - 40);
  text("Vedant Kothari", width/2, height/2);
  text("Endrit Idrizi", width/2, height/2 + 40);
  //back button
  fill(150);
  rectMode(CENTER);
  rect(width/2, height - 100, 200, 60, 10);
  fill(255);
  textSize(30);
  text("BACK", width/2, height - 100);
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
  camera(width/2, height/2, 800, width/2, height/2, 0, 0, 1, 0);
  image(gameField, width/2, height/2, width, height);
  
  // Display cars and ball
  car1.display();
  car2.display();
  ball.display();
}

void startGame() {
  gameStarted = true;
}

void update() {
  car1.applyForce(gravity);
  car2.applyForce(gravity);
  ball.applyForce(gravity);
  ball.airResistance();

  car1.update();
  car2.update();
  ball.update();
  
  ball.checkCollision(car1);
  ball.checkCollision(car2);

  car1.display();
  car2.display();
  ball.display();
}

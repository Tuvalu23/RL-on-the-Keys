boolean gameStarted = false;
boolean credits = false;
boolean settings = false;
boolean isBall3D = true; 
Car car1, car2;
Ball ball;
int score1, score2; 
PImage background, car1Image, car2Image, gameField;
PFont font;
PFont font2;
PVector gravity;
boolean[] keys = new boolean[256];

// countdoewn stuff
boolean countdownActive = true;
int countdownVal = 3;
int countdownTimer;

//goal stuff
boolean goalScored = false;
String goalMessage = "";
int goalMessageX;
int goalMessageColor;
boolean alternateShade = false; // switching shade for goal msg

void setup() {
  size(1600, 900, P3D); // made it 3d for now maybe we could do this
  font = createFont("Bauhaus 93", 24);
  font2 = createFont("Arial Bold", 24);
  background = loadImage("background.jpg");
  car1Image = loadImage("bluecar.png"); 
  car2Image = loadImage("orangecar.png"); 
  gameField = loadImage("rlfield.jpg");
  car1 = new Car(car1Image, width/4, height - 100, 1); // player 1
  car2 = new Car(car2Image, width* 3/4, height - 100, 2); // player 2
  ball = new Ball(width / 2, height - 300);
  
  gravity = new PVector(0, 4); //gravity. we should prob do it here bc both ball + car experience gravity
  countdownTimer = millis();
}

void draw() {
  if (!gameStarted && !credits && !settings) {
    image(background, 0, 0, width, height); 
    displayOpeningScreen();
  }
  else if (credits){
    credits();
  }
  else if (settings) {
    displaySettingsScreen();
  }
  else {
    background(255);
    drawField();
    if (countdownActive) {
      ball.velocity.set(0, 0);
      car1.velocity.set(0, 0);
      car2.velocity.set(0, 0);
      car1.facingOtherSide = true;
      car1.angle = 0;
      car2.angle = 0;
      car1.fuel = 75;
      car2.fuel = 75;
      car1.position.set(width/4, height - 100);
      car2.position.set(width * 3/4, height - 100);
      displayCountdown(); // start game countdown
      if (millis() - countdownTimer > 1000) {
        countdownVal--;
        countdownTimer = millis();
        if (countdownVal == 0) {
          countdownActive = false;
          countdownVal = 3; // Reset the countdown value for the next goal
        }
      }
    } else {
      update();
    }
    
    if (goalScored) {
      displayGoalMessage();
      goalMessageX += 5;
      if (goalMessageX > width) {
        goalScored = false;
      }
    }
  }
}

void mousePressed() {
  if (!gameStarted && !credits && !settings) {
    // checks if play button is pressed
    if (mouseX > width/2 - 200 && mouseX < width/2 + 200 && mouseY > height/2 - 100 && mouseY < height/2 - 50) { 
      startGame();
    }
    // checks if credits is pressed
    else if (mouseX > width/2 - 200 && mouseX < width/2 + 200 && mouseY > height/2 - 25 && mouseY < height/2 + 25) { 
      credits = true;
    }
    // check if settings is pressed
    else if (mouseX > width/2 - 200 && mouseX < width/2 + 200 && mouseY > height/2 + 50 && mouseY < height/2 + 100) { 
      settings = true;
    }
    // check if exit is pressed
    else if (mouseX > width/2 - 200 && mouseX < width/2 + 200 && mouseY > height/2 + 125 && mouseY < height/2 + 175) { 
      exit(); // quit
    }
  } else if (credits) {
    // checks if back button in credits is pressed
    if (mouseX > width/2 - 100 && mouseX < width/2 + 100 && mouseY > height - 130 && mouseY < height - 70) {
      credits = false;
    }
  } else if (settings) {
    // Toggle Ball 3D/2D button
    if (mouseX > width/2 - 200 && mouseX < width/2 + 200 && mouseY > height/2 - 80 && mouseY < height/2 - 20) {
      isBall3D = !isBall3D; // Toggle the ball mode
    }
    // Back button
    else if (mouseX > width/2 - 100 && mouseX < width/2 + 100 && mouseY > height/2 + 20 && mouseY < height/2 + 80) {
      settings = false;
    }
  }
}

void keyPressed() {
  if (keyCode < keys.length) {
    keys[keyCode] = true;
    if (gameStarted && !countdownActive) {
      car1.keyPressed();
      car2.keyPressed();
    }
  }
}

void keyReleased() {
  if (keyCode < keys.length) {
    keys[keyCode] = false;
  }
}

void credits() {
  credits = true;
  background(0);
  textFont(font);
  textAlign(CENTER, CENTER);
  fill(255);
  textSize(50);
  text("CREDITS", width/2, height/4);
  textSize(30);
  text("Ben Rudinski", width/2, height/2 - 40);
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

void displaySettingsScreen() {
  background(0);
  textFont(font);
  textAlign(CENTER, CENTER);
  fill(255);
  textSize(50);
  text("SETTINGS", width/2, height/4);
  
  // Toggle Ball 3D/2D button
  fill(150);
  rectMode(CENTER);
  rect(width/2, height/2 - 50, 400, 60, 10);
  fill(255);
  textSize(30);
  text(isBall3D ? "Ball Mode: 3D" : "Ball Mode: 2D", width/2, height/2 - 50);
  
  // Back button
  fill(150);
  rectMode(CENTER);
  rect(width/2, height/2 + 50, 200, 60, 10);
  fill(255);
  textSize(30);
  text("BACK", width/2, height/2 + 50);
}

void drawField() {
  camera(width/2, height/2, 800, width/2, height/2, 0, 0, 1, 0);
  image(gameField, width/2, height/2, width, height);
  
  // Display cars and ball
  car1.display();
  car2.display();
  ball.display();
  displayScoreboard();
}

void displayScoreboard() {
  textFont(font);
  textAlign(CENTER, CENTER);
  textSize(50);
  
  fill(0, 0, 255);
  rectMode(CENTER);
  rect(width/4, 50, 100, 60);
  
  fill(255, 140, 0);
  rect(width*3/4, 50, 100, 60);
  
  fill(255);
  text(score1, width/4, 50);
  
  fill(255);
  text(score2, width*3/4, 50);
}

void startGame() {
  gameStarted = true;
  countdownActive = true;
  countdownVal = 3;
  countdownTimer = millis();
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
  
  checkGoal(); // has there been a goal
}

void checkGoal() {
  // Check if the ball has hit the left goal area
  if (ball.location.x - ball.size / 2 <= width/12.5 && 
      ball.location.y >= height * 0.375 - 40 && 
      ball.location.y <= height * 2/3 + 40) {
    score2++;
    resetBall();
    goalScored("Team 2");
  }
  // Check if the ball has hit the right goal area
  else if (ball.location.x + ball.size / 2 >= width * 0.925 && 
           ball.location.y >= height * 0.375 - 40 && 
           ball.location.y <= height * 2/3 + 40) {
    score1++;
    resetBall();
    goalScored("Team 1");
  }
}

void goalScored(String team) {
  goalScored = true;
  goalMessage = "GOAL! " + team;
  goalMessageX = 0; // Start the message from the left of the screen
  goalMessageColor = team.equals("Team 2") ? color(255, 140, 0) : color(30, 144, 255); // colors for each team
}

void displayGoalMessage() {
  textFont(font);
  textAlign(CENTER, CENTER);
  textSize(100);
  fill(goalMessageColor);
  text(goalMessage, goalMessageX, height / 2);
}

void resetBall() {
  ball.location.set(width / 2, height - 300);
  ball.velocity.set(0, 0);
  countdownActive = true;
  countdownVal = 3;
  countdownTimer = millis();
}

void displayCountdown() {
  textFont(font);
  textAlign(CENTER, CENTER);
  textSize(100);
  float colorInterpolation = map(countdownVal, 3, 1, 0, 1);
  fill(lerpColor(color(255, 0, 0), color(0, 255, 0), colorInterpolation)); // Interpolate from red to green
  text(countdownVal, width / 2, height / 2);
}
//testing branch work (delete later)

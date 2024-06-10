public class Car {
  PVector position;
  PVector velocity;
  PVector acceleration;
  PImage carImage;
  float angle; // heading essentially
  boolean facingOtherSide;
  boolean onGround;
  boolean onRoof;
  boolean onLeftWall;
  boolean onRightWall;
  boolean turning;
  int jumpCount;
  int fuel;
  String[] arr = {" "};
  int mode; // left or right keys
  int fuelRefillCooldown; // to make refill boost a little slower
  
  //flip vars
  int degreesLeft = 0; 
  
  Car(PImage carImage, float x, float y, int mode) {
    this.carImage = carImage;
    position = new PVector(x, y);
    velocity = new PVector(0, 0);
    acceleration = new PVector(0,0);
    angle = 0;
    this.mode = mode;
    this.facingOtherSide = (mode == 1);
    onGround = true;
    onRoof = false;
    onLeftWall = false;
    onRightWall = true;
    turning = false;
    jumpCount = 2;
    fuel = 100;
    fuelRefillCooldown = 0;
  }
  
  //have to continue working with angles
  void angleUp(){
      degreesLeft = 15;
  }
  void angleDown(){
    if (!onGround && !onRoof && !onLeftWall && !onRightWall) {
    degreesLeft = -15;
    }
  }
  
  void angleGravity() { // confusing but gravity is important especially for aggles
    if (!onLeftWall && !onRightWall && angle < PI / 2 && angle > 0) {
      angle += radians(4);
    }
    if (!onLeftWall && !onRightWall && angle < 3 * PI / 2 && angle > PI) {
      angle -= radians(4);
    }
    
  }
  
  void applyForce(PVector force) {
    PVector f = PVector.div(force, 20); // Assuming mass = 20 for simplicity
    acceleration.add(f);
  }
  
  void keyPressed(){
    if (mode == 1){
      if (keyPressed){
        if (keys[32]){
          jump();
        }
      }
    }
    else{
      if (keyPressed){
        if (keys[ENTER]){
          jump();
        }
      }
    }
  }
  
  void update() {
    angleGravity();
    refuel();
    if (mode == 1) { // left screen
      if (keyPressed) {
        if (keys['A']) {
        acceleration.x = -0.5;
      }
      if (keys['D']) {
        acceleration.x = 0.5;
      }
      if (keys['W']) {
        angleUp();
      }
      if (keys['S']) {
        angleDown();
      }
      //if (keys[32]) {
      //  jump();
      //}
      if (keys[SHIFT]){
        useBoost();
      }
      }
    } else { // right screen
      if (keyPressed) {
        if (keys[LEFT]) {
        acceleration.x = -0.5;
      }
      if (keys[RIGHT]) {
        acceleration.x = 0.5;
      }
      if (keys[UP]) {
        angleUp();
      }
      if (keys[DOWN]) {
        angleDown();
      }
      //if (keys[ENTER]) {
      //  jump();
      //}
      if (keys[BACKSPACE]){
        useBoost();
      }
      }
    }
    
    if (degreesLeft > 0) { //handle flips and rotations in animation
      turning = true;
      angle -= radians(5);
      degreesLeft -= 5;
    }
    else if (degreesLeft < 0) {
      turning = true;
      angle += radians(5);
      degreesLeft += 5;
    }
    else {
      turning = false;
    }
      
    velocity.add(acceleration);
    position.add(velocity);
    acceleration.mult(0);
    velocity.limit(15);
    velocity.mult(0.99); // friction
    
    
    //HAVE TO FIX THIS SO THAT BOOST CAN WORK
    //
    if (velocity.x < 0) {
      facingOtherSide = false;
    }
    else if (velocity.x > 0) {
      facingOtherSide = true;
    }
   
    
    position.x = constrain(position.x, carImage.width * 0.3 / 2 + 94, width - carImage.width * 0.3 / 2 - 88); // constrain x pos
    position.y = constrain(position.y, carImage.height * 0.3 / 2 + 95, height - carImage.height * 0.3 / 2 - 100); // constrain y pos
    
    if (position.y >= height - carImage.height * 0.3 / 2 - 100) {
      onGround = true;
      onRoof = false;
      onLeftWall = false;
      onRightWall = false;
      angle = 0; // Set angle to 0 degrees when on the ground
      jumpCount = 2; // Reset jump count when on the ground
    } else if (position.y <= carImage.height * 0.3 / 2 + 95) {
      onGround = false;
      onRoof = true;
      onLeftWall = false;
      onRightWall = false;
      angle = PI; // Set angle to 180 degrees when on the ceiling
      if (facingOtherSide) { // swap sides on ceiling
        facingOtherSide = false;
      }
      else {
        facingOtherSide = true;
      }
      jumpCount = 2; // Reset jump count when on the ceiling
    } else if (position.x <= carImage.width * 0.3 / 2 + 94) {
      onGround = false;
      onRoof = false;
      onLeftWall = true;
      onRightWall = false;
      angle = -PI / 2; // Set angle to 90 degrees when on the left wall
      jumpCount = 2; // Reset jump count when on the left wall
    } else if (position.x >= width - carImage.width * 0.3 / 2 - 108) {
      onGround = false;
      onRoof = false;
      onLeftWall = false;
      onRightWall = true;
      angle = -PI / 2; // Set angle to 270 degrees when on the right wall
      jumpCount = 2; // Reset jump count when on the right wall
    } else {
      onGround = false;
      onRoof = false;
      onLeftWall = false;
      onRightWall = false;
    }
  }
  
  void jump() {
    if (jumpCount == 2 || onGround || ((jumpCount == 1) && (!onGround) && (abs(velocity.x) < 5))) {
      velocity.y = - 5;
      jumpCount--;
    }
    else if ((jumpCount == 1) && !onGround && (abs(velocity.x) > 5)) {
      velocity.y = -10;
      degreesLeft = 360;
      jumpCount--;
    }
  
  }
  
  void useBoost(){
   if (fuel > 0 && !turning) {
    float boostAngle = angle;
    if ((facingOtherSide && angle == PI) || (!facingOtherSide && angle == 0)) {
      boostAngle -= PI;
    }
    if (!facingOtherSide && position.y < height - carImage.height * 0.3 / 2 - 100) {
      boostAngle -= PI; // Adjust the angle by 180 degrees if the car is facing the other side
      boostAngle *= -1;
    }
    PVector boost = PVector.fromAngle(boostAngle).mult(1.5); // Adjust the multiplier for desired boost strength
    acceleration.add(boost);
    fuel -= 1;
  }
  }
  
  void refuel(){
    if (onGround || onRightWall || onLeftWall || onRoof) {
      fuelRefillCooldown++;
      if (fuelRefillCooldown >= 3) { // Adjust the number for slower refuel rate (higher is slower btw)
        if (fuel < 75) {
          fuel += 1;
        }
        if (fuel > 75) {
          fuel = 75;
        }
        fuelRefillCooldown = 0;
      }
    }
  }
  
  void display() {
    pushMatrix();
    translate(position.x, position.y);
    if (!facingOtherSide) {
      scale(-1, 1); // flip horizontally
    }
    rotate(angle);
    imageMode(CENTER);
    image(carImage, 0, 0, carImage.width * 0.3, carImage.height * 0.3);
    popMatrix();
    displayFuelBar();
  }
  
  void displayFuelBar() {
  if (fuel < 75) {
    float barWidth = 80;
    float barHeight = 10;
    float x = position.x - barWidth / 2; // Adjust x to be the left edge of the bar
    float y = position.y - carImage.height * 0.3 / 2 - 45;
    float fuelRatio = fuel / 75.0;
    int red = (int) map(fuelRatio, 0, 1, 255, 0);
    int green = (int) map(fuelRatio, 0, 1, 0, 255);
    noStroke();
    fill(255, 0, 0); // Background color (red)
    rect(x, y, barWidth, barHeight);
    fill(red, green, 0); // Foreground color (gradient from red to green)
    rect(x, y, barWidth * fuelRatio, barHeight);
  }
}
  
   boolean intersects(Ball ball) {
    float distance = dist(position.x, position.y, ball.location.x, ball.location.y);
    //return distance < 0.2; 
    return distance < (carImage.width * 0.3 / 2 + ball.size / 2) - 29 || distance < (carImage.height * 0.3 / 2 + ball.size / 2) - 59;
  }
  
}

public class Car {
  PVector position;
  PVector velocity;
  PVector acceleration;
  PImage carImage;
  float angle; // heading essentially
  int mode; // left or right keys
  boolean facingOtherSide;
  
  Car(PImage carImage, float x, float y, int mode) {
    this.carImage = carImage;
    position = new PVector(x, y);
    velocity = new PVector(0, 0);
    acceleration = new PVector(0,0);
    angle = 0;
    this.mode = mode;
    this.facingOtherSide = (mode == 1);
  }
  
  //have to continue working with angles
  void angleUp(){
    if (angle > 3*PI/2){
      rotate(-radians(1));
    }
    else{
      //car.rotate(radians(1));
    }
  }
  
  void applyForce(PVector force) {
    PVector f = PVector.div(force, 20); // Assuming mass = 20 for simplicity
    acceleration.add(f);
  }
  
  void update() {
    if (mode == 1) { // left screen
      if (keyPressed) {
        if (key == 'a') {
          acceleration.x = -0.5;
        }
        if (key == 'd') {
          acceleration.x = 0.5;
        }
      }
    } else { // right screen
      if (keyPressed) {
        if (keyCode == LEFT) {
          acceleration.x = -0.5;
        }
        if (keyCode == RIGHT) {
          acceleration.x = 0.5;
        }
      }
    }
    
    velocity.add(acceleration);
    position.add(velocity);
    acceleration.mult(0);
    velocity.limit(15);
    velocity.mult(0.99); // friction
    
    if (velocity.x < 0) {
      facingOtherSide = false;
    }
    else if (velocity.x > 0) {
      facingOtherSide = true;
    }
    
    position.x = constrain(position.x, carImage.width * 0.35 / 2 + 114, width - carImage.width * 0.35 / 2 - 108); // constrain x pos
    position.y = constrain(position.y, carImage.height * 0.35 / 2 + 95, height - carImage.height * 0.35 / 2 - 100); // constrain y pos
  }
  
  void display() {
    pushMatrix();
    translate(position.x, position.y);
    if (!facingOtherSide) {
      scale(-1, 1); // flip horizontally
    }
    rotate(angle); // angle stuff endrit
    imageMode(CENTER);
    image(carImage, 0, 0, carImage.width * 0.35, carImage.height * 0.35);
    popMatrix();
  }
  
   boolean intersects(Ball ball) {
    float distance = dist(position.x, position.y, ball.location.x, ball.location.y);
    return distance < (carImage.width * 0.35 / 2 + ball.size / 2) - 30 || distance < (carImage.height * 0.35 / 2 + ball.size / 2) - 60;
  }
  
}

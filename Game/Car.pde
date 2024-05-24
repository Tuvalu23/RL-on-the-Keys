public class Car {
  String name;
  PVector position;
  PVector velocity;
  PVector acceleration;
  PVector location;
  color carColor;
  float angle; // heading essentially
  float size = 30; // size of the car
  int mode; // left or right keys
  
  Car(String n, color c, float x, float y, int mode) {
    name = n;
    carColor = c;
    position = new PVector(x, y);
    velocity = new PVector(0, 0);
    acceleration = new PVector(0,0);
    angle = PI/2;
    this.mode = mode;
  }
  
  //have to continue working with angles
  void angleUp(){
    if (angle > 3*PI/2){
      rotate(-radians(1));
    }
    else{
      car.rotate(radians(1));
    }
  }
  
 // move method is bound to change a lot this is very simple 
  void move(){
    velocity.add(acceleration);
    location.add(velocity);
    acceleration.x = 0;
    acceleration.y = 0;
    velocity.limit(20);
    //change the x based on the xVel
    //change the y based on the yVel
  }
  
   void applyForce(PVector force){
    acceleration.x += force.x/20;
    acceleration.y += force.y/20;
    // acceleration = force / mass
    // Create a force vector
    // Update the acceleration vector applying the acceleraion formula
    // IMPORTANT: More than one force could be applied, so you need to add the forces
    // to have the net force
  }
  
  void display() {
    // idk we need to make cool shape
  }
}

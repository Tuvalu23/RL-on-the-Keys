public class Ball {
  PVector location;
  PVector velocity;
  PVector acceleration;
  int mass = 10;
  float size = 20; // ball size
  
  Ball(float x, float y) {
    location = new PVector(x, y); // x,y should be the center of the field, or the top of the field so the ball drops down
    velocity = new PVector(0, 0);
    acceleration = new PVector(0,0);
  }
  
  void move(){
    velocity.add(acceleration);
    location.add(velocity);
    acceleration.x = 0;
    acceleration.y = 0;
    velocity.limit(20);
    //change the x based on the xVel
    //change the y based on the yVel
  }
  
  
  //Change the 800/790 and 1000/999 with the correct borders of the field
  void bounce(){
    if (location.y - (25*mass) <= 0 || location.y+(25*mass) >= 800){
      velocity.y *= -1;
      //acceleration.y *= -1;
      if (location.y - (25 * mass) <= 0)
        location.y = 25 * mass + 1;
      else location.y = 799 - (25 * mass);
    }
    if (location.x - (25*mass) <= 0 || location.x +(25*mass) >= 1000){
      velocity.x *= -1;
      //acceleration.x *= -1;
      if (location.x - (25 * mass) <= 0)
        location.x = 25 * mass + 1;
      else location.x = 999 - (25 * mass);
    }
    // If a ball touches any border of the sketch
    // change the direction of the movement multiplying by -1
  }
  
  //we will need to apply a gravity force to the ball and car
  void applyForce(PVector force){
    acceleration.x += force.x/mass;
    acceleration.y += force.y/mass;
    // acceleration = force / mass
    // Create a force vector
    // Update the acceleration vector applying the acceleraion formula
    // IMPORTANT: More than one force could be applied, so you need to add the forces
    // to have the net force
  }
  
  void display() {
    fill(128, 128, 128);
    circle(location.x, location.y, size);
  }
  
  // continue
}

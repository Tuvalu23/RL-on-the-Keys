public class Ball {
  PVector location;
  PVector velocity;
  PVector acceleration;
  int mass = 10;
  float size = 100; // ball size
  
  Ball(float x, float y) {
    location = new PVector(x, y); // x,y should be the center of the field, or the top of the field so the ball drops down
    velocity = new PVector(0, 0);
    acceleration = new PVector(0,0);
  }
  
  void update() { // former move() just changed for simplicity
    velocity.add(acceleration);
    location.add(velocity);
    acceleration.mult(0);
    velocity.limit(20);
    bounce();
  }
  
  // fixed so bounce works properly
  void bounce(){
    float xOffset = 115;
    float yOffset = 100;

    if (location.y - size / 2 <= yOffset || location.y + size / 2 >= height - yOffset) {
        velocity.y *= -1;
        if (location.y - size / 2 <= yOffset)
            location.y = yOffset + size / 2;
        else
            location.y = height - yOffset - size / 2;
    }
    if (location.x - size / 2 <= xOffset || location.x + size / 2 >= width - xOffset) {
        velocity.x *= -1;
        if (location.x - size / 2 <= xOffset)
            location.x = xOffset + size / 2;
        else
            location.x = width - xOffset - size / 2;
    }
  }
  
  //we will need to apply a gravity force to the ball and car
  void applyForce(PVector force){
    acceleration.add(PVector.div(force, mass));
  }
  
  void airResistance() {
    velocity.x *= (0.99);
  }
  
  void display() {
    if (isBall3D) {
      PGraphics pg = createGraphics(int(size), int(size));
      pg.beginDraw();
      pg.noStroke();
      for (int i = 0; i < size / 2; i++) {
        float inter = map(i, 0, size / 2, 100, 255); // Gray on outside (100) to white on inside (255)
        pg.fill(inter);
        pg.ellipse(size / 2, size / 2, size - i * 2, size - i * 2);
      }
      pg.endDraw();
      image(pg, location.x - size / 2, location.y - size / 2);
    } else {
      fill(100, 100, 100); // Gray color
      ellipse(location.x, location.y, size, size);
    }
  }
 
 void checkCollision(Car car) {
    if (car.intersects(this)) {
      PVector normal = PVector.sub(location, car.position);
      normal.normalize();
      float dotProduct = velocity.dot(normal);
      PVector reflection = PVector.sub(velocity, PVector.mult(normal, 2 * dotProduct));
      velocity.set(reflection);

      PVector carForce = car.velocity.copy().mult(car.velocity.mag() * 0.5f); // Adjust force transfer
      applyForce(carForce);

      location.add(PVector.mult(normal, size / 2)); // move the ball outside the car to avoid sticking
    }
 }
  
}

public class Ball {
  PVector position;
  PVector velocity;
  float size = 20; // ball size
  
  Ball(float x, float y) {
    position = new PVector(x, y);
    velocity = new PVector(0, 0);
  }
  
  void display() {
    fill(128, 128, 128);
    circle(position.x, position.y, size);
  }
  
  // continue
}

public class Car {
  PVector position;
  PVector velocity;
  color carColor;
  float angle; // heading essentially
  float size = 30; // size of the car
  int mode; // left or right keys
  
  Car(color c, float x, float y, int mode) {
    carColor = c;
    position = new PVector(x, y);
    velocity = new PVector(0, 0);
    angle = PI/2;
    this.mode = mode;
  }
  
  void display() {
    // idk we need to make cool shape
  }
}

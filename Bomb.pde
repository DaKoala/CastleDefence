class Bomb {
  final static float G = 0.05;
  PVector pos, vel;
  int type;
  int halfSize;
  
  Bomb(float _posX, float _posY, float _velX, float _velY, int _type, int _halfSize) {
    this.pos = new PVector(_posX, _posY);
    this.vel = new PVector(_velX, _velY);
    this.type = _type;
    this.halfSize = _halfSize;
  }
  
  void update() {
    this.vel.y += G;
    this.pos.x += this.vel.x;
    this.pos.y += this.vel.y;
  }
  
  void display(ArrayList<PImage> images) {
    image(images.get(this.type), this.pos.x, this.pos.y);
  }
}
class Player {
  PVector pos;
  float lbound, rbound, tbound, bbound;
  int state;
  int halfSize;
  Listener leapMotion;
  
  Player(float _posX, float _posY, float _lbound, float _rbound, float _tbound, float _bbound, int _halfSize, Listener _leapMotion) {
    this.pos = new PVector(_posX, _posY);
    this.lbound = _lbound;
    this.rbound = _rbound;
    this.tbound = _tbound;
    this.bbound = _bbound;
    this.leapMotion = _leapMotion;
    this.halfSize = _halfSize;
    this.state = 0;
  }
  
  boolean isCollide(Bomb that) {
    float dx = this.pos.x - that.pos.x;
    float dy = this.pos.y - that.pos.y;
    float distSq = dx * dx + dy * dy;
    float sizeSum = this.halfSize + that.halfSize;
    if (distSq < sizeSum * sizeSum) return true;
    return false;
  }
  
  void update() {
    if      (this.leapMotion.triggerGrab) this.state = 3;
    else if (this.leapMotion.isGrab)      this.state = 1;
    else if (this.leapMotion.triggerTap)  this.state = 2;
    else                                  this.state = 0;
    
    float x = constrain(this.leapMotion.handPosition.x, this.lbound, this.rbound);
    float y = constrain(this.leapMotion.handPosition.y, this.tbound, this.bbound);
    this.pos.x = x;
    this.pos.y = y;
  }
  
  void display(ArrayList<PImage> images) {
    if (this.state == 1 || this.state == 3) image(images.get(1), this.pos.x, this.pos.y);
    else                                    image(images.get(0), this.pos.x, this.pos.y);
  }
}
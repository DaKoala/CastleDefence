class Base {
  PVector pos;
  PImage baseImage;
  int halfWid, halfHei;

  Base(float _posX, float _posY, int _halfWid, int _halfHei, PImage _baseImage) {
    this.pos = new PVector(_posX, _posY); 
    this.baseImage = _baseImage;
    this.halfHei = _halfHei;
    this.halfWid = _halfWid;
  }

  boolean isCollide(Bomb that) {
    if (abs(this.pos.x - that.pos.x) < (this.halfWid + that.halfSize) && abs(this.pos.y - that.pos.y) < (this.halfHei + that.halfSize)) {
      return true;
    }
    return false;
  }

  void display() {
    image(this.baseImage, this.pos.x, this.pos.y);
  }
}
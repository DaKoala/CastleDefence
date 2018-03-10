import processing.sound.*;

ArrayList<PImage> bombImages = new ArrayList<PImage>();
ArrayList<PImage> playerImages = new ArrayList<PImage>();
ArrayList<Bomb> bombs = new ArrayList<Bomb>();
int interval = 3000;
int counter = 0;
int health = 10;
SoundFile boom;
SoundFile success;
Player player;
Base base;

void setup() {
  imageMode(CENTER);
  size(1600, 900);
  leapSetup(); 
  boom = new SoundFile(this, "boom.wav");
  success = new SoundFile(this, "success.wav");
  player = new Player(500, 500, 0, width, 0, height, 200, listener);
  base = new Base(800, 691, 250, 209, loadImage("base.png"));
  bombImages.add(loadImage("bomb1.png"));
  bombImages.add(loadImage("bomb2.png"));
  playerImages.add(loadImage("hand1.png"));
  playerImages.add(loadImage("hand2.png"));
}

void draw() {
  background(255);
  if (health == 0) {
    textSize(96);
    fill(255, 0, 0);
    text("GAME OVER!", 500, 450);
    return;
  }
  leapDraw();
  board(timeCompute(millis()), health);

  if (millis() - counter > interval) {
    float possible = random(1);
    if      (possible > 0.75) bombs.add(new Bomb(1700, random(300, 500), random(-5, -3), random(-5, -7), 1, 75));
    else if (possible > 0.5)  bombs.add(new Bomb(-100, random(300, 500), random(3, 5), random(-5, -7), 1, 75));
    else                      bombs.add(new Bomb(random(550, 1050), -100, 0, 0, 0, 75));
    counter = millis();
    interval = interval <= 800 ? interval : interval - 50;
  }

  base.display();

  player.update();
  player.display(playerImages);

  for (int i = bombs.size() - 1; i >= 0; i--) {
    Bomb curr = bombs.get(i);

    if ((player.state == 3 && curr.type == 1) || (player.state == 2 && curr.type == 0)) {
      if (player.isCollide(curr)) {
        bombs.remove(i);
        success.play();
        continue;
      }
    }

    if (base.isCollide(curr)) {
      bombs.remove(i);
      boom.play();
      health--;
      continue;
    }

    curr.update();
    curr.display(bombImages);
  }
}

String timeCompute(int ms) {
  int second = ms / 1000;
  int minute = second / 60;
  second = second % 60;
  return "TIME: " + 
    (minute > 9 ? str(minute) : "0" + str(minute)) + 
    ":" + 
    (second > 9 ? str(second) : "0" + str(second));
}

void board(String time, int health) {
  textSize(18);
  fill(0);
  text(time, 20, 30);
  if (health > 2) {
    stroke(0, 255, 0);
    noFill();
    rect(20, 40, 200, 30);
    fill(0, 255, 0);
    rect(20, 40, 20 * health, 30);
  } else {
    stroke(255, 0, 0);
    noFill();
    rect(20, 40, 200, 30);
    fill(255, 0, 0);
    rect(20, 40, 20 * health, 30);
  }
}
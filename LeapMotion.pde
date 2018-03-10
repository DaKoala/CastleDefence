import de.voidplus.leapmotion.*;

class Listener {
  boolean pGrab, isGrab, triggerTap, triggerGrab;
  int pgestureId, gestureId;
  PVector handPosition;

  Listener() {
    this.pGrab = false;
    this.isGrab = false;
    this.triggerTap = false;
    this.triggerGrab = false;
    this.pgestureId = 0;
    this.gestureId = 0;
    this.handPosition = new PVector(0, 0);
  }
}


LeapMotion leap;
Listener listener;

void leapSetup() {
  leap = new LeapMotion(this).allowGestures("key_tap");
  listener = new Listener();
}

void leapDraw() {
  if (listener.gestureId > listener.pgestureId) listener.triggerTap = true;
  else                                          listener.triggerTap = false;
  listener.pgestureId = listener.gestureId;

  for (Hand hand : leap.getHands ()) {
    PVector currPos = hand.getStabilizedPosition();
    float currGrab = hand.getGrabStrength();
    listener.handPosition.x = currPos.x;
    listener.handPosition.y = currPos.y;
    if (currGrab > 0.8) listener.isGrab = true;
    else                listener.isGrab = false;
  }
  if (!listener.pGrab && listener.isGrab) listener.triggerGrab = true;
  else                                    listener.triggerGrab = false;
  listener.pGrab = listener.isGrab;
}


void leapOnKeyTapGesture(KeyTapGesture g) {
  listener.gestureId = g.getId();
}
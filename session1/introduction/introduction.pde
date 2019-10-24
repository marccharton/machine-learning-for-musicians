import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress dest;

void setup() {
  size(640, 640, P2D);
  noStroke();
  oscP5 = new OscP5(this, 9000);
  dest = new NetAddress("127.0.0.1", 6448);
}

int xPos = 0, 
    yPos = 0;

void draw() {
  background(0);
  fill(255);
  
  int ballSize = 100;
  // int offset = ballSize / 2;
  
  xPos = mouseX;
  yPos = mouseY;
  
  ellipse(xPos, yPos, ballSize, ballSize);
  println(mouseX);
  if (frameCount % 2 == 0) {
    sendOsc();
  }
}

void sendOsc() {
  OscMessage msg = new OscMessage("/wek/inputs");
  msg.add((float)mouseX);
  msg.add((float)mouseY);
  oscP5.send(msg, dest);
}

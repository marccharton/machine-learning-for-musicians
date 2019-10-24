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

  drawValues();
  drawBall();
}

void drawBall() {
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

void drawValues(){
  push();
  stroke(255, 0, 0);
  line(width/2, 0, width/2, height);
  line(0, height/2, width, height/2);

  textSize(15);
  fill(150);
  text("(output1, output2)", 20, 20);

  textSize(32);
  fill(255, 0, 0);
  text("(0,0)", width / 4 - 50, height / 4);
  text("(0,1)", width * 3/4 - 50, height / 4);
  text("(1,0)", width / 4 - 50, height * 3/4);
  text("(1,1)", width * 3/4 - 50, height * 3/4);

  pop();
}

void sendOsc() {
  OscMessage msg = new OscMessage("/wek/inputs");
  msg.add((float)mouseX);
  msg.add((float)mouseY);
  oscP5.send(msg, dest);
}

import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress dest;

float ballSize;
float ballColor;

void setup() {
  size(640, 640, P2D);
  noStroke();
  colorMode(HSB);
  oscP5 = new OscP5(this, 9000);
  dest = new NetAddress("127.0.0.1", 6448);
}

void draw() {
  background(0);
  fill(255);

  drawValues();
  drawBall();
}

void drawBall() {
  ballSize = map(mouseY, 0, height, 0, width/2);
  ballColor = map(mouseX, 0, width, 0, 255);

  fill(ballColor, 255, 255);
  ellipse(width/2, height/2, ballSize, ballSize);
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
  fill(255, 255, 255);
  text("-", width / 2 - 50, 20);
  text("+", width / 2 - 50, height - 20);
  
  text("rouge", width * 1/10 - 50, height / 2);
  text("rouge", width * 9/10 - 50, height / 2);
  text("bleu", width * 5/10 - 50, height / 2);

  pop();
}

void sendOsc() {
  OscMessage msg = new OscMessage("/wek/inputs");
  msg.add(ballSize);
  msg.add(ballColor);
  oscP5.send(msg, dest);
}

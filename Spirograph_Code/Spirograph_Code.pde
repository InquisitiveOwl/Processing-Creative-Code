// SPIROGRAPH
// http://en.wikipedia.org/wiki/Spirograph
// also (for inspiration):
// http://ensign.editme.com/t43dances
//
// this processing sketch uses simple OpenGL transformations to create a
// Spirograph-like effect with interlocking circles (called sines).  
// press the spacebar to switch between tracing and
// showing the underlying geometry.
//
// your tasks:
// (1) tweak the code to change the simulation so that it draws something you like.
// hint: you can change the underlying system, the way it gets traced when you hit the space bar,
// or both.  try to change *both*.  :)
// (2) use minim to make the simulation MAKE SOUND.  the full minim docs are here:
// http://code.compartmental.net/minim/
// hint: the website for the docs has three sections (core, ugens, analysis)... look at all three
// another hint: minim isn't super efficient with a large number of things playing at once.
// see if there's a simple way to get an effective sound, or limit the number of shapes
// you're working with.

import ddf.minim.*;

AudioPlayer player;
Minim minim;

int NUMSINES = 12; 
float[] sines = new float[NUMSINES];
float IR; 
int i; 

float fund = 0.01; 
float ratio = .1; 
int alpha = 50;

boolean trace = true;

void setup()
{
  size(1200, 700, P3D);
  
  minim =new Minim(this);
  player = minim.loadFile("Blank__Kytt_-_08_-_RSPN.mp3",2048);
  player.play();

  IR = height/2.;
  background(255);

  for (int i = 0; i<sines.length; i++)
  {
    sines[i] = TAU;
  }
}

void draw()
{

  if (!trace) background(255);
  if (!trace) {
    stroke(0, 255);
    fill(255, 0, 0);
    frameRate(100);
  }  

  pushMatrix(); 
  translate(width/2, height/2); 

  for (i = 0; i<sines.length; i++)
  {
    float ittyBittyPoint = 0;
    if (trace) {
      stroke(0, 0, 100*(float(i)/sines.length), alpha/2);
      fill(125, 50, 100, 50);
      ittyBittyPoint = 6.0*(3.0-float(i)/sines.length); 
    }
    float radius = IR/(i+1);
    rotateZ(sines[i]); 
    if (!trace) ellipse(radius*2, radius*2, 0, 0);
    pushMatrix(); 
    translate(radius, radius); 
    if (!trace) ellipse(1, 1, 1, 0);
    if (trace) ellipse(0, 0, ittyBittyPoint, ittyBittyPoint);
    popMatrix(); 
    translate(radius, 1);
    sines[i] = (sines[i]+(fund+(fund*i*ratio)))%TAU;
  }
  popMatrix();
}

void keyPressed()
{
  if (key==' ') {
    background(255);
  }
}

void stop()
{
  player.close();
  minim.stop();
  super.stop();
}

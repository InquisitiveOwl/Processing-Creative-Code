// This was originally called ripples in 3D by Steven Kay
// Source code can be found here http://www.openprocessing.org/sketch/6714
 
int waveNum=6; //I increased the wave cycle

//removed his coloring background

float smoothWaves=0.991; // changed the speed of the waves
 
class source{
    public float xAxis; //renamed public floats
    public float yAxis;
    public float amplitude;
    public float dist;
   
  public source(float _x,float _y, float _amp,float _wave) {
      xAxis=_x; 
      yAxis=_y; 
      amplitude=_amp; 
      dist=_wave;
  }
   
  public float getPart(float xx,float yy,float time) {
    float distt=mag(xx-xAxis,yy-yAxis);
    return amplitude*(float) Math.cos (((time-distt)/dist));
  } //this is all the mathmatical foundations Kay set so I left them as is
 
  public void disappear() {
    amplitude*=smoothWaves;
  } 
}
 
ArrayList waveys;
 
void setup() {
  size(1200,1200,P3D);
  newDrop();
}
 
//he set up the format for this segment as well although I wen't through to rename and test each segment 
void newDrop() {
  waveys=new ArrayList();
    for (int i=0;i<waveNum;i++) {
      chopyWater(); 
  }
}
 
void keyReleased() { // made this a keyRelease
  newDrop();
}
 
 //removed his keyPressed code
 
void chopyWater() {
  waveys.add(new source(random(-300,100),random(-300,100),random(2,60),random(2,12)));
} //changed ripples to look more ragged in movement like choppy water
 
void draw() {
  background(154,0,0); //turned into a sea of blood
  noStroke();
   
  // fade waves out over time
  for (int i=0;i<waveys.size();i++) {
    source s=(source)waveys.get(i);
    s.disappear();
  }
   
  translate(00,00,-1100); //moved ocean surface lower on the screen
  rotateX(mouseY/100.0); //changed so you can flip the ocean over

   //I've left most of this the same since I like the way the heights compound
  float totalAmp=0.0;
   
  for (float y=-100.0;y<100.0;y+=3.0) {
    for (float x=-100.0;x<100.0;x+=3.0) {
 
      // sum of waves heights
      float compoundHeight=0.0;
      for (int i=0;i<waveys.size();i++) {
        source s=(source)waveys.get(i);
        compoundHeight+=s.getPart(x,y,(float)frameCount);
      }
      totalAmp+=Math.abs(compoundHeight);
       
      // brightness level
      float num=80+(10*compoundHeight);
      fill(num);
       
      if (num>50) { //lowered
        pushMatrix();
        translate(x*20,y*20,compoundHeight); //expanded field to cover frame
        box(20); // increased number of boxes and sizes- wanted to switch to spheres but the computer can't handle that much computation it seems
        popMatrix();
      }
       
    }
  }
  //removed his settling down and auto restart
}


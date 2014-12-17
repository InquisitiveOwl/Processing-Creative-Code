//most credit goes to Ryan Chao, who did some very neat spinny star galaxy thing
//I followed his format and structure to redesign organization, numbers, sizes, randomness and spent a good deal of time trying to cut away unnecessary code among other ins and outs
//link here: http://www.openprocessing.org/sketch/152497

//issues I'm still looking to change. Fix the initial draw that reverts back to Chao's original design then turns into mine. 

int stars = 700; //changed number

myLine[] L = new myLine[stars];
myArc[] A = new myArc[stars];

void setup() {

  size(1200, 600); //changed size
  background(0);
  noFill();
  
//changed variable names
  for(int d = 0; d < stars; d++) {

    L[d] = new myLine(width, height, width, height);
    A[d] = new myArc(width, height, width, height);

  }
}
 
 
void draw() {
   
  background(0);
  for(int d = 0; d < stars; d++) {
    if(L[d].nFrame <= L[d].pizzaSlice) {
      L[d].update();
    } 
    //what I created to make the stars fly from bottom right to upper left
    else {
      L[d] = new myLine(width+80, height+80, -mouseX, -mouseY);
    }
     
    if(A[d].nFrame <= A[d].pieceOfCake) {
      A[d].update();
    } 
    //the simple yet huge change that changes arc style from tube to spinny thing
    else {
      A[d] = new myArc(-width, -height, mouseX, mouseY);
    }
  }  
}
 
 //this was all set and established by Chao since I don't know what a PVector does yet but I liked how it called on the program to do a trippy circle
class myLine {
   
  PVector andTheyreOff;
  PVector[] mMove = new PVector[2]; //mousemove
  PVector direction;
  float ruler;
  float tstep;
  int nFrame = 1;
  int pizzaSlice;
  color perty;
  int lbs;
 
  myLine(int wid, int hei, float Xc, float Yc) {
 
    //99% of things in this segment of code was also set up by Chao and I chose to leave since I needed it to run my code visual
    //had an issue where stars started forming mid screen so I added pixel directions fixed it so they looked like they were coming from off screen
    andTheyreOff = new PVector( random(-100.0, (float)wid + 100), random(-100.0, (float)hei + 100));
    direction = new PVector(Xc - andTheyreOff.x, Yc - andTheyreOff.y);
    ruler = direction.mag();
    pizzaSlice = (int)random(70, 130); //increased number to slow down the start creation
    tstep = ruler / (float)pizzaSlice;
    direction.normalize();
    mMove[0] = andTheyreOff;
    mMove[1] = PVector.add(andTheyreOff, PVector.mult(direction, tstep));
    perty = color(300, 350, random(150, 250)); //changed these numbers to make stars two colors- a yellowish and a white
    lbs = (int)random(2, 3); //changed this to make for tiner farther looking stars
  }
   
  void update() {
//    comment by Chao: pushStyle();
//this code batch I left the same as well
    stroke(perty, 100.0 - 100*cos( (float)nFrame * tstep*TWO_PI/ruler) );      
    strokeWeight(lbs);  
    line(mMove[0].x, mMove[0].y, mMove[1].x, mMove[1].y);
//    comment by Chao: popStyle();
    mMove[0] = mMove[1];
    mMove[1] = PVector.add(mMove[0], PVector.mult(direction, tstep));
    nFrame ++; 
  }
   
}
     //though I changed most of the labels here, I kept his structure the same to make sure I understood everything
class myArc {
  PVector andTheyreOff;
  PVector[] mMove = new PVector[2];
  float range;
  int pieceOfCake;
  float magnitute;
  float ang;
  float tStep;
  int nFrame = 1;
  int pizzaSlice;
  color perty;
  int lbs;
  float Rx, Ry;
   
  myArc(int wid, int hei, float Xc, float Yc) {
    wid *= 0.2;
    hei *= 0.2;
    Rx = Xc;
    Ry = Yc;
    PVector reference = new PVector(1.0, 0.0);
    andTheyreOff = new PVector( random(-(float)wid, (float)wid), random(-(float)hei, (float)hei));
    ang = PVector.angleBetween(andTheyreOff, reference);
    if(andTheyreOff.y < 0) {
      ang *= -1.0;
    }
    magnitute = andTheyreOff.mag();
    range = random(-TWO_PI, TWO_PI);
    pieceOfCake = (int)random(70, 120);//slightly increaded numbers to slow the draw of circle
    tStep = range / (float)pieceOfCake;
    perty = color(250, 0, random(100, 120));//changes color of circle to snazzy magenta
    lbs = (int)random(2, 4);//changed slightly the size of the stars that make up the big circle
    //left the below code unchanged in terms of structure and format
    mMove[0] = new PVector(andTheyreOff.x + Rx, andTheyreOff.y + Ry);
    andTheyreOff.set(magnitute * cos(ang + tStep), magnitute * sin(ang + tStep));
    mMove[1] = new PVector(andTheyreOff.x + Rx, andTheyreOff.y + Ry);
     
  }
   
  void update() {
//    pushStyle();
    stroke(perty, 255.0 - 300*cos( (float)nFrame * tStep*TWO_PI/range) );//increased numbers slightly
    strokeWeight(lbs);
    line(mMove[0].x, mMove[0].y, mMove[1].x, mMove[1].y);
//    popStyle();
    mMove[0] = mMove[1];
    andTheyreOff.set(magnitute * cos(ang + nFrame * tStep), magnitute * sin(ang + nFrame * tStep) );
    mMove[1] = new PVector(andTheyreOff.x + Rx, andTheyreOff.y + Ry);
    nFrame ++; 
     
  }
   
}
void keyPressed()
{
  if(key==' ') background (0);
}


PImage doodle[] = new PImage[6];

int w, h;

int x, y; 

int mid; 
int aod; 

int imgNum = 0; 

color p0, p1, p2, p3, p4, p5, p6, p7, p8; 

void setup()
{
  size(800, 400); 
  smooth(); 

  doodle[0] = createImage(50, 50, RGB);
  doodle[1] = createImage(50, 50, RGB);
  w = doodle[0].width; 
  h = doodle[0].height; 

  fillRandom();
}

void draw()
{

  doodle[imgNum].loadPixels();

  if (mousePressed)
  {
    int mousex = constrain(int(mouseX/4.0), 0, width-5);
    int mousey = constrain(int(mouseY/12.0), 0, height-2);
    doodle[imgNum].pixels[mousey*w + mousex] = color(100, 100, 100);
  }

  
  for (x=0; x<h; x++) 
  {
    for (y=0; y<w; y++)
    {

      // top row
      p0 = doodle[imgNum].pixels[((x-1+h)%h)*w + (y-1+w)%w]; 
      p1 = doodle[imgNum].pixels[((x-1+h)%h)*w + y]; 
      p2 = doodle[imgNum].pixels[((x-1+h)%h)*w + (y+1+w)%w]; 

      // center row
      p3 = doodle[imgNum].pixels[x*w + (y-1+w)%w];
      p4 = doodle[imgNum].pixels[x*w + y]; 
      p5 = doodle[imgNum].pixels[x*w + (y+1+w)%w]; 

      // bottom row
      p6 = doodle[imgNum].pixels[((x+1+h)%h)*w + (y-1+w)%w]; 
      p7 = doodle[imgNum].pixels[((x+1+h)%h)*w + y]; 
      p8 = doodle[imgNum].pixels[((x+1+h)%h)*w + (y+1+w)%w]; 

      aod = 0; 
      aod+= int(green(p0)>50.) + int(green(p1)>150.) + int(green(p2)>200.); 
      aod+= int(green(p3)>50.) + int(green(p5)>150.); 
      aod+= int(green(p6)>50.) + int(green(p7)>150.) + int(green(p8)>200.); 

      mid = int(green(p4)>30.); 

      if (mid==1 && (aod==3 ||aod==2))
      {
        doodle[1-imgNum].pixels[x*w + y] = color(50, 60, 75);
      } else if (mid==0 && aod==1) 
      {
        doodle[1-imgNum].pixels[x*w + y] = color(100, 100, 255);
      } else 
      {   
        doodle[1-imgNum].pixels[x*w + y] = color(200, 0, 50);
      }
    }
  }

  doodle[imgNum].updatePixels(); 

  image(doodle[1-imgNum], 1, 1, width, height); 

  imgNum = 1-imgNum; 
}

void fillRandom()
{
  doodle[imgNum].loadPixels();
  for (x=0; x<doodle[imgNum].pixels.length; x++)
  {
    float rand = random(500);
    if (rand>400) 
    {
      doodle[imgNum].pixels[x] = color(255, 255, 255);
    }
  }
  doodle[imgNum].updatePixels();
}

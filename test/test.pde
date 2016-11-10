  int b = 360;
  float s;
  float[] a = new float[b];
  void setup()
  {

  size(1000, 360);
  background(255);
 
  
  println(a[1]);
  }
void draw()
{
   s = random(0,500);
   a[0] = s;

   background(204);
   fill(0, 0, 255);  
       for(int c =350;c>0;c--)
    {       
       a[c] = a[c-1];      
    } 
     stroke(255,0,123);
     for(int c =0;c<350;c++)
    {        
       point(c,a[c]);
    }
  
  
   
}
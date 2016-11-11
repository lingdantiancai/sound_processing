// This sketch shows how to use the Amplitude class to analyze a
// stream of sound. In this case a sample is analyzed. Smooth_factor
// determines how much the signal will be smoothed on a scale
// form 0-1.

import processing.sound.*;

// Declare the processing sound variables 
SoundFile sample;
Amplitude rms;



  int b =1000 ,q = 1000;
  float s;
  float[] a = new float[b];
  float width_x;
// Declare a scaling factor
float scale=5;

// Declare a smooth factor
float smooth_factor=0.25;

// Used for smoothing
float sum;

public void setup() {
    size(1000,720);
    width_x = 1000/q;
    //Load and play a soundfile and loop it
    sample = new SoundFile(this, "DJ.mp3");
    sample.loop();
    
    // Create and patch the rms tracker
    rms = new Amplitude(this);
    rms.input(sample);
}      

public void draw() {
    // Set background color, noStroke and fill color
    background(125,255,125);
    noStroke();
    fill(255,0,150);
    
    // smooth the rms data by smoothing factor
    sum += (rms.analyze() - sum) * smooth_factor;  

    // rms.analyze() return a value between 0 and 1. It's
    // scaled to height/2 and then multiplied by a scale factor
    float rms_scaled=sum*(height/2)*scale;

    // We draw an ellispe coupled to the audio analysis
    ellipse(width/2+300, height/2, rms_scaled, rms_scaled);
   
    a[0] =  rms_scaled;
    for(int c =b-1;c>0;c--)
    {       
       a[c] = a[c-1];      
    } 
     stroke(255,0,123);
     for(int c =0;c<b-1;c++)
    {    
      //line(c,360-a[c]/2,c+1,360-a[c+1]/2);
      //line(c,360+a[c]/2,c+1,360+a[c+1]/2);
      rect(c*width_x,360,width_x,-a[c]/2);
      rect(c*width_x,360,width_x,a[c]/2);
      //point(c,a[c]);
    }
}
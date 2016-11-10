/**
 * Processing Sound Library, Example 5
 * 
 * This sketch shows how to use the FFT class to analyze a stream  
 * of sound. Change the variable bands to get more or less 
 * spectral bands to work with. The smooth_factor variable determines 
 * how much the signal will be smoothed on a scale form 0-1.
 */

import processing.sound.*;

// Declare the processing sound variables 
SoundFile sample;
FFT fft;
AudioDevice device;


  int b = 360;
  float s;
  float[] a = new float[b];

// Declare a scaling factor
int scale = 5;

// Define how many FFT bands we want
int bands = 256;

// declare a drawing variable for calculating rect width
float r_width;

// Create a smoothing vector
float[] sum = new float[bands];

// Create a smoothing factor
float smooth_factor = 0.2;

void setup() {
  size(1000, 360);
  background(255);

  // If the Buffersize is larger than the FFT Size, the FFT will fail
  // so we set Buffersize equal to bands
  device = new AudioDevice(this, 44000, bands);

  // Calculate the width of the rects depending on how many bands we have
  r_width = 650/float(bands);

  // Load and play a soundfile and loop it. This has to be called 
  // before the FFT is created.
  sample = new SoundFile(this, "DJ.mp3");
  sample.loop();

  // Create and patch the FFT analyzer
  fft = new FFT(this, bands);
  fft.input(sample);
}      

void draw() {
  // Set background color, noStroke and fill color
  background(204);
  fill(0, 0, 255);
  noStroke();

  fft.analyze();
  for (int i = 0; i < bands; i++) {
    // Smooth the FFT data by smoothing factor
    sum[i] += (fft.spectrum[i] - sum[i]) * smooth_factor;

    // Draw the rects with a scale factor
    rect( i*r_width, height, r_width, -sum[i]*height*scale );
    println(sum[0]*height*scale);
    point(650,sum[0]*height*scale);
    //////////////////////
    a[0] = sum[0]*height*scale;
    for(int c =350;c>0;c--)
    {       
       a[c] = a[c-1];      
    } 
     stroke(255,0,123);
     for(int c =0;c<350;c++)
    {        
       point(650+c,a[c]);
    }
    
  }
}
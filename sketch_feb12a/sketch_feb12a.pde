import ddf.minim.*;
import ddf.minim.signals.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;

Minim minim;
AudioPlayer player;
String filename;
FFT fft;

void setup() {
  // Setup Sketch
  size(800, 600, P2D);
  
  // Setup Song
  minim = new Minim(this);
  filename = "Clair de lune - Debussy.mp3";
  player = minim.loadFile(filename);
  player.play();
  
  // Setup FFT
  fft = new FFT(player.bufferSize(), player.sampleRate());
  fft.linAverages(128);  // sets length of averages array
}

// Drawing FFT with bar representation
void draw() {
  background(0);
  // performs forward transform on buffer, does spectrum analysis and calculate
  // averages array
  fft.forward(player.mix);
  
  // drawing bars
  for (int i = 0; i < 24; i++){
    float freq = fft.getAvg(i) * 40;
    rect(i * 20, height-freq, 20, freq);
    fill(255);
  }
}

void stop(){
  if (player.isPlaying()){
    player.pause();
  }
}

// Cleaning up	
void destroy(){
  player.close();
  minim.stop();
  super.stop();
}

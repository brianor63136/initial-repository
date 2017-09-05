import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

Minim minim;
AudioOutput out;
FFT         fft;

float b_note[] = {261.63, 293.66, 329.63, 349.23, 392, 440, 493.88, 523.25};
float t_note[] = {1046.5, 1174.66, 1318.51, 1396.91, 1567.98, 1760, 1975.53, 2093};

public void setup() {
  size( 400, 200, P3D );
  minim = new Minim(this); //initialises input variable
  out = minim.getLineOut();//initialises output variable

  fft = new FFT( 1024, out.sampleRate() ); //initialises fft variable using 1024 samples with the output patched to the samplerate

  for ( int i = 0; i < 20; i++ ) // i is set to 0, because i is less than 30 it will incremnet until it reaches this number
  { 
    if (i <=4) {

      out.playNote( 1.25 + i*2.0, 0.3, new kick( ) );//output connected to playnote, which has the parameters of startTime, duration, and instrument
    } else if (i>=4 && i<=6) {

      out.playNote( 1.25 + i*2.0, 0.3, new kick( ) );//as a result everytime that these instrumnets are called they are played  
      out.playNote( 1.75 + i*2.0, 0.3, new hat( ) );
    } else if (i >=6  && i<=10) {

      out.playNote( 1.25 + i*2.0, 0.3, new kick( ) );
      out.playNote( 1.75 + i*2.0, 0.3, new hat( ) );
      out.playNote( 2.25 + i*2.0, 0.3, new snare( ) );
    } else if (i >= 10 && i<=14) {

      out.playNote( 1.25 + i*2.0, 0.3, new kick( ) );
      out.playNote( 1.75 + i*2.0, 0.3, new hat( ) );
      out.playNote( 2.25 + i*2.0, 0.3, new snare( ) );
      out.playNote( 1 + i*2.0, 0.05, new melodics( b_note[1], 0.5 ) ); //because melodic instrument has the parameters of frequency and amplitude, they need to be added
      out.playNote( 2 + i*2.0, 0.05, new melodics( b_note[5], 0.5 ) ); //the notes are called from their arrays, which contain specific octaves
    } else if (i>=14 && i<=16) {
      out.playNote( 1.25 + i*2.0, 0.3, new kick( ) );
      out.playNote( 1.75 + i*2.0, 0.3, new hat( ) );
      out.playNote( 2.25 + i*2.0, 0.3, new snare( ) );
      out.playNote( 1 + i*2.0, 0.05, new melodics( b_note[1], 0.5 ) );
      out.playNote( 2 + i*2.0, 0.05, new melodics( b_note[5], 0.5 ) );
      out.playNote( 1.5 + i*2.0, 0.05, new melodics( t_note[3], 0.25 ) );
      out.playNote( 2.5 + i*2.0, 0.05, new melodics( t_note[7], 0.25 ) );
    } else {
      out.playNote( 1.25 + i*2.0, 0.3, new kick( ) );
      out.playNote( 1.75 + i*2.0, 0.3, new hat( ) );
      out.playNote( 2.25 + i*2.0, 0.3, new snare( ) );
      out.playNote( 1 + i*2.0, 0.05, new melodics( b_note[1], 0.5 ) );
      out.playNote( 2 + i*2.0, 0.05, new melodics( b_note[5], 0.5 ) );
      out.playNote( 0.5 + i*2.0, 0.05, new melodics( t_note[3], 0.25 ) );
      out.playNote( 1.5 + i*2.0, 0.05, new melodics( t_note[5], 0.25 ) );
      out.playNote( 2.5 + i*2.0, 0.05, new melodics( t_note[3], 0.25 ) );
    }
  }

}

public void draw()
{ //fft visualisation is drawn here
  background( 0 );

  stroke( 200 );

  fft.forward( out.mix ); //fft will be performed on the samples in the output mix buffer in real time

  for ( int i = 0; i < fft.specSize(); ++i )
  { //draws the line for the frequency band
    float val = fft.getBand( i );
    line( i, height, i, height - pow ( 10.0, (0.05 * val) )*2 );
  }

  fill( 255 );
}
/* REFERENCES
 http://code.compartmental.net/minim/adsr_class_adsr.html
 http://code.compartmental.net/minim/noise_class_noise.html
 http://code.compartmental.net/minim/fft_class_fft.html
 frequencies used are based off this http://www.phy.mtu.edu/~suits/notefreqs.html
 https://www.reddit.com/r/synthesizers/comments/2d2muh/how_to_synthesize_hihats_through_subtractive/?st=ivu0h8nd&sh=c445a4aa
 http://sound-au.com/tcaas/hiraga1fig1.gif
 */
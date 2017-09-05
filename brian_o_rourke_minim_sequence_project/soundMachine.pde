public class soundMachine implements Instrument
{
  ADSR adsr;
  Oscil osc;
  Oscil osc_1;
  Oscil osc_2;
  MoogFilter moog;
  MoogFilter moog_1;
  //volume
  float amp = 1;
  //adsr
  float attack = 0;
  float decay = 0.1;
  float sustain = 1;
  float release = 0.5;
  //osc + moog
  float freq = 1000;

  void noteOn( float dur )
  {
    adsr.noteOn(); //specifies when the adsr should start - http://code.compartmental.net/minim/adsr_method_noteon.html
    adsr.patch( out ); //patches the adsr to the output
  }

  void noteOff()
  {
    adsr.unpatchAfterRelease( out ); //unpatches the adsr to the output
    adsr.noteOff(); //specifies that the adsr envelope should start the release time - http://code.compartmental.net/minim/adsr_method_noteoff.html
  }
}

public class kick extends soundMachine
{ 
  // the resulting sound is the product of a combination of subtractive 
  //synthesis (the filters), frequency modulation (patching the oscillators 
  //together), and an envelope (ADSR)

  public kick()
  {     

    adsr = new ADSR( amp*0.5, attack, decay, sustain*0.5, release); 
    osc = new Oscil(freq*0.1, amp*0.5, Waves.SQUARE);
    osc_1 = new Oscil(freq*0.05, amp*0.5, Waves.TRIANGLE);
    moog = new MoogFilter(freq*0.05, amp*0.5);
    moog_1 = new MoogFilter(freq*0.075, amp*0.6);

    moog.type= MoogFilter.Type.LP; //declariing the type of filter that will be used
    moog_1.type= MoogFilter.Type.LP;

    osc.patch(adsr); //patching the carrier osc to the adsr
    osc.patch(moog); //patching the carrier osc to the first filter
    osc.patch(moog_1); //patching the carrier osc to the second filter
    osc.patch(osc_1); //patching the carrier osc to the modular osc
  }
}

public class snare extends soundMachine
{ 

  private Noise noise;
  private MoogFilter  moog_2;
  private MoogFilter  moog_3;
  private MoogFilter  moog_4;

  snare()
  {     
    noise = new Noise(0.5);
    adsr = new ADSR( amp*0.5, attack, decay+0.015, sustain*0.119, release*1.1165);
    moog = new MoogFilter(freq*10, 0.5);
    moog_1 = new MoogFilter(freq*12, amp*0.6);
    moog_2 = new MoogFilter(freq*14, amp*0.7);
    moog_3 = new MoogFilter(freq*16, amp*0.8);
    moog_4 = new MoogFilter(freq*18, amp*0.9);

    moog.type= MoogFilter.Type.HP;//declariing the type of filter that will be used
    moog_1.type= MoogFilter.Type.HP;
    moog_2.type= MoogFilter.Type.HP;
    moog_3.type= MoogFilter.Type.HP;
    moog_4.type= MoogFilter.Type.HP;

    noise.patch( adsr );//patching the noise generator to the adsr and the 5 filters
    noise.patch( moog );
    noise.patch( moog_1 );
    noise.patch( moog_2 );
    noise.patch( moog_3 );
    noise.patch( moog_4 );
  }
}

public class hat extends soundMachine
{ 
  hat()
  {    //filling these variables with various data types.
    //the setup for this class was derived from a the ADSR helpfile along with information from reddit
    adsr = new ADSR( amp*0.6, attack, decay*2, sustain*0.6, release*0.2  );
    osc = new Oscil(freq*16, amp*0.5, Waves.TRIANGLE);
    osc_1 = new Oscil(freq*19, amp*0.5, Waves.SQUARE);
    osc.patch(adsr); //patching to the adsr and the modular osc
    osc.patch(osc_1);
  }
}

class melodics extends soundMachine
{ 
  melodics( float frequency, float amplitude )
  {    // the values used are based off of the adsr helpfile
    osc = new Oscil( frequency, amplitude, Waves.TRIANGLE );
    osc_1 = new Oscil(frequency*2, amplitude*0.75, Waves.TRIANGLE);
    osc_2 = new Oscil(frequency*4, amplitude*0.5, Waves.TRIANGLE);

    adsr = new ADSR( 0.5, 0.01, 0.05, 0.5, 0.25 );
    moog = new MoogFilter (7500, 0.5);
    moog_1 = new MoogFilter (8000, 0.6);
    moog.type = MoogFilter.Type.HP;
    moog_1.type = MoogFilter.Type.LP;

    osc.patch(adsr).patch(moog);
    osc.patch(adsr).patch(moog_1);

    osc_1.patch(adsr).patch(moog);
    osc_2.patch(adsr).patch(moog_1);
  }
}
import ddf.minim.*;
import ddf.minim.ugens.*;
import javax.sound.midi.*;
/**
    This example demonstrates how you might use the note sequencing abilities 
    of Minim to drive a JavaSound Synthesizer. You might want to take this 
    approach if you want to tightly couple visuals and music, like this example does,
    but don't want to construct your own synthesis chains or try to hook into midi events
    from a JavaSound Sequence. Also, typically, Minim's sequencing will have more 
    solid timing than a JavaSound Sequence will.
    <p>
    For more info about what can be done with JavaSound midi synthesis, see 
    <a href="http://docs.oracle.com/javase/6/docs/api/javax/sound/midi/MidiChannel.html">javax.sound.midi.MidiChannel</a> and 
    <a href="http://docs.oracle.com/javase/6/docs/api/javax/sound/midi/Synthesizer.html">javax.sound.midi.Synthesizer</a>
    <p>
    For more information about Minim and additional features, visit http://code.compartmental.net/minim/
    <p>
    Author: Damien Di Fede  
  */
  

// two things we need from Minim for note playing.  

// what we need from JavaSound for sound making.


// the Blip class is what handles our visuals.
// see below the draw function for the definition.

// the Instrument implementation we use for playing notes
// we have to explicitly specify the Instrument interface
// from Minim because there is also an Instrument interface
// in javax.sound.midi. We could avoid this by importing
// only the classes we need from javax.sound.midi, 
// rather than importing everything.
class MidiSynth implements ddf.minim.ugens.Instrument
{
  int channel;
  int noteNumber;
  int noteVelocity;

  MidiSynth( int channelIndex, String noteName, float vel )
  {
    channel = channelIndex;
    // to make our sequence code more readable, we use note names.
    // and then convert the note name to a Midi note value here.
    noteNumber = (int)Frequency.ofPitch(noteName).asMidiNote();
    // similarly, we specify velocity as a [0,1] volume and convert to [1,127] here.
    noteVelocity = 1 + int(126*vel); 
  }
  
  void noteOn( float dur )
  {
    // make sound
    channels[channel].noteOn( noteNumber, noteVelocity );
  }
  
  void noteOff()
  {
    channels[channel].noteOff( noteNumber );
  }
}

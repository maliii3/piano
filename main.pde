import java.io.*;
import java.lang.*;
import themidibus.*; //Import the library
import javax.sound.midi.*;
import processing.serial.*;
import static javax.swing.JOptionPane.*;
import ddf.minim.*;
import ddf.minim.AudioPlayer;
import ddf.minim.ugens.*;

static final int SETUP_STATE = 0;
static final int READY_STATE = 1;
static final int RECORD_STATE = 2;
static final int TUTORIAL_STATE = 3;
static final int SETTINGS_STATE = 4;
static final int MODE_SELECTION_STATE = 5;
static final int backgroundColor = 222;
static int tutorialWait = 0;

int keyOffset = 36;
Player playplay;
TutorialPage tutorialPage;
PrintWriter output, midiRecord;
Buttons buttons;
File recordFile;
Timer timer, playerTimer;
int state, textBackground = 240;
boolean recording = false, clicked = false, saved = false;
String msg = "";
Piano piano;
PFont myFont;
ArrayList<Integer> notes = new ArrayList<Integer>();
ArrayList<Integer> chords = new ArrayList<Integer>();
ArrayList<Boolean> playing = new ArrayList<Boolean>();
ArrayList<String> temporaryRecord = new ArrayList<String>();
ArrayList<String> notePitches = new ArrayList<String>();
Serial port;
MidiBus myBus;

/*******************************************/
Synthesizer  synth;
// the MidiChannels of the synth.
MidiChannel[] channels;

// constants to refer to the channels we are going to put our instruments on.
int PIANO_CHANNEL = 0;

/*******************************************/

Minim minim;
AudioOutput out;

void setup() {


  /*******************************************/
  try
  {
    synth = MidiSystem.getSynthesizer();
    synth.open();
    Soundbank sounds = MidiSystem.getSoundbank( createInput("TimGM6mb.sf2") );
    synth.loadAllInstruments( sounds );
    channels = synth.getChannels();
    // for a list of general midi instrument program numbers, see: http://www.midi.org/techspecs/gm1sound.php
    channels[PIANO_CHANNEL].programChange( 0 ); // should be "electric piano 1"
  }
  catch( Exception ex )
  {
    // oops there wasn't one.
    println( "No default synthesizer, sorry bud." , ex.toString());
  } 
  /*******************************************/
  
  timer = new Timer();
  playerTimer = new Timer();
  buttons = new Buttons();
  playing.add(false);
  tutorialPage = new TutorialPage();
  background(backgroundColor);
  minim = new Minim(this);
  out = minim.getLineOut();
  populateNote();

  String[] lines = loadStrings("db.txt");
  
  if(lines == null || lines.length == 0){
    state = SETUP_STATE; // SETUP STATE
    output = createWriter("db.txt"); 
  }
  else{
    state = MODE_SELECTION_STATE;
    piano = new Piano(Integer.parseInt(lines[0]));
    myBus = new MidiBus(this, 0, 1);
  }
  fullScreen();
  //printArray(Serial.list());
  //port = new Serial(this, Serial.list()[4], 9600);
  //MidiBus.list();
}

void draw() {

  switch(state) {

    case SETUP_STATE:
      setupState();
      break;

    case READY_STATE:
      readyState();
      break;

    case RECORD_STATE:
      recordState();
      break;

    case TUTORIAL_STATE:
      tutorialState();
      break;

    case SETTINGS_STATE:
      settingState();
      break;

    case MODE_SELECTION_STATE:
      modeSelectionState();
      break;
  }
}

void setupState(){
  
  pushMatrix();
  background(backgroundColor);
  myFont = createFont("Tahoma", 32);
  textFont(myFont);
  textSize(32);
  fill(0);
  textAlign(CENTER);
  text("How many keys your piano have? ", width/2, height/2 - 100); 
  textInputDiv();
  popMatrix();

}

void readyState(){
  
  pushMatrix();
  piano.show();
  popMatrix();
}

void recordState(){

  pushMatrix();
  background(backgroundColor);
  
  if(!playing.get(0)){
    buttons.playButton();
  }
  else{
    buttons.pauseButton();
  }

  if(playing.get(0))
    playplay.playRecord(playerTimer.getElapsedTime(), piano.states, playerTimer, timer, playing);
    
  if(!recording)
    buttons.startRecordButton();
  else
    buttons.stopRecordButton();
  
  buttons.backButton();
  buttons.saveButton();
  buttons.deleteButton();
  recordTimer();
  piano.show();
  popMatrix();
}

void tutorialState(){

  pushMatrix();
  background(backgroundColor);

  if(tutorialPage.trackSelected == -1){
    tutorialPage.show();
  }
  else{
    piano.show("TUTORIAL");
  }

  buttons.backButton();
  popMatrix();
}

void settingState(){
  // piano key count should be changed
  // maybe background colors can be changed
  // Sounds of the piano can be changed????????*
}

void modeSelectionState(){

  background(backgroundColor);
  buttons.tutorialButton();
  buttons.recordButton();
}

void textInputDiv(){

  pushMatrix();
  rectMode(CENTER);
  noStroke();
  fill(textBackground);
  rect(width/2, height/2, width/10, height/10, 10);
  
  if(clicked){

    rectMode(CORNER);
    
    translate(width/2 - width/20, height/2 - height/20);

    myFont = createFont("Tahoma", 72);
    textFont(myFont);
    fill(0);
    //textAlign(CENTER);
    text(msg, width/20, height/15 ); 

    if(frameCount % 5 == 0){
      fill(0);
      delay(250);
    }
    else{
      fill(200);
      delay(250);
    }

    if(msg.length() == 0)
      rect(10,10,10,height/10-20);
  }
  popMatrix();
}

void mousePressed(){
  
  if(state == SETUP_STATE){
    if(width/2 - width/20 < mouseX && mouseX < width/2 + width/20 && height/2 - height/20 < mouseY && mouseY < height/2 + height/20 ){
      textBackground = 200;
      clicked = true;
    }
  }
  // else {
  //     clicked = false;
  // }

  if(state == MODE_SELECTION_STATE){

    if(width * 0.1 < mouseX && mouseX < width * 0.45 && height * 0.5 - (width * 0.175) < mouseY && mouseY < height * 0.5 + (width * 0.175)){
      state = TUTORIAL_STATE;
      tutorialWait = frameCount;

    }

    if(width * 0.55 < mouseX && mouseX < width * 0.9 && height * 0.5 - (width * 0.175) < mouseY && mouseY < height * 0.5 + (width * 0.175)){
      state = RECORD_STATE;
    }
  }

  if(state == RECORD_STATE || state == TUTORIAL_STATE){

    if(width / 50 < mouseX && mouseX < width / 50 + width / 25 && width / 50 < mouseY && mouseY < width / 50 + width / 25){
      if(state == TUTORIAL_STATE)
        if(tutorialPage.trackSelected != -1)
          tutorialPage.trackSelected = -1;
        else
          state = MODE_SELECTION_STATE;
      else
        state = MODE_SELECTION_STATE;
    }
  }

  if(state == RECORD_STATE ){

    if(!recording){
      if(width * 0.5 - width * 0.025 < mouseX && mouseX < width * 0.5 + width * 0.025 && height * 0.1 - width * 0.025 < mouseY && mouseY < height * 0.1 + width * 0.025){
        recording = true;
        saved = false;
        timer.start();
      }
    }
    else{
      if(width * 0.5 - width * 0.025 < mouseX && mouseX < width * 0.5 + width * 0.025 && height * 0.1 - width * 0.025 < mouseY && mouseY < height * 0.1 + width * 0.025){
        recording = false;
        timer.stop();
        //midiRecord.flush();
        //midiRecord.close();
      }
    }

    if(buttons.isSaveButtonPressed()){
      if(temporaryRecord.size() > 0 && !saved){
        
        recordFile = new File(sketchPath() + "/records");
        String[] listPath = recordFile.list();
        boolean saveable = true;

        do{
          String recordFilename = showInputDialog("Please name your masterpiece");
          
          if(recordFilename == null)
            break;

          for(int i = 0 ; i < listPath.length ; i++){
            
            if(recordFilename.equals(listPath[i].substring(0,listPath[i].indexOf(".")))){
              saveable = false;
            }

          }

          if(saveable){ 
            midiRecord = createWriter("./records/" + recordFilename + ".txt"); 

            for(String recordLines : temporaryRecord){
              midiRecord.println(recordLines);
            }
            saved = true;
            midiRecord.flush();
            midiRecord.close();
          }
        }
        while(!saveable);
      }
      else if(temporaryRecord.size() == 0 && !saved){
        showMessageDialog(null,"Record is empty!");
      }

    }

    if(buttons.isPlayPauseButtonPressed()){
      
      if(!playing.get(0)){
        if(temporaryRecord.size() >= 0){
          ArrayList<String> playableCopy = new ArrayList<String>(temporaryRecord);
          playplay = new Player(playableCopy);
          playerTimer.start();
          timer.start();
          playing.set(0, true); 
        }
      }
      else{
        timer.stop();
        playerTimer.stop();
        for(int i = 0 ; i < piano.states.size() ; i++){
          piano.states.set(i,false);
        }
        playing.set(0,false);
      }
    }

    if(buttons.isDeleteButtonPressed()){

      if(!playing.get(0) && temporaryRecord.size() >= 0){
        
        playerTimer.reset();
        timer.reset();
        temporaryRecord.clear(); 
      }
    }
  }
}

void keyPressed(){

  if(clicked){
    
    if ((key>='0' && key<='9') && msg.length() < 3)
      msg += key;
    
    if(key == BACKSPACE && msg.length() > 0 )
      msg = msg.substring(0,msg.length()-1);

    if(key == ENTER){
      state = MODE_SELECTION_STATE;
      output.print(msg);
      output.flush();
      output.close();
      setup();
    }
  }
}

void recordTimer(){

  pushMatrix();

  myFont = createFont("Tahoma", 100);
  textFont(myFont);
  fill(0);
  textAlign(CENTER);
  
  if(timer.getElapsedTime() > 0){
    timer.showTime();
  }
  
  popMatrix();
}

void midiMessage(MidiMessage message) {

  if(state == READY_STATE || state == TUTORIAL_STATE || state == RECORD_STATE){

    int note = (int)(message.getMessage()[1] & 0xFF);
    int vel = (int)(message.getMessage()[2] & 0xFF);
  
    float velValue = vel * 1.0 / 127;

    //port.write(Integer.toString(note-offset));
    // write any charcter that marks the end of a number
    //port.write('e');
    
    if (keyOffset <= note && note <= keyOffset + piano.keyCount) {

      if (vel > 0 ) {

        piano.states.set(note-keyOffset, true);

        if(recording){
          String noteInfo = Integer.toString(note-keyOffset) + " " + Float.toString(timer.getElapsedTime() * 0.001)  + " P";
          //midiRecord.println(noteInfo);
          
          temporaryRecord.add(noteInfo);
        }

        String strNote = "";

        strNote = notePitches.get((note-keyOffset) % 12) + (((note-keyOffset) / 12) + 2); 
        note( 0, 2.5, PIANO_CHANNEL, strNote, velValue );
        //out.playNote(strNote);
        //states.set(note-keyOffset, true);

        //port.write(Integer.toString(12 - ((note-keyOffset))));
        // write any charcter that marks the end of a number
        //port.write('e');
      } else {

        piano.states.set(note-keyOffset, false);
        
        if(recording){
          String noteInfo = Integer.toString(note-keyOffset) + " " + Float.toString(timer.getElapsedTime() * 0.001) + " R";
          //midiRecord.println(noteInfo);
          temporaryRecord.add(noteInfo);
        }
        //out.resumeNotes();
        
        // port.write(Integer.toString((12 - ((note-keyOffset)))*2));
        // // write any charcter that marks the end of a number
        // port.write('e');
      }
    }
  }
}

void populateNote(){
  
  notePitches.add("C");
  notePitches.add("C#");
  notePitches.add("D");
  notePitches.add("D#");
  notePitches.add("E");
  notePitches.add("F");
  notePitches.add("F#");
  notePitches.add("G");
  notePitches.add("G#");
  notePitches.add("A");
  notePitches.add("A#");
  notePitches.add("B");
}

void note( float time, float duration, int channelIndex, String noteName, float velocity )
{
  out.playNote( time, duration, new MidiSynth( channelIndex, noteName, velocity ) );
}

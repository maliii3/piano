import themidibus.*; //Import the library
import javax.sound.midi.MidiMessage;
import processing.serial.*;


static final int SETUP_STATE = 0;
static final int READY_STATE = 1;
static final int RECORD_STATE = 2;
static final int TUTORIAL_STATE = 3;
static final int SETTINGS_STATE = 4;
static final int MODE_SELECTION_STATE = 5;

	
PrintWriter output;
PImage tutorialImage;
PImage recordImage;
PImage backImage;

int state;
String msg = "" ;
Piano piano;
int pianoKeyCount;
boolean clicked = false;
PFont myFont;
int anannnn = 222;
ArrayList<Integer> notes = new ArrayList<Integer>();
ArrayList<Integer> chords = new ArrayList<Integer>();
ArrayList<ArrayList<Integer> > upcoming= new ArrayList<ArrayList<Integer> >();

Serial port;
MidiBus myBus;

int currentColor = 0;
int midiDevice  = 0;

void setup() {
  

  tutorialImage = loadImage("tutorial.png");
  recordImage = loadImage("record.png");
  backImage = loadImage("back.png");

  background(204);
  
  String[] lines = loadStrings("db.txt");
  
 if(lines == null || lines.length == 0){
   state = SETUP_STATE; // SETUP STATE
    output = createWriter("db.txt"); 
   
 }
 else{
    state = READY_STATE;

    pianoKeyCount = Integer.parseInt(lines[0]);
    
    piano = new Piano(pianoKeyCount);
  
    println(this.piano.pianoWidth);
    println(this.piano.pianoHeight);

    myBus = new MidiBus(this, midiDevice, 1);
 }
  fullScreen();
  //printArray(Serial.list());
  //port = new Serial(this, Serial.list()[4], 9600);
  //MidiBus.list();
}


void draw() {

    switch(state) {
 
        case SETUP_STATE:
        //
            setupState();
            break;
 
        case READY_STATE:
        //
            readyState();
            break;
 
        case RECORD_STATE:
        //
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

 
    }//switch
  
  

  // if (upcoming.size() > 0) {

  //   if (upcoming.get(0).size() > 0) {
  //     ArrayList<Integer> currentChord = upcoming.get(0);

  //     for (int note : currentChord) {
  //       states.set(note-48, true);

  //       port.write(Integer.toString(12 - ((note-48))));
  //       // write any charcter that marks the end of a number
  //       port.write('e');
  //     }
  //   } else {
     
  //     upcoming.remove(0);
  //     delay(1000);
  //   }
  // }
}

void setupState(){
    
    myFont = createFont("Tahoma", 32);
    textFont(myFont);
    textSize(32);
    fill(0);
    textAlign(CENTER);
    text("How many keys your piano have?: ", width/2, height/2 - 100); 
    textInputDiv();

}

void readyState(){
  
  stroke(1);
  //rectMode(CENTER);

  float scaleValue = width * 1.0 / piano.pianoWidth;
  
  if(piano.pianoWidth > width){
    
    translate(width / 2 - piano.pianoWidth * scaleValue / 2, height / 2 - (piano.pianoHeight * scaleValue) / 2);
    scale(scaleValue);
  }
  else {
    translate(width / 2 - piano.pianoWidth / 2, height / 2 - piano.pianoHeight / 2);
  }
  
  for (int j = 0; j < piano.keyCount ; j++) {
    for(int a = 0; a < piano.octaveCount + 1 ; a++){
      if (j != 1 + a * 12 || j != 3 + a * 12 || j != 6 + a * 12 ||j != 8 + a * 12 || j != 10 + a * 12 )
        piano.keys.get(j).show(piano.states.get(j));
    }
  }

  for (int k = 0; k < piano.keyCount; k++) {
    for(int b = 0; b < piano.octaveCount + 1 ; b++){
      if (k == 1 + b * 12 || k == 3 + b * 12 || k == 6 + b * 12 ||k == 8 + b * 12 || k == 10 + b * 12 )
        piano.keys.get(k).show(piano.states.get(k));
    }
  }
}

void recordState(){

  pushMatrix();
  background(204);
  myFont = createFont("Tahoma", 100);
  textFont(myFont);
  fill(0);
  textAlign(CENTER);
  text("RECORD STATE", width/2, height/2);
  backButton();
  popMatrix();

}

void tutorialState(){

  pushMatrix();
  background(204);
  myFont = createFont("Tahoma", 100);
  textFont(myFont);
  fill(0);
  textAlign(CENTER);
  text("TUTORIAL STATE", width/2, height/2); 
  backButton();
  popMatrix();
  
}

void settingState(){
  // SETTING SHOULD BE CHANGED LATER ON WE WILL DEAL WITH IT RIGHT HERE


}

void modeSelectionState(){

  //print("state is: Mode Selection");
  // IN THIS FUNCTION USER WILL CHOOSE THE MODE TYPE (RECORD OR TUTORIAL)
  background(204);
  tutorialButton();
  recordButton();
}

void textInputDiv(){

    rectMode(CENTER);
    noStroke();
    fill(anannnn);
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

        rect(10,10,10,height/10-20);
    }
}

void mousePressed(){
  
  if(state == SETUP_STATE){
    if(width/2 - width/20 < mouseX && mouseX < width/2 + width/20 && height/2 - height/20 < mouseY && mouseY < height/2 + height/20 ){
        anannnn = 200;
        clicked = true;
    }
  }
  // else {
  //     clicked = false;
  // }

  if(state == MODE_SELECTION_STATE){

    if(width * 0.1 < mouseX && mouseX < width * 0.45 && height * 0.5 - (width * 0.175) < mouseY && mouseY < height * 0.5 + (width * 0.175)){
      state = TUTORIAL_STATE;
    }

    if(width * 0.55 < mouseX && mouseX < width * 0.9 && height * 0.5 - (width * 0.175) < mouseY && mouseY < height * 0.5 + (width * 0.175)){
      state = RECORD_STATE;
    }
  }

  if(state == RECORD_STATE || state == TUTORIAL_STATE){

    if(width / 50 < mouseX && mouseX < width / 50 + width / 25 && width / 50 < mouseY && mouseY < width / 50 + width / 25){

      state = MODE_SELECTION_STATE;
    }
  }
}

void keyPressed(){
  if(clicked){
    //Detects only alphanumeric chars
    if ((key>='0' && key<='9') && msg.length() < 2) {
        msg+=key;
    }
    if(key == BACKSPACE && msg.length() > 0 ){

        msg = msg.substring(0,msg.length()-1);
    }

    if(key == ENTER){
        state = MODE_SELECTION_STATE;
        output.print(msg);
        output.flush();
        output.close();
        setup();
    }
  }
}

void tutorialButton(){

  pushMatrix();
  rectMode(CORNER);
  fill(150);
  noStroke();
  rect(width * 0.1 , height * 0.5 - (width * 0.175) , width * 0.35 , width * 0.35 , width / 100);
  translate(width * 0.1 , height * 0.5 - (width * 0.175));
  imageMode(CENTER);
  float imageScaleValue = width * 0.30 / tutorialImage.width;
  image(tutorialImage, width * 0.175, width * 0.175, width * 0.30, tutorialImage.height * imageScaleValue);
  popMatrix();

}


void recordButton(){

  pushMatrix();
  rectMode(CORNER);
  fill(150);
  noStroke();
  rect(width * 0.55 , height * 0.5 - (width * 0.175), width * 0.35 , width * 0.35 , width / 100 );
  translate(width * 0.55 , height * 0.5 - (width * 0.175));
  imageMode(CENTER);
  float imageScaleValue = width * 0.20 / recordImage.width;
  image(recordImage, width * 0.175 , width * 0.175, width * 0.20, recordImage.height * imageScaleValue);
  popMatrix();

}

void backButton(){

  pushMatrix();
  fill(204);
  noStroke();
  rectMode(CENTER);
  rect(width / 25, width / 25, width/25 , width/25);
  translate(width / 25, width / 25);
  imageMode(CENTER);
  image(backImage, 0, 0 , width / 25, width / 25 );
  popMatrix();
}

void midiMessage(MidiMessage message) {

  if(state == READY_STATE){

    int note = (int)(message.getMessage()[1] & 0xFF) ;
    int vel = (int)(message.getMessage()[2] & 0xFF);

    //port.write(Integer.toString(note-36));
    // write any charcter that marks the end of a number
    //port.write('e');

    if (48 <= note && note <= 48 + piano.keyCount) {



      if (vel > 0 ) {

        piano.states.set(note-48, true);

        // if (upcoming.size() > 0) {
        //   if (upcoming.get(0).size() > 0) {
        //     ArrayList<Integer> currentChord = upcoming.get(0);



        //     for (int i = currentChord.size()-1; i >=0; i--) {

        //       if (currentChord.get(i) == note) {
        //         println(note, " için girdim");
              
        //         states.set(note-48, false);
        //         port.write(Integer.toString((12 - ((note-48)))*2));
        //         // write any charcter that marks the end of a number
        //         port.write('e');
              
        //         currentChord.remove(i);
        //       }
        //     }
        //   }
        // }

        //states.set(note-48, true);

        //port.write(Integer.toString(12 - ((note-48))));
        // write any charcter that marks the end of a number
        //port.write('e');
      } else {

        piano.states.set(note-48, false);
        // port.write(Integer.toString((12 - ((note-48)))*2));
        // // write any charcter that marks the end of a number
        // port.write('e');
      }
    }
  }
}

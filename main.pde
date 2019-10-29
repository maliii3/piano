import themidibus.*; //Import the library
import javax.sound.midi.MidiMessage;
import processing.serial.*;


static final int SETUP_STATE = 0;
static final int READY_STATE = 1;
static final int RECORD_STATE = 2;
static final int TUTORIAL_STATE = 3;
static final int SETTINGS_STATE = 4;

	
PrintWriter output;
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
  translate(width / 2 - piano.pianoWidth / 2, height / 2 - piano.pianoHeight / 2);
  
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



}

void tutorialState(){



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
        state = READY_STATE;
        output.print(msg);
        output.flush();
        output.close();
        setup();
    }
  }
}


// void midiMessage(MidiMessage message) {
//   int note = (int)(message.getMessage()[1] & 0xFF) ;
//   int vel = (int)(message.getMessage()[2] & 0xFF);

//   //port.write(Integer.toString(note-36));
//   // write any charcter that marks the end of a number
//   //port.write('e');

//   if (48 <= note && note <= 71) {



//     if (vel > 0 ) {



//       if (upcoming.size() > 0) {
//         if (upcoming.get(0).size() > 0) {
//           ArrayList<Integer> currentChord = upcoming.get(0);



//           for (int i = currentChord.size()-1; i >=0; i--) {

//             if (currentChord.get(i) == note) {
//               println(note, " için girdim");
             
//               states.set(note-48, false);
//               port.write(Integer.toString((12 - ((note-48)))*2));
//               // write any charcter that marks the end of a number
//               port.write('e');
             
//               currentChord.remove(i);
//             }
//           }
//         }
//       }

//       //states.set(note-48, true);

//       //port.write(Integer.toString(12 - ((note-48))));
//       // write any charcter that marks the end of a number
//       //port.write('e');
//     } else {

//       states.set(note-48, false);
//       port.write(Integer.toString((12 - ((note-48)))*2));
//       // write any charcter that marks the end of a number
//       port.write('e');
//     }
//   }
// }

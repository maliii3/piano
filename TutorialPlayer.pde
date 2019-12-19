class TutorialPlayer{

  Record currentRecord;
  ArrayList<String> sequentialChords;

  TutorialPlayer(Record record){
    this.currentRecord = new Record(record);
    this.sequentialChords = new ArrayList<String>();
    this.parseRecord();
  }

  void parseRecord(){

    String keys = "";
    String lastAction = "?";

    while(this.currentRecord.playableLines.size() > 0){

      String line = this.currentRecord.playableLines.get(0);

      int index = line.indexOf(" ");
      int index2 = line.indexOf(" ",index+1);
      
      String noteValue = line.substring(0, index);
      float noteTime = float(line.substring(index + 1, index2));
      String noteType = line.substring(index2 + 1);

      if(noteType.contains("R") && lastAction.contains("P")){
        sequentialChords.add(keys.substring(0, keys.length() - 1));
        keys = "";
      }
      else if (noteType.contains("P")){
        keys += noteValue + ";";
      }
      this.currentRecord.playableLines.remove(0);
      lastAction = noteType;
    }
  }

  void simulateKeys(ArrayList<Boolean> states){

    if(this.sequentialChords.size() > 0){
      String[] currentNotes = this.sequentialChords.get(0).split(";");
      for(String strNote : currentNotes){
        int note = Integer.parseInt(strNote);
        states.set(note, true);
      }
    }
  }

  void checkAllKeys(ArrayList<Boolean> states,ArrayList<Integer> pressedKeys){

    ArrayList<Integer> chordNotes = new ArrayList<Integer>();
    if(this.sequentialChords.size() > 0){

      java.util.Collections.sort(pressedKeys);
      
      
      String[] currentNotes = this.sequentialChords.get(0).split(";");
      for(String strNote : currentNotes){
        int note = Integer.parseInt(strNote);
        chordNotes.add(note);
        states.set(note, true);
      }

      java.util.Collections.sort(chordNotes); 
      
      if(chordNotes.equals(pressedKeys) && frameCount % 5 == 0 ){
        for(int note : chordNotes){
          states.set(note,false);
        }
        this.sequentialChords.remove(0);
      }
    }
  }
}

class Player{
    
  String[] lines;
  String filename;
  PrintWriter playableRecord;
  ArrayList<String> playableLines;

  Player(String path){
    this.filename = path;
    this.lines = loadStrings("./records/" + path);
    this.playableLines = new ArrayList<String>();

    for(int i = 0 ; lines != null && i < lines.length ; i++){
      this.playableLines.add(lines[i]);
    }
  }

  Player(ArrayList<String> currentLines){

    this.playableLines = currentLines;
  }

  // void sortRecord(){

  //   playableRecord = createWriter("./playables/" + this.filename);
  //   ArrayList<String> notes = new ArrayList<String>();
  //   ArrayList<String> noteInfos = new ArrayList<String>();
  //   ArrayList<String> notesRemaining = new ArrayList<String>();
    
  //   for(String line : this.lines){
      
  //     int index = line.indexOf(" ");
  //     int index2 = line.indexOf(" ",index+1);
  //     String noteValue = line.substring(0, index);
  //     String noteTime = line.substring(index + 1, index2);
      
  //     if(notes.size() > 0){
        
  //       if(notes.contains(noteValue)){
  //         String res= "";
  //         float timeEnd = float(noteTime);
  //         int indexNote = notes.indexOf(noteValue);
  //         float timeStart = float(noteInfos.get(indexNote));
  //         res = noteInfos.get(indexNote) + " " + noteValue + " " + str(timeEnd-timeStart);
  //         notesRemaining.add(res);
  //         notes.remove(indexNote);
  //         noteInfos.remove(indexNote);
  //       }
  //       else {
  //         notes.add(noteValue);
  //         noteInfos.add(noteTime);
  //       }

  //     }
  //     else {
  //       notes.add(noteValue);
  //       noteInfos.add(noteTime);
  //     }
  //   }
    
  //   java.util.Collections.sort(notesRemaining);
    

  //   playableRecord.close();
  //   playableRecord.flush();

  // }

  void playRecord(int currentTime, ArrayList<Boolean> states, Timer timer, Timer general, ArrayList<Boolean> playing ){

    if(this.playableLines.size() > 0){

      String line = this.playableLines.get(0);

      int index = line.indexOf(" ");
      int index2 = line.indexOf(" ",index+1);
      int noteValue = int(line.substring(0, index));
      float noteTime = float(line.substring(index + 1, index2));
      String noteType = line.substring(index2 + 1);

      if((currentTime * 0.001) >= noteTime ){
        if(noteType.contains("P")){
          states.set(noteValue,true);
        }
        else{
          states.set(noteValue,false);
        }
        this.playableLines.remove(0);
      }
    }
    else{
      timer.stop();
      general.stop();
      for(int i = 0 ; i < states.size() ; i++){
        states.set(i,false);
      }
      playing.set(0,false);
    }
  }
}
class Player{
    
  String[] lines;

  Player(String path){

    this.lines = loadStrings(path);
  }


  void sortRecord(){

    ArrayList<String> notes = new ArrayList<String>();
    ArrayList<String> noteInfos = new ArrayList<String>();

    for(String line : this.lines){

      String noteValue = line.substring(0, line.indexOf(" "));

      if(currentNodes.size() > 0){
        if(notes.contains(noteValue)){


        }
        else{
          notes.add(noteValue);
        }
      }
      else{
        notes.add(noteValue);
        noteInfos.add(line);
      }
      

    }

  }

  void playRecord(){



  }

}
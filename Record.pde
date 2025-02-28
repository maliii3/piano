class Record{

  String name;
  String duration;
  String description;
  String creator;
  String difficulty;
  ArrayList<String> playableLines;
  PFont myFont;

  Record(String path){

    this.name = path.substring(0,path.indexOf("."));
    String[] lines = loadStrings("./records/" + path);
    this.playableLines = new ArrayList<String>();
    
    for(int i = 0 ; lines != null && i < lines.length ; i++){
      this.playableLines.add(lines[i]);
    }

    float numericDuration = float(lines[lines.length-1].split(" ")[1]) - float(lines[0].split(" ")[1]);
    String seconds = numericDuration % 60 < 10 ? "0" + Integer.toString(int(numericDuration % 60)) : Integer.toString(int(numericDuration % 60));
    String minutes = numericDuration / (60) % 60 < 10 ? "0" +  Integer.toString(int(numericDuration / (60) % 60)) : Integer.toString(int(numericDuration / (60) % 60));
    String hours = Integer.toString(int(numericDuration / (60*60) % 24));

    this.duration = hours + ":" + minutes + ":" + seconds;
  }

  Record(Record rec){
    this.name = rec.name;
    this.duration = rec.duration;
    this.playableLines = rec.playableLines;
  }

  void show(int index){

    pushMatrix();
    rectMode(CORNER);
    fill(242);
    noStroke();
    rect(((width * 0.5) - ((width * 0.9)/ 2)) , (height * 0.25 + (index * height * 0.20)) - ((height * 0.19) / 2), (width * 0.9), (height * 0.19), (width * 0.01));
    this.myFont = createFont("Tahoma", 32);
    textFont(myFont);
    textSize(32);
    fill(0);
    textAlign(LEFT);
    translate((width * 0.01) , (height * 0.125 + (index * height * 0.20)));
    text("Name: " + this.name, 100, 100);
    text("Duration: " + this.duration, 100, 150); 
    popMatrix();
  }

  int isSelected(int index){
    
    if(((width * 0.05)) <= mouseX && mouseX <= (width * 0.9) && (height * 0.25 + (index * height * 0.20)) - ((height * 0.19) / 2) <= mouseY && mouseY <= (height * 0.25 + (index * height * 0.20)) + ((height * 0.19) / 2) )
      return index;
    else
      return -1;
  
  }

}
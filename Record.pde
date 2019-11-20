class Record{

  String name;
  String duration;
  String description;
  String creator;
  String difficulty;
  PFont myFont;

  Record(String path){

    this.name = path.substring(0,path.indexOf("."));
    String[] lines = loadStrings("./records/" + path);

    float numericDuration = float(lines[lines.length-1].split(" ")[1]) - float(lines[0].split(" ")[1]);
    String seconds = numericDuration % 60 < 10 ? "0" + Integer.toString(int(numericDuration % 60)) : Integer.toString(int(numericDuration % 60));
    String minutes = numericDuration / (60) % 60 < 10 ? "0" +  Integer.toString(int(numericDuration / (60) % 60)) : Integer.toString(int(numericDuration / (60) % 60));
    String hours = Integer.toString(int(numericDuration / (60*60) % 24));

    this.duration = hours + ":" + minutes + ":" + seconds;
  }

  void show(int index){

    pushMatrix();
    rectMode(CENTER);
    fill(242);
    noStroke();
    rect((width * 0.5) , (height * 0.25 + (index * height * 0.20)), (width * 0.9), (height * 0.19), (width * 0.01));
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

//   int select(){
    
//   }
}
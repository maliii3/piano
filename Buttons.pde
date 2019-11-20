class Buttons{

  PImage tutorialImage;
  PImage recordImage;
  PImage backImage;
  PImage startRecordImage;
  PImage stopRecordImage;
  PImage playImage;
  PImage deleteImage;
  PImage saveImage;
  PImage pauseImage;

  Buttons(){

    this.startRecordImage = loadImage("./images/startRecord.png");
    this.stopRecordImage = loadImage("./images/stopRecord.png");
    this.tutorialImage = loadImage("./images/tutorial.png");
    this.recordImage = loadImage("./images/record.png");
    this.backImage = loadImage("./images/back.png");
    this.playImage = loadImage("./images/play.png");
    this.deleteImage = loadImage("./images/delete.png");
    this.saveImage = loadImage("./images/save.png");
    this.pauseImage = loadImage("./images/pause.png");
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
    image(this.tutorialImage, width * 0.175, width * 0.175, width * 0.30, tutorialImage.height * imageScaleValue);
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
    float imageScaleValue = width * 0.20 / startRecordImage.width;
    image(this.startRecordImage, width * 0.175 , width * 0.175, width * 0.20, startRecordImage.height * imageScaleValue);
    popMatrix();
  }

  void backButton(){

    pushMatrix();
    fill(204);
    noStroke();
    rectMode(CENTER);
    rect(width / 25, width / 25, width/25 , width/25);
    // translate(width / 25, width / 25);
    // translate(width / 25, width / 25);
    //imageMode(CENTER);
    image(this.backImage, width / 25, width / 25 , width / 25, width / 25 );
    popMatrix();
  }

  void startRecordButton(){

    pushMatrix();
    translate(width/2, height/10);
    float imageScaleValue = width * 0.05 / startRecordImage.width;
    image(this.startRecordImage, 0, 0, width * 0.05, startRecordImage.height * imageScaleValue);
    popMatrix();
  }

  void stopRecordButton(){

    pushMatrix();
    translate(width/2, height/10);
    float imageScaleValue = width * 0.05 / stopRecordImage.width;
    image(this.stopRecordImage, 0, 0, width * 0.05, stopRecordImage.height * imageScaleValue);
    popMatrix();
  }

  void playButton(){

    pushMatrix();
    translate(width * 0.42, height/10);
    float imageScaleValue = width * 0.05 / playImage.width;
    image(this.playImage, 0, 0, width * 0.05, playImage.height * imageScaleValue);
    popMatrix();
  }

  void pauseButton(){

    pushMatrix();
    translate(width * 0.42, height/10);
    float imageScaleValue = width * 0.05 / pauseImage.width;
    image(this.pauseImage, 0, 0, width * 0.05, pauseImage.height * imageScaleValue);
    popMatrix();
  }

  void deleteButton(){

    pushMatrix();
    translate(width * 0.34, height/10);
    float imageScaleValue = width * 0.05 / deleteImage.width;
    image(this.deleteImage, 0, 0, width * 0.05, deleteImage.height * imageScaleValue);
    popMatrix();
  }

  void saveButton(){

    pushMatrix();
    translate(width * 0.26, height/10);
    float imageScaleValue = width * 0.05 / saveImage.width;
    image(this.saveImage, 0, 0, width * 0.05, saveImage.height * imageScaleValue);
    popMatrix();
  }

  boolean isSaveButtonPressed(){

    return width * 0.26 - width * 0.025 < mouseX && mouseX < width * 0.26 + width * 0.025 && height * 0.1 - width * 0.025 < mouseY && mouseY < height * 0.1 + width * 0.025;

  }

  boolean isPlayPauseButtonPressed(){

    return width * 0.42 - width * 0.025 < mouseX && mouseX < width * 0.42 + width * 0.025 && height * 0.1 - width * 0.025 < mouseY && mouseY < height * 0.1 + width * 0.025;
  
  }

  boolean isDeleteButtonPressed(){

    return width * 0.34 - width * 0.025 < mouseX && mouseX < width * 0.34 + width * 0.025 && height * 0.1 - width * 0.025 < mouseY && mouseY < height * 0.1 + width * 0.025;

  }
}
class Timer {
  int startTime = 0, stopTime = 0;
  boolean running = false;  
    
    void start() {
        startTime = millis();
        running = true;
    }
    
    void stop() {
        stopTime = millis();
        running = false;
    }

    int getElapsedTime() {
        int elapsed;
        if (running) {
             elapsed = (millis() - startTime);
        }
        else {
            elapsed = (stopTime - startTime);
        }
        return elapsed;
    }

    String second(){
      return (getElapsedTime() / 1000) % 60 < 10 ? "0" + Integer.toString((getElapsedTime() / 1000) % 60) : Integer.toString((getElapsedTime() / 1000) % 60);
    }

    String minute() {
      return (getElapsedTime() / (1000*60)) % 60 < 10 ? "0" +  Integer.toString((getElapsedTime() / (1000*60)) % 60) : Integer.toString((getElapsedTime() / (1000*60)) % 60);
    }

    int hour() {
      return (getElapsedTime() / (1000*60*60)) % 24;
    }

    String timeStamp(){

      return Integer.toString(hour())+ ":" + minute() + ":" + second();

    }

    void showTime(){

      pushMatrix();
      //scale(0.7);
      text(timer.second(), width * 0.8 , height * 0.13);
      text(":", width * 0.75, height * 0.13);
      text(timer.minute(), width * 0.7, height * 0.13);
      text(":", width * 0.65, height * 0.13);
      text(timer.hour(), width * 0.62, height * 0.13);
      popMatrix();
    } 

    void reset(){

      this.startTime = 0;
      this.stopTime = 0;
    }
}

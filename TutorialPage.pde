import java.io.*;
import java.lang.*;

class TutorialPage{

  ArrayList<String> recordsFiles;
  ArrayList<Record> records;
  int currentPage;
  int offset;
  int trackSelected;
  File recordFolder;
  
  TutorialPage(){
    
    this.trackSelected = -1;
    this.currentPage = 0;
    this.recordFolder = new File(sketchPath() + "/records");
    this.records = new ArrayList<Record>();
    String[] listPath = recordFolder.list();
    if(listPath.length > 4){
      for(int i = 0 ; i < 4 ; i++){
        println(listPath[i]);
        this.records.add(new Record(listPath[i]));
      }
    }
    else{
      for(int i = 0 ; i < listPath.length ; i++ ){
        this.records.add(new Record(listPath[i]));
      }
    }
  }

  void show(){

    if(this.records.size() > 4){
      for(int i = 0 ; i < 4; i++){
        this.records.get(i).show(i);
        if(mousePressed && (frameCount - 1 > tutorialWait )){
          int currentSelectedTrack = this.records.get(i).isSelected(i);
          if(currentSelectedTrack != -1){
            this.trackSelected = currentSelectedTrack;
            break; 
          }
        }
      }
    }
    else{
      for(int i = 0 ; i < this.records.size(); i++){
        this.records.get(i).show(i);
        if(mousePressed && (frameCount - 1 > tutorialWait )){
          int currentSelectedTrack = this.records.get(i).isSelected(i);
          if(currentSelectedTrack != -1){
            this.trackSelected = currentSelectedTrack;
            break; 
          }
        }
      }
    }
    
  }

  // void nextPage(){
  //   this.currentPage++;
  //   this.records.clear();
    
  //   if(listPath.length > (4 * currentPage) ){
  //     for(int i = (currentPage - 1) * 4  ; i < (currentPage ) * 4 ; i++){
  //       Record tempRecord = new Record(listPath[i]);
  //       this.records.add(tempRecord);
  //     }
  //   }
  //   else{
  //     for(int i = (currentPage - 1) * 4 ; i < listPath.length ; i++ ){
  //       Record tempRecord = new Record(listPath[i]);
  //       this.records.add(tempRecord);
  //     }
  //   }
  // }

  // void previousPage(){
  //   this.currentPage--;
  // }

  // void loadData(int pageIndex){
    
  // }
  
}

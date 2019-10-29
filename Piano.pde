class Piano{

    int keyCount;
    int octaveCount;
    int remainderKeyCount;
    int pianoWidth;
    int pianoHeight;
    ArrayList<Key> keys;
    ArrayList<Boolean> states;
    ArrayList<Key> remainderKeys;

    Piano(int keyCount_){
        
        this.pianoWidth = 0;
        this.pianoHeight = 400;
        this.keyCount = keyCount_;
        this.keys = new ArrayList<Key>();
        this.states = new ArrayList<Boolean>();
        this.remainderKeys = new ArrayList<Key>();
        for(int i = 0 ; i < keyCount_ ; i++){
            this.states.add(false);
        }
        this.createKeysDynamically();
    }

    void createKeysDynamically(){

        this.octaveCount = this.keyCount / 12;
        int i;
        this.remainderKeyCount = this.keyCount - this.octaveCount * 12 ;
        for(i = 0 ; i < octaveCount ; i++){
            this.createOneOctaveKeys(i);
        }
        if(remainderKeyCount != 0){
            remainderKeys.add(new Key(0 + i * 490, 20, 70, 400, 255));
            remainderKeys.add(new Key(50 + i * 490, 20, 38, 250, 0));//1
            remainderKeys.add(new Key(70 + i * 490, 20, 70, 400, 255));
            remainderKeys.add(new Key(120 + i * 490, 20, 38, 250, 0));//3
            remainderKeys.add(new Key(140 + i * 490, 20, 70, 400, 255));
            remainderKeys.add(new Key(210 + i * 490, 20, 70, 400, 255));
            remainderKeys.add(new Key(260 + i * 490, 20, 38, 250, 0));//6
            remainderKeys.add(new Key(280 + i * 490, 20, 70, 400, 255));
            remainderKeys.add(new Key(330 + i * 490, 20, 38, 250, 0));//8
            remainderKeys.add(new Key(350 + i * 490, 20, 70, 400, 255));
            remainderKeys.add(new Key(400 + i * 490, 20, 38, 250, 0));//10
            remainderKeys.add(new Key(420 + i * 490, 20, 70, 400, 255)); 

            for(int k = 0 ; k < remainderKeyCount ; k++){

                if ( k != 1  && k != 3 && k != 6 && k != 8 && k != 10 ){
                    this.pianoWidth += 70;
                    println(k);
                }
                    
                keys.add(remainderKeys.get(k));
            }   
        }
    }

    void createOneOctaveKeys(int octaveIndex){

        keys.add(new Key(0 + octaveIndex * 490, 20, 70, 400, 255));
        keys.add(new Key(50 + octaveIndex * 490, 20, 38, 250, 0));//1
        keys.add(new Key(70 + octaveIndex * 490, 20, 70, 400, 255));
        keys.add(new Key(120 + octaveIndex * 490, 20, 38, 250, 0));//3
        keys.add(new Key(140 + octaveIndex * 490, 20, 70, 400, 255));
        keys.add(new Key(210 + octaveIndex * 490, 20, 70, 400, 255));
        keys.add(new Key(260 + octaveIndex * 490, 20, 38, 250, 0));//6
        keys.add(new Key(280 + octaveIndex * 490, 20, 70, 400, 255));
        keys.add(new Key(330 + octaveIndex * 490, 20, 38, 250, 0));//8
        keys.add(new Key(350 + octaveIndex * 490, 20, 70, 400, 255));
        keys.add(new Key(400 + octaveIndex * 490, 20, 38, 250, 0));//10
        keys.add(new Key(420 + octaveIndex * 490, 20, 70, 400, 255));

        this.pianoWidth += 490;
    }
}

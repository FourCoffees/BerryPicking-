#include "testApp.h"
void initiatePosition(Berry berries[], LadyBug bugs[],  int id);


//--------------------------------------------------------------
void testApp::setup(){	
	ofRegisterTouchEvents(this);
	ofxAccelerometer.setup();
    ofxiPhoneAlerts.addListener(this);
	//iPhoneSetOrientation(OFXIPHONE_ORIENTATION_LANDSCAPE_RIGHT);
	ofBackground(127,127,127);
    ofEnableAlphaBlending();
    
    
    backgroundImg.loadImage("background.png");
    descriptionImg.loadImage("directions5.png");
    StartBtn.loadImage("start3.png");
    timeFrameImg.loadImage("score_frame.png");
    scoreFrameImg.loadImage("score_frame.png");
    finalFrameImg.loadImage("final_frame.png");
    replayBtn.loadImage("replay_btn.png");
    credits.loadImage("creditsBtn.png");
    creditsDefault.loadImage("Default2.png");
    mainMenuBtn.loadImage("creditsBtn.png");
    
    
    font.loadFont("MarkerFelt.ttc", 16);
    fontBig.loadFont("MarkerFelt.ttc", 32);
    
    music.loadSound("lady.caf");
    musicMenu.loadSound("menu.caf");
    squish.loadSound("squish.caf");
    atmos.loadSound("atmos.caf");
    berryFx.loadSound("picked.caf");
    
    //initialize gameboard
    for(int i=0;i<8;i++) {
        for(int j=0;j<12;j++){
            GameBoad[i][j]=false;
        }
    }
    
    musicMenu.setLoop(true);
    musicMenu.play();

    
    collectedBerries =0;
    killedLadybugs = 0;
    
    GameStart = false;
    GameRestart=false;
    playonce=false;
    
}

//--------------------------------------------------------------
void testApp::update(){
   
}

//--------------------------------------------------------------
void testApp::draw(){
    
    backgroundImg.draw(0,0);
	
    //Initial screen with start button and description
    if(GameStart == false) {
        
        if(creditsShow==false) {
        
           descriptionImg.draw(ofGetWidth()/2 -descriptionImg.width/2, 90);
        
            StartBtn.draw(ofGetWidth()/2 - StartBtn.width/2,250);
        
            credits.draw(ofGetWidth() - credits.width -20, ofGetHeight() - credits.height -20); 
        
            boundingbox = font.getStringBoundingBox(" Credits", 0 ,0);
            font.drawString("credits", ofGetWidth() -(credits.width -20)/2 -boundingbox.width , ofGetHeight() - credits.height/2-15);
        
        }
        else {
            creditsDefault.draw(0,0);
        }
    }
    else{
        //Game Time on
        if(GameStart == true) {
        
            timeGaming= ofGetElapsedTimeMillis() - time1;
            
        
            if(timeGaming<30000){
        
                for(int i=0; i<numBerries; i++) {
                    berries[i].draw();
                    
                }
            
                for(int i=0; i<numLadyBugs; i++) {
                    ladybugs[i].draw();
                }
                
                timeFrameImg.draw(ofGetWidth() - timeFrameImg.width,420);
                font.drawString(ofToString(30 -timeGaming/1000,2), ofGetWidth() - timeFrameImg.width/2 - 20, 445);

                scoreFrameImg.draw(0,420);
                font.drawString(ofToString(collectedBerries), scoreFrameImg.width/2 - 20 , 445);
            }
            else {
                //Time's Up!
                if(playonce==false) {
                    music.stop();
                    musicMenu.setLoop(true);
                    musicMenu.play();
                    playonce=true;
                }
                
            
                finalFrameImg.draw(ofGetWidth()/2 - finalFrameImg.width/2,8);            
            
                boundingbox = fontBig.getStringBoundingBox("Times' Up!!", 0, 0);
                fontBig.drawString("Times' Up!!",ofGetWidth()/2 - boundingbox.width/2 , 60);
            
                boundingbox = font.getStringBoundingBox("Cramberries: 6666", 0 ,0);
                font.drawString("Cramberries:", ofGetWidth()/2 - boundingbox.width/3 , 110);
                
                fontBig.drawString(ofToString(collectedBerries), ofGetWidth()/2 + boundingbox.width/2, 110);
            
            
                boundingbox = font.getStringBoundingBox("Cramberries: 66", 0 ,0);
                font.drawString("Ladybugs:", ofGetWidth()/2 - boundingbox.width/3 , 180);
            
                fontBig.drawString(ofToString(-killedLadybugs), ofGetWidth()/2 + boundingbox.width/2, 180);
            
                music.stop();
            
                replayBtn.draw(ofGetWidth()/2 - replayBtn.width/2, 350);
                
                mainMenuBtn.draw(ofGetWidth() - mainMenuBtn.width, ofGetHeight() - mainMenuBtn.height -20);
                
                boundingbox = font.getStringBoundingBox("Back", 0 ,0);
                font.drawString("Back", ofGetWidth() - mainMenuBtn.width + boundingbox.width/2, ofGetHeight() - mainMenuBtn.height  + boundingbox.height/2);
                
             
                GameRestart=true;
        
            }
        }
    }
}

//--------------------------------------------------------------
void testApp::exit(){

}

//--------------------------------------------------------------
void testApp::touchDown(ofTouchEventArgs &touch){
    
      if(GameStart==false) {
          
          if(creditsShow == false ){  
              //Pressing the start button
              if(touch.x > ofGetWidth()/2 - StartBtn.width/2 && touch.x<ofGetWidth()/2 + StartBtn.width/2
                 && touch.y > 250 && touch.y< 250+StartBtn.height) {
            
                  GameStart=true;
            
                  musicMenu.stop();
                  music.setLoop(true);
                  music.play();
                  atmos.play();
            
                  for(int i=0; i<numBerries ; i++) {
                      berries[i].setup();
                  } 
            
                  for(int i=0; i<numLadyBugs ; i++) {
                      ladybugs[i].setup();
                  } 
            
                  for(int i=0; i<numBerries ; i++) {
                      berries[i].initiatePosition(&(GameBoad),i);
                  } 
                  
                  for(int i=0; i<numLadyBugs; i++) {
                      ladybugs[i].initiatePosition(&GameBoad, i );
                  }
                  
                 
                  
                time1= ofGetElapsedTimeMillis();

           
              }
    
              if(touch.x >( ofGetWidth() - credits.width -20) && touch.x <(ofGetWidth() -20) && touch.y > (ofGetHeight() - credits.height -20) && touch.y<(ofGetHeight()-20)) {
            
                  creditsShow = true;

              }
          }
          else {
              creditsShow=false;
          }
          
          
          
    }
    else {
        
        if(GameRestart==false){
          
            for(int i=0; i<numLadyBugs;i++) {
                
                int positionX, positionY;
                
                positionX=(int)ladybugs[i].posX*40;
                positionY=(int)ladybugs[i].posY*40;
                
                if(touch.x>positionX && touch.x<(positionX + ladybugs[i].img.width) && touch.y > positionY && touch.y<(positionY + ladybugs[i].img.height)) {
                    
                    squish.play();
                    
                    GameBoad[ladybugs[i].posX][ladybugs[i].posY] = false;
                    
                    ladybugs[i].visible=false;
                    killedLadybugs++;
                    ladybugs[i].initiatePosition(&GameBoad, i);
                }
            }
            
            for(int i=0;i<numBerries;i++){
                
                int positionX, positionY;
                
                positionX=(int)berries[i].posX*40;
                positionY=(int)berries[i].posY*40;
                
                if(touch.x > positionX && touch.x < (positionX + berries[i].img.width) 
                   && touch.y > positionY && touch.y <(positionY + berries[i].img.height)) {
                
                    // Case where berry has been picked!
                                       
                    berryFx.play();
                    
                    collectedBerries++;
                    GameBoad[berries[i].posX][berries[i].posY] = false;
                    
                    berries[i].visible=false;
                    
                    berries[i].initiatePosition(&GameBoad, i);
                    
                   
                }
            }
        }
        else { 
            if( touch.x >= (ofGetWidth()/2 - replayBtn.width/2) && touch.x <= (ofGetWidth()/2 + replayBtn.width/2)
               && touch.y >= 350 && touch.y <= (350+ replayBtn.height)) {
                               
                
                GameRestart=false;
                GameStart=true;
                time1= ofGetElapsedTimeMillis();
                collectedBerries=0;
                killedLadybugs=0;
              
                for(int i=0; i<numBerries;i++) {
                   berries[i].initiatePosition(&GameBoad,i);
                }
                for(int i=0;i<numLadyBugs;i++) {
                    ladybugs[i].initiatePosition(&GameBoad, i);
                }
                
                musicMenu.stop();
                music.play();
                atmos.play();
 
            }
            
            //go back to main menu 
            
            if(touch.x>(ofGetWidth() - mainMenuBtn.width) && touch.x<ofGetWidth() 
               && touch.y >(ofGetHeight() - mainMenuBtn.height) && touch.y<ofGetHeight()) {
                
                GameStart=false;
                
                collectedBerries=0;
                killedLadybugs=0;
                
                for(int i=0; i<numBerries ; i++) {
                    berries[i].setup();
                } 
                
                for(int i=0; i<numLadyBugs ; i++) {
                    ladybugs[i].setup();
                } 
                
                
                for(int i=0; i<numBerries;i++) {
                    berries[i].initiatePosition(&GameBoad,i);
                }
                for(int i=0;i<numLadyBugs;i++) {
                    ladybugs[i].initiatePosition(&GameBoad, i);
                }

            }
        }  
    
    }
}

//--------------------------------------------------------------
void testApp::touchMoved(ofTouchEventArgs &touch){

}

//--------------------------------------------------------------
void testApp::touchUp(ofTouchEventArgs &touch){

}

//--------------------------------------------------------------
void testApp::touchDoubleTap(ofTouchEventArgs &touch){

}

//--------------------------------------------------------------
void testApp::lostFocus(){

}

//--------------------------------------------------------------
void testApp::gotFocus(){

}

//--------------------------------------------------------------
void testApp::gotMemoryWarning(){

}

//--------------------------------------------------------------
void testApp::deviceOrientationChanged(int newOrientation){

}


//--------------------------------------------------------------
void testApp::touchCancelled(ofTouchEventArgs& args){

}


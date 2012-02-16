#pragma once

#include "ofMain.h"
#include "ofxiPhone.h"
#include "ofxiPhoneExtras.h"
#include "Berry.h"
#include "LadyBug.h"


#define numBerries 10
#define numLadyBugs 4


class testApp : public ofxiPhoneApp {
	
public:
	void setup();
	void update();
	void draw();
	void exit();
	
	void touchDown(ofTouchEventArgs &touch);
	void touchMoved(ofTouchEventArgs &touch);
	void touchUp(ofTouchEventArgs &touch);
	void touchDoubleTap(ofTouchEventArgs &touch);
	void touchCancelled(ofTouchEventArgs &touch);

	void lostFocus();
	void gotFocus();
	void gotMemoryWarning();
	void deviceOrientationChanged(int newOrientation);
    
    
    Berry berries[numBerries];
    LadyBug ladybugs[numLadyBugs];

    bool GameStart;
    bool isCapturedBerry[numBerries];
    bool GameRestart;
    bool playonce;
    bool creditsShow;
    
    ofImage backgroundImg;
    ofImage descriptionImg;
    ofImage StartBtn;
    ofImage timeFrameImg;
    ofImage scoreFrameImg;
    ofImage finalFrameImg;
    ofImage replayBtn;
    ofImage credits;
    ofImage creditsDefault;
    ofImage mainMenuBtn;
    
    ofTrueTypeFont font;
    ofTrueTypeFont fontBig;
    
    ofSoundPlayer music;
    ofSoundPlayer musicMenu;
    ofSoundPlayer squish;
    ofSoundPlayer atmos;
    ofSoundPlayer berryFx;
    
    float time1;
    float timeGaming;

       
    int collectedBerries;
    int killedLadybugs;
    
    ofRectangle boundingbox;
    
    char message[255];
    
    bool GameBoad[8][12];

    


};



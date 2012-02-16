#pragma once

#include "LadyBug.h"
#define numBerries 10
#define numLadyBugs 4



class Berry {
    
public: 
    int posX, posY;
    bool visible;
    int rotation;
    
    
    ofImage img;
    
    void setup() {
        
        visible=false;
        img.loadImage("berry.png");            
        
        posX= (int)(ofRandom(0,8));
        posY = (int)(ofRandom(0,10));
    }
    
    void draw() {
        
        float positionX, positionY;
        
        if(visible==true) {
            positionX=40*posX;
            positionY=40*posY;
            
            img.draw(positionX,positionY);
        }
    }
    
    void update(){
    }
    
   
    void initiatePosition(bool (*gameboard)[8][12], int id) {
      
        posX= (int)(ofRandom(0,8));
        posY = (int)(ofRandom(0,10));

        for(int i=0;i<8;i++) {
            for(int j=0;j<12;j++) {
                if((*gameboard)[i][j]==true) {
                    posX= (int)(ofRandom(0,8));
                    posY = (int)(ofRandom(0,10));
                }
                else {
                    (*gameboard)[i][j]=true;
                    visible=true;
                    break;
                }
            }
        }
        
    }
    
    
};




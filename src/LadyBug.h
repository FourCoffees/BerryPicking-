#pragma once

#define numBerries 10 
#define numLadyBugs 4



class LadyBug {
    
public:
    int posX, posY;
    float bottom, right;
    
    ofImage img;
    bool visible;
    
    
    void setup() {
        
        visible=false;
        img.loadImage("ladybug2.png");
        
        posX= (int)(ofRandom(0,8));
        posY = (int)(ofRandom(0,10));

        
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
    
    void draw() {
        float positionX, positionY;

        
        if(visible) {
            
            positionX=40*posX;
            positionY=40*posY;

            img.draw(positionX,positionY);
        }
        
    }
    
    
};



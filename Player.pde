class Player {
  
 int ypos;
 float rot;
 int[] candleLit = {1,0,0,0,0,0,0,0,0,0,0,0};
 int score;
 boolean winner;

 Player(int _ypos, float _rot) {
      ypos = _ypos;
      rot = _rot;
  
  if (debug) {
  for (int i = 0; i<numCandles; i++) {
  candleLit[i] = int(random(2));
  } 
  }
 }
 
 void playerCandles() {
     pushMatrix();
     translate(.5*(width-candleDisplay),ypos);
     rotate(rot);
     translate(-candleDisplay*(rot/PI),0);
     
   if (gameOn) {
     winner = false;
     
   for (int j = 0; j<numCandles; j++) {
   

    candles[j] = new Candle(candleSize, (j*(candleSize+padding)), 0);

    
      if(candleLit[j] == 1) {
       
      candles[j].display();
     
      
    if (lightDark == false) {  
      score++;
      textSize(30);
      textAlign(CENTER,CENTER);
 //     text("Light your candles!",candleDisplay/2,-(candleSize/2)-padding); 
    } else {
     score=score-2; 
     textSize(30);
     textAlign(CENTER,CENTER);
  //   text("Blow out your candles!",candleDisplay/2,-(candleSize/2)-padding); 
    }
    
    if (score<0) {
     score = 0; 
    }
    
    } else {
       candles[j].nodisplay(); 
      }
  }
    textSize(scoreSize);
    textAlign(CENTER, TOP);
    fill(255,255,255);
    text(str(score),candleDisplay/2,candleSize/2); 
    
    //if (score > winThreshold) {
 
    //  winner = true;
    //  gameOn = false;
    //  gameEnd = true;
    //}
   }
  if (winner == true) {
   text("WIN",candleDisplay/2,candleSize/2); 
  }
      popMatrix();
      
      
  if (gameEnd == true) {
   score = 0; 
  }
  
 }

void randomCandles() {
   for (int i = 0; i<numCandles; i++) {
  candleLit[i] = int(random(2));
  }  
}

}
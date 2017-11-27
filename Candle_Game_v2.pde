// timed version instead of score

import themidibus.*;

MidiBus myBus; // The MidiBus

boolean debug = true;

int numPlayers = 2;
int numCandles = 4;
int candleSize = 100;
float padding = candleSize/3;
int candleDisplay = int(candleSize + padding)*(numCandles-1);
int offset = 50;
int scoreSize = 50;
Candle candles[] = new Candle[numCandles];
Player players[] = new Player[numPlayers];
int winThreshold = 3000;

int flame = 1;

float randomTime = 10000;
int randomTimeOffset = 2000;

int gameLength = 60;
int gameTime;
int gameTimeDisplay;
boolean gameOn;
boolean gameEnd;
boolean winDisplay;

int color1;
int color2;
int color3;

float pulse;
float dx;
float amplitude = 50;
float pulseValue;
float turning;
int[] player1candles = {30,31,32,33}; // cc values of candles
int[] player2candles = {36,39,40,41};
int[] player1modelights = {60,61,62,63};
int[] player2modelights = {64,65,66,67};

int[] candleValues1 = new int[numCandles];
int[] candleValues2 = new int[numCandles];

boolean lightDark;
int switchMode = int(random(10000));
int currentTime;

void setup() {
   color1 = int(random(255));
   color2 = int(random(255));
   color3 = int(random(255));
// fullScreen();
  size(1000, 700);
  offset = int((width-candleDisplay)/2+candleSize/2);
  
  MidiBus.list();
  myBus = new MidiBus(this, "Teensy MIDI", "to Max 1");
  
    players[0] = new Player(candleSize+scoreSize, PI);
    players[1] = new Player(height-(candleSize+scoreSize), 0);

}

void draw() {
   turning += .02;
  background(0);
  strokeWeight(1);
  line(0,height/2,width,height/2);

pulseWave();
winner();

for (int i = 0;i<numPlayers;i++){

  players[i].playerCandles();
  }

  if (gameOn) {
 winDisplay = false;
    gameTimeDisplay = gameLength-int(((millis()-gameTime)/1000));
    
    for (int i = 0; i<numCandles;i++) {
     if (players[0].candleMode[i] == 1) {  
      myBus.sendNoteOn(1,player1modelights[i],100);
     } else {
      myBus.sendNoteOff(1,player1modelights[i],100);
      }
      
     if (players[1].candleMode[i] == 1) {  
      myBus.sendNoteOn(1,player2modelights[i],100);
     } else {
      myBus.sendNoteOff(1,player2modelights[i],100);
      }
      
    }
   
  if (millis()-currentTime > switchMode) {
    println("SWITCH");
    currentTime = millis();
    switchMode = int(random(randomTime))+randomTimeOffset; 
    lightDark = !lightDark;
  } 
  
    fill(color1,color2,color3,100);
  noStroke();
  rect(0,0,width,map(players[0].score,0,winThreshold,0,height/2));
  fill(color2,color3,color1,100);
  rect(0,map(players[1].score,0,winThreshold,height,height/2),width,map(players[1].score,0,winThreshold,height,height/2));

  pushMatrix();
     textSize(100+pulseValue);
     textAlign(CENTER,CENTER);
     translate(width/2,height/2);   
     rotate(turning%TWO_PI);
      fill(255,0,0); 
     
      text(str(gameTimeDisplay), 0,0);
  popMatrix();

if (gameTimeDisplay == 0) {
 gameOn = false;
 winDisplay = true;
 gameEnd = true;
} 
   
  
  }
  else {
    
  pushMatrix();
     textSize(75+pulseValue);
     textAlign(CENTER,CENTER);
     translate(width/2,height/2);   
     rotate(turning%TWO_PI);
     text("click to play",0,0); 
  popMatrix();
  }

}

void mousePressed() {
 if (debug) {
  for (int i = 0; i<numCandles; i++) {
  players[0].candleLit[i] = int(random(2));
  } 

    for (int i = 0; i<numCandles; i++) {
  players[1].candleLit[i] = int(random(2));
  }
  players[0].randomCandles();
  players[1].randomCandles();
 }
   if (gameOn == false) {
   gameOn = true; 
   lightDark = false;
   currentTime = millis();
   gameTime = millis();
   gameEnd = false;
   }


}

void controllerChange(int channel, int number, int value) {
 
  for (int i = 0; i<numCandles;i++) {
   if (number == player1candles[i]) {
    candleValues1[i] = value;
   }
  }
  
  for (int i = 0; i<numCandles;i++) {   
   if (candleValues1[i] > flame) {
    players[0].candleLit[i] = 1; 
   } else {
     players[0].candleLit[i] = 0; 
   }
  }
  
    for (int i = 0; i<numCandles;i++) {
   if (number == player2candles[i]) {
    candleValues2[i] = value;
   }
  }
  
  for (int i = 0; i<numCandles;i++) {   
   if (candleValues2[i] > 0) {
    players[1].candleLit[i] = 1; 
   } else {
     players[1].candleLit[i] = 0; 
   }
  }
}

void pulseWave() {
 pulse += .3; 
 
   float x = pulse;
  for (int i = 0; i < 100; i++) {
 pulseValue = (sin(x)*amplitude)+50;
    x+=dx;
  }
 pulseValue = pulseValue/50;
}

void winner() {
  
  if (winDisplay == true) {
    if (players[0].score > players[1].score)  {
      players[0].winner = true;
      players[1].winner = false;
    }
    
    if (players[1].score > players[0].score)  {
      players[0].winner = false;
      players[1].winner = true;      
    }
    
  //  if (players[1].score == players[0].score)  {
  //      pushMatrix();
  //   textSize(100+pulseValue);
  //   textAlign(CENTER,CENTER);
  //   translate(width/2,100);   
  //   rotate(turning%TWO_PI);
  //   text("tie game!",0,0); 
  //popMatrix();
  //  } 
    
  }
}
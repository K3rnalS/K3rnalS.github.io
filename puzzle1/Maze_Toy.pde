int x=75; //X value of the square
int y=75; //Y value of the square
int w=20,h=20;//width and height of the square
int stopx=0; //Stopping point for laser 1
int stopx2=0; //Stopping point for laser 2
float r,r2,r3;//Variables used in randomized colour generator
int M=4; //Movement speed of the square
int fail=0; //Fail counter
//The following booleans are all regarding checkpoints and activation
boolean node1=true; //The first node, if true, node has not been hit and is on screen, if false, node has been hit and is no longer on screen
boolean node2=false; //The second node, if true, node has not been hit and is on screen, if false, then either the first node has not been hit yet or this one has been hit
boolean node3=false;//The third node, if true, node has not been hit and is on screen, if false, then either the prior node has not been hit or this node has been hit
boolean checkpoints=false; //Will become true when all nodes are hit and checkpoints are enabled. Checkpoints are not required to complete the maze
boolean check1=false; //Will be set to true when player is on the first checkpoint
boolean check2=false; //Will be set to true when player is on the second checkpoint
boolean check3=false; //Will be set to true when player is on the third checkpoint
int fx; 
int fy;
PFont f;
String fails = "Fails: "+fail;
String checks="Checkpoints: Disabled";
String checks2="0/3 Nodes activated";
String obj="Objective: Reach the end of the maze";
String obj2="(Optional): Activate checkpoints";
String time = "8:20";
String pity="Pity Mode: Disabled";
String code="";
String code2="";
String R="";
String G="";
String B="";
int t;
int s;
int m=t/60;
int interval = 60*8+20;
String m2=m+":";
String pity2="Pity Mode will be activated in: "+t;
boolean pityB=false;

void setup(){
  f = createFont("Arial",16,true);
size(800,800); //Set display size to 400x400 pixels
}

void move(){ //Functions for movement
if (keyPressed){ //If a key is pressed...
  if (keyCode == UP){ //If the UP arrow is pressed
  y=y-M; //subtract the movement speed of the square from the current y position
  } if (keyCode==DOWN){ //If the DOWN arrow is pressed
  y=y+M; //add the movement speed of the square to the current y position
  } if (keyCode==RIGHT){ //If the RIGHT arrow is pressed
  x=x+M; //add the movement speed of the square to the current x position
  } if (keyCode==LEFT){ //If the LEFT arrow is pressed
  x=x-M; //subtract the movement speed of the square from the current x position
  }
}
if (!keyPressed){

}
}
void colour(){ //Function used for randomizing the colour of the maze
r = random(255)+50; //Generate a random number between 0 and 255 (The +50 is to avoid generating incredibly dark colours that are too hard to see)
r2 = random(255)+50; //Generate a random number between 0 and 255 (The +50 is to avoid generating incredibly dark colours that are too hard to see)
r3 = random(255)+50; //Generate a random number between 0 and 255 (The +50 is to avoid generating incredibly dark colours that are too hard to see)
}

void reset(){ //Function for respawning the square when no checkpoints are active
x=75; //Set the x position to 5
y=75; //Set the y position to 5
M=4;
fail=fail+1; //Add 1 fail to the fail counter (since they had to have hit a wall and respawned)
fails=("Fails: "+fail);
if(node2==true ||node3==true){ //If the player has hit the first or second node but has not hit the final node
node1=true; //Node 1 respawns
node2=false; //Node 2 disappears
node3=false; //Node 3 disappears (if it was on screen)
checks2="0/3 Nodes activated";
//If you die before fully activating checkpoints (hitting all 3 nodes), you must restart the process of activating them
}
}
void reset1(){ //Function for respawning the square at the first checkpoint
x=50; //Set x position to 25
y=510; //Set y position to 105
fail=fail+1; //Add 1 to the fail counter
fails=("Fails: "+fail);
}
void reset2(){ //Function for respawning the square at the second checkpoint
x=760; //Set x position to 380
y=610; //Set y position to 305
fail=fail+1; //Add 1 to the fail counter
fails=("Fails: "+fail);
}
void reset3(){ //Function for respawning the square at the third checkpoint
x=10; //Set x position to 5
y=710; //Set y position to 355
fail=fail+1; //Add 1 to the fail counter
fails=("Fails: "+fail);
}
void spawn(){ //Function for respawning the square. Checks where the square should be respawning based on which checkpoint the player has reached, and runs the correct respawn function from above
if (checkpoints==false){ //If the player has not enabled checkpoints
reset(); //Run the basic respawn function
}else if (check1==false && check2==false && check3==false){ //This is for if the player has enabled checkpoints but somehow not stepped into any checkpoints
reset(); //Run the basic respawn function
}else if (checkpoints==true && check1==true){ //If the player has enabled checkpoints and reached checkpoint 1
reset1(); //Run the first checkpoint respawn function
} else if (checkpoints==true && check2==true){ //If the player has enabled checkpoints and reached checkpoint 2
reset2(); //Run the first checkpoint respawn function
} else if (checkpoints==true && check3==true){ //If the player has enabled checkpoints and reached checkpoint 3
reset3(); //Run the first checkpoint respawn function
}
//colour(); //Run the colour function upon death, randomly changing the colour for every respawn
}

void draw(){ //Start of main draw loop
move(); //Access function for player movement
background(0); //Set background to black
noStroke(); //Remove borders on all shapes

//EXIT SQUARE
fill(0,255,0); //Set colour to bright green
rect(750,700,780,750); //Draw the exit square
if(x>=750 && y>700 && y+20<750 && x<780){ //If the player is fully within the exit square
//print("Code: 613907. ");
code="Colour Hex: #7289da";
code2="Find: ";
R="R";
G="G";
B="B";
println("Fails: "+fail); //Print in the console the amount of failed attempts they made while escaping
println("Colour Hex: #7289da");
println("Find RGB");
exit(); //Close the program
}

//CHECKPOINTS
if (node1==true){ //If the player has not activated the first node
fill(255,0,255); //Set colour to magenta
rectMode(CORNERS); //Set rectangle sizing mode to be based on coordinates of two cornerns
rect(5,405,35,435); //Draw the node
}
if (x+20>5 && y+20>405 && x<35 && y<435 && node1==true){ //If the player activates the first node
node1=false; //The node is now false and will no longer appear on screen
node2=true; //The second node is now true and will appear on screen
checks2="1/3 Nodes activated";
}
if (node2==true){ //If the player has not activated the second node but has activated the first
fill(255,0,255); //Set colour to magenta
rectMode(CORNERS); //Set rectangle sizing mode to be based on coordinates of two cornerns
rect(80,60,110,90); //Draw the node
}
if (x+20>80 && y+20>60 && x<110 && y<90 && node2==true){ //If the player activates the second node
node2=false; //The node is now false and will no longer appear on screen
node3=true; //The third node is now true and will appear on screen
checks2="2/3 Nodes activated";
}
if (node3==true){ //If the player has not activated the third node but has activated the first and second
fill(255,0,255); //Set colour to magenta
rectMode(CORNERS); //Set rectangle sizing mode to be based on coordinates of two cornerns
rect(5,505,35,535); //Draw the node
}
if (x+20>5 && y+20>505 && x<35 && y<535 && node3==true){ //If the player activates the third and final node, subsequently enabling checkpoints
node1=false; //All nodes set to false so they are no longer on screen
node2=false; //All nodes set to false so they are no longer on screen
node3=false; //All nodes set to false so they are no longer on screen
checks2="3/3 Nodes activated";
checks="Checkpoints: Enabled";
checkpoints=true; //Checkpoints are now enabled
}
if(checkpoints==true){ //If checkpoints have been enabled
fill(50,100,50); //Set colour to dark shade of green (to represent them being off)
rect(40,500,80,540); //Draw the first checkpoint
rect(750,600,width,650); //Draw the second checkpoint
rect(0,700,50,750); //Draw the third checkpoint
}

if (x+20>40 && y+20>500 && x<80 && y<540 && checkpoints==true && check2==false && check3==false){ //If the player moves within the first checkpoint and the other 2 checkpoints are inactive
check1=true; //The player has activated the first checkpoint

}
if (check1==true){ //If checkpoint 1 is activated
fill(0,255,0); //Set colour to bright green
rect(40,500,80,540); //Redraw checkpoint 1 in brighter green to show that it is activated
}
if (x+20>750 && y+20>600 && x<width && y<650 && checkpoints==true && check3==false){ //If the player moves within the second checkpoint and checkpoint 3 has not been activated
  check1=false; //First checkpoint is now inactive
  check2=true; //Second checkpoint is now active
}
if (check2==true && pityB==false){ //If checkpoint 2 is activated
fill(0,255,0); //Set colour to bright green
rect(750,600,width,650); //Redraw checkpoint 2 in brighter green to show that it is activated
  M=2;
}else if (check2==true && pityB==true){
fill(0,255,0); //Set colour to bright green
rect(750,600,width,650); //Redraw checkpoint 2 in brighter green to show that it is activated
  M=1;
}
if(x>=750 && y>=600 && x+20<=width && y+20<=650 && pityB==false && checkpoints==false){
M=2;}

if (x+20>0 && y+20>700 && x<50 && y<750 && checkpoints==true){ //If the player moves within the third checkpoint
  check1=false; //First checkpoint is now inactive
  check2=false; //Second checkpoint is now inactive
  check3=true; //Third checkpoint is now active
}
if (check3==true){ //If checkpoint 3 is activated
fill(0,255,0); //Set colour to bright green
rect(0,700,50,750); //Redraw checkpoint 3 in brighter green to show that it is activated
if (pityB==false){M=4;} //Change the movement speed back to 2 as the frustrating part of the maze is now over
if (pityB==true){M=2;}
}

if (x+20>0 && y+20>700 && x<50 && y<750 && checkpoints==false){ //If the player moves within the third checkpoint
M=4;
}

//Square (Player)
rectMode(CORNER); //Set rectangle sizing mode to be based on the coordinates of two corners
noCursor(); //Remove cursor from the screen
fill(255,0,0); //Set colour to bright red
rect(x, y, w, h);//Draw the player's square

//MAZE (Every piece that makes up the maze)
//if (r==0){ //If randomized colour value #1 is still 0 ('colour()' has not been run yet)
//colour(); //Run 'colour' function (assigns random values to 'r', 'r2', and 'r3')
//}
fill(250,250,150); //Set random colour
rectMode(CORNERS); //Set rectangle sizing mode to be based on the coordinates of two corners
rect(0, 750, width, height); //Draw the bottom block
if (x+20>0 && y+20>750 && x<width && y<height){ //If the player touches the boundary of the aforementioned block
spawn(); //Run the spawn function to determine where the player is supposed to respawn and then place them there
}
rect(0, 150, 200, 200); //Draws the large block right beneath the player's spawn
if (y+20>150 && x<200 && y<200){ //If the player touches the boundary of the aforementioned block
spawn(); //Run the spawn function to determine where the player is supposed to respawn and then place them there
}
rect(200, 60, 250, 200); //Draws the smallest block in the player spawn which is slightly above the first block
if (y+20>60 && x+20>200 && y<200 && x<250){ //If the player touches the boundary of the aforementioned block
spawn(); //Run the spawn function to determine where the player is supposed to respawn and then place them there
}
rect(250, 40, 300, 200); //Draw the block in the player spawn that's elevated slightly above the second block
if (x<300 && y+20>40 && x+20>250 && y<200){ //If the player touches the boundary of the aforementioned block
spawn(); //Run the spawn function to determine where the player is supposed to respawn and then place them there
}
rect(330, 0, width, 500); //Draw the giant block in the top right corner. This block takes up a lot of space because it was originally used for text. Text was removed since we haven't learned strings yet.
if (x+20>330 && y+20>0 && x<width && y<500){ //If the player touches the boundary of the aforementioned block
spawn(); //Run the spawn function to determine where the player is supposed to respawn and then place them there
}
rect(40, 250, 350, 300); //Draw the first horizontal block in the first portion of the maze
if (x+20>40 && y+20>250 && x<350 && y<300){ //If the player touches the boundary of the aforementioned block
spawn(); //Run the spawn function to determine where the player is supposed to respawn and then place them there
}
rect(0, 350, 300, 400); //Draw the second horizontal block in the first portion of the maze
if (x+20>0 && y+20>350 && x<300 && y<400){ //If the player touches the boundary of the aforementioned block
spawn(); //Run the spawn function to determine where the player is supposed to respawn and then place them there
}
rect(40, 440, 350, 500); //Draw the third horizontal block in the first portion of the maze
if (x+20>40 && y+20>440 && x<350 && y<500){ //If the player touches the boundary of the aforementioned block
spawn(); //Run the spawn function to determine where the player is supposed to respawn and then place them there
}
rect(0, 540, 775, 600); //Draw the first "stair" block in the second portion of the maze, under checkpoint 1
if (x+20>0 && y+20>540 && x<775 && y<600){ //If the player touches the boundary of the aforementioned block
spawn(); //Run the spawn function to determine where the player is supposed to respawn and then place them there
}
rect(200, 535, 775, 600); //Draw the second "stair" block in the second portion of the maze, this is elevated slightly above the last one
if (x+20>200 && y+20>535 && x<775 && y<600){ //If the player touches the boundary of the aforementioned block
spawn(); //Run the spawn function to determine where the player is supposed to respawn and then place them there
}
rect(400, 530, 775, 600); //Draw the third "stair" block in the second portion of the maze, this is elevated slightly above the last one
if (x+20>400 && y+20>530 && x<775 && y<600){ //If the player touches the boundary of the aforementioned block
spawn(); //Run the spawn function to determine where the player is supposed to respawn and then place them there
}
rect(600, 525, 775, 600); //Draw the fourth "stair" block in the second portion of the maze, this is elevated slightly above the last one
if (x+20>600 && y+20>525 && x<775 && y<600){ //If the player touches the boundary of the aforementioned block
spawn(); //Run the spawn function to determine where the player is supposed to respawn and then place them there
}
rect(40, 650, width, 700); //Draw the base floor of the third portion of the maze. (teeth portion)
if (x+20>40 && y+20>650 && x<width && y<700){ //If the player touches the boundary of the aforementioned block
spawn(); //Run the spawn function to determine where the player is supposed to respawn and then place them there
}
rect(600, 600, 625, 625); //Draw the first square as part of the teeth portion of the maze
if (x+20>600 && y+20>600 && x<625 && y<625){ //If the player touches the boundary of the aforementioned block
spawn(); //Run the spawn function to determine where the player is supposed to respawn and then place them there
}
rect(540, 625, 565, 650); //Draw the second square as part of the teeth portion of the maze
if (x+20>540 && y+20>625 && x<565 && y<650){ //If the player touches the boundary of the aforementioned block
spawn(); //Run the spawn function to determine where the player is supposed to respawn and then place them there
}
rect(480, 600, 505, 625); //Draw the third square as part of the teeth portion of the maze
if (x+20>480 && y+20>600 && x<505 && y<625){ //If the player touches the boundary of the aforementioned block
spawn(); //Run the spawn function to determine where the player is supposed to respawn and then place them there
}
rect(420, 625, 445, 650); //Draw the fourth square as part of the teeth portion of the maze
if (x+20>420 && y+20>625 && x<445 && y<650){ //If the player touches the boundary of the aforementioned block
spawn(); //Run the spawn function to determine where the player is supposed to respawn and then place them there
}
rect(360, 600, 385, 625); //Draw the fifth square as part of the teeth portion of the maze
if (x+20>360 && y+20>600 && x<385 && y<625){ //If the player touches the boundary of the aforementioned block
spawn(); //Run the spawn function to determine where the player is supposed to respawn and then place them there
}
rect(300, 625, 325, 650); //Draw the sixth square as part of the teeth portion of the maze
if (x+20>300 && y+20>625 && x<325 && y<650){ //If the player touches the boundary of the aforementioned block
spawn(); //Run the spawn function to determine where the player is supposed to respawn and then place them there
}
rect(240, 600, 265, 625); //Draw the seventh square as part of the teeth portion of the maze
if (x+20>240 && y+20>600 && x<265 && y<625){ //If the player touches the boundary of the aforementioned block
spawn(); //Run the spawn function to determine where the player is supposed to respawn and then place them there
}
rect(180, 625, 205, 650); //Draw the eighth square as part of the teeth portion of the maze
if (x+20>180 && y+20>625 && x<205 && y<650){ //If the player touches the boundary of the aforementioned block
spawn(); //Run the spawn function to determine where the player is supposed to respawn and then place them there
}
rect(120, 600, 145, 625); //Draw the ninth square as part of the teeth portion of the maze
if (x+20>120 && y+20>600 && x<145 && y<625){ //If the player touches the boundary of the aforementioned block
spawn(); //Run the spawn function to determine where the player is supposed to respawn and then place them there
}
rect(60, 625, 85, 650); //Draw the tenth square as part of the teeth portion of the maze
if (x+20>60 && y+20>625 && x<85 && y<650){ //If the player touches the boundary of the aforementioned block
spawn(); //Run the spawn function to determine where the player is supposed to respawn and then place them there
}
rect(0, 600, 25, 625); //Draw the eleventh and final square as part of the teeth portion of the maze
if (x+20>0 && y+20>600 && x<25 && y<625){ //If the player touches the boundary of the aforementioned block
spawn(); //Run the spawn function to determine where the player is supposed to respawn and then place them there
}
rect(140,700,340,705); //Draws the first narrowing roof block as part of the final portion of the maze
if (x+20>140 && y+20>700 && x<340 && y<705){ //If the player touches the boundary of the aforementioned block
spawn(); //Run the spawn function to determine where the player is supposed to respawn and then place them there
}
rect(140,750,340,730); //Draws the first narrowing floor block as part of the final portion of the maze ///////////////////////////////////////////////////////
if (x+20>140 && y+20>730 && x<340 && y<750){ //If the player touches the boundary of the aforementioned block
spawn(); //Run the spawn function to determine where the player is supposed to respawn and then place them there
}
rect(380,700,580,720); //Draws the second narrowing roof block as part of the final portion of the maze
if (x+20>380 && y+20>700 && x<580 && y<720){ //If the player touches the boundary of the aforementioned block
spawn(); //Run the spawn function to determine where the player is supposed to respawn and then place them there
}
rect(380,750,580,745); //Draws the second narrowing floor block as part of the final portion of the maze
if (x+20>380 && y+20>745 && x<580 && y<750){ //If the player touches the boundary of the aforementioned block
spawn(); //Run the spawn function to determine where the player is supposed to respawn and then place them there
}
rect(620,700,width,712); //Draws the third narrowing roof block as part of the final portion of the maze
if (x+20>620 && y+20>700 && x<width && y<714){ //If the player touches the boundary of the aforementioned block
spawn(); //Run the spawn function to determine where the player is supposed to respawn and then place them there
}
rect(620,750,width,738); //Draws the third narrowing floor block as part of the final portion of the maze
if (x+20>620 && y+20>739 && x<width && y<750){ //If the player touches the boundary of the aforementioned block
spawn(); //Run the spawn function to determine where the player is supposed to respawn and then place them there
}
rect(780,700,width,750); //Draws the block in behind the green exit square
if (x+20>780 && y+20>700 && x<801 && y<750){ //If the player touches the boundary of the aforementioned block
spawn(); //Run the spawn function to determine where the player is supposed to respawn and then place them there
} //Note: This buffer block has a hitbox despite being impossible to reach because originally the game used a mouse to move the square; it was possible to go out of boundaries and skip to the end
if(x<=0 || x+20>=width || y+20>=height || y<=0){ //If the player goes outside of any of the boundaries
spawn(); //Run the spawn function to determine where the player is supposed to respawn and then place them there
}

//LASERS

int xl2=200;//x value of first row laser
while(xl2<stopx2 && pityB==false){ //while 'xl2' is below the stopping point
fill(255,0,0); //Set colour to bright red
rect(xl2,200,xl2+10,250); //Draw laser
xl2=xl2+140; //Increase laser's x value by 70
}
stopx2=stopx2+2; //Increase stopping point of first row laser

if (stopx2>=340){ //If the stopping point gets to 170 (70 pixels after 'xl2')
xl2=60; //Set 'xls' to 30 (The laser won't draw until 'stopx2' is greater than 'xl2' but 'xl2' will start off above 'stopx2' causing there to be a small period of time where the laser is not on screen)
stopx2=0; //Reset stopping point to 0
}

boolean laser2=true; //Is laser 2 on screen?

if (xl2==200 && xl2<=210){ //If the first row laser is being drawn
laser2=false; //Set first row laser to false
}

if (laser2==true && x+20>200 && y+20>200 && x<210 && y<250 && pityB==false){ //If the player steps into the laser while it is active
spawn(); //Run the spawn function
}

int xl1=200;//x value of first row laser
while(xl1<stopx2 && pityB==false){ //while 'xl2' is below the stopping point
fill(255,0,0); //Set colour to bright red
rect(xl1,300,xl1+10,350); //Draw laser
xl1=xl1+140; //Increase laser's x value by 70
}
stopx=stopx+2; //Increase stopping point of first row laser

if (stopx>=340){ //If the stopping point gets to 170 (70 pixels after 'xl2')
xl1=60; //Set 'xls' to 30 (The laser won't draw until 'stopx2' is greater than 'xl2' but 'xl2' will start off above 'stopx2' causing there to be a small period of time where the laser is not on screen)
stopx=0; //Reset stopping point to 0
}

boolean laser1=true; //Is laser 2 on screen?

if (xl1==200 && xl1<=210){ //If the first row laser is being drawn
laser1=false; //Set first row laser to false
}

if (laser1==true && x+20>200 && y+20>300 && x<210 && y<350 && pityB==false){ //If the player steps into the laser while it is active
spawn(); //Run the spawn function
}


fill(0);
textFont(f,40);
text(fails,350,50);
text(checks,350,150);
textFont(f,24);
text(obj,350,210);
text(obj2,350,250);
text(checks2, 400, 290);
text(code,350,440);

 t = interval-int(millis()/1000);
    time = nf(t , 3);
    if(t <= 0){
     pity="Pity Mode: Enabled";
     pityB=true;
    }
    if (pityB==true){
    M=2;
    checkpoints=true;
    node1=false;
    node2=false;
    node3=false;
    }
    
text (pity,350,330);
text(pity2, 400, 370);
if(pityB==false){
pity2="Pity Mode will be activated in: "+t;
}else if(pityB==true){
pity2="Speed Reduced, Lasers Removed";
}
text(code2,380,470);
fill(255,0,0);
text(R,440,470);
fill(0,200,0);
text(G,460,470);
fill(0,0,255);
text(B,480,470);

}

/* 
Interactive Toy
James Cant
2020-10-03

This interactive toy is a maze game in which the player attempts to get the
red square to the end by controlling it with the arrow keys. The player has
the opportunity to enable checkpoints by hitting pink nodes, which will 
greatly benefit them as the maze gets progressively less forgiving. 
The maze also randomizes its colour upon respawning.

Note: This code was originially made in 800x800 pixels,
most numbers were adjusted by adding "/2" after them.
This code was also written with the original intention of moving the player by
using the mouse (as seen in my pseudocode and design planning).
The player is now moved by the keyboard instead because resetting the cursor position 
requires tools not given within chapters 1-7. Though you can adjust mouseX and mouseY,
this does not actually reset where the computer knows the cursor is, thus allowing the
player to clip through the maze. In order to forcefully move the player's cursor, a
"robot" is required, as well as importing of some java libraries.
Lastly, I originally had a few strings that would print out on screen telling
the player their current fail count and their objectives (i.e. enable checkpoints 1/3)
This was also removed because strings are not given within chapters 1-7.
*/

int x=5; //X value of the square
int y=5; //Y value of the square
int w=10,h=10;//width and height of the square
int stopx=0; //Stopping point for laser 1
int stopx2=0; //Stopping point for laser 2
float r,r2,r3;//Variables used in randomized colour generator
int M=2; //Movement speed of the square
int fail=0; //Fail counter
//The following booleans are all regarding checkpoints and activation
boolean node1=true; //The first node, if true, node has not been hit and is on screen, if false, node has been hit and is no longer on screen
boolean node2=false; //The second node, if true, node has not been hit and is on screen, if false, then either the first node has not been hit yet or this one has been hit
boolean node3=false;//The third node, if true, node has not been hit and is on screen, if false, then either the prior node has not been hit or this node has been hit
boolean checkpoints=false; //Will become true when all nodes are hit and checkpoints are enabled. Checkpoints are not required to complete the maze
boolean check1=false; //Will be set to true when player is on the first checkpoint
boolean check2=false; //Will be set to true when player is on the second checkpoint
boolean check3=false; //Will be set to true when player is on the third checkpoint
void setup(){
size(400,400); //Set display size to 400x400 pixels
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
}
void colour(){ //Function used for randomizing the colour of the maze
r = random(255)+50; //Generate a random number between 0 and 255 (The +50 is to avoid generating incredibly dark colours that are too hard to see)
r2 = random(255)+50; //Generate a random number between 0 and 255 (The +50 is to avoid generating incredibly dark colours that are too hard to see)
r3 = random(255)+50; //Generate a random number between 0 and 255 (The +50 is to avoid generating incredibly dark colours that are too hard to see)
}

void reset(){ //Function for respawning the square when no checkpoints are active
x=5; //Set the x position to 5
y=5; //Set the y position to 5
fail=fail+1; //Add 1 fail to the fail counter (since they had to have hit a wall and respawned)
if(node2==true ||node3==true){ //If the player has hit the first or second node but has not hit the final node
node1=true; //Node 1 respawns
node2=false; //Node 2 disappears
node3=false; //Node 3 disappears (if it was on screen)
//If you die before fully activating checkpoints (hitting all 3 nodes), you must restart the process of activating them
}
}
void reset1(){ //Function for respawning the square at the first checkpoint
x=50/2; //Set x position to 25
y=510/2; //Set y position to 105
fail=fail+1; //Add 1 to the fail counter
}
void reset2(){ //Function for respawning the square at the second checkpoint
x=760/2; //Set x position to 380
y=610/2; //Set y position to 305
fail=fail+1; //Add 1 to the fail counter
}
void reset3(){ //Function for respawning the square at the third checkpoint
x=10/2; //Set x position to 5
y=710/2; //Set y position to 355
fail=fail+1; //Add 1 to the fail counter
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
colour(); //Run the colour function upon death, randomly changing the colour for every respawn
}

void draw(){ //Start of main draw loop
move(); //Access function for player movement
background(0); //Set background to black
noStroke(); //Remove borders on all shapes

//EXIT SQUARE
fill(0,255,0); //Set colour to bright green
rect(750/2,700/2,780/2,750/2); //Draw the exit square
if(x>=750/2 && y>700/2 && y+10<750/2 && x<780/2){ //If the player is fully within the exit square
print("You Escaped! "); //Print in the console that they've escaped
print("Fails: "+fail); //Print in the console the amount of failed attempts they made while escaping
exit(); //Close the program
}

//CHECKPOINTS
if (node1==true){ //If the player has not activated the first node
fill(255,0,255); //Set colour to magenta
rectMode(CORNERS); //Set rectangle sizing mode to be based on coordinates of two cornerns
rect(5/2,405/2,35/2,435/2); //Draw the node
}
if (x+10>5/2 && y+10>405/2 && x<35/2 && y<435/2 && node1==true){ //If the player activates the first node
node1=false; //The node is now false and will no longer appear on screen
node2=true; //The second node is now true and will appear on screen
}
if (node2==true){ //If the player has not activated the second node but has activated the first
fill(255,0,255); //Set colour to magenta
rectMode(CORNERS); //Set rectangle sizing mode to be based on coordinates of two cornerns
rect(80/2,60/2,110/2,90/2); //Draw the node
}
if (x+10>80/2 && y+10>60/2 && x<110/2 && y<90/2 && node2==true){ //If the player activates the second node
node2=false; //The node is now false and will no longer appear on screen
node3=true; //The third node is now true and will appear on screen
}
if (node3==true){ //If the player has not activated the third node but has activated the first and second
fill(255,0,255); //Set colour to magenta
rectMode(CORNERS); //Set rectangle sizing mode to be based on coordinates of two cornerns
rect(5/2,505/2,35/2,535/2); //Draw the node
}
if (x+10>5/2 && y+10>505/2 && x<35/2 && y<535/2 && node3==true){ //If the player activates the third and final node, subsequently enabling checkpoints
node1=false; //All nodes set to false so they are no longer on screen
node2=false; //All nodes set to false so they are no longer on screen
node3=false; //All nodes set to false so they are no longer on screen
checkpoints=true; //Checkpoints are now enabled
}
if(checkpoints==true){ //If checkpoints have been enabled
fill(50,100,50); //Set colour to dark shade of green (to represent them being off)
rect(40/2,500/2,80/2,540/2); //Draw the first checkpoint
rect(750/2,600/2,width,650/2); //Draw the second checkpoint
rect(0,700/2,50/2,750/2); //Draw the third checkpoint
}

if (x+10>40/2 && y+10>500/2 && x<80/2 && y<540/2 && checkpoints==true && check2==false && check3==false){ //If the player moves within the first checkpoint and the other 2 checkpoints are inactive
check1=true; //The player has activated the first checkpoint

}
if (check1==true){ //If checkpoint 1 is activated
fill(0,255,0); //Set colour to bright green
rect(40/2,500/2,80/2,540/2); //Redraw checkpoint 1 in brighter green to show that it is activated
}
if (x+10>750/2 && y+10>600/2 && x<width && y<650/2 && checkpoints==true && check3==false){ //If the player moves within the second checkpoint and checkpoint 3 has not been activated
  check1=false; //First checkpoint is now inactive
  check2=true; //Second checkpoint is now active
}
if (check2==true){ //If checkpoint 2 is activated
fill(0,255,0); //Set colour to bright green
rect(750/2,600/2,width,650/2); //Redraw checkpoint 2 in brighter green to show that it is activated
M=1; //Halve the movement speed to make the next portion of the maze less frustrating
}
if (x+10>0 && y+10>700/2 && x<50/2 && y<750/2 && checkpoints==true){ //If the player moves within the third checkpoint
  check1=false; //First checkpoint is now inactive
  check2=false; //Second checkpoint is now inactive
  check3=true; //Third checkpoint is now active
}
if (check3==true){ //If checkpoint 3 is activated
fill(0,255,0); //Set colour to bright green
rect(0,700/2,50/2,750/2); //Redraw checkpoint 3 in brighter green to show that it is activated
M=2; //Change the movement speed back to 2 as the frustrating part of the maze is now over
}

//Square (Player)
rectMode(CORNER); //Set rectangle sizing mode to be based on the coordinates of two corners
noCursor(); //Remove cursor from the screen
fill(255,0,0); //Set colour to bright red
rect(x, y, w, h);//Draw the player's square

//MAZE (Every piece that makes up the maze)
if (r==0){ //If randomized colour value #1 is still 0 ('colour()' has not been run yet)
colour(); //Run 'colour' function (assigns random values to 'r', 'r2', and 'r3')
}
fill(r,r2,r3); //Set random colour
rectMode(CORNERS); //Set rectangle sizing mode to be based on the coordinates of two corners
rect(0, 750/2, width, height); //Draw the bottom block
if (x+10>0 && y+10>750/2 && x<width && y<height){ //If the player touches the boundary of the aforementioned block
spawn(); //Run the spawn function to determine where the player is supposed to respawn and then place them there
}
rect(0, 150/2, 200/2, 200/2); //Draws the large block right beneath the player's spawn
if (y+10>150/2 && x<200/2 && y<200/2){ //If the player touches the boundary of the aforementioned block
spawn(); //Run the spawn function to determine where the player is supposed to respawn and then place them there
}
rect(200/2, 60/2, 250/2, 200/2); //Draws the smallest block in the player spawn which is slightly above the first block
if (y+10>60/2 && x+10>200/2 && y<200/2 && x<250/2){ //If the player touches the boundary of the aforementioned block
spawn(); //Run the spawn function to determine where the player is supposed to respawn and then place them there
}
rect(250/2, 40/2, 300/2, 200/2); //Draw the block in the player spawn that's elevated slightly above the second block
if (x<300/2 && y+10>40/2 && x+10>250/2 && y<200/2){ //If the player touches the boundary of the aforementioned block
spawn(); //Run the spawn function to determine where the player is supposed to respawn and then place them there
}
rect(330/2, 0, width, 500/2); //Draw the giant block in the top right corner. This block takes up a lot of space because it was originally used for text. Text was removed since we haven't learned strings yet.
if (x+10>330/2 && y+10>0 && x<width && y<500/2){ //If the player touches the boundary of the aforementioned block
spawn(); //Run the spawn function to determine where the player is supposed to respawn and then place them there
}
rect(40/2, 250/2, 350/2, 300/2); //Draw the first horizontal block in the first portion of the maze
if (x+10>40/2 && y+10>250/2 && x<350/2 && y<300/2){ //If the player touches the boundary of the aforementioned block
spawn(); //Run the spawn function to determine where the player is supposed to respawn and then place them there
}
rect(0, 350/2, 300/2, 400/2); //Draw the second horizontal block in the first portion of the maze
if (x+10>0 && y+10>350/2 && x<300/2 && y<400/2){ //If the player touches the boundary of the aforementioned block
spawn(); //Run the spawn function to determine where the player is supposed to respawn and then place them there
}
rect(40/2, 440/2, 350/2, 500/2); //Draw the third horizontal block in the first portion of the maze
if (x+10>40/2 && y+10>440/2 && x<350/2 && y<500/2){ //If the player touches the boundary of the aforementioned block
spawn(); //Run the spawn function to determine where the player is supposed to respawn and then place them there
}
rect(0, 540/2, 775/2, 600/2); //Draw the first "stair" block in the second portion of the maze, under checkpoint 1
if (x+10>0 && y+10>540/2 && x<775/2 && y<600/2){ //If the player touches the boundary of the aforementioned block
spawn(); //Run the spawn function to determine where the player is supposed to respawn and then place them there
}
rect(200/2, 535/2, 775/2, 600/2); //Draw the second "stair" block in the second portion of the maze, this is elevated slightly above the last one
if (x+10>200/2 && y+10>535/2 && x<775/2 && y<600/2){ //If the player touches the boundary of the aforementioned block
spawn(); //Run the spawn function to determine where the player is supposed to respawn and then place them there
}
rect(400/2, 530/2, 775/2, 600/2); //Draw the third "stair" block in the second portion of the maze, this is elevated slightly above the last one
if (x+10>400/2 && y+10>530/2 && x<775/2 && y<600/2){ //If the player touches the boundary of the aforementioned block
spawn(); //Run the spawn function to determine where the player is supposed to respawn and then place them there
}
rect(600/2, 525/2, 775/2, 600/2); //Draw the fourth "stair" block in the second portion of the maze, this is elevated slightly above the last one
if (x+10>600/2 && y+10>525/2 && x<775/2 && y<600/2){ //If the player touches the boundary of the aforementioned block
spawn(); //Run the spawn function to determine where the player is supposed to respawn and then place them there
}
rect(40/2, 650/2, width, 700/2); //Draw the base floor of the third portion of the maze. (teeth portion)
if (x+10>40/2 && y+10>650/2 && x<width && y<700/2){ //If the player touches the boundary of the aforementioned block
spawn(); //Run the spawn function to determine where the player is supposed to respawn and then place them there
}
rect(600/2, 600/2, 625/2, 625/2); //Draw the first square as part of the teeth portion of the maze
if (x+10>600/2 && y+10>600/2 && x<625/2 && y<625/2){ //If the player touches the boundary of the aforementioned block
spawn(); //Run the spawn function to determine where the player is supposed to respawn and then place them there
}
rect(540/2, 625/2, 565/2, 650/2); //Draw the second square as part of the teeth portion of the maze
if (x+10>540/2 && y+10>625/2 && x<565/2 && y<650/2){ //If the player touches the boundary of the aforementioned block
spawn(); //Run the spawn function to determine where the player is supposed to respawn and then place them there
}
rect(480/2, 600/2, 505/2, 625/2); //Draw the third square as part of the teeth portion of the maze
if (x+10>480/2 && y+10>600/2 && x<505/2 && y<625/2){ //If the player touches the boundary of the aforementioned block
spawn(); //Run the spawn function to determine where the player is supposed to respawn and then place them there
}
rect(420/2, 625/2, 445/2, 650/2); //Draw the fourth square as part of the teeth portion of the maze
if (x+10>420/2 && y+10>625/2 && x<445/2 && y<650/2){ //If the player touches the boundary of the aforementioned block
spawn(); //Run the spawn function to determine where the player is supposed to respawn and then place them there
}
rect(360/2, 600/2, 385/2, 625/2); //Draw the fifth square as part of the teeth portion of the maze
if (x+10>360/2 && y+10>600/2 && x<385/2 && y<625/2){ //If the player touches the boundary of the aforementioned block
spawn(); //Run the spawn function to determine where the player is supposed to respawn and then place them there
}
rect(300/2, 625/2, 325/2, 650/2); //Draw the sixth square as part of the teeth portion of the maze
if (x+10>300/2 && y+10>625/2 && x<325/2 && y<650/2){ //If the player touches the boundary of the aforementioned block
spawn(); //Run the spawn function to determine where the player is supposed to respawn and then place them there
}
rect(240/2, 600/2, 265/2, 625/2); //Draw the seventh square as part of the teeth portion of the maze
if (x+10>240/2 && y+10>600/2 && x<265/2 && y<625/2){ //If the player touches the boundary of the aforementioned block
spawn(); //Run the spawn function to determine where the player is supposed to respawn and then place them there
}
rect(180/2, 625/2, 205/2, 650/2); //Draw the eighth square as part of the teeth portion of the maze
if (x+10>180/2 && y+10>625/2 && x<205/2 && y<650/2){ //If the player touches the boundary of the aforementioned block
spawn(); //Run the spawn function to determine where the player is supposed to respawn and then place them there
}
rect(120/2, 600/2, 145/2, 625/2); //Draw the ninth square as part of the teeth portion of the maze
if (x+10>120/2 && y+10>600/2 && x<145/2 && y<625/2){ //If the player touches the boundary of the aforementioned block
spawn(); //Run the spawn function to determine where the player is supposed to respawn and then place them there
}
rect(60/2, 625/2, 85/2, 650/2); //Draw the tenth square as part of the teeth portion of the maze
if (x+10>60/2 && y+10>625/2 && x<85/2 && y<650/2){ //If the player touches the boundary of the aforementioned block
spawn(); //Run the spawn function to determine where the player is supposed to respawn and then place them there
}
rect(0, 600/2, 25/2, 625/2); //Draw the eleventh and final square as part of the teeth portion of the maze
if (x+10>0 && y+10>600/2 && x<25/2 && y<625/2){ //If the player touches the boundary of the aforementioned block
spawn(); //Run the spawn function to determine where the player is supposed to respawn and then place them there
}
rect(200/2,700/2,400/2,705/2); //Draws the first narrowing roof block as part of the final portion of the maze
if (x+10>200/2 && y+10>700/2 && x<400/2 && y<705/2){ //If the player touches the boundary of the aforementioned block
spawn(); //Run the spawn function to determine where the player is supposed to respawn and then place them there
}
rect(200/2,750/2,400/2,745/2); //Draws the first narrowing floor block as part of the final portion of the maze
if (x+10>200/2 && y+10>745/2 && x<400/2 && y<750/2){ //If the player touches the boundary of the aforementioned block
spawn(); //Run the spawn function to determine where the player is supposed to respawn and then place them there
}
rect(400/2,700/2,600/2,710/2); //Draws the second narrowing roof block as part of the final portion of the maze
if (x+10>400/2 && y+10>700/2 && x<600/2 && y<710/2){ //If the player touches the boundary of the aforementioned block
spawn(); //Run the spawn function to determine where the player is supposed to respawn and then place them there
}
rect(400/2,750/2,600/2,740/2); //Draws the second narrowing floor block as part of the final portion of the maze
if (x+10>400/2 && y+10>740/2 && x<600/2 && y<750/2){ //If the player touches the boundary of the aforementioned block
spawn(); //Run the spawn function to determine where the player is supposed to respawn and then place them there
}
rect(600/2,700/2,width,712/2); //Draws the third narrowing roof block as part of the final portion of the maze
if (x+10>600/2 && y+10>700/2 && x<width && y<714/2){ //If the player touches the boundary of the aforementioned block
spawn(); //Run the spawn function to determine where the player is supposed to respawn and then place them there
}
rect(600/2,750/2,width,738/2); //Draws the third narrowing floor block as part of the final portion of the maze
if (x+10>600/2 && y+10>739/2 && x<width && y<750/2){ //If the player touches the boundary of the aforementioned block
spawn(); //Run the spawn function to determine where the player is supposed to respawn and then place them there
}
rect(780/2,700/2,width,750/2); //Draws the block in behind the green exit square
if (x+10>780/2 && y+10>700/2 && x<801/2 && y<750/2){ //If the player touches the boundary of the aforementioned block
spawn(); //Run the spawn function to determine where the player is supposed to respawn and then place them there
} //Note: This buffer block has a hitbox despite being impossible to reach because originally the game used a mouse to move the square; it was possible to go out of boundaries and skip to the end
if(x<=0 || x+10>=width || y+10>=height || y<=0){ //If the player goes outside of any of the boundaries
spawn(); //Run the spawn function to determine where the player is supposed to respawn and then place them there
}

//LASERS
int xl=30; //x value of second row laser
while(xl<stopx){ //While the x value is below the stop point
fill(255,0,0); //Set colour to bright red
rect(xl,150,xl+10,175); //Draw laser (10 pixels wide)
xl=xl+70; //Increase x value of laser by 70 (this will then go past the stopping point and reset the lasers position
}
int xl2=100;//x value of first row laser
while(xl2<stopx2){ //while 'xl2' is below the stopping point
fill(255,0,0); //Set colour to bright red
rect(xl2,100,xl2+10,125); //Draw laser
xl2=xl2+70; //Increase laser's x value by 70
}
stopx2=stopx2+1; //Increase stopping point of first row laser
stopx=stopx+1; //Increase stopping point of second row laser

if (stopx>=100){ //If the stopping point gets to 100 (70 pixels after 'xl')
xl=-40; //Set 'xl' to -40 (The laser won't draw until 'stopx' is greater than 'xl' but 'xl' will start off above 'stopx' causing there to be a small period of time where the laser is not on screen)
stopx=0; //Reset stopping point to 0
}

if (stopx2>=170){ //If the stopping point gets to 170 (70 pixels after 'xl2')
xl2=30; //Set 'xls' to 30 (The laser won't draw until 'stopx2' is greater than 'xl2' but 'xl2' will start off above 'stopx2' causing there to be a small period of time where the laser is not on screen)
stopx2=0; //Reset stopping point to 0
}

boolean laser1=true; //Is laser 1 on screen?
boolean laser2=true; //Is laser 2 on screen?

if (xl2==100 && xl2<=110){ //If the first row laser is being drawn
laser2=false; //Set first row laser to false
}

if (xl==30 && xl<=40){ //If the second row laser is being drawn
laser1=false; //Set second row laser to false
}
//Note: I am not entirely sure why the true/false above has to be set to false. It does seem backwards but it works.
//When it's set to true, the hitbox actually gets inverted and becomes active at the wrong times, despite the if statements below having the lasers marked as true

if (laser1==true && x+10>30 && y+10>150 && x<40 && y<175){ //If the player steps into the laser while it is active
spawn(); //Run the spawn function
}

if (laser2==true && x+10>100 && y+10>100 && x<110 && y<125){ //If the player steps into the laser while it is active
spawn(); //Run the spawn function
}

}

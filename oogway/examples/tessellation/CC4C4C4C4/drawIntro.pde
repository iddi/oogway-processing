
void drawIntro(){
  pushStyle();
     textFont(font,32);
     fill(0);
     text("No.16, Basic Type CC4C4C4C4",200,50);
     textFont(font,16);
     text("Turn the arbitrary line AB around A by 90 Degrees into the position AC. "
     + "Draw another arbitrary line from C to the arbitrary point D "
     + "and turn it 90 degrees into the position DE. "
     + "Complete the figure by a C-line EB."
        , 200, 100,700,200);
     text("Number of arbitrary lines: 2\nNetwork: 43433\n4 Positions."
         , 650, 200,700,100); 
  popStyle();
}


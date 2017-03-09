import de.bezier.guido.*;
public final static int NUM_rS = 20;
public final static int NUM_cS = 20;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs = new ArrayList <MSButton>(); //ArrayList of just the minesweeper buttons that are mined

void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    
    //your code to declare and initialize buttons goes here
    buttons = new MSButton[NUM_rS][NUM_cS];
    for(int rs = 0; rs<NUM_rS; rs++)
    {
        for (int c = 0; c<NUM_cS; c++)
        {
            buttons [rs][c] = new MSButton (rs,c);
        }
    }
    
    setBombs();
}
public void setBombs()
{
    for (int x = 0; x < 50; x++)
    {
    int rRow = (int)(Math.random()*NUM_rS);
    int rCol = (int)(Math.random()*NUM_cS);
    if (!bombs.contains(buttons[rRow][rCol]))
    {
        bombs.add(buttons[rRow][rCol]);
    }
    }
}

public void draw ()
{
    background( 0 );
    if(isWon())
        displayWinningMessage();
}
public boolean isWon()
{
  for (int r=0; r<NUM_rS; r++)
  {
    for (int c=0; c<NUM_cS; c++)
    {
      if (!buttons[r][c].isClicked() && !bombs.contains(buttons[r][c]))
      {
        return false;
      }
    }
  }
  return true;

}

public void displayLosingMessage()
{
  for (int r=0; r<NUM_rS; r++)
  {
    for (int c=0; c<NUM_cS; c++)
    {
      if (bombs.contains(buttons[r][c])&& !buttons[r][c].isClicked())
      {
        buttons[r][c].marked=false;
        buttons[r][c].clicked=true;
      }
    }
  }
  buttons[9][9].label="Y";
  buttons[9][10].label="o";
  buttons[9][11].label="u";
  buttons[9][12].label="";
  buttons[10][8].label="L";
  buttons[10][9].label="o";
  buttons[10][10].label="s";
  buttons[10][11].label="e";
  buttons[10][12].label="!";
}
public void displayWinningMessage()
{

        buttons[9][9].label="Y";
        buttons[9][10].label="o";
        buttons[9][11].label="u";
        buttons[9][12].label="";
        buttons[10][8].label="W";
        buttons[10][9].label="i";
        buttons[10][10].label="n";
        buttons[10][11].label="!";

}

public class MSButton
{
    private int r, c;
    private float x,y, width, height;
    private boolean clicked, marked;
    private String label;
    private boolean rightclicked;
    
    public MSButton ( int rr, int cc )
    {
        width = 400/NUM_cS;
        height = 400/NUM_rS;
        r = rr;
        c = cc; 
        x = c*width;
        y = r*height;
        label = "";
        marked = clicked = false;
        marked = Math.random() < .5;
        Interactive.add( this ); // register it with the manager
    }
    public boolean isMarked()
    {
        return marked;
    }
    public boolean isClicked()
    {
        return clicked;
    }
    
    public void mousePressed () 
    {
        clicked = true;
        rightclicked = false;
         if(keyPressed == true)
        {
            if(marked == false)
            {
                clicked = false;
                marked = true;
            }

            if (marked == true)
            {
                marked = false;
          if(isValid(r,c-1) && buttons[r][c-1].isMarked())
            buttons[r][c-1].mousePressed();
          
          if(isValid(r,c+1) && buttons[r][c+1].isMarked())
            buttons[r][c+1].mousePressed();
          
          if(isValid(r-1,c) && buttons[r-1][c].isMarked())
            buttons[r-1][c].mousePressed();
          
          if(isValid(r+1,c) && buttons[r+1][c].isMarked())
            buttons[r+1][c].mousePressed();   
          
            }
        }
        if (mouseButton == RIGHT)
        {
            rightclicked = true;
            fill(0,255,0);
        }

        else if (bombs.contains(this))
        {
            displayLosingMessage();
        }
        else if (countBombs(r,c)>0)
        {
            setLabel(""+countBombs(r,c));
        }

        else  
        {
            if(isValid(r,c-1) && buttons[r][c-1].clicked == false)
            buttons[r][c-1].mousePressed();
          
          if(isValid(r,c+1) && buttons[r][c+1].clicked == false)
            buttons[r][c+1].mousePressed();
          
          if(isValid(r-1,c) && buttons[r-1][c].clicked == false)
            buttons[r-1][c].mousePressed();
          
          if(isValid(r-1,c+1) && buttons[r-1][c+1].clicked == false)
            buttons[r-1][c+1].mousePressed();   
          
          if(isValid(r-1,c-1) && buttons[r-1][c-1].clicked == false)
            buttons[r-1][c-1].mousePressed();    
          
          if(isValid(r+1,c-1) && buttons[r+1][c-1].clicked == false)
            buttons[r+1][c-1].mousePressed();
          if(isValid(r+1,c+1) && buttons[r+1][c+1].clicked == false)
            buttons[r+1][c+1].mousePressed(); 
          if(isValid(r+1,c) && buttons[r+1][c].clicked == false)
            buttons[r+1][c].mousePressed();          
    }



    }

    public void draw () 
    {    
        if(rightclicked)
            fill(0,255,0);
        else if( clicked && bombs.contains(this) ) {
            displayLosingMessage(); 
            fill(255,0,0);
        }
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );

        rect(x, y, width, height);
        fill(0);
        text(label,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        label = newLabel;
    }
    public boolean isValid(int r, int c)
    {
        //your code here
        if (r < 20 && r>= 0 && c < 20 && c >= 0)
        return true;
        else
        return false;
    }
    public int countBombs(int r, int c)
    {
        int numBombs = 0;
        if (isValid(r,c+1) && bombs.contains(buttons[r][c+1]))
            numBombs++;
        if (isValid(r,c-1) && bombs.contains(buttons[r][c-1]))
            numBombs++;
        
        if (isValid(r+1,c+1) && bombs.contains(buttons[r+1][c+1]))
            numBombs++;
        if (isValid(r+1,c-1) && bombs.contains(buttons[r+1][c-1]))
            numBombs++;
        if (isValid(r+1,c) && bombs.contains(buttons[r+1][c]))
            numBombs++;       
        
        if (isValid(r-1,c+1) && bombs.contains(buttons[r-1][c+1]))
            numBombs++;
        if (isValid(r-1,c-1) && bombs.contains(buttons[r-1][c-1]))
            numBombs++;
        if (isValid(r-1,c) && bombs.contains(buttons[r-1][c]))
            numBombs++;

        return numBombs;
    }
}


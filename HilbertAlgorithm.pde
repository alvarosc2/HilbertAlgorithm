String points;
float scale = 400.0;

void setup()
{
  int rep = 4;
  int numPoints = power(4, rep);
  
  float[] points2;
  points2 = new float[numPoints * 2];
  
  size(400, 400); 
  stroke(0);
  background(255);
  
  points = hilbert(0, 0, 1 ,0, 0, 1, rep);
  
  // Converts the data in points which is a string into a linear array of 
  // floats
  points2 = float(split(points, ' '));
  
  int i=0;

  // this nighmarish code is used to handle the lines that join the points
  // returned by the hilbert function
  while(i < points2.length)
  {
    line(scale * points2[i+0], scale * points2[i+1], scale * points2[i+2], scale * points2[i+3]);   
    line(scale * points2[i+2], scale * points2[i+3], scale * points2[i+4], scale * points2[i+5]);
    line(scale * points2[i+4], scale * points2[i+5], scale * points2[i+6], scale * points2[i+7]);
    
    // Handle the drawing of lines between the cups    
    i += 8;
    
    if(i >= points2.length)
      break;
    else
      line(scale * points2[i-2], scale * points2[i-1], scale * points2[i], scale * points2[i+1]);

  }

}

int power(int base, int exponent)
{
   if (exponent == 0)
     return 1;
   else
     return base * power(base, exponent - 1); 
}

// The result of this function are returned as a string of values separated by spaces
// maybe this is a funny thing to do but I was having a hard time trying to decide
// how I would return the coordinates of the points calculated by this function.
String hilbert(float x0, float y0, float xi, float xj, float yi, float yj, int n)
{   
  String redPoint;
  String greenPoint;
  String bluePoint;
  String violetPoint;
  
  if (n <= 0)
    {
        float X = x0 + (xi + yi)/2;
        float Y = y0 + (xj + yj)/2;
        
        // Output the coordinates of the cv
        return X + " " + Y;
    }
    else
    {
        redPoint = hilbert(x0,               y0,               yi/2, yj/2, xi/2, xj/2, n - 1);
        greenPoint = hilbert(x0 + xi/2,        y0 + xj/2,        xi/2, xj/2, yi/2, yj/2, n - 1);
        bluePoint = hilbert(x0 + xi/2 + yi/2, y0 + xj/2 + yj/2, xi/2, xj/2, yi/2, yj/2, n - 1);
        violetPoint = hilbert(x0 + xi/2 + yi,   y0 + xj/2 + yj,  -yi/2,-yj/2,-xi/2,-xj/2, n - 1);
    }
    return redPoint + " " + greenPoint + " " + bluePoint + " " + violetPoint;
}
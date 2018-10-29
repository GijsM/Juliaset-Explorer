int iterations = 100;
int mode = 1;

float size = 2;
float lastX = 0;
float lastY = 0;

void setup() {
  size(800, 800);
  colorMode(HSB);
}

void draw() {
  switch(mode) {
    // Animation mode
  case 0: 
    drawJuliaSet(0, 0, size, new ComplexNumber(map(sin((float) frameCount / 30 * sqrt(5)), -1, 1, -1, 1), map(cos((float) frameCount / 30 * sqrt(3)), -1, 1, -1, 1)));
    break;
    // Exploration mode
  case 1: 
    drawJuliaSet(0, 0, size, new ComplexNumber(map(mouseX, 0, width, -1, 1), map(mouseY, 0, height, -1, 1)));
    text(map(mouseX, 0, width, -1, 1) + " + " + map(mouseY, 0, height, -1, 1) + "i", 0, 20);
    break;
    // Zoom mode
  case 2: 
    drawJuliaSet(map(mouseX, 0, width, lastX + size / 2, lastX-size / 2), map(mouseY, 0, height, lastY + size / 2, lastY-size / 2), size, new ComplexNumber(0.315, 0.035)); 
    break;
  }
}

void drawJuliaSet(float xOrigin, float yOrigin, float size, ComplexNumber c) {
  loadPixels();
  for (int i = 0; i < pixels.length; i++) {
    float y = map(i / width, 0, height, yOrigin-size / 2, yOrigin +size / 2);
    float x = map(i % width, 0, width, xOrigin-size / 2, xOrigin + size / 2);
    ComplexNumber z = new ComplexNumber(x, y);
    int currentIteration = 0;
    float absoluteValue = 0;
    while (++currentIteration < iterations && absoluteValue < 4) {
      z.square();
      z.add(c);
      absoluteValue = z.absoluteValue(true);
    }
    if (currentIteration < iterations)
      pixels[i] = color(255 - map(currentIteration, 0, iterations, 0, 200), 255, 255);
    else 
      pixels[i] = color(0);
  }
  updatePixels();
}

void mouseWheel(MouseEvent event) {
  if (event.getCount() == -1) size *= 0.75;
  else size /= 0.75;
  lastX = map(mouseX, 0, width, lastX + size / 2, lastX - size / 2);
  lastY = map(mouseY, 0, height, lastY + size / 2, lastY - size / 2);
}

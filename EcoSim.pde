Network testNet;
Link[] defaultNet;
color uiBackground;
float[] inputs;

void setup() {
  defaultNet = new Link[3];
  defaultNet[0] = new Link();
  defaultNet[1] = new Link();
  defaultNet[2] = new Link();
  
  defaultNet[0].in = 1;
  defaultNet[0].out = 5;

  defaultNet[1].in = 2;
  defaultNet[1].out = 5;
  
  defaultNet[2].in = 5;
  defaultNet[2].out = 1000;
  
  inputs = new float[4];
  
  testNet = new Network(4, 3, defaultNet);
  uiBackground = color(60, 60, 60);
  
  size(1080, 720);
  print("Initialized Simulation!");
}

void draw() {
  background(20, 20, 50);
  
  
  if(frameCount % 60 == 0) {
    for(int i = 0; i < inputs.length; i++) {
      inputs[i] = random(-1.0f, 1.0f);  
    }
  
    testNet.evaluate(inputs);
  }
  
  drawNetwork(testNet, 200, 200, 200, 200, uiBackground);
}
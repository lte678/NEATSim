void drawNetwork(Network net, int x, int y, int objWidth, int objHeight) {
  fill(255, 255, 255);
  
  stroke(2);
  
  for(int i = 0; i < net.links.length; i++) {
    if(net.links[i].in != 0) {
      int startX = (int)(net.neurons[net.links[i].in].xPos * objWidth); 
      int startY = (int)(net.neurons[net.links[i].in].yPos * objHeight);
      int endX = (int)(net.neurons[net.links[i].out].xPos * objWidth); 
      int endY = (int)(net.neurons[net.links[i].out].yPos * objHeight); 
      
      line(x + startX, y + startY, x + endX, y + endY);
    }
  }
  
  noStroke();
  
  for(int i = 0; i < net.neurons.length; i++) {
    if(net.neurons[i] != null) {
      int neuronX = (int)(net.neurons[i].xPos * objWidth);
      int neuronY = (int)(net.neurons[i].yPos * objHeight);
      
      fill(net.neurons[i].value * 255.0f, 0, 0);
      
      ellipse(x + neuronX, y + neuronY, objWidth / 25, objWidth / 25);
    }
  }
}

void drawNetwork(Network net, int x, int y, int objWidth, int objHeight, color background) {
  fill(background);
  noStroke();
  rect(x, y, objWidth, objHeight);
  fill(255, 255, 255);
  
  stroke(2);
  
  for(int i = 0; i < net.links.length; i++) {
    if(net.links[i].in != 0) {
      int startX = (int)(net.neurons[net.links[i].in].xPos * objWidth); 
      int startY = (int)(net.neurons[net.links[i].in].yPos * objHeight);
      int endX = (int)(net.neurons[net.links[i].out].xPos * objWidth); 
      int endY = (int)(net.neurons[net.links[i].out].yPos * objHeight); 
      
      line(x + startX, y + startY, x + endX, y + endY);
    }
  }
  
  noStroke();
  
  for(int i = 0; i < net.neurons.length; i++) {
    if(net.neurons[i] != null) {
      int neuronX = (int)(net.neurons[i].xPos * objWidth);
      int neuronY = (int)(net.neurons[i].yPos * objHeight);
      
      
      fill((int)constrain((net.neurons[i].value * -255.0f), 0, 255), (int)constrain((net.neurons[i].value * 255.0f), 0, 255), 0);
      
      ellipse(x + neuronX, y + neuronY, objWidth / 25, objWidth / 25);
    }
  }
}
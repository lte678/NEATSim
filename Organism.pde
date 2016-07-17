class Organism {
  Network brain;
  int senses = 2;
  int motors = 1;
  
  Organism() {
    brain = new Network(senses, motors, new Link[0]);
  }
}
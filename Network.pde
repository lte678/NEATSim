import java.util.Arrays;

//
//Neural network functions and classes
//

int maxIncomingLinks = 100;
int maxLinks = 1000;
int maxNodes = 1000;

float sigmoid(float x) {
    return 2 / (1 + exp(-4.9 * x)) - 1;
}

class Link implements Comparable {
  int in;
  int out;
  float weight;
  boolean enabled;
  boolean input;
  boolean output;
  int innovation;
  
  Link() {
    in = 0;
    out = 0;
    weight = 1.0f;
    enabled = true;
    input = false;
    output = false;
    innovation = 0;
  }
  
  public int compareTo(Object o) {
    if(o != null) {
      Link l = (Link)o;
      if(l.out > out) {
        return -1;
      } else if(l.out == out) {
        return 0;  
      }
      return 1;
    } else {
      print("Why is object null!?");
      return 0;
    }
  }
}

class Neuron {
  public byte type;
  public float value;
  public float xPos;
  public float yPos;
  public ArrayList<Link> incoming;
  
  Neuron() {
    value = 0.0f;                    // The output value
    type = 1;                        // A hidden node by default
    incoming = new ArrayList<Link>(); // Set the max amount of incoming values to maxIncomingLinks
  }
  
  public void evaluate(Network net) {
      float sum = 0;
      
      for(int i = 0; i < incoming.size(); i++) {
        float other = net.neurons[incoming.get(i).in].value;
        sum += incoming.get(i).weight * other;
      }
      
      value = sigmoid(sum);
  }
}

class Network {
  public Neuron[] neurons; //Hidden nodes
  public Link[] links;    //Interneural connections
  public int inputs;  //Number of inputs
  public int outputs;  //Number of outputs
  public float[] output;  //List of neuron output values
  
  Network(int _inputs, int _outputs, Link[] startingLinks) {
    inputs = _inputs;
    outputs = _outputs;
    output = new float[outputs];
    for(int i = 0; i < output.length; i++) {
      output[i] = 0.0f; //Initialize outputs to 0  
    }
    
    if(outputs == 0) {
      print("Cant initialize a network with 0 outputs! Making outputs 1, may have unexpected results...");  
      outputs = 1;
    }
    neurons = new Neuron[maxNodes + outputs];
    links = new Link[maxLinks];
    int i = 0;
    while(i < startingLinks.length) {
      links[i] = startingLinks[i];
      i++;
    }
    while(i < links.length) {
      links[i] = new Link();
      links[i].out = 0;
      i++;
    }
    
    //
    // Add input and output neurons to start
    //
    
    i = 0;
    while(i < inputs + 1) {          // 1 extra input to be the bias
      Neuron newNode = new Neuron();
      newNode.type = 0;              // Type 0 = input
      newNode.yPos = (1.0f / (inputs + 2)) * (i + 1);
      newNode.xPos = 0.1f;
      neurons[i] = newNode;
      i++;
    }
    
    neurons[0].value = 1.0f;
    
    i = 0;
    while(i < outputs) {
      Neuron newNode = new Neuron();
      newNode.type = 2;              // Type 2 = output
      newNode.yPos = (1.0f / (outputs + 1)) * (i + 1);
      newNode.xPos = 0.9f;
      neurons[maxNodes + i] = newNode;
      i++;
    }
    
    Arrays.sort(links);
    i = 0;
    while(i < links.length) {
      Link tempLink = links[i];
      if(tempLink.enabled) {
        if(neurons[tempLink.out] == null) {
          neurons[tempLink.out] = new Neuron();
          neurons[tempLink.out].xPos = random(0.2f, 0.8f);
          neurons[tempLink.out].yPos = random(0.2f, 0.8f);
        }
        
        neurons[tempLink.out].incoming.add(tempLink);
        
        if(neurons[tempLink.in] == null) {
          neurons[tempLink.in] = new Neuron();
        }
      }
      i++;
    }
  }
  
  void evaluate(float[] inputValues) {
    neurons[0].value = 1.0f; //!!!Set the first Node to be 1, this is the bias node and critical
    if(inputValues.length > inputs) {
      print("This network expects " + inputs + " intputs, not " + inputValues.length);  
      return;
    }
    int i = 0; 
    while(i < inputValues.length) {
      neurons[i + 1].value = inputValues[i];  //Set the input neurons value to whatever the input is
      i++;
    }
    while(i < inputs) {
      neurons[i + 1].value = 0.0f; //If no input value is supplied, set it to 0
      i++;
    }
    
    //
    //Evaluate neuron outputs based on supplied inputs
    //
    
    for(i = inputs + 1; i < neurons.length; i++) {
      if(neurons[i] != null) {
        neurons[i].evaluate(this); //Evaluate the neurons value in this network
      }
    }
    
    int j = 0;
    for(i = maxNodes; i < maxNodes + outputs; i++) {
      output[j] = neurons[i].value;
      j++;
    }
  }
}
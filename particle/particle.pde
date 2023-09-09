// Number of particles for each type (3000)
int num = 3000;
// Three types of particles: a, b, and c
Particle[] particles_a = new Particle[num];
Particle[] particles_b = new Particle[num];
Particle[] particles_c = new Particle[num];
int fade = 600; // The length of the particle tail
float radius = 3; // Radius of the particles

// Scale of curviness of the noise (300)
float noiseScale = 400;

// How often the direction of the noise changes (1.2)
float noiseStrength = 1.4;

void setup() {
  size(1920, 1080);
  noStroke();
  for (int i = 0; i < num; i++) {
    PVector loc_a = new PVector(random(width * 1.2), random(height), 2);
    float angle_a = random(TWO_PI);
    PVector dir_a = new PVector(cos(angle_a), sin(angle_a));
    PVector loc_b = new PVector(random(width * 1.2), random(height), 2);
    float angle_b = random(TWO_PI);
    PVector dir_b = new PVector(cos(angle_b), sin(angle_b));
    PVector loc_c = new PVector(random(width * 1.2), random(height), 2);
    float angle_c = random(TWO_PI);
    PVector dir_c = new PVector(cos(angle_c), sin(angle_c));

    particles_a[i] = new Particle(loc_a, dir_a, 0.5);
    particles_b[i] = new Particle(loc_b, dir_b, 0.5);
    particles_c[i] = new Particle(loc_c, dir_c, 0.75);
  }
}

void draw() {
  background(0); // Comment this line to see the particle tails, uncomment to hide the tails
  fill(0, 2); // Put a high value for hiding the tails
  noStroke();
  rect(0, 0, width, height);

  for (int i = 0; i < num; i++) {
    fill(255, fade); // White
    particles_a[i].move();
    particles_a[i].update(radius);
    particles_a[i].checkEdges();

    fill(0, 255, 255, fade); // Turquoise
    particles_b[i].move();
    particles_b[i].update(radius);
    particles_b[i].checkEdges();

    fill(102, 153, 255, fade); // Blue
    particles_c[i].move();
    particles_c[i].update(radius);
    particles_c[i].checkEdges();
  }
}

class Particle {
  PVector loc;
  PVector dir;
  float speed;
  float d;

  Particle(PVector loc_, PVector dir_, float speed_) {
    loc = loc_;
    dir = dir_;
    speed = speed_;
    d = 1;
  }

  void run() {
    move();
    checkEdges();
    update(radius); // Pass the radius here
  }

  // Method to move position
  void move() {
    float angle = noise(loc.x / noiseScale, loc.y / noiseScale, frameCount / noiseScale) * TWO_PI * noiseStrength;
    dir.x = cos(angle) + sin(angle) - sin(angle);
    dir.y = sin(angle) - cos(angle) * sin(angle);
    PVector vel = dir.copy();
    vel.mult(speed * d);
    loc.add(vel);
  }

  // Method to check edges
  void checkEdges() {
    if (loc.x < 0 || loc.x > width || loc.y < 0 || loc.y > height) {
      loc.x = random(width * 1.2);
      loc.y = random(height);
    }
  }

  // Method to update position
  void update(float r) {
    ellipse(loc.x, loc.y, r, r);
  }
}

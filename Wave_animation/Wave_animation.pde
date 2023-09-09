int xspacing = 25;   // How far apart should each horizontal location be spaced
int w;              // Width of entire wave
int maxwaves = 12;   // total # of waves to add together
color[] waveColors = new color[5];  // 创建三个不同的颜色
float theta = 0.0;
float[] amplitude = new float[maxwaves];   // Height of wave
float[] dx = new float[maxwaves];          // Value for incrementing X, to be calculated as a function of period and xspacing
float[] yvalues;                           // Using an array to store height values for the wave (not entirely necessary)

void setup() {
  size(640, 360);
  frameRate(50);
  colorMode(RGB, 255, 255, 255, 100);
  w = width + 8;

  for (int i = 0; i < maxwaves; i++) {
    amplitude[i] = random(10,30);
    float period = random(100,300); // How many pixels before the wave repeats
    dx[i] = (TWO_PI / period) * xspacing;
  }

  yvalues = new float[w/xspacing];
  waveColors[0] = color(34, 87, 122); 
  waveColors[1] = color(56, 163, 165);  
  waveColors[2] = color(87, 204, 153);  
  waveColors[3] = color(128, 237, 153);  
  waveColors[4] = color(199, 249, 204);  
  
  amplitude[0] = random(10, 30);  // 第一个波浪的振幅
  float period1 = random(100, 300);  // 第一个波浪的周期
  dx[0] = (TWO_PI / period1) * xspacing;
  
  amplitude[1] = random(10, 30);  // 第二个波浪的振幅
  float period2 = random(100, 300);  // 第二个波浪的周期
  dx[1] = (TWO_PI / period2) * xspacing;
  
  amplitude[2] = random(10, 30);  // 第三个波浪的振幅
  float period3 = random(100, 300);  // 第三个波浪的周期
  dx[2] = (TWO_PI / period3) * xspacing;
}

void draw() {
  background(0);
  calcWave();
  renderWave();
}

void calcWave() {
  // Increment theta (try different values for 'angular velocity' here
  theta += 0.02;

  // Set all height values to zero
  for (int i = 0; i < yvalues.length; i++) {
    yvalues[i] = 0;
  }
 
  // Accumulate wave height values
  for (int j = 0; j < maxwaves; j++) {
    float x = theta;
    for (int i = 0; i < yvalues.length; i++) {
      // Every other wave is cosine instead of sine
      if (j % 2 == 0)  yvalues[i] += sin(x)*amplitude[j];
      else yvalues[i] += cos(x)*amplitude[j];
      x+=dx[j];
    }
  }
}

void renderWave() {
  // A simple way to draw the wave with an ellipse at each location
  noStroke();
  fill(255,50);
  ellipseMode(CENTER);
  for (int x = 0; x < yvalues.length; x++) {
    int waveIndex = x % 5;  // 循环使用三个不同的颜色
    fill(waveColors[waveIndex], 50);  // 使用对应的颜色
    float radius = map(abs(yvalues[x]), 0, 60, 8, 32); // 根据yvalues的绝对值映射半径
    ellipse(x * xspacing, height / 2 + yvalues[x], radius, radius); // 使用计算出的半径绘制圆圈
  }
}

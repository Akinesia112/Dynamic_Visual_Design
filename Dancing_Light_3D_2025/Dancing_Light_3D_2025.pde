PShape[] cubes = new PShape[25]; // 创建一个立方体数组
int[] colors; // 存储立方体的颜色
float radius = 350; // 增大间距的半径

void setup() {
  size(1000, 1000, P3D);
  noStroke();
  smooth(8);
  // 设置环境光和镜面光
  ambientLight(100, 100, 100);
  specular(255);
  
  colors = new int[cubes.length];
  
  // 创建所有立方体并设置颜色和发光效果
  for (int i = 0; i < cubes.length; i++) {
    PShape cube = createCube();
    cubes[i] = cube;
    
    // 随机选择立方体的颜色
    int colorChoice = i % 3;
    if (colorChoice == 0) {
      colors[i] = color(0, 255, 255); // 蓝色
      emissive(0, 255, 255); // 设置发蓝光效果
    } else if (colorChoice == 1) {
      colors[i] = color(255); // 白色
      emissive(255); // 设置发白光效果
    } else {
      colors[i] = color(102,153,255); // 绿色
      emissive(102,153,255); // 设置发绿光效果
    }
  }
}

void draw() {
  background(0);
  lights(); // 启用简单的灯光效果
  translate(width / 2, height / 2, 0);
  
  float angleIncrement = TWO_PI / cubes.length;
  
  for (int i = 0; i < cubes.length; i++) {
    PShape cube = cubes[i];
    float x = radius * cos(angleIncrement * i);
    float y = radius * sin(angleIncrement * i);
    float z = map(sin(frameCount * 0.03 + i * 0.1), -1, 1, -100, 100);
    
    pushMatrix();
    translate(x, y, z);
    rotateY(frameCount * 0.02);
    rotateX(frameCount * 0.02);
    
    // 设置立方体的颜色
    fill(colors[i]);
    
    shape(cube);
    popMatrix();
  }
}

// 创建立方体的函数
PShape createCube() {
  PShape cube = createShape();
  cube.beginShape(QUADS);
  // 定义立方体的顶点和面
  float s = 50; // 立方体的大小
  float[] x = {-s/2, s/2, s/2, -s/2, -s/2, s/2, s/2, -s/2};
  float[] y = {-s/2, -s/2, s/2, s/2, -s/2, -s/2, s/2, s/2};
  float[] z = {-s/2, -s/2, -s/2, -s/2, s/2, s/2, s/2, s/2};
  int[] indices = {0, 1, 2, 3, 4, 5, 6, 7, 1, 0, 3, 2, 7, 6, 5, 4, 4, 0, 3, 7, 1, 2, 5, 6};
  
  for (int i = 0; i < indices.length; i++) {
    int vertexIndex = indices[i];
    float xPos = x[vertexIndex];
    float yPos = y[vertexIndex];
    float zPos = z[vertexIndex];
    cube.vertex(xPos, yPos, zPos);
  }
  
  cube.endShape(CLOSE);
  return cube;
}

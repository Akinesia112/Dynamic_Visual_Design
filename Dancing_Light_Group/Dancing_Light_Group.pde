PVector[] positions = new PVector[2025]; // 儲存立方體的位置
color[] colors = new color[2025]; // 儲存立方體的顏色

void setup() {
  size(1000, 1000, P3D);
  stroke(100);
  strokeWeight(2);
  smooth(8);

  // 初始化立方體位置和顏色
  for (int i = 0; i < positions.length; i++) {
    positions[i] = new PVector(random(-400, 400), random(-400, 400), random(-400, 400));
    colors[i] = color(random(255), random(255), random(255));
  }
}

float r = 0;

void draw() {
  background(0);

  // 旋轉立方體群組
  rotateY(r);
  rotateZ(r);
  rotateX(r);

  for (int i = 0; i < positions.length; i++) {
    pushMatrix();
    translate(width/2 + positions[i].x, height/2 + positions[i].y, positions[i].z);
    fill(colors[i]);
    box(40);
    popMatrix();
  }

  r += 0.03;
}

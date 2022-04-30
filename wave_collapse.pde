import java.util.*;
int scale = 10;
int rows;
int cols;
Cell[][] cells;
ArrayList<Integer> def =new ArrayList<>(List.of(0, 1, 2, 3, 4));
int compl=0;
// 0 path
// 1 tree
// 2 sand
// 3 water
// 4 grass

void setup() {
  size(600, 600);
  rows = height/scale;
  cols = width/scale;
  background(0);
  //noLoop();
  cells = new Cell[rows][cols];
  for (int i = 0; i < rows; i++) {
    for ( int j= 0; j< cols; j++) {
      cells[i][j]= new Cell(-1, def, i*cols+j);
    }
  }
}

void collapse() {
  int min_choice=6;
  int mi=0;
  int mj=0;
  compl++;
  for (int i = 0; i < rows; i++) {
    for ( int j= 0; j< cols; j++) {
      if (cells[i][j].choices.size()<min_choice && cells[i][j].type==-1) {
        min_choice = cells[i][j].choices.size();
        mi =i;
        mj =j;
      }
    }
  }
  int type = cells[mi][mj].choices.get((int)random(min_choice));
  cells[mi][mj].type = type;
  println(mi, mj, type);
  int startPosY = (mj - 1 < 0) ? mj : mj-1;
  int startPosX = (mi - 1 < 0) ? mi : mi-1;
  int endPosY =   (mj + 1 > cols-1) ? mj : mj+1;
  int endPosX=   (mi + 1 > rows-1) ? mi : mi+1;


  int rowNum = startPosY;
  int colNum = mj;
  while (rowNum!=endPosY) {
    if (cells[rowNum][colNum].type!=-1) {
      if (type == 3) {
        cells[rowNum][colNum].choices.remove(Integer.valueOf(0));
        cells[rowNum][colNum].choices.remove(Integer.valueOf(1));
        cells[rowNum][colNum].choices.remove(Integer.valueOf(4));

        //cells[rowNum][colNum].choices.add(Integer.valueOf(2));
      } else if (type ==2) {
        cells[rowNum][colNum].choices.remove(Integer.valueOf(0));
        cells[rowNum][colNum].choices.remove(Integer.valueOf(1));

        //cells[rowNum][colNum].choices.add(Integer.valueOf(4));
        //cells[rowNum][colNum].choices.add(Integer.valueOf(3));
      } else if (type == 4) {
        cells[rowNum][colNum].choices.remove(Integer.valueOf(3));
      } else if (type==0) {
        cells[rowNum][colNum].choices.remove(Integer.valueOf(1));
        cells[rowNum][colNum].choices.remove(Integer.valueOf(2));
        cells[rowNum][colNum].choices.remove(Integer.valueOf(3));
      } else if (type ==1) {
        cells[rowNum][colNum].choices.remove(Integer.valueOf(0));
        cells[rowNum][colNum].choices.remove(Integer.valueOf(2));
        cells[rowNum][colNum].choices.remove(Integer.valueOf(3));
      }
    }
    rowNum+=1;
  }
}
//void mousePressed() {
//  collapse();
//  redraw();
//}
void draw() {
  collapse();
  noStroke();
  for (int i = 0; i < rows; i++) {
    for ( int j= 0; j< cols; j++) {
      switch (cells[i][j].type) {
      case -1:
        fill(255, 255, 255);
        break;
      case 0:
        fill(99, 72, 64);
        break;
      case 1:
        fill(0, 87, 10);
        break;
      case 2:
        fill(195, 195, 150);
        break;
      case 3:
        fill(31, 174, 234);
        break;
      case 4:
        fill(0, 165, 31);
        break;
      }
      rect(j*scale, i*scale, scale, scale);
      fill(0);
      //println(cells[i][j].type);
      //text(cells[i][j].type, j*scale, i*scale);
    }
  }
}

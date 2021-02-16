import 'dart:io';

main(List<String> args) {
  var geology = new File('input03.txt').readAsLinesSync();
  var a = calculateTreesInSlope(geology, 1, 1);
  var b = calculateTreesInSlope(geology, 3, 1);
  var c = calculateTreesInSlope(geology, 5, 1);
  var d = calculateTreesInSlope(geology, 7, 1);
  var e = calculateTreesInSlope(geology, 1, 2);

  print(a*b*c*d*e);
}
int calculateTreesInSlope(List<String> geology, int columnAdditive, rowAdditive) {
  var trees = 0;
  var spotInColumn = 0;
  for( var spotInRow =0; spotInRow < geology.length; spotInRow+=rowAdditive ){
    var spot = geology[spotInRow][spotInColumn];

    if( spot == '#'){
      trees++;
    }

    spotInColumn +=columnAdditive;
    if(spotInColumn >= geology[0].length){
      spotInColumn -= geology[0].length;
    }
  }
  return trees;
}
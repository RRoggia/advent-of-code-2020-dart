import 'dart:io';

main(List<String> args) {
  var inputs = new File('input05.txt').readAsLinesSync();
  num highest =0;
  var seta=Set<int>();
  for( var input in inputs) {
    num row = 128;
    num column = 8;
    num min = 0;
    num max = 127;

    num minColumn = 0;
    num maxColumn = 7;

    for(var i = 0 ; i < 6; i++){
      row /= 2;
      if( input[i] == 'F' ){
        max -= row.toInt();
      } else {
        min = min + row.toInt();
      }
    }
    var finale = input[6] =='F'? min : max;
    
    for( var i =7; i<9;i++) {
      column /= 2;
      if( input[i] =='L'){
        maxColumn -= column;
      }else{
        minColumn += column;
      }
    }

    var finale2 = input[9] =='L'? minColumn : maxColumn;

    var a = finale * 8 + finale2;
    seta.add(a.toInt());

    if(  a > highest ){
      highest = a;
    }
  }
  var lista = seta.toList();
  lista.sort((a,b) => a-b);
  var truea= true;
  var cont = 68;
  var i = 0;
  while (truea) {
    if( lista[i] != cont){
      truea = false;
    }
    if(cont >1000){
      truea=false;
    }
    cont++;
    i++;
  }
  print(cont);

  print(highest.toInt());
}
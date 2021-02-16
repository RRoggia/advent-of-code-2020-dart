import 'dart:io';

main(List<String> args){
  var passwordsAndPolicies = new File('input02.txt').readAsLinesSync();

  var count = 0;

  for( var entry in passwordsAndPolicies ){

    var split = entry.split( '-' );
    var min = int.parse(split[0]);

    var split2 = split[1].split( ' ' );
    var max = int.parse(split2[0]);

    var split3 = split2[1].split( ':' );
    var letter = split3[0];

    var word = split2[2];

    var times = 0;
    
    for( var a in word.split('') ){
      if( a == letter ){
        times++;
      }
    }    

    if( times >= min && times <= max){
      count++;
    }
  }
  print(count);
}

// main(List<String> args) {
//   var passwordsAndPolicies = new File('input02.txt').readAsLinesSync();

//   var count = 0;

//   for( var entry in passwordsAndPolicies ){

//     var split = entry.split( '-' );
//     var min = int.parse(split[0]);

//     var split2 = split[1].split( ' ' );
//     var max = int.parse(split2[0]);

//     var split3 = split2[1].split( ':' );
//     var letter = split3[0];

//     var word = split2[2];

//     var letters = word.split('');
//     print(letters);
//     var a = letters[ min - 1];
//     var b = letters[ max - 1];
//     print(a);
//     print(b);
    
//     if( a == letter && !(b == letter) || !(a == letter) && b == letter){
//       count++;
//     }
//    print(count);
// }
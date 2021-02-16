import 'dart:io';

main(List<String> args) {
  var inputs = new File('input06.txt').readAsLinesSync();
  var total = 0;
  var current = Set<String>();
  var valid = Set<String>();
  var invalid = false;

  for( var line in inputs ){
    current = Set<String>();
    if(line.isEmpty) {
      total += valid.length;

      valid = Set<String>();
      invalid = false;
      continue;
    }
    current.addAll(line.split('').toSet());

    if( !invalid && valid.isEmpty) {
      valid.addAll(current);
      continue;
    } 
    var tmp = Set<String>();
    valid.forEach((e) {
      if(current.contains(e)){
        tmp.add(e);
      }else{
        invalid = true;
      }
    });
    valid = tmp;
    }

  total += current.length;
  print(total);
}
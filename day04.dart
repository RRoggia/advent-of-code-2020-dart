import 'dart:io';


// main(List<String> args) {
//   var input = File('input04.txt').readAsLinesSync();

//   var passport = Set<String>();
//   var validPass = 0;
//   for(var line in input){
//     if( line.isEmpty ){
//       if(passport.length == 7 && !passport.contains('cid') || passport.length > 7){
//         print(passport);
//         validPass++;
//       }
//       passport = Set<String>();
//       continue;
//     }

//     var keywords = line.split(' ');
//     print(keywords);
//     for(var word in keywords){
//       print(word);
//       print(word.split(':')[0]);
//       passport.add(word.split(':')[0]);
//     }
    
//   }
//   print(validPass);
// }

main(List<String> args) {
  var input = File('input04.txt').readAsLinesSync();

  var passport = Set<String>();
  var validPass = 0;

  var validateDigit = (value, min, max) {
    if( value.length > 4){
      return false;
    }
    var a = int.parse(value);
    return a >= min && a <= max;
  };

  var g = {
    'byr': (String value) => validateDigit(value, 1920,2002),
    'iyr': (String value) => validateDigit(value, 2010,2020),
    'eyr': (String value) => validateDigit(value, 2020,2030),
    'hgt': (String value) {
      if( value.contains('cm')){
        var b = value.split('cm')[0];
        var c = int.parse(b);
        return c >= 150 && c <=193;
      }else{
        var b = value.split('in')[0];
        var c = int.parse(b);
        return c >= 59 && c <=76;
      }
    },
    'hcl': (String value) {
      var valid = Set<String>();
      for( var i =0; i<10;i++){
        valid.add(i.toString());
      }
      valid.add('a');
      valid.add('b');
      valid.add('c');
      valid.add('d');
      valid.add('e');
      valid.add('f');

      var hasHash = false;
      var hasSix = false;
      if( value[0] =='#') {
        hasHash = true;
        var count = 0;
        for(var a in value.split('')){
          if(valid.contains(a)){
            count++;
          }else{
            count=0;
          }
        }
        hasSix = count == 6 && value.length == 7;
      }
      return hasHash && hasSix;
    },
    'ecl': (String value) {
      return value == 'amb' || value == 'blu' ||value == 'brn' || value =='gry' ||value =='grn'|| value =='hzl'|| value =='oth';
    },
    'pid': (String value) {
      return value.length == 9;
    },
    'cid': (any) => true
  };

  for(var line in input){
    if( line.isEmpty ){
      if(passport.length == 7 && !passport.contains('cid') || passport.length > 7){
        print(passport);
        validPass++;
      }
      passport = Set<String>();
      continue;
    }

    var keywords = line.split(' ');

    for(var word in keywords){
      var key = word.split(':')[0];
      var value = word.split(':')[1];
      print( key);
      if( g[key](value)){
        passport.add(word.split(':')[0]);
      }
    }
  }
  print(validPass);
}


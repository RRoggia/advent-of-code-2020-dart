import 'dart:collection';
import 'dart:io';

const SHINY_GOLD = 'shiny gold';
  RegExp exp = new RegExp(r"[0-9][\s\w]* ");


main( List<String> args) {
  var inputs = new File('input07.txt').readAsLinesSync();
  var bagNames = new HashMap<String, HashMap<String, int>>();
    
  for(var input in inputs) {
    var bagName = input.split('bags contain')[0].trim();
    var stringInnerBags = input.split('bags contain')[1];
    
    var innerBags = new HashMap<String,int>();
    if( !stringInnerBags.contains('no other bags')) {
      var matches = exp.allMatches(stringInnerBags);
      
      for(var match in matches){
          var number = int.parse(match.group(0).split(' ')[0]);
          var name = match.group(0).substring(number.toString().length);
          innerBags[name.trim()] = number;
      }
    }

    bagNames[bagName] = innerBags;
  }
  var teste = process(SHINY_GOLD, bagNames);
  print(teste);
  print(bagNames);
  
}

String process( bagName, HashMap<String, HashMap<String, int>>bagNames ){
  var innerBags = bagNames[bagName];
  
  var result = '3';

  for(var name in innerBags.keys) {
    result += '+ ${innerBags[name]} * (${process(name, bagNames)} )';
    //result += ' + ';
  }
  if( result == ''){
    return '1';
  }
  return result + '';
}

// main(List<String> args) {
//   var inputs = new File('input07.txt').readAsLinesSync();
//   var bagNames = new HashMap<String, Set<String>>();
  
//   for(var input in inputs) {
//     var bagName = input.split('bags contain')[0].trim();
//     var stringInnerBags = input.split('bags contain')[1];

//     bagNames[bagName] = getInnerBagNames(stringInnerBags);
//   }

//   var lookFor = new Set<String>();
//   lookFor.add(SHINY_GOLD);

//   print('result is ${lookForOutherBags(SHINY_GOLD, bagNames, lookFor).length}');
// }

HashMap<String, bool> lookForOutherBags(String innerBag, HashMap<String, Set<String>> bags, Iterable<String> done) {
  var lookIn = new HashMap<String, bool>();
  print('==> Part one - Look at innerbgs');
  for(var outterBag in bags.keys){
    print('looking for $innerBag at outer bag $outterBag');
    if( bags[outterBag].contains(innerBag)){
      print('found it');
      print('Have we already looked in the outterbag $outterBag?');
      if(!done.contains(outterBag)){
        print('No! look at $outterBag later');
        lookIn[outterBag] = true;
      }else{
        print('yup, we already look at it');
      }
    } else{
      print( 'didnt found it');
    }
  }

  print( lookIn );

  var internal = new HashMap<String, bool>();
  internal.addAll(lookIn);

  print('==> Part Two - Look at outterbags');

  for(var item in lookIn.entries) {
    print('Should we look at the ${item.key}? ${item.value}');
    if(item.value){
      lookIn[item.key] = false;
      print('looking in outter bag ${item.key}');
      var outter = lookForOutherBags(item.key, bags, lookIn.keys);
      internal.addAll(outter);
    }
  }
  print('before return $internal');
  return internal;
}



Set<String> getInnerBagNames(String stringInnerBags) {
  var innerBags = new Set<String>();
  for(var bag in stringInnerBags.split('bag') ){
    if( bag == ' no other ') {
      break;
    }

    var isSeparator = bag == 's,' || bag == 's.' || bag == '.';
    if( isSeparator ) {
      continue;
    }

    bag = bag.trimLeft();
    bag = bag.trimRight();
    
    var initial = bag.substring(0,1);
    var shiftRigth = 2;
    
    if( initial == 's' ) {
      shiftRigth = 5;
    } else if( initial == ',') {
      shiftRigth = 4;
    }

    var innerBagName = bag.substring(shiftRigth, bag.length );
    innerBags.add(innerBagName);
  }
  return innerBags;
}
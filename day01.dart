import 'dart:io';

main(List<String> args) {
  var expenseReportEntries = new File('input01.txt').readAsLinesSync().map(int.parse).toSet();
  
  var entry = expenseReportEntries
    .map((entry) => 2020 - entry)
    .firstWhere((entry) => expenseReportEntries.contains(entry));

  print( entry * ( 2020 - entry));  

  var found = false;
  for( var entry2 in expenseReportEntries){
    for (var entry3 in expenseReportEntries){
      var remaining = 2020 - (entry2 + entry3);
      if( expenseReportEntries.contains(remaining)){
        print('a $entry2');
        print('b $entry3');
        print('c $remaining');
        print(entry2 * entry3 * remaining);
        found=true;
        break;
      };
    }
    if(found){
      break;
    }
  }
}
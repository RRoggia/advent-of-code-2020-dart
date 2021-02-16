import 'dart:collection';
import 'dart:io';

main(List<String> args) {
  var commands = new File('input08.txt').readAsLinesSync()
    .map((e) => Instruction.getInstruction(e))
    .toList();

    // var counter = 0;
    // var steps = Set<int>();
    // counter = process(0, counter, commands, steps);
    // print(counter);

  
  for(var i =0; i<commands.length; i++){
    
    List<Instruction> commands2 = List.from(commands);
    if( commands[i] is NoOp ){
      commands2[i] = Jmp( commands[i].value);
    }else if ( commands[i] is Jmp) {
      commands2[i] = NoOp( commands[i].value);
    }

    var counter = 0;
    var steps = Set<int>();
    try {
      counter = process2(0, counter, commands2, steps);
      print(counter);
    }catch( e ){
      //print(e);
    }
  }
}

int process2( int position, int counter, List<Instruction> listOfCommands, Set<int> steps ) {
  
  if( steps.contains( position ) ) {
    throw Exception('infinite loop');
  } else {
     steps.add(position);
  }
  
  if( position == listOfCommands.length){
    return counter;
  }

  var command = listOfCommands.toList()[position];
  // print('$position - $command ${command.value}');
  if( command is Acc) {
    var total = counter + command.value;
    return process2(position + 1, total, listOfCommands, steps);
  } else if( command is NoOp){
    return process2(position+1, counter, listOfCommands, steps);
  } else {
    return process2(position + command.value, counter, listOfCommands, steps);
  }
}

int process( int position, int counter, List<Instruction> listOfCommands, Set<int> steps ) {
  
  if( steps.contains( position ) ) {
    return counter;
  } else {
     steps.add(position);
  }

  var command = listOfCommands.toList()[position];
  // print('$position - $command ${command.value}');
  if( command is Acc) {
    var total = counter + command.value;
    return process(position + 1, total, listOfCommands, steps);
  } else if( command is NoOp){
    return process(position+1, counter, listOfCommands, steps);
  } else {
    return process(position + command.value, counter, listOfCommands, steps);
  }
}

abstract class Instruction {
  int value;
  Instruction(this.value);

  static Instruction getInstruction( String instruction ){
    var value = int.parse(instruction.split(' ')[1]);
    if( instruction.startsWith('acc')) {
      return Acc(value);
    }else if( instruction.startsWith('jmp')){
      return Jmp(value);
    }else{
      return NoOp(value);
    }
  }
}

class Acc extends Instruction {
  Acc(int value) : super(value);
}

class NoOp extends Instruction {
  NoOp(int value) : super(value);
}

class Jmp extends Instruction {
  Jmp(int value) : super(value);  
}

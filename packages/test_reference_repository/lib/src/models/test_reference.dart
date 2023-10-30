import 'package:equatable/equatable.dart';

class TestReference implements Equatable
{
  final String id;
  bool done;
  var note;

  TestReference({required this.id, this.done = false, this.note});

  factory TestReference.base(String s){
    return TestReference(
      id: s,
      done: false,
      note: 2
    );
  }
  
  @override
  List<Object?> get props => [
    id,
    done,
    note
  ];
  
  @override
  bool? get stringify => true;
}
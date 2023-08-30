import 'dart:ffi';

class TestReference
{
  final String id;
  bool done;
  Float? note;

  TestReference({required this.id, this.done = false, this.note});
}
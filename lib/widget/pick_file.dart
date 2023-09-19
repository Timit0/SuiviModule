import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';

import '../enum/mode.dart';


class PickFile{
  static Future<String?> builder(Mode mode) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom, 
      allowedExtensions: [mode == Mode.JSONimportMode ? 'json' : 'csv'],
    );

    if(result != null){
      try{
        PlatformFile file = result.files.single;
        String fileFromBytes = String.fromCharCodes(file.bytes!);
        return utf8.decode(fileFromBytes.codeUnits);
      }catch(e){}
      
    }
  }
}

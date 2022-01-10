import 'dart:io';
import 'package:path_provider/path_provider.dart';

class CounterStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/count2.txt');
  }

  Future<File> writeData(int count2) async {
    final file = await _localFile;
    return file.writeAsString('$count2');
  }

  Future<int> readData() async {
    try {
      final file = await _localFile;
      final content = await file.readAsString();
      return int.parse(content);
    }
    catch (e) {
      return 0;
    }
  }
}
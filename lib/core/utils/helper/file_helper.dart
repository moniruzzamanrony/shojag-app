import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../resource/dependency_injection.dart';

/// [FileHelper] is a singleton class that provides utility methods to handle file operations.
/// It uses the [path_provider] package to get the app's directory path.
/// File related helper functions are defined in this class
///
class FileHelper {
  Future<String?> get externalDirectoryPath async {
    final directory = await getExternalStorageDirectory();
    return directory?.path;
  }

  Future<String> get documentsDirectoryPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<String> get temporaryDirectoryPath async {
    final directory = await getTemporaryDirectory();
    return directory.path;
  }

  Future<String> get cachedTempDirectoryPath async {
    final directory = await getApplicationCacheDirectory();
    return directory.path;
  }

  void deleteFile(String sourcePath) async {
    final fileNameWithExtension = getFileNameWithExtension(sourcePath);
    final dir = await documentsDirectoryPath;
    final parentDir = p.join(dir, uploadDir);
    final filePath = p.join(parentDir, fileNameWithExtension);
    final file = File(filePath);
    if (await file.exists()) {
      await file.delete();
    }
  }

  String uploadDir = 'upload';

  Future<File> createFile(String sourcePath, {String? fileName}) async {
    final sourceFile = File(sourcePath);
    if (!await sourceFile.exists()) {
      return Future.error('Could not create file');
    }
    final fileExtension = getFileExtension(sourcePath);
    final fileNameWithExtension = '$fileName.$fileExtension';

    final dir = await documentsDirectoryPath;
    final parentDir = p.join(dir, uploadDir);
    final filePath = p.join(parentDir, fileNameWithExtension);
    final file = File(filePath);
    if (!await Directory(parentDir).exists()) {
      await Directory(parentDir).create(recursive: true);
    }
    if (!await file.exists()) {
      return await sourceFile.copy(file.path);
    }
    return file;
  }

  Future<File?> checkFile(String sourcePath) async {
    final fileNameWithExtension = getFileNameWithExtension(sourcePath);
    final dir = await documentsDirectoryPath;
    final parentDir = p.join(dir, uploadDir);
    final filePath = p.join(parentDir, fileNameWithExtension);
    final file = File(filePath);
    if (await file.exists()) {
      return file;
    }
    return null;
  }

  Future<String> fileSavedPath(String url) async {
    final fileNameWithExtension = getFileNameWithExtension(url);
    final dir = await documentsDirectoryPath;
    final parentDir = p.join(dir, uploadDir);
    if (!await Directory(parentDir).exists()) {
      await Directory(parentDir).create(recursive: true);
    }
    final filePath = p.join(parentDir, fileNameWithExtension);

    return filePath;
  }

  String generatePath(
      {String? end,
      List<String>? subDirectories,
      bool useAppDirectory = true}) {
    final dir = appDirectoryPath;

    String tempPath = useAppDirectory ? p.join(dir) : '';
    for (final d in (subDirectories ?? <String>[])) {
      tempPath = p.join(tempPath, d);
    }
    if (end != null) {
      tempPath = p.join(tempPath, end);
    }
    return tempPath;
  }

  File getImageFileFromLocalStorage(String end,
      {List<String>? subDirectories}) {
    final filePath = generatePath(subDirectories: subDirectories);
    final fileAndNameExtension = getFileNameWithExtension(end);

    final imageFilePath = p.join(filePath, fileAndNameExtension);
    return File(imageFilePath);
  }

  File? renameFile(String filePath, String newName) {
    final file = File(filePath);

    if (file.existsSync()) {
      var path = file.path;
      var lastSeparator = path.lastIndexOf(Platform.pathSeparator);
      var extension = getFileExtension(path);
      var newPath =
          '${path.substring(0, lastSeparator + 1)}$newName.$extension';
      return file.renameSync(newPath);
    }
    return null;
  }

  String getFileNameWithExtension(String path) {
    final splitPaths = path.split('/');
    if (splitPaths.isNotEmpty) {
      return splitPaths.last;
    }
    return '';
  }

  String getFileExtension(String path) {
    final splitPaths = path.split(Platform.pathSeparator);
    if (splitPaths.isNotEmpty) {
      final fileNameWithExtension = splitPaths.last;

      final fileNameSplits = fileNameWithExtension.split('.');
      if (fileNameSplits.length > 1) {
        return fileNameSplits.last;
      }
    }
    return '';
  }

  String getFileName(String path) {
    final splitPaths = path.split(Platform.pathSeparator);
    if (splitPaths.isNotEmpty) {
      final fileNameWithExtension = splitPaths.last;

      final fileNameSplits = fileNameWithExtension.split('.');
      if (fileNameSplits.length > 1) {
        return fileNameSplits.first;
      }
    }
    return '';
  }

  Future<Uint8List?> getFileFromApi({required String url}) async {
    try {
      final response =
          await Dio(BaseOptions(responseType: ResponseType.bytes)).get(url);
      if (response.statusCode == 200) {
        return response.data;
      }
      return null;
    } on Exception catch (_) {
      return null;
    }
  }
}

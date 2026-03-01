// ignore_for_file: depend_on_referenced_packages

import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:path/path.dart' as path;
import 'package:zeraytee/CONTROLLER/CONST/Imports/packages.dart';

/// Optimized Cache Manager لحل مشكلة SlowSQLite
class OptimizedCacheManager extends CacheManager {
  static const key = 'optimizedCacheKey';

  static OptimizedCacheManager? _instance;

  factory OptimizedCacheManager() {
    _instance ??= OptimizedCacheManager._();
    return _instance!;
  }

  OptimizedCacheManager._()
    : super(
        Config(
          key,
          stalePeriod: const Duration(days: 7), // Cache validity
          maxNrOfCacheObjects: 200, // Limit cache size (كان 100)
          repo: JsonCacheInfoRepository(databaseName: key),
          fileService: HttpFileService(),
        ),
      );
}

/// استخدمه في كود الصور بدل DefaultCacheManager
class ImageHelper {
  static final _cacheManager = OptimizedCacheManager();

  /// Get cached image or download
  static Future<FileInfo?> getCachedImage(String url) async {
    try {
      final file = await _cacheManager.getSingleFile(url);
      return FileInfo(file, FileSource.Online, DateTime.now().add(const Duration(days: 7)), url);
    } catch (e) {
      debugPrint('Cache error: $e');
      return null;
    }
  }

  /// Clear old cache
  static Future<void> clearOldCache() async {
    await _cacheManager.emptyCache();
  }

  /// Get cache size
  static Future<int> getCacheSize() async {
    final dir = await getTemporaryDirectory();
    final cacheDir = Directory(path.join(dir.path, OptimizedCacheManager.key));

    if (!await cacheDir.exists()) return 0;

    int totalSize = 0;
    await for (var entity in cacheDir.list(recursive: true)) {
      if (entity is File) {
        totalSize += await entity.length();
      }
    }

    return totalSize;
  }
}

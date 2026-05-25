import 'package:equatable/equatable.dart';

class PickedFileInfo extends Equatable {
  final String name;
  final int sizeBytes;
  final String path;

  const PickedFileInfo({
    required this.name,
    required this.sizeBytes,
    required this.path,
  });

  String get displaySize {
    if (sizeBytes < 1024 * 1024) {
      return '${(sizeBytes / 1024).toStringAsFixed(1)} KB';
    }
    return '${(sizeBytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }

  @override
  List<Object?> get props => [path];
}

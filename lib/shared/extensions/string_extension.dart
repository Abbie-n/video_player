import 'package:jiffy/jiffy.dart';

extension StringExtension on String {
  String get convertToTimeAgo => Jiffy(this).fromNow();
}

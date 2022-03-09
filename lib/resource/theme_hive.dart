import 'package:hive/hive.dart';

part 'theme_hive.g.dart';

@HiveType(typeId: 1)
class ThemeResource {
  ThemeResource({this.status});

  @HiveField(1)
  bool? status;
}

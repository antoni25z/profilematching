import 'package:floor/floor.dart';

@entity
class Assessment {
  @PrimaryKey(autoGenerate: false)
  String id;

  String aspect;
  String criteria;
  int type;
  int bobot;
  double bobot_penilaian;
  int target;

  Assessment(
      {required this.id,
      required this.aspect,
      required this.criteria,
      required this.type,
      required this.bobot,
      required this.bobot_penilaian,
      required this.target});
}

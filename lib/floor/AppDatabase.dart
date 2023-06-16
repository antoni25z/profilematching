

import 'package:floor/floor.dart';
import 'package:gaspol/floor/Assessment.dart';
import 'package:gaspol/floor/AssessmentDao.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'AppDatabase.g.dart';

@Database(version: 1, entities: [Assessment])
abstract class AppDatabase extends FloorDatabase {
  AssessmentDao get assessmentDao;
}
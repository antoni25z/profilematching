import 'package:floor/floor.dart';

import 'Assessment.dart';

@dao
abstract class AssessmentDao {
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> addAssessment(Assessment assesment);
  
  @Query('SELECT * FROM Assessment')
  Future<List<Assessment>> getAllAssessments();

  @Query('DELETE * FROM Assessment')
  Future<void> clearAsstessment();
}
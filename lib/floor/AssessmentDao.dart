import 'package:floor/floor.dart';

import 'Assessment.dart';

@dao
abstract class AssessmentDao {
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> addAssessment(Assessment assesment);
  
  @Query('SELECT * FROM Assesment')
  Future<List<Assessment>> getAllAssessments();
}
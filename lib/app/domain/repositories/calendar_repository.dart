
abstract class CalendarRepository{

  Future<dynamic> createReminderInCalendar(String title , String des , DateTime dateEvent);
  Future<dynamic> createVideoConference(String title , String des , DateTime dateEvent);
  
}

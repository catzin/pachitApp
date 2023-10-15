
import '../../domain/repositories/index.dart';
import 'package:google_sign_in/google_sign_in.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:googleapis/calendar/v3.dart' as calendar;
import 'package:googleapis_auth/auth_io.dart' as auth;

class CalendarRepositoryImp implements CalendarRepository{
  @override
  Future createReminderInCalendar(String title , String des , DateTime dateEvent)async{


    try{

      //calc days and duration
    final DateTime startTime = DateTime(dateEvent.year, dateEvent.month, dateEvent.day,7,0,0).toUtc();
    final DateTime endTime = startTime.add(const Duration(days:1)).toUtc();

    //crear cliente de autenticación

    final GoogleSignInAccount? googleSignInAccount = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount!.authentication;

    final authClient = auth.authenticatedClient(

    http.Client(),
      auth.AccessCredentials(
        auth.AccessToken(
          'Bearer',
          googleSignInAuthentication.accessToken!,
          DateTime.now()
              .add(const Duration(hours: 1))
              .toUtc(), // Asume una validez de 1 hora
        ),
        googleSignInAuthentication.idToken,
        ['https://www.googleapis.com/auth/calendar'],
      ),
    );

     // Crear el objeto CalendarApi
    final cal = calendar.CalendarApi(authClient);

    // Definir el evento
    calendar.Event event = calendar.Event(); 

    //definir info del evento
    event.summary = title;
    event.description = des;

    calendar.EventDateTime start = calendar.EventDateTime();
    start.dateTime = startTime;
    start.timeZone = "GMT+00:00";
    event.start = start;

    calendar.EventDateTime end = calendar.EventDateTime();
    end.dateTime = endTime;
    end.timeZone = "GMT+00:00";
    event.end = end;
    String calendarId = "primary";
    final result = await cal.events.insert(event, calendarId);

    return result.htmlLink;

    }catch(e){
      throw Exception('Error en la solicitud calendar api: $e');
  
    }
    
  }
  
  @override
  Future createVideoConference(String title , String des , DateTime dateEvent) async {
    try {
      //calc days and duration
      final DateTime startTime = DateTime(dateEvent.year, dateEvent.month, dateEvent.day,7,0,0).toUtc();
      final DateTime endTime = startTime.add(const Duration(minutes:30)).toUtc();

      //crear cliente de autenticación
      final GoogleSignInAccount? googleSignInAccount = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount!.authentication;

      final authClient = auth.authenticatedClient(

    http.Client(),
      auth.AccessCredentials(
        auth.AccessToken(
          'Bearer',
          googleSignInAuthentication.accessToken!,
          DateTime.now()
              .add(const Duration(hours: 1))
              .toUtc(), // Asume una validez de 1 hora
        ),
        googleSignInAuthentication.idToken,
        ['https://www.googleapis.com/auth/calendar'],
      ),
    );

      // Crear el objeto CalendarApi
      final cal = calendar.CalendarApi(authClient);

      // Definir el evento
      calendar.Event event = calendar.Event(); 

      //definir info del evento
      event.summary = title;
      event.description = des;

      calendar.EventDateTime start = calendar.EventDateTime();
      start.dateTime = startTime;
      start.timeZone = "GMT+00:00";
      event.start = start;

      calendar.EventDateTime end = calendar.EventDateTime();
      end.dateTime = endTime;
      end.timeZone = "GMT+00:00";
      event.end = end;

      // Añade un enlace de Google Meet al evento
      event.conferenceData = calendar.ConferenceData(
        createRequest: calendar.CreateConferenceRequest(
          requestId: 'unique-request-id', // Asegúrate de que este ID sea único
          conferenceSolutionKey: calendar.ConferenceSolutionKey(type: 'hangoutsMeet'),
        ),
      );

       // Agrega un asistente al evento
      // event.attendees = [
      //   calendar.EventAttendee(email: 'alexiparrea@gmail.com'),
      // ];

      String calendarId = "primary";
      final result = await cal.events.insert(event, calendarId, conferenceDataVersion: 1);

      return result.htmlLink;

    } catch(e) {
      throw Exception('Error en la solicitud calendar api: $e');
    }
  }
 

}
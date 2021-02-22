import 'dart:convert';
import 'package:http/http.dart' as http;
import 'Tournaments.dart';

Future<List<Tournaments>> fetchTournaments() async {
  var response = await http.get('http://tournaments-dot-game-tv-prod.uc.r.appspot.com/tournament/api/tournaments_list_v2?limit=10&status=all');
  if (response.statusCode == 200) {
     var jsonData = json.decode(response.body)['data']['tournaments'];
     List<Tournaments> tournaments = [];

     for (var json in jsonData) {
        Tournaments tournament = Tournaments(tournamentName: json['name'], tournamentType: json['tournament_type'], url: json['cover_url']);
        tournaments.add(tournament);
     }
     print(tournaments.length);

     return tournaments;
  } else {
    throw Exception('Failed to load album');
  }
}

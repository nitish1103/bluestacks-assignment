import 'package:flutter/material.dart';
import 'getTournaments.dart';
import 'Tournaments.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({this.userName, this.passWord});

  final String userName;
  final String passWord;

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Future<List<Tournaments>> futureRecommendations;
  String profileName;
  String imagePath;
  int rating;
  int tournamentPlayed;
  int tournamentWon;
  int winningPercentage;

  void initState() {
    super.initState();
    futureRecommendations = fetchTournaments();
    if (true) {
      profileName = 'Simon Baker';
      imagePath = 'images/john.jpg';
      rating = 2250;
      tournamentPlayed = 19;
      tournamentWon = 9;
      winningPercentage = 19;
    } else {
      profileName = 'John Doe';
      imagePath = 'images/john.jpg';
      rating = 3250;
      tournamentPlayed = 29;
      tournamentWon = 9;
      winningPercentage = 19;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.white38,
            centerTitle: true,
            title: Text(
              'FlyingWolf',
              style: TextStyle(color: Colors.black),
            )),
        body: Container(
          child:
          SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage(imagePath),
                        radius: 40.0,
                      ),
                      Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 18.0),
                            child: Text(
                              'Simon Baker',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 18.0),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.blue, width: 1.0),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                '$rating Elo Rating',
                                style: TextStyle(color: Colors.blue),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    width: double.infinity,
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(12.0),
                                bottomLeft: Radius.circular(12.0)),
                            color: Color(0xffE89200),
                          ),
                          width: MediaQuery.of(context).size.width * 0.28,
                          height: 90.0,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(
                              '$tournamentPlayed Tournament Played',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.28,
                          height: 90.0,
                          color: Color(0xff9900BE),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(
                              '$tournamentWon Tournament Won',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(12.0),
                                bottomRight: Radius.circular(12.0)),
                            color: Color(0xffED5E47),
                          ),
                          width: MediaQuery.of(context).size.width * 0.28,
                          height: 90.0,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(
                              '$winningPercentage      Winning Percentage',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  child: Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Text(
                        'Recommended for you',
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                      )),
                ),
                FutureBuilder(
                  future: futureRecommendations,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.data == null) {
                      return Container(
                        child: Center(
                          child: Text("Loading..."),
                        ),
                      );
                    } else {
                      return
                        Scrollbar(
                          child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Card(
                                child: Column(
                                  children: [
                                    Container(
                                        child: Image.network(
                                            snapshot.data[index].url)),
                                    Text(
                                      snapshot.data[index].tournamentName,
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                      ),
                        );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

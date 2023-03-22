import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var chars = ["", "", "", "", "", "", "", "", ""];
  int counter = 0;
  String player = 'X';
  int flagX = 0;
  int flagO = 0;
  int sonuc = 0;
  String tmp = '';
  var color1 = Colors.black38;
  var color2 = Colors.yellow.shade100;
  void playX(String s, int n) {
    if (chars[n] == '' && chars[n] != 'O' && chars[n] != 'X') {
      chars[n] = s;
    }
  }

  void playO(String s, int n) {
    if (chars[n] == '' && chars[n] != 'X' && chars[n] != 'O') {
      chars[n] = s;
    }
  }

  void alert(String s, int sonuc) {
    if (sonuc == 1) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Oyun Bitti!"),
              content: Text("Winner is $s!"),
              actions: [
                TextButton(
                  child: const Text("Play Again"),
                  onPressed: () {
                    reset();
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          });
    } else if (sonuc == 0) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Oyun Bitti!"),
              content: const Text("Draw!"),
              actions: [
                TextButton(
                  child: const Text("Play Again"),
                  onPressed: () {
                    reset();
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          });
    }
  }

  int kontrol(int flag, String s) {
    int i, j;
    int sayacX = 1;
    i = 0;
    while (i < 7 && flag == 0) {
      sayacX = 1;
      for (j = 1; j < 3; j++) {
        if (chars[i] == chars[i + j] && chars[i] == s) {
          sayacX++;
        }
      }
      if (sayacX == 3) {
        flag = 1;
      }
      i += 3;
    }
    if (sayacX != 3 && flag == 0) {
      if (chars[0] == chars[4] && chars[4] == chars[8] && chars[0] == s) {
        flag = 1;
      } else if (chars[2] == chars[4] &&
          chars[4] == chars[6] &&
          chars[2] != '') {
        flag = 1;
      }
    }
    if (flag == 0) {
      sayacX = 1;
      i = 0;
      while (i < 3 && flag == 0) {
        j = i + 3;
        if (chars[i] == chars[j] && chars[j] == chars[j + 3] && chars[i] == s) {
          flag = 1;
        }
        i++;
      }
    }
    return flag;
  }

  void reset() {
    setState(() {
      chars = ["", "", "", "", "", "", "", "", ""];
      counter = 0;
      player = 'X';
      flagX = 0;
      flagO = 0;
      sonuc = 0;
      tmp = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    var ekran = MediaQuery.of(context);
    final double yukseklik = ekran.size.height;
    final double genislik = ekran.size.width;
    return Scaffold(
      appBar: AppBar(
        title: AnimatedTextKit(
          animatedTexts: [
            TyperAnimatedText('TİC ',
                textStyle: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'Comfortaa')),
            TyperAnimatedText('TAC',
                textStyle: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'Comfortaa')),
            TyperAnimatedText('TOE',
                textStyle: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'Comfortaa')),
            TyperAnimatedText('TİC TAC TOE',
                textStyle: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'Comfortaa')),
          ],
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 40.0, bottom: 30.0),
            child: Text(
              "You are player X",
              style: TextStyle(
                fontFamily: 'Comfortaa',
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1.0,
                ),
                itemCount: chars.length,
                itemBuilder: (context, indeks) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: genislik / 3,
                        height: yukseklik / 6,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 8.0, bottom: 8.0, left: 10.0, right: 10.0),
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                if (player == 'X') {
                                  tmp = player;
                                  playX(player, indeks);
                                  counter++;
                                  sonuc = kontrol(flagX, player);
                                  if (sonuc == 1) {
                                    alert(tmp, sonuc);
                                  } else if (sonuc == 0 && counter == 9) {
                                    alert(tmp, sonuc);
                                  }
                                  player = 'O';
                                } else if (player == 'O') {
                                  tmp = player;
                                  playO(player, indeks);
                                  counter++;
                                  sonuc = kontrol(flagO, player);
                                  if (sonuc == 1) {
                                    alert(tmp, sonuc);
                                  } else if (sonuc == 0 && counter == 9) {
                                    alert(tmp, sonuc);
                                  }
                                  player = 'X';
                                }
                              });
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.teal,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0))),
                            child: Text(
                              chars[indeks],
                              style: TextStyle(
                                  color:
                                      (chars[indeks] == 'X' ? color1 : color2),
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Comfortaa',
                                  fontSize: yukseklik / 10),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 100.0),
            child: Text(
              "Player $player turn",
              style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                  fontFamily: 'Comfortaa'),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.grey.shade50,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  
  bool turn = true;
  int punteggioX=0, punteggioO=0;
  List<String> displayExOh = ['', '', '',
                              '', '', '', 
                              '', '', '', ];
  
  static var titolo = GoogleFonts.pressStart2p(
    textStyle: TextStyle(color: Colors.white, 
    fontSize: 20, 
    fontWeight: FontWeight.bold,),
  );
  static var sottotitolo = GoogleFonts.pressStart2p(
    textStyle: TextStyle(
    color: Colors.grey[300], 
    fontSize: 15, 
    fontWeight: FontWeight.bold
  )
  );
  static var nibba = GoogleFonts.pressStart2p(
    textStyle: TextStyle(
      color: Colors.grey[900], 
      fontSize: 10, 
    )
  );
  



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Player x", style: titolo,),
                        SizedBox(height: 10,),
                        Text(punteggioX.toString(), style: sottotitolo,),
                      ],
                    ),
                    SizedBox(width: 50,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Player o", style: titolo,),
                        SizedBox(height: 10,),
                        Text(punteggioO.toString(), style: sottotitolo,),
                      ],
                    )
                  ],
                ),
                ),
              ),
            ),
          Expanded(
            flex: 3,
            child: Container(
              margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: GridView.builder(
                itemCount: 9,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                itemBuilder: (BuildContext context, int index){
                  return GestureDetector(
                    onTap: (){_tapped(index);},
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[700])
                      ),
                      child: Center(
                        child: Text(
                          displayExOh[index], 
                          style: GoogleFonts.sedgwickAveDisplay(
                            textStyle: TextStyle(
                              color: Colors.white, 
                              fontSize: 40
                            ),
                          ),
                        )
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Text("@matty_105", style: titolo),
            ),
          )

        ],
      ),
    );
  }

  void _tapped(int index){
    setState(() {
      if(displayExOh[index]==''){
        displayExOh[index] = (turn)?'o':'x';
        turn = !turn;
        _checkWinner();
      }
    });
  }

  void _checkWinner(){
    if(displayExOh[0]==displayExOh[1] &&
       displayExOh[1]==displayExOh[2] &&
       displayExOh[0]!='') _showWinDialog();

    else if(displayExOh[3]==displayExOh[4] &&
       displayExOh[4]==displayExOh[5] &&
       displayExOh[3]!='') _showWinDialog();
    
    else if(displayExOh[6]==displayExOh[7] &&
       displayExOh[7]==displayExOh[8] &&
       displayExOh[6]!='') _showWinDialog();
    
    else if(displayExOh[0]==displayExOh[3] &&
       displayExOh[3]==displayExOh[6] &&
       displayExOh[0]!='') _showWinDialog();

    else if(displayExOh[1]==displayExOh[4] &&
       displayExOh[4]==displayExOh[7] &&
       displayExOh[1]!='') _showWinDialog();

    else if(displayExOh[2]==displayExOh[5] &&
       displayExOh[5]==displayExOh[8] &&
       displayExOh[2]!='') _showWinDialog();

    else if(displayExOh[0]==displayExOh[4] &&
       displayExOh[4]==displayExOh[8] &&
       displayExOh[0]!='') _showWinDialog();
    
    else if(displayExOh[2]==displayExOh[4] &&
       displayExOh[4]==displayExOh[6] &&
       displayExOh[2]!='') _showWinDialog();
    else{
      bool flag = false;
      for(int i = 0; i<displayExOh.length; i++){
        if(displayExOh[i]=='') flag = true;
      }
      if(!flag) _noOneWins();
    }
    

  }
  

  void _noOneWins(){
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          title: Text("It's a draw", style: nibba,),
          actions: <Widget>[
            FlatButton(
              onPressed: (){
                _clearBoard();
                Navigator.of(context).pop();
              }, 
              child: Text("Play Again!", style: nibba,)
            ),
          ],
        );
      }
    );
  }

  void _showWinDialog(){
    String winner = (!turn)?'o':'x';
    if(!turn) setState(() {punteggioO++;});
    else setState(() {punteggioX++;});
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          title: Text("$winner is the Winner", style: nibba,),
          actions: <Widget>[
            FlatButton(
              onPressed: (){
                _clearBoard();
                Navigator.of(context).pop();
              }, 
              child: Text("Play Again!", style: nibba,)
            ),
          ],
        );
      }
    );
  }

  void _clearBoard(){
    for(int i = 0; i<displayExOh.length; i++){
      setState(() {displayExOh[i]='';});
    }
  }

}




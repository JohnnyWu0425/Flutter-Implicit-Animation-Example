import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main()
{
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  // parameter for image
  String displayStr = "Hide Image";
  bool displayFlag = true;

  double containerWidth = 100;
  double containerHeight = 100;

  double distFromLeft = 130;

  // parameter for white animation box
  double beginWidth = 100;
  double endWidth = 100;
  bool rightMoveCompleted = true;
  bool leftMoveCompleted = true;
  var curLeftDist;
  double oldLeftDist = 50;
  var curRightDist;
  double oldRightDist = 204;
  bool initPos = true;
  bool moveRight = true;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "Implicit Animation Example",
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[

            Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Container(
                  width: 400,
                  height: 400,
                  color: Colors.red[100],
                ),

                AnimatedPositioned(
                  left: distFromLeft,
                  
                  duration: Duration(seconds: 1),
                  child: AnimatedContainer(
                    width: containerWidth,
                    height: containerHeight,

                    child: AnimatedOpacity(
                      opacity: (displayFlag)? (1):(0),
                      duration: Duration(seconds: 1),
                      child: Image(
                        width: containerWidth,
                        height: containerHeight,
                        fit: BoxFit.fill,
                        image: AssetImage("images/flutter.png"),
                      ),
                    ),

                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                    ),

                    duration: Duration(seconds: 1),
                  ),
                ),


                TweenAnimationBuilder(
                  tween: Tween(begin: beginWidth, end: endWidth),
                  duration: Duration(milliseconds: 500),
                  builder: (_, double value, __){
                    return Positioned(
                      left: (initPos)? (oldLeftDist):(curLeftDist),
                      right: (initPos)? (null):(curRightDist),
                      bottom: 10,
                      child: Container(
                        height: 50,
                        width: value,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: (moveRight)? (CrossAxisAlignment.start):(CrossAxisAlignment.end),
                            children: <Widget>[
                              Icon(
                                Icons.brightness_1,
                                color: Colors.black,
                                size: 10,
                              ),

                              SizedBox(
                                height: 5,
                              ),

                              Icon(
                                Icons.brightness_1,
                                color: Colors.black,
                                size: 10,
                              ),
                            ],
                          ),
                        ),
                        decoration: BoxDecoration(
                          color: Colors.brown[500],
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                      ),
                    );
                  },

                  onEnd: (){
                    if(!rightMoveCompleted){
                      setState(() {
                        beginWidth = endWidth;
                        endWidth -= 15;

                        curRightDist = oldRightDist;
                        oldLeftDist += 15;
                        curLeftDist = null;

                        rightMoveCompleted = true;
                      });
                    }

                    if(!leftMoveCompleted){
                      setState(() {
                        beginWidth = endWidth;
                        endWidth -= 15;

                        curLeftDist = oldLeftDist;
                        oldRightDist += 15;
                        curRightDist = null;

                        leftMoveCompleted = true;
                      });
                    }
                  },
                ),

              ],
            ),


            SizedBox(
              height: 50,
            ),

            CupertinoButton(
              child: Text(
                "$displayStr",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
              borderRadius: BorderRadius.circular(18.0),
              color: Colors.lightBlue[200],

              onPressed: (){
                setState(() {
                  displayStr = (displayFlag)? ("Show Image"):("Hide Image");
                  displayFlag = !displayFlag;
                });
              },
            ),

            SizedBox(
              height: 20,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                CupertinoButton(
                  padding: EdgeInsets.all(18.0),
                  child: Text(
                    "Enlarge",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 19,
                    ),
                  ),
                  borderRadius: BorderRadius.circular(18.0),
                  color: Colors.lightBlue[200],

                  onPressed: (){
                    setState(() {
                      containerWidth += 15;
                      containerHeight += 15;
                      distFromLeft -= 7.5;
                    });
                  },
                ),

                SizedBox(
                  width: 14,
                ),

                CupertinoButton(
                  padding: EdgeInsets.all(18.0),
                  child: Text(
                    "Shrink",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 19,
                    ),
                  ),
                  borderRadius: BorderRadius.circular(18.0),
                  color: Colors.lightBlue[200],

                  onPressed: (){
                    setState(() {
                      containerWidth -= 15;
                      containerHeight -= 15;
                      distFromLeft += 7.5;
                    });
                  },
                ),

              ],
            ),

            SizedBox(
              height: 20,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                CupertinoButton(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: Icon(
                    Icons.arrow_back,
                    size: 30,
                    color: Colors.black,
                  ),
                  borderRadius: BorderRadius.circular(18.0),
                  color: Colors.lightBlue[200],

                  onPressed: (){
                    setState(() {
                      distFromLeft -= 15;
                    });
                  },
                ),

                SizedBox(
                  width: 20,
                ),

                CupertinoButton(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: Icon(
                    Icons.arrow_forward,
                    size: 30,
                    color: Colors.black,
                  ),
                  borderRadius: BorderRadius.circular(18.0),
                  color: Colors.lightBlue[200],

                  onPressed: (){
                    setState(() {
                      distFromLeft += 15;
                    });
                  },
                ),

              ],
            ),

            SizedBox(
              height: 20,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                CupertinoButton(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: Icon(
                    Icons.arrow_back,
                    size: 30,
                    color: Colors.black,
                  ),
                  borderRadius: BorderRadius.circular(18.0),
                  color: Colors.lightBlue[200],

                  onPressed: (){
                    setState(() {
                      beginWidth = endWidth;
                      endWidth += 15;

                      curRightDist = oldRightDist;
                      oldLeftDist -= 15;
                      curLeftDist = null;

                      leftMoveCompleted = false;
                      initPos = false;

                      moveRight = true;
                    });
                  },
                ),

                SizedBox(
                  width: 20,
                ),

                CupertinoButton(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: Icon(
                    Icons.arrow_forward,
                    size: 30,
                    color: Colors.black,
                  ),
                  borderRadius: BorderRadius.circular(18.0),
                  color: Colors.lightBlue[200],

                  onPressed: (){
                    setState(() {
                      beginWidth = endWidth;
                      endWidth += 15;

                      curLeftDist = oldLeftDist;
                      oldRightDist -= 15;
                      curRightDist = null;

                      rightMoveCompleted = false;
                      initPos = false;

                      moveRight = false;
                    });
                  },
                ),

              ],
            ),
          ],
        ),
      ),
    );
  }
}

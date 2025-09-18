import 'dart:async';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:video_player/video_player.dart';

class VideoWidget extends StatefulWidget {
  final VideoPlayerController controller;
  VideoWidget({super.key, required this.controller});
  @override
  State<VideoWidget> createState() => _VideoWidgetState(this.controller);
}
class _VideoWidgetState extends State<VideoWidget> with SingleTickerProviderStateMixin {
  final VideoPlayerController _controller;
  late AnimationController controller;
  late final Animation<double> curve;
  _VideoWidgetState(this._controller);
  @override
  void initState() {
    super.initState();
    controller=AnimationController(vsync: this,duration: Duration(seconds: 5));
    curve=CurvedAnimation(parent: controller, curve: Curves.easeInOut);
    Timer(Duration(milliseconds: 300) ,(){
      controller.repeat();
    });

  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(children: [
        InkWell(
            onTap: (){
              _controller.value.isPlaying? _controller.pause():_controller.play();
              setState(() {

              });
            },
            child: VideoPlayer(_controller)),
        Column(
          children: [
            Expanded(
              child: Container(
                height: MediaQuery.of(context).size.height,

              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    height: 60,
                    width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.symmetric(horizontal:
                      MediaQuery.of(context).size.width/3),
                      child:_controller.value.isPlaying?Container():
                      IconButton(
                        onPressed: (){
                          _controller.play();
                          setState(() {

                          });
                        },
                        icon:Icon(Icons.play_arrow_rounded,size: 60),color: Colors.white54,)),
                ),
                Container(
                  width: 80,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Column(
                          children: [
                            Container(
                                 height: 80,
                                child: Stack(
                                  children: [
                                    Container(
                                      width: 50 ,
                                      child:CircleAvatar(
                                        radius: 35,
                                        backgroundImage: AssetImage("image/sapeur.jpg",
                                        ),) ,
                                      decoration:BoxDecoration(
                                          border: Border.all(color: Colors.white),
                                          shape: BoxShape.circle
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 8,
                                      left: 17,
                                      child: CircleAvatar(
                                          radius: 10,
                                          backgroundColor: Colors.redAccent,
                                          child: Icon(Icons.add,
                                            size: 20,color:Colors.white,weight: 20,)),
                                    )
                                  ],
                                )),
                            Container(
                                height: 60,
                                child: Icon(
                                    Icons.favorite
                                )),
                            Container(
                                height: 60,
                                child: Icon(IonIcons.chatbubble_ellipses)),
                            Container(
                                height: 60,
                                child: Icon(Icons.bookmark)),
                            Container(
                                height: 60, child: Icon(IonIcons.arrow_redo)),
                            Container(
                                height: 60,
                                child:RotationTransition(
                                  turns: curve,
                                  child: CircleAvatar(
                                    radius: 25,
                                    backgroundImage: AssetImage("image/sapeur.jpg"),
                                  ),
                                )
                            )],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ]),
    );
  }
}

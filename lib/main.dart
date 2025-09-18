import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mytik_tok/video_widget.dart';
import 'package:video_player/video_player.dart';
import 'class_page_video.dart';

void main(){
  runApp(MaterialApp(
    theme: ThemeData(iconTheme: IconThemeData(size: 40,color: Colors.white)),
    home: MyTikTok(),
    debugShowCheckedModeBanner: false,
  ));
}
class MyTikTok extends StatefulWidget {
   MyTikTok({super.key});
  @override
  State<MyTikTok> createState() => _MyTikTokState();
}
class _MyTikTokState extends State<MyTikTok> {
  PageController page_controller=PageController();
  List<VideoPlayerController> _controllers=[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initVideo();
    page_controller.addListener(() {
      final page=page_controller.page?.round();
      if(page!=null && page<_controllers.length){
        _playOnly(page);
        setState(() {

        });
      }
    },);
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }
  void initVideo(){
    late VideoPlayerController controller;
    for(var video in mesVideos){
       controller=VideoPlayerController.asset(video.video)..initialize().then((_) {
      },)..setLooping(true);
       _controllers.add(controller);
    }
    WidgetsBinding.instance.addPostFrameCallback((_) => _playOnly(0) );
  }
  void _playOnly(int index){
    for(var i=0;i<_controllers.length;i++){
      if(i==index){
        _controllers[i].play();
      }
      else{
        _controllers[i].pause();
      }
    }
    setState(() {

    });
  }
  @override
  void dispose() {
    // TODO: implement dispose
    for(var controller in _controllers){
      controller.dispose();
    }
    page_controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body:Stack(
       children: [
         PageView.builder(
             scrollDirection: Axis.vertical,
             itemCount: mesVideos.length,
             controller: page_controller,
             itemBuilder: (context,index){
             return
             VideoWidget(controller: _controllers[index],);
         }),
         Container(
             height: 200,
             child: Padding(
               padding: const EdgeInsets.only(top: 50),
               child: Row(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Expanded(
                     child: Container(
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           Text("Suivis",
                               style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 20)),
                             SizedBox(width: 20),
                           Text("Pour toi",
                               style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 20)),
                         ],
                       ),
                     ),
                   ),
                 Container(
                   padding: EdgeInsets.only(right: 15),
                   child:Icon(Icons.search_outlined) ,
                 )

                 ],
               ),
             )),
       ],
     ),
      bottomNavigationBar: BottomNavigationBar(
        mouseCursor: MouseCursor.uncontrolled,
        iconSize: 25,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Accueil"),
          BottomNavigationBarItem(
              icon: Icon(Icons.people_alt_outlined),
              label: "Amis"),
          BottomNavigationBarItem(
              icon: Image.asset("image/icone.jpg",
              width: 50,),
              label: ""),
          BottomNavigationBarItem(
              icon: Icon(Icons.messenger_outline),
              label: "Boite de réception"),
          BottomNavigationBarItem(
              icon: Icon(Icons.perm_identity_sharp),
              label: "Profil"),
        ],
        showUnselectedLabels: true,
      ),
    );
  }
}



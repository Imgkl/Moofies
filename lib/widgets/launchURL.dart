// import 'package:url_launcher/url_launcher.dart';
// //always make sure that the link has https prefix and not just www

// _launchURLTrailer(var videos) async{
//     if(videos.length!=0){
//       String key;
//       for(int i=videos.length-1;i>=0;i--){
//         if(videos[i]['type']=='Trailer'){
//           key = videos[i]['key'];
//           break;
//         }
//         continue;
//       }
//       String url = "https://www.youtube.com/watch?v=$key";
//       if(await canLaunch(url)){
//         await launch(url);
//       }
//       else{
//         throw 'Could Not launch url';
//       }
//     }
// }
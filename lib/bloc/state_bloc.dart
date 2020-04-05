 import 'dart:async';

import 'package:moofies/bloc/state_provider.dart';

class StateBloc {
   StreamController animationController = StreamController();
   final StateProvider provider = StateProvider();

   Stream get animationStatus => animationController.stream.asBroadcastStream();

   void toggleAnimation(){
     provider.toggleAnimationValue();
     animationController.sink.add(provider.isAnimating); 
   }
   

   void dispose(){
     
     animationController.close();
   }
 }

 final statebloc = StateBloc();
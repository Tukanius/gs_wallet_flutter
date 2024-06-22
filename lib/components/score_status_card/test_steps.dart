// import 'dart:async';

// import 'package:after_layout/after_layout.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:green_score/api/auth_api.dart';
// import 'package:green_score/api/score_api.dart';
// import 'package:green_score/components/custom_button/custom_button.dart';
// import 'package:green_score/components/score_status_card/bar_data/bar_graph.dart';
// import 'package:green_score/models/accumlation.dart';
// import 'package:green_score/models/user.dart';
// import 'package:green_score/provider/user_provider.dart';
// import 'package:green_score/src/profile_page/dan_verify_page/dan_verify_page.dart';
// import 'package:green_score/src/score_page/collect_score_page/collect_step_page.dart';
// import 'package:green_score/widget/ui/color.dart';
// import 'package:lottie/lottie.dart';
// import 'package:pedometer/pedometer.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:provider/provider.dart';
// import 'package:socket_io_client/socket_io_client.dart' as io;

// class StepStatusCard extends StatefulWidget {
//   final bool? isActive;
//   final String assetPath;
//   final String pushWhere;
//   const StepStatusCard({
//     super.key,
//     required this.assetPath,
//     this.isActive,
//     required this.pushWhere,
//   });

//   @override
//   State<StepStatusCard> createState() => _StepStatusCardState();
// }

// class _StepStatusCardState extends State<StepStatusCard> with AfterLayoutMixin {
//   late io.Socket socket;
//   socketListener() {
//     socket.onConnect((data) => debugPrint('Socket Connection'));
//     socket.onDisconnect((data) => debugPrint('Disconnect'));
//     socket.onConnectError((data) => debugPrint('Socket Connection Error'));
//     socket.on('data', (data) {
//       debugPrint('Received data from server: $data');
//     });
//     socket.onReconnect((data) {
//       debugPrint('Reconnected to the socket server');
//     });
//     socket.onReconnecting((data) {
//       debugPrint('Reconnecting to the socket server');
//     });
//   }

//   List<double> stepsForLast7Days = List<double>.filled(7, 0.0);
//   bool isLoading = true;
//   bool isGraphLoad = false;
//   Accumlation walk = Accumlation();
//   User user = User();
//   num stepped = 0;
//   late StreamSubscription<StepCount> subscription;
//   bool show = false;
//   @override
//   afterFirstLayout(BuildContext context) async {
//     user = await AuthApi().me(false);
//     await requestPermission();
//     await getWalk();

//     String url = 'https://dev-gs.zto.mn';
//     socket = io.io(
//       url,
//       io.OptionBuilder().setTransports(['websocket']).setQuery({
//         'token': '${Provider.of<UserProvider>(context, listen: false).myToken}',
//       }).build(),
//     );
//     // socket.onConnect((_) {
//     //   print('Connected');
//     //   Accumlation test =
//     //       Accumlation(balanceAmount: 123, latitude: 1, longitude: 2);
//     //   print('========');
//     //   // socket.emitWithAck('action', test.toJson(), ack: (data) {
//     //   //   print('Server acknowledgment received: $data');
//     //   // });

//     //   socket.emit('action', {
//     //     {
//     //       'type': 'walk',
//     //       'payload': {
//     //         'amount': 123,
//     //         'latitude': 1,
//     //         'longitude': 2,
//     //       }
//     //     }
//     //   });

//     //   print('========');
//     // });

//     socketListener();
//   }

//   getWalk() async {
//     try {
//       walk.type = "WALK";
//       walk.code = "WALK_01";
//       walk = await ScoreApi().getStep(walk);
//       walk.lastWeekTotal != null
//           ? stepsForLast7Days = walk.lastWeekTotal!
//               .map((data) => data.totalAmount!.toDouble())
//               .toList()
//           : List<double>.filled(7, 0.0);

//       if (walk.balanceAmount == 0 || walk.balanceAmount == null) {
//         setState(() {
//           stepped = 0;
//         });
//       } else {
//         setState(() {
//           stepped = walk.balanceAmount!;
//         });
//       }
//       setState(() {
//         isGraphLoad = false;
//         isLoading = false;
//       });
//     } catch (e) {
//       setState(() {
//         isGraphLoad = false;
//         isLoading = false;
//       });
//       print(e.toString());
//     }
//   }

//   requestPermission() async {
//     final PermissionStatus status =
//         await Permission.activityRecognition.request();
//     print('===========STEP PERMISSION========');
//     print(status);
//     print('===========STEP PERMISSION========');
//     if (status == PermissionStatus.granted) {
//       calculateStep();
//     } else {
//       calculateStep();
//     }
//     if (status == PermissionStatus.permanentlyDenied) {
//       // openAppSettings();
//     }
//   }

//   // void calculateStep() async {
//   //   Accumlation sendWalk = Accumlation();
//   //   int? previousStepCount;
//   //   subscription = Pedometer.stepCountStream.listen(
//   //     (event) {
//   //       int currentStepCount = event.steps;
//   //       int stepsSinceLastEvent = previousStepCount != null
//   //           ? currentStepCount - previousStepCount!
//   //           : 0;
//   //       previousStepCount = currentStepCount;
//   //       if (mounted) {
//   //         setState(() {
//   //           sendWalk.amount = stepsSinceLastEvent.toString();
//   //           stepped += stepsSinceLastEvent;
//   //           if (previousStepCount != null && stepsSinceLastEvent != 0) {
//   //             ScoreApi().sendStep(sendWalk);
//   //           }
//   //         });
//   //       }
//   //     },
//   //   );
//   // }
//   int accumulatedSteps = 0;

//   void calculateStep() async {
//     Accumlation sendWalk = Accumlation();
//     int? previousStepCount;

//     subscription = Pedometer.stepCountStream.listen(
//       (event) async {
//         int currentStepCount = event.steps;
//         int stepsSinceLastEvent = previousStepCount != null
//             ? currentStepCount - previousStepCount!
//             : 0;
//         previousStepCount = currentStepCount;

//         if (stepsSinceLastEvent > 0) {
//           accumulatedSteps += stepsSinceLastEvent;
//         }
//         setState(() {
//           stepped += stepsSinceLastEvent;
//           print('=====ULDEGDEL====');
//           print(accumulatedSteps);
//           print('=====ULDEGDEL====');
//         });
//         if (mounted && accumulatedSteps > 20) {
//           sendWalk.amount = accumulatedSteps;
//           accumulatedSteps = accumulatedSteps - accumulatedSteps;
//           if (previousStepCount != null) {
//             socket.emit('action', {
//               {
//                 'type': 'walk',
//                 'payload': {
//                   'amount': sendWalk.amount,
//                   // 'latitude': 1,
//                   // 'longitude': 2,
//                 }
//               }
//             });
//             // socket.onConnect((_) {
//             //   print('Connected');
//             //   print('========');

//             //   socket.emit('action', {
//             //     {
//             //       'type': 'walk',
//             //       'payload': {
//             //         'amount': sendWalk.amount,
//             //         // 'latitude': 1,
//             //         // 'longitude': 2,
//             //       }
//             //     }
//             //   });

//             //   print('========');
//             // });
//             // await ScoreApi().sendStep(sendWalk);
//           }
//         }
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: MediaQuery.of(context).size.width,
//       padding: EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(26),
//         color: buttonbg,
//       ),
//       child: Column(
//         children: [
//           Row(
//             children: [
//               widget.isActive == true
//                   ? Row(
//                       children: [
//                         Lottie.asset(
//                           'assets/lottie/live.json',
//                           height: 50,
//                           width: 50,
//                         ),
//                         SizedBox(
//                           width: 10,
//                         ),
//                       ],
//                     )
//                   : SizedBox(),
//               SvgPicture.asset(
//                 '${widget.assetPath}',
//                 height: 36,
//                 width: 36,
//               ),
//               SizedBox(
//                 width: 10,
//               ),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Алхалт',
//                     style: TextStyle(
//                       color: white,
//                       fontSize: 12,
//                     ),
//                   ),
//                   Text(
//                     isLoading == true
//                         ? "0"
//                         : walk.balanceAmount != null && walk.balanceAmount != 0
//                             // ? '${stepCounter.stepped}'
//                             ? '${stepped}'
//                             : '0',
//                     style: TextStyle(
//                       color: white,
//                       fontSize: 24,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//           SizedBox(
//             height: 50,
//           ),
//           isGraphLoad == true
//               ? SizedBox(
//                   height: 120,
//                   child: Center(
//                     child: CircularProgressIndicator(
//                       color: greentext,
//                     ),
//                   ),
//                 )
//               : SizedBox(
//                   height: 120,
//                   child: MyBarGraph(
//                     data: walk,
//                     weeklySum: stepsForLast7Days,
//                   ),
//                 ),
//           SizedBox(
//             height: 10,
//           ),
//           CustomButton(
//             labelText: 'Урамшуулал татах',
//             height: 40,
//             textColor: white,
//             buttonColor: isLoading == true
//                 ? greytext
//                 : walk.green!.threshold! <= stepped
//                     ? greentext
//                     : greytext,
//             isLoading: isLoading == true
//                 ? false
//                 : walk.green!.threshold! <= stepped
//                     ? isLoading
//                     : false,
//             onClick: isLoading == true
//                 ? () {}
//                 : walk.green!.threshold! <= stepped
//                     ? () async {
//                         Accumlation difference = Accumlation();
//                         if (walk.green!.threshold! <= stepped) {
//                           print('======STEPPED====');
//                           print(stepped);
//                           print(walk.balanceAmount);
//                           difference.amount = accumulatedSteps;
//                           print(accumulatedSteps);
//                           print('======STEPPED====');
//                           if (accumulatedSteps != 0) {
//                             print('Connected');
//                             print('========');

//                             socket.emit('action', {
//                               {
//                                 'type': 'walk',
//                                 'payload': {
//                                   'amount': difference.amount,
//                                   // 'latitude': 1,
//                                   // 'longitude': 2,
//                                 }
//                               }
//                             });
//                             print('========');
//                             // await ScoreApi().sendStep(difference);
//                           }
//                           accumulatedSteps = 0;
//                           if (user.danVerified == false) {
//                             Navigator.of(context)
//                                 .pushNamed(DanVerifyPage.routeName);
//                           } else {
//                             Navigator.of(context).pushNamed(
//                               CollectStepScore.routeName,
//                               arguments: CollectStepScoreArguments(
//                                 id: walk.id!,
//                                 pushWhere: widget.pushWhere,
//                               ),
//                             );
//                           }
//                         }
//                       }
//                     : () {},
//           ),
//         ],
//       ),
//     );
//   }
// }

//
// import 'package:flutter/material.dart';
// import 'package:hieroglyphic_app/compenets/constant/colors.dart';
//
// class CustomContainer extends StatefulWidget {
//    CustomContainer({required this.isAdmin});
//    bool isAdmin;
//
//   @override
//   State<CustomContainer> createState() => _CustomContainerState();
// }
//
// class _CustomContainerState extends State<CustomContainer> {
//
//   @override
//   Widget build(BuildContext context) {
//     return  Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         InkWell(
//           onTap: () {
//             isAdmin=false;
//             setState(() {
//             });
//           },
//           child: Container(
//             width: 150,
//             height: 50,
//             child: Center(child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//
//                 Text('User ',style: TextStyle(fontSize: 20,color: isAdmin?AppColor.primaryColor  :Colors.white),),
//                 Icon(Icons.account_circle_rounded,color: isAdmin?AppColor.primaryColor  :Colors.white ,),
//
//               ],
//             )),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(12),
//               color:isAdmin?  Colors.white : AppColor.primaryColor
//             ),
//           ),
//         ),
//         InkWell(
//           onTap: () {
//             isAdmin=true;
//             setState(() {
//             });
//           },
//           child: Container(
//             width: 150,
//             height: 50,
//             child: Center(child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text('Admin ',style: TextStyle(fontSize: 20,color: isAdmin?  Colors.white : AppColor.primaryColor),),
//                 Icon(Icons.lock_person,color: isAdmin?  Colors.white : AppColor.primaryColor,),
//
//               ],
//             )),
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(12),
//
//                 color:isAdmin?AppColor.primaryColor  :Colors.white
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

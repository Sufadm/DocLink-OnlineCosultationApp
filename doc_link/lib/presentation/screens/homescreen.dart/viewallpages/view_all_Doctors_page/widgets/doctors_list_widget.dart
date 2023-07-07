import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../shared/const/const.dart';

class DoctorsListWidget extends StatelessWidget {
  final String categorie;
  final String doctorname;
  final VoidCallback? onTap;
  final String avatarImageUrl;

  const DoctorsListWidget({
    Key? key,
    required this.doctorname,
    this.onTap,
    required this.avatarImageUrl,
    required this.categorie,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: kWhiteColor,
        ),
        height: 65,
        width: double.infinity,
        child: ListTile(
          subtitle: Text(
            categorie,
            style: GoogleFonts.outfit(),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          leading: CircleAvatar(
            maxRadius: 25,
            // minRadius: 10,
            backgroundImage: NetworkImage(avatarImageUrl),
          ),
          title: Text(
            doctorname,
            style: kTextStyleMediumBlack,
          ),
          trailing: const Icon(Icons.east),
        ),
      ),
    );
  }
}


// class DoctorsListWidget extends StatelessWidget {
//   final String doctorname;
//   final VoidCallback? onTap;
//   final String avatarImageUrl;
//   const DoctorsListWidget({
//     super.key,
//     required this.doctorname,
//     this.onTap,
//     required this.avatarImageUrl,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(10),
//           color: kWhiteColor,
//         ),
//         height: 70,
//         width: double.infinity,
//         child:
        
        
        
//          Container(
//           margin: const EdgeInsets.only(left: 10, right: 10),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               CircleAvatar(
//                 maxRadius: 30,
//                 minRadius: 10,
//                 backgroundImage: NetworkImage(avatarImageUrl),
//               ),
//               Text(
//                 doctorname,
//                 style: kTextStyleMediumBlack,
//               ),
//               const Icon(Icons.east)
//             ],
//           ),
//         ),
        
//       ),
//     );
//   }
// }

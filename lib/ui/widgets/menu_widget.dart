part of 'widgets.dart';

// class SquareMenuWidget extends StatelessWidget {
//   final String? title;
//   final Widget? image;
//   final Function? onTap;
//   const SquareMenuWidget({Key? key, this.title, this.image, this.onTap}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Container(
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(Sizes.dimen_8),
//           boxShadow: [
//             BoxShadow(
//                 offset: const Offset(0, 0),
//                 color: Colors.blueGrey.withOpacity(0.5),
//                 blurRadius: 10)
//           ],
//         ),
//         child: Material(
//           borderRadius: BorderRadius.circular(Sizes.dimen_8),
//           color: Colors.white70,
//           child: InkWell(
//             onTap: () {
//               if (onTap != null) {
//                 onTap!();
//               }
//             },
//             child: Container(
//               height: size.height * 0.15,
//               child: Column(
//                 children: [
//                   Expanded(
//                     flex: 2,
//                     child: Center(
//                       child: SizedBox(
//                         height: Sizes.dimen_48,
//                         width: Sizes.dimen_48,
//                         child: image!,
//                       ),
//                     ),
//                   ),
//                   Expanded(
//                     flex: 1,
//                     child: AutoSizeText(
//                       title!,
//                       style: blackTextFont.copyWith(
//                         color: darkGrey,
//                         fontSize: Sizes.dimen_18,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       );
//   }
// }

Widget menuWidget(
    BuildContext context,{
  final String? title,
  final Widget? image,
  final Function? onTap
}) {
  var size = MediaQuery.of(context).size;
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      boxShadow: [
        BoxShadow(
            offset: const Offset(0, 0),
            color: Colors.blueGrey.withOpacity(0.5),
            blurRadius: 10)
      ],
    ),
    child: Material(
      borderRadius: BorderRadius.circular(8),
      color: Colors.white70,
      child: InkWell(
        onTap: () {
          if (onTap != null) {
            onTap();
          }
        },
        child: Container(
          height: size.height * 0.2,
          width: size.width * 0.4,
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: Center(
                  child: SizedBox(
                    height: 80,
                    width: 80,
                    child: image!,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: AutoSizeText(
                  title!,
                  maxLines: 1,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

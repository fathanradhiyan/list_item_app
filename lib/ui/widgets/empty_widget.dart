part of 'widgets.dart';

Widget emptyWidget() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      LottieBuilder.asset(
          'assets/empty.json'),
      Text('Tidak ada Data', textAlign: TextAlign.center, style: TextStyle(color: Colors.blueGrey, fontSize: 18, fontWeight: FontWeight.w600),)
    ],
  );
}
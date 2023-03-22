part of 'widgets.dart';

Widget listCard(BuildContext context,
    {required int idValue,
    required String nameValue,
    required String codeValue,
      VoidCallback? onEdit,
      VoidCallback? onDelete,
    }) {
  var size = MediaQuery.of(context).size;
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
      child: Container(
        height: size.height * 0.14,
        padding: const EdgeInsets.fromLTRB(8, 8, 8, 2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            keyValRow(keyText: 'Name', valText: nameValue),
            const SizedBox(
              height: 8,
            ),
            keyValRow(keyText: 'Barcode', valText: codeValue),
            Align(
              alignment: Alignment.center,
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: onEdit,
                      child: const Text(
                        'Edit',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueGrey),
                      ),
                      style: ElevatedButton.styleFrom(
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        //padding: EdgeInsets.zero,
                        minimumSize: Size.zero,
                        fixedSize: const Size(80, 30),
                        backgroundColor: Colors.white,
                        side: const BorderSide(width: 1, color: Colors.blueGrey),
                      ),
                    ),
                    const SizedBox(width: 8,),
                    ElevatedButton(
                      onPressed: onDelete,
                      child: const Text(
                        'Delete',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        minimumSize: Size.zero,
                        fixedSize: const Size(80, 30),
                        backgroundColor: Colors.blueGrey,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    ),
  );
}

Widget keyValRow({required String keyText, required String valText}) {
  return Row(
    children: [
      Expanded(
        flex: 2,
        child: Text(
          keyText,
          style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey),
        ),
      ),
      const Text(
        ':',
        style: TextStyle(
            fontSize: 14, fontWeight: FontWeight.bold, color: Colors.blueGrey),
      ),
      const SizedBox(
        width: 8,
      ),
      Expanded(
        flex: 7,
        child: Text(
          valText,
          style: const TextStyle(
              fontSize: 14,
              // fontWeight: FontWeight.bold,
              color: Colors.blueGrey),
        ),
      ),
    ],
  );
}

Widget textBox({
  String? title,
  bool? isImportant = false,
  TextStyle? style,
  EdgeInsetsGeometry? padding,
  double? height,
  double? width,
  Color? color,
  Widget? child
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
          margin: const EdgeInsets.only(top: 8),
          padding: const EdgeInsets.only(left: 2),
          child: title == null
              ? null
              : isImportant!
                  ? RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: title,
                        style: style ?? const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                        children: const <TextSpan>[
                          TextSpan(
                              text: '*',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red)),
                        ],
                      ),
                    )
                  : Text(
                      title,
                      style: style ?? const TextStyle(fontWeight: FontWeight.bold),
                    )),
      title == null
          ? const SizedBox()
          : const SizedBox(
              height: 2,
            ),
      Container(
          padding: padding ?? const EdgeInsets.all(8),
          width: width,
          height: height,
          decoration: BoxDecoration(
              boxShadow: [
                      BoxShadow(
                          offset: const Offset(0, 4),
                          color: Colors.blueGrey.withOpacity(0.5),
                          blurRadius: 2),
                    ],
              borderRadius: BorderRadius.circular(5),
              color: color ?? Colors.white,
              border: Border.all(width: 1, color: Colors.blueGrey)),
          child: child)
    ],
  );
}

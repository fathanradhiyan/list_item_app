part of 'pages.dart';

class SearchItemPage extends StatefulWidget {
  const SearchItemPage({Key? key}) : super(key: key);

  @override
  _SearchItemPageState createState() => _SearchItemPageState();
}

class _SearchItemPageState extends State<SearchItemPage> {
  List<Item> searchList = [];
  bool? isLoading = false;
  TextEditingController? _nameController;
  TextEditingController? _codeController;

  @override
  void initState() {
    // TODO: implement initState
    _nameController = TextEditingController();
    _codeController = TextEditingController();
    super.initState();
  }

  Future refreshList() async {
    setState(() => isLoading = true);

    searchList = await ItemDatabase.instance.readAllItems();

    setState(() => isLoading = false);
  }

  Future searchItem(String text) async {
    setState(() => isLoading = true);

    searchList = await ItemDatabase.instance.readAllItems(search: text);

    setState(() => isLoading = false);
  }

  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Barang Tersedia'),
        ),
        body: SizedBox(
            width: size.width,
            height: size.height,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: textBox(
                          child: TextField(
                              style: const TextStyle(fontSize: 12),
                              keyboardType: TextInputType.text,
                              controller: _searchController,
                              maxLines: 1,
                              maxLength: 20,
                              decoration: const InputDecoration(
                                counterText: "",
                                isDense: true,
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 0, vertical: 8),
                                border: InputBorder.none,
                                hintStyle: TextStyle(color: Colors.grey),
                                hintText: 'Masukkan Cari Item',
                              )),
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      ElevatedButton(
                        onPressed: () => searchItem(_searchController.text),
                        style: ElevatedButton.styleFrom(
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          minimumSize: Size.zero,
                          fixedSize: const Size(80, 30),
                          backgroundColor: Colors.blueGrey,
                        ),
                        child: const Text(
                          'Search',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Expanded(
                    child: isLoading!
                        ? const SpinKitFadingCircle(
                            size: 45,
                            color: Colors.blueGrey,
                          )
                        : searchList.isNotEmpty
                            ? ListView(
                                shrinkWrap: true,
                                children:
                                    List.generate(searchList.length, (index) {
                                  return listCard(context,
                                      idValue: searchList[index].itemId!,
                                      nameValue: searchList[index].itemName!,
                                      codeValue: searchList[index].barcode!,
                                      onEdit: () async {
                                    _codeController!.text =
                                        searchList[index].barcode!;
                                    _nameController!.text =
                                        searchList[index].itemName!;
                                    await customPopup(context,
                                        // color: (_noFieldEmpty)? Colors.blueGrey : Colors.grey,
                                        title: const Text(
                                          'Edit Item',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        content: SizedBox(
                                          height: size.height * 0.25,
                                          child: Column(
                                            children: [
                                              textBox(
                                                title: "Nama",
                                                isImportant: true,
                                                child: TextField(
                                                    style: const TextStyle(
                                                        fontSize: 12),
                                                    keyboardType:
                                                        TextInputType.text,
                                                    controller: _nameController,
                                                    maxLines: 1,
                                                    maxLength: 20,
                                                    decoration:
                                                        const InputDecoration(
                                                      counterText: "",
                                                      isDense: true,
                                                      contentPadding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 0,
                                                              vertical: 8),
                                                      border: InputBorder.none,
                                                      hintStyle: TextStyle(
                                                          color: Colors.grey),
                                                      hintText:
                                                          'Masukkan Nama Item',
                                                    )),
                                              ),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              textBox(
                                                title: "Barcode",
                                                isImportant: true,
                                                child: TextField(
                                                    style: const TextStyle(
                                                        fontSize: 12),
                                                    keyboardType:
                                                        TextInputType.text,
                                                    controller: _codeController,
                                                    maxLines: 1,
                                                    maxLength: 20,
                                                    decoration:
                                                        const InputDecoration(
                                                      counterText: "",
                                                      isDense: true,
                                                      contentPadding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 0,
                                                              vertical: 8),
                                                      border: InputBorder.none,
                                                      hintStyle: TextStyle(
                                                          color: Colors.grey),
                                                      hintText: 'Masukkan kode',
                                                    )),
                                              ),
                                            ],
                                          ),
                                        ), onCancel: () {
                                      Get.back();
                                      setState(() {
                                        _nameController!.clear();
                                        _codeController!.clear();
                                      });
                                    }, onOk: () async {
                                      await ItemDatabase.instance.update(Item(
                                          itemId: searchList[index].itemId!,
                                          itemName: _nameController!.text,
                                          barcode: _codeController!.text));
                                      setState(() {
                                        _nameController!.clear();
                                        _codeController!.clear();
                                        refreshList();
                                      });
                                      Get.back();
                                    });
                                  }, onDelete: () async {
                                    await ItemDatabase.instance
                                        .delete(searchList[index].itemId!);
                                    refreshList();
                                  });
                                }),
                              )
                            : emptyWidget())
              ],
            )));
  }

  Future<void> customPopup(BuildContext context,
      {VoidCallback? onOk,
      VoidCallback? onCancel,
      String? labelCancel,
      Widget? title,
      Color? color,
      String? buttonText,
      Widget? content}) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: title ?? const SizedBox(),
          content: content ?? const SizedBox(),
          actionsAlignment: MainAxisAlignment.spaceBetween,
          buttonPadding: const EdgeInsets.all(24),
          actions: <Widget>[
            ElevatedButton(
              onPressed: onCancel,
              style: ElevatedButton.styleFrom(
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                //padding: EdgeInsets.zero,
                minimumSize: Size.zero,
                fixedSize: const Size(80, 30),
                backgroundColor: Colors.white,
                side: const BorderSide(width: 1, color: Colors.blueGrey),
              ),
              child: const Text(
                'Cancel',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey),
              ),
            ),
            ElevatedButton(
              onPressed: onOk,
              style: ElevatedButton.styleFrom(
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                minimumSize: Size.zero,
                fixedSize: const Size(80, 30),
                backgroundColor: color ?? Colors.blueGrey,
              ),
              child: const Text(
                'Add',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }
}

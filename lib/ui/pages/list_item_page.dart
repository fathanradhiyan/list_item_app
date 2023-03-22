part of 'pages.dart';

class ListItemPage extends StatefulWidget {
  const ListItemPage({Key? key}) : super(key: key);

  @override
  State<ListItemPage> createState() => _ListItemPageState();
}

class _ListItemPageState extends State<ListItemPage> {
  late List<Item> itemList = [];
  bool isLoading = false;
  TextEditingController? _nameController;
  TextEditingController? _codeController;

  @override
  void initState() {
    // TODO: implement initState
    _nameController = TextEditingController();
    _codeController = TextEditingController();

    refreshList();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    // ItemDatabase.instance.close();
    super.dispose();
  }

  Future refreshList() async {
    setState(() => isLoading = true);

    itemList = await ItemDatabase.instance.readAllItems();

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Barang Tersedia'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            customPopup(context,
                // color: (_noFieldEmpty)? Colors.blueGrey : Colors.grey,
                title: const Text(
                  'Add Item',
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
                            style: const TextStyle(fontSize: 12),
                            keyboardType: TextInputType.text,
                            controller: _nameController,
                            maxLines: 1,
                            maxLength: 20,
                            decoration: const InputDecoration(
                              counterText: "",
                              isDense: true,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 0, vertical: 8),
                              border: InputBorder.none,
                              hintStyle: TextStyle(color: Colors.grey),
                              hintText: 'Masukkan Nama Item',
                            )),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      textBox(
                        title: "Barcode",
                        isImportant: true,
                        child: TextField(
                          // onChanged: (text){
                          //   setState(() {
                          //     text.isNotEmpty;
                          //   });
                          // },
                            style: const TextStyle(fontSize: 12),
                            keyboardType: TextInputType.text,
                            controller: _codeController,
                            maxLines: 1,
                            maxLength: 20,
                            decoration: const InputDecoration(
                              counterText: "",
                              isDense: true,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 0, vertical: 8),
                              border: InputBorder.none,
                              hintStyle: TextStyle(color: Colors.grey),
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
            }, onOk: ()async {
                  await ItemDatabase.instance.create(Item(
                      itemName: _nameController!.text,
                      barcode: _codeController!.text));
                  setState(() {
                    _nameController!.clear();
                    _codeController!.clear();
                    refreshList();
                  });
                  Get.back();
                });
          },
          tooltip: 'Add List',
          child: const Icon(Icons.add),
        ),
        body: Container(
          child: itemList.isNotEmpty
              ? ListView(
                  children: List.generate(itemList.length, (index) {
                    return listCard(context,
                        idValue: itemList[index].itemId!,
                        nameValue: itemList[index].itemName!,
                        codeValue: itemList[index].barcode!, onEdit: () async {
                      _codeController!.text = itemList[index].barcode!;
                      _nameController!.text = itemList[index].itemName!;
                      await customPopup(context,
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
                                      style: const TextStyle(fontSize: 12),
                                      keyboardType: TextInputType.text,
                                      controller: _nameController,
                                      maxLines: 1,
                                      maxLength: 20,
                                      decoration: const InputDecoration(
                                        counterText: "",
                                        isDense: true,
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 0, vertical: 8),
                                        border: InputBorder.none,
                                        hintStyle:
                                            TextStyle(color: Colors.grey),
                                        hintText: 'Masukkan Nama Item',
                                      )),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                textBox(
                                  title: "Barcode",
                                  isImportant: true,
                                  child: TextField(
                                      style: const TextStyle(fontSize: 12),
                                      keyboardType: TextInputType.text,
                                      controller: _codeController,
                                      maxLines: 1,
                                      maxLength: 20,
                                      decoration: const InputDecoration(
                                        counterText: "",
                                        isDense: true,
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 0, vertical: 8),
                                        border: InputBorder.none,
                                        hintStyle:
                                            TextStyle(color: Colors.grey),
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
                            itemId: itemList[index].itemId!,
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
                          .delete(itemList[index].itemId!);
                      refreshList();
                    });
                  }),
                )
              : emptyWidget()
        ));
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

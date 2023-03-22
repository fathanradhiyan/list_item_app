part of 'pages.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: const Text('Home Page'),),
      body: SizedBox(
        width: double.infinity,
        height: size.height,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            menuWidget(context, title: 'List Barang', image: LottieBuilder.asset('assets/list_icon.json'), onTap: () => Get.to(()=> const ListItemPage())),
            menuWidget(context, title: 'Cari Barang', image: LottieBuilder.asset('assets/search_icon.json'), onTap: () => Get.to(()=> const SearchItemPage())),
          ],
        ),
      ),
    );
  }
}

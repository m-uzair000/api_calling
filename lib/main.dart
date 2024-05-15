import 'package:flutter/material.dart';

import 'models/md_slider_image.dart';
import 'network/api_paths.dart';
import 'network/api_service.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isLoaded = false;
  List<MDSliderImage> imagesList = [];

  @override
  void initState() {
    getImages();
    super.initState();
  }

  Future<void> getImages() async {
    var result = await ApiService.request(ApiPaths.getImages,
        method: RequestMethod.GET, formData: true);
    imagesList = List.generate(result.data.length, (index) => MDSliderImage.fromMap(result.data[index]));
    setState(() {
      isLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Slider Images"),
      ),
      body: SizedBox(
        child: isLoaded
            ? SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: ListView.builder(
                    itemBuilder: (_, i) {
                      return Container(
                        clipBehavior: Clip.antiAlias,
                        width: MediaQuery.of(context).size.width,
                        margin:const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.black,width: 0.5)
                        ),
                        child: ClipRRect(
                          clipBehavior: Clip.antiAlias,
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                              ApiPaths.baseURL + imagesList[i].image!),
                        ),
                      );
                    },
                    itemCount: imagesList.length),
              )
            : const Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}

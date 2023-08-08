import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:news_with_push_notification/provider/news_provider.dart';
import 'package:news_with_push_notification/ui/add_news/colors.dart';
import 'package:news_with_push_notification/ui/add_news/text_field.dart';
import 'package:provider/provider.dart';

class AddNews extends StatefulWidget {
  AddNews({super.key, required this.callback});
  VoidCallback callback;

  @override
  State<AddNews> createState() => _AddNewsState();
}

class _AddNewsState extends State<AddNews> {
  ImagePicker picker = ImagePicker();

  String? catID;
  String? catName;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.read<ProductsProvider>().tozalash();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFFF2F2F2),
          title: const Text(
            "Add News",
            style: TextStyle(color: Colors.black),
          ),
          leading: IconButton(
            onPressed: () {
              context.read<ProductsProvider>().tozalash();

              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(10),
                children: [
                  const SizedBox(height: 10),
                  GlobalTextField(
                    hintText: "Add News title",
                    textAlign: TextAlign.start,
                    controller:
                        context.read<ProductsProvider>().titleController,
                    label: 'title',
                  ),
                  const SizedBox(height: 10),
                  GlobalTextField(
                    hintText: "Add News author",
                    textAlign: TextAlign.start,
                    keyboardType: TextInputType.text,
                    controller:
                        context.read<ProductsProvider>().authorController,
                    label: 'Author',
                  ),
                  const SizedBox(height: 10),
                  GlobalTextField(
                    hintText: "Add News description",
                    textAlign: TextAlign.start,
                    controller:
                        context.read<ProductsProvider>().descriptionController,
                    label: 'Description',
                  ),
                  const SizedBox(height: 10),
                  GlobalTextField(
                    maxLines: 5,
                    keyboardType: TextInputType.text,
                    hintText: "Add News Content",
                    textAlign: TextAlign.start,
                    controller:
                        context.read<ProductsProvider>().contentController,
                    label: 'Content',
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.green),
                    ),
                    onPressed: () async {
                      showBottomSheetDialog(context);
                    },
                    child: context.watch<ProductsProvider>().imageUrl.isEmpty
                        ? const Text(
                            "Select Image",
                            style: TextStyle(color: Colors.white),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          )
                        : SizedBox(
                            height: 100,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                ...List.generate(
                                    context
                                        .watch<ProductsProvider>()
                                        .imageUrl
                                        .length, (index) {
                                  String singleImage = context
                                      .watch<ProductsProvider>()
                                      .imageUrl;
                                  return Container(
                                    padding: const EdgeInsets.all(5),
                                    margin: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Image.network(
                                      singleImage,
                                      width: 80,
                                      height: 80,
                                      fit: BoxFit.fill,
                                    ),
                                  );
                                })
                              ],
                            ),
                          ),
                  ),
                ],
              ),
            ),
            Visibility(
              visible: context.watch<ProductsProvider>().imageUrl.isNotEmpty,
              child: SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () {
                    showBottomSheetDialog(context);
                  },
                  style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.green),
                  ),
                  child: const Text(
                    "Select Image",
                    style: TextStyle(color: Colors.white),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 5),
              child: SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                      style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(Colors.green),
                      ),
                      onPressed: () {
                        context.read<ProductsProvider>().sendNotification();
                        widget.callback.call();
                        Navigator.pop(context);

                        context.read<ProductsProvider>().tozalash();
                      },
                      child: const Text("Send News"))),
            ),
          ],
        ),
      ),
    );
  }

  void showBottomSheetDialog(BuildContext x) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: x,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(24),
          height: 200,
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 255, 248, 248),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          child: Column(
            children: [
              ListTile(
                onTap: () {
                  _getFromCamera(context);
                },
                leading: const Icon(Icons.camera_alt),
                title: const Text("Select from Camera"),
              ),
              ListTile(
                onTap: () {
                  _getFromGallery(context);
                },
                leading: const Icon(Icons.photo),
                title: const Text("Select from Gallery"),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _getFromCamera(BuildContext context) async {
    XFile? xFile = await picker.pickImage(
      source: ImageSource.camera,
      maxHeight: 512,
      maxWidth: 512,
    );

    if (context.mounted) {
      if (xFile != null) {
        await context
            .read<ProductsProvider>()
            .uploadCategoryImage(context, xFile);
      }
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    }
  }

  Future<void> _getFromGallery(BuildContext context) async {
    XFile? xFile = await picker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 512,
      maxWidth: 512,
    );
    if (context.mounted) {
      if (xFile != null) {
        await context
            .read<ProductsProvider>()
            .uploadCategoryImage(context, xFile);
      }
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    }
  }
}

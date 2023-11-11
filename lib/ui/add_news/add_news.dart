import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:news_with_push_notification/bloc/notification_send/notification_bloc.dart';
import 'package:news_with_push_notification/services/models/notification_fields/notify_fields.dart';
import 'package:news_with_push_notification/ui/add_news/widgets/popup_menu_button.dart';
import 'package:news_with_push_notification/ui/ui_utils/text_field.dart';
import 'package:provider/provider.dart';

class AddNews extends StatefulWidget {
  const AddNews({
    super.key,
  });

  @override
  State<AddNews> createState() => _AddNewsState();
}

class _AddNewsState extends State<AddNews> {
  ImagePicker picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
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
                  MyPopupMenuButton(
                    items: const ['News', 'Technology', 'Medicine', 'Cars'],
                    initialValue: "Select a Topic",
                    onChanged: (String newValue) {
                      context.read<NotificationBloc>().updateWebsiteField(
                          fieldKey: NotificationFileds.to,
                          value: "/topics/$newValue");
                      debugPrint('Selected: $newValue');
                    },
                  ),
                  const SizedBox(height: 10),
                  GlobalTextField(
                    hintText: "Add News title",
                    textAlign: TextAlign.start,
                    onChanged: (value) {
                      context.read<NotificationBloc>().updateWebsiteField(
                          fieldKey: NotificationFileds.title, value: value);
                      context.read<NotificationBloc>().updateWebsiteField(
                          fieldKey: NotificationFileds.title2, value: value);
                    },
                    label: 'title',
                  ),
                  const SizedBox(height: 10),
                  GlobalTextField(
                    hintText: "Add News author",
                    textAlign: TextAlign.start,
                    keyboardType: TextInputType.text,
                    onChanged: (value) => context
                        .read<NotificationBloc>()
                        .updateWebsiteField(
                            fieldKey: NotificationFileds.author, value: value),
                    label: 'Author',
                  ),
                  const SizedBox(height: 10),
                  GlobalTextField(
                    hintText: "Add News description",
                    textAlign: TextAlign.start,
                    onChanged: (value) => context
                        .read<NotificationBloc>()
                        .updateWebsiteField(
                            fieldKey: NotificationFileds.description,
                            value: value),
                    label: 'Description',
                  ),
                  const SizedBox(height: 10),
                  GlobalTextField(
                    maxLines: 5,
                    keyboardType: TextInputType.text,
                    hintText: "Add News Content",
                    textAlign: TextAlign.start,
                    onChanged: (value) => context
                        .read<NotificationBloc>()
                        .updateWebsiteField(
                            fieldKey: NotificationFileds.content, value: value),
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
                    child: context
                            .watch<NotificationBloc>()
                            .state
                            .allDataFromNotify
                            .fcmResponseModel
                            .imageUrl
                            .isEmpty
                        ? const Text(
                            "Select Image",
                            style: TextStyle(color: Colors.white),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          )
                        : SizedBox(
                            height: 100,
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              margin: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Image.network(
                                context
                                    .watch<NotificationBloc>()
                                    .state
                                    .allDataFromNotify
                                    .fcmResponseModel
                                    .imageUrl,
                                width: 80,
                                height: 80,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                  ),
                ],
              ),
            ),
            Visibility(
              visible: context
                  .watch<NotificationBloc>()
                  .state
                  .allDataFromNotify
                  .fcmResponseModel
                  .imageUrl
                  .isNotEmpty,
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
                        context
                            .read<NotificationBloc>()
                            .add(SendNotification());
                        context
                            .read<NotificationBloc>()
                            .add(FetchLocalNotification());

                        Navigator.pop(context);
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
            .read<NotificationBloc>()
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
            .read<NotificationBloc>()
            .uploadCategoryImage(context, xFile);
      }
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    }
  }
}

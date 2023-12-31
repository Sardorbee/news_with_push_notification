import 'package:flutter/material.dart';
import 'package:news_with_push_notification/services/models/fcm_response_model.dart';

class DetailsScreen extends StatelessWidget {
  DetailsScreen({super.key, this.fcmResponseModel});
  FcmResponseModel? fcmResponseModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'News detail',
        ),
      ),
      body: Center(
        child: Column(
          children: [
            fcmResponseModel?.imageUrl != null
                ? InteractiveViewer(
                  scaleEnabled: true,
                  child: Image.network(fcmResponseModel!.imageUrl))
                : const Placeholder(),
            Text(fcmResponseModel?.title ?? ''),
            Text(fcmResponseModel?.author ?? ''),
            Text(fcmResponseModel?.publishedAt ?? ''),
            Text(fcmResponseModel?.description ?? ''),
            Text(fcmResponseModel?.content ?? ''),
          ],
        ),
      ),
    );
  }
}

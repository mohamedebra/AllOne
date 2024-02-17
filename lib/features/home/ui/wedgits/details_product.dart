
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../../../core/helper/chache_helper.dart';
import '../../data/model/product_offer.dart';



class DetailsProduct extends StatelessWidget {
  final DataProduct productItems;

  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();

  DetailsProduct({super.key, required this.productItems,});

  @override
  Widget build(BuildContext context) {
    // Assuming `title` contains the special title you want to display.
    String changeLang = productItems.title!;
    String imageUrl = productItems.files
        ?.firstWhere(
            (file) =>
        file.image!.endsWith('.pdf') ,
        orElse: () => Files(
            fileType:
            '') // Use orElse to handle the case when no valid image is found.
    )
        .image ?? '';

    // Correctly forming the URL for the PDF viewer.
    // String url = productItems.files![1].image ?? '';
    String fullUrl = 'http://app.misrgidda.com/$imageUrl';

    return Scaffold(
      appBar: AppBar(
        // Directly using `changeLang` as it's guaranteed to be non-null here.
        title: Text(changeLang),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.bookmark,
              color: Colors.grey,
              semanticLabel: 'Bookmark',
            ),
            onPressed: () {
              _pdfViewerKey.currentState?.openBookmarkView();
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SfPdfViewer.network(
          fullUrl,
          key: _pdfViewerKey,
        ),
      ),
    );
  }
}
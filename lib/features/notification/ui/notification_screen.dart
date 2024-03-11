
import 'package:all_one/core/helper/spacing.dart';
import 'package:all_one/core/networks/api_service.dart';
import 'package:all_one/core/theming/styles.dart';
import 'package:all_one/features/notification/data/repo/notaification_data.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/wedgits/error.dart';
import '../../../core/wedgits/loading_coustom_all_view.dart';
import '../../home/data/model/product_offer.dart';
import '../logic/notification_cubit.dart';
import 'package:intl/intl.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    BlocProvider.of<NotificationCubit>(context).fetchNote();

    // TODO: implement initState
    super.initState();
  }
  String getReadableDate(String dateStr) {
    final DateFormat format = DateFormat('yyyy-MM-dd HH:mm:ss');
    DateTime date = format.parse(dateStr);

    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);
    DateTime yesterday = today.subtract(Duration(days: 1));
    DateTime dateToCompare = DateTime(date.year, date.month, date.day);

    if(dateToCompare == today) {
      return "Today";
    } else if(dateToCompare == yesterday) {
      return "Yesterday";
    } else {
      // For any other date, return the formatted date or any format you need
      return DateFormat('yyyy-MM-dd').format(date);
    }
  }
  @override
  Widget build(BuildContext context) {
    
    
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Notification',
          style: TextStyles.font18BlackMedium,
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<NotificationCubit,NotificationState>(
        builder: (BuildContext context, NotificationState state) {
          if(state is NotificationLoaded){
          return SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.88,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 25, top: 25, right: 25),
                      child: Text(//Jiffy.parse(state.productOffersNotification.data!.data![0].createdAt!).fromNow();
                       // Jiffy.parse(state.productOffersNotification.data![0].createdAt!).fromNow(),
                        getReadableDate(state.productOffersNotification.data![0].createdAt!),
                        style: TextStyles.font14GrayRegular,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10,),
                ...List.generate(
                    state.productOffersNotification.data!.length,
                        (index) => Container(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:  EdgeInsets.all(8.0),
                                child: CircleAvatar(
                                  radius: 25,
                                  backgroundImage: buildProductImage(state.productOffersNotification.data![index]),

                                  // Use the 'image' property
                                ),                              ),
                              horizontalSpace(10.w),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${state.productOffersNotification.data![index].title}',
                                    style: TextStyles.font15DarkBlueMedium,
                                  ),
                                  verticalSpace(2),
                                  SizedBox(
                                    width: MediaQuery.sizeOf(context).width * 0.7,
                                    child: Text(
                                      "Bast Offers",
                                      maxLines: 5,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyles.font14GrayRegular,
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        )

                ),

              ],
            ),
          );
          }
          if(state is NotificationLoading){
            return const Center(child: CircularProgressIndicator());
          }
          if(state is NotificationError){
            return state.error == 'defaultError'
                ? const LoadingCoustomAllView()
                : CustomErrorWidget(
              errMessage: state.error,
            );          }
          return Center(child: Text('data'));
        },
      ),
    );
  }
   buildProductImage(DataProduct product) {
    // Find the first image file that is an actual image (ignoring non-image files).

    // String? imageUrl = product.files?.firstWhere(
    //       (file) => file.image!.endsWith('.jpg') || file.image!.endsWith('.jpeg') || file.image!.endsWith('.png'),
    //   orElse: () => null, // Use orElse to handle the case when no valid image is found.
    //
    // ).image;
    String? imageUrl = product.files
        ?.firstWhere(
            (file) =>
        file.image!.endsWith('.jpg') ||
            file.image!.endsWith('.jpeg') ||
            file.image!.endsWith('.png'),
        orElse: () => Files(
            fileType:
            'asstes/images/2.jpg') // Use orElse to handle the case when no valid image is found.
    )
        .image;

    // Check if an image URL was found and is not null.
    if (imageUrl != null) {
      // Complete the URL if necessary (if the stored URL is relative).
      String fullImageUrl = 'http://app.misrgidda.com$imageUrl';

      // Return an Image widget to display the image.
      // return Image(image: NetworkImage(fullImageUrl),fit: BoxFit.cover,);
      return Image.network(fullImageUrl).image;
    }
    return Image.asset('asstes/icons/Error.png').image;
  }
}

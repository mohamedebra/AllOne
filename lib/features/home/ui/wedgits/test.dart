// import 'package:all_one/core/helper/extensions.dart';
// import 'package:all_one/features/home/logic/home_cubit.dart';
// import 'package:all_one/features/home/logic/home_state.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// import '../../../../core/helper/spacing.dart';
// import '../../../../core/networks/api_service.dart';
// import '../../../../core/routing/routes.dart';
// import '../../../../core/theming/styles.dart';
// import '../../../../core/wedgits/error.dart';
// import '../../../../core/wedgits/loding.dart';
// import '../../../../core/wedgits/loding_category.dart';
// import '../../data/model/model.dart';
// import '../../data/model/model_products.dart';
// import '../../data/repo/repo_types.dart';
//
// class TestProduct extends StatefulWidget {
//   const TestProduct({super.key});
//
//   @override
//   State<TestProduct> createState() => _TestProductState();
// }
//
// class _TestProductState extends State<TestProduct> {
//   @override
//   void initState() {
//     // TODO: implement initState
//     BlocProvider.of<HomeCubit>(context).fetchTypes();
//
//     super.initState();
//   }
//   @override
//   Widget build(BuildContext context) {
//
//     return BlocProvider(
//       create: (BuildContext context) => HomeCubit(TypesRepo(ApiService(Dio())))..fetchTypes(),
//
//       child: Scaffold(
//         appBar: AppBar(
//           leading: IconButton(
//             onPressed: (){
//               Navigator.pop(context);
//             },
//             icon: const Icon(Icons.arrow_back),
//           ),
//         ),
//         body: SafeArea(
//           child: BlocBuilder<HomeCubit,HomeState>(
//             builder: (context,state){
//               if (state is ProductLoading) {
//                 return const LoadingCategory();
//               } else if (state is ProductSuccess) {
//
//                 // Render your list here
//                 return ListView.builder(
//                   shrinkWrap: true,
//                   physics: const NeverScrollableScrollPhysics(),
//                   itemBuilder: (context, index) {
//                     if(state.productOffers.data![index].files![index].main == 0 )
//                     {
//                       final imageUrl = 'http://app.misrgidda.com/${state.productOffers.data![index].files![index].image!}';
//
//
//                       return Column(
//                         children: [
//                           InkWell(
//                             onTap: () {
//                               // admobInterstitial!.show();
//
//                               context.pushNamed(Routes.detailsProduct,
//                                   arguments: productItems[index]);
//                             },
//                             child: SizedBox(
//                               height: 110,
//                               child: Row(
//                                 children: [
//                                   Stack(
//                                     alignment: AlignmentDirectional.topStart,
//                                     children: [
//                                       ClipRRect(
//                                         borderRadius: BorderRadius.circular(16),
//                                         child: AspectRatio(
//                                           aspectRatio: 2.6 / 3,
//                                           child: Container(
//                                             color: Colors.grey[100],
//                                             child: Image(
//                                               fit: BoxFit.cover,
//                                               image: NetworkImage(imageUrl!),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                       Padding(
//                                         padding: EdgeInsets.only(right: 15.w),
//                                         child: Image(
//                                           image: AssetImage('asstes/icons/special-png.png'),
//                                           width: 80,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                   const SizedBox(
//                                     width: 15,
//                                   ),
//                                   Expanded(
//                                     child: Column(
//                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                       mainAxisAlignment: MainAxisAlignment.center,
//                                       children: [
//                                         SizedBox(
//                                           width: MediaQuery.of(context).size.width * .5,
//                                           child: Text(productItems[index].name!,
//                                               maxLines: 2,
//                                               overflow: TextOverflow.ellipsis,
//                                               style: TextStyles.font18BlackMedium),
//                                         ),
//                                         const SizedBox(
//                                           height: 3,
//                                         ),
//                                         Text(
//                                           productItems[index].details!,
//                                           style: TextStyles.font13GrayRegular,
//                                         ),
//                                         const SizedBox(
//                                           height: 3,
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           SizedBox(
//                             height: 12.h,
//                           ),
//                         ],
//                       );
//                     }
//                   },
//                   itemCount: state.productOffers.data!.length,
//                 );
//               } else if (state is ProductError) {
//                 // Handle error state
//                 //
//                 return  CustomErrorWidget(errMessage: state.error,);
//
//               }
//               return SizedBox.shrink(); // Fallback
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }

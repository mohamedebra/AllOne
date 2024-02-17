import 'package:all_one/features/home/data/model/product_offer.dart';
import 'package:all_one/features/notification/data/model/note_model.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:meta/meta.dart';

import '../data/repo/notaification_data.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  final NoteRepo noteRepo;
  NotificationCubit(this.noteRepo) : super(NotificationInitial());

  void fetchNote() async {
    emit(NotificationLoading());
    final result = await noteRepo.getProduct();
    result.when(
      success: (types) {
        print(types.data![0].id);

        emit(NotificationLoaded(types));
      },
      failure: (error) =>             emit(NotificationError(error.apiErrorModel.message ?? '')),
    );

  }


}

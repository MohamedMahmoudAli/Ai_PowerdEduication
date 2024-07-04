import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hieroglyphic_app/compenets/constants.dart';
import 'package:meta/meta.dart';

part 'pdf_state.dart';

class PdfCubit extends Cubit<PdfState> {
  PdfCubit() : super(PdfInitial());

  static PdfCubit get(context) => BlocProvider.of(context);

  List<String> pdfUrl = [];
  List<String> pdfTitle = [];

  Future<void> getPdf() async {
    try {
      pdfUrl.clear();
      pdfTitle.clear();
      final QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('files').get();
      for (var doc in querySnapshot.docs) {
        pdfUrl.add(doc.get('name'));
      }
      for (var doc in querySnapshot.docs) {
        pdfTitle.add(doc.get('title'));
      }
      emit(getPdfSucsess());
    } catch (e) {
      emit(getPdfError(e.toString()));
    }
  }
}

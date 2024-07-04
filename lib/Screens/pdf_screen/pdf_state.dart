part of 'pdf_cubit.dart';

@immutable
abstract class PdfState {}

class PdfInitial extends PdfState {}
class getPdfSucsess extends PdfState {}

class getPdfError extends PdfState {
  final String error;

  getPdfError(this.error);
}
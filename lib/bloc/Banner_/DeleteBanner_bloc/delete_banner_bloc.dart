
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:modern_grocery/repositery/api/banner/deleteBanner_api.dart';
part 'delete_banner_event.dart';
part 'delete_banner_state.dart';

class DeleteBannerBloc extends Bloc<DeleteBannerEvent, DeleteBannerState> {
  final DeletebannerApi _deletebannerApi = DeletebannerApi();
  DeleteBannerBloc() : super(DeleteBannerInitial()) {
    on<fetchDeleteBannerEvent>((event, emit) async {
      emit(DeleteBannerLoading());
      try {
        await _deletebannerApi.detetebanner(event.BnnerId);

        emit(DeleteBannerLoaded());
      } catch (e) {
        print(" Banner delete error: $e");
        emit(DeleteBannerError(errorMessage: e.toString()));
      }
    });
  }
}

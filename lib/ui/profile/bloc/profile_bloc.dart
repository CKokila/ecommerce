import 'package:bloc/bloc.dart';
import 'package:ecommerce/data/repo/profile_repo.dart';
import 'package:meta/meta.dart';

import '../../../data/model/profile_model.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileRepo profileRepo = ProfileRepo();
  ProfileBloc() : super(ProfileInitial()) {
    on<FetchProfileEvent>(_fetchProfile);
  }

  Future<void> _fetchProfile(
      FetchProfileEvent event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    try {
      final profile = await profileRepo.fetchProfile();
      emit(ProfileLoaded(profile: profile));
    } catch (e) {
      emit(ProfileError(error: e.toString()));
    }
  }
}

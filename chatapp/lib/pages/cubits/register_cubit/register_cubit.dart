import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  Future<void> registerUser(
      {required String email, required String password}) async {
    emit(RegisterLoading());
    try {
      // ignore: unused_local_variable
      UserCredential user = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      // You can emit a success state here if needed
      emit(RegisterSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        emit(RegisterFailure('Email is already in use.'));
      } else if (e.code == 'weak-password') {
        emit(RegisterFailure('The password provided is too weak.'));
      } else {
        emit(RegisterFailure(e.message ?? 'An unknown error occurred.'));
      }
    } catch (e) {
      emit(RegisterFailure(e.toString()));
    }
  }
}

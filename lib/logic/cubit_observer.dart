import 'package:manga_app/logic/logic.dart';

class CubitObserver extends BlocObserver {
  void transition(Cubit bloc, Transition transition) {
    print('transition: $transition');
    super.onTransition(bloc, transition);
  }

  void onChange(Cubit cubit, Change change) {
    print('change: $change');
    super.onChange(cubit, change);
  }

  void onError(Cubit cubit, Object error, StackTrace stackTrace) {
    print('error : $error');
    print('stack trace  : $stackTrace');
    super.onError(cubit, error, stackTrace);
  }
}

import 'package:stream_state/stream_state.dart';
import '../themes/index.dart';

import '../models/index.dart';

class Store {
  static final Store _singleton = Store._internal();
  factory Store() => _singleton;
  Store._internal();

  var email = StreamState<String>(initial: 'none');
  var publicStore = StreamState<List<PublicListItem>>(
    initial: [],
    //serialize: (state) => jsonEncode(state),
    //deserialize: (str) => jsonDecode(str),
  );

  var privilagedStore = StreamState<List<PrivilagedListItem>>(
    initial: [],
    //serialize: (state) => state.toMap(),
    //deserialize: (serialized) => PublicListItem.fromMap(serialized)
  );

  var user = StreamState<AppUser>(initial: null);

  var darkMode = StreamState<bool>(
      initial: true, persist: true, persistPath: '/settings/darkmode');

  // Initialize with darkModeTheme
  var theme = StreamState<AppTheme>(initial: darkModeTheme);
}

final store = Store();

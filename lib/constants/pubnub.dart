import 'package:get_storage/get_storage.dart';
import 'package:pubnub/pubnub.dart';
import 'package:spalhe/models/auth.dart';

class PubNubController {
  static final box = GetStorage();
  static AuthModel auth = AuthModel.fromJson(box.read('auth') ?? {});
  static final userId = auth.user?.id;

  final PubNub pubnub = PubNub(
    defaultKeyset: Keyset(
      subscribeKey: 'sub-c-840de33a-1d77-11ec-9033-a65b09ab59bc',
      publishKey: 'pub-c-0dab627c-fc74-4df2-a9fc-d1c8310432f8',
      userId: UserId((userId ?? '').toString()),
    ),
  );
}


import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';

AudioPlayer audioPlayer = AudioPlayer();
playLocal(String pro) async {
  //int result = await audioPlayer.play("mp3/yo.mp3", isLocal: true);
  try{
    final player = AudioCache();
    player.play('mp3/'+pro+'.mp3');
  }catch(e){
    print("failed to player " + pro);
  }

}
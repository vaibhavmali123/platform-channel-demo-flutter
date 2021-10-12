package platforms.channel.demo;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

import android.content.Context;
import android.os.Build;
import android.os.Bundle;
import android.os.VibrationEffect;
import android.os.Vibrator;


import java.util.Date;
import java.util.Timer;
import java.util.TimerTask;

import io.flutter.app.FlutterActivity;
import io.flutter.plugins.GeneratedPluginRegistrant;
import io.flutter.view.FlutterView;

public class MainActivity extends FlutterActivity {
  private static final String CHANNEL = "testMethodChanel";
  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);
    new MethodChannel(getFlutterView(), CHANNEL).setMethodCallHandler(
      new MethodCallHandler() {
        @Override
        public void onMethodCall(MethodCall methodCall, Result result) {
          if (methodCall.method.equals("changeLife")){
            String message ="Life Changed";
            result.success(message);
          }
          if (methodCall.method.equals("getDateTime")) {
              new Timer().scheduleAtFixedRate(new TimerTask() {
                  @Override
                  public void run() {
                      //your method
                  }
              }, 0, 1000);

              Date date=new Date();
          String message = date.toString();

          result.success(message);
          }
        }
      }
    );
  }

}



              
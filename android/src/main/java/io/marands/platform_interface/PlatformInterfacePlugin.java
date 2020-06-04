package io.marands.platform_interface;

import androidx.annotation.NonNull;
import androidx.core.os.LocaleListCompat;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

/**
 * PlatformInterfacePlugin
 */
public class PlatformInterfacePlugin implements MethodCallHandler {

  /**
   * Plugin registration.
   */
  public static void registerWith(Registrar registrar) {
    final MethodChannel channel = new MethodChannel(registrar.messenger(),
        "io.marands.flutter/platform_interface");
    channel.setMethodCallHandler(new PlatformInterfacePlugin());
  }

  @Override
  public void onMethodCall(MethodCall call, @NonNull Result result) {
    String method = call.method;
    switch (method) {
      case "preferredLanguages":
        result.success(getPreferredLanguages());
        break;
      case "currentLocale":
        result.success(getCurrentLocale());
        break;
      default:
        result.notImplemented();
    }
  }

  private String getCurrentLocale() {
    return Locale.getDefault().toString();
  }

  private List<String> getPreferredLanguages() {
    List<String> result = new ArrayList<String>();

    if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.N) {
      LocaleListCompat list = LocaleListCompat.getAdjustedDefault();
      for (int i = 0; i < list.size(); i++) {
        result.add(list.get(i).toString());
      }
    } else {
      result.add(getCurrentLocale());
    }

    return result;
  }
}

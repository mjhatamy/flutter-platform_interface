package io.marands.platform_interface;

import android.os.Build;

import androidx.annotation.NonNull;
import androidx.core.os.LocaleListCompat;

import org.json.JSONObject;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

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

  private String localeToJsonString(Locale locale) {
    Map<String, String> map = new HashMap<>();
    if(locale.getLanguage() != null && locale.getLanguage().length() > 0) {
      map.put("languageCode", locale.getLanguage());
    }
    if(locale.getCountry() != null && locale.getCountry().length() > 0) {
      map.put("countryCode", locale.getCountry());
    }
    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
      if(locale.getScript() != null && locale.getScript().length() > 0) {
        map.put("scriptCode", locale.getScript());
      }
    }

    if(map.size() <= 0) {
      return null;
    }

    JSONObject obj=new JSONObject(map);
    return obj.toString();
  }

  private String getCurrentLocale() {
    Locale locale = Locale.getDefault();
    return localeToJsonString(locale);
  }

  private List<String> getPreferredLanguages() {
    List<String> result = new ArrayList<String>();

    if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.N) {
      LocaleListCompat list = LocaleListCompat.getAdjustedDefault();
      for (int i = 0; i < list.size(); i++) {
        Locale locale = list.get(i);
        result.add(localeToJsonString(locale));
      }
    } else {
      result.add(getCurrentLocale());
    }
    return result;
  }
}

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

  private static HashMap wrapError(Exception exception) {
    HashMap<String, Object> errorMap = new HashMap<>();
    errorMap.put("message", exception.toString());
    errorMap.put("code", null);
    errorMap.put("details", null);
    return errorMap;
  }

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

  private pigeon_platform_locale.PiLocale localeToPiLocale(Locale locale) {
    Map<String, String> map = new HashMap<>();
    pigeon_platform_locale.PiLocale piLocale = new pigeon_platform_locale.PiLocale();
    if(locale.getLanguage() != null && locale.getLanguage().length() > 0) {
      piLocale.setLanguageCode(locale.getLanguage());
    }
    if(locale.getCountry() != null && locale.getCountry().length() > 0) {
      piLocale.setCountryCode(piLocale.getCountryCode());
    }
    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
      if(locale.getScript() != null && locale.getScript().length() > 0) {
        piLocale.setScriptCode(locale.getScript());
      }
    }
    return piLocale;
  }

  private HashMap<String, Object> getCurrentLocale() {
    HashMap<String, Object> wrapped = new HashMap<>();
    Locale locale = Locale.getDefault();
    wrapped.put("result", localeToPiLocale(locale).toMap());
    return wrapped;
  }

  private HashMap<String, Object> getPreferredLanguages() {
    HashMap<String, Object> wrapped = new HashMap<>();
    List<HashMap<Object, Object>> result = new ArrayList<HashMap<Object, Object>>();

    if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.N) {
      LocaleListCompat list = LocaleListCompat.getAdjustedDefault();
      for (int i = 0; i < list.size(); i++) {
        Locale locale = list.get(i);
        pigeon_platform_locale.PiLocale piLocale = localeToPiLocale(locale);
        HashMap item = piLocale.toMap();
        if(item != null) {
          result.add(item);
        }
      }
    } else {
      Locale locale = Locale.getDefault();
      result.add(localeToPiLocale(locale).toMap());
    }
    wrapped.put("result", result);
    return wrapped;
  }
}

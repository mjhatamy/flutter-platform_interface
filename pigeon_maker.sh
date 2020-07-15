
OUT_DART_FILE_NAME="platform_locale_classes"
OUT_OBJECTIVE_C_FILE_NAME="pigeon_platform_locale"
OUT_JAVA_FILE_NAME="pigeon_platform_locale"

flutter pub run pigeon \
  --input pigeons/platform_locale.dart \
  --dart_out "./lib/src/pigeons/${OUT_DART_FILE_NAME}.dart" \
  --objc_header_out "./ios/Classes/${OUT_OBJECTIVE_C_FILE_NAME}.h" \
  --objc_source_out "./ios/Classes/${OUT_OBJECTIVE_C_FILE_NAME}.m" \
  --java_out "./android/src/main/java/io/marands/platform_interface/${OUT_JAVA_FILE_NAME}.java" \
  --java_package "io.marands.platform_interface"

#PATCH
sed -i '' '4i\
library platform_interface.platform_locale;
' "./lib/src/pigeons/${OUT_DART_FILE_NAME}.dart"

find ./lib/src/pigeons/. -name '*.dart' -print0 | xargs -0 sed -i "" "s/dev.flutter.pigeon./io.marands.platform_interface\//g"
find ./lib/src/pigeons/. -name '*.dart' -print0 | xargs -0 sed -i "" "s/_fromMap/fromMap/g"
find ./lib/src/pigeons/. -name '*.dart' -print0 | xargs -0 sed -i "" "s/_toMap/toMap/g"

echo "Done"
# Keep all UCrop classes and methods
-keep class com.yalantis.ucrop.** { *; }
-keep class com.yalantis.ucrop.util.** { *; }

# Keep specific RectUtils method
-keepclassmembers class com.yalantis.ucrop.util.RectUtils {
    public static android.graphics.PointF getCenterFromRect(android.graphics.RectF);
}

# Avoid warnings from UCrop
-dontwarn com.yalantis.ucrop.**
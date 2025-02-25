package com.example.android_native

import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.MethodChannel
import android.os.Build
import androidx.annotation.NonNull
import io.flutter.embedding.engine.FlutterEngine
import android.util.Base64

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.hoondori.dev/info"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
            .setMethodCallHandler( { call, result ->
                println(call.method)
                if (call.method == "getDeviceInfo") {
                    val deviceInfo = getDeviceInfo()
                    result.success(deviceInfo)
                } else if (call.method == "getEncrypt") {
                    val data = call.arguments.toString().toByteArray();
                    val changedText = Base64.encodeToString(data, Base64.DEFAULT);
                    result.success(changedText)
                } else if (call.method == "getDecrypt") {
                    val data = call.arguments.toString();
                    val changedText = Base64.decode(data, Base64.DEFAULT);
                    result.success(String(changedText));
                }
            }
        )
    }

    private fun getDeviceInfo(): String {
        val sb = StringBuffer()
        sb.append(Build.DEVICE + "\n")
        sb.append(Build.BRAND + "\n")
        sb.append(Build.MODEL + "\n")
        return sb.toString()
    }
}

package com.example.flutter_example

import android.content.pm.PackageInfo
import android.os.Build
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    companion object {
        const val CHANNEL = "example.com/value"
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
            call, result ->
            when (call.method) {
                "getDeviceInfo" -> {
                    val deviceInfo = _getDeviceInfo()
                    result.success(deviceInfo)
                }
                "getOsVersion" -> {
                    val osVersion = _getOsVersion()
                    result.success(osVersion)
                }
                "getAppVersion" -> {
                    val appVersionName = _getAppVersion()
                    result.success(appVersionName)
                }
                "getUserAgent" -> {
                    val userAgent = _getUserAgent()
                    result.success(userAgent)
                }
            }
        }
    }

    private fun _getDeviceInfo(): String {
        val strBuilder = StringBuilder()
        strBuilder.append(Build.DEVICE + "\n")
        strBuilder.append(Build.BRAND + "\n")
        strBuilder.append(Build.MODEL + "\n")
        strBuilder.append(Build.PRODUCT + "\n")
        strBuilder.toString()
        return strBuilder.toString()
    }

    private fun _getOsVersion() : String {
        return Build.VERSION.RELEASE
    }

    private fun _getAppVersion(): String {
        var version = ""
        try {
            val packageInfo = packageManager.getPackageInfo(packageName, 0)
            version = packageInfo.versionName
        } catch (e : Exception) {
            return ""
        }
        return version
    }

    private fun _getUserAgent() : String {
        var userAgent = ""
        userAgent = ("Starbucks_Android/" + _getAppVersion() + "(Android:" + _getOsVersion() + ")")
        return userAgent
    }
}

package com.example.tripmate

import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.example.tripmate/api_key"

    override fun configureFlutterEngine(flutterEngine: io.flutter.embedding.engine.FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            // Handle method calls here
            if (call.method == "setApiKey") {
                val apiKey = call.argument<String>("apiKey")
                // Use the API key as needed, e.g., configure maps, etc.
                result.success("API Key received")
            } else {
                result.notImplemented()
            }
            
        }
    }
}

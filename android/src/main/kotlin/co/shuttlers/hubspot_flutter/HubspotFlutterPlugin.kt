package co.shuttlers.hubspot_flutter

import androidx.annotation.NonNull

import android.content.Context
import android.content.Intent
import com.hubspot.mobilesdk.HubspotManager
import com.hubspot.mobilesdk.HubspotWebActivity

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.launch

/** HubspotFlutterPlugin */
class HubspotFlutterPlugin: FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel
  private lateinit var context: Context

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "hubspot_flutter")
    channel.setMethodCallHandler(this)
    context = flutterPluginBinding.applicationContext
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
        when (call.method) {
            "initialize" -> {
                HubspotManager.getInstance(context).configure()
                result.success(null)
            }

            "openChat" -> {
                val intent = Intent(context, HubspotWebActivity::class.java)
                intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
                context.startActivity(intent)
                result.success(null)
            }
            
            "setUserIdentity" -> {
                val email = call.argument<String>("email")
                val identityToken = call.argument<String>("identityToken")
                if (email != null && identityToken != null) {
                    HubspotManager.getInstance(context).setUserIdentity(email, identityToken)
                    result.success(null)
                } else {
                    result.error("INVALID_ARGUMENT", "Email or IdentityToken is null", null)
                }
            }

            "setChatProperties" -> {
                val properties = call.argument<Map<String, String>>("properties")
                if (properties != null) {
                    HubspotManager.getInstance(context).setChatProperties(properties)
                    result.success(null)
                } else {
                    result.error("INVALID_ARGUMENT", "Properties map is null", null)
                }
            }

            "logout" -> {
                // Launch a coroutine to call the suspend function
                GlobalScope.launch(Dispatchers.Main) {
                    try {
                        HubspotManager.getInstance(context).logout()
                        result.success(null)
                    } catch (e: Exception) {
                        result.error("LOGOUT_ERROR", "Failed to logout: ${e.localizedMessage}", null)
                    }
                }
            }

            // Add more methods as needed
            else -> result.notImplemented()
        }
    }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}

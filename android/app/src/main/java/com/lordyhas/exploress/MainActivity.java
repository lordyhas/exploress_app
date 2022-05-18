package com.lordyhas.exploress;
/*
import android.os.Bundle;

import androidx.annotation.Nullable;

import io.flutter.plugin.common.PluginRegistry.PluginRegistrantCallback;

import io.flutter.embedding.android.FlutterActivity;


public class MainActivity extends FlutterActivity {
    /*@Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        //qflitePlugin.registerWith(registrarFor("com.tekartik.sqflite.SqflitePlugin"));
        //GeneratedPluginRegistrant.registerWith(Objects.requireNonNull(this.getFlutterEngine()));
    }*/

    /* @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
        //FacebookSdk.sdkInitialize(this);
        GeneratedPluginRegistrant.registerWith(flutterEngine);

    }* /
}*/

/*

// MainActivity.java
-import android.os.Bundle;
        -import io.flutter.app.FlutterActivity;
        +import io.flutter.embedding.android.FlutterActivity;
        -import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
-  @Override
-  protected void onCreate(Bundle savedInstanceState) {
        -    super.onCreate(savedInstanceState);
        -    GeneratedPluginRegistrant.registerWith(this);
        -  }
}

*/

import io.flutter.embedding.android.FlutterActivity;

public class MainActivity extends FlutterActivity {
        // You do not need to override onCreate() in order to invoke
        // GeneratedPluginRegistrant. Flutter now does that on your behalf.

        // ...retain whatever custom code you had from before (if any).
}
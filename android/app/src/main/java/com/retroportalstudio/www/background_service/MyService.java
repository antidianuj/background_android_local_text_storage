package com.retroportalstudio.www.background_service;

import android.app.NotificationManager;
import android.app.Service;
import android.content.Intent;
import android.os.Build;
import android.os.IBinder;

import androidx.annotation.Nullable;
import androidx.core.app.NotificationCompat;
import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;

public class MyService extends Service {
    private static final String FILE_NAME = "example.txt";


    @Override
    public void onCreate() {

        super.onCreate();

        if(Build.VERSION.SDK_INT >= Build.VERSION_CODES.O){
            FileOutputStream fos = null;
            try {
                fos = openFileOutput(FILE_NAME, MODE_PRIVATE);
                fos.write("Hello".getBytes());


            } catch (FileNotFoundException e) {
                e.printStackTrace();
            } catch (IOException e) {
                e.printStackTrace();
            } finally {
                if (fos != null) {
                    try {
                        fos.close();
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                }
            }


            NotificationCompat.Builder builder = new NotificationCompat.Builder(this,"messages")
                    .setContentText(" ")
                    .setContentTitle("Flutter Background")
                    .setSmallIcon(R.drawable.ic_android_black_24dp);


            startForeground(101,builder.build());
        }

    }

    @Nullable
    @Override
    public IBinder onBind(Intent intent) {
        return null;
    }
}

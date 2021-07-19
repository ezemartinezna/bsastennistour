package com.emdev.bsastennistour

import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import androidx.core.content.ContextCompat
import androidx.core.view.isVisible
import com.emdev.bsastennistour.Main.MainVC
import kotlinx.android.synthetic.main.activity_main.*
import com.emdev.bsastennistour.showAlert.showAlert

// CREATE AN ALERT MESSAGE
//    showAlert().dialog("Tu vieja","Tu MAMA", this)

class MainActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
        buttonTitleMenu()
        loginAccess()



    }

    private fun loginAccess() {

        initSession.setOnClickListener{

            val homeIntent = Intent(this, MainVC::class.java)
            intent.flags = Intent.FLAG_ACTIVITY_CLEAR_TASK.or(Intent.FLAG_ACTIVITY_NEW_TASK)
            startActivity(homeIntent)


        }

    }



    private fun buttonTitleMenu() {

        buttonInitSession.setOnClickListener {

            titleMainActivity.text = "INICIAR SESIÓN"
            initSession.isVisible = true
            createAccount.isVisible = false
            viewSocialMediaLogin.isVisible = true
            buttonInitSession.setTextColor(ContextCompat.getColor(this , R.color.colorPop))
            lineInitSession.setBackgroundColor(ContextCompat.getColor(this , R.color.colorPop))
            buttonCreateAccount.setTextColor(ContextCompat.getColor(this , R.color.colorWhite))
            lineCreateAccount.setBackgroundColor(ContextCompat.getColor(this , R.color.colorWhite))
        }

        buttonCreateAccount.setOnClickListener {

            titleMainActivity.text = "CREAR CUENTA"
            initSession.isVisible = false
            createAccount.isVisible = true
            viewSocialMediaLogin.isVisible = false
            buttonInitSession.setTextColor(ContextCompat.getColor(this , R.color.colorWhite))
            lineInitSession.setBackgroundColor(ContextCompat.getColor(this , R.color.colorWhite))
            buttonCreateAccount.setTextColor(ContextCompat.getColor(this , R.color.colorPop))
            lineCreateAccount.setBackgroundColor(ContextCompat.getColor(this , R.color.colorPop))
        }

    }

}
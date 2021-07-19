package com.emdev.bsastennistour.showAlert

import android.content.Context
import androidx.appcompat.app.AlertDialog
import com.kaopiz.kprogresshud.KProgressHUD

private var hud: KProgressHUD? = null

class showAlert {

    fun dialog(title: String, message: String, contexto : Context) {

        hud?.dismiss()

        val builder = AlertDialog.Builder(contexto)
        builder.setTitle(title)
        builder.setMessage(message)
        builder.setPositiveButton("Aceptar", null)
        val dialog: AlertDialog = builder.create()
        dialog.show()
    }
}
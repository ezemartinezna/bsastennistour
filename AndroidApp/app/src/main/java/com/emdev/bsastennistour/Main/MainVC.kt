package com.emdev.bsastennistour.Main

import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import androidx.fragment.app.Fragment
import com.emdev.bsastennistour.Matches.FragmentMatch
import com.emdev.bsastennistour.Player.FragmentPlayer
import com.emdev.bsastennistour.R
import com.emdev.bsastennistour.Settings.FragmentSettings
import com.emdev.bsastennistour.Tourament.FragmentTours
import kotlinx.android.synthetic.main.activity_main_vc.*

class MainVC : AppCompatActivity() {


    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main_vc)
        val mainFragment = FragmentMain()
        val toursFragment = FragmentTours()
        val matchFragment = FragmentMatch()
        val playerFragment = FragmentPlayer()
        val settingsFragment = FragmentSettings()

        makeCurrentFragment(mainFragment)
        bottom_nav.setOnNavigationItemSelectedListener {
            when (it.itemId) {
                R.id.navigation_main -> makeCurrentFragment(mainFragment)
                R.id.navigation_tour -> makeCurrentFragment(toursFragment)
                R.id.navigation_match -> makeCurrentFragment(matchFragment)
                R.id.navigation_player -> makeCurrentFragment(playerFragment)
                R.id.navigation_settings -> makeCurrentFragment(settingsFragment)
            }
            true
        }

    }

    private fun makeCurrentFragment(fragment : Fragment) =
        supportFragmentManager.beginTransaction().apply {
            replace(R.id.nav_host_fragment, fragment)
            commit()
        }

}
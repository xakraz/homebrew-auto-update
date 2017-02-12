# Automatic updates for Homebrew

This is a little thingy that automatically calls `brew update` and
optionally `brew fetch` and `brew upgrade` on a schedule.
By default, it does so every day at 7am and sends you a notification
when something new is available.

To install, use

    brew install xakraz/auto-update/brew-auto-update --HEAD

and then follow the instructions that are printed:

```
==> Caveats
To have launchd start xakraz/auto-update/brew-auto-update now and restart at login:
  brew services start xakraz/auto-update/brew-auto-update
```

The App Store preferences for checking for updates are respected, so
to turn off updating or fetching, change the settings there.


## History and contributions

This project was started by [petere](https://github.com/petere).
I forked his project to:

* enable automatic Homebrew upgrades, and
* merge improvements from
  [jsok](https://github.com/jsok/homebrew-auto-update) and
  [xakraz](https://github.com/xakraz/homebrew-auto-update).

Feel free to submit issues and pull requests with improvements.


## Notes

### Auto-update configuration

The auto-update, auto-upgrade default behavior follows the MacAppStore configuration.
However, you can override this config with the following environment variables:

```
HOMEBREW_AUTO_UPDATE
HOMEBREW_AUTO_FETCH
HOMEBREW_AUTO_UPGRADE
```

These environment variables can be set with the `launchctl` utility
 or permanently in config files.

http://www.launchd.info/
- Tab 'Configuration'
- Section 'Setting environment variables:'


### MacOS integration

#### Notifications

Are sent to the system thanks to the awesome tool [`terminal-notifier`](https://github.com/julienXX/terminal-notifier).


#### Launchd user agents

Need absolute path in their definition.

You can check its configuration in `Library/LaunchAgents/homebrew.mxcl.brew-auto-update.plist`).
It is also in this file that you can change the date the auto-update check is performed.

More info about Launchd agents:
- https://developer.apple.com/library/content/documentation/MacOSX/Conceptual/BPSystemStartup/Chapters/CreatingLaunchdJobs.html
- http://www.launchd.info/


#### Logs

You can see the logs via the app `Console`.
The path should be `~/Library/Logs/brew-auto-update/`.


```
Getting Terminal App ID
termapp_id: com.googlecode.iterm2
Updating Brew formulae
Outdated formulae: vitorgalvao/tiny-scripts/cask-repair
Display notifications to user
2017-02-10 14:02:45.384 terminal-notifier[6581:132685] command output:
Updating Homebrew...
==> Upgrading 1 outdated package, with result:
vitorgalvao/tiny-scripts/cask-repair 0.31.0
==> Upgrading vitorgalvao/tiny-scripts/cask-repair 
==> Cloning https://github.com/vitorgalvao/tiny-scripts.git
Updating /Users/utilisateur/Library/Caches/Homebrew/cask-repair--git
==> Checking out branch master
🍺  /usr/local/Cellar/cask-repair/0.31.0: 5 files, 23.3K, built in 3 seconds
New_Outdated formulae:
Upgrades applied
Done
```

```
Getting Terminal App ID
termapp_id: com.googlecode.iterm2
Updating Brew formulae
Outdated formulae: 
No updates available - Exiting
```

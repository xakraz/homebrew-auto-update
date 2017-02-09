require 'formula'

class BrewAutoUpdate < Formula
  homepage 'https://github.com/xakraz/homebrew-auto-update/'
  head 'https://github.com/xakraz/homebrew-auto-update.git', :branch => 'master'

  depends_on 'terminal-notifier'
  depends_on 'coreutils'

  def install
    inreplace 'bin/brew-auto-update', '/usr/local', HOMEBREW_PREFIX
    inreplace 'bin/brew-upgrade', '/usr/local', HOMEBREW_PREFIX
    prefix.install 'bin'
    (bin/'brew-auto-update').chmod 0755
    (bin/'brew-upgrade').chmod 0755
  end

  plist_options startup: false

  def plist; <<EOS
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC -//Apple Computer//DTD PLIST 1.0//EN http://www.apple.com/DTDs/PropertyList-1.0.dtd >

<plist version="1.0">
  <dict>
    <key>EnvironmentVariables</key>
    <dict>
      <key>PATH</key>
      <string>#{HOMEBREW_PREFIX}/opt/coreutils/libexec/gnubin:/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin</string>
    </dict>
    <key>Label</key>
    <string>#{plist_name}</string>

    <key>ProgramArguments</key>
    <array>
      <string>#{opt_bin}/brew-auto-update</string>
    </array>

    <key>ProcessType</key>
    <string>Background</string>

    <key>StartCalendarInterval</key>
    <dict>
      <!-- 1:00pm each day -->
      <key>Hour</key>
      <integer>13</integer>
      <key>Minute</key>
      <integer>0</integer>
    </dict>

    <key>RunAtLoad</key>
    <true/>

    <key>StandardOutPath</key>
    <string>#{ENV['HOME']}/Library/Logs/brew-auto-update/update.log</string>

    <key>StandardErrorPath</key>
    <string>#{ENV['HOME']}/Library/Logs/brew-auto-update/update.log</string>
  </dict>
</plist>
EOS
  end
end

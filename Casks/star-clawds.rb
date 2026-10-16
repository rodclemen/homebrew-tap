cask "star-clawds" do
  version "3.5.0"
  sha256 "6516d4b789005acab49e45297ac75a39f92c37fd2cb31ba65ac375d806525870"

  url "https://github.com/rodclemen/clawd-clash/releases/download/v#{version}/Clawd-Clash-#{version}.zip"
  name "Clawd Clash"
  desc "Claude Code sessions as a pixel-art Star Clawds battle on your desktop"
  homepage "https://github.com/rodclemen/clawd-clash"

  depends_on macos: :ventura
  conflicts_with cask: ["clawd-clash", "marvelous-clawds", "detective-clawds"]

  app "Clawd Clash.app"

  # Start in starWars, unless a universe was already picked.
  preflight_steps do
    run "/bin/sh",
        args:           ["-c", "defaults read com.rodclemen.clawdclash universe >/dev/null 2>&1 || defaults write com.rodclemen.clawdclash universe -string starWars"],
        writable_paths: ["Library/Preferences"],
        writable_base:  :home
  end

  # brew runs this on upgrade too (uninstall, then install): the hooks come out, and the new app puts
  # them back on its next launch. It may fail (macOS can refuse to run an installed copy that's been
  # changed, and kills it), and that mustn't stop the upgrade: the hooks then just stay, pointing at the
  # same path the new app is installed to.
  uninstall quit:   "com.rodclemen.clawdclash",
            script: {
              executable:   "#{appdir}/Clawd Clash.app/Contents/MacOS/ClawdClash",
              args:         ["--uninstall-hooks"],
              must_succeed: false,
            }

  zap trash: [
    "~/.claude/clawd-clash",
    "~/Library/Application Support/Clawd Clash",
    "~/Library/Screen Savers/Clawd Clash.saver",
    "~/Library/Preferences/com.rodclemen.clawdclash.plist",
  ]
end

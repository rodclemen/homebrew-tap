cask "star-clawds" do
  version "3.0.0"
  sha256 "8a8f79a11ff55b7ca6660062485949c24de9514e1cafb60a2f1d87adf44d27c4"

  url "https://github.com/rodclemen/clawd-clash/releases/download/v#{version}/Clawd-Clash-#{version}.zip"
  name "Clawd Clash"
  desc "Claude Code sessions as a pixel-art Star Clawds battle on your desktop"
  homepage "https://github.com/rodclemen/clawd-clash"

  depends_on macos: :ventura
  conflicts_with cask: ["clawd-clash", "marvelous-clawds", "detective-clawds"]

  app "Clawd Clash.app"

  # Start in starWars, unless a universe was already picked.
  preflight do
    system_command "/bin/sh", args: ["-c", "defaults read com.rodclemen.clawdclash universe >/dev/null 2>&1 || defaults write com.rodclemen.clawdclash universe -string starWars"]
  end

  # brew runs this on upgrade too (uninstall, then install): the hooks come out, and the new app puts
  # them back on its next launch.
  uninstall quit:   "com.rodclemen.clawdclash",
            script: {
              executable: "#{appdir}/Clawd Clash.app/Contents/MacOS/ClawdClash",
              args:       ["--uninstall-hooks"],
            }

  zap trash: [
    "~/.claude/clawd-clash",
    "~/Library/Application Support/Clawd Clash",
    "~/Library/Screen Savers/Clawd Clash.saver",
    "~/Library/Preferences/com.rodclemen.clawdclash.plist",
  ]
end

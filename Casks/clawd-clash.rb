cask "clawd-clash" do
  version "3.1.0"
  sha256 "1fd60c0846896127c135c432eddd1d77af15e2e9b4d0e9d328bd357e1d13549e"

  url "https://github.com/rodclemen/clawd-clash/releases/download/v#{version}/Clawd-Clash-#{version}.zip"
  name "Clawd Clash"
  desc "Claude Code sessions as a pixel-art Star Clawds, Marvelous Clawds or Detective Clawds battle on your desktop"
  homepage "https://github.com/rodclemen/clawd-clash"

  depends_on macos: :ventura
  conflicts_with cask: ["star-clawds", "marvelous-clawds", "detective-clawds"]

  app "Clawd Clash.app"

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

cask "star-clawds" do
  version "2.28.3"
  sha256 "21d2b2864792242b01953e8367fcdbe5334af83f095852860ae6de90e572af9f"

  url "https://github.com/rodclemen/star-clawds/releases/download/v#{version}/Clawd-Wars-#{version}.zip"
  name "Clawd Wars"
  desc "Claude Code sessions as a pixel-art Star Clawds battle on your desktop"
  homepage "https://github.com/rodclemen/star-clawds"

  depends_on macos: :ventura

  app "Clawd Wars.app"

  # brew runs this on upgrade too (uninstall, then install): the hooks come out, and the new app puts
  # them back on its next launch.
  uninstall quit:   "com.rodclemen.vaderclaude",
            script: {
              executable: "#{appdir}/Clawd Wars.app/Contents/MacOS/ClawdWars",
              args:       ["--uninstall-hooks"],
            }

  zap trash: [
    "~/.claude/vader-status",
    "~/Library/Application Support/Clawd Wars",
    "~/Library/Screen Savers/Clawd Wars.saver",
    "~/Library/Preferences/com.rodclemen.vaderclaude.plist",
  ]
end

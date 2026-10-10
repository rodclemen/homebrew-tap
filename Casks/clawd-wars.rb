cask "clawd-wars" do
  version "2.20.0"
  sha256 "edc88ee505a25dd105960a72756e144014395a0cf24abf8177235ef0a0b52662"

  url "https://github.com/rodclemen/clawd-wars/releases/download/v#{version}/Clawd-Wars-#{version}.zip"
  name "Clawd Wars"
  desc "Claude Code sessions as a pixel-art Star Wars battle on your desktop"
  homepage "https://github.com/rodclemen/clawd-wars"

  depends_on macos: :ventura

  app "Clawd Wars.app"

  uninstall quit:   "com.rodclemen.vaderclaude",
            script: {
              executable: "#{appdir}/Clawd Wars.app/Contents/MacOS/ClawdWars",
              args:       ["--uninstall-hooks"],
            }

  zap trash: [
    "~/.claude/vader-status",
    "~/Library/Preferences/com.rodclemen.vaderclaude.plist",
  ]
end

cask "clawd-wars" do
  version "2.25.0"
  sha256 "4e6c03e79ae727821c46f54b0969ede02a31221e2c6bea0782347461976ebf0a"

  url "https://github.com/rodclemen/clawd-wars/releases/download/v#{version}/Clawd-Wars-#{version}.zip"
  name "Clawd Wars"
  desc "Claude Code sessions as a pixel-art Star Wars battle on your desktop"
  homepage "https://github.com/rodclemen/clawd-wars"

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
    "~/Library/Preferences/com.rodclemen.vaderclaude.plist",
  ]
end

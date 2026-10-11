cask "clawd-wars" do
  version "2.26.1"
  sha256 "ecf9f565d6e4f0a76b24486853676dd08043d27ce0410eb40a7e344d020d02f2"

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
    "~/Library/Application Support/Clawd Wars",
    "~/Library/Screen Savers/Clawd Wars.saver",
    "~/Library/Preferences/com.rodclemen.vaderclaude.plist",
  ]
end

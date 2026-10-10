cask "clawd-wars" do
  version "2.15.0"
  sha256 "78b582fd0ec42ff0c1c43184defb1a9ba37b3944177b5e889605cc42ce854725"

  url "https://github.com/rodclemen/clawd-wars/releases/download/v#{version}/Clawd-Wars-#{version}.zip"
  name "Clawd Wars"
  desc "Claude Code sessions as a pixel-art Star Wars battle on your desktop"
  homepage "https://github.com/rodclemen/clawd-wars"

  depends_on macos: ">= :ventura"

  app "Clawd Wars.app"

  postflight do
    # Not notarized yet: clear the download quarantine so macOS lets it open.
    system_command "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "#{appdir}/Clawd Wars.app"]
  end

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

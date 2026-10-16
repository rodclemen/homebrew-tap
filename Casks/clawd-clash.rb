cask "clawd-clash" do
  version "3.4.0"
  sha256 "1ea09db1cf47051e2e8ca74a61eb5a4318c567cf67fc4b2ff9780993f38ee5ea"

  url "https://github.com/rodclemen/clawd-clash/releases/download/v#{version}/Clawd-Clash-#{version}.zip"
  name "Clawd Clash"
  desc "Your AI coding sessions as a pixel-art battle across many universes, on your desktop"
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

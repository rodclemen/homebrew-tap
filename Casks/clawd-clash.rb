cask "clawd-clash" do
  version "4.1.1"
  sha256 "0a87708fbd33bddfa44f075279abc9cb2d0fb1452f3fe67a7a23ad20ef38fca2"

  url "https://github.com/rodclemen/clawd-clash/releases/download/v#{version}/Clawd-Clash-#{version}.zip"
  name "Clawd Clash"
  desc "Your AI coding sessions as a pixel-art battle across many universes, on your desktop"
  homepage "https://github.com/rodclemen/clawd-clash"

  depends_on macos: :ventura
  depends_on arch: :arm64
  conflicts_with cask: ["star-clawds", "marvelous-clawds", "detective-clawds"]

  app "Clawd Clash.app"

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
    "~/Library/Containers/com.apple.ScreenSaver.Engine.legacyScreenSaver/Data/Library/Application Support/Clawd Clash Saver",
  ]
end

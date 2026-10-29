cask "clawds-of-the-universe" do
  version "4.2.0"
  sha256 "2664c98d9c7e18e3b808d8dbaddb691ef933a106c75a87c0b55454f473a8daeb"

  url "https://github.com/rodclemen/clawd-clash/releases/download/v#{version}/Clawd-Clash-#{version}.zip"
  name "Clawd Clash"
  desc "Claude Code sessions as a pixel-art Clawds of the Universe battle on your desktop"
  homepage "https://github.com/rodclemen/clawd-clash"

  depends_on macos: :ventura
  depends_on arch: :arm64
  conflicts_with cask: ["clawd-clash", "star-clawds", "marvelous-clawds", "detective-clawds"]

  app "Clawd Clash.app"

  # Start in eternia, unless a universe was already picked.
  preflight_steps do
    run "/bin/sh",
        args:           ["-c", "defaults read com.rodclemen.clawdclash universe >/dev/null 2>&1 || defaults write com.rodclemen.clawdclash universe -string eternia"],
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
    "~/Library/Containers/com.apple.ScreenSaver.Engine.legacyScreenSaver/Data/Library/Application Support/Clawd Clash Saver",
  ]
end

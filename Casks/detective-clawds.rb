cask "detective-clawds" do
  version "3.5.1"
  sha256 "f212c0bccafe869f670e40e263606207250cfb6c2e491d53cd80afaa70e43603"

  url "https://github.com/rodclemen/clawd-clash/releases/download/v#{version}/Clawd-Clash-#{version}.zip"
  name "Clawd Clash"
  desc "Claude Code sessions as a pixel-art Detective Clawds battle on your desktop"
  homepage "https://github.com/rodclemen/clawd-clash"

  depends_on macos: :ventura
  depends_on arch: :arm64
  conflicts_with cask: ["clawd-clash", "star-clawds", "marvelous-clawds"]

  app "Clawd Clash.app"

  # Start in dc, unless a universe was already picked.
  preflight_steps do
    run "/bin/sh",
        args:           ["-c", "defaults read com.rodclemen.clawdclash universe >/dev/null 2>&1 || defaults write com.rodclemen.clawdclash universe -string dc"],
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

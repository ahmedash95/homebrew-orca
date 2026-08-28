cask "orca" do
  version "0.0.8"
  sha256 "2c46113b3faf94d4f4dee525008d19cd9051734235851dec035cd88f18b6a839"

  url "https://github.com/ahmedash95/homebrew-orca/releases/download/v#{version}/Orca-#{version}.dmg"
  name "Orca"
  desc "Terminal workspace for AI coding agents"
  homepage "https://github.com/ahmedash95/homebrew-orca"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: ">= :monterey"

  app "Orca.app"

  # Orca is ad-hoc signed but not notarized (no Apple Developer Program
  # membership), so Gatekeeper would refuse to launch the downloaded bundle.
  # Clearing the quarantine flag here is what the README otherwise asks users
  # to run by hand.
  postflight do
    system_command "/usr/bin/xattr",
                   args:         ["-dr", "com.apple.quarantine", "#{appdir}/Orca.app"],
                   must_succeed: false
  end

  uninstall quit: "dev.ahmedash95.orca"

  zap trash: [
    "~/.orca",
    "~/Library/Saved Application State/dev.ahmedash95.orca.savedState",
  ]
end

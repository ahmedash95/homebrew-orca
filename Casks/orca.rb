cask "orca" do
  version "0.0.10"
  sha256 "9d65ae74695818efdedf3daf726be6ed7b0dd7af7f1ec274cb15e3ce70929506"

  url "https://github.com/ahmedash95/homebrew-orca/releases/download/v#{version}/Orca-#{version}.dmg"
  name "Orca"
  desc "Terminal workspace for AI coding agents"
  homepage "https://github.com/ahmedash95/homebrew-orca"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :monterey

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

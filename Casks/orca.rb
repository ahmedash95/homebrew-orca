cask "orca" do
  version "0.0.14"
  sha256 "51d04207f7776a98ea55e627778bbea44f3ddded8c804c252c2287a8da87e17e"

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

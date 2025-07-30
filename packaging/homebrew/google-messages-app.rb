cask "google-messages-app" do
  version "1.0.0"
  sha256 :no_check # Will be updated automatically

  url "https://github.com/YOUR_USERNAME/google-messages-app/releases/download/v#{version}/GoogleMessages-v#{version}-mac.dmg"
  name "Google Messages"
  desc "Desktop Google Messages application built with Electron"
  homepage "https://github.com/YOUR_USERNAME/google-messages-app"

  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates true

  app "Google Messages.app"

  zap trash: [
    "~/Library/Application Support/google-messages-app",
    "~/Library/Preferences/com.example.google-messages-app.plist",
    "~/Library/Caches/com.example.google-messages-app",
    "~/Library/Logs/google-messages-app",
    "~/Library/Saved Application State/com.example.google-messages-app.savedState",
  ]
end
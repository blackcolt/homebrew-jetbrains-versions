cask "datagrip@2022.3.3" do
  version "2022.3.3,223.8617.3"

  name "JetBrains DataGrip #{version.before_comma}"
  desc "Databases and SQL IDE"
  homepage "https://www.jetbrains.com/datagrip/"

  app "DataGrip.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/datagrip/datagrip-2022.3.3.dmg"
      sha256 "e9da8036c7d268368b3f82034389481730cb663b809659b1fa1ab91fd9bdc8cd"
  else
      url "https://download.jetbrains.com/datagrip/datagrip-2022.3.3-aarch64.dmg"
      sha256 "ef76c7d61c64f7f0f831ef2774bd908e68d651a20648fc4e63618e24a81be6dd"
  end

  uninstall_postflight do
    ENV["PATH"].split(File::PATH_SEPARATOR).map { |path| File.join(path, "datagrip") }.each do |path|
      if File.exist?(path) &&
        File.readlines(path).grep(/# see com.intellij.idea.SocketLock for the server side of this interface/).any?
        File.delete(path)
      end
    end
  end

  zap trash: [
    "~/Library/Application Support/JetBrains/DataGrip*",
    "~/Library/Caches/JetBrains/DataGrip*",
    "~/Library/Logs/JetBrains/DataGrip*",
    "~/Library/Saved Application State/com.jetbrains.datagrip.savedState",
  ]
end
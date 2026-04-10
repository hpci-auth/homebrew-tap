# ORIGINAL: https://github.com/indigo-dc/homebrew-oidc-agent/blob/master/Formula/oidc-agent.rb

class OidcAgentDesktopAT5 < Formula
  desc "Add oidc-prompt for oidc-agent-cli"
  homepage "https://github.com/indigo-dc/oidc-agent"
  url "https://github.com/indigo-dc/oidc-agent/archive/refs/tags/v5.3.5.tar.gz"
  sha256 "aaa212730560caea21d4d3b72218c55e5eeec1f776d711f58044339f168ed60a"
  license "MIT"
  # revision 1

  bottle do
    root_url "https://github.com/hpci-auth/homebrew-tap/releases/download/oidc-agent-desktop@5-5.3.5"
    sha256 cellar: :any, arm64_tahoe:   "fcc280e6406597def9b3cc19b446ac45b65ad87b7b53e6429c4422cd4e82aeab"
    sha256 cellar: :any, arm64_sequoia: "f057061c8775ca2fc3b26c34254473f2bba053bb386c768bdcca05353d3715ef"
  end

  depends_on "help2man" => :build
  depends_on "argp-standalone"
  depends_on "libmicrohttpd"
  depends_on "libsodium"
  depends_on :macos # macOS only
  depends_on "oidc-agent-cli@5"
  depends_on "pkg-config"
  depends_on "qrencode"

  on_macos do
    # /usr/bin/jq is installed in macOS 15 or later
    depends_on "jq" if OS.mac? && MacOS.version < :sequoia
  end

  def install
    system "make", "-j#{ENV.make_jobs}", "PREFIX=#{prefix}"
    system "make", "install", "PREFIX=#{prefix}"

    Dir.glob(bin/"*") do |file|
      # ohai file
      next if %w[oidc-prompt].include?(File.basename(file))

      rm file, verbose: true
    end
    Dir.glob(man1/"*") do |file|
      # ohai file
      next if %w[oidc-prompt.1.gz].include?(File.basename(file))

      rm file, verbose: true
    end
    Dir.glob(lib/"*") do |file|
      # ohai file
      rm file, verbose: true
    end
    Dir.glob(prefix/"etc/oidc-agent/*") do |file|
      # ohai file
      rm_r file, verbose: true
    end
  end

  test do
    assert_predicate bin/"oidc-prompt", :executable?
  end
end

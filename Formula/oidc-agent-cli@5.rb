# ORIGINAL: https://github.com/indigo-dc/homebrew-oidc-agent/blob/master/Formula/oidc-agent.rb

class OidcAgentCliAT5 < Formula
  desc "Manage OpenID Connect tokens on the command-line (without oidc-prompt)"
  homepage "https://github.com/indigo-dc/oidc-agent"
  url "https://github.com/indigo-dc/oidc-agent/archive/refs/tags/v5.3.5.tar.gz"
  sha256 "aaa212730560caea21d4d3b72218c55e5eeec1f776d711f58044339f168ed60a"
  license "MIT"
  # revision 1

  bottle do
    root_url "https://github.com/hpci-auth/homebrew-tap/releases/download/oidc-agent-cli@5-5.3.4_1"
    sha256 arm64_tahoe:   "283b41a547fcf5c71412d0c09c3e29a58bc0db2586967cf4432485a0e083da32"
    sha256 arm64_sequoia: "1048b224c1aa98aaead97a808e77f25af8a74b157c83fcebe1a23bf1f469f1ce"
  end

  depends_on "help2man" => :build
  depends_on "argp-standalone"
  depends_on "libmicrohttpd"
  depends_on "libsodium"
  depends_on :macos # macOS only
  depends_on "pkg-config"
  depends_on "qrencode"

  on_macos do
    # /usr/bin/jq is installed in macOS 15 or later
    depends_on "jq" if OS.mac? && MacOS.version < :sequoia
  end

  def install
    system "make", "-j#{ENV.make_jobs}", "PREFIX=#{prefix}"
    system "make", "install", "PREFIX=#{prefix}"

    rm bin/"oidc-prompt"
    rm man1/"oidc-prompt.1"
  end

  service do
    run [opt_bin/"oidc-agent", "-a", "~/Library/Caches/oidc-agent/oidc-agent.sock", "-d"]
    keep_alive true
    working_dir var
    log_path var/"log/oidc-agent.log"
    error_log_path var/"log/oidc-agent.log"
    environment_variables PATH: "/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/opt/homebrew/bin"
  end

  def caveats
    <<~EOS
      To start oidc-agent as a background service now and restart at login:
        brew services start oidc-agent
      If you don't need a background service, you can run the following instead:
        oidc-agent -a ~/Library/Caches/oidc-agent/oidc-agent.sock -d
    EOS
  end

  test do
    refute_path_exists bin/"oidc-prompt"
    assert_match version.to_s, shell_output("#{bin}/oidc-agent --version")
  end
end

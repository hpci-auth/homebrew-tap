class Hpcissh < Formula
  desc "SSH client for HPCI"
  homepage "https://github.com/hpci-auth/hpcissh-clients"

  # url "https://github.com/hpci-auth/hpcissh-clients.git",
  #     tag: "v1.12.0"
  url "https://github.com/hpci-auth/hpcissh-clients.git",
      revision: "44146649fbd35e660cf6cfc4643454de76cf474f"
  version "1.12.0-rc7"

  license "Apache-2.0"

  head "https://github.com/hpci-auth/hpcissh-clients.git", branch: "develop"

  bottle do
    root_url "https://github.com/hpci-auth/homebrew-tap/releases/download/hpcissh-1.12.0-rc6"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "532e5a555a5dc85876001b4479875a53dd6167c818cdf77b7c4737ef655b7062"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "eea0a368604595cdca8866cee23218910fca98b4b4a6e9a306ae9b84a2719815"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "f570e64fa990a946a856c9c5573421b5991810a072a90fb120b353f7dca25c0c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "724e08e94d4d25a94adeb51ea08a80e752611f9a2aee01a9b78a98a2ac59f2b9"
  end

  depends_on "jwt-agent"

  on_macos do
    # (optional) depends_on "oidc-agent"

    depends_on "bash"
    # /usr/bin/jq is installed in macOS 15 or later
    depends_on "jq" if OS.mac? && MacOS.version < :sequoia
    depends_on "sshpass"

    # curl is required but is already included with macOS
  end

  def install
    args = %W[
      prefix=#{prefix}
    ]
    # use bash version 5 on macOS
    args << "bash_path=#{HOMEBREW_PREFIX}/bin/bash" if OS.mac?
    system "make", *args
    system "make", "install", *args
  end

  # def caveats
  #   <<~EOS
  #   EOS
  # end

  test do
    assert_path_exists bin/"test-hpcissh"
    assert_predicate bin/"test-hpcissh", :executable?
    system bin/"test-hpcissh"
  end
end

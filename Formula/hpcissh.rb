class Hpcissh < Formula
  desc "SSH client for HPCI"
  homepage "https://github.com/hpci-auth/hpcissh-clients"

  # url "https://github.com/hpci-auth/hpcissh-clients.git",
  #     tag: "v1.12.0"
  url "https://github.com/hpci-auth/hpcissh-clients.git",
      revision: "207dec3343828e2bcefdfdee2ca831575f896a11"
  version "1.12.0-rc9"

  license "Apache-2.0"

  head "https://github.com/hpci-auth/hpcissh-clients.git", branch: "develop"

  bottle do
    root_url "https://github.com/hpci-auth/homebrew-tap/releases/download/hpcissh-1.12.0-rc9"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "e65d636022caf55517ce3cbd2c097d93c4e865e6f244e77b0ea1d15634610e69"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "1f54901e667f2ecea65958398c8447d62fa083d2c344a5cd75bb2073fa452dc4"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "617279291156912135b8927c229bedb1f672c11eb93a569a84b8e6468b63bf1c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "33bc2907500d99a8b6b89f8171f80c9380e77e891aed5c89c988f75a6482e3aa"
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

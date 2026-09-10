class Hpcissh < Formula
  desc "SSH client for HPCI"
  homepage "https://github.com/hpci-auth/hpcissh-clients"

  # url "https://github.com/hpci-auth/hpcissh-clients.git",
  #     tag: "v1.12.0"
  url "https://github.com/hpci-auth/hpcissh-clients.git",
      revision: "bba7da37e1e7f761a84f81b6707ed4798f5f8958"
  version "1.12.0-rc10"

  license "Apache-2.0"

  head "https://github.com/hpci-auth/hpcissh-clients.git", branch: "develop"

  bottle do
    root_url "https://github.com/hpci-auth/homebrew-tap/releases/download/hpcissh-1.12.0-rc10"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "cd99a5e64affdf91c395e0f1393118a443226120b33580052d1b21a56baeb492"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "adf31e09a6a897e360c00a2d722df0e9b57dc9414e4b213d1f189130b9690a5f"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "ca0799076c3329e6fc3f6cd9d458c53654de3b6d076a669168fa9649fc9a97ba"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "506504363aa2bc5e3bb5a2f171f790ba0f1b0f8b1d8d79e6a3dacc2c4017624f"
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

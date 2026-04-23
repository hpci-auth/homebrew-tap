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
    root_url "https://github.com/hpci-auth/homebrew-tap/releases/download/hpcissh-1.12.0-rc8"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "00ce31b29105f6665e33814f52adc1840b7881dc15ddf8832ccf228f5b0af047"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "bfa76bfb6a1371272a90d67dcd079f0fafdb864c753b4260e381495eceaec344"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "a354eb31ab782452474b161ad7686614dff9131fd0039129548e650a24edc526"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "7b81c7199ff70ffce4daca5e681b3dca3c91b121736566ca4277dc3a8e557f9f"
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

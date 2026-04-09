class Hpcissh < Formula
  desc "SSH client for HPCI"
  homepage "https://github.com/hpci-auth/hpcissh-clients"

  # url "https://github.com/hpci-auth/hpcissh-clients.git",
  #     tag: "v1.12.0"
  url "https://github.com/hpci-auth/hpcissh-clients.git",
      revision: "08cda0d1e3b3ceddcc605b561fdc9ebc4fe4550d"
  version "1.12.0-rc8"

  license "Apache-2.0"

  head "https://github.com/hpci-auth/hpcissh-clients.git", branch: "develop"

  bottle do
    root_url "https://github.com/hpci-auth/homebrew-tap/releases/download/hpcissh-1.12.0-rc7"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "707cfcee6fbc0d8e7ce1e28f094c7e5e66209bf49c9aef57af59422664d7a06a"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "585fa909cf30ff1b6d70c3fc2560e3d8a875c12640e3e763f13400bb0e4ba18e"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "6237a75cbc847c5afa33ba1df314422a69ca555ec2b2488858120d7c9382b8c4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "d942bcf917fb77e0306a043178d39b3c913d3715847be4fe8a97269046f59d06"
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

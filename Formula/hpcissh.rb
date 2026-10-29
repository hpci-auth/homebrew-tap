class Hpcissh < Formula
  desc "SSH client for HPCI"
  homepage "https://github.com/hpci-auth/hpcissh-clients"

  # url "https://github.com/hpci-auth/hpcissh-clients.git",
  #     tag: "v1.12.0"
  url "https://github.com/hpci-auth/hpcissh-clients.git",
      revision: "0e20f363a3bc91eba48b9e8dc68218fedbea742c"
  version "1.12.0"

  license "Apache-2.0"

  head "https://github.com/hpci-auth/hpcissh-clients.git", branch: "develop"

  bottle do
    root_url "https://github.com/hpci-auth/homebrew-tap/releases/download/hpcissh-1.12.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "813a722930c3d4849cc5223aa2ac65cb3e40eaf710938aa64205bf8ea172c1dc"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "1a89f42ba6bfa4754b7b7548ab9a03081002e10399e18a2382f2cdef66eca6aa"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "eb3c8463fee347e96b2b019486cc11c1b93a8f591f87fa090d32077a63b9561f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c7caad4f512776ec51467eebdbb7edf3e27a62b627b7ea0e6f177cf340cc2068"
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

class JwtAgent < Formula
  desc "Obtain a JSON Web Token (JWT) from a JWT server"
  homepage "https://github.com/oss-tsukuba/jwt-agent"

  url "https://github.com/oss-tsukuba/jwt-agent.git",
      tag: "1.1.1"

  license "BSD-3-Clause"

  bottle do
    root_url "https://github.com/hpci-auth/homebrew-tap/releases/download/jwt-agent-1.1.1"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "9174ebb5d345d1bbe8dfec3963b435bbb41b7d9b5a1324c14c2258f2ac3b889a"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "e01be9b62fb97d09d97f5777c23db781e73e8aba7552095bd2aa0616ba66cc9a"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "b55fb94cb07563fffdd0aca6950aa4edbd3e3fd5f41e1efd95f9d45702825321"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e40ebef0f5342028800d15307d9b41959252fe7f0b4a2f55ae30fbd93d985477"
  end

  depends_on "go" => :build

  def install
    inreplace "jwt-agent" do |s|
      s.gsub! "#!/bin/sh", "#!/bin/bash"
    end

    # workaround for "pandoc: No such file or directory"
    touch ["jwt-agent.1.md", "jwt-agent.1"], mtime: Time.now
    system "make"
    system "make", "install", "PREFIX=#{prefix}", "MANDIR=#{man}"
  end

  test do
    system "#{bin}/jwt-agent", "--version"
  end
end

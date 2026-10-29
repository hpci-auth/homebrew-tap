class JwtAgent < Formula
  desc "Obtain a JSON Web Token (JWT) from a JWT server"
  homepage "https://github.com/oss-tsukuba/jwt-agent"

  url "https://github.com/oss-tsukuba/jwt-agent.git",
      tag:      "1.1.1",
      revision: "7af7edb4fce224068304bab719f44efa26e8d7a5"

  license "BSD-3-Clause"

  bottle do
    root_url "https://github.com/hpci-auth/homebrew-tap/releases/download/jwt-agent-1.1.1"
    rebuild 2
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "46e564fc6ae27cd4ec71bd364294df30b40b30be5e3244ab5866d7f4d0c14e54"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "c30ac7f9af6eb82dfc24ce937c6aae9158f032feeb6ab40ed4a256f07fb6221f"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "743b3dba433d7f85be8c140e1f569c1a81fa492d9fb0e0be7ec35dff4ec829ce"
    sha256 cellar: :any,                 x86_64_linux:  "4235b3e9d3211baa2195f13ab26da7bd0b39720300df9b7b2239884de1926512"
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

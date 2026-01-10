class HpcAT04 < Formula
  desc "Local-first Slurm submissions over SSH"
  homepage "https://hpcd.dev"
  url "https://github.com/hpcd-dev/hpcd/archive/refs/tags/v0.4.1.tar.gz"
  sha256 "1f80572c2700440198c933abc951a70ecd4d2ee146822bdee2c8312ef252c07d"
  license "AGPL-3.0-only"

  bottle do
    root_url "https://github.com/hpcd-dev/homebrew-hpc/releases/download/hpc-0.4.1"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "dfb7062bc85cb4e55ff2e4505a6f9e05a02ecf87c181b613bdc30b1f4b041887"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "714e5830c1b037be234c9ea39433cef6b0c1e4b1807937cd4433c425c31d8d60"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "1c8a42d0d324a4d6c097c519a56ad886128a0fbe2f41091166977ba039841464"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f2ffc972ca56ee4efb6012ec2644c0c8957732b6cedd5258dbe7f3534b4b2d5c"
  end

  keg_only :versioned_formula

  depends_on "pkg-config" => :build
  depends_on "rust" => :build
  depends_on "protobuf" => :build
  depends_on "openssl@3" if OS.linux?
  depends_on "sqlite" if OS.linux?

  def install
    system "cargo", "install", *std_cargo_args(path: "cli")
    system "cargo", "install", *std_cargo_args(path: "hpcd")
  end

  service do
    run [opt_bin/"hpcd"]
    keep_alive true
    log_path var/"log/hpcd.log"
    error_log_path var/"log/hpcd.log"
  end

  test do
    system bin/"hpc", "--help"
    system bin/"hpcd", "--help"
  end
end

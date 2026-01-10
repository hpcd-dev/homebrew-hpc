class Hpc < Formula
  desc "Local-first Slurm submissions over SSH"
  homepage "https://hpcd.dev"
  url "https://github.com/hpcd-dev/hpcd/archive/refs/tags/v0.4.1.tar.gz"
  sha256 "1f80572c2700440198c933abc951a70ecd4d2ee146822bdee2c8312ef252c07d"
  license "AGPL-3.0-only"

  bottle do
    root_url "https://github.com/hpcd-dev/homebrew-hpc/releases/download/hpc-0.4.1"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "7ec24c5e20f04d3db7c7eb1e570471f36d9c018e1dbeec0b79f2e84602a57e98"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "8fde28561ee586076cab89fbdabeea5b3a8b833302652c779f3e0e30e9fc8db3"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "dd4ab20e0bf86f1f585048dc5d7b404d650a705b232b3870a5c0361386c84a14"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "db10a81fd69abdcf97488f721fa10fbfb77571b2040067163f91f3233c7f1c60"
  end

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

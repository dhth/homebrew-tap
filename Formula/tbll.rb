class Tbll < Formula
  desc "tbll outputs data in tabular format"
  homepage "https://github.com/dhth/tbll"
  version "0.2.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/dhth/tbll/releases/download/v0.2.2/tbll-aarch64-apple-darwin.tar.xz"
      sha256 "db3693cfffd6fe874f2a4df9f74d08b89678642989dfde9c8009cd0270233872"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dhth/tbll/releases/download/v0.2.2/tbll-x86_64-apple-darwin.tar.xz"
      sha256 "5560d819a45f516a3d2a607a972f12af3f2de6cfee813a65b4c7aa418d1f7c0e"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/dhth/tbll/releases/download/v0.2.2/tbll-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "cf58a316d38907b472efe76a8e0335a759f0d9cd69cc2833affe887eb6608523"
  end

  BINARY_ALIASES = {
    "aarch64-apple-darwin":     {},
    "x86_64-apple-darwin":      {},
    "x86_64-unknown-linux-gnu": {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    bin.install "tbll" if OS.mac? && Hardware::CPU.arm?
    bin.install "tbll" if OS.mac? && Hardware::CPU.intel?
    bin.install "tbll" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end

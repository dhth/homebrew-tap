class Sqdj < Formula
  desc "sqdj shortens delimited data"
  homepage "https://github.com/dhth/squidge"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/dhth/squidge/releases/download/v0.1.0/sqdj-aarch64-apple-darwin.tar.xz"
      sha256 "1fc689e33bb6f16d7e5c5fcad29bff7632853bde0d2855de203f49ca923cfac0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dhth/squidge/releases/download/v0.1.0/sqdj-x86_64-apple-darwin.tar.xz"
      sha256 "8176abda6f9f650c1f046149268af460e20c678c912d59a6119f6b37362fe69b"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/dhth/squidge/releases/download/v0.1.0/sqdj-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "445ab3f73a55bb66478e02b1a82a76d12b27a24042d3a54f2b79561ad03b18b8"
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":     {},
    "x86_64-apple-darwin":      {},
    "x86_64-pc-windows-gnu":    {},
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
    bin.install "sqdj" if OS.mac? && Hardware::CPU.arm?
    bin.install "sqdj" if OS.mac? && Hardware::CPU.intel?
    bin.install "sqdj" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end

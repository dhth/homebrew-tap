class Sqdj < Formula
  desc "sqdj shortens delimited data"
  homepage "https://github.com/dhth/squidge"
  version "0.2.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/dhth/squidge/releases/download/v0.2.1/sqdj-aarch64-apple-darwin.tar.xz"
      sha256 "c93e340a3f9d7afc96dd1193e2127fa3ff41711891b6b6fb05e7d738479122b4"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dhth/squidge/releases/download/v0.2.1/sqdj-x86_64-apple-darwin.tar.xz"
      sha256 "740672ff563d0acb6e8bb1a304831740ba4b39cb564753ce5b2053ea07b3e219"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/dhth/squidge/releases/download/v0.2.1/sqdj-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "205c142fb7f7181782450fa048b628d76a0a91f8baf5483dcdab04fb377e7211"
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

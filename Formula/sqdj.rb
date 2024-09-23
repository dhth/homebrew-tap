class Sqdj < Formula
  desc "sqdj shortens delimited data"
  homepage "https://github.com/dhth/squidge"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/dhth/squidge/releases/download/v0.2.0/sqdj-aarch64-apple-darwin.tar.xz"
      sha256 "c7a007a68773badfeb194d6d489348472db058e204297736be8d222b12d61cd8"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dhth/squidge/releases/download/v0.2.0/sqdj-x86_64-apple-darwin.tar.xz"
      sha256 "20da4bafc57ed7bd3473f765c7e6b758db89ba1b52c7e628aeaa6b6431f4233f"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/dhth/squidge/releases/download/v0.2.0/sqdj-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "659cb8e8a7c5dc67cc7d9e1b1dd634887493186924e71a59d38d55812bd0b718"
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

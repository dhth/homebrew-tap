class Sqdj < Formula
  desc "sqdj shortens delimited data"
  homepage "https://github.com/dhth/squidge"
  version "0.2.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/dhth/squidge/releases/download/v0.2.3/sqdj-aarch64-apple-darwin.tar.xz"
      sha256 "ebaaf54dbbb7edd05faf09665119300b66d5d8e1b4ebe19ca6a3a52ee59e8808"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dhth/squidge/releases/download/v0.2.3/sqdj-x86_64-apple-darwin.tar.xz"
      sha256 "5911a6fcd828b299569faf72bc072d0de16ef1ba52955c68bd7eaeca466f8159"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/dhth/squidge/releases/download/v0.2.3/sqdj-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "c0791b8c8140490207f9c3199ab0ca313a2ce5ae2aaeb6404dc549a8861ab26f"
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

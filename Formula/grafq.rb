class Grafq < Formula
  desc "query Neo4j/AWS Neptune databases via an interactive console"
  homepage "https://github.com/dhth/grafq"
  version "0.2.0"
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/dhth/grafq/releases/download/v0.2.0/grafq-aarch64-apple-darwin.tar.xz"
    sha256 "1858a5da428bc3d0d83ed76f224a17fa9243e3388339c8588d2d570e6b1feb7d"
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/dhth/grafq/releases/download/v0.2.0/grafq-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "ce94531042a96d7addcfa7f7fcb2d92668e57dcdad09240a171b84b7500c06c6"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dhth/grafq/releases/download/v0.2.0/grafq-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "01091d0480397905188467278571a04872a2c58ec0acf38a2b2905006125dc9a"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-unknown-linux-gnu":  {},
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
    bin.install "grafq" if OS.mac? && Hardware::CPU.arm?
    bin.install "grafq" if OS.linux? && Hardware::CPU.arm?
    bin.install "grafq" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end

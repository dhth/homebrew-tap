class Bmm < Formula
  desc "bmm lets you get to your bookmarks in a flash"
  homepage "https://tools.dhruvs.space/bmm/"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/dhth/bmm/releases/download/v0.1.0/bmm-aarch64-apple-darwin.tar.xz"
      sha256 "ac3135f8ee8e11fcbfd196018894f8f4f0f47ada7d23ad19bd646d9dd503995d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dhth/bmm/releases/download/v0.1.0/bmm-x86_64-apple-darwin.tar.xz"
      sha256 "52589d73825f036adc960f416e0ed8a48a3df0c5d3ae4a9afa2381f2e7eeac35"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/dhth/bmm/releases/download/v0.1.0/bmm-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "f603035923391893894099cd7d895d6139f1e790a394e0bd197ca7c8bb8871ff"
  end

  BINARY_ALIASES = {
    "aarch64-apple-darwin":              {},
    "x86_64-apple-darwin":               {},
    "x86_64-unknown-linux-gnu":          {},
    "x86_64-unknown-linux-musl-dynamic": {},
    "x86_64-unknown-linux-musl-static":  {},
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
    bin.install "bmm" if OS.mac? && Hardware::CPU.arm?
    bin.install "bmm" if OS.mac? && Hardware::CPU.intel?
    bin.install "bmm" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end

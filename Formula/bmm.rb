class Bmm < Formula
  desc "bmm lets you get to your bookmarks in a flash"
  homepage "https://tools.dhruvs.space/bmm/"
  version "0.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/dhth/bmm/releases/download/v0.3.0/bmm-aarch64-apple-darwin.tar.xz"
      sha256 "4d0cd0250620e811ed5de9f79048594d6338c6132a22bbb75063b85719a432cc"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dhth/bmm/releases/download/v0.3.0/bmm-x86_64-apple-darwin.tar.xz"
      sha256 "e799f85e6dcf35e4dd9d55842722cea66ff382de628a8c94c25eca5ad43cc1d2"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/dhth/bmm/releases/download/v0.3.0/bmm-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "ba78c154e0f69042f206389570a310b3f3eb713d3072e4298334ec5fcb6bd654"
  end
  license "MIT"

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

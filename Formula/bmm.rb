class Bmm < Formula
  desc "bmm lets you get to your bookmarks in a flash"
  homepage "https://tools.dhruvs.space/bmm/"
  version "0.3.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/dhth/bmm/releases/download/v0.3.1/bmm-aarch64-apple-darwin.tar.xz"
      sha256 "55639374f14ef8133682658adced2355aa0a1ce553f5f2689c427e15945fa72c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dhth/bmm/releases/download/v0.3.1/bmm-x86_64-apple-darwin.tar.xz"
      sha256 "2a2d6d7bc9107e5bf68b5d63898078425e9ea915057c1e4c32c0a209788ae2fb"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/dhth/bmm/releases/download/v0.3.1/bmm-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "9f55e1279e2641897c0735a5a69cf953cab0e830fc6642e6ba0862026775ff20"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dhth/bmm/releases/download/v0.3.1/bmm-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "fa61f38ee59a728cfe2ae4e0a2c5b29408cc99132f4b6edb456b622d4d049641"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":              {},
    "aarch64-unknown-linux-gnu":         {},
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
    bin.install "bmm" if OS.linux? && Hardware::CPU.arm?
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

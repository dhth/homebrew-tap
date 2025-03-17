class Ecscope < Formula
  desc "ecscope lets you monitor AWS ECS resources from the terminal"
  homepage "https://tools.dhruvs.space/ecscope/"
  version "0.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/dhth/ecscope/releases/download/v0.3.0/ecscope-aarch64-apple-darwin.tar.xz"
      sha256 "0e46fd7facdfd33f18b7adc840c867fdac1657958845ee40f8345bee8a84350a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dhth/ecscope/releases/download/v0.3.0/ecscope-x86_64-apple-darwin.tar.xz"
      sha256 "d00455fcfb5dc1914e52732367af31dbd06eaa71a82fb756a3fa6599b4b5c1ed"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/dhth/ecscope/releases/download/v0.3.0/ecscope-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "c27b0dfd265a6cb25f1a37e603812eda629673852ccbdc9576b874c8536c547c"
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
    bin.install "ecscope" if OS.mac? && Hardware::CPU.arm?
    bin.install "ecscope" if OS.mac? && Hardware::CPU.intel?
    bin.install "ecscope" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end

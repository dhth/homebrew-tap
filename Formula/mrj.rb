class Mrj < Formula
  desc "mrj merges your open dependency upgrade PRs"
  homepage "https://tools.dhruvs.space/mrj"
  version "0.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/dhth/mrj/releases/download/v0.3.0/mrj-aarch64-apple-darwin.tar.xz"
      sha256 "b1faddbb0e4a72c88486ad1e7d5019fbbe68fdc0a30f3a38a939ab5716d45822"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dhth/mrj/releases/download/v0.3.0/mrj-x86_64-apple-darwin.tar.xz"
      sha256 "86552571d27950487210c887b7c0a40fbc0f7317e80b13c84045e2ee8f2fad8c"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/dhth/mrj/releases/download/v0.3.0/mrj-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "6bc6832ad8e6c481d9f8e466c0a867787a818836cc46e0105b97e8d89b5aa343"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dhth/mrj/releases/download/v0.3.0/mrj-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "4e6ff4431075aed719ee05469a940c12a55ec36ad3e5502a1f4ddb789f64cf3e"
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
    bin.install "mrj" if OS.mac? && Hardware::CPU.arm?
    bin.install "mrj" if OS.mac? && Hardware::CPU.intel?
    bin.install "mrj" if OS.linux? && Hardware::CPU.arm?
    bin.install "mrj" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end

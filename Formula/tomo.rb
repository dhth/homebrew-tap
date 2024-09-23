class Tomo < Formula
  desc "tomo is a no-frills pomodoro progress indicator for tmux"
  homepage "https://github.com/dhth/tomo"
  version "0.2.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/dhth/tomo/releases/download/v0.2.1/tomo-aarch64-apple-darwin.tar.xz"
      sha256 "6559417face31c4c371a51283008180bcf31736db750299a4f3b0bee85dc06b4"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dhth/tomo/releases/download/v0.2.1/tomo-x86_64-apple-darwin.tar.xz"
      sha256 "546523dd2f888ac9bb8b4267f6264466c76b2c809317d170a13eeb0be1778b16"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/dhth/tomo/releases/download/v0.2.1/tomo-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "72f48bc31bd31135288de128240c10dd7209057b222f3e2edcf713f2d46d76d9"
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":     {},
    "x86_64-apple-darwin":      {},
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
    bin.install "tomo" if OS.mac? && Hardware::CPU.arm?
    bin.install "tomo" if OS.mac? && Hardware::CPU.intel?
    bin.install "tomo" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end

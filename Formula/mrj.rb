class Mrj < Formula
  desc "mrj merges your open dependency upgrade PRs"
  homepage "https://tools.dhruvs.space/mrj"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/dhth/mrj/releases/download/v0.2.0/mrj-aarch64-apple-darwin.tar.xz"
      sha256 "d1dab2d80c822e6aa302d65b11d6ff9331c40cb03cc6e5465d7e6cb4a09538a8"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dhth/mrj/releases/download/v0.2.0/mrj-x86_64-apple-darwin.tar.xz"
      sha256 "12c87f8b9c67fd36a1ffd6368ac7dec69964b88f5e3f39b95e59d511ad9ac827"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/dhth/mrj/releases/download/v0.2.0/mrj-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "3a52a040194cc6b4299a62a5afb9e273b35ebd3bd6006542017bdd6b75c2f02f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dhth/mrj/releases/download/v0.2.0/mrj-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "a955fbf2594217b070aba6b3c18a06fff9db62efbb2a910f3c28567cae152cf1"
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

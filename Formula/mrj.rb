class Mrj < Formula
  desc "mrj merges your open dependency upgrade PRs"
  homepage "https://tools.dhruvs.space/mrj"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/dhth/mrj/releases/download/v0.1.0/mrj-aarch64-apple-darwin.tar.xz"
      sha256 "af844d08b55026afdb52a2696f45778931129e684b1d304f310200e51aaed883"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dhth/mrj/releases/download/v0.1.0/mrj-x86_64-apple-darwin.tar.xz"
      sha256 "1e595a2fb5f34f3bed1b3fc2521c72a157499e29ddcc68ab79ecca86b4287523"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/dhth/mrj/releases/download/v0.1.0/mrj-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "198b733202db557deaaef704fa96affbe697b8d8c260f9186953bf23ad3ddfb8"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dhth/mrj/releases/download/v0.1.0/mrj-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "95772302b4d4c3371219654f57a65386d28f4a4be6327ced79d5ee161c818615"
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

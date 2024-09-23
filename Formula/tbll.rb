class Tbll < Formula
  desc "tbll outputs data in tabular format"
  homepage "https://github.com/dhth/tbll"
  version "0.2.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/dhth/tbll/releases/download/v0.2.1/tbll-aarch64-apple-darwin.tar.xz"
      sha256 "279982049079853fb5a17de32cd8a7411dfa23c1b8ecf282cc0f6b78282f2bb6"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dhth/tbll/releases/download/v0.2.1/tbll-x86_64-apple-darwin.tar.xz"
      sha256 "2b1c720503768864f783da28dfd5264a718f007eef54021d57c26e6ea01f9303"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/dhth/tbll/releases/download/v0.2.1/tbll-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "1e5ffdf6af12f3b4c4228c2cc8e701fe799e677315c0efe054335e421bd9273e"
  end

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
    bin.install "tbll" if OS.mac? && Hardware::CPU.arm?
    bin.install "tbll" if OS.mac? && Hardware::CPU.intel?
    bin.install "tbll" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end

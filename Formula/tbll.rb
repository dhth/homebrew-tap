class Tbll < Formula
  desc "tbll outputs data in tabular format"
  homepage "https://github.com/dhth/tbll"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/dhth/tbll/releases/download/v0.2.0/tbll-aarch64-apple-darwin.tar.xz"
      sha256 "74d2355d556a23eccc57e80729be7bd9771829fadddcf8eed674fed04c3bfa0d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dhth/tbll/releases/download/v0.2.0/tbll-x86_64-apple-darwin.tar.xz"
      sha256 "3422f778f3eeeb0e0b7a3bbacdff9cfa709a0c39ddf4f5e0316739d184ece7e9"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/dhth/tbll/releases/download/v0.2.0/tbll-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "24a5ae0620d0956b242b6c7c6b6b1880baf4d1339668a17455b17ade79fa4e4f"
    end
  end

  BINARY_ALIASES = {"aarch64-apple-darwin": {}, "x86_64-apple-darwin": {}, "x86_64-unknown-linux-gnu": {}}

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
    if OS.mac? && Hardware::CPU.arm?
      bin.install "tbll"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "tbll"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "tbll"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end

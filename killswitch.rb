class Killswitch < Formula
  desc "create & load a kill-switch pf.conf"
  homepage "https://vpn-kill-switch.com/"
  url "https://github.com/vpn-kill-switch/killswitch.git",
      :tag => "0.3.0",
      :revision => "59b5ce0c9a9da440fe5fa4e20f9180935c810302"

  head "https://github.com/vpn-kill-switch/killswitch.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "179e07bb22e2755e3d082f07607cf2e98e266defaace3ceb764a4c32f03ccf8d" => :sierra
    sha256 "5be8ef01a8568b7de75b19d525a4830b0c934c43b9e8f9fb150cbdcb18091a26" => :el_capitan
    sha256 "6dcf9d7de2489f5e3d6fd56488c3abe2bff1ea6f6bf0d9de89421b0e9a7e2e38" => :yosemite
  end

  depends_on "go" => :build

  def install
    ENV["GOPATH"] = buildpath
    (buildpath/"src/github.com/vpn-kill-switch/killswitch").install buildpath.children
    cd "src/github.com/vpn-kill-switch/killswitch" do
      system "make"
      bin.install "killswitch"
    end
  end

  test do
    system bin/"killswitch", "-v"
  end
end

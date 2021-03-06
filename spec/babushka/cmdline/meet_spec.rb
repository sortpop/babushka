require 'spec_helper'

RSpec.describe Babushka::Cmdline, 'meet' do
  describe "argument parsing" do
    let(:parser) {
      Babushka::Cmdline::Parser.for(%w[git version=1.7.7 source=http://git.org/git.tgz])
    }
    before {
      expect(Babushka::Base.task).to receive(:process).with(
        %w[git],
        {'version' => '1.7.7', 'source' => 'http://git.org/git.tgz'},
        parser
      )
    }
    it "should recognise args" do
      parser.run
    end
  end

  describe "dep invocation" do
    it "should invoke the dep correctly" do
      expect(Dep('git')).to receive(:process).with(true)
      Babushka::Cmdline::Parser.for(%w[git]).run
    end
    it "should invoke the dep correctly when --dry-run is supplied" do
      expect(Dep('git')).to receive(:process).with(false)
      Babushka::Cmdline::Parser.for(%w[git --dry-run]).run
    end
  end
end

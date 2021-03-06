require 'spec_helper'
require 'rbconfig'

RSpec.describe "MSpec" do
  before :all do
    path = RbConfig::CONFIG['bindir']
    exe  = RbConfig::CONFIG['ruby_install_name']
    file = File.expand_path('../../fixtures/should.rb', __FILE__)
    @out = `#{path}/#{exe} #{file}`
  end

  describe "#should" do
    it "records failures" do
      expect(@out).to include <<-EOS
1)
MSpec expectation method #should causes a failure to be recorded FAILED
Expected 1 == 2
to be truthy but was false
EOS
    end

    it "raises exceptions for examples with no expectations" do
      expect(@out).to include <<-EOS
2)
MSpec expectation method #should registers that an expectation has been encountered FAILED
No behavior expectation was found in the example
EOS
    end
  end

  describe "#should_not" do
    it "records failures" do
      expect(@out).to include <<-EOS
3)
MSpec expectation method #should_not causes a failure to be recorded FAILED
Expected 1 == 1
to be falsy but was true
EOS
    end

    it "raises exceptions for examples with no expectations" do
      expect(@out).to include <<-EOS
4)
MSpec expectation method #should_not registers that an expectation has been encountered FAILED
No behavior expectation was found in the example
EOS
    end
  end

  it "prints status information" do
    expect(@out).to include ".FF..FF."
  end

  it "prints out a summary" do
    expect(@out).to include "0 files, 8 examples, 6 expectations, 4 failures, 0 errors"
  end

  it "records expectations" do
    expect(@out).to include "I was called 6 times"
  end
end

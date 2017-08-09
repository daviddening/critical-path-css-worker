require "spec_helper"

RSpec.describe CriticalPathCssWorker do
  it "has a version number" do
    expect(CriticalPathCssWorker::VERSION).not_to be nil
  end

  describe "#critical_css" do
    let!(:url) {"https://test.com"}

    it "calls through to cache worker" do
      expect(CriticalPathCss).to receive(:fetch) {"some css"}
      expect(CriticalPathCssWorker::CacheCriticalCssWorker).to receive(:cache_critical_css).with(url, true)

      expect(CriticalPathCssWorker::critical_css(url)).to eq "some css"
    end
  end
end

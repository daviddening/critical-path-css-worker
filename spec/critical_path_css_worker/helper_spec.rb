require 'spec_helper'

describe CriticalPathCssWorker::Helper do
  include CriticalPathCssWorker::Helper

  describe "#critical_css" do
    let!(:url) {"https://test.com"}

    it "calls through to cache worker" do
      expect(CriticalPathCss).to receive(:fetch) {"some css"}
      expect(CriticalPathCssWorker::CacheCriticalCssWorker).to receive(:cache_critical_css).with(url, true)

      expect(critical_css(url)).to eq "some css"
    end
  end
end

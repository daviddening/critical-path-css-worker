require "spec_helper"

describe CriticalPathCssWorker::CacheState do
  describe '.set_processing' do
    let!(:route) { 'a/early-pregnancy' }

    it 'Sets css processing' do
      expect(CriticalPathCssWorker::CacheState.processing?(route)).to eq false
      expect(CriticalPathCssWorker::CacheState.fresh?(route)).to eq false
      CriticalPathCssWorker::CacheState.processing(route)
      expect(CriticalPathCssWorker::CacheState.processing?(route)).to eq true
      expect(CriticalPathCssWorker::CacheState.fresh?(route)).to eq false
      CriticalPathCssWorker::CacheState.fresh(route)
      expect(CriticalPathCssWorker::CacheState.processing?(route)).to eq false
      expect(CriticalPathCssWorker::CacheState.fresh?(route)).to eq true
    end
  end

  describe '.clear_matched' do
    it 'deletes freshness cache' do
      expect(Rails).to receive_message_chain(:cache, :delete_matched).with("/", {:namespace=>"critical-path-css-processing"})
      CriticalPathCssWorker::CacheState.clear_matched('/')
    end
  end
end


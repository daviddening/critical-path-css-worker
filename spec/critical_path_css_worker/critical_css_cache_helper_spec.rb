require "spec_helper"

describe CriticalPathCssWorker::CriticalCssCacheHelper do
  describe '.set_processing' do
    let!(:route) { 'a/early-pregnancy' }

    it 'Sets css processing' do
      expect(CriticalPathCssWorker::CriticalCssCacheHelper.processing?(route)).to eq false
      expect(CriticalPathCssWorker::CriticalCssCacheHelper.fresh?(route)).to eq false
      CriticalPathCssWorker::CriticalCssCacheHelper.processing(route)
      expect(CriticalPathCssWorker::CriticalCssCacheHelper.processing?(route)).to eq true
      expect(CriticalPathCssWorker::CriticalCssCacheHelper.fresh?(route)).to eq false
      CriticalPathCssWorker::CriticalCssCacheHelper.fresh(route)
      expect(CriticalPathCssWorker::CriticalCssCacheHelper.processing?(route)).to eq false
      expect(CriticalPathCssWorker::CriticalCssCacheHelper.fresh?(route)).to eq true
    end
  end

  describe '.clear_matched' do
    it 'deletes freshness cache' do
      expect(Rails).to receive_message_chain(:cache, :delete_matched).with("/", {:namespace=>"critical-path-css-processing"})
      CriticalPathCssWorker::CriticalCssCacheHelper.clear_matched('/')
    end
  end
end


require "spec_helper"

describe CriticalPathCssWorker::Worker do
  let(:worker) { CriticalPathCssWorker::Worker.new }
  let!(:url) { 'http://thebump.com/a/early-pregnancy' }
  let!(:path) { '/a/early-pregnancy' }

  describe '#perform' do
    it 'calls critical path css with the url path' do
      expect(CriticalPathCss).to receive(:generate).with('/a/early-pregnancy')

      worker.perform('http://thebump.com/a/early-pregnancy')

      expect(CriticalPathCssWorker::CacheState.fresh?(path)).to eq true
    end
  end

  describe '.cache_critical_css' do
    let!(:critical_css_present) { false }

    it 'set url as processing and enqueues' do
      expect(CriticalPathCssWorker::Worker).to receive(:perform_async)

      CriticalPathCssWorker::Worker.cache_critical_css(url, critical_css_present)

      expect(CriticalPathCssWorker::CacheState.processing?(path)).to eq true
    end

    context 'already processing' do
      before do
        CriticalPathCssWorker::CacheState.processing(path)
      end

      it 'does not enqueue a job' do
        expect(CriticalPathCssWorker::Worker).not_to receive(:perform_async)

        CriticalPathCssWorker::Worker.cache_critical_css(url, critical_css_present)

        expect(CriticalPathCssWorker::CacheState.processing?(path)).to eq true
      end
    end

    context 'already has critical css' do
      let!(:critical_css_present) { true }

      it 'does not enqueue a job' do
        CriticalPathCssWorker::CacheState.fresh(path)

        expect(CriticalPathCssWorker::Worker).not_to receive(:perform_async)

        CriticalPathCssWorker::Worker.cache_critical_css(url, critical_css_present)

        expect(CriticalPathCssWorker::CacheState.processing?(path)).to eq false
      end

      context 'critical css is stale' do
        it 'set url as processing and enqueues' do
          expect(CriticalPathCssWorker::Worker).to receive(:perform_async)

          CriticalPathCssWorker::Worker.cache_critical_css(url, critical_css_present)

          expect(CriticalPathCssWorker::CacheState.processing?(path)).to eq true
        end
      end
    end
  end
end

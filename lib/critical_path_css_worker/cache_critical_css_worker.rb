module CriticalPathCssWorker
  class CacheCriticalCssWorker
    include Sidekiq::Worker

    CRITICAL_CSS_CACHE_NAMESPACE = "critical-path-css-processing".freeze

    def perform(url)
      path = URI(url).path
      CriticalPathCss.generate(path)
      CriticalCssCacheHelper.fresh(path)
    end

    def self.cache_critical_css(url, critical_css_present)
      path = URI(url).path

      return if critical_css_present && CriticalCssCacheHelper.fresh?(path)
      return if CriticalCssCacheHelper.processing?(path)

      CriticalCssCacheHelper.processing(path)
      CacheCriticalCssWorker.perform_async(url)
    end
  end
end

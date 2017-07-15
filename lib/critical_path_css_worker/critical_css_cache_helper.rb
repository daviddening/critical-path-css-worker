module CriticalPathCssWorker
  class CriticalCssCacheHelper
    CRITICAL_CSS_CACHE_HELPER_NAMESPACE = "critical-path-css-processing".freeze
    PROCESSING = "processing".freeze
    FRESH = "fresh".freeze

    def self.processing(route)
      set_state(route, PROCESSING)
    end

    def self.fresh(route)
      set_state(route, FRESH, 6.days)
    end

    def self.set_state(route, state, expiry = 1.hour)
      Rails.cache.write(
        route,
        state,
        namespace: CRITICAL_CSS_CACHE_HELPER_NAMESPACE,
        expires_in: expiry
      )
    end

    def self.processing?(route)
      Rails.cache.read(
        route,
        namespace: CRITICAL_CSS_CACHE_HELPER_NAMESPACE
      ) == PROCESSING
    end

    def self.fresh?(route)
      Rails.cache.read(
        route,
        namespace: CRITICAL_CSS_CACHE_HELPER_NAMESPACE
      ) == FRESH
    end

    def self.clear_matched(routes)
      Rails.cache.delete_matched(routes, namespace: CRITICAL_CSS_CACHE_HELPER_NAMESPACE)
    end
  end
end

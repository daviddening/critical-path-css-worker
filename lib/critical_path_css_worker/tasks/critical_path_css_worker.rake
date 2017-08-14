require 'critical-path-css-rails'

namespace :critical_path_css_worker do
  desc 'Clear freshness cache so we pull latest CSS and update critical CSS cache' do
    task set_css_stale: :environment do
      CacheState.clear_matched('*')
    end
  end
end



begin

  require 'metric_fu'

  MetricFu::Configuration.run do |config|
    config.metrics = [:churn, :flog, :flay, :reek, :roodi, :hotspots]
  end

rescue LoadError
end

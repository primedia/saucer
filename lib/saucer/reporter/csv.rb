require 'CSV'

module Saucer
  module Reporter
    class CSV
      include Anima.new(:jobs)

      LINEFEEDS = %r([\r\f\n])

      def config
        Configuration.instance
      end

      def generate
        csv_string = ::CSV.generate do |csv|
          csv << config.headers
          jobs.each do |job|
            csv << row(job)
          end
        end
      end

      def row(job)
        config.keys.map do |k|
          standardize(job.send(k))
        end
      end

      def standardize(field)
        String(field).gsub(LINEFEEDS, ' ') # Linefeeds break csv
      end
    end

    class CSV::Configuration
      include Singleton

      def self.configure(&block)
        instance.instance_eval(&block)
      end


      # :name, :browser, :browser_version, :error, :passed?
      def columns_and_keys
        @columns_and_keys || {}
      end

      def columns_and_keys=(value)
        @columns_and_keys = value
      end

      def headers
        @columns_and_keys.values
      end

      def keys
        @columns_and_keys.keys
      end
    end

  end
end

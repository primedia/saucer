require 'axlsx'

module Saucer
  module Reporter
    class Xlsx
      include Anima.new(:jobs)

      def config
        Configuration.instance
      end

      def generate
        Axlsx::Package.new do |p|

          p.workbook.add_worksheet(:name => "Full Output") do |sheet|
            no_style = sheet.styles.add_style(:bg_color => "FFFFFF")
            green_style = sheet.styles.add_style(:bg_color => "51D654")
            red_style = sheet.styles.add_style(:bg_color => "EB0017")

            sheet.add_row config.headers

            jobs.sort_by { |j| j.name }.each do |job|
              r = row(job)
              pass_style = if r.last[/true/i]
                             green_style
                           else
                             red_style
                           end
              styles = [Array.new(4, no_style), pass_style].flatten
              sheet.add_row r, style: styles

            end
          end

          p.workbook.add_worksheet(:name => "Error Filtered") do |sheet|
            no_style = sheet.styles.add_style(:bg_color => "FFFFFF")
            green_style = sheet.styles.add_style(:bg_color => "51D654")
            red_style = sheet.styles.add_style(:bg_color => "EB0017")

            sheet.add_row config.headers

            jobs.select { |j| j.failed? }.map do |job|
              r = row(job)
              pass_style = if r.last[/true/i]
                             green_style
                           else
                             red_style
                           end
              styles = [Array.new(4, no_style), pass_style].flatten
              sheet.add_row r, style: styles

            end
          end
        end
      end

      def generate!
        p = generate
        p.serialize('simple.xlsx')
      end

      def row(job)
        config.keys.map do |k|
          standardize(job.send(k))
        end
      end

      def standardize(field)
        String(field)
      end
    end

    class Xlsx::Configuration
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

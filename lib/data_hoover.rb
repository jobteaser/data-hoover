require 'data_hoover/version'

require 'digest'
require 'logger'

require 'segment/analytics'

require 'data_hoover/nozzle'
require 'data_hoover/bags/segment_analytics'

module DataHoover
  class << self

    attr_accessor :logger, :traits

    def anonymize(entry)
      return if entry.nil?
      Digest::SHA256.hexdigest(entry.to_s)
    end

    alias anon anonymize

  end

  self.logger = Logger.new(STDOUT)
  self.traits = ->(_) { {} }
end

module DataHoover
  module Bags
    class SegmentAnalytics

      class << self

        def tag(trackee_id:, traits:)
          client.identify(
            user_id: trackee_id,
            traits: traits
          )
        end

        def wrap(trackee_id:, event:, properties:)
          client.track(
            user_id: trackee_id,
            event: event,
            properties: properties
          )
        end

        private

        def client
          Segment::Analytics.new(
            write_key: ENV.fetch('SEGMENT_KEY'),
            on_error: ->(_status, msg) { DataHoover.logger.error(msg) }
          )
        end

      end

    end
  end
end

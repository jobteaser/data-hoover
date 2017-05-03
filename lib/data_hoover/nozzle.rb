module DataHoover
  class Nozzle

    def initialize(trackee:, bag: DataHoover::Bags::SegmentAnalytics)
      @trackee = trackee
      @bag = bag
    end

    def absorb(event, props={})
      @bag.tag(
        trackee_id: DataHoover.anon(@trackee.id),
        traits: traits
      )
      @bag.wrap(
        trackee_id: DataHoover.anon(@trackee.id),
        event: event,
        properties: props
      )
    end

    private

    def traits
      trackee_traits = DataHoover.traits.call(@trackee)
      Hash(trackee_traits).reject { |_key, value| value.nil? }
    end

  end
end

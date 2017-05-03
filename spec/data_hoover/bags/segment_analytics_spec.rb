require 'spec_helper'

RSpec.describe DataHoover::Bags::SegmentAnalytics do
  describe '.tag' do
    it 'works' do
      expect { described_class.tag(trackee_id: 1, traits: {}) }.
        not_to raise_error
    end
  end

  describe '.wrap' do
    it 'works' do
      expect do
        described_class.wrap(trackee_id: 1, event: 'foo_event', properties: {})
      end.not_to raise_error
    end
  end
end

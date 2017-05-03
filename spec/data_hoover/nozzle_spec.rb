require 'spec_helper'

RSpec.describe DataHoover::Nozzle, type: :type do
  let(:trackee) { double(id: 1) }

  before { DataHoover.traits = ->(_) { {} } }

  describe '#absorb' do
    it 'works with the default provider' do
      expect { described_class.new(trackee: trackee).absorb('foo_event', test: 'test') }.
        not_to raise_error
    end

    it 'delegates the heavy lifting to the provider' do
      expect(GoodProvider).to receive(:tag).once
      expect(GoodProvider).to receive(:wrap).once

      described_class.
        new(trackee: trackee, bag: GoodProvider).
        absorb('foo_event', test: 'test')

      expect do
        described_class.
          new(trackee: trackee, bag: UnwrappableBag).
          absorb(:foo_event, test: 'test')
      end.to raise_error(NoMethodError, a_string_starting_with('undefined method `wrap'))

      expect do
        described_class.
          new(trackee: trackee, bag: BagWithoutTag).
          absorb(:foo_event, test: 'test')
      end.to raise_error(NoMethodError, a_string_starting_with('undefined method `tag'))
    end

    class GoodProvider

      def self.tag(*_); end

      def self.wrap(*_); end

    end

    class UnwrappableBag

      def self.tag(*_); end

    end

    class BagWithoutTag

      def self.wrap(*_); end

    end
  end
end

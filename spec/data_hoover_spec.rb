require "spec_helper"

RSpec.describe DataHoover do
  it 'has a version number' do
    expect(DataHoover::VERSION).not_to be nil
  end

  describe '.anonymize' do
    it 'handles nil' do
      expect(described_class.anonymize(nil)).to be_nil
    end

    it 'returns the SHA256 of the string representation' do
      expect(described_class.anonymize('foo')).
        to eq('2c26b46b68ffc68ff99b453c1d30413413422d706483bfa0f98a5e886266e7ae')

      expect(described_class.anonymize(42)).
        to eq('73475cb40a568e8da8a045ced110137e159f890ac4da883b6b17dc651b3a8049')
    end
  end

  describe 'logger' do
    it 'is possible to inject a logger' do
      expect(described_class).to respond_to(:logger=)
    end
  end

  describe 'traits' do
    it 'is possible to inject traits' do
      expect(described_class).to respond_to(:traits=)
    end
  end
end

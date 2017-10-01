require 'rspec'
require 'caesar_cipher'

describe CaesarCipher do
  describe 'setting the shift factor' do
    it 'generates a shift factor' do
      expect(described_class.new.shift).to be_a Fixnum
    end

    it 'allows setting the shift manually' do
      shift = 13
      cipher = described_class.new(shift)

      expect(cipher.shift).to eq shift
    end

    it 'raises an error with the shift is not an integer' do
      expect {
        described_class.new(3.5)
      }.to raise_error ArgumentError, 'Not a valid shift.'
    end
  end

  describe 'encoding and decoding' do
    let(:shift) { 4 }
    let(:cipher) { described_class.new(shift) }

    it 'can encode' do
      expect(cipher.encode('abc')).to eq 'efg'
    end

    it 'can decode' do
      expect(cipher.decode('efg')).to eq 'abc'
    end

    it 'is reversible' do
      plaintext = 'asdfsdfkji'
      expect(cipher.decode(cipher.encode(plaintext))).to eq plaintext
    end

    it 'can wrap on encode' do
      expect(cipher.encode('xyz')).to eq 'bcd'
    end

    it 'can wrap on decode' do
      expect(cipher.decode('bcd')).to eq 'xyz'
    end

    it 'can handle negative shifts' do
      expect(described_class.new(-3).encode('def')).to eq 'abc'
    end
  end
end
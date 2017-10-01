require 'rspec'
require 'deranged_alphabet_cipher'

describe DerangedAlphabetCipher do
  describe 'setting the alphabet' do
    context 'a keyword is provided' do
      let(:keyword) { 'zebras' }
      let(:cipher)  { described_class.new(keyword) }

      it 'puts the keyword at the front' do
        expect(cipher.deranged_alphabet).to match(/^zebras/)
      end

      it 'puts the remaining alphabet in the usual order at the end' do
        expect(cipher.deranged_alphabet).to match(/cdfghijklmnopqtuvwxy$/)
      end

      it 'includes all the letters'do
        expect(cipher.deranged_alphabet)
          .to eq 'zebrascdfghijklmnopqtuvwxy'
      end

      it 'deletes duplicates from the keyword' do
        expect(described_class.new('elollo').keyword).to eq 'elo'
      end
    end

    context 'no keyword is provided' do
      let(:cipher) { described_class.new }

      it 'randomly generates one' do
        expect(cipher.keyword).to match(/^[a-z]+$/)
      end
    end

    it 'raises an error with the keyword contains non-letter characters' do
      expect {
        described_class.new('what?')
      }.to raise_error ArgumentError, 'Not a valid keyword.'
    end
  end

  describe 'encoding and decoding' do
    let(:keyword) { 'who' }
    let(:cipher)  { described_class.new(keyword) }

    it 'can encode' do
      expect(cipher.encode('abc')).to eq 'who'
    end

    it 'can decode' do
      expect(cipher.decode('who')).to eq 'abc'
    end

    it 'is reversible' do
      plaintext = 'asdfsdfkji'
      expect(cipher.decode(cipher.encode(plaintext))).to eq plaintext
    end

    it 'can handle repeated characters' do
      expect(cipher.encode('imil')).to eq 'fkfj'
    end
  end
end
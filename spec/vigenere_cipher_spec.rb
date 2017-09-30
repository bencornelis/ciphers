require 'rspec'
require 'vigenere_cipher'

describe Cipher do
  describe 'setting the key' do
    it 'has generates a random key made up of 100 letters' do
      key = Cipher.new.key

      expect(key).to match(/^[a-z]+$/)
      expect(key.length).to eq 100
    end

    it 'allows setting a key manually' do
      key = 'abc'
      cipher = Cipher.new(key)

      expect(cipher.key).to eq key
    end

    it 'raises an error with an all caps key' do
      expect { Cipher.new('ABCDE') }.to raise_error ArgumentError, 'Bad key'
    end

    it 'raises an error with a numeric key' do
      expect { Cipher.new('12345') }.to raise_error ArgumentError, 'Bad key'
    end

    it 'raises an error with an empty key' do
      expect { Cipher.new('') }.to raise_error ArgumentError, 'Bad key'
    end
  end

  describe 'encoding and decoding' do
    let(:key) { 'abcdefghij'}
    let(:cipher) { Cipher.new(key) }

    it 'can encode' do
      expect(cipher.encode('aaaaaaaaaa')).to eq 'abcdefghij'
    end

    it 'can decode' do
      expect(cipher.decode('abcdefghij')).to eq 'aaaaaaaaaa'
    end

    it 'is reversible' do
      plaintext = 'asdagsgjalsdjgkls';
      expect(cipher.decode(cipher.encode(plaintext))).to eq plaintext
    end

    it 'can wrap on encode' do
      expect(cipher.encode('zzzzzzzzzz')).to eq 'zabcdefghi'
    end

    it 'can wrap on decode' do
      expect(cipher.decode('zabcdefghi')).to eq 'zzzzzzzzzz'
    end

    it 'can handle text with spaces' do
      plaintext = "this cipher is great";
      expect(cipher.decode(cipher.encode(plaintext))).to eq plaintext
    end

    it 'can handle messages longer than the key' do
      expect(Cipher.new('abc').encode('iamapandabear'))
        .to eq 'iboaqcnecbfcr'
    end
  end
end
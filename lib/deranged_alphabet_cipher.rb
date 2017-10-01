class DerangedAlphabetCipher
  ALPHABET = ('a'..'z').to_a

  attr_reader :keyword, :original_alphabet, :deranged_alphabet

  def initialize(keyword=generate_keyword)
    validate(keyword)

    @keyword = remove_duplicates(keyword)
    @original_alphabet = ALPHABET.join
    @deranged_alphabet = generate_alphabet(keyword)
  end

  def encode(plaintext)
    plaintext.tr(original_alphabet, deranged_alphabet)
  end

  def decode(ciphertext)
    ciphertext.tr(deranged_alphabet, original_alphabet)
  end

  private

  def validate(keyword)
    raise ArgumentError, 'Not a valid keyword.' unless all_letters?(keyword)
  end

  def all_letters?(keyword)
    keyword.chars.all? { |char| ALPHABET.include?(char) }
  end

  def remove_duplicates(keyword)
    keyword.chars.uniq.join
  end

  def generate_keyword
    ALPHABET.sample(rand(26)).shuffle.join
  end

  def generate_alphabet(keyword)
    keyword + (ALPHABET - keyword.chars).join
  end
end
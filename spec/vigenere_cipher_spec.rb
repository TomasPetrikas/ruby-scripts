require './mini_projects/vigenere_cipher'

describe Vigenere do
  describe '#vigenere_cipher' do
    it 'returns an empty string with an empty input message' do
      expect(Vigenere.vigenere_cipher('', 'egg')).to eql('')
    end
    it 'returns an unchanged message with an empty keyword' do
      expect(Vigenere.vigenere_cipher('Hello', '')).to eql('Hello')
    end
    it 'returns an encrypted one-word message' do
      expect(Vigenere.vigenere_cipher('Hello', 'egg')).to eql('Lkrpu')
    end
    it 'returns an encrypted multi-word message' do
      expect(Vigenere.vigenere_cipher('Attack at dawn', 'lemon')).to eql('Lxfopv ef rnhr')
    end
    it 'the case of the keyword does not matter' do
      msg_in = 'thequickbrownfoxjumpsoverthelazydog'
      msg_out = 'epsdfqqxmzcjynckucacdwjrcbvrwinlowu'
      expect(Vigenere.vigenere_cipher(msg_in, 'lIoN')).to eql(msg_out)
    end
    it 'does not alter non-alphabetic symbols' do
      expect(Vigenere.vigenere_cipher('./,_0123456789!?', 'egg')).to eql('./,_0123456789!?')
    end
  end
end

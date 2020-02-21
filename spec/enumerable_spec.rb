require './methods'

RSpec.describe Enumerable do
  let(:a) { [1, 2, 3, 4] }
  let(:b) { %w[ant bear cat] }
  let(:c) { [nil, true, 99] }
  let(:d) { [] }
  let(:e) { [1, 2, 4, 2] }
  let(:f) { (1..4) }
  describe '#my_each' do
    it 'returns its array' do
      expect(a.my_each { |x| x }).to eq(a)
    end

    it 'returns its array' do
      expect(a.my_each).not_to eq(a)
    end

    it 'returns an enum when no block given' do
      expect(a.my_each).to eq(:Enumerator)
    end
  end

  describe '#my_each_with_index' do
    it 'returns its array' do
      expect(a.my_each_with_index { |_x, y| y }).to eq(a)
    end

    it 'does not returns its array' do
      expect(a.my_each_with_index).not_to eq(a)
    end

    it 'returns an enum when no block given' do
      expect(a.my_each_with_index).to eq(:Enumerator)
    end
  end

  describe '#my_select' do
    it 'returns an array' do
      expect(a.my_select(&:even?)).to eq([2, 4])
    end

    it 'does not return an array' do
      expect(a.my_select(&:even?)).not_to eq('2, 4')
    end

    it 'returns an enum when no block given' do
      expect(a.my_select).to eq(:Enumerator)
    end
  end

  describe '#my_all?' do
    it 'returns true when all is true' do
      expect(b.my_all? { |word| word.length >= 3 }).to eq(true)
    end

    it 'returns false when one is false' do
      expect(b.my_all? { |word| word.length >= 4 }).to eq(false)
    end

    it 'returns false when one is false' do
      expect(c.my_all?).to eq(false)
    end

    it 'returns true when empty' do
      expect(d.my_all?).to eq(true)
    end
  end

  describe '#my_any?' do
    it 'returns true if one is true' do
      expect(b.my_any? { |word| word.length >= 3 }).to eq(true)
    end

    it 'returns true if one is true' do
      expect(b.my_any? { |word| word.length >= 4 }).to eq(true)
    end

    it 'returns true if one is true' do
      expect(c.my_any?).to eq(true)
    end

    it 'returns false when empty' do
      expect(d.my_any?).to eq(false)
    end
  end

  describe '#my_none' do
    it 'returns true if all element are false' do
      expect(b.my_none? { |word| word.length == 5 }).to eq(true)
    end

    it 'returns false if one element is true for condition' do
      expect(b.my_none? { |word| word.length >= 4 }).to eq(false)
    end

    it 'returns true when empty' do
      expect(d.my_none?).to eq(true)
    end

    it 'returns true when all element is false' do
      expect([nil].my_none?).to eq(true)
    end

    it 'returns true when all element is false' do
      expect([nil, false].my_none?).to eq(true)
    end

    it 'returns false when one element is true' do
      expect([nil, false, true].my_none?).to eq(false)
    end
  end

  describe '#my_count' do
    it 'returns the number of items in array' do
      expect(e.my_count).to eq(4)
    end

    it 'returns the number of given argument' do
      expect(e.my_count(2)).to eq(2)
    end

    it 'returns the number of item for which condition in block is true' do
      expect(e.my_count(&:even?)).to eq(3)
    end

    it 'returns the number of given argument' do
      expect(e.my_count(2)).not_to eq(4)
    end
  end

  describe '#my_map' do
    it 'returns an enum when no block given' do
      expect(f.my_map).to eq(:Enumerator)
    end

    it 'returns a new array' do
      expect(f.my_map { |i| i * i }).to eq([1, 4, 9, 16])
    end

    it 'returns a new array' do
      expect(f.my_map { |i| i * i }).not_to eq('[1, 4, 9, 16]')
    end
  end

  describe '#my_inject' do
    it 'returns sum of all element when symbol given' do
      expect((5..10).my_inject(:+)).to eq(45)
    end

    it 'returns sum of all element when symbol given' do
      expect((5..10).my_inject { |sum, n| sum + n }).to eq(45)
    end

    it 'returns product of all element when argument and symbol given' do
      expect((5..10).my_inject(1, :*)).to eq(151_200)
    end

    it 'returns longest word' do
      expect(%w[cat sheep bear].my_inject do |memo, word|
        memo.length > word.length ? memo : word
      end).to eq('sheep')
    end
  end
end

RSpec.describe '#multiply_els' do
  it 'return accumulation of arr' do
    a = [1, 2, 3]
    expect(multiply_els(a)).to eq(6)
  end
end

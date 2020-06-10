require_relative '../enumerables.rb'

describe Enumerable do
  describe '#my_each' do
    let(:arr_num) { [1, 2, 3, 4] }
    let(:arr_str) { %w[a b c] }

    it 'Print all the numbers' do
      expect { arr_num.my_each { |n| print n } }.to output('1234').to_stdout
    end
    it 'Print all the characters' do
      expect { arr_str.my_each { |c| print c, ' -- ' } }.to output('a -- b -- c -- ').to_stdout
    end
    it 'Return enumerator when no block is given' do
      expect(arr_num.my_each).to be_an Enumerator
    end
  end

  describe '#my_each_with_index' do
    let(:arr_num) { [1, 2, 3, 4] }
    let(:arr_str) { %w[a b c] }
    let(:vowels) { %w[a e i o u] }
    it 'Print all the numbers with index bigger than 2' do
      expect { arr_num.my_each_with_index { |n, index| print [n, index] if n > 2 } }.to output('[3, 2][4, 3]').to_stdout
    end
    it 'print works with its index that have an a' do
      expect { arr_str.my_each_with_index { |n, index| print [n, index] if n == 'a' } }.to output('["a", 0]').to_stdout
    end
    it 'Return enumerator when no block is given' do
      expect(arr_num.my_each).to be_an Enumerator
    end
  end

  describe '#my_select' do
    let(:arr_num) { [1, 2, 3, 4, 5] }
    let(:arr_str) { %w[a b c] }
    let(:vowels) { %w[a e i o u] }
    it 'Select the even numbers' do
      expect(arr_num.my_select { |num| (num % 2).zero? }).to include(2, 4)
    end
    it 'Select the multiples of three' do
      expect(arr_str.my_select { |str| vowels.include? str }).to include('a')
    end
    it 'Return enumerator when no block is given' do
      expect(arr_num.my_select).to be_an Enumerator
    end
  end

  describe '#my_all?' do
    let(:false_num) { [29, 32, 54, 30, 17] }
    let(:true_num) { [2, 4, 6, 12, 34] }
    let(:true_str) { %w[kkkr rnunrr ppolkf mmnd] }
    let(:vowels) { %w[a e i o u] }
    it 'every number is bigger than 20?' do
      expect(false_num.my_all? { |n| n > 20 }).to be(false)
    end
    it 'every number is even?' do
      expect(false_num.my_all? { |n| (n % 2).zero? }).to be(false)
    end
    it 'Select strings bigger than 3 letters' do
      expect(true_str.my_all? { |str| str if str.length > 3 }).to be(true)
    end
  end

  describe '#my_inject' do
    let(:arr_num) { [2, 4, 6] }
    it 'returns the result of operation performed on each element in
    the array with given argument as parameter.' do
      expect(arr_num.my_inject(10) { |sym, item| sym + item }).to eql(22)
    end
  end

  describe '#my_map' do
    let(:arr_num) { [1, 2, 3, 4, 5] }
    let(:arr_str) { %w[dog door road blade] }
    it 'returns the modified array performed the operation in the block on each element' do
      expect(arr_num.my_map { |element| element * 2 }).to eql([2, 4, 6, 8, 10])
    end
    it 'returns the modified array performed the operation in the block on each element' do
      expect(arr_str.my_map { |word| word + '?' }).to eql(['dog?', 'door?', 'road?', 'blade?'])
    end
  end

  describe '#my_none?' do
    let(:arr_num) { [1, 2, 3, 4, 5] }
    let(:arr_nums) { [2, 4, 6] }
    it 'returns true if the condition does not hold for any elements' do
      expect(arr_nums.my_none?(String)).to eql(true)
    end
    it 'returns false if condition holds for any elements' do
      expect(arr_num.my_none?(&:even?)).to eql(false)
    end
  end

  describe '#my_any?' do
    let(:arr_num) { [1, 2, 3, 4, 5] }
    let(:arr_str) { %w[dog door road blade] }
    let(:arr_arg) { [2, nil, false] }
    it 'returns true if the condition holds for any elements' do
      expect(arr_num.my_any?(&:even?)).to eql(true)
    end
    it 'returns true if condition does not hold for any elements' do
      expect(arr_str.my_any?(/b/)).to eql(true)
    end
    it 'returns false if condition holds for any elements' do
      expect(arr_arg.my_any?(1)).to eql(false)
    end
  end

  describe '#my_count' do
    let(:arr_num) { [1, 2, 4, 2, 5, 7, 9, 3, 5, 6, 1] }
    it 'Return the number of elements' do
      expect(arr_num.my_count).to eql(11)
    end
    it 'Returns how many 2 are there' do
      expect(arr_num.my_count(2)).to eql(2)
    end
    it 'Returns how many numbers are divisible for 3' do
      expect(arr_num.my_count { |x| (x % 3).zero? }).to eql(3)
    end
  end
end

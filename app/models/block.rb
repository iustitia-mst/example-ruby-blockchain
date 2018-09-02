require 'digest/sha2'

class Block < ApplicationRecord

  def calculate_hash
    self.hash_value = calculate_hash_inner
  end

  def is_valid_hash?
    calculate_hash_inner == self.hash_value
  end

  def == (other)
    hash_data == other.hash
  end

  private

    def calculate_hash_inner
      Digest::SHA256.hexdigest({
        index: self.index,
        previous_hash: self.previous_hash,
        generated_at: self.generated_at,
        data_value: self.data_value,
        nonce: self.nonce
      }.to_json)
    end

    class << self
      def genesis_block
        Block.new(
          index: 0,
          previous_hash: '0',
          generated_at: 10000,
          data_value: "genesis block!!",
          nonce: 0
        )
      end
    end

end

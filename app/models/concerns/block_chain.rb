require 'digest/sha2'
require 'json'
require_relative '../block'

class BlockChain

  def initialize
    if Block.count == 0
      gb = ProofOfWork.do_proof_of_work BlockChain.get_genesis_block
      gb.save 
    end
  end

  def get_latest_block
    Block.order(:index).reverse_order.limit(1).first
  end

  def generate_next_block data
    previous_block = get_latest_block
    next_index = previous_block.index + 1
    next_timestamp = Time.now.to_i
    nb = Block.new(
      index: next_index,
      previous_hash: previous_block.hash_value,
      generated_at: next_timestamp,
      data_value: data,
      nonce: 0,
    )
    ProofOfWork.do_proof_of_work nb
  end

  def is_valid_new_block? new_block, previous_block
    if previous_block.index + 1 != new_block.index
      p "invalid index pre:#{previous_block.index}, new:#{new_block.index}, #{size}"
      return false
    elsif previous_block.hash_value != new_block.previous_hash
      puts "invalid hash: previous hash"
      return false
    end
    unless new_block.is_valid_hash?
      puts "invalid hash: hash"
      return false
    end
    true
  end

  def add_block new_block
    if is_valid_new_block?(new_block, get_latest_block)
      new_block.save
    end
  end

  def size
    Block.count
  end

  class << self

    # def is_valid_chain? block_chain_to_validate
    #   return false if block_chain_to_validate.blocks[0] != BlockChain.get_genesis_block()
    #   tmp_blocks = [block_chain_to_validate.blocks[0]]
    #   block_chain_to_validate.blocks[1..-1].each.with_index(1) do |block, i|
    #     if block_chain_to_validate.is_valid_new_block?(block, tmp_blocks[i - 1])
    #       tmp_blocks << block
    #     else
    #       return false
    #     end
    #   end
    # end

    def get_genesis_block
      b = Block.genesis_block
      b.calculate_hash
      b
    end
  end

end

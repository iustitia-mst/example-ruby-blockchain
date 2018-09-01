class ProofOfWork 
  def self.do_proof_of_work (new_block)
    difficulty = '0' * (new_block.index + 1)
    loop do
      new_block.calculate_hash
      break if new_block.hash_value.starts_with? difficulty 
      new_block.nonce += 1
    end
    p new_block.calculate_hash
    new_block
  end
end

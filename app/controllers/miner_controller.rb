class MinerController < ActionController::API

  def initialize
    @my_blockchain = BlockChain.new
  end

  def update_blockchain
    do_update_blockchain = params[:blockchain_size].to_i > @my_blockchain.size
    if do_update_blockchain 
      # TODO TBI. Get longer blockchain.
    end
    render json: "{update?: #{do_update_blockchain}}"
  end

  def add_new_block
    nb = @my_blockchain.generate_next_block params[:data_value]
    @my_blockchain.add_block nb
    render json: nb
  end

end

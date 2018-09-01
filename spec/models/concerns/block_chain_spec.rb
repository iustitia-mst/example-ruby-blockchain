require 'rails_helper'

# ブロックチェーンはブロックの連結リスト
# ブロックはいくつかのデータと自身のハッシュを持つ
# 前のブロックのハッシュもそのデータに含まれる => データ改竄すると後のブロックも全部影響でるので長くなるほど変更難度↑
# ノードは新しいブロックを自由に追加できる
# 検証結果が正しく、長いブロックチェーンが信頼される
# 更新を受け取った時、手元のブロックチェーンとそれを比較し、より長いものをブロックチェーンとして受け入れる

RSpec.describe BlockChain do
  let(:b) {BlockChain.new}

  describe 'Initialize blockchain' do
    it 'Succeeded' do
      expect(b).not_to be nil
    end
    it 'Latest_block is genesis_block' do
      expect(b.get_latest_block.generated_at).to eq 10000
    end
  end

  describe 'Generate nextblock' do
    let(:nb) {b.generate_next_block 'next block.'}
    it 'Next block has previous hash_value ' do
      expect(nb.previous_hash).to eq b.get_latest_block.hash_value
      expect(b.size).to be 1
    end
    it 'Next block has previous hash_value ' do
      expect(nb.previous_hash).to eq b.get_latest_block.hash_value
      expect(b.size).to be 1
    end
    it 'Next hash_value is not equals previous hash_value ' do
      expect(nb.hash_value).not_to eq b.get_latest_block.hash_value
      expect(b.size).to be 1
    end
    it 'is valid.' do
      expect(b.is_valid_new_block? nb, b.get_latest_block).to be true
      expect(b.size).to be 1
    end
    it 'and Add new block.' do
      b.add_block nb
      expect(b.size).to be 2
      expect(b.get_latest_block.generated_at).to be nb.generated_at
    end
  end

end

class RenameTokenToTokenDigest < ActiveRecord::Migration[6.1]
  def change
    rename_column(:tokens, :token, :token_digest)
  end
end

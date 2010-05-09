class ChangeImageColumnToBinary < ActiveRecord::Migration
  def self.up
    change_column :pages, :image, :binary, :limit => 1.megabyte
    Page.all.each(&:perform)
  end

  def self.down
    change_column :pages, :image, :string
  end
end

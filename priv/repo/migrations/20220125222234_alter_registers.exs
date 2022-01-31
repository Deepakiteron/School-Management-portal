defmodule Schoolmanagementsystem.Repo.Migrations.AlterRegisters do
  use Ecto.Migration

  def change do
    alter table(:registers) do
      add :role, :string
      modify :address, :text
      remove :type
    end
  end
end

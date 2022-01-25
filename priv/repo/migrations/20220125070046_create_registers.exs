defmodule Schoolmanagementsystem.Repo.Migrations.CreateRegisters do
  use Ecto.Migration

  def change do
    create table(:registers) do
      add :first_name, :string
      add :last_name, :string
      add :age, :integer
      add :gender, :string
      add :phone_number, :string
      add :email, :string
      add :password, :string
      add :address, :string
      add :type, :string

      timestamps()
    end
  end
end

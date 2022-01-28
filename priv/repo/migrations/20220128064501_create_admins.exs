defmodule Schoolmanagementsystem.Repo.Migrations.CreateAdmins do
  use Ecto.Migration

  def change do
    create table(:admins) do
      add :name, :string
      add :age, :integer
      add :email, :string
      add :password, :string
      add :role, :string

      timestamps()
    end
  end
end

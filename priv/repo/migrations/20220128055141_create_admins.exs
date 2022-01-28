defmodule SchoolPortal.Repo.Migrations.CreateAdmins do
  use Ecto.Migration

  def change do
    create table(:admins) do
      add :name, :string
      add :age, :integer
      add :email, :string
      add :password, :string

      timestamps()
    end

    create unique_index(:admins, [:email])

  end
end

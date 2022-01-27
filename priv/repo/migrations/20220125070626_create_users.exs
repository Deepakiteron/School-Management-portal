defmodule SchoolPortal.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :firstname, :string
      add :lastname, :string
      add :email, :string
      add :password, :string
      add :age, :integer
      add :gender, :string
      add :address, :text
      add :phone_number, :string
      add :category_type, :string

      timestamps()
    end
    create unique_index(:users, [:email])
  end
end

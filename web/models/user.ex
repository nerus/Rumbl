defmodule Rumbl.User do
  use Rumbl.Web, :model
  schema "users" do
  	field :name, :string
  	field :username, :string
  	field :password, :string, virtual: true
  	field :password_hash, :string
  	field :birthday, Ecto.Date
  	timestamps
  end

  def changeset(model, params \\ :empty) do
  	model
  	|> cast(params, ~w(name username), [])
  	|> validate_length(:username, min: 8, max: 100)
    |> unique_constraint(:username)
  end
  def registration_changeset(model, params) do
    model
    |> changeset(params)
    |> cast(params, ~w(password), [])
    |> validate_length(:password, min: 8, max: 100)
    |> put_pas_hash()
  end
  def put_pas_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}} ->
        put_change(changeset, :password_hash, Comeonin.Bcrypt.hashpwsalt(pass)) 
      _ -> 
        changeset 
    end
  end
end
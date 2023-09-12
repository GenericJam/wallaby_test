defmodule WallabyTest.DummyTest do
  use ExUnit.Case, async: true
  use Wallaby.Feature

  feature "users can go to home page", %{session: session} do
    session
    |> IO.inspect()
    |> visit("/")
  end
end
